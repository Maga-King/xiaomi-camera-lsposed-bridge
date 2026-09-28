package local.mio.os4camerabridge;

import java.lang.reflect.Field;
import java.lang.reflect.Method;
import java.lang.reflect.Modifier;
import java.util.ArrayList;
import org.luckypray.dexkit.DexKitBridge;
import org.luckypray.dexkit.query.FindMethod;
import org.luckypray.dexkit.query.matchers.MethodMatcher;
import de.robv.android.xposed.XC_MethodHook;
import de.robv.android.xposed.XposedBridge;

/** Keep the Legendary container after, rather than before, EXIF serialization. */
public final class LegendarySaveContractBridge {
    private static volatile boolean enabled;
    private LegendarySaveContractBridge() {}
    public static void enable() { enabled = true; }
    public static boolean isEnabled() { return enabled; }

    public static void bind(DexKitBridge bridge, ClassLoader loader) {
        try {
            var tags = bridge.findMethod(FindMethod.create().matcher(MethodMatcher.create()
                    .usingStrings("StoImage").returnType(String.class).paramCount(0)));
            if (tags.size() != 1) throw new IllegalStateException("store tag count=" + tags.size());
            Class<?> owner = tags.get(0).getMethodInstance(loader).getDeclaringClass();
            var writers = bridge.findMethod(FindMethod.create().matcher(MethodMatcher.create()
                    .declaredClass(owner).usingStrings("Storage.addImage(writer)",
                            "ImageSaveRequest: image save finished").returnType(void.class).paramCount(1)));
            if (writers.size() != 1) throw new IllegalStateException("store writer count=" + writers.size());
            ArrayList<Method> getters = new ArrayList<>();
            for (Method method : owner.getDeclaredMethods()) {
                if (!Modifier.isStatic(method.getModifiers()) && method.getReturnType() == boolean.class
                        && method.getParameterCount() == 0) getters.add(method);
            }
            if (getters.size() != 1) throw new IllegalStateException("stream capability count=" + getters.size());
            Class<?> entry = Class.forName("local.mio.os4camerabridge.HookEntry", false,
                    LegendarySaveContractBridge.class.getClassLoader());
            Field activeModule = entry.getDeclaredField("activeCameraModule");
            activeModule.setAccessible(true);
            XposedBridge.hookMethod(getters.get(0), new XC_MethodHook() {
                @Override protected void afterHookedMethod(MethodHookParam p) throws Throwable {
                    if (p.hasThrowable() || activeModule.getInt(null) != 256) return;
                    // M9 already disables deferred EXIF in the legacy bridge. M3 must
                    // follow the same ordering: EXIF -> container/marker -> storage.
                    // Otherwise the deferred writer serializes a pre-tagged XMP object
                    // over our newly tagged bytes. Never skip EXIF itself or rewrite pixels.
                    if (Boolean.TRUE.equals(p.getResult())) {
                        p.setResult(false);
                        XposedBridge.log("[LegendarySaveContract] defer disabled for Legendary; EXIF before container");
                    }
                }
            });
            XposedBridge.log("[LegendarySaveContract] validated writer=" + writers.get(0)
                    + " capability=" + getters.get(0));
        } catch (Throwable error) {
            XposedBridge.log("[LegendarySaveContract] binding refused: " + error);
        }
    }
}
