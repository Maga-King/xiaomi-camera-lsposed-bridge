package local.mio.os4camerabridge;

import android.hardware.camera2.CaptureResult;
import android.media.ExifInterface;
import java.io.ByteArrayInputStream;
import java.lang.reflect.Method;
import java.util.ArrayList;
import java.util.List;
import java.util.concurrent.atomic.AtomicInteger;
import de.robv.android.xposed.XC_MethodHook;
import de.robv.android.xposed.XposedBridge;
import de.robv.android.xposed.XposedHelpers;

/** Bounded, read-only audit of the current APK's JPEG and EXIF handoff. */
public final class JpegChainProbe {
    private static final int LIMIT = 24;
    private static final AtomicInteger JPEG_CALLS = new AtomicInteger();
    private static final AtomicInteger WATER_CALLS = new AtomicInteger();
    private static final AtomicInteger EXIF_CALLS = new AtomicInteger();
    private static final ThreadLocal<Object> EXIF_TASK = new ThreadLocal<>();
    private static final String EXTRA = "local.mio.jpegChainProbe";
    private static final String[] TAGS = {"Orientation", "ISOSpeedRatings", "PhotographicSensitivity",
            "ExposureTime", "FNumber", "FocalLength", "FocalLengthIn35mmFilm",
            "ImageWidth", "ImageLength", "PixelXDimension", "PixelYDimension"};
    private static boolean installed;

    private JpegChainProbe() {}

    public static synchronized void install(ClassLoader loader) {
        if (installed) return;
        List<XC_MethodHook.Unhook> hooks = new ArrayList<>();
        try {
            Class<?> task = XposedHelpers.findClass("Rh.r", loader);
            Class<?> water = XposedHelpers.findClass("p7.g", loader);
            Class<?> exif = XposedHelpers.findClass("p7.c", loader);
            Class<?> builder = XposedHelpers.findClass("k7.d$a", loader);
            // Resolve all exact signatures before registering any hook.
            Method jpegMethod = task.getDeclaredMethod("a", int.class, byte[].class);
            Method waterMethod = water.getDeclaredMethod("a", task);
            Method exifMethod = exif.getDeclaredMethod("a", task);
            Method captureMethod = builder.getDeclaredMethod("a", CaptureResult.class);
            Method buildMethod = builder.getDeclaredMethod("c");
            hooks.add(XposedBridge.hookMethod(jpegMethod, new XC_MethodHook(10000) {
                @Override protected void beforeHookedMethod(MethodHookParam p) {
                    if (!Integer.valueOf(0).equals(p.args[0])
                            || JPEG_CALLS.incrementAndGet() > LIMIT) return;
                    p.setObjectExtra(EXTRA, Boolean.TRUE);
                    inspectBytes("reader-in " + identity(p.thisObject), p.args[1]);
                }
                @Override protected void afterHookedMethod(MethodHookParam p) {
                    if (p.getObjectExtra(EXTRA) == null) return;
                    inspectTask("reader-out", p.thisObject, p.hasThrowable());
                }
            }));
            hooks.add(XposedBridge.hookMethod(waterMethod, new XC_MethodHook(10000) {
                @Override protected void beforeHookedMethod(MethodHookParam p) {
                    if (WATER_CALLS.incrementAndGet() > LIMIT) return;
                    p.setObjectExtra(EXTRA, Boolean.TRUE);
                    inspectTask("water-in", p.args[0], false);
                }
                @Override protected void afterHookedMethod(MethodHookParam p) {
                    if (p.getObjectExtra(EXTRA) != null)
                        inspectTask("water-out", p.args[0], p.hasThrowable());
                }
            }));
            hooks.add(XposedBridge.hookMethod(exifMethod, new XC_MethodHook(10000) {
                @Override protected void beforeHookedMethod(MethodHookParam p) {
                    if (EXIF_CALLS.incrementAndGet() > LIMIT) return;
                    // Preserve a possible outer invocation; never leak across saves.
                    p.setObjectExtra(EXTRA, new Object[]{EXIF_TASK.get()});
                    EXIF_TASK.set(p.args[0]);
                    inspectTask("exif-in", p.args[0], false);
                }
                @Override protected void afterHookedMethod(MethodHookParam p) {
                    Object previous = p.getObjectExtra(EXTRA);
                    if (!(previous instanceof Object[])) return;
                    try {
                        inspectTask("exif-out", p.args[0], p.hasThrowable());
                    } finally {
                        Object outer = ((Object[]) previous)[0];
                        if (outer == null) EXIF_TASK.remove(); else EXIF_TASK.set(outer);
                    }
                }
            }));
            hooks.add(XposedBridge.hookMethod(captureMethod, new XC_MethodHook(10000) {
                @Override protected void beforeHookedMethod(MethodHookParam p) {
                    Object current = EXIF_TASK.get();
                    if (current == null) return;
                    try {
                        Object captures = field(current, "f");
                        log("exif-selected " + identity(current)
                                + " selected=" + result(p.args[0])
                                + " taskB=" + result(field(captures, "b"))
                                + " taskC=" + result(field(captures, "c")));
                    } catch (Throwable t) { error("exif-selected", t); }
                }
            }));
            hooks.add(XposedBridge.hookMethod(buildMethod, new XC_MethodHook(10000) {
                @Override protected void afterHookedMethod(MethodHookParam p) {
                    if (EXIF_TASK.get() == null) return;
                    try {
                        Object output = p.getResult();
                        StringBuilder values = new StringBuilder();
                        if (!p.hasThrowable() && output != null) {
                            for (String tag : TAGS) values.append(' ').append(tag)
                                    .append('=').append(XposedHelpers.callMethod(output, "e", tag));
                        }
                        log("exif-built " + identity(EXIF_TASK.get())
                                + " error=" + p.hasThrowable() + values);
                    } catch (Throwable t) { error("exif-built", t); }
                }
            }));
            installed = true;
            log("installed182 audit-v2 hooks=" + hooks.size()
                    + " limit=" + LIMIT + " readOnly=true; no JPEG/request/result writes");
        } catch (Throwable t) {
            for (XC_MethodHook.Unhook hook : hooks) {
                try { hook.unhook(); } catch (Throwable ignored) {}
            }
            error("install rejected", t);
        }
    }

