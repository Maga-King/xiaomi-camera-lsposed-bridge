package local.mio.os4camerabridge;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.Reader;

/** Immutable 3D .cube lookup. Red is the fastest-changing axis; no camera calibration. */
public final class LegendaryCubeLut {
    private final int size;
    private final float[] values;
    private final int[][] lower = new int[3][256];
    private final float[][] fraction = new float[3][256];

    private LegendaryCubeLut(int size, float[] values, float[] min, float[] max) {
        this.size = size;
        this.values = values;
        for (int channel = 0; channel < 3; channel++) {
            for (int value = 0; value < 256; value++) {
                float position = Math.max(0f, Math.min(1f,
                        (value / 255f - min[channel]) / (max[channel] - min[channel]))) * (size - 1);
                int base = Math.min(size - 2, (int) position);
                lower[channel][value] = base;
                fraction[channel][value] = position - base;
            }
        }
    }

    public static LegendaryCubeLut read(Reader input) throws IOException {
        BufferedReader reader = new BufferedReader(input);
        float[] min = {0, 0, 0}, max = {1, 1, 1}, values = null;
        boolean minSeen = false, maxSeen = false, dataStarted = false;
        int size = 0, count = 0, lineNumber = 0;
        String line;
        while ((line = reader.readLine()) != null) {
            lineNumber++;
            if (lineNumber == 1 && line.startsWith("\ufeff")) line = line.substring(1);
            int comment = line.indexOf('#');
            if (comment >= 0) line = line.substring(0, comment);
            line = line.trim();
            if (line.isEmpty()) continue;
            String[] parts = line.split("\\s+");
            try {
                if (parts[0].equals("TITLE")) {
                    if (dataStarted) throw new IllegalArgumentException("Late TITLE");
                    continue;
                }
                if (parts[0].equals("LUT_3D_SIZE")) {
                    if (parts.length != 2 || size != 0 || dataStarted)
                        throw new IllegalArgumentException("Duplicate/invalid size");
                    size = Integer.parseInt(parts[1]);
                    if (size < 2 || size > 65) throw new IllegalArgumentException("Unsupported grid size");
                    values = new float[size * size * size * 3];
                    continue;
                }
                if (parts[0].equals("DOMAIN_MIN") || parts[0].equals("DOMAIN_MAX")) {
                    boolean isMin = parts[0].equals("DOMAIN_MIN");
                    if (parts.length != 4 || dataStarted || (isMin ? minSeen : maxSeen))
                        throw new IllegalArgumentException("Duplicate/late/invalid domain");
                    float[] target = isMin ? min : max;
                    for (int channel = 0; channel < 3; channel++) target[channel] = finite(parts[channel + 1]);
                    if (isMin) minSeen = true; else maxSeen = true;
                    continue;
                }
                if (values == null || parts.length != 3 || count + 3 > values.length)
                    throw new IllegalArgumentException("Invalid or excess data");
                for (String part : parts) values[count++] = finite(part);
                dataStarted = true;
            } catch (IllegalArgumentException error) {
                throw new IOException("Invalid cube line " + lineNumber + ": " + error.getMessage(), error);
            }
        }
        if (values == null || count != values.length) throw new IOException("Incomplete LUT");
        for (int channel = 0; channel < 3; channel++) {
            if (!(max[channel] > min[channel]) || !Float.isFinite(max[channel] - min[channel]))
                throw new IOException("Invalid domain span");
        }
        return new LegendaryCubeLut(size, values, min, max);
    }

    private static float finite(String token) {
        float value = Float.parseFloat(token);
        if (!Float.isFinite(value) || Math.abs(value) > 65504f)
            throw new IllegalArgumentException("Nonfinite or unbounded value");
        return value;
    }

    public int gridSize() { return size; }

    public int mapArgb(int pixel) {
        int red = (pixel >>> 16) & 255, green = (pixel >>> 8) & 255, blue = pixel & 255;
        int base = 3 * (lower[0][red] + size * (lower[1][green] + size * lower[2][blue]));
        float r = fraction[0][red], g = fraction[1][green], b = fraction[2][blue];
        int result = pixel & 0xff000000;
        for (int channel = 0; channel < 3; channel++) {
            int i = base + channel;
            int greenStep = size * 3, blueStep = size * size * 3;
            float low = mix(mix(values[i], values[i + 3], r),
                    mix(values[i + greenStep], values[i + greenStep + 3], r), g);
            float high = mix(mix(values[i + blueStep], values[i + blueStep + 3], r),
                    mix(values[i + blueStep + greenStep], values[i + blueStep + greenStep + 3], r), g);
            int value = Math.round(Math.max(0f, Math.min(1f, mix(low, high, b))) * 255f);
            result |= value << (16 - channel * 8);
        }
        return result;
    }

    public void mapArgb(int[] pixels, int offset, int count) {
        if (pixels == null || offset < 0 || count < 0 || offset > pixels.length - count)
            throw new IllegalArgumentException("Invalid pixel range");
        for (int i = offset; i < offset + count; i++) pixels[i] = mapArgb(pixels[i]);
    }

    private static float mix(float a, float b, float t) { return a + (b - a) * t; }
}
