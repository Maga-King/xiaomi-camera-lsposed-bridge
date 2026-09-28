package local.mio.os4camerabridge;

import android.hardware.camera2.CaptureResult;
import android.hardware.camera2.TotalCaptureResult;
import android.media.Image;
import android.os.SystemClock;
import java.lang.reflect.Method;
import java.util.ArrayList;
import java.util.LinkedHashMap;
import java.util.Map;
import de.robv.android.xposed.XC_MethodHook;
import de.robv.android.xposed.XposedBridge;
import de.robv.android.xposed.XposedHelpers;

/** M3/M9 main-camera JPEG through Photo APS; only M9 retains an unfused RAW attachment. */
public final class LegendaryPhotoCaptureBridge {
    private static Class<?> entry;
    private static Class<?> zoomData;
    private static Method wrap, metadata, shading, basename;
    private static boolean installed;
    private static final Map<Long, Reference> references = new LinkedHashMap<>();

    private LegendaryPhotoCaptureBridge() {}

    public static synchronized void install(ClassLoader loader) {
        if (installed) return;
        ArrayList<XC_MethodHook.Unhook> hooks = new ArrayList<>();
        try {
            ClassLoader own = LegendaryPhotoCaptureBridge.class.getClassLoader();
            entry = Class.forName("local.mio.os4camerabridge.HookEntry", false, own);
            Class<?> container = Class.forName("local.mio.os4camerabridge.LegendM9Container", false, own);
            Class<?> meta = Class.forName("local.mio.os4camerabridge.LegendM9Container$Metadata", false, own);
            zoomData = XposedHelpers.findClass("com.android.camera.data.data.i", loader);
            Method select = XposedHelpers.findClass("B2.c", loader).getDeclaredMethod("c", int.class, int.class, boolean.class);
            if (select.getReturnType() != int.class) throw new IllegalStateException("Camera selector signature");
            Method gate = entry.getDeclaredMethod("isRearClarityModule", int.class);
            Method raw = entry.getDeclaredMethod("supportsLegendRawSensor", int.class);
            Method submit = entry.getDeclaredMethod("submitCommonApsFrames");
            Method tag = entry.getDeclaredMethod("tagLegendaryStoreTask", Object.class, int.class);
            // This is an own exact-v182 callback, not a foreign APK obfuscation guess.
            Class<?> restart = Class.forName("local.mio.os4camerabridge.HookEntry$47", false, own);
            Method restartCallback = restart.getDeclaredMethod("beforeHookedMethod", XC_MethodHook.MethodHookParam.class);
            wrap = accessible(container.getDeclaredMethod("wrap", byte[].class, byte[].class, float[].class, String.class, meta));
            metadata = accessible(entry.getDeclaredMethod("legendMetadata", CaptureResult.class, CaptureResult.class, int.class, int.class));
            shading = accessible(entry.getDeclaredMethod("legendLensShadingMap", CaptureResult.class, CaptureResult.class));
            basename = accessible(entry.getDeclaredMethod("legendTaskBasename", Object.class));
            hooks.add(XposedBridge.hookMethod(select, new XC_MethodHook(10000) {
                @Override protected void afterHookedMethod(MethodHookParam p) {
                    if (!p.hasThrowable() && (Integer)p.args[0] == 0 && (Integer)p.args[1] == 256 && mainSelected()) {
                        Object previous = p.getResult();
                        p.setResult(0);
                        log("main selector " + previous + " -> logical0; no additional RAW stream");
                    }
                }
            }));
            hooks.add(XposedBridge.hookMethod(gate, new XC_MethodHook() {
                @Override protected void afterHookedMethod(MethodHookParam p) {
                    if ((Integer)p.args[0] == 256 && mainSelected()) p.setResult(true);
                }
            }));
            hooks.add(XposedBridge.hookMethod(raw, new XC_MethodHook() {
                @Override protected void beforeHookedMethod(MethodHookParam p) {
                    if ((Integer)p.args[0] == 0 && mainSelected()) p.setResult(false);
                }
            }));
            hooks.add(XposedBridge.hookMethod(restartCallback, new XC_MethodHook() {
                @Override protected void beforeHookedMethod(MethodHookParam p) {
                    if (!active()) return;
                    try {
                        MethodHookParam original = (MethodHookParam)p.args[0];
                        Object view = XposedHelpers.getObjectField(original.thisObject, "j");
                        Object child = XposedHelpers.callMethod(view, "getChildAt", original.args[0]);
                        float ratio = (Float)XposedHelpers.callMethod(child, "getZoomRatio");
                        if (mainRatio(ratio)) p.setResult(null); // Skip old physical restart callback, not Xiaomi's zoom method.
                    } catch (Throwable t) { log("restart check retained " + t); }
                }
            }));
            hooks.add(XposedBridge.hookMethod(submit, new XC_MethodHook() {
                @Override protected void beforeHookedMethod(MethodHookParam p) {
                    if (!active()) return;
                    try { retain(); } catch (Throwable t) { log("reference rejected; APS JPEG continues " + t); }
                }
            }));
            hooks.add(XposedBridge.hookMethod(tag, new XC_MethodHook() {
                @Override protected void beforeHookedMethod(MethodHookParam p) {
                    if ((Integer)p.args[1] != 1) return;
                    try {
                        if (save(p.args[0])) p.setResult(null);
                    } catch (Throwable t) { log("container retained on old tag fallback " + t); }
                }
            }));
            // Reuse the exact Photo session-key repair, opt-in only when this adapter is installed.
            XposedHelpers.setStaticBooleanField(Class.forName("local.mio.os4camerabridge.RearSessionParameterBridge", false, own),
                    "legendaryPhotoEnabled", true);
            installed = true;
            log("installed v3 M3+M9-main PhotoAPS=true nativeJpegRotation=true separateRawOrientation=true unfusedReferenceRAW=M9-only editorChanges=false");
        } catch (Throwable t) {
            for (XC_MethodHook.Unhook hook : hooks) hook.unhook();
            log("install rejected, all delegate hooks removed " + t);
        }
    }

