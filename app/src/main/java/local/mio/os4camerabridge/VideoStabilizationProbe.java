package local.mio.os4camerabridge;

import android.hardware.camera2.CaptureRequest;
import android.media.CamcorderProfile;
import android.util.Range;
import java.util.List;
import de.robv.android.xposed.XC_MethodHook;
import de.robv.android.xposed.XposedBridge;
import de.robv.android.xposed.XposedHelpers;

/** Optional diagnostic only; absent from default/release backports. */
public final class VideoStabilizationProbe {
    private static int count;
    private static int requestCount;
    private static volatile boolean genericEligible;
    private VideoStabilizationProbe() {}

    public static void install(ClassLoader loader) {
        final Class<?> entry = XposedHelpers.findClass(
                "local.mio.os4camerabridge.HookEntry",
                VideoStabilizationProbe.class.getClassLoader());
        final Class<?> props = XposedHelpers.findClass("android.os.SystemProperties", null);
        final Class<?> video = XposedHelpers.findClass("com.android.camera.module.VideoModule", loader);
        XposedBridge.hookAllMethods(video, "isEisOn", new XC_MethodHook() {
            @Override protected void afterHookedMethod(MethodHookParam p) {
                if (p.hasThrowable() || !(p.getResult() instanceof Boolean)) return;
                try {
                    int module = XposedHelpers.getIntField(p.thisObject, "mModuleIndex");
                    int camera = XposedHelpers.getStaticIntField(entry, "activeCameraId");
                    if (module != 162 || camera != 0) return;
                    String choice = (String) XposedHelpers.callStaticMethod(props, "get",
                            "debug.mio.video.eis_probe", "observe");
                    boolean original = (Boolean) p.getResult();
                    if ("off".equals(choice)) p.setResult(false);
                    if ("generic".equals(choice)) {
                        Object settings = XposedHelpers.getObjectField(p.thisObject, "mUserRecordSetting");
                        CamcorderProfile profile = (CamcorderProfile) XposedHelpers.getObjectField(settings, "j");
                        genericEligible = profile != null && profile.videoFrameWidth == 1920
                                && profile.videoFrameHeight == 1080 && profile.videoFrameRate == 30;
                        if (genericEligible) p.setResult(false);
                    }
                    if (count++ < 24) {
                        Object config = XposedHelpers.callStaticMethod(
                                XposedHelpers.findClass("Je.b", loader), "B");
                        Object feature = XposedHelpers.getObjectField(config, "e");
                        XposedBridge.log("[VideoStabilizationProbe] module=" + module
                                + " camera=" + camera + " choice=" + choice
                                + " original=" + original + " result=" + p.getResult()
                                + " feature=" + feature.getClass().getName());
                    }
                } catch (Throwable error) {
                    XposedBridge.log("[VideoStabilizationProbe] diagnostic error " + error);
                }
            }
        });
        XposedBridge.hookAllMethods(XposedHelpers.findClass("sh.b", loader), "b",
                new XC_MethodHook(-10000) {
            @Override protected void beforeHookedMethod(MethodHookParam p) {
                try {
                    if (!genericEligible || p.args.length != 5
                            || !(p.args[0] instanceof Integer) || !(p.args[1] instanceof List)
                            || !(p.args[2] instanceof CaptureRequest)) return;
                    if (XposedHelpers.getStaticIntField(entry, "activeCameraModule") != 162
                            || !"0".equals(String.valueOf(XposedHelpers.callMethod(p.thisObject, "c")))) return;
                    if (!"generic".equals(XposedHelpers.callStaticMethod(props, "get",
                            "debug.mio.video.eis_probe", "observe"))) return;
                    int mode = (Integer) p.args[0];
                    if (mode != 0 && mode != 0xf010 && mode != 0x8004) return;
                    CaptureRequest request = (CaptureRequest) p.args[2];
                    Range<Integer> fps = request.get(CaptureRequest.CONTROL_AE_TARGET_FPS_RANGE);
                    if (fps == null || fps.getUpper() != 30 || ((List<?>) p.args[1]).size() != 3) return;
                    p.args[0] = 0;
                    XposedBridge.log("[VideoStabilizationProbe] generic1080p30 mode=0x"
                            + Integer.toHexString(mode) + " -> 0; all3 outputs retained; fps=" + fps);
                } catch (Throwable error) {
                    XposedBridge.log("[VideoStabilizationProbe] generic diagnostic error " + error);
                }
            }
        });
        // Separate test: preserve Xiaomi's EIS-based session selection and UI
        // scaling; vary only the standard key in built video requests.
        XposedBridge.hookAllMethods(CaptureRequest.Builder.class, "build", new XC_MethodHook() {
            @Override protected void beforeHookedMethod(MethodHookParam p) {
                try {
                    if (XposedHelpers.getStaticIntField(entry, "activeCameraModule") != 162
                            || XposedHelpers.getStaticIntField(entry, "activeCameraId") != 0) return;
                    String choice = (String) XposedHelpers.callStaticMethod(props, "get",
                            "debug.mio.video.eis_probe", "observe");
                    if (!"request_off".equals(choice)) return;
                    CaptureRequest.Builder builder = (CaptureRequest.Builder) p.thisObject;
                    if (!Integer.valueOf(CaptureRequest.CONTROL_CAPTURE_INTENT_VIDEO_RECORD)
                            .equals(builder.get(CaptureRequest.CONTROL_CAPTURE_INTENT))) return;
                    Integer original = builder.get(CaptureRequest.CONTROL_VIDEO_STABILIZATION_MODE);
                    p.setObjectExtra("videoEisOriginal", original);
                    p.setObjectExtra("videoEisChanged", Boolean.TRUE);
                    builder.set(CaptureRequest.CONTROL_VIDEO_STABILIZATION_MODE, 0);
                    if (requestCount++ < 24) XposedBridge.log(
                            "[VideoStabilizationProbe] request_off standard EIS " + original
                            + " -> 0; unchanged OIS="
                            + builder.get(CaptureRequest.LENS_OPTICAL_STABILIZATION_MODE));
                } catch (Throwable error) {
                    XposedBridge.log("[VideoStabilizationProbe] request diagnostic error " + error);
                }
            }
            @Override protected void afterHookedMethod(MethodHookParam p) {
                if (!Boolean.TRUE.equals(p.getObjectExtra("videoEisChanged"))) return;
                try {
                    ((CaptureRequest.Builder) p.thisObject).set(
                            CaptureRequest.CONTROL_VIDEO_STABILIZATION_MODE,
                            (Integer) p.getObjectExtra("videoEisOriginal"));
                } catch (Throwable error) {
                    XposedBridge.log("[VideoStabilizationProbe] restore error " + error);
                }
            }
        });
        XposedBridge.log("[VideoStabilizationProbe] optional isEisOn diagnostic installed; default observe");
    }
}
