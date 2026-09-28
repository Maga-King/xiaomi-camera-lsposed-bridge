package local.mio.os4camerabridge;

/** Bounds of the public video route verified on this port. */
public final class GenericVideoPolicy {
    private GenericVideoPolicy() {}

    public static boolean supportsProfile(int module, int camera, int width, int height, int fps) {
        return module == 162 && camera == 0 && width == 1920 && height == 1080 && fps == 30;
    }

    public static boolean supportsSession(boolean profileVerified, int module, String camera,
            int operationMode, int outputCount, int fpsUpper) {
        return profileVerified && module == 162 && "0".equals(camera)
                && (operationMode == 0 || operationMode == 0x8004 || operationMode == 0xf010)
                && outputCount == 3 && fpsUpper == 30;
    }
}
