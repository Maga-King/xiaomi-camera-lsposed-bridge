package local.mio.os4camerabridge;

import android.hardware.camera2.CaptureResult;
import java.lang.reflect.Array;
import java.util.Locale;
import de.robv.android.xposed.XposedBridge;

/** Read-only, same-frame metadata evidence at the actual M9 container boundary. */
public final class LegendaryInputContractProbe {
    private LegendaryInputContractProbe() {}
    public static void record(CaptureResult physical, CaptureResult logical, int orientation, int cameraId) {
        try {
            log("BEGIN camera=" + cameraId + " taskOrientation=" + orientation
                    + " ts=" + physical.get(CaptureResult.SENSOR_TIMESTAMP)
                    + " frame=" + physical.getFrameNumber() + " logicalSame=" + (physical == logical));
            dump(physical, "physical");
            if (logical != physical) dump(logical, "logical");
            log("END");
        } catch (Throwable error) { log("read failed: " + error); }
    }
    private static void dump(CaptureResult result, String label) {
        if (result == null) return;
        for (CaptureResult.Key<?> key : result.getKeys()) {
            String name = key.getName();
            String lower = name.toLowerCase(Locale.ROOT);
            if (!(lower.contains("gain") || lower.contains("ccm") || lower.contains("colorcorrection")
                    || lower.contains("blacklevel") || lower.contains("whitelevel") || lower.contains("zoom")
                    || lower.contains("exposuretime") || lower.contains("sensitivity")
                    || lower.contains("focallength") || lower.contains("cct") || lower.contains("luxindex")
                    || lower.contains("activephysicalid") || lower.contains("sensormode"))) continue;
            try { log(label + " " + name + "=" + value(result.get(key))); }
            catch (Throwable error) { log(label + " " + name + " unreadable=" + error.getClass().getSimpleName()); }
        }
    }
    private static String value(Object value) {
        if (value == null) return "null";
        if (!value.getClass().isArray()) return String.valueOf(value);
        int length = Array.getLength(value);
        StringBuilder out = new StringBuilder(value.getClass().getSimpleName()).append(" length=").append(length).append(" [");
        for (int i = 0; i < Math.min(length, 24); i++) { if (i > 0) out.append(','); out.append(Array.get(value, i)); }
        return out.append(length > 24 ? ",...]" : "]").toString();
    }
    private static void log(String value) { XposedBridge.log("[LegendaryInputContract] " + value); }
}
