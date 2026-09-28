package local.mio.os4camerabridge;

import android.hardware.camera2.CaptureRequest;
import android.media.CamcorderProfile;
import android.util.Range;
import java.util.List;
import de.robv.android.xposed.XC_MethodHook;
import de.robv.android.xposed.XposedBridge;
import de.robv.android.xposed.XposedHelpers;

/** Self-contained version of the user-verified generic1080p30 experiment. */
public final class GenericVideoSessionBridge {
    private static volatile boolean profileVerified;
    private static int decisionLogs;
    private GenericVideoSessionBridge() {}

    private static boolean verifyProfile(Object settings, int module, Object manager) {
        Object camera = manager == null ? null : XposedHelpers.callMethod(manager, "V");
        int cameraId = camera == null ? -1 : XposedHelpers.getIntField(camera, "a");
        CamcorderProfile profile = settings == null ? null
                : (CamcorderProfile) XposedHelpers.getObjectField(settings, "j");
        return profile != null && GenericVideoPolicy.supportsProfile(module, cameraId,
                profile.videoFrameWidth, profile.videoFrameHeight, profile.videoFrameRate);
    }

    public static void install(ClassLoader loader) {
        final Class<?> entry = XposedHelpers.findClass("local.mio.os4camerabridge.HookEntry",
                GenericVideoSessionBridge.class.getClassLoader());
        // VideoModuleDevice calls UserRecordSetting.k directly while choosing
        // its graph. VideoModule.isEisOn can be reached only AFTER configure on
        // a 60 -> 30 transition, and activeCameraId may still name camera 2.
        // Use the live manager/proxy and current profile at the upstream gate.
        XposedHelpers.findAndHookMethod("com.android.camera.module.video.G", loader, "k",
                XposedHelpers.findClass("j9.e", loader), int.class,
                XposedHelpers.findClass("j6.k", loader), new XC_MethodHook() {
            @Override protected void afterHookedMethod(MethodHookParam p) {
                if (p.hasThrowable()) return;
                try {
                    boolean eligible = verifyProfile(p.thisObject, (Integer) p.args[1], p.args[2]);
                    profileVerified = eligible;
                    if (!eligible) return;
                    p.setResult(false);
                    if (decisionLogs++ < 12) XposedBridge.log(
                            "[GenericVideo] upstream settings EIS off before graph selection; live camera0 1080p30");
                } catch (Throwable error) {
                    profileVerified = false;
                    XposedBridge.log("[GenericVideo] upstream profile unavailable: " + error);
                }
            }
        });
        XposedBridge.hookAllMethods(XposedHelpers.findClass(
                "com.android.camera.module.VideoModule", loader), "isEisOn", new XC_MethodHook() {
            @Override protected void afterHookedMethod(MethodHookParam p) {
                if (p.hasThrowable() || !(p.getResult() instanceof Boolean)) return;
                try {
                    int module = XposedHelpers.getIntField(p.thisObject, "mModuleIndex");
                    Object settings = XposedHelpers.getObjectField(p.thisObject, "mUserRecordSetting");
                    profileVerified = verifyProfile(settings, module,
                            XposedHelpers.getObjectField(p.thisObject, "mCameraManager"));
                    if (!profileVerified) return;
                    // Use Xiaomi's own OIS/rendering branch, not a hidden crop or
                    // a downstream key override that leaves EIS scaling enabled.
                    boolean original = (Boolean) p.getResult();
                    p.setResult(false);
                    if (decisionLogs++ < 12) XposedBridge.log("[GenericVideo] 1080p30 EIS "
                            + original + " -> false; retain stock OIS branch");
                } catch (Throwable error) {
                    profileVerified = false;
                    XposedBridge.log("[GenericVideo] profile not verified, original route retained: " + error);
                }
            }
        });
        XposedBridge.hookAllMethods(XposedHelpers.findClass("sh.b", loader), "b",
                new XC_MethodHook(-10000) {
            @Override protected void beforeHookedMethod(MethodHookParam p) {
                try {
                    if (p.args.length != 5 || !(p.args[0] instanceof Integer)
                            || !(p.args[1] instanceof List) || !(p.args[2] instanceof CaptureRequest)) return;
                    int module = XposedHelpers.getStaticIntField(entry, "activeCameraModule");
                    String camera = String.valueOf(XposedHelpers.callMethod(p.thisObject, "c"));
                    int mode = (Integer) p.args[0];
                    Range<Integer> fps = ((CaptureRequest) p.args[2]).get(CaptureRequest.CONTROL_AE_TARGET_FPS_RANGE);
                    if (!GenericVideoPolicy.supportsSession(profileVerified, module, camera, mode,
                            ((List<?>) p.args[1]).size(), fps == null ? -1 : fps.getUpper())) return;
                    p.args[0] = 0;
                    XposedBridge.log("[GenericVideo] camera=0 mode=0x" + Integer.toHexString(mode)
                            + " -> NORMAL(0), 1080p30, all3 outputs retained");
                } catch (Throwable error) {
                    XposedBridge.log("[GenericVideo] session not verified, original mode retained: " + error);
                }
            }
        });
        XposedBridge.log("[GenericVideo] verified1080p30 fallback installed, no temporary property required");
    }
}
