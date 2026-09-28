package local.mio.os4camerabridge;

import android.graphics.Rect;
import android.hardware.camera2.CameraCharacteristics;
import android.hardware.camera2.CaptureRequest;
import android.util.Range;
import java.lang.reflect.Field;
import java.lang.reflect.Method;
import java.util.Map;
import java.util.concurrent.atomic.AtomicInteger;
import de.robv.android.xposed.XC_MethodHook;
import de.robv.android.xposed.XposedBridge;

/** Keep continuous video zoom in logical-camera coordinates, without legacy crop conversion. */
public final class VideoLogicalWideZoomBridge {
    private static boolean installed;
    private static final AtomicInteger LOGS = new AtomicInteger();
    private VideoLogicalWideZoomBridge() {}

    public static synchronized void install(ClassLoader ignored) {
        if (installed) return;
        try {
            Class<?> entry = Class.forName("local.mio.os4camerabridge.HookEntry", false,
                    VideoLogicalWideZoomBridge.class.getClassLoader());
            Field cache = entry.getDeclaredField("CAMERA_CHARACTERISTICS");
            cache.setAccessible(true);
            Method physical = entry.getDeclaredMethod("applyPhysicalRoleZoom", CaptureRequest.Builder.class,
                    int.class, float.class, int.class);
            XposedBridge.hookMethod(physical, new XC_MethodHook() {
                @Override protected void beforeHookedMethod(MethodHookParam p) {
                    if (((Integer) p.args[3]) != 162 || ((Integer) p.args[1]) != 0) return;
                    float ratio = (Float) p.args[2];
                    if (!Float.isFinite(ratio) || ratio < 0.6f || ratio > 20f) return;
                    try {
                        CameraCharacteristics characteristics = (CameraCharacteristics) ((Map<?, ?>) cache.get(null)).get("0");
                        if (characteristics == null) throw new IllegalStateException("Missing camera0 characteristics");
                        int[] capabilities = characteristics.get(CameraCharacteristics.REQUEST_AVAILABLE_CAPABILITIES);
                        boolean logical = false;
                        if (capabilities != null) for (int c : capabilities)
                            if (c == CameraCharacteristics.REQUEST_AVAILABLE_CAPABILITIES_LOGICAL_MULTI_CAMERA) logical = true;
                        Range<Float> range = characteristics.get(CameraCharacteristics.CONTROL_ZOOM_RATIO_RANGE);
                        Rect active = characteristics.get(CameraCharacteristics.SENSOR_INFO_ACTIVE_ARRAY_SIZE);
                        if (!logical || range == null || !range.contains(ratio) || active == null || active.isEmpty())
                            throw new IllegalStateException("Camera0 logical zoom capability mismatch");
                        CaptureRequest.Builder builder = (CaptureRequest.Builder) p.args[0];
                        Float oldZoom = builder.get(CaptureRequest.CONTROL_ZOOM_RATIO);
                        Rect oldCrop = builder.get(CaptureRequest.SCALER_CROP_REGION);
                        try {
                            builder.set(CaptureRequest.CONTROL_ZOOM_RATIO, ratio);
                            builder.set(CaptureRequest.SCALER_CROP_REGION, new Rect(active));
                        } catch (Throwable writeFailure) {
                            builder.set(CaptureRequest.CONTROL_ZOOM_RATIO, oldZoom);
                            builder.set(CaptureRequest.SCALER_CROP_REGION, oldCrop);
                            throw writeFailure;
                        }
                        p.setResult(null); // Only bypass the physical-only normalization for this call.
                        if (LOGS.getAndIncrement() < 48) XposedBridge.log("[VideoLogicalWideZoom] camera0 ratio="
                                + ratio + " crop=" + active + "; physical normalization bypassed");
                    } catch (Throwable t) {
                        if (LOGS.getAndIncrement() < 48) XposedBridge.log("[VideoLogicalWideZoom] rejected: " + t);
                    }
                }
            });
            installed = true;
            XposedBridge.log("[VideoLogicalWideZoom] installed v2: rear Video162 logical0 continuous0.6..20; no physical-role crop conversion");
        } catch (Throwable t) { XposedBridge.log("[VideoLogicalWideZoom] install rejected: " + t); }
    }
}
