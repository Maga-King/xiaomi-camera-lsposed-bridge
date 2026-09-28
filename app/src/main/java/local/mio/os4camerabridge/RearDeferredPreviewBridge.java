package local.mio.os4camerabridge;

import android.hardware.camera2.params.OutputConfiguration;
import android.view.Surface;
import java.lang.reflect.Field;
import java.lang.reflect.Method;
import java.util.List;
import de.robv.android.xposed.XC_MethodHook;
import de.robv.android.xposed.XposedBridge;

/** Keep Xiaomi's real deferred output; bind only after framework finalization succeeds. */
public final class RearDeferredPreviewBridge {
    private static volatile boolean installed;
    private static Field generationField, sessionField, activeField, previewField, moduleField;
    private static Object sessionLock;
    private static Method isDeferred;
    // Guarded by HookEntry's existing session-generation lock.
    private static OutputConfiguration pendingOutput;
    private static int pendingGeneration = -1;

    private RearDeferredPreviewBridge() {}

    public static synchronized void install(ClassLoader ignored) {
        if (installed) return;
        try {
            Class<?> entry = Class.forName("local.mio.os4camerabridge.HookEntry", false,
                    RearDeferredPreviewBridge.class.getClassLoader());
            generationField = field(entry, "commonApsUnifiedSessionGeneration", int.class);
            moduleField = field(entry, "activeCameraModule", int.class);
            sessionField = field(entry, "commonApsUnifiedSession", android.hardware.camera2.CameraCaptureSession.class);
            activeField = field(entry, "commonApsUnifiedSessionActive", boolean.class);
            previewField = field(entry, "commonApsUnifiedXiaomiPreviewSurface", Surface.class);
            sessionLock = field(entry, "COMMON_APS_UNIFIED_SESSION_LOCK", Object.class).get(null);
            isDeferred = OutputConfiguration.class.getDeclaredMethod("isDeferredConfiguration");
            isDeferred.setAccessible(true);
            Class<?> implementation = Class.forName("android.hardware.camera2.impl.CameraCaptureSessionImpl");
            Method finalizeOutputs = implementation.getDeclaredMethod("finalizeOutputConfigurations", List.class);
            XposedBridge.hookMethod(finalizeOutputs, new XC_MethodHook() {
                @Override protected void afterHookedMethod(MethodHookParam p) throws Throwable {
                    synchronized (sessionLock) {
                        if (pendingOutput == null || pendingGeneration != generationField.getInt(null)
                                || p.thisObject != sessionField.get(null) || !activeField.getBoolean(null)) return;
                        boolean included = false;
                        for (Object output : (List<?>) p.args[0]) if (output == pendingOutput) included = true;
                        if (!included) return;
                        if (p.hasThrowable()) {
                            XposedBridge.log("[RearDeferredPreview] framework finalize failed; not bound: " + p.getThrowable());
                            return;
                        }
                        Surface surface = pendingOutput.getSurface();
                        if (surface == null || !surface.isValid()) {
                            XposedBridge.log("[RearDeferredPreview] finalize returned without a valid preview; not bound");
                            return;
                        }
                        previewField.set(null, surface);
                        XposedBridge.log("[RearDeferredPreview] finalized real Xiaomi Surface generation=" + pendingGeneration);
                        pendingOutput = null;
                        pendingGeneration = -1;
                    }
                }
            });
            installed = true;
            XposedBridge.log("[RearDeferredPreview] installed v1; same output identity, generation and session required");
        } catch (Throwable t) {
            XposedBridge.log("[RearDeferredPreview] install rejected: " + t);
        }
    }

    public static Surface prepare(OutputConfiguration output, int generation) throws Exception {
        Surface surface = output.getSurface();
        if (!installed) {
            if (surface == null) throw new IllegalStateException("Deferred preview bridge unavailable");
            return surface;
        }
        synchronized (sessionLock) {
            if (generation != generationField.getInt(null)) throw new IllegalStateException("Stale preview generation");
            pendingOutput = null;
            pendingGeneration = -1;
            if (surface != null) return surface;
            if (moduleField.getInt(null) != 163 || !Boolean.TRUE.equals(isDeferred.invoke(output)))
                throw new IllegalStateException("Missing preview is not ordinary Photo deferred output");
            pendingOutput = output;
            pendingGeneration = generation;
            XposedBridge.log("[RearDeferredPreview] retaining Xiaomi deferred output generation=" + generation);
            return null;
        }
    }

    private static Field field(Class<?> owner, String name, Class<?> type) throws Exception {
        Field value = owner.getDeclaredField(name);
        if (value.getType() != type) throw new IllegalStateException("Unexpected field type: " + name);
        value.setAccessible(true);
        return value;
    }
}
