package local.mio.os4camerabridge;

import android.app.Application;
import android.content.Context;
import android.graphics.Bitmap;
import java.io.OutputStream;
import java.lang.reflect.Method;
import java.lang.reflect.Modifier;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Map;
import java.util.WeakHashMap;
import org.luckypray.dexkit.DexKitBridge;
import org.luckypray.dexkit.query.FindMethod;
import org.luckypray.dexkit.query.matchers.MethodMatcher;
import de.robv.android.xposed.XC_MethodHook;
import de.robv.android.xposed.XposedBridge;
import de.robv.android.xposed.XposedHelpers;

/** Scope metadata normalization to the Legendary job's private output EXIF object. */
public final class LegendaryEditorSaveBridge {
    private static final ThreadLocal<Integer> SAVE_DEPTH = ThreadLocal.withInitial(() -> 0);
    private static final Map<Object, int[]> COPIED_EXIF = Collections.synchronizedMap(new WeakHashMap<>());
    private LegendaryEditorSaveBridge() {}

    public static void install(ClassLoader loader) {
        XposedHelpers.findAndHookMethod(Application.class, "attach", Context.class, new XC_MethodHook() {
            @Override protected void afterHookedMethod(MethodHookParam p) {
                Context context = (Context) p.args[0];
                if (!"com.miui.mediaeditor".equals(context.getPackageName())) return;
                bind(context, loader);
            }
        });
    }

    private static void bind(Context context, ClassLoader loader) {
        try {
            System.loadLibrary("dexkit");
            try (DexKitBridge dex = DexKitBridge.create(context.getApplicationInfo().sourceDir)) {
                var saves = dex.findMethod(FindMethod.create().matcher(MethodMatcher.create()
                        .usingStrings("saveResultInternal, handleResult:", "copyOriExifInfo error, e:")
                        .paramTypes(Object.class).returnType(Object.class)));
                var encoders = dex.findMethod(FindMethod.create().matcher(MethodMatcher.create()
                        .usingStrings("storeImage: start, bmp=", "storeImage: exif writer stream ready, iccSet=")
                        .paramCount(3).returnType(void.class)));
                if (saves.size() != 1 || encoders.size() != 1)
                    throw new IllegalStateException("save/encoder candidates=" + saves.size() + "/" + encoders.size());
                Method save = saves.get(0).getMethodInstance(loader);
                Method encoder = encoders.get(0).getMethodInstance(loader);
                Class<?>[] parameters = encoder.getParameterTypes();
                if (parameters[0] != OutputStream.class || parameters[1] != Bitmap.class)
                    throw new IllegalStateException("encoder signature mismatch");
                Class<?> exif = parameters[2];
                var getters = dex.findMethod(FindMethod.create().matcher(MethodMatcher.create()
                        .declaredClass(exif).usingStrings("GPSTimeStamp", "algoComment")
                        .paramTypes(String.class).returnType(String.class)));
                if (getters.size() != 1) throw new IllegalStateException("EXIF getter count=" + getters.size());
                Method get = getters.get(0).getMethodInstance(loader);
                Method set = uniqueMethod(exif, void.class, String.class, String.class);
                Method copy = uniqueMethod(exif, void.class, exif);

                XposedBridge.hookMethod(save, new XC_MethodHook() {
                    @Override protected void beforeHookedMethod(MethodHookParam p) {
                        SAVE_DEPTH.set(SAVE_DEPTH.get() + 1);
                    }
                    @Override protected void afterHookedMethod(MethodHookParam p) {
                        int depth = SAVE_DEPTH.get() - 1;
                        if (depth <= 0) SAVE_DEPTH.remove(); else SAVE_DEPTH.set(depth);
                    }
                });
                XposedBridge.hookMethod(copy, new XC_MethodHook() {
                    @Override protected void afterHookedMethod(MethodHookParam p) {
                        if (SAVE_DEPTH.get() <= 0 || p.hasThrowable()) return;
                        try {
                            Object original = p.args[0];
                            int mode = integer(get.invoke(original, "legendmode"));
                            int orientation = integer(get.invoke(original, "Orientation"));
                            int width = integer(get.invoke(original, "PixelXDimension"));
                            int height = integer(get.invoke(original, "PixelYDimension"));
                            if (width <= 0 || height <= 0) {
                                width = integer(get.invoke(original, "ImageWidth"));
                                height = integer(get.invoke(original, "ImageLength"));
                            }
                            if (mode == 1) COPIED_EXIF.put(p.thisObject, new int[]{mode, orientation, width, height});
                        } catch (Throwable error) { log("source metadata unavailable: " + error); }
                    }
                });
                XposedBridge.hookMethod(encoder, new XC_MethodHook() {
                    @Override protected void beforeHookedMethod(MethodHookParam p) {
                        if (SAVE_DEPTH.get() <= 0 || p.args[2] == null || !(p.args[1] instanceof Bitmap)) return;
                        Object outputExif = p.args[2];
                        int[] source = COPIED_EXIF.remove(outputExif);
                        if (source == null) return;
                        Bitmap bitmap = (Bitmap) p.args[1];
                        int width = bitmap.getWidth(), height = bitmap.getHeight();
                        if (!LegendaryEditorOrientationPolicy.shouldNormalize(source[0], source[1],
                                source[2], source[3], width, height)) {
                            log("geometry retained source=" + source[2] + "x" + source[3]
                                    + " exif=" + source[1] + " output=" + width + "x" + height);
                            return;
                        }
                        try {
                            set.invoke(outputExif, "Orientation", "1");
                            set.invoke(outputExif, "PixelXDimension", String.valueOf(width));
                            set.invoke(outputExif, "PixelYDimension", String.valueOf(height));
                            log("M9 output EXIF normalized " + source[1] + "->1; pixels untouched " + width + "x" + height);
                        } catch (Throwable error) { log("metadata normalization failed: " + error); }
                    }
                });
                log("bound save=" + save + " encoder=" + encoder + " copy=" + copy);
            }
        } catch (Throwable error) { log("binding refused: " + error); }
    }
    private static Method uniqueMethod(Class<?> owner, Class<?> result, Class<?>... parameters) {
        ArrayList<Method> methods = new ArrayList<>();
        for (Method method : owner.getDeclaredMethods())
            if (!Modifier.isStatic(method.getModifiers()) && method.getReturnType() == result
                    && java.util.Arrays.equals(method.getParameterTypes(), parameters)) methods.add(method);
        if (methods.size() != 1) throw new IllegalStateException("EXIF structural candidates=" + methods.size());
        Method method = methods.get(0); method.setAccessible(true); return method;
    }
    private static int integer(Object value) {
        try { return Integer.parseInt(String.valueOf(value)); } catch (RuntimeException ignored) { return -1; }
    }
    private static void log(String message) { XposedBridge.log("[LegendaryEditorSave] " + message); }
}
