package local.mio.os4camerabridge;

import android.app.Application;
import android.os.Bundle;
import android.os.Looper;
import android.os.ParcelFileDescriptor;
import android.os.SystemClock;
import java.io.*;
import java.lang.reflect.Method;
import java.nio.file.Files;
import java.util.LinkedHashMap;
import java.util.Map;
import de.robv.android.xposed.XC_MethodHook;
import de.robv.android.xposed.XposedBridge;
import de.robv.android.xposed.XposedHelpers;

/** Same-shot post-APS/pre-Xiaomi-effect rendering on Xiaomi's existing image worker. */
public final class LegendaryNativeCaptureBridge {
    private static final Map<Long, Capture> CAPTURES = new LinkedHashMap<>();
    private static final ThreadLocal<Capture> CONTAINER_CAPTURE = new ThreadLocal<>();
    private static Class<?> entry;
    private static Method transplant;
    private static boolean installed;
    private LegendaryNativeCaptureBridge() {}

    public static synchronized void install(ClassLoader loader) {
        if (installed) return;
        LegendaryWatermarkBridge.install(loader);
        try {
            ClassLoader own = LegendaryNativeCaptureBridge.class.getClassLoader();
            entry = Class.forName("local.mio.os4camerabridge.HookEntry", false, own);
            transplant = entry.getDeclaredMethod("transplantAppMetadata", byte[].class, byte[].class);
            transplant.setAccessible(true);
            Method receive = XposedHelpers.findClass("Rh.r", loader).getDeclaredMethod("a", int.class, byte[].class);
            // Existing default-priority hook first substitutes APS JPEG. This runs afterwards,
            // still BEFORE Xiaomi dispatches Effect/Exif/Water/Store stages.
            XposedBridge.hookMethod(receive, new XC_MethodHook(-10000) {
                @Override protected void beforeHookedMethod(MethodHookParam p) {
                    if ((Integer)p.args[0] != 0 || !(p.args[1] instanceof byte[])) return;
                    try {
                        Object source = XposedHelpers.getObjectField(p.thisObject, "a");
                        long timestamp = XposedHelpers.getLongField(source, "f");
                        Capture capture;
                        synchronized (CAPTURES) { prune(); capture = CAPTURES.get(timestamp); }
                        if (capture == null || capture.rendered) return;
                        if (Looper.myLooper() == Looper.getMainLooper()) {
                            log("rejected main-thread render ts=" + timestamp + "; original retained"); return;
                        }
                        byte[] before = (byte[])p.args[1];
                        byte[] after = render(before, capture);
                        p.args[1] = after;
                        capture.rendered = true;
                        log("committed pre-Xiaomi-effect ts=" + timestamp + " mode=" + capture.mode
                                + " bytes=" + before.length + "->" + after.length + " thread=" + Thread.currentThread().getName()
                                + " watermarkPixelsUntouched=true galleryHooks=false");
                    } catch (Throwable failure) { log("local render rejected; clean APS JPEG retained " + failure); }
                }
            });
            try { LegendaryCalibrationBridge.install(); }
            catch(Throwable error) { log("optional matrix binding rejected; native rendering stays independent " + error); }
            try { LegendaryRawPackBridge.install(); }
            catch(Throwable error) { log("RAW loop acceleration unavailable; original packing retained " + error); }
            installed = true;
            log("installed native capture bridge; old capture-side user LUT removed; same-shot main APS only");
        } catch (Throwable failure) { log("install failed " + failure); }
    }

