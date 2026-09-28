package local.mio.os4camerabridge;

/** Pure policy/parser shared by the bridge and host tests; never decodes pixels. */
public final class JpegWatermarkMetadataPolicy {
    private JpegWatermarkMetadataPolicy() {}

    static final String[] SHOOTING_TAGS = {
            "ExposureTime", "FNumber", "ExposureProgram", "ISOSpeedRatings",
            "PhotographicSensitivity", "SensitivityType", "StandardOutputSensitivity",
            "RecommendedExposureIndex", "ShutterSpeedValue", "ApertureValue",
            "BrightnessValue", "ExposureBiasValue", "MaxApertureValue", "MeteringMode",
            "LightSource", "Flash", "FocalLength", "FocalLengthIn35mmFilm",
            "WhiteBalance", "ExposureMode", "SceneCaptureType", "DigitalZoomRatio"
    };

    static boolean eligible(int module, int facing, int shotType, boolean watermark) {
        return (module == 163 || module == 167 || module == 256) && facing == 0
                && shotType == 0 && watermark;
    }

    static boolean needsRestore(String before, String after) {
        return before != null && !before.isEmpty() && before.length() <= 160
                && (after == null || after.isEmpty());
    }

    /** Return encoded SOF width/height, ignoring EXIF orientation and dimensions. */
    static int[] dimensions(byte[] data) {
        if (data == null || data.length < 4 || u(data[0]) != 255 || u(data[1]) != 216)
            return null;
        int position = 2;
        while (position < data.length) {
            if (u(data[position++]) != 255) return null;
            while (position < data.length && u(data[position]) == 255) position++;
            if (position >= data.length) return null;
            int marker = u(data[position++]);
            if (marker == 0 || marker == 216 || marker == 217 || marker == 218) return null;
            if (marker == 1 || (marker >= 208 && marker <= 215)) continue;
            if (position + 2 > data.length) return null;
            int length = (u(data[position]) << 8) | u(data[position + 1]);
            if (length < 2 || length > data.length - position) return null;
            boolean sof = marker >= 192 && marker <= 207
                    && marker != 196 && marker != 200 && marker != 204;
            if (sof) {
                if (length < 8) return null;
                int components = u(data[position + 7]);
                if (components < 1 || length != 8 + 3 * components) return null;
                int height = (u(data[position + 3]) << 8) | u(data[position + 4]);
                int width = (u(data[position + 5]) << 8) | u(data[position + 6]);
                return width > 0 && height > 0 ? new int[]{width, height} : null;
            }
            position += length;
        }
        return null;
    }

    private static int u(byte value) { return value & 255; }
}
