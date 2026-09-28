package local.mio.os4camerabridge;

import android.app.Application;
import android.os.SystemClock;
import java.io.File;
import java.io.FileOutputStream;
import java.lang.reflect.Method;
import java.util.concurrent.atomic.AtomicBoolean;
import de.robv.android.xposed.XC_MethodHook;
import de.robv.android.xposed.XposedBridge;
import de.robv.android.xposed.XposedHelpers;

/** One paired diagnostic per process. Never modifies image/request/result arguments. */
public final class JpegColorStageProbe {
    private static final String EXTRA = "local.mio.colorStageInput";
    private static final AtomicBoolean CLAIMED = new AtomicBoolean();
    private static boolean installed;
    private JpegColorStageProbe() {}

    public static synchronized void install(ClassLoader ignored) {
        if (installed) return;
        try {
            Class<?> entry = Class.forName("local.mio.os4camerabridge.HookEntry",
                    false, JpegColorStageProbe.class.getClassLoader());
            Method render = entry.getDeclaredMethod("renderFinalJpegEffects",
                    byte[].class, Class.class, Class.class);
            if (render.getReturnType() != byte[].class) throw new IllegalStateException("Wrong renderer");
            XposedBridge.hookMethod(render, new XC_MethodHook(10000) {
                @Override protected void beforeHookedMethod(MethodHookParam p) {
                    byte[] input = (byte[]) p.args[0];
                    if (jpeg(input) && CLAIMED.compareAndSet(false, true)) p.setObjectExtra(EXTRA, input);
                }
                @Override protected void afterHookedMethod(MethodHookParam p) {
                    Object extra = p.getObjectExtra(EXTRA);
                    if (!(extra instanceof byte[])) return;
                    byte[] input = (byte[]) extra;
                    byte[] output = !p.hasThrowable() && p.getResult() instanceof byte[]
                            ? (byte[]) p.getResult() : null;
                    long id = SystemClock.elapsedRealtime();
                    // Existing renderer allocates its output; neither array is mutated.
                    // Finite worker releases both references after two diagnostic writes.
                    new Thread(() -> {
                        try {
                            Application app = (Application) XposedHelpers.callStaticMethod(
                                    XposedHelpers.findClass("android.app.ActivityThread", null),
                                    "currentApplication");
                            if (app == null || !"com.android.camera".equals(app.getPackageName()))
                                throw new IllegalStateException("Wrong diagnostic application");
                            File root = new File(app.getCacheDir(), "color-stage-probe");
                            if (!root.isDirectory() && !root.mkdir()) throw new IllegalStateException("Cannot create diagnostic directory");
                            write(new File(root, id + "_before_effect.jpg"), input);
                            if (jpeg(output)) write(new File(root, id + "_after_effect.jpg"), output);
                            XposedBridge.log("[JpegColorStageProbe] saved id=" + id + " input="
                                    + input.length + " output=" + (output == null ? -1 : output.length)
                                    + " same=" + (input == output) + " diagnosticOnly=true");
                        } catch (Throwable t) {
                            XposedBridge.log("[JpegColorStageProbe] diagnostic failed; photo untouched: " + t);
                        }
                    }, "CameraColorStageProbe").start();
                }
            });
            installed = true;
            XposedBridge.log("[JpegColorStageProbe] installed; one before/after pair in cache; no processing dependency on files");
        } catch (Throwable t) {
            XposedBridge.log("[JpegColorStageProbe] install rejected: " + t);
        }
    }

    private static boolean jpeg(byte[] data) {
        return data != null && data.length > 3 && data.length <= 40 * 1024 * 1024
                && (data[0] & 255) == 255 && (data[1] & 255) == 216;
    }

    private static void write(File file, byte[] data) throws Exception {
        if (!file.createNewFile()) throw new IllegalStateException("Diagnostic file exists");
        try (FileOutputStream stream = new FileOutputStream(file)) { stream.write(data); }
    }
}
