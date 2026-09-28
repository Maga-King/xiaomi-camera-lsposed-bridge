package local.mio.os4camerabridge;

import android.hardware.camera2.CaptureRequest;
import java.lang.reflect.Field;
import java.lang.reflect.Method;
import java.util.Arrays;
import java.util.concurrent.atomic.AtomicInteger;
import de.robv.android.xposed.XC_MethodHook;
import de.robv.android.xposed.XposedBridge;

/** Stock fallback control experiment; no session, stream, burst or image changes. */
public final class RearTelePreviewBridge {
    private static final CaptureRequest.Key<int[]> FALLBACK = new CaptureRequest.Key<>(
            "com.oplus.fallback.disableMask", int[].class);
    private static final AtomicInteger LOGS = new AtomicInteger();
    private static boolean installed;

    private RearTelePreviewBridge() {}

    public static synchronized void install(ClassLoader ignored) {
        if (installed) return;
        try {
            Class<?> entry = Class.forName("local.mio.os4camerabridge.HookEntry",
                    false, RearTelePreviewBridge.class.getClassLoader());
            Method route = entry.getDeclaredMethod("applyUnifiedOplusLensRoute",
                    CaptureRequest.Builder.class, CaptureRequest.class, boolean.class);
            Field module = field(entry, "activeCameraModule", int.class);
            Field camera = field(entry, "activeCameraId", int.class);
            Field unified = field(entry, "commonApsUnifiedSessionActive", boolean.class);
            Field portrait = field(entry, "commonApsUnifiedPortraitSession", boolean.class);
            XposedBridge.hookMethod(route, new XC_MethodHook(9000) {
                @Override protected void afterHookedMethod(MethodHookParam p) {
                    if (p.hasThrowable()) return;
                    try {
                        CaptureRequest.Builder builder = (CaptureRequest.Builder) p.args[0];
                        Float ratio = builder.get(CaptureRequest.CONTROL_ZOOM_RATIO);
                        if (ratio == null || !RearTelePreviewPolicy.eligible(module.getInt(null),
                                camera.getInt(null), unified.getBoolean(null),
                                portrait.getBoolean(null), (Boolean) p.args[2], ratio)) return;
                        int[] before = builder.get(FALLBACK);
                        int[] after = RearTelePreviewPolicy.mask(before);
                        if (after == null) return;
                        builder.set(FALLBACK, after);
                        if (LOGS.getAndIncrement() < 12) XposedBridge.log(
                                "[RearTelePreview] experiment-v1 zoom=" + ratio
                                + " fallbackMask=" + Arrays.toString(before) + "->"
                                + Arrays.toString(builder.get(FALLBACK))
                                + " previewOnly=true; actual lens must be verified in results");
                    } catch (Throwable t) {
                        if (LOGS.getAndIncrement() < 12) XposedBridge.log(
                                "[RearTelePreview] request retained: " + t);
                    }
                }
            });
            installed = true;
            XposedBridge.log("[RearTelePreview] installed experiment-v1; stock fallback bit2; rear163 logical0 repeating only");
        } catch (Throwable t) {
            XposedBridge.log("[RearTelePreview] install rejected: " + t);
        }
    }

    private static Field field(Class<?> owner, String name, Class<?> type) throws Exception {
        Field result = owner.getDeclaredField(name);
        if (result.getType() != type) throw new IllegalStateException("Unexpected " + name);
        result.setAccessible(true);
        return result;
    }
}
