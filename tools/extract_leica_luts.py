#!/usr/bin/env python3
"""Inspect and extract Xiaomi's leica_filter_param.bin.

The file stores six 216-byte scene trigger records followed by a pool of
17x17x17 BGR LUTs.  This tool deliberately validates every offset and trigger
index before producing assets so a malformed firmware blob cannot silently
turn into an incorrect final-JPEG colour transform.
"""

from __future__ import annotations

import argparse
import hashlib
import json
import struct
from pathlib import Path


def u16(data: bytes, offset: int) -> int:
    return struct.unpack_from("<H", data, offset)[0]


def text_field(data: bytes, offset: int, size: int) -> str:
    return data[offset : offset + size].split(b"\0", 1)[0].decode(
        "ascii", errors="strict"
    ).strip()


def parse_scene(data: bytes, offset: int, size: int) -> dict:
    if size < 66:
        raise ValueError(f"scene record at {offset} is too small: {size}")
    name = text_field(data, offset, 64)
    cursor = offset + 64
    end = offset + size
    lux_count = u16(data, cursor)
    cursor += 2
    groups = []
    for _ in range(lux_count):
        if cursor + 6 > end:
            raise ValueError(f"truncated lux group in {name}")
        lux_min, lux_max, cct_count = struct.unpack_from("<HHH", data, cursor)
        cursor += 6
        cct_groups = []
        for _ in range(cct_count):
            if cursor + 6 > end:
                raise ValueError(f"truncated CCT group in {name}")
            cct_min, cct_max, lut_index = struct.unpack_from(
                "<HHH", data, cursor
            )
            cursor += 6
            cct_groups.append(
                {"min": cct_min, "max": cct_max, "lut": lut_index}
            )
        groups.append(
            {"min": lux_min, "max": lux_max, "cct": cct_groups}
        )
    if cursor != end:
        raise ValueError(
            f"scene {name} consumed {cursor - offset} bytes, expected {size}"
        )
    return {"name": name, "lux": groups}


def parse_shading_record(data: bytes, offset: int) -> tuple[dict, int]:
    zoom = struct.unpack_from("<f", data, offset)[0]
    cursor = offset + 4
    lux_count = u16(data, cursor)
    cursor += 2
    if not 0.1 <= zoom <= 100.0 or not 1 <= lux_count <= 32:
        raise ValueError(f"invalid shading record at {offset}: {zoom=}, {lux_count=}")
    groups = []
    for _ in range(lux_count):
        lux_min, lux_max, cct_count = struct.unpack_from("<HHH", data, cursor)
        cursor += 6
        if not 1 <= cct_count <= 32:
            raise ValueError(f"invalid shading CCT count at {cursor - 2}")
        cct_groups = []
        for _ in range(cct_count):
            cct_min, cct_max, shading_index = struct.unpack_from(
                "<HHH", data, cursor
            )
            cursor += 6
            cct_groups.append(
                {"min": cct_min, "max": cct_max, "shading": shading_index}
            )
        groups.append({"min": lux_min, "max": lux_max, "cct": cct_groups})
    return {"zoom": zoom, "lux": groups}, cursor


def identity_error(lut: bytes, dimension: int) -> tuple[int, int]:
    total = 0
    maximum = 0
    cursor = 0
    for b in range(dimension):
        bv = round(b * 255 / (dimension - 1))
        for g in range(dimension):
            gv = round(g * 255 / (dimension - 1))
            for r in range(dimension):
                rv = round(r * 255 / (dimension - 1))
                # The cube is indexed B/G/R, while each entry stores RGB.
                expected = (rv, gv, bv)
                for channel in range(3):
                    error = abs(lut[cursor + channel] - expected[channel])
                    total += error
                    maximum = max(maximum, error)
                cursor += 3
    return total, maximum


