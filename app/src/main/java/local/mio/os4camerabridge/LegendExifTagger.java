package local.mio.os4camerabridge;

import java.io.ByteArrayOutputStream;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Comparator;

/**
 * Lossless EXIF APP1 editor for Xiaomi's private Leica Legendary tag.
 *
 * <p>The cloud editor reads TIFF tag 0x88B0 (34992).  Adding a second EXIF
 * APP1 packet is not safe because most readers only inspect the first packet,
 * so this class clones the owning IFD and preserves every original EXIF byte.
 * It is a dependency-free adaptation of the writer shipped in the supplied
 * Xiaomi 15 Ultra port.</p>
 */
final class LegendExifTagger {
    static final int TAG_LEGEND_MODE = 34992;
    private static final byte[] EXIF_MAGIC = {69, 120, 105, 102, 0, 0};

    private LegendExifTagger() {
    }

    static byte[] tag(byte[] jpeg, int mode) {
        requireJpeg(jpeg);
        int[] exif = findExifSegment(jpeg);
        if (exif == null) {
            return insertAfterSoi(jpeg, buildMinimalExifApp1(mode));
        }
        byte[] replacement;
        try {
            replacement = injectIntoExisting(jpeg, exif[0], exif[1], mode);
        } catch (TiffParseException exception) {
            // Match Xiaomi's fail-safe: retain a valid Leica marker even when
            // the vendor JPEG contains an unparseable EXIF directory.
            replacement = buildMinimalExifApp1(mode);
        }
        byte[] output = new byte[jpeg.length - exif[1] + replacement.length];
        System.arraycopy(jpeg, 0, output, 0, exif[0]);
        System.arraycopy(replacement, 0, output, exif[0], replacement.length);
        System.arraycopy(jpeg, exif[0] + exif[1], output,
                exif[0] + replacement.length,
                jpeg.length - exif[0] - exif[1]);
        return output;
    }

    static int read(byte[] jpeg) {
        int[] exif = findExifSegment(jpeg);
        if (exif == null) {
            return -1;
        }
        int bodyLength = exif[1] - 4;
        byte[] body = new byte[bodyLength];
        System.arraycopy(jpeg, exif[0] + 4, body, 0, bodyLength);
        return readFromExifBody(body);
    }

    static int readOrientation(byte[] jpeg) {
        int[] exif = findExifSegment(jpeg);
        if (exif == null) {
            return 1;
        }
        int bodyLength = exif[1] - 4;
        byte[] body = new byte[bodyLength];
        System.arraycopy(jpeg, exif[0] + 4, body, 0, bodyLength);
        if (body.length < 14 || !startsWith(body, 0, EXIF_MAGIC)) {
            return 1;
        }
        boolean littleEndian;
        int first = body[6] & 0xff;
        int second = body[7] & 0xff;
        if (first == 'I' && second == 'I') {
            littleEndian = true;
        } else if (first == 'M' && second == 'M') {
            littleEndian = false;
        } else {
            return 1;
        }
        int relative = (int) u32(body, 10, littleEndian);
        int start = 6 + relative;
        if (relative < 0 || start + 2 > body.length) {
            return 1;
        }
        int count = u16(body, start, littleEndian);
        int entries = start + 2;
        if (entries + count * 12 > body.length) {
            return 1;
        }
        for (int index = 0; index < count; index++) {
            int entry = entries + index * 12;
            if (u16(body, entry, littleEndian) != 0x0112) {
                continue;
            }
            int type = u16(body, entry + 2, littleEndian);
            long itemCount = u32(body, entry + 4, littleEndian);
            int value = type == 3 && itemCount == 1
                    ? u16(body, entry + 8, littleEndian)
                    : type == 4 && itemCount == 1
                    ? (int) u32(body, entry + 8, littleEndian) : 1;
            return value >= 1 && value <= 8 ? value : 1;
        }
        return 1;
    }

    private static int[] findExifSegment(byte[] jpeg) {
        int offset = 2;
        while (offset + 4 <= jpeg.length) {
            if ((jpeg[offset] & 0xff) != 0xff) {
                offset++;
                continue;
            }
            int marker = jpeg[offset + 1] & 0xff;
            if (marker == 0xda) {
                return null;
            }
            if (marker == 0xd8 || marker == 0xd9 || marker == 0
                    || (marker >= 0xd0 && marker <= 0xd7)) {
                offset += 2;
                continue;
            }
            int segmentLength = u16be(jpeg, offset + 2);
            if (segmentLength < 2
                    || offset + segmentLength + 2 > jpeg.length) {
                return null;
            }
            if (marker == 0xe1
                    && startsWith(jpeg, offset + 4, EXIF_MAGIC)) {
                return new int[]{offset, segmentLength + 2};
            }
            offset += segmentLength + 2;
        }
        return null;
    }

