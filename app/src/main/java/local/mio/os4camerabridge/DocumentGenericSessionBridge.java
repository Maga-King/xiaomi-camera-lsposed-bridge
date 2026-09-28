package local.mio.os4camerabridge;

import android.media.Image;
import java.util.List;
import java.util.Map;
import java.util.concurrent.atomic.AtomicInteger;
import de.robv.android.xposed.XC_MethodHook;
import de.robv.android.xposed.XposedBridge;
import de.robv.android.xposed.XposedHelpers;

/** Optional document-only baseline: preserve stock detector output and save chain. */
public final class DocumentGenericSessionBridge {
    private static final AtomicInteger frames = new AtomicInteger();
    private static final AtomicInteger decoded = new AtomicInteger();
    private DocumentGenericSessionBridge() {}

    public static void install(ClassLoader loader) {
        Class<?> entry = XposedHelpers.findClass("local.mio.os4camerabridge.HookEntry",
                DocumentGenericSessionBridge.class.getClassLoader());
        XposedHelpers.findAndHookMethod(entry, "isRearClarityModule", int.class, new XC_MethodHook() {
            @Override protected void beforeHookedMethod(MethodHookParam p) {
                if (Integer.valueOf(186).equals(p.args[0])) p.setResult(false);
            }
        });
        XposedBridge.hookAllMethods(XposedHelpers.findClass("sh.b", loader), "b", new XC_MethodHook(-10000) {
            @Override protected void beforeHookedMethod(MethodHookParam p) {
                if (!isDocument(entry)) return;
                try {
                    if (p.args.length != 5 || !(p.args[1] instanceof List<?>)) return;
                    String camera = String.valueOf(XposedHelpers.callMethod(p.thisObject, "c"));
                    int mode = (Integer) p.args[0];
                    List<?> outputs = (List<?>) p.args[1];
                    int privateCount = 0, jpegCount = 0, yuvCount = 0;
                    StringBuilder formats = new StringBuilder();
                    for (Object output : outputs) {
                        int format = (Integer) XposedHelpers.callStaticMethod(entry, "configuredOutputFormat", output);
                        formats.append(format).append(',');
                        if (format == 34) privateCount++;
                        if (format == 33 || format == 256) jpegCount++;
                        if (format == 35) yuvCount++;
                    }
                    boolean compatible = "0".equals(camera) && outputs.size() == 3
                            && privateCount == 1 && jpegCount == 1 && yuvCount == 1
                            && (mode == 0 || mode == 0x9002 || mode == 0x8001);
                    if (compatible) p.args[0] = 0;
                    XposedBridge.log("[DocumentGeneric] camera=" + camera + " mode=" + mode
                            + "->" + p.args[0] + " formats=" + formats + " compatible=" + compatible);
                } catch (Throwable error) { XposedBridge.log("[DocumentGeneric] session check: " + error); }
            }
        });
        Class<?> doc = XposedHelpers.findClass("com.android.camera.features.mode.doc.DocModule", loader);
        XposedBridge.hookAllMethods(doc, "appendPreviewDecoder", new XC_MethodHook() {
            @Override protected void afterHookedMethod(MethodHookParam p) {
                frames.set(0); decoded.set(0);
                try {
                    Object registry = XposedHelpers.getObjectField(p.args[0], "c");
                    XposedBridge.log("[DocumentGeneric] registered decoders="
                            + (registry instanceof Map<?, ?> ? ((Map<?, ?>) registry).keySet() : registry));
                } catch (Throwable error) { XposedBridge.log("[DocumentGeneric] decoder registry: " + error); }
            }
        });
        XposedHelpers.findAndHookMethod("gi.f", loader, "b", Image.class, new XC_MethodHook() {
            @Override protected void beforeHookedMethod(MethodHookParam p) {
                if (!isDocument(entry)) return;
                int count = frames.incrementAndGet();
                if (count > 3 && count % 120 != 0) return;
                try {
                    Image image = (Image) p.args[0];
                    XposedBridge.log("[DocumentGeneric] input#" + count + " " + image.getWidth() + "x"
                            + image.getHeight() + " format=" + image.getFormat() + " ts=" + image.getTimestamp());
                } catch (Throwable error) { XposedBridge.log("[DocumentGeneric] input: " + error); }
            }
        });
        XposedBridge.hookAllMethods(doc, "onDocDecodeDataReceived", new XC_MethodHook() {
            @Override protected void afterHookedMethod(MethodHookParam p) {
                int count = decoded.incrementAndGet();
                if (count > 3 && count % 30 != 0) return;
                try {
                    XposedBridge.log("[DocumentGeneric] decoded#" + count + " result=" + p.args[0]
                            + " lastInfo=" + (XposedHelpers.getObjectField(p.thisObject, "mLastDocInfo") != null));
                } catch (Throwable error) { XposedBridge.log("[DocumentGeneric] decode: " + error); }
            }
        });
        XposedBridge.hookAllMethods(doc, "prepareNormalCapture", new XC_MethodHook() {
            @Override protected void afterHookedMethod(MethodHookParam p) {
                try {
                    XposedBridge.log("[DocumentGeneric] prepare shotData="
                            + (XposedHelpers.getObjectField(p.thisObject, "mDocShotData") != null)
                            + " frames=" + frames.get() + " decoded=" + decoded.get());
                } catch (Throwable error) { XposedBridge.log("[DocumentGeneric] prepare: " + error); }
            }
        });
        XposedBridge.log("[DocumentGeneric] module186 APS replacement bypassed; original preview/JPEG/YUV and saver retained");
    }

    private static boolean isDocument(Class<?> entry) {
        return XposedHelpers.getStaticIntField(entry, "activeCameraModule") == 186;
    }
}
