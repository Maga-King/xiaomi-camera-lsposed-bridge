package local.mio.os4camerabridge;

import android.hardware.camera2.CaptureRequest;
import java.lang.reflect.Field;
import java.lang.reflect.Method;
import java.util.Arrays;
import java.util.concurrent.atomic.AtomicInteger;
import de.robv.android.xposed.XC_MethodHook;
import de.robv.android.xposed.XposedBridge;

/** Prevent captured stock still lux from changing an already configured session. */
public final class RearSessionParameterBridge {
    private static boolean installed;
    private static volatile boolean legendaryPhotoEnabled;
    private static final AtomicInteger LOGS = new AtomicInteger();
    private static final String LUX = "com.oplus.light.sensor.lux";
    private static final String INSENSOR = "org.codeaurora.qcamera3.sessionParameters.EnableInsensorZoom";
    private static volatile CaptureRequest latestPreview;
    private static volatile int previewGeneration = -1;
    private RearSessionParameterBridge() {}

    public static synchronized void install(ClassLoader ignored) {
        if (installed) return;
        try {
            ClassLoader loader = RearSessionParameterBridge.class.getClassLoader();
            Class<?> entry = Class.forName("local.mio.os4camerabridge.HookEntry", false, loader);
            Class<?> decision = Class.forName("local.mio.os4camerabridge.HookEntry$CommonApsDecision", false, loader);
            Field active = field(entry, "commonApsUnifiedSessionActive", boolean.class);
            Field module = field(entry, "activeCameraModule", int.class);
            Field camera = field(entry, "activeCameraId", int.class);
            Field portrait = field(entry, "commonApsUnifiedPortraitSession", boolean.class);
            Field parameters = field(entry, "commonApsUnifiedSessionParameters", CaptureRequest.class);
            Field generation = field(entry, "commonApsUnifiedSessionGeneration", int.class);
            Field currentSession = field(entry, "commonApsUnifiedSession", android.hardware.camera2.CameraCaptureSession.class);
            Object lock = field(entry, "COMMON_APS_UNIFIED_SESSION_LOCK", Object.class).get(null);
            Method augment = entry.getDeclaredMethod("augmentUnifiedApsRepeatingRequest", Object.class, CaptureRequest.class);
            XposedBridge.hookMethod(augment, new XC_MethodHook() {
                @Override protected void afterHookedMethod(MethodHookParam p) throws Throwable {
                    if (p.hasThrowable() || !(p.getResult() instanceof CaptureRequest)) return;
                    synchronized (lock) {
                        if (!active.getBoolean(null) || !supportedModule(module.getInt(null)) || camera.getInt(null) != 0
                                || portrait.getBoolean(null) || p.args[0] != currentSession.get(null)) return;
                        latestPreview = (CaptureRequest) p.getResult();
                        previewGeneration = generation.getInt(null);
                    }
                }
            });
            Method apply = entry.getDeclaredMethod("applyCommonApsRequestTags", CaptureRequest.Builder.class, int.class, decision);
            if (apply.getReturnType() != boolean.class) throw new IllegalStateException("Wrong tag-writer signature");
            XposedBridge.hookMethod(apply, new XC_MethodHook() {
                @Override @SuppressWarnings({"rawtypes", "unchecked"})
                protected void afterHookedMethod(MethodHookParam p) {
                    if (p.hasThrowable() || !Boolean.TRUE.equals(p.getResult())) return;
                    try {
                        synchronized (lock) {
                            if (!active.getBoolean(null) || !supportedModule(module.getInt(null))
                                    || camera.getInt(null) != 0 || portrait.getBoolean(null)) return;
                            CaptureRequest session = (CaptureRequest) parameters.get(null);
                            if (session == null) throw new IllegalStateException("Session parameters missing");
                            CaptureRequest.Builder builder = (CaptureRequest.Builder) p.args[0];
                            for (String name : new String[]{LUX, INSENSOR}) {
                                CaptureRequest reference = session;
                                if (INSENSOR.equals(name) && latestPreview != null
                                        && previewGeneration == generation.getInt(null)) reference = latestPreview;
                                CaptureRequest.Key key = null;
                                for (CaptureRequest.Key<?> candidate : reference.getKeys())
                                    if (name.equals(candidate.getName())) { key = candidate; break; }
                                if (key == null) throw new IllegalStateException("Reference has no key: " + name);
                                Object desired = reference.get(key);
                                if (!valid(desired)) throw new IllegalStateException("Invalid value: " + name);
                                Object before = builder.get(key);
                                if (!equal(before, desired)) {
                                    Object copy = desired instanceof float[] ? ((float[]) desired).clone()
                                            : desired instanceof int[] ? ((int[]) desired).clone() : desired;
                                    builder.set(key, copy);
                                    if (!equal(builder.get(key), desired)) throw new IllegalStateException("Write did not stick: " + name);
                                    if (LOGS.getAndIncrement() < 48) XposedBridge.log("[RearSessionParameter] frame=" + p.args[1]
                                            + " " + name + " " + display(before) + " -> " + display(desired)
                                            + "; reference=" + (reference == session ? "session" : "live-preview"));
                                }
                            }
                        }
                    } catch (Throwable t) {
                        XposedBridge.log("[RearSessionParameter] alignment failed: " + t);
                    }
                }
            });
            installed = true;
            XposedBridge.log("[RearSessionParameter] installed v2; lux/session and insensor/live-preview retained, no forced zoom value");
        } catch (Throwable t) { XposedBridge.log("[RearSessionParameter] install rejected: " + t); }
    }
    private static boolean supportedModule(int module) {
        return module == 163 || legendaryPhotoEnabled && module == 256;
    }
    private static boolean valid(Object value) {
        return value instanceof Float && Float.isFinite((Float) value)
                || value instanceof float[] && ((float[]) value).length == 1 && Float.isFinite(((float[]) value)[0])
                || value instanceof Integer || value instanceof int[] && ((int[]) value).length == 1;
    }
    private static boolean equal(Object left, Object right) {
        if (left instanceof float[] && right instanceof float[]) return Arrays.equals((float[]) left, (float[]) right);
        if (left instanceof int[] && right instanceof int[]) return Arrays.equals((int[]) left, (int[]) right);
        return left != null && left.equals(right);
    }
    private static String display(Object value) { return value instanceof float[] ? Arrays.toString((float[]) value)
            : value instanceof int[] ? Arrays.toString((int[]) value) : String.valueOf(value); }
    private static Field field(Class<?> owner, String name, Class<?> type) throws Exception {
        Field value = owner.getDeclaredField(name);
        if (value.getType() != type) throw new IllegalStateException("Unexpected field type: " + name);
        value.setAccessible(true);
        return value;
    }
}
