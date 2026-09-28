package local.mio.os4camerabridge;

import android.hardware.camera2.CaptureRequest;
import android.hardware.camera2.CaptureResult;
import android.hardware.camera2.TotalCaptureResult;
import android.os.SystemClock;
import de.robv.android.xposed.XC_MethodHook;
import de.robv.android.xposed.XposedBridge;
import java.lang.reflect.Array;
import java.lang.reflect.Field;
import java.lang.reflect.Method;
import java.util.List;
import java.util.Locale;

/** Temporary read-only, two-capture contract audit. No request, result or image mutations. */
public final class CaptureColorContractProbe {
    private static boolean installed;
    private static Field module, camera, unified, portrait;
    private static int captures, remaining, postPreview;
    private static boolean sawStill;
    private static long lastFrame = -1, lastSample;
    private static String cachedPreview = "not sampled";
    private CaptureColorContractProbe() {}

    public static synchronized void install(ClassLoader ignored) {
        if (installed) return;
        try {
            Class<?> entry = Class.forName("local.mio.os4camerabridge.HookEntry", false,
                    CaptureColorContractProbe.class.getClassLoader());
            module = field(entry, "activeCameraModule", int.class);
            camera = field(entry, "activeCameraId", int.class);
            unified = field(entry, "commonApsUnifiedSessionActive", boolean.class);
            portrait = field(entry, "commonApsUnifiedPortraitSession", boolean.class);
            Method build = null;
            for (Method method : entry.getDeclaredMethods()) {
                if (method.getName().equals("buildCommonApsRequestSet")
                        && method.getParameterCount() == 3
                        && method.getParameterTypes()[1] == CaptureRequest.class
                        && List.class.isAssignableFrom(method.getReturnType())) {
                    if (build != null) throw new IllegalStateException("Ambiguous request factory");
                    build = method;
                }
            }
            if (build == null) throw new NoSuchMethodException("buildCommonApsRequestSet");
            XposedBridge.hookMethod(build, new XC_MethodHook() {
                @Override protected void afterHookedMethod(MethodHookParam p) {
                    try {
                        if (p.hasThrowable() || !eligible() || !(p.getResult() instanceof List<?>)) return;
                        List<?> requests = (List<?>) p.getResult();
                        if (requests.isEmpty() || !(requests.get(0) instanceof CaptureRequest)) return;
                        synchronized (CaptureColorContractProbe.class) {
                            if (captures >= 2) return;
                            captures++;
                            remaining = 12;
                            postPreview = 0;
                            sawStill = false;
                            log("capture=" + captures + " before=" + cachedPreview);
                            log("capture=" + captures + " xiaomi=" + request((CaptureRequest) p.args[1]));
                            log("capture=" + captures + " built=" + request((CaptureRequest) requests.get(0)));
                        }
                    } catch (Throwable t) { log("factory read failed: " + t.getClass().getSimpleName()); }
                }
            });
            XposedBridge.hookAllConstructors(TotalCaptureResult.class, new XC_MethodHook() {
                @Override protected void afterHookedMethod(MethodHookParam p) {
                    try {
                        if (p.thisObject instanceof TotalCaptureResult && eligible())
                            result((TotalCaptureResult) p.thisObject);
                    } catch (Throwable ignoredFailure) { /* Never alter the camera callback. */ }
                }
            });
            installed = true;
            log("installed read-only v1; two rear163 captures; bounded metadata logs; no image writes");
        } catch (Throwable t) { log("install rejected: " + t); }
    }

    private static boolean eligible() throws Exception {
        return module.getInt(null) == 163 && camera.getInt(null) == 0
                && unified.getBoolean(null) && !portrait.getBoolean(null);
    }