    private static boolean mainRatio(float ratio) { return Float.isFinite(ratio) && ratio >= 1.0f && ratio < 3.0f; }
    private static boolean mainSelected() {
        try {
            int mode = XposedHelpers.getStaticIntField(entry, "activeLegendMode");
            if (mode != 1 && mode != 2) return false;
            float ratio = (Float)XposedHelpers.getStaticObjectField(entry, "pendingLegendPhysicalZoom");
            if (!Float.isFinite(ratio)) ratio = (Float)XposedHelpers.callStaticMethod(zoomData, "N", new Class<?>[]{int.class}, 256);
            return mainRatio(ratio);
        } catch (Throwable t) { return false; }
    }

    private static boolean active() {
        return installed && XposedHelpers.getStaticIntField(entry, "activeCameraModule") == 256
                && (XposedHelpers.getStaticIntField(entry, "activeLegendMode") == 1
                    || XposedHelpers.getStaticIntField(entry, "activeLegendMode") == 2)
                && XposedHelpers.getStaticIntField(entry, "activeCameraId") == 0
                && XposedHelpers.getStaticBooleanField(entry, "commonApsUnifiedSessionActive");
    }

    private static void retain() throws Exception {
        long start = SystemClock.elapsedRealtime();
        Object lock = XposedHelpers.getStaticObjectField(entry, "COMMON_APS_LOCK");
        Reference retained = null;
        synchronized (lock) {
            long identity = XposedHelpers.getStaticLongField(entry, "commonApsIdentity");
            long shutter = XposedHelpers.getStaticLongField(entry, "commonApsShutterTimestamp");
            int mode = XposedHelpers.getStaticIntField(entry, "activeLegendMode");
            float zoom = (Float)XposedHelpers.getStaticObjectField(entry, "commonApsZoomRatio");
            int rawOrientation = XposedHelpers.getStaticIntField(entry, "commonApsOrientation");
            if (identity <= 0 || identity != shutter || !mainRatio(zoom)) return;
            if (rawOrientation != 0 && rawOrientation != 90 && rawOrientation != 180 && rawOrientation != 270)
                throw new IllegalStateException("Invalid capture orientation");
            Map<?,?> frames = (Map<?,?>)XposedHelpers.getStaticObjectField(entry, "COMMON_APS_FRAMES");
            for (Object frame : frames.values()) {
                if (XposedHelpers.getIntField(frame, "index") != 1) continue;
                Image image = (Image)XposedHelpers.getObjectField(frame, "main");
                TotalCaptureResult result = (TotalCaptureResult)XposedHelpers.getObjectField(frame, "result");
                long timestamp = XposedHelpers.getLongField(frame, "timestamp");
                if (image == null || result == null || timestamp != shutter || image.getTimestamp() != timestamp
                        || !Long.valueOf(timestamp).equals(result.get(CaptureResult.SENSOR_TIMESTAMP))
                        || image.getFormat() != 37 || image.getWidth() != 4096 || image.getHeight() != 3072
                        || !"2".equals(result.get(CaptureResult.LOGICAL_MULTI_CAMERA_ACTIVE_PHYSICAL_ID)))
                    throw new IllegalStateException("Main reference timestamp/geometry/lens mismatch");
                Image.Plane[] planes = image.getPlanes();
                if (planes.length != 1) throw new IllegalStateException("RAW10 planes");
                Object captureMetadata = metadata.invoke(null, result, result, rawOrientation, 2);
                LegendaryNativeCaptureBridge.remember(timestamp, mode,
                        XposedHelpers.getIntField(captureMetadata, "luxIndex"),
                        XposedHelpers.getIntField(captureMetadata, "cct"), rawOrientation);
                if (mode == 2) {
                    log("M3 same-shot PhotoAPS reference ts=" + timestamp + " physical=2 extraRAW=false");
                    break;
                }
                float[] lsc = (float[])shading.invoke(null, result, result);
                byte[] raw = PackedRaw10Copy.copy(planes[0].getBuffer(), 4096, 3072, planes[0].getRowStride());
                retained = new Reference(timestamp, raw, result, lsc, rawOrientation);
                break;
            }
        }
        if (retained == null) return;
        synchronized (references) {
            prune();
            while (references.size() >= 2) references.remove(references.keySet().iterator().next());
            references.put(retained.timestamp, retained);
        }
        log("retained ts=" + retained.timestamp + " bytes=" + retained.raw.length + " iso="
                + retained.result.get(CaptureResult.SENSOR_SENSITIVITY) + " copyMs=" + (SystemClock.elapsedRealtime()-start)
                + " sourceIndex=1 fusedRAW=false");
    }