    private static int readFromExifBody(byte[] body) {
        if (body.length < 14 || !startsWith(body, 0, EXIF_MAGIC)) {
            return -1;
        }
        boolean littleEndian;
        int first = body[6] & 0xff;
        int second = body[7] & 0xff;
        if (first == 'I' && second == 'I') {
            littleEndian = true;
        } else if (first == 'M' && second == 'M') {
            littleEndian = false;
        } else {
            return -1;
        }
        int[] scan = scanIfd(body, 6, (int) u32(body, 10, littleEndian),
                littleEndian);
        if (scan[0] != -1) {
            return scan[0];
        }
        if (scan[1] != -1) {
            return scanIfd(body, 6, scan[1], littleEndian)[0];
        }
        return -1;
    }

    private static int[] scanIfd(byte[] body, int tiffStart, int relative,
            boolean littleEndian) {
        int start = tiffStart + relative;
        if (relative < 0 || start + 2 > body.length) {
            return new int[]{-1, -1};
        }
        int count = u16(body, start, littleEndian);
        int entries = start + 2;
        if (entries + count * 12 > body.length) {
            return new int[]{-1, -1};
        }
        int exifIfd = -1;
        for (int index = 0; index < count; index++) {
            int entry = entries + index * 12;
            int tag = u16(body, entry, littleEndian);
            int type = u16(body, entry + 2, littleEndian);
            long itemCount = u32(body, entry + 4, littleEndian);
            if (tag == 34665 && itemCount == 1 && (type == 3 || type == 4)) {
                exifIfd = type == 3
                        ? u16(body, entry + 8, littleEndian)
                        : (int) u32(body, entry + 8, littleEndian);
            }
            if (tag == TAG_LEGEND_MODE) {
                if (type == 1) {
                    return new int[]{body[entry + 8] & 0xff, exifIfd};
                }
                if (type == 3) {
                    return new int[]{u16(body, entry + 8, littleEndian),
                            exifIfd};
                }
                if (type == 4) {
                    return new int[]{(int) u32(body, entry + 8,
                            littleEndian), exifIfd};
                }
                return new int[]{body[entry + 8] & 0xff, exifIfd};
            }
        }
        return new int[]{-1, exifIfd};
    }