    private static synchronized void result(TotalCaptureResult result) {
        if (captures >= 2 && remaining == 0) return;
        long frame = result.getFrameNumber();
        if (frame == lastFrame) return;
        CaptureRequest req = result.getRequest();
        if (req == null) return;
        boolean still = Integer.valueOf(CaptureRequest.CONTROL_CAPTURE_INTENT_STILL_CAPTURE)
                .equals(req.get(CaptureRequest.CONTROL_CAPTURE_INTENT));
        long now = SystemClock.elapsedRealtime();
        if (remaining == 0) {
            if (still || now - lastSample < 500) return;
            lastSample = now;
            lastFrame = frame;
            cachedPreview = describe(result, req);
            return;
        }
        lastFrame = frame;
        if (still) sawStill = true;
        if (!still && !sawStill) return;
        if (!still && postPreview++ >= 4) { remaining = 0; return; }
        remaining--;
        log("capture=" + captures + " phase=" + (still ? "still" : "preview") + " " + describe(result, req));
    }

    private static String describe(TotalCaptureResult result, CaptureRequest req) {
        StringBuilder out = new StringBuilder("frame=").append(result.getFrameNumber())
                .append(" monoMs=").append(SystemClock.elapsedRealtime())
                .append(" active=").append(result.get(CaptureResult.LOGICAL_MULTI_CAMERA_ACTIVE_PHYSICAL_ID))
                .append(" req{").append(request(req)).append("} result{");
        int count = 0;
        for (CaptureResult.Key<?> key : result.getKeys()) {
            if (selected(key.getName()) && count++ < 64) {
                try { out.append(key.getName()).append('=').append(value(result.get(key))).append(';'); }
                catch (Throwable ignored) { /* Missing vendor type is not fatal. */ }
            }
        }
        return out.append('}').toString();
    }

    private static String request(CaptureRequest request) {
        if (request == null) return "null";
        StringBuilder out = new StringBuilder();
        int count = 0;
        for (CaptureRequest.Key<?> key : request.getKeys()) {
            if (selected(key.getName()) && count++ < 64) {
                try { out.append(key.getName()).append('=').append(value(request.get(key))).append(';'); }
                catch (Throwable ignored) { /* Read only. */ }
            }
        }
        return out.toString();
    }

    private static boolean selected(String name) {
        if (name.startsWith("android.")) return name.startsWith("android.colorCorrection.")
                || name.startsWith("android.tonemap.") || name.startsWith("android.control.awb")
                || name.startsWith("android.control.ae") || name.equals("android.control.captureIntent")
                || name.equals("android.control.mode") || name.equals("android.control.zoomRatio")
                || name.equals("android.control.postRawSensitivityBoost")
                || name.equals("android.sensor.exposureTime") || name.equals("android.sensor.sensitivity")
                || name.equals("android.sensor.frameDuration") || name.equals("android.lens.focalLength")
                || name.equals("android.edge.mode") || name.equals("android.noiseReduction.mode")
                || name.equals("android.shading.mode");
        String lower = name.toLowerCase(Locale.ROOT);
        return lower.contains("awb") || lower.contains("cct") || lower.contains("adrc")
                || lower.contains("gamma") || lower.contains("tonemap") || lower.contains("saturation")
                || lower.contains("contrast") || lower.contains("color") || lower.contains("lux");
    }

    private static String value(Object value) {
        if (value == null) return "null";
        if (value.getClass().isArray()) {
            int length = Array.getLength(value);
            StringBuilder out = new StringBuilder("[");
            for (int i = 0; i < Math.min(length, 12); i++) {
                if (i != 0) out.append(',');
                out.append(Array.get(value, i));
            }
            return out.append(length > 12 ? ",...len=" + length : "").append(']').toString();
        }
        String text = value.toString();
        return text.length() > 700 ? text.substring(0, 700) + "..." : text;
    }
    private static Field field(Class<?> owner, String name, Class<?> type) throws Exception {
        Field result = owner.getDeclaredField(name);
        if (result.getType() != type) throw new IllegalStateException("Unexpected " + name);
        result.setAccessible(true);
        return result;
    }
    private static void log(String text) { XposedBridge.log("[CaptureColorContract] " + text); }
}
