package local.mio.os4camerabridge;

import android.app.Application;
import android.content.Context;
import android.media.MediaFormat;
import android.os.SystemClock;
import java.lang.reflect.Constructor;
import java.lang.reflect.Field;
import java.lang.reflect.Method;
import java.lang.reflect.Modifier;
import java.util.concurrent.LinkedBlockingQueue;
import java.util.concurrent.atomic.AtomicInteger;
import de.robv.android.xposed.XC_MethodHook;
import de.robv.android.xposed.XposedBridge;
import de.robv.android.xposed.XposedHelpers;
import org.luckypray.dexkit.DexKitBridge;
import org.luckypray.dexkit.query.FindMethod;
import org.luckypray.dexkit.query.matchers.MethodMatcher;

/** Retains Xiaomi's circular video/audio recorder with standard PCM input. */
public final class RearLivePhotoBridge {
    private static final ThreadLocal<Integer> AUDIO_SCOPE = new ThreadLocal<>();
    private static final ThreadLocal<PendingPath> PENDING_PATH = new ThreadLocal<>();
    private static final AtomicInteger LOGS = new AtomicInteger();
    private static boolean installed;

    private RearLivePhotoBridge() {}

    public static synchronized void install(ClassLoader loader) {
        if (installed) return;
        try {
            XposedHelpers.findAndHookMethod(Application.class, "attach", Context.class,
                    new XC_MethodHook() {
                        @Override protected void afterHookedMethod(MethodHookParam p) {
                            Context context = (Context) p.args[0];
                            if ("com.android.camera".equals(context.getPackageName())) resolve(context, loader);
                        }
                    });
            installed = true;
            log("r17 contract resolver scheduled; no fixed obfuscated encoder/task class");
        } catch (Throwable t) { log("bootstrap rejected: " + t); }
    }

    private static void resolve(Context context, ClassLoader loader) {
        try {
            System.loadLibrary("dexkit");
            try (DexKitBridge bridge = DexKitBridge.create(context.getApplicationInfo().sourceDir)) {
                var constructors = bridge.findMethod(FindMethod.create().matcher(MethodMatcher.create()
                        .name("<init>").usingStrings("CircularAudioEncoder", "createDirectAACAudioFormat")
                        .paramTypes(MediaFormat.class, long.class, long.class, LinkedBlockingQueue.class)));
                var capabilities = bridge.findMethod(FindMethod.create().matcher(MethodMatcher.create()
                        .usingStrings("ro.miui.support_audiorecord_compress")
                        .paramTypes(int.class, int.class).returnType(boolean.class)));
                if (constructors.size() != 1 || capabilities.size() != 1) {
                    throw new IllegalStateException("Audio candidates constructor=" + constructors.size()
                            + " capability=" + capabilities.size());
                }
                boolean invokes = false;
                for (var call : constructors.get(0).getInvokes()) {
                    if (call.getDescriptor().equals(capabilities.get(0).getDescriptor())) invokes = true;
                }
                if (!invokes) throw new IllegalStateException("Audio constructor/capability edge absent");
                Constructor<?> constructor = constructors.get(0).getConstructorInstance(loader);
                Method compressed = capabilities.get(0).getMethodInstance(loader);
                bind(constructor, compressed);
                bindCapturePath(bridge, loader);
            }
        } catch (Throwable t) { log("binding rejected, native behavior retained: " + t); }
    }

    private static void bind(Constructor<?> constructor, Method compressed) {
        try {
            if (compressed.getReturnType() != boolean.class
                    || !Modifier.isStatic(compressed.getModifiers())) {
                throw new IllegalStateException("Compressed-audio signature changed");
            }
            XposedBridge.hookMethod(compressed, new XC_MethodHook() {
                @Override protected void afterHookedMethod(MethodHookParam p) {
                    Integer depth = AUDIO_SCOPE.get();
                    if (depth == null || depth <= 0 || p.hasThrowable()
                            || !Boolean.TRUE.equals(p.getResult())) return;
                    p.setResult(false);
                    log("circular recorder direct AAC -> PCM + AAC encoder; sampleRate="
                            + p.args[0] + " channels=" + p.args[1]);
                }
            });
            XposedBridge.hookMethod(constructor, new XC_MethodHook() {
                @Override protected void beforeHookedMethod(MethodHookParam p) {
                    Integer depth = AUDIO_SCOPE.get();
                    AUDIO_SCOPE.set(depth == null ? 1 : depth + 1);
                }
                @Override protected void afterHookedMethod(MethodHookParam p) {
                    Integer depth = AUDIO_SCOPE.get();
                    if (depth == null || depth <= 1) AUDIO_SCOPE.remove();
                    else AUDIO_SCOPE.set(depth - 1);
                    if (p.hasThrowable()) log("circular recorder construction failed: " + p.getThrowable());
                }
            });
            log("bound circular constructor=" + constructor + " capability=" + compressed
                    + "; movie recorder unchanged");
        } catch (Throwable t) {
            log("binding rejected, native behavior retained: " + t);
        }
    }

    private static void log(String message) {
        if (LOGS.getAndIncrement() < 60) XposedBridge.log("[RearLivePhoto] " + message);
    }

