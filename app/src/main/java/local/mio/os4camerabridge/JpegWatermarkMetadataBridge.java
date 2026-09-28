package local.mio.os4camerabridge;

import java.io.ByteArrayInputStream;
import java.io.InputStream;
import java.lang.reflect.Constructor;
import java.lang.reflect.Method;
import java.nio.ByteOrder;
import java.util.LinkedHashMap;
import java.util.Map;
import java.util.WeakHashMap;
import java.util.ArrayList;
import java.util.List;
import de.robv.android.xposed.XC_MethodHook;
import de.robv.android.xposed.XposedBridge;
import de.robv.android.xposed.XposedHelpers;

/** Preserve existing shooting EXIF through the verified legacy Bitmap watermark. */
public final class JpegWatermarkMetadataBridge {
    private static final String EXTRA = "local.mio.watermarkShootingMetadata";
    // Values do not refer to keys or retain image buffers. Failed/abandoned tasks
    // can be collected; normal tasks are removed exactly once on EXIF entry.
    private static final Map<Object, Pending> PENDING = new WeakHashMap<>();
    private static boolean installed;

    private JpegWatermarkMetadataBridge() {}

    public static synchronized void install(ClassLoader loader) {
        if (installed) return;
        List<XC_MethodHook.Unhook> hooks = new ArrayList<>();
        try {
            Class<?> taskClass = XposedHelpers.findClass("Rh.r", loader);
            Class<?> waterClass = XposedHelpers.findClass("p7.g", loader);
            Class<?> exifClass = XposedHelpers.findClass("rf.b", loader);
            Class<?> exifTaskClass = XposedHelpers.findClass("p7.c", loader);
            Method waterMethod = waterClass.getDeclaredMethod("a", taskClass);
            Method exifMethod = exifTaskClass.getDeclaredMethod("a", taskClass);
            Method taskExif = taskClass.getDeclaredMethod("e", byte[].class);
            Method read = exifClass.getDeclaredMethod("e", String.class);
            Method rawAttribute = exifClass.getDeclaredMethod("i", String.class);
            Method rawString = rawAttribute.getReturnType().getDeclaredMethod("l", ByteOrder.class);
            Method write = exifClass.getDeclaredMethod("R", String.class, String.class);
            Constructor<?> parse = exifClass.getConstructor(InputStream.class);
            if (taskExif.getReturnType() != exifClass || read.getReturnType() != String.class
                    || write.getReturnType() != void.class)
                throw new IllegalStateException("Unexpected Xiaomi EXIF contract");
            hooks.add(XposedBridge.hookMethod(waterMethod, new XC_MethodHook(9000) {
                @Override protected void beforeHookedMethod(MethodHookParam p) {
                    try {
                        Object task = p.args[0];
                        Object auxiliary = field(task, "b");
                        int module = XposedHelpers.getIntField(auxiliary, "g");
                        // Fresh Rh.a.toString/constructor identify d as isFrontCamera.
                        // ExifData.cameraIdFrontOrBack is still its default -1 here.
                        int facing = XposedHelpers.getBooleanField(auxiliary, "d") ? 1 : 0;
                        int shotType = XposedHelpers.getIntField(auxiliary, "f");
                        boolean watermark = XposedHelpers.getBooleanField(field(task, "l"), "e");
                        if (!JpegWatermarkMetadataPolicy.eligible(module, facing, shotType, watermark)) {
                            if (module == 163 || module == 167)
                                XposedBridge.log("[WatermarkMetadata] gate module=" + module
                                        + " front=" + (facing == 1) + " type=" + shotType + " water=" + watermark);
                            return;
                        }
                        Object source = field(task, "a");
                        byte[] jpeg = (byte[]) field(source, "i");
                        if (JpegWatermarkMetadataPolicy.dimensions(jpeg) == null) {
                            XposedBridge.log("[WatermarkMetadata] invalid input SOF module=" + module);
                            return;
                        }
                        Object inputExif = parse.newInstance(new ByteArrayInputStream(jpeg));
                        Map<String, String> values = new LinkedHashMap<>();
                        for (String tag : JpegWatermarkMetadataPolicy.SHOOTING_TAGS) {
                            // e() formats special rationals for display. l(ByteOrder)
                            // returns their original numerator/denominator instead.
                            Object attribute = rawAttribute.invoke(inputExif, tag);
                            String value = attribute == null ? null : (String) rawString.invoke(
                                    attribute, XposedHelpers.getObjectField(inputExif, "m"));
                            if (JpegWatermarkMetadataPolicy.needsRestore(value, null)) values.put(tag, value);
                        }
                        p.setObjectExtra(EXTRA, new Snapshot(task,
                                XposedHelpers.getLongField(source, "f"), jpeg, values, module));
                        XposedBridge.log("[WatermarkMetadata] snapshot module=" + module
                                + " tags=" + values.size() + " rawExposure=" + values.get("ExposureTime"));
                    } catch (Throwable t) { report("input retained", t); }
                }

                @Override protected void afterHookedMethod(MethodHookParam p) {
                    Object extra = p.getObjectExtra(EXTRA);
                    if (!(extra instanceof Snapshot) || p.hasThrowable()) return;
                    Snapshot snapshot = (Snapshot) extra;
                    try {
                        if (p.args[0] != snapshot.task) return;
                        Object source = field(snapshot.task, "a");
                        if (XposedHelpers.getLongField(source, "f") != snapshot.timestamp) return;
                        byte[] jpeg = (byte[]) field(source, "i");
                        if (jpeg == snapshot.jpeg) return; // No Bitmap output replacement.
                        if (JpegWatermarkMetadataPolicy.dimensions(jpeg) == null) return;
                        synchronized (PENDING) {
                            if (PENDING.size() >= 64) {
                                XposedBridge.log("[WatermarkMetadata] pending capacity reached; not retained");
                                return;
                            }
                            PENDING.put(snapshot.task, new Pending(snapshot.timestamp,
                                    snapshot.values, snapshot.module));
                        }
                    } catch (Throwable t) { report("water handoff failed", t); }
                }
            }));
            hooks.add(XposedBridge.hookMethod(exifMethod, new XC_MethodHook(9000) {
                @Override protected void beforeHookedMethod(MethodHookParam p) {
                    Object task = p.args[0];
                    Pending pending;
                    synchronized (PENDING) { pending = PENDING.remove(task); }
                    if (pending == null) return;
                    try {
                        Object source = field(task, "a");
                        if (XposedHelpers.getLongField(source, "f") != pending.timestamp) return;
                        byte[] jpeg = (byte[]) field(source, "i");
                        int[] size = JpegWatermarkMetadataPolicy.dimensions(jpeg);
                        if (size == null) return;
                        // r7.b.a calls Rh.r.O and resetExif even with hasEffect=false.
                        // Only now is this the final cached object p7.c will serialize.
                        Object outputExif = taskExif.invoke(task, (Object) jpeg);
                        int restored = 0;
                        for (Map.Entry<String, String> entry : pending.values.entrySet()) {
                            String current = (String) read.invoke(outputExif, entry.getKey());
                            if (JpegWatermarkMetadataPolicy.needsRestore(entry.getValue(), current)) {
                                write.invoke(outputExif, entry.getKey(), entry.getValue());
                                if (read.invoke(outputExif, entry.getKey()) != null) restored++;
                                else XposedBridge.log("[WatermarkMetadata] writer rejected " + entry.getKey());
                            }
                        }
                        String[] dimensionTags = {"PixelXDimension", "PixelYDimension"};
                        for (int axis = 0; axis < dimensionTags.length; axis++) {
                            String current = (String) read.invoke(outputExif, dimensionTags[axis]);
                            String actual = Integer.toString(size[axis]);
                            if (JpegWatermarkMetadataPolicy.needsRestore(actual, current)) {
                                write.invoke(outputExif, dimensionTags[axis], actual);
                                if (read.invoke(outputExif, dimensionTags[axis]) != null) restored++;
                            }
                        }
                        XposedBridge.log("[WatermarkMetadata] restored=" + restored
                                + " module=" + pending.module + " ts=" + pending.timestamp
                                + " encoded=" + size[0] + "x" + size[1]
                                + " orientationUnchanged=true cachedExifOnly=true afterEffect=true"
                                + " iso=" + read.invoke(outputExif, "ISOSpeedRatings")
                                + " exposure=" + read.invoke(outputExif, "ExposureTime"));
                        Object exposure = rawAttribute.invoke(outputExif, "ExposureTime");
                        if (exposure != null) XposedBridge.log("[WatermarkMetadata] exposure rational="
                                + rawString.invoke(exposure, XposedHelpers.getObjectField(outputExif, "m"))
                                + " expected=" + pending.values.get("ExposureTime"));
                    } catch (Throwable t) { report("preservation incomplete", t); }
                }
            }));
            installed = true;
            XposedBridge.log("[WatermarkMetadata] installed182 metadata-v5; exact source rationals after Effect; rear Photo/Pro legacy JPEG only");
        } catch (Throwable t) {
            for (XC_MethodHook.Unhook hook : hooks) {
                try { hook.unhook(); } catch (Throwable ignored) {}
            }
            report("install rejected", t);
        }
    }

    private static Object field(Object owner, String name) {
        return XposedHelpers.getObjectField(owner, name);
    }

    private static void report(String stage, Throwable t) {
        XposedBridge.log("[WatermarkMetadata] " + stage + ": " + t);
    }

    private static final class Snapshot {
        final Object task;
        final long timestamp;
        final byte[] jpeg;
        final Map<String, String> values;
        final int module;
        Snapshot(Object task, long timestamp, byte[] jpeg, Map<String, String> values, int module) {
            this.task = task;
            this.timestamp = timestamp;
            this.jpeg = jpeg;
            this.values = values;
            this.module = module;
        }
    }

    private static final class Pending {
        final long timestamp;
        final Map<String, String> values;
        final int module;
        Pending(long timestamp, Map<String, String> values, int module) {
            this.timestamp = timestamp;
            this.values = values;
            this.module = module;
        }
    }
}