    private static byte[] injectIntoExisting(byte[] jpeg, int markerOffset,
            int totalLength, int mode) {
        int bodyLength = totalLength - 4;
        byte[] body = new byte[bodyLength];
        System.arraycopy(jpeg, markerOffset + 4, body, 0, bodyLength);
        if (bodyLength < 14 || !startsWith(body, 0, EXIF_MAGIC)) {
            throw new TiffParseException("bad EXIF body");
        }
        boolean littleEndian;
        int first = body[6] & 0xff;
        int second = body[7] & 0xff;
        if (first == 'I' && second == 'I') {
            littleEndian = true;
        } else if (first == 'M' && second == 'M') {
            littleEndian = false;
        } else {
            throw new TiffParseException("bad byte order");
        }

        int ifd0 = 6 + (int) getU32(body, 10, littleEndian);
        if (ifd0 < 6 || ifd0 + 2 > bodyLength) {
            throw new TiffParseException("IFD0 out of bounds");
        }
        int ifd0Count = getU16(body, ifd0, littleEndian);
        int ifd0Entries = ifd0 + 2;
        if (ifd0Entries + ifd0Count * 12 + 4 > bodyLength) {
            throw new TiffParseException("IFD0 entries out of bounds");
        }

        // Update an existing tag in place when available.
        for (int index = 0; index < ifd0Count; index++) {
            int entry = ifd0Entries + index * 12;
            if (getU16(body, entry, littleEndian) == TAG_LEGEND_MODE) {
                writeLegendEntry(body, entry, littleEndian, mode);
                return app1(body);
            }
        }

        // Xiaomi prefers the ExifIFD when one exists; otherwise clone IFD0.
        int pointerEntry = -1;
        int exifIfdRelative = -1;
        for (int index = 0; index < ifd0Count; index++) {
            int entry = ifd0Entries + index * 12;
            int tag = getU16(body, entry, littleEndian);
            int type = getU16(body, entry + 2, littleEndian);
            long count = getU32(body, entry + 4, littleEndian);
            if (tag == 34665 && count == 1 && (type == 3 || type == 4)) {
                pointerEntry = entry;
                exifIfdRelative = type == 3
                        ? getU16(body, entry + 8, littleEndian)
                        : (int) getU32(body, entry + 8, littleEndian);
                break;
            }
        }

        int targetIfd = ifd0;
        boolean replaceIfd0Pointer = true;
        if (pointerEntry >= 0 && exifIfdRelative >= 0) {
            int candidate = 6 + exifIfdRelative;
            if (candidate + 2 <= bodyLength) {
                int count = getU16(body, candidate, littleEndian);
                if (candidate + 2 + count * 12 + 4 <= bodyLength) {
                    targetIfd = candidate;
                    replaceIfd0Pointer = false;
                }
            }
        }

        int targetCount = getU16(body, targetIfd, littleEndian);
        int targetEntries = targetIfd + 2;
        int nextIfdOffset = targetEntries + targetCount * 12;
        if (nextIfdOffset + 4 > bodyLength) {
            throw new TiffParseException("target IFD out of bounds");
        }

        ArrayList<byte[]> entries = new ArrayList<>(targetCount + 1);
        for (int index = 0; index < targetCount; index++) {
            int entry = targetEntries + index * 12;
            entries.add(Arrays.copyOfRange(body, entry, entry + 12));
        }
        byte[] nextPointer = Arrays.copyOfRange(body, nextIfdOffset,
                nextIfdOffset + 4);
        boolean replaced = false;
        for (int index = 0; index < entries.size(); index++) {
            if (getU16(entries.get(index), 0, littleEndian)
                    == TAG_LEGEND_MODE) {
                entries.set(index, legendEntry(littleEndian, mode));
                replaced = true;
                break;
            }
        }
        if (!replaced) {
            entries.add(legendEntry(littleEndian, mode));
        }
        entries.sort(Comparator.comparingInt(
                value -> getU16(value, 0, littleEndian)));

        int cloneOffset = bodyLength + ((bodyLength - 6) & 1);
        int relativeCloneOffset = cloneOffset - 6;
        int newLength = cloneOffset + 2 + entries.size() * 12 + 4;
        byte[] output = Arrays.copyOf(body, newLength);
        putU16(output, cloneOffset, littleEndian, entries.size());
        int destination = cloneOffset + 2;
        for (byte[] entry : entries) {
            System.arraycopy(entry, 0, output, destination, 12);
            destination += 12;
        }
        System.arraycopy(nextPointer, 0, output, destination, 4);
        if (newLength + 2 > 65535) {
            throw new TiffParseException("EXIF APP1 exceeds 64 KiB");
        }
        if (replaceIfd0Pointer) {
            putU32(output, 10, littleEndian, relativeCloneOffset);
        } else if (getU16(output, pointerEntry + 2, littleEndian) == 3) {
            if (relativeCloneOffset > 65535) {
                throw new TiffParseException("ExifIFD offset overflows SHORT");
            }
            putU16(output, pointerEntry + 8, littleEndian,
                    relativeCloneOffset);
            output[pointerEntry + 10] = 0;
            output[pointerEntry + 11] = 0;
        } else {
            putU32(output, pointerEntry + 8, littleEndian,
                    relativeCloneOffset);
        }
        return app1(output);
    }

    private static byte[] legendEntry(boolean littleEndian, int mode) {
        byte[] entry = new byte[12];
        writeLegendEntry(entry, 0, littleEndian, mode);
        return entry;
    }

    private static void writeLegendEntry(byte[] bytes, int offset,
            boolean littleEndian, int mode) {
        putU16(bytes, offset, littleEndian, TAG_LEGEND_MODE);
        putU16(bytes, offset + 2, littleEndian, 1); // BYTE
        putU32(bytes, offset + 4, littleEndian, 1);
        bytes[offset + 8] = (byte) (mode & 0xff);
        bytes[offset + 9] = 0;
        bytes[offset + 10] = 0;
        bytes[offset + 11] = 0;
    }

    private static byte[] buildMinimalExifApp1(int mode) {
        ByteArrayOutputStream body = new ByteArrayOutputStream(32);
        body.write(EXIF_MAGIC, 0, EXIF_MAGIC.length);
        body.write('I');
        body.write('I');
        writeU16le(body, 42);
        writeU32le(body, 8);
        writeU16le(body, 1);
        writeU16le(body, TAG_LEGEND_MODE);
        writeU16le(body, 1);
        writeU32le(body, 1);
        body.write(mode & 0xff);
        body.write(0);
        body.write(0);
        body.write(0);
        writeU32le(body, 0);
        return app1(body.toByteArray());
    }

