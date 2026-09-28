package local.mio.os4camerabridge;

import android.app.Application;
import android.content.Context;
import android.hardware.camera2.CameraCaptureSession;
import android.hardware.camera2.CameraCharacteristics;
import android.hardware.camera2.CameraManager;
import android.hardware.camera2.CaptureRequest;
import android.util.Range;
import java.lang.reflect.Field;
import java.lang.reflect.Method;
import java.util.concurrent.atomic.AtomicInteger;
import de.robv.android.xposed.XC_MethodHook;
import de.robv.android.xposed.XposedBridge;
import de.robv.android.xposed.XposedHelpers;

/** Bounded main-1x motion-preview experiment on the persistent APS session. */
public final class RearMotionPreviewBridge {
    private static final Range<Integer> MOTION_FPS = Range.create(60, 60);
    private static final ThreadLocal<Boolean> PREVIEW_SCOPE = new ThreadLocal<>();
    private static final AtomicInteger LOGS = new AtomicInteger();
    private static boolean installed;
    private static Range<Integer> lastPreviewFps;
    private static int lastGeneration = -1;
    private RearMotionPreviewBridge() {}

    public static synchronized void install(ClassLoader cameraLoader) {
        if (installed) return;
        try {
            Class<?> entry = Class.forName("local.mio.os4camerabridge.HookEntry", false,
                    RearMotionPreviewBridge.class.getClassLoader());
            Field active = field(entry, "commonApsUnifiedSessionActive");
            Field module = field(entry, "activeCameraModule");
            Field camera = field(entry, "activeCameraId");
            Field portrait = field(entry, "commonApsUnifiedPortraitSession");
            Field generation = field(entry, "commonApsUnifiedSessionGeneration");
            Field currentSession = field(entry, "commonApsUnifiedSession");
            Object lock = field(entry, "COMMON_APS_UNIFIED_SESSION_LOCK").get(null);
            Class<?> data = XposedHelpers.findClass("g2.a", cameraLoader);
            Class<?> component = XposedHelpers.findClass("r2.G", cameraLoader);
            Method augment = entry.getDeclaredMethod("augmentUnifiedApsRepeatingRequest", Object.class, CaptureRequest.class);
            Method route = entry.getDeclaredMethod("applyUnifiedOplusLensRoute", CaptureRequest.Builder.class, CaptureRequest.class, boolean.class);
            Class<?> decision = Class.forName(entry.getName() + "$CommonApsDecision", false, entry.getClassLoader());
            Method apply = entry.getDeclaredMethod("applyCommonApsRequestTags", CaptureRequest.Builder.class, int.class, decision);

            XposedBridge.hookMethod(augment, new XC_MethodHook() {
                @Override protected void beforeHookedMethod(MethodHookParam p) {
                    PREVIEW_SCOPE.remove();
                    try {
                        synchronized (lock) {
                            if (!eligible(active, module, camera, portrait)
                                    || p.args[0] != currentSession.get(null) || !(p.args[1] instanceof CaptureRequest)) return;
                            CaptureRequest request = (CaptureRequest) p.args[1];
                            Float zoom = request.get(CaptureRequest.CONTROL_ZOOM_RATIO);
                            // Validate 1x first; do not change UW/tele routes in this experiment.
                            if (zoom == null || !Float.isFinite(zoom) || Math.abs(zoom - 1f) > 0.01f) return;
                            Object repository = XposedHelpers.callStaticMethod(data, "a");
                            Object motion = XposedHelpers.callMethod(repository, "x", component);
                            boolean on = Boolean.TRUE.equals(XposedHelpers.callMethod(motion, "isSwitchOn", 163));
                            boolean supported = supports60();
                            PREVIEW_SCOPE.set(on && supported);
                            log("state=" + on + " supported60=" + supported + " generation=" + generation.getInt(null)
                                    + " original=" + request.get(CaptureRequest.CONTROL_AE_TARGET_FPS_RANGE));
                        }
                    } catch (Throwable t) { PREVIEW_SCOPE.remove(); log("state read rejected: " + t); }
                }
                @Override protected void afterHookedMethod(MethodHookParam p) {
                    try {
                        synchronized (lock) {
                            if (PREVIEW_SCOPE.get() != null && !p.hasThrowable() && p.getResult() instanceof CaptureRequest
                                    && eligible(active, module, camera, portrait) && p.args[0] == currentSession.get(null)) {
                                lastPreviewFps = ((CaptureRequest) p.getResult()).get(CaptureRequest.CONTROL_AE_TARGET_FPS_RANGE);
                                lastGeneration = generation.getInt(null);
                                log("preview built=" + lastPreviewFps + " generation=" + lastGeneration);
                            } else { lastPreviewFps = null; lastGeneration = -1; }
                        }
                    } catch (Throwable t) { log("preview observation rejected: " + t); }
                    finally { PREVIEW_SCOPE.remove(); }
                }
            });
            XposedBridge.hookMethod(route, new XC_MethodHook() {
                @Override protected void afterHookedMethod(MethodHookParam p) {
                    if (p.hasThrowable() || !Boolean.TRUE.equals(PREVIEW_SCOPE.get())) return;
                    try {
                        ((CaptureRequest.Builder) p.args[0]).set(CaptureRequest.CONTROL_AE_TARGET_FPS_RANGE, MOTION_FPS);
                    } catch (Throwable t) { log("preview FPS write rejected: " + t); }
                }
            });
            XposedBridge.hookMethod(apply, new XC_MethodHook() {
                @Override protected void afterHookedMethod(MethodHookParam p) {
                    if (p.hasThrowable() || !Boolean.TRUE.equals(p.getResult())) return;
                    try {
                        synchronized (lock) {
                            if (!eligible(active, module, camera, portrait) || lastPreviewFps == null
                                    || lastGeneration != generation.getInt(null) || !(currentSession.get(null) instanceof CameraCaptureSession)) return;
                            CaptureRequest.Builder builder = (CaptureRequest.Builder) p.args[0];
                            Float zoom = builder.get(CaptureRequest.CONTROL_ZOOM_RATIO);
                            if (zoom == null || Math.abs(zoom - 1f) > 0.01f) return;
                            Range<Integer> before = builder.get(CaptureRequest.CONTROL_AE_TARGET_FPS_RANGE);
                            if (!lastPreviewFps.equals(before)) {
                                builder.set(CaptureRequest.CONTROL_AE_TARGET_FPS_RANGE, lastPreviewFps);
                                log("still frame=" + p.args[1] + " FPS=" + before + " -> " + lastPreviewFps);
                            }
                        }
                    } catch (Throwable t) { log("still FPS alignment rejected: " + t); }
                }
            });
            installed = true;
            log("installed v1: only rear163 logical0 zoom1; no frame-count/algorithm/stream changes");
        } catch (Throwable t) { XposedBridge.log("[RearMotionPreview] install rejected: " + t); }
    }

    private static boolean supports60() throws Exception {
        Application app = (Application) XposedHelpers.callStaticMethod(
                Class.forName("android.app.ActivityThread"), "currentApplication");
        if (app == null) return false;
        CameraManager manager = (CameraManager) app.getSystemService(Context.CAMERA_SERVICE);
        Range<Integer>[] ranges = manager.getCameraCharacteristics("0").get(CameraCharacteristics.CONTROL_AE_AVAILABLE_TARGET_FPS_RANGES);
        if (ranges != null) for (Range<Integer> range : ranges) if (MOTION_FPS.equals(range)) return true;
        return false;
    }
    private static boolean eligible(Field active, Field module, Field camera, Field portrait) throws Exception {
        return active.getBoolean(null) && module.getInt(null) == 163 && camera.getInt(null) == 0 && !portrait.getBoolean(null);
    }
    private static Field field(Class<?> owner, String name) throws Exception {
        Field result = owner.getDeclaredField(name); result.setAccessible(true); return result;
    }
    private static void log(String message) {
        if (LOGS.getAndIncrement() < 100) XposedBridge.log("[RearMotionPreview] " + message);
    }
}
