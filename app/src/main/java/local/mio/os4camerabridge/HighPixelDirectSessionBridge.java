package local.mio.os4camerabridge;

import java.lang.reflect.Method;
import java.lang.reflect.Modifier;
import java.util.List;
import java.util.Arrays;
import android.app.AndroidAppHelper;
import android.content.Context;
import android.graphics.ImageFormat;
import android.hardware.camera2.CameraManager;
import android.hardware.camera2.CameraCharacteristics;
import android.hardware.camera2.params.StreamConfigurationMap;
import android.util.Size;
import de.robv.android.xposed.XC_MethodHook;
import de.robv.android.xposed.XposedBridge;
import de.robv.android.xposed.XposedHelpers;

/** Isolated PixelModule direct-JPEG candidate; no forced sensor sizes. */
public final class HighPixelDirectSessionBridge {
    private static boolean capabilitiesLogged;
    private HighPixelDirectSessionBridge() {}

    public static void install(ClassLoader loader) {
        try {
            Class<?> pixel = Class.forName("com.android.camera.features.mode.pixel.PixelModule", false, loader);
            Method parallel = pixel.getDeclaredMethod("isParallelSessionEnable");
            if (parallel.getReturnType() != boolean.class || Modifier.isStatic(parallel.getModifiers()))
                throw new IllegalStateException("Unexpected Pixel parallel contract");
            Class<?> entry = Class.forName("local.mio.os4camerabridge.HookEntry", false,
                    HighPixelDirectSessionBridge.class.getClassLoader());
            XposedBridge.hookMethod(parallel, new XC_MethodHook() {
                @Override protected void beforeHookedMethod(MethodHookParam p) {
                    p.setResult(false);
                    logCapabilities();
                }
            });
            XposedBridge.hookAllMethods(XposedHelpers.findClass("sh.b", loader), "b", new XC_MethodHook(-10000) {
                @Override protected void beforeHookedMethod(MethodHookParam p) {
                    try {
                        if (XposedHelpers.getStaticIntField(entry, "activeCameraModule") != 175) return;
                        if (p.args.length != 5 || !(p.args[0] instanceof Integer) || !(p.args[1] instanceof List<?>)) return;
                        String camera = String.valueOf(XposedHelpers.callMethod(p.thisObject, "c"));
                        List<?> outputs = (List<?>) p.args[1];
                        int mode = (Integer) p.args[0], preview = 0, jpeg = 0, yuv = 0;
                        StringBuilder formats = new StringBuilder();
                        for (Object output : outputs) {
                            int format = (Integer) XposedHelpers.callStaticMethod(entry, "configuredOutputFormat", output);
                            formats.append(format).append(',');
                            if (format == 34) preview++;
                            if (format == 33 || format == 256) jpeg++;
                            if (format == 35) yuv++;
                        }
                        boolean compatible = "0".equals(camera) && preview == 1 && jpeg == 1
                                && yuv <= 1 && outputs.size() == preview + jpeg + yuv
                                && (mode == 0 || mode == 0x9004 || mode == 0x8001 || mode == 0x80f3);
                        if (compatible) p.args[0] = 0;
                        XposedBridge.log("[HighPixelDirect] camera=" + camera + " mode=" + mode + "->"
                                + p.args[0] + " formats=" + formats + " compatible=" + compatible);
                    } catch (Throwable error) { XposedBridge.log("[HighPixelDirect] session: " + error); }
                }
            });
            XposedBridge.log("[HighPixelDirect] Pixel override disabled; native JPEG consumer retained; size unmodified");
        } catch (Throwable error) { XposedBridge.log("[HighPixelDirect] unavailable: " + error); }
    }

    private static synchronized void logCapabilities() {
        if (capabilitiesLogged) return;
        try {
            Context context = AndroidAppHelper.currentApplication();
            if (context == null) return;
            CameraManager manager = (CameraManager) context.getSystemService(Context.CAMERA_SERVICE);
            for (String id : manager.getCameraIdList()) {
                CameraCharacteristics c = manager.getCameraCharacteristics(id);
                StreamConfigurationMap map = c.get(CameraCharacteristics.SCALER_STREAM_CONFIGURATION_MAP);
                if (map == null) continue;
                XposedBridge.log("[HighPixelCaps] id=" + id + " JPEG=" + Arrays.toString(map.getOutputSizes(ImageFormat.JPEG))
                        + " high=" + Arrays.toString(map.getHighResolutionOutputSizes(ImageFormat.JPEG)));
            }
            capabilitiesLogged = true;
        } catch (Throwable error) { XposedBridge.log("[HighPixelCaps] unavailable: " + error); }
    }
}