    private static void bindCapturePath(DexKitBridge bridge, ClassLoader loader) throws Exception {
        var setters = bridge.findMethod(FindMethod.create().matcher(MethodMatcher.create()
                .usingStrings("setShotSavePath: ", "CameraConfigManager")
                .returnType(void.class).paramTypes(String.class, boolean.class, boolean.class, boolean.class)));
        var starts = bridge.findMethod(FindMethod.create().matcher(MethodMatcher.create()
                .usingStrings("onCaptureStart: isLiveShot = ", " onlyPreDuration = ")
                .returnType(void.class).paramCount(5)));
        if (setters.size() != 1 || starts.size() != 1) {
            throw new IllegalStateException("Live path methods ambiguous: " + setters.size() + "/" + starts.size());
        }
        Method setter = setters.get(0).getMethodInstance(loader);
        Method start = starts.get(0).getMethodInstance(loader);
        Class<?>[] parameters = start.getParameterTypes();
        if (Modifier.isStatic(start.getModifiers()) || Modifier.isStatic(setter.getModifiers())
                || parameters[3] != boolean.class || parameters[4] != int.class) {
            throw new IllegalStateException("Live path method structure changed");
        }
        Class<?> task = parameters[0];
        var descriptions = bridge.findMethod(FindMethod.create().matcher(MethodMatcher.create()
                .declaredClass(task).usingStrings("ParallelTaskData:{mTimestamp=", ",mSavePath=")
                .returnType(String.class).paramCount(0)));
        if (descriptions.size() != 1) throw new IllegalStateException("Task identity descriptor not unique");
        Field pathField = null;
        for (var use : descriptions.get(0).getUsingFields()) {
            Field field = use.getField().getFieldInstance(loader);
            if (field.getType() != String.class || Modifier.isStatic(field.getModifiers())) continue;
            if (pathField != null && !pathField.equals(field)) throw new IllegalStateException("Task path field ambiguous");
            pathField = field;
        }
        if (pathField == null || pathField.getDeclaringClass() == task) throw new IllegalStateException("Nested task path absent");
        Field storageField = null;
        for (Field field : task.getDeclaredFields()) {
            if (Modifier.isStatic(field.getModifiers()) || field.getType() != pathField.getDeclaringClass()) continue;
            if (storageField != null) throw new IllegalStateException("Storage field ambiguous");
            storageField = field;
        }
        if (storageField == null) throw new IllegalStateException("Task storage absent");
        final Field path = pathField, storage = storageField;
        path.setAccessible(true); storage.setAccessible(true);
        Class<?> entry = Class.forName("local.mio.os4camerabridge.HookEntry", false, RearLivePhotoBridge.class.getClassLoader());
        Field active = field(entry, "commonApsUnifiedSessionActive");
        Field module = field(entry, "activeCameraModule");
        Field camera = field(entry, "activeCameraId");
        Field generation = field(entry, "commonApsUnifiedSessionGeneration");
        XposedBridge.hookMethod(setter, new XC_MethodHook() {
            @Override protected void afterHookedMethod(MethodHookParam p) {
                PENDING_PATH.remove();
                try {
                    if (p.hasThrowable() || !eligible(active, module, camera)) return;
                    String value = (String) p.args[0];
                    if (LivePhotoCapturePathPolicy.isNativeLivePath(value)) {
                        PENDING_PATH.set(new PendingPath(value, SystemClock.elapsedRealtimeNanos(),
                                System.currentTimeMillis(), generation.getInt(null)));
                    }
                } catch (Throwable t) { log("path observation rejected: " + t); }
            }
        });
        XposedBridge.hookMethod(start, new XC_MethodHook() {
            @Override protected void beforeHookedMethod(MethodHookParam p) {
                PendingPath pending = PENDING_PATH.get();
                PENDING_PATH.remove(); // Never lend this filename to another task or thread.
                if (pending == null || p.args[0] == null) return;
                try {
                    if (!eligible(active, module, camera)) return;
                    Object storageObject = storage.get(p.args[0]);
                    if (storageObject == null) return;
                    Object present = path.get(storageObject);
                    if (present instanceof String && !((String) present).isEmpty()) return;
                    long shotMillis = LivePhotoCapturePathPolicy.dateTakenMillis(p.args[0].toString());
                    long age = SystemClock.elapsedRealtimeNanos() - pending.nanos;
                    if (!LivePhotoCapturePathPolicy.mayTransfer(pending.path, age, pending.wallMillis,
                            shotMillis, pending.generation, generation.getInt(null))) {
                        log("path transfer rejected: ageNs=" + age + " shotDelta=" + (shotMillis - pending.wallMillis));
                        return;
                    }
                    path.set(storageObject, pending.path);
                    log("same-task Xiaomi path restored: " + pending.path + " ageNs=" + age
                            + " generation=" + pending.generation);
                } catch (Throwable t) { log("path transfer rejected: " + t); }
            }
        });
        log("bound path setter=" + setter + " capture=" + start + " storage=" + storage + " path=" + path);
    }

    private static boolean eligible(Field active, Field module, Field camera) throws IllegalAccessException {
        return active.getBoolean(null) && module.getInt(null) == 163 && camera.getInt(null) == 0;
    }
    private static Field field(Class<?> owner, String name) throws NoSuchFieldException {
        Field result = owner.getDeclaredField(name); result.setAccessible(true); return result;
    }
    private static final class PendingPath {
        final String path;
        final long nanos, wallMillis;
        final int generation;
        PendingPath(String path, long nanos, long wallMillis, int generation) {
            this.path = path; this.nanos = nanos; this.wallMillis = wallMillis; this.generation = generation;
        }
    }
}
