package local.mio.os4camerabridge;

import java.io.ByteArrayOutputStream;
import java.nio.charset.StandardCharsets;

/** Remove only a source ICC profile after an actual conversion to sRGB. */
public final class LegendaryJpegColorMetadata {
    private static final byte[] ICC = "ICC_PROFILE\0".getBytes(StandardCharsets.US_ASCII);

    private LegendaryJpegColorMetadata() {}

    public static byte[] withoutSourceIcc(byte[] jpeg) {
        if (jpeg == null || jpeg.length < 4 || (jpeg[0] & 255) != 255
                || (jpeg[1] & 255) != 216) throw new IllegalArgumentException("Not JPEG");
        ByteArrayOutputStream out = new ByteArrayOutputStream(jpeg.length);
        out.write(jpeg, 0, 2);
        int pos = 2;
        while (pos < jpeg.length) {
            int start = pos;
            if ((jpeg[pos++] & 255) != 255) throw new IllegalArgumentException("Invalid marker");
            while (pos < jpeg.length && (jpeg[pos] & 255) == 255) pos++;
            if (pos >= jpeg.length) throw new IllegalArgumentException("Truncated marker");
            int marker = jpeg[pos++] & 255;
            if (marker == 0xda || marker == 0xd9) {
                out.write(jpeg, start, jpeg.length - start);
                return out.toByteArray();
            }
            if (marker == 0x01 || (marker >= 0xd0 && marker <= 0xd7)) {
                out.write(jpeg, start, pos - start);
                continue;
            }
            if (marker == 0 || marker == 0xd8 || pos + 2 > jpeg.length)
                throw new IllegalArgumentException("Invalid segment");
            int size = ((jpeg[pos] & 255) << 8) | (jpeg[pos + 1] & 255);
            if (size < 2 || size > jpeg.length - pos)
                throw new IllegalArgumentException("Truncated segment");
            boolean icc = marker == 0xe2 && size >= 2 + ICC.length;
            for (int i = 0; icc && i < ICC.length; i++) icc = jpeg[pos + 2 + i] == ICC[i];
            int end = pos + size;
            if (!icc) out.write(jpeg, start, end - start);
            pos = end;
        }
        throw new IllegalArgumentException("Missing scan/end marker");
    }
}