def parse(path: Path) -> tuple[dict, bytes, list[bytes]]:
    data = path.read_bytes()
    scene_count = u16(data, 0)
    scene_sizes = [u16(data, 2 + index * 2) for index in range(scene_count)]
    cursor = 2 + scene_count * 2
    max_input, lut_offset, dimension, metadata_count = struct.unpack_from(
        "<HHHH", data, cursor
    )
    cursor += 8
    metadata_sizes = [u16(data, cursor + index * 2) for index in range(metadata_count)]
    cursor += metadata_count * 2
    metadata = []
    for size in metadata_sizes:
        metadata.append(text_field(data, cursor, size))
        cursor += size
    if cursor > 1024:
        raise ValueError(f"metadata overlaps scene table: end={cursor}")

    scenes = []
    scene_cursor = 1024
    for size in scene_sizes:
        scenes.append(parse_scene(data, scene_cursor, size))
        scene_cursor += size
    if scene_cursor > lut_offset:
        raise ValueError(f"scene table overlaps LUT pool: end={scene_cursor}")

    shading_triggers = []
    shading_cursor = scene_cursor
    while shading_cursor + 6 <= lut_offset and any(data[shading_cursor:shading_cursor + 6]):
        record, shading_cursor = parse_shading_record(data, shading_cursor)
        shading_triggers.append(record)

    used_indices = sorted(
        {
            entry["lut"]
            for scene in scenes
            for lux in scene["lux"]
            for entry in lux["cct"]
        }
    )
    if not used_indices or used_indices != list(range(used_indices[-1] + 1)):
        raise ValueError(f"non-contiguous LUT indices: {used_indices}")
    lut_size = dimension**3 * 3
    lut_count = used_indices[-1] + 1
    pool_end = lut_offset + lut_count * lut_size
    if pool_end > len(data):
        raise ValueError(
            f"LUT pool needs {pool_end} bytes but file only has {len(data)}"
        )
    luts = [
        data[lut_offset + index * lut_size : lut_offset + (index + 1) * lut_size]
        for index in range(lut_count)
    ]

    shading_indices = sorted(
        {
            entry["shading"]
            for zoom in shading_triggers
            for lux in zoom["lux"]
            for entry in lux["cct"]
        }
    )
    if not shading_indices or shading_indices != list(range(shading_indices[-1] + 1)):
        raise ValueError(f"non-contiguous shading indices: {shading_indices}")
    shading_offset = pool_end
    shading_count = shading_indices[-1] + 1
    shading_end = shading_offset + shading_count * 8 * 4
    if shading_end != len(data):
        raise ValueError(
            f"shading pool ends at {shading_end}, file ends at {len(data)}"
        )
    shading_params = [
        list(struct.unpack_from("<8f", data, shading_offset + index * 32))
        for index in range(shading_count)
    ]

    unique_luts: list[bytes] = []
    unique_first_indices: list[int] = []
    index_to_unique: list[int] = []
    digest_to_unique: dict[str, int] = {}
    for index, lut in enumerate(luts):
        digest = hashlib.sha256(lut).hexdigest()
        unique = digest_to_unique.get(digest)
        if unique is None:
            unique = len(unique_luts)
            digest_to_unique[digest] = unique
            unique_luts.append(lut)
            unique_first_indices.append(index)
        index_to_unique.append(unique)

    manifest = {
        "source": str(path),
        "file_size": len(data),
        "scene_count": scene_count,
        "scene_sizes": scene_sizes,
        "max_input": max_input,
        "lut_pool_offset": lut_offset,
        "lut_dimension": dimension,
        "lut_size": lut_size,
        "lut_count": lut_count,
        "pool_end": pool_end,
        "shading_trigger_offset": scene_cursor,
        "shading_trigger_end": shading_cursor,
        "shading_count": shading_count,
        "shading_offset": shading_offset,
        "shading_end": shading_end,
        "metadata": metadata,
        "scenes": scenes,
        "shading_triggers": shading_triggers,
        "shading_params": shading_params,
        "unique_first_indices": unique_first_indices,
        "index_to_unique": index_to_unique,
        "unique_identity_error": [
            {
                "first_index": unique_first_indices[index],
                "sum": identity_error(lut, dimension)[0],
                "max": identity_error(lut, dimension)[1],
            }
            for index, lut in enumerate(unique_luts)
        ],
    }
    return manifest, data, unique_luts


def main() -> None:
    parser = argparse.ArgumentParser()
    parser.add_argument("input", type=Path)
    parser.add_argument("--output", type=Path)
    args = parser.parse_args()

    manifest, _, unique_luts = parse(args.input)
    print(json.dumps(manifest, ensure_ascii=False, indent=2))
    if args.output:
        args.output.mkdir(parents=True, exist_ok=True)
        (args.output / "manifest.json").write_text(
            json.dumps(manifest, ensure_ascii=False, indent=2) + "\n",
            encoding="utf-8",
        )
        for index, lut in enumerate(unique_luts):
            first = manifest["unique_first_indices"][index]
            (args.output / f"leica_{first:03d}.cube17").write_bytes(lut)


if __name__ == "__main__":
    main()