    private static boolean save(Object task) throws Exception {
        Object source = XposedHelpers.getObjectField(task, "a");
        long timestamp = XposedHelpers.getLongField(source, "f");
        Reference reference;
        synchronized (references) { prune(); reference = references.remove(timestamp); }
        if (reference == null) return false;
        byte[] jpeg = (byte[])XposedHelpers.getObjectField(source, "i");
        // APS rotates JPEG pixels; the retained Bayer plane has NOT been rotated.
        // source.c is JPEG's remaining rotation (usually zero), not RAW's capture orientation.
        int jpegTaskOrientation = XposedHelpers.getIntField(source, "c");
        Object meta = metadata.invoke(null, reference.result, reference.result, reference.rawOrientation, 2);
        String name = (String)basename.invoke(null, task);
        byte[] encoded;
        LegendaryNativeCaptureBridge.beginContainer(timestamp);
        try { encoded = (byte[])wrap.invoke(null, jpeg, reference.raw, reference.lsc, name, meta); }
        finally { LegendaryNativeCaptureBridge.endContainer(); }
        XposedHelpers.setObjectField(source, "i", encoded);
        log("committed basename=" + name + " ts=" + timestamp + " primary=" + jpeg.length + " total=" + encoded.length
                + " jpegTaskOrientation=" + jpegTaskOrientation + " rawOrientation=" + reference.rawOrientation
                + " jpeg=PhotoAPS referenceRAW=unfused sameShot=true");
        return true;
    }

    private static void prune() { references.values().removeIf(r -> SystemClock.elapsedRealtime() - r.created > 30000); }
    private static Method accessible(Method method) { method.setAccessible(true); return method; }
    private static void log(String value) { XposedBridge.log("[LegendaryPhotoCapture] " + value); }
    private static final class Reference {
        final long timestamp, created = SystemClock.elapsedRealtime();
        final byte[] raw;
        final TotalCaptureResult result;
        final float[] lsc;
        final int rawOrientation;
        Reference(long ts, byte[] raw, TotalCaptureResult result, float[] lsc, int rawOrientation) {
            this.timestamp=ts; this.raw=raw; this.result=result; this.lsc=lsc; this.rawOrientation=rawOrientation;
        }
    }
}