    private static Object field(Object owner, String name) {
        return owner == null ? null : XposedHelpers.getObjectField(owner, name);
    }

    private static String identity(Object task) {
        try {
            Object source = field(task, "a");
            Object auxiliary = field(task, "b");
            return "task=" + System.identityHashCode(task) + " ts=" + field(source, "f")
                    + " module=" + field(auxiliary, "g");
        } catch (Throwable t) { return "task=" + System.identityHashCode(task); }
    }

    private static String result(Object value) {
        if (!(value instanceof CaptureResult)) return value == null ? "null" : "other";
        CaptureResult r = (CaptureResult) value;
        return "{ts=" + r.get(CaptureResult.SENSOR_TIMESTAMP)
                + ",frame=" + r.getFrameNumber()
                + ",iso=" + r.get(CaptureResult.SENSOR_SENSITIVITY)
                + ",exposure=" + r.get(CaptureResult.SENSOR_EXPOSURE_TIME)
                + ",focal=" + r.get(CaptureResult.LENS_FOCAL_LENGTH)
                + ",aperture=" + r.get(CaptureResult.LENS_APERTURE)
                + ",boost=" + r.get(CaptureResult.CONTROL_POST_RAW_SENSITIVITY_BOOST) + "}";
    }

    private static void inspectTask(String stage, Object task, boolean failed) {
        try {
            Object source = field(task, "a");
            Object capture = field(task, "f");
            log(stage + " " + identity(task) + " error=" + failed
                    + " rotation=" + field(source, "c") + "/" + field(source, "d")
                    + " resultB=" + result(field(capture, "b"))
                    + " resultC=" + result(field(capture, "c")));
            inspectBytes(stage + " " + identity(task), field(source, "i"));
        } catch (Throwable t) { error(stage, t); }
    }

    private static void inspectBytes(String stage, Object value) {
        try {
            if (!(value instanceof byte[])) { log(stage + " jpeg=null"); return; }
            byte[] jpeg = (byte[]) value;
            if (jpeg.length < 4 || jpeg[0] != (byte) 0xff || jpeg[1] != (byte) 0xd8) {
                log(stage + " nonJpeg bytes=" + jpeg.length); return;
            }
            ExifInterface exif = new ExifInterface(new ByteArrayInputStream(jpeg));
            StringBuilder values = new StringBuilder();
            for (String tag : TAGS) values.append(' ').append(tag).append('=')
                    .append(exif.getAttribute(tag));
            log(stage + " bytes=" + jpeg.length + values);
        } catch (Throwable t) { error(stage + " metadata", t); }
    }

    private static void log(String message) { XposedBridge.log("[JpegChainProbe] " + message); }
    private static void error(String stage, Throwable t) {
        log(stage + ": " + t.getClass().getSimpleName() + " " + t.getMessage());
    }
}
