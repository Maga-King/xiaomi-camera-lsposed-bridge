package local.mio.os4camerabridge;

import android.app.Application;
import android.hardware.camera2.CaptureResult;
import android.os.SystemClock;
import java.io.File;
import java.io.FileOutputStream;
import java.lang.reflect.Method;
import java.lang.reflect.Modifier;
import java.nio.charset.StandardCharsets;
import java.util.HashSet;
import java.util.Set;
import java.util.concurrent.ArrayBlockingQueue;
import java.util.concurrent.ThreadPoolExecutor;
import java.util.concurrent.TimeUnit;
import de.robv.android.xposed.XC_MethodHook;
import de.robv.android.xposed.XposedBridge;
import de.robv.android.xposed.XposedHelpers;

/** Optional read-only JPEG boundary samples. No decoder, filter or capture changes. */
public final class JpegQualityBoundaryProbe {
    private static final String EXTRA = "local.mio.jpegQualitySample";
    private static final Set<String> CLAIMED = new HashSet<>();
    private static final ThreadPoolExecutor WRITER = new ThreadPoolExecutor(0, 1,
            5, TimeUnit.SECONDS, new ArrayBlockingQueue<>(2), runnable -> {
                Thread thread = new Thread(runnable, "CameraJpegQualityProbe");
                thread.setPriority(Thread.MIN_PRIORITY);
                return thread;
            });
    private static boolean installed;
    private static Class<?> entry;

    private JpegQualityBoundaryProbe() {}

    public static synchronized void install(ClassLoader loader) {
        if (installed) return;
        try {
            entry = Class.forName("local.mio.os4camerabridge.HookEntry", false,
                    JpegQualityBoundaryProbe.class.getClassLoader());
            // This diagnostic targets the audited APK only; resolve the full signature.
            // Failure skips sampling and never substitutes another app method.
            Class<?> task = XposedHelpers.findClass("Rh.r", loader);
            Method accept = task.getDeclaredMethod("a", int.class, byte[].class);
            if (Modifier.isStatic(accept.getModifiers()) || accept.getReturnType() != void.class)
                throw new IllegalStateException("Unexpected JPEG task signature");
            XposedBridge.hookMethod(accept, new XC_MethodHook(20000) {
                @Override protected void beforeHookedMethod(MethodHookParam p) {
                    try {
                        if (!Integer.valueOf(0).equals(p.args[0]) || !jpeg(p.args[1])) return;
                        int module = XposedHelpers.getStaticIntField(entry, "activeCameraModule");
                        if (module != 167 && module != 256 && module != 163) return;
                        int camera = XposedHelpers.getStaticIntField(entry, "activeCameraId");
                        int legend = module == 256
                                ? XposedHelpers.getStaticIntField(entry, "activeLegendMode") : 0;
                        String key = module + "_" + camera + "_" + legend;
                        synchronized (CLAIMED) {
                            if (CLAIMED.size() >= 6 || !CLAIMED.add(key)) return;
                        }
                        byte[] before = ((byte[]) p.args[1]).clone();
                        p.setObjectExtra(EXTRA, new Sample(key + "_" + SystemClock.elapsedRealtime(),
                                before, taskInfo(p.thisObject)));
                    } catch (Throwable t) { log("reader-before skipped " + t); }
                }
                @Override protected void afterHookedMethod(MethodHookParam p) {
                    Object sample = p.getObjectExtra(EXTRA);
                    if (!(sample instanceof Sample)) return;
                    try {
                        Object source = XposedHelpers.getObjectField(p.thisObject, "a");
                        Object value = XposedHelpers.getObjectField(source, "i");
                        byte[] after = jpeg(value) ? ((byte[]) value).clone() : null;
                        submit((Sample) sample, after,
                                "failed=" + p.hasThrowable() + " " + taskInfo(p.thisObject));
                    } catch (Throwable t) {
                        submit((Sample) sample, null, "after-unavailable=" + t);
                    }
                }
            });
            installed = true;
            log("installed diagnosticOnly=true maxSamples=6 perModeCamera=1 noPixelChanges=true");
        } catch (Throwable t) { log("install skipped " + t); }
    }

    private static boolean jpeg(Object value) {
        if (!(value instanceof byte[])) return false;
        byte[] bytes = (byte[]) value;
        return bytes.length >= 4 && bytes.length <= 32 * 1024 * 1024
                && bytes[0] == (byte) 255 && bytes[1] == (byte) 216;
    }

    private static String taskInfo(Object task) {
        try {
            Object source = XposedHelpers.getObjectField(task, "a");
            Object captures = XposedHelpers.getObjectField(task, "f");
            return "task=" + System.identityHashCode(task)
                    + " timestamp=" + XposedHelpers.getObjectField(source, "f")
                    + " resultB=" + result(XposedHelpers.getObjectField(captures, "b"))
                    + " resultC=" + result(XposedHelpers.getObjectField(captures, "c"));
        } catch (Throwable t) { return "taskMetadataUnavailable=" + t.getClass().getSimpleName(); }
    }

    private static String result(Object value) {
        if (!(value instanceof CaptureResult)) return "none";
        CaptureResult result = (CaptureResult) value;
        return "{ts=" + result.get(CaptureResult.SENSOR_TIMESTAMP)
                + ",frame=" + result.getFrameNumber()
                + ",iso=" + result.get(CaptureResult.SENSOR_SENSITIVITY)
                + ",exposure=" + result.get(CaptureResult.SENSOR_EXPOSURE_TIME)
                + ",focal=" + result.get(CaptureResult.LENS_FOCAL_LENGTH)
                + ",focus=" + result.get(CaptureResult.LENS_FOCUS_DISTANCE)
                + ",nr=" + result.get(CaptureResult.NOISE_REDUCTION_MODE)
                + ",edge=" + result.get(CaptureResult.EDGE_MODE) + "}";
    }

    private static void submit(Sample sample, byte[] after, String details) {
        try {
            WRITER.execute(() -> {
                try {
                    Application app = (Application) XposedHelpers.callStaticMethod(
                            XposedHelpers.findClass("android.app.ActivityThread", null), "currentApplication");
                    if (app == null || !"com.android.camera".equals(app.getPackageName())) return;
                    File directory = new File(app.getCacheDir(), "jpeg-quality-probe");
                    if (!directory.isDirectory() && !directory.mkdir()) throw new IllegalStateException("mkdir failed");
                    write(new File(directory, sample.id + "_reader_before.jpg"), sample.before);
                    if (after != null) write(new File(directory, sample.id + "_reader_after.jpg"), after);
                    write(new File(directory, sample.id + ".txt"),
                            (sample.details + "\n" + details + "\n").getBytes(StandardCharsets.UTF_8));
                    log("saved " + sample.id + " before=" + sample.before.length
                            + " after=" + (after == null ? -1 : after.length));
                } catch (Throwable t) { log("write skipped " + t); }
            });
        } catch (Throwable t) { log("queue skipped " + t.getClass().getSimpleName()); }
    }

    private static void write(File file, byte[] bytes) throws Exception {
        if (!file.createNewFile()) throw new IllegalStateException("Refusing overwrite");
        try (FileOutputStream output = new FileOutputStream(file)) { output.write(bytes); }
    }

    private static void log(String message) { XposedBridge.log("[JpegQualityBoundaryProbe] " + message); }

    private static final class Sample {
        final String id;
        final byte[] before;
        final String details;
        Sample(String id, byte[] before, String details) {
            this.id = id;
            this.before = before;
            this.details = details;
        }
    }
}
