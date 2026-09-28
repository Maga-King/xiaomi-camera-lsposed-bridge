package local.mio.os4camerabridge;

import java.io.ByteArrayOutputStream;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

/** JPEG 的色彩描述属于编码后的像素，不能从另一张图盲目覆盖。 */
public final class RearJpegMetadataPolicy {
    private RearJpegMetadataPolicy() {}

    public static byte[] transfer(byte[] original, byte[] encoded) {
        List<int[]> source = headers(original);
        List<int[]> target = headers(encoded);
        if (Arrays.equals(original, encoded)) return encoded;
        ByteArrayOutputStream extra = new ByteArrayOutputStream();
        List<int[]> addedSegments = new ArrayList<>();
        for (int[] segment : source) {
            int marker = segment[2];
            // APP2 的 ICC 属于目标编码器；MPF 内偏移也不能跨编码图像移植。
            if (marker != 0xe1 && marker != 0xed) continue;
            boolean present = false;
            for (int[] existing : target) {
                if (marker != existing[2]) continue;
                if (same(original, segment, encoded, existing)
                        || (isExif(original, segment) && isExif(encoded, existing))) {
                    present = true;
                    break;
                }
            }
            for (int[] added : addedSegments) {
                if (marker == added[2] && (same(original, segment, original, added)
                        || (isExif(original, segment) && isExif(original, added)))) {
                    present = true;
                    break;
                }
            }
            if (!present) {
                extra.write(original, segment[0], segment[1]);
                addedSegments.add(segment);
            }
        }
        if (extra.size() == 0) return encoded;
        ByteArrayOutputStream result = new ByteArrayOutputStream(encoded.length + extra.size());
        result.write(encoded, 0, 2);
        byte[] added = extra.toByteArray();
        result.write(added, 0, added.length);
        result.write(encoded, 2, encoded.length - 2);
        return result.toByteArray();
    }

    private static boolean isExif(byte[] data, int[] segment) {
        int p = segment[0] + 4;
        return segment[2] == 0xe1 && segment[1] >= 10 && data[p] == 'E'
                && data[p + 1] == 'x' && data[p + 2] == 'i' && data[p + 3] == 'f'
                && data[p + 4] == 0 && data[p + 5] == 0;
    }

    private static boolean same(byte[] left, int[] a, byte[] right, int[] b) {
        if (a[1] != b[1]) return false;
        for (int i = 0; i < a[1]; i++) if (left[a[0] + i] != right[b[0] + i]) return false;
        return true;
    }

    private static List<int[]> headers(byte[] data) {
        if (data == null || data.length < 4 || (data[0] & 255) != 255 || (data[1] & 255) != 216)
            throw new IllegalArgumentException("缺少 JPEG SOI");
        ArrayList<int[]> segments = new ArrayList<>();
        int position = 2;
        while (position < data.length && segments.size() < 1024) {
            int start = position;
            if ((data[position++] & 255) != 255) throw new IllegalArgumentException("JPEG 标记无效");
            while (position < data.length && (data[position] & 255) == 255) position++;
            if (position >= data.length) throw new IllegalArgumentException("JPEG 标记截断");
            int marker = data[position++] & 255;
            if (marker == 0xd9) return segments;
            if (marker == 0xda) {
                if (position + 2 > data.length) throw new IllegalArgumentException("SOS 截断");
                int length = ((data[position] & 255) << 8) | (data[position + 1] & 255);
                if (length < 2 || length > data.length - position) throw new IllegalArgumentException("SOS 长度无效");
                return segments;
            }
            if (marker == 1 || (marker >= 0xd0 && marker <= 0xd7)) continue;
            if (position + 2 > data.length) throw new IllegalArgumentException("JPEG 段头截断");
            int length = ((data[position] & 255) << 8) | (data[position + 1] & 255);
            if (length < 2 || length > data.length - position) throw new IllegalArgumentException("JPEG 段越界");
            // 元数据标记采用规范的单个 FF，避免把填充字节误认为载荷。
            segments.add(new int[]{position - 2, length + 2, marker});
            position += length;
            if (position <= start) throw new IllegalArgumentException("JPEG 解析未前进");
        }
        throw new IllegalArgumentException("JPEG 缺少扫描段或段数超限");
    }
}