    static void remember(long timestamp, int mode, int lux, int cct, int orientation) {
        boolean gamma = false, matrix = false;
        try {
            try { application().getContentResolver().takePersistableUriPermission(LegendaryProcessingProvider.URI,
                    android.content.Intent.FLAG_GRANT_READ_URI_PERMISSION); } catch(SecurityException ignored) { }
            Bundle settings = application().getContentResolver().call(LegendaryProcessingProvider.URI, "settings", null, null);
            if (settings == null) throw new IOException("settings provider unavailable");
            gamma = settings.getBoolean(LegendaryProcessingProvider.GAMMA, false);
            matrix = settings.getBoolean(LegendaryProcessingProvider.MATRIX, false);
        } catch (Throwable failure) { log("optional settings unavailable; both donor adaptations off " + failure); }
        synchronized (CAPTURES) {
            prune();
            while (CAPTURES.size() >= 4) CAPTURES.remove(CAPTURES.keySet().iterator().next());
            CAPTURES.put(timestamp, new Capture(mode, lux, cct, orientation, gamma, matrix));
        }
    }
    static void beginContainer(long timestamp) {
        synchronized (CAPTURES) { CONTAINER_CAPTURE.set(CAPTURES.remove(timestamp)); }
    }
    static void endContainer() { CONTAINER_CAPTURE.remove(); }
    public static boolean isPhotoApsSource(Object source) {
        try {
            long timestamp=XposedHelpers.getLongField(source,"f");
            synchronized(CAPTURES) { return CAPTURES.containsKey(timestamp); }
        } catch(Throwable ignored) { return false; }
    }
    static boolean matrixEnabledForContainer() {
        Capture capture = CONTAINER_CAPTURE.get();
        return capture != null && capture.mode == 1 && capture.matrix;
    }
    private static Application application() {
        Application app = (Application)XposedHelpers.getStaticObjectField(entry, "xiaomiCameraApplication");
        if (app == null) throw new IllegalStateException("Camera application missing");
        return app;
    }
    private static byte[] render(byte[] source, Capture capture) throws Exception {
        long started=SystemClock.elapsedRealtime();
        if (source.length < 4 || source.length > 32*1024*1024) throw new IOException("Primary size rejected");
        Application app = application();
        File input = File.createTempFile("legend_source_", ".jpg", app.getCacheDir());
        File output = File.createTempFile("legend_rendered_", ".jpg", app.getCacheDir());
        try {
            try (FileOutputStream stream = new FileOutputStream(input)) { stream.write(source); }
            try (ParcelFileDescriptor read = ParcelFileDescriptor.open(input, ParcelFileDescriptor.MODE_READ_ONLY);
                    ParcelFileDescriptor write = ParcelFileDescriptor.open(output, ParcelFileDescriptor.MODE_READ_WRITE | ParcelFileDescriptor.MODE_TRUNCATE)) {
                Bundle request = new Bundle();
                request.putParcelable("input", read); request.putParcelable("output", write);
                request.putInt("mode", capture.mode); request.putInt("lux", capture.lux); request.putInt("cct", capture.cct);
                Bundle response = app.getContentResolver().call(LegendaryProcessingProvider.URI, "render", null, request);
                if (response == null || !response.getBoolean("ok"))
                    throw new IOException(response == null ? "No render reply" : response.getString("error"));
                if (output.length() != response.getLong("bytes") || output.length() < 4 || output.length() > 32*1024*1024)
                    throw new IOException("Incomplete native output");
                byte[] result = Files.readAllBytes(output.toPath());
                byte[] finished=(byte[])transplant.invoke(null, LegendaryJpegColorMetadata.withoutSourceIcc(source), result);
                log("timing mode="+capture.mode+" nativeProvider={"+response.getString("timing")
                        +"} callerTotal="+(SystemClock.elapsedRealtime()-started)+" ms");
                return finished;
            }
        } finally { input.delete(); output.delete(); }
    }
    private static void prune() { CAPTURES.values().removeIf(capture -> SystemClock.elapsedRealtime()-capture.created > 45000); }
    private static void log(String value) { XposedBridge.log("[LegendaryNativeCapture] " + value); }
    private static final class Capture {
        final int mode, lux, cct, orientation;
        final boolean gamma, matrix;
        final long created = SystemClock.elapsedRealtime();
        volatile boolean rendered;
        Capture(int mode, int lux, int cct, int orientation, boolean gamma, boolean matrix) {
            this.mode=mode; this.lux=lux; this.cct=cct; this.orientation=orientation; this.gamma=gamma; this.matrix=matrix;
        }
    }
}
