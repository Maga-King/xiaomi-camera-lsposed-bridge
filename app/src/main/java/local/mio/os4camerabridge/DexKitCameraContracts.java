package local.mio.os4camerabridge;

import android.app.Application;
import android.content.Context;
import android.os.SystemClock;
import android.util.Size;
import java.lang.reflect.Field;
import java.lang.reflect.Method;
import java.lang.reflect.Modifier;
import java.util.ArrayList;
import java.util.concurrent.atomic.AtomicBoolean;
import org.luckypray.dexkit.DexKitBridge;
import org.luckypray.dexkit.query.FindMethod;
import org.luckypray.dexkit.query.FindClass;
import org.luckypray.dexkit.query.matchers.MethodMatcher;
import org.luckypray.dexkit.query.matchers.ClassMatcher;
import org.luckypray.dexkit.result.MethodDataList;
import de.robv.android.xposed.XC_MethodHook;
import de.robv.android.xposed.XposedBridge;
import de.robv.android.xposed.XposedHelpers;

/** Process-local, feature-based lookup. No persistent file is needed to start. */
public final class DexKitCameraContracts {
    private static final AtomicBoolean started = new AtomicBoolean();
    private static volatile String featureDescription = "contract scan pending";
    private DexKitCameraContracts() {}

    public static String describeFeature() { return featureDescription; }

    public static void install(ClassLoader hostLoader) {
        XposedHelpers.findAndHookMethod(Application.class, "attach", Context.class, new XC_MethodHook() {
            @Override protected void afterHookedMethod(MethodHookParam p) {
                Context context = (Context) p.args[0];
                if (!"com.android.camera".equals(context.getPackageName()) || !started.compareAndSet(false, true)) return;
                resolve(context, hostLoader);
            }
        });
    }

    private static void resolve(Context context, ClassLoader loader) {
        long start = SystemClock.elapsedRealtime();
        try {
            System.loadLibrary("dexkit");
            try (DexKitBridge bridge = DexKitBridge.create(context.getApplicationInfo().sourceDir)) {
                BeautyPanelContractBridge.bind(bridge, loader);
                if (SoftwareBeautyBridge.isEnabled()) SoftwareBeautyBridge.bind(bridge, loader);
                if (SlowMotionRecorderBridge.isEnabled()) SlowMotionRecorderBridge.bind(bridge, loader);
                if (LegendarySaveContractBridge.isEnabled()) LegendarySaveContractBridge.bind(bridge, loader);
                // A literal plus the complete signature, not a jadx-generated alias.
                MethodDataList pixelCandidates = bridge.findMethod(FindMethod.create().matcher(
                        MethodMatcher.create().usingStrings("NO_PIXEL").returnType(boolean.class).paramCount(0)));
                ArrayList<Method> valid = new ArrayList<>();
                for (var candidate : pixelCandidates) {
                    Method method = candidate.getMethodInstance(loader);
                    Class<?> owner = method.getDeclaringClass();
                    if (Modifier.isStatic(method.getModifiers()) || !hasCameraModuleAncestor(owner)) continue;
                    // Confirm the owner is the pixel module through its class's own literal.
                    var owners = bridge.findMethod(FindMethod.create().matcher(MethodMatcher.create()
                            .declaredClass(owner).usingStrings("PixelModule@")));
                    if (owners.size() == 1) valid.add(method);
                }
                if (valid.size() == 1) {
                    Method method = valid.get(0);
                    XposedBridge.hookMethod(method, new XC_MethodHook() {
                        @Override protected void beforeHookedMethod(MethodHookParam p) { p.setResult(false); }
                    });
                    XposedBridge.log("[CameraContracts] pixel parallel bound " + method);
                } else XposedBridge.log("[CameraContracts] pixel ambiguous/missing count=" + valid.size());

                var sizes = bridge.findMethod(FindMethod.create().matcher(MethodMatcher.create()
                        .usingStrings("putPictureSize pictureSize = ", "LoadStreamSizeBase")
                        .returnType(void.class).paramTypes(Size.class)));
                if (sizes.size() == 1) {
                    Method method = sizes.get(0).getMethodInstance(loader);
                    if (Modifier.isStatic(method.getModifiers())) throw new IllegalStateException("Picture-size setter is static");
                    XposedBridge.log("[CameraContracts] size setter validated " + method);
                } else XposedBridge.log("[CameraContracts] size setter ambiguous/missing count=" + sizes.size());

                var features = bridge.findClass(FindClass.create().matcher(ClassMatcher.create()
                        .usingStrings("DataItemFeature")));
                if (features.size() == 1) {
                    Class<?> owner = features.get(0).getInstance(loader);
                    Object singleton = findSingletonByType(owner);
                    StringBuilder description = new StringBuilder(owner.getName());
                    if (singleton != null) {
                        for (Field field : owner.getDeclaredFields()) {
                            if (Modifier.isStatic(field.getModifiers()) || field.getType().isPrimitive()
                                    || field.getType().getName().startsWith("java.")
                                    || field.getType().getName().startsWith("android.")) continue;
                            field.setAccessible(true);
                            Object value = field.get(singleton);
                            if (value != null) description.append(' ').append(field.getName()).append(':').append(value.getClass().getName());
                        }
                    }
                    featureDescription = description.toString();
                } else featureDescription = "feature matcher count=" + features.size();
                XposedBridge.log("[CameraContracts] feature=" + featureDescription);
            }
            var packageInfo = context.getPackageManager().getPackageInfo(context.getPackageName(), 0);
            XposedBridge.log("[CameraContracts] hostVersion=" + packageInfo.getLongVersionCode()
                    + " updated=" + packageInfo.lastUpdateTime + " process-local scanMs="
                    + (SystemClock.elapsedRealtime() - start) + "; no frame/shutter scanning");
        } catch (Throwable error) {
            featureDescription = "contract resolver unavailable: " + error;
            XposedBridge.log("[CameraContracts] " + featureDescription);
        }
    }

    private static boolean hasCameraModuleAncestor(Class<?> type) {
        for (Class<?> c = type.getSuperclass(); c != null; c = c.getSuperclass())
            if ("com.android.camera.module.Camera2Module".equals(c.getName())) return true;
        return false;
    }

    private static Object findSingletonByType(Class<?> owner) throws IllegalAccessException {
        ArrayList<Field> fields = new ArrayList<>();
        ArrayList<Class<?>> containers = new ArrayList<>();
        containers.add(owner);
        for (Class<?> nested : owner.getDeclaredClasses()) containers.add(nested);
        for (Class<?> container : containers) for (Field field : container.getDeclaredFields())
            if (Modifier.isStatic(field.getModifiers()) && field.getType() == owner) fields.add(field);
        if (fields.size() != 1) return null;
        Field field = fields.get(0);
        field.setAccessible(true);
        return field.get(null);
    }
}
