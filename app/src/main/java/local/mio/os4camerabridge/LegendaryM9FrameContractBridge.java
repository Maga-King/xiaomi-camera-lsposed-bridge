package local.mio.os4camerabridge;

import android.hardware.camera2.CaptureResult;
import android.hardware.camera2.params.ColorSpaceTransform;
import java.lang.reflect.Array;
import java.lang.reflect.Field;
import java.util.Collections;
import java.util.Map;
import java.util.WeakHashMap;
import de.robv.android.xposed.XC_MethodHook;
import de.robv.android.xposed.XposedBridge;

/** Experimental main1x input-contract correction, associated with the same metadata object. */
public final class LegendaryM9FrameContractBridge {
    private record Frame(float zoom, float gain, float[] ccm, long timestamp) {}
    private static final Map<Object, Frame> FRAMES = Collections.synchronizedMap(new WeakHashMap<>());
    private LegendaryM9FrameContractBridge() {}
    public static void install() {
        try {
            ClassLoader loader = LegendaryM9FrameContractBridge.class.getClassLoader();
            Class<?> entry = Class.forName("local.mio.os4camerabridge.HookEntry", false, loader);
            Field mainId = entry.getDeclaredField("rearMainPhysicalCameraId");
            mainId.setAccessible(true);
            Class<?> container = Class.forName("local.mio.os4camerabridge.LegendM9Container", false, loader);
            XposedBridge.hookAllMethods(entry, "legendMetadata", new XC_MethodHook() {
                @Override protected void afterHookedMethod(MethodHookParam p) {
                    if (p.hasThrowable() || p.getResult() == null) return;
                    try {
                        if ((int) p.args[3] != mainId.getInt(null)) return;
                        CaptureResult result = (CaptureResult) p.args[0];
                        // Cross-lens metadata ownership remains a separate pending fix.
                        if (result != p.args[1]) return;
                        Float zoom = result.get(CaptureResult.CONTROL_ZOOM_RATIO);
                        Long timestamp = result.get(CaptureResult.SENSOR_TIMESTAMP);
                        ColorSpaceTransform transform = result.get(CaptureResult.COLOR_CORRECTION_TRANSFORM);
                        if (zoom == null || Math.abs(zoom - 1f) > .0001f || timestamp == null || transform == null) return;
                        float gain = Float.NaN;
                        for (CaptureResult.Key<?> key : result.getKeys()) if ("com.qti.sensorbps.gain".equals(key.getName())) {
                            Object value = result.get(key);
                            if (value != null && value.getClass().isArray() && Array.getLength(value) > 0) value = Array.get(value, 0);
                            if (value instanceof Number) gain = ((Number) value).floatValue();
                            break;
                        }
                        if (!Float.isFinite(gain) || gain <= 0) return;
                        float[] matrix = new float[9];
                        for (int row = 0; row < 3; row++) for (int column = 0; column < 3; column++)
                            matrix[row * 3 + column] = transform.getElement(column, row).floatValue();
                        FRAMES.put(p.getResult(), new Frame(zoom, gain, matrix, timestamp));
                    } catch (Throwable error) { log("capture contract rejected: " + error); }
                }
            });
            XposedBridge.hookAllMethods(container, "buildMessage", new XC_MethodHook() {
                @Override protected void afterHookedMethod(MethodHookParam p) {
                    if (p.hasThrowable() || !(p.getResult() instanceof byte[]) || p.args.length != 3) return;
                    Frame frame = FRAMES.remove(p.args[1]);
                    if (frame == null) return;
                    try {
                        byte[] packet = (byte[]) p.getResult();
                        byte[] corrected = LegendaryM9MessagePolicy.correct(packet, frame.zoom, frame.gain, frame.ccm);
                        p.setResult(corrected);
                        log("main1x packet fields5/9/18 corrected ts=" + frame.timestamp + " zoom=" + frame.zoom
                                + " bpsGain=" + frame.gain + " ccm=" + java.util.Arrays.toString(frame.ccm)
                                + " bytes=" + packet.length + "; RAW/JPEG untouched");
                    } catch (Throwable error) { log("original packet retained: " + error); }
                }
            });
            log("same-frame main1x metadata experiment bound; no JPEG/RAW manipulation");
        } catch (Throwable error) { log("binding refused: " + error); }
    }
    private static void log(String value) { XposedBridge.log("[LegendaryFrameContract] " + value); }
}
