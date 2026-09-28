package local.mio.os4camerabridge;

import java.nio.ByteBuffer;

/** Copy native MIPI RAW10 row payloads without decoding, changing CFA, or consuming a buffer. */
public final class PackedRaw10Copy {
    private PackedRaw10Copy() {}

    public static byte[] copy(ByteBuffer source, int width, int height, int rowStride) {
        if (source == null || width <= 0 || height <= 0 || width % 4 != 0
                || width > 8192 || height > 8192) throw new IllegalArgumentException("Invalid RAW10 geometry");
        int rowBytes = width / 4 * 5;
        long total = (long) rowBytes * height;
        long required = (long) rowStride * (height - 1) + rowBytes;
        if (rowStride < rowBytes || total > 64 * 1024 * 1024 || required > source.remaining())
            throw new IllegalArgumentException("Invalid RAW10 stride/capacity");
        ByteBuffer view = source.duplicate();
        int start = view.position();
        byte[] packed = new byte[(int)total];
        for (int row = 0; row < height; row++) {
            view.position(start + row * rowStride);
            view.get(packed, row * rowBytes, rowBytes);
        }
        return packed;
    }
}