    private static byte[] app1(byte[] body) {
        int segmentLength = body.length + 2;
        if (segmentLength > 65535) {
            throw new TiffParseException("EXIF APP1 exceeds 64 KiB");
        }
        byte[] output = new byte[body.length + 4];
        output[0] = (byte) 0xff;
        output[1] = (byte) 0xe1;
        output[2] = (byte) ((segmentLength >>> 8) & 0xff);
        output[3] = (byte) (segmentLength & 0xff);
        System.arraycopy(body, 0, output, 4, body.length);
        return output;
    }

    private static byte[] insertAfterSoi(byte[] jpeg, byte[] segment) {
        byte[] output = new byte[jpeg.length + segment.length];
        output[0] = jpeg[0];
        output[1] = jpeg[1];
        System.arraycopy(segment, 0, output, 2, segment.length);
        System.arraycopy(jpeg, 2, output, segment.length + 2,
                jpeg.length - 2);
        return output;
    }

    private static int getU16(byte[] bytes, int offset,
            boolean littleEndian) {
        return u16(bytes, offset, littleEndian);
    }

    private static long getU32(byte[] bytes, int offset,
            boolean littleEndian) {
        return u32(bytes, offset, littleEndian);
    }

    private static void putU16(byte[] bytes, int offset,
            boolean littleEndian, int value) {
        if (littleEndian) {
            bytes[offset] = (byte) (value & 0xff);
            bytes[offset + 1] = (byte) ((value >>> 8) & 0xff);
        } else {
            bytes[offset] = (byte) ((value >>> 8) & 0xff);
            bytes[offset + 1] = (byte) (value & 0xff);
        }
    }

    private static void putU32(byte[] bytes, int offset,
            boolean littleEndian, long value) {
        if (littleEndian) {
            bytes[offset] = (byte) (value & 0xff);
            bytes[offset + 1] = (byte) ((value >>> 8) & 0xff);
            bytes[offset + 2] = (byte) ((value >>> 16) & 0xff);
            bytes[offset + 3] = (byte) ((value >>> 24) & 0xff);
        } else {
            bytes[offset] = (byte) ((value >>> 24) & 0xff);
            bytes[offset + 1] = (byte) ((value >>> 16) & 0xff);
            bytes[offset + 2] = (byte) ((value >>> 8) & 0xff);
            bytes[offset + 3] = (byte) (value & 0xff);
        }
    }

    private static int u16be(byte[] bytes, int offset) {
        return ((bytes[offset] & 0xff) << 8) | (bytes[offset + 1] & 0xff);
    }

    private static int u16(byte[] bytes, int offset,
            boolean littleEndian) {
        int first = bytes[offset] & 0xff;
        int second = bytes[offset + 1] & 0xff;
        return littleEndian ? (second << 8) | first : (first << 8) | second;
    }

    private static long u32(byte[] bytes, int offset,
            boolean littleEndian) {
        long a = bytes[offset] & 0xffL;
        long b = bytes[offset + 1] & 0xffL;
        long c = bytes[offset + 2] & 0xffL;
        long d = bytes[offset + 3] & 0xffL;
        return littleEndian
                ? a | (b << 8) | (c << 16) | (d << 24)
                : (a << 24) | (b << 16) | (c << 8) | d;
    }

    private static void writeU16le(ByteArrayOutputStream output, int value) {
        output.write(value & 0xff);
        output.write((value >>> 8) & 0xff);
    }

    private static void writeU32le(ByteArrayOutputStream output, int value) {
        output.write(value & 0xff);
        output.write((value >>> 8) & 0xff);
        output.write((value >>> 16) & 0xff);
        output.write((value >>> 24) & 0xff);
    }

    private static boolean startsWith(byte[] bytes, int offset,
            byte[] prefix) {
        if (offset < 0 || offset + prefix.length > bytes.length) {
            return false;
        }
        for (int index = 0; index < prefix.length; index++) {
            if (bytes[offset + index] != prefix[index]) {
                return false;
            }
        }
        return true;
    }

    private static void requireJpeg(byte[] jpeg) {
        if (jpeg == null || jpeg.length < 4
                || (jpeg[0] & 0xff) != 0xff
                || (jpeg[1] & 0xff) != 0xd8) {
            throw new IllegalArgumentException("input is not a JPEG");
        }
    }

    private static final class TiffParseException
            extends RuntimeException {
        TiffParseException(String message) {
            super(message);
        }
    }
}
