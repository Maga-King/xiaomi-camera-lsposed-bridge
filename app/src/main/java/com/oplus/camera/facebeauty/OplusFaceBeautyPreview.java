package com.oplus.camera.facebeauty;

/**
 * Exact Java ABI expected by ColorOS' libApsFaceBeautyPreviewJni.so.
 *
 * The implementation is bundled in the LSP module so the Xiaomi camera does
 * not need the complete OplusCamera APK or a Magisk system-app overlay.
 */
public final class OplusFaceBeautyPreview {
    private static boolean loaded;

    public static synchronized void load(String absolutePath) {
        if (!loaded) {
            System.load(absolutePath);
            loaded = true;
        }
    }

    public native int destroy();

    public native long getTimeStamp();

    public native float getZoomScale();

    public native int init(int width, int height, int version, int logLevel,
            String language, String region, String locale,
            boolean frontCamera, boolean enableAi, byte[] sensorName,
            int modeIndex);

    public native int process(int inputTexture, int[] outputTextures,
            int[] processInfo, int[] beautyParameters);

    public native int reset();

    public native int setPreviewParams(String key, String value);

    public native int updataFfd(byte[] data);

    public native int updataMetaParams(byte[] data);

    public native int updataPreviewParams(long timestamp);
}
