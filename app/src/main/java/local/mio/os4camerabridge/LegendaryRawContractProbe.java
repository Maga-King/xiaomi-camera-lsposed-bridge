package local.mio.os4camerabridge;

import android.app.Application;
import android.hardware.camera2.CameraCharacteristics;
import android.hardware.camera2.CaptureResult;
import android.hardware.camera2.TotalCaptureResult;
import android.media.Image;
import java.io.File;
import java.io.FileOutputStream;
import java.lang.reflect.Array;
import java.nio.charset.StandardCharsets;
import java.util.Map;
import java.util.concurrent.atomic.AtomicBoolean;
import de.robv.android.xposed.XposedBridge;
import de.robv.android.xposed.XposedHelpers;

/** Temporary r10 read-only probe: one verified M9 main/DOL pair per Camera process.
 * This never changes requests, input buffers, metadata or the cloud attachment.
 * Remove the call after the RAW/gain contract has been measured.
 */
public final class LegendaryRawContractProbe {
    private static final AtomicBoolean claimed = new AtomicBoolean();
    private LegendaryRawContractProbe() {}

    public static void capture(Class<?> entry, Object frame, byte[] mainCopy, float[] lsc) {
        if (!claimed.compareAndSet(false, true)) return;
        try {
            TotalCaptureResult result = (TotalCaptureResult) XposedHelpers.getObjectField(frame, "result");
            Image dol = (Image) XposedHelpers.getObjectField(frame, "dol");
            long timestamp = XposedHelpers.getLongField(frame, "timestamp");
            if (result == null || dol == null || dol.getFormat() != 37
                    || dol.getWidth() != 4096 || dol.getHeight() != 3072
                    || dol.getTimestamp() != timestamp
                    || !Long.valueOf(timestamp).equals(result.get(CaptureResult.SENSOR_TIMESTAMP))) {
                throw new IllegalStateException("DOL/result identity or geometry mismatch");
            }
            Image.Plane[] planes = dol.getPlanes();
            if (planes.length != 1) throw new IllegalStateException("DOL plane count");
            byte[] dolCopy = PackedRaw10Copy.copy(planes[0].getBuffer(), 4096, 3072, planes[0].getRowStride());
            StringBuilder report = new StringBuilder("diagnosticOnly=true mainRawBeforePacking=true DOLsameShot=true\n");
            report.append("timestamp=").append(timestamp).append(" frame=").append(result.getFrameNumber())
                    .append(" dolRowStride=").append(planes[0].getRowStride()).append('\n');
            for (CaptureResult.Key<?> key : result.getKeys()) {
                try { report.append(key.getName()).append('=').append(value(result.get(key))).append('\n'); }
                catch (Throwable error) { report.append(key.getName()).append("=<unreadable>").append('\n'); }
            }
            report.append("sameFrameLsc=").append(value(lsc)).append('\n');
            Map<?,?> chars = (Map<?,?>) XposedHelpers.getStaticObjectField(entry, "CAMERA_CHARACTERISTICS");
            for (String id : new String[]{"0", "2"}) {
                CameraCharacteristics c = (CameraCharacteristics) chars.get(id);
                if (c == null) continue;
                for (CameraCharacteristics.Key<?> key : c.getKeys()) {
                    String name = key.getName();
                    if (!name.startsWith("android.sensor.") && !name.startsWith("android.colorCorrection.")
                            && !name.startsWith("android.lens.")) continue;
                    try { report.append("characteristics[").append(id).append("].").append(name)
                            .append('=').append(value(c.get(key))).append('\n'); }
                    catch (Throwable ignored) {}
                }
            }
            final String details = report.toString();
            Thread writer = new Thread(() -> {
                try {
                    Application app = (Application) XposedHelpers.callStaticMethod(
                            XposedHelpers.findClass("android.app.ActivityThread", null), "currentApplication");
                    if (app == null || !"com.android.camera".equals(app.getPackageName())) return;
                    File dir = new File(app.getCacheDir(), "legend-cloud-contract-r10");
                    if (!dir.isDirectory() && !dir.mkdir()) throw new IllegalStateException("mkdir");
                    write(new File(dir, timestamp+"-main.raw10"), mainCopy);
                    write(new File(dir, timestamp+"-dol.raw10"), dolCopy);
                    write(new File(dir, timestamp+"-metadata.txt"), details.getBytes(StandardCharsets.UTF_8));
                    XposedBridge.log("[LegendaryRawContractProbe] saved same-shot main+DOL ts="+timestamp
                            +" bytesEach="+mainCopy.length+" path="+dir+" pixelsAndCloudUnchanged=true");
                } catch (Throwable error) { XposedBridge.log("[LegendaryRawContractProbe] write skipped "+error); }
            }, "LegendaryRawContractEvidence");
            writer.setPriority(Thread.MIN_PRIORITY);
            writer.start();
        } catch (Throwable error) { XposedBridge.log("[LegendaryRawContractProbe] skipped "+error); }
    }

    private static String value(Object value) {
        if (value == null) return "null";
        if (!value.getClass().isArray()) return String.valueOf(value);
        int length = Array.getLength(value);
        int limit = value instanceof float[] ? 1024 : 96;
        StringBuilder text = new StringBuilder(value.getClass().getSimpleName()).append(" length=").append(length).append(" [");
        for (int i = 0; i < Math.min(length, limit); i++) {
            if (i > 0) text.append(',');
            text.append(Array.get(value, i));
        }
        return text.append(length > limit ? ",...TRUNCATED]" : "]").toString();
    }
    private static void write(File file, byte[] data) throws Exception {
        if (!file.createNewFile()) throw new IllegalStateException("Refusing evidence overwrite");
        try (FileOutputStream out = new FileOutputStream(file)) { out.write(data); }
    }
}
