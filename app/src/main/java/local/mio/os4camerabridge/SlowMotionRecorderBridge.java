package local.mio.os4camerabridge;

import android.media.MediaRecorder;
import android.media.MediaCodecInfo;
import android.hardware.camera2.CaptureRequest;
import java.nio.charset.StandardCharsets;
import android.view.Surface;
import java.lang.reflect.*;
import java.util.*;
import org.luckypray.dexkit.DexKitBridge;
import org.luckypray.dexkit.query.FindMethod;
import org.luckypray.dexkit.query.matchers.MethodMatcher;
import de.robv.android.xposed.*;

/** Uses the host's standard recorder branch, scoped to its slow-motion factory. */
public final class SlowMotionRecorderBridge {
    private static boolean enabled;
    private static Field activeModule;
    private static volatile boolean recording;
    private static final ThreadLocal<Integer> FACTORY_DEPTH = ThreadLocal.withInitial(() -> 0);
    private static final ThreadLocal<Boolean> SLOW_SETUP = ThreadLocal.withInitial(() -> false);
    private static final Map<Object, Surface> RECORDER_INPUTS = Collections.synchronizedMap(new WeakHashMap<>());
    private SlowMotionRecorderBridge() {}
    public static void enable() { enabled = true; }
    public static boolean isEnabled() { return enabled; }

    public static void bind(DexKitBridge kit, ClassLoader loader) {
        try {
            Class<?> entry = Class.forName("local.mio.os4camerabridge.HookEntry", false,
                    SlowMotionRecorderBridge.class.getClassLoader());
            activeModule = entry.getDeclaredField("activeCameraModule");
            activeModule.setAccessible(true);
            bindRecordState(loader);
            bindLockedComponent(kit, loader, "ComponentConfigSlowMotion", "slow_motion_240");
            bindLockedComponent(kit, loader, "ComponentConfigSlowMotionQuality", "6");
            var standard = kit.findMethod(FindMethod.create().matcher(MethodMatcher.create()
                    .usingStrings("setupMediaRecorder: null parameter", "setupMediaRecorder: null MediaRecorder")
                    .returnType(void.class).paramCount(1)));
            if (standard.size() != 1) throw new IllegalStateException("standard recorder count=" + standard.size());
            Class<?> standardClass = standard.get(0).getClassInstance(loader);
            Set<Class<?>> videoComponents = new LinkedHashSet<>();
            Class<?> videoModule = Class.forName("com.android.camera.module.VideoModule", false, loader);
            for (Class<?> c = videoModule; c != null; c = c.getSuperclass())
                for (Field f : c.getDeclaredFields()) if (!Modifier.isStatic(f.getModifiers()))
                    videoComponents.add(f.getType());
            var factories = kit.findMethod(FindMethod.create().matcher(MethodMatcher.create()
                    .usingStrings("createRecorder: reset cost: ", "initializeRecorder: createRecorder ")
                    .returnType(void.class).paramCount(0)));
            factories.removeIf(candidate -> {
                try {
                    if (!videoComponents.contains(candidate.getClassInstance(loader))) return true;
                    Map<Class<?>, Set<Method>> boolCalls = new LinkedHashMap<>();
                    for (var call : candidate.getInvokes()) if (call.isMethod()) {
                        Method m = call.getMethodInstance(loader);
                        if (!Modifier.isStatic(m.getModifiers()) && m.getReturnType() == boolean.class
                                && m.getParameterCount() == 0)
                            boolCalls.computeIfAbsent(m.getDeclaringClass(), k -> new LinkedHashSet<>()).add(m);
                    }
                    long pairs = boolCalls.values().stream().filter(s -> s.size() == 2).count();
                    XposedBridge.log("[SlowMotionRecorder] candidate=" + candidate.getMethodInstance(loader)
                            + " selectorPairs=" + pairs);
                    if (pairs != 1) return true;
                    for (Field f : candidate.getClassInstance(loader).getDeclaredFields())
                        if (f.getType().isInterface() && f.getType().isAssignableFrom(standardClass)) return false;
                } catch (Throwable ignored) {}
                return true;
            });
            if (factories.size() != 1) throw new IllegalStateException("typed factory count=" + factories.size());
            Method factory = factories.get(0).getMethodInstance(loader);
            Map<Class<?>, Set<Method>> grouped = new LinkedHashMap<>();
            for (var call : factories.get(0).getInvokes()) {
                if (!call.isMethod()) continue;
                Method m = call.getMethodInstance(loader);
                if (!Modifier.isStatic(m.getModifiers()) && m.getReturnType() == boolean.class
                        && m.getParameterCount() == 0)
                    grouped.computeIfAbsent(m.getDeclaringClass(), k -> new LinkedHashSet<>()).add(m);
            }
            List<Set<Method>> pairs = new ArrayList<>();
            for (Set<Method> set : grouped.values()) if (set.size() == 2) pairs.add(set);
            if (pairs.size() != 1) throw new IllegalStateException("recorder selector pairs=" + pairs.size());
            boolean mediaField = false, sharedContract = false;
            for (Field f : standardClass.getDeclaredFields()) if (f.getType() == MediaRecorder.class) mediaField = true;
            for (Field f : factory.getDeclaringClass().getDeclaredFields())
                if (f.getType().isInterface() && f.getType().isAssignableFrom(standardClass)) sharedContract = true;
            if (!mediaField || !sharedContract) throw new IllegalStateException("standard recorder contract mismatch");
            XposedHelpers.findAndHookMethod(MediaRecorder.class, "setInputSurface", Surface.class, new XC_MethodHook() {
                @Override protected void afterHookedMethod(MethodHookParam p) throws Throwable {
                    if (activeModule.getInt(null) != 172) return;
                    RECORDER_INPUTS.put(p.thisObject, (Surface)p.args[0]);
                    XposedBridge.log("[SlowMotionRecorder] setInput recorder=" + System.identityHashCode(p.thisObject)
                            + " input=" + p.args[0] + " error=" + p.getThrowable());
                }
            });
            XposedHelpers.findAndHookMethod(MediaRecorder.class, "prepare", new XC_MethodHook() {
                @Override protected void afterHookedMethod(MethodHookParam p) throws Throwable {
                    Surface input = RECORDER_INPUTS.get(p.thisObject);
                    if (input == null) return;
                    StringBuilder details = new StringBuilder();
                    for (Field f : MediaRecorder.class.getDeclaredFields()) if (Surface.class.isAssignableFrom(f.getType())) {
                        f.setAccessible(true); details.append(' ').append(f.getName()).append('=').append(f.get(p.thisObject));
                    }
                    XposedBridge.log("[SlowMotionRecorder] prepared recorder=" + System.identityHashCode(p.thisObject)
                            + " supplied=" + input + details + " error=" + p.getThrowable());
                    try {
                        Surface actual = ((MediaRecorder)p.thisObject).getSurface();
                        Class<?> utils = Class.forName("android.hardware.camera2.utils.SurfaceUtils");
                        Method id = utils.getDeclaredMethod("getSurfaceId", Surface.class); id.setAccessible(true);
                        XposedBridge.log("[SlowMotionRecorder] producer supplied=" + id.invoke(null, input)
                                + " actual=" + id.invoke(null, actual) + " output=" + actual);
                    } catch (Throwable error) { XposedBridge.log("[SlowMotionRecorder] producer inspect=" + error); }
                }
            });
            XposedBridge.hookMethod(standard.get(0).getMethodInstance(loader), new XC_MethodHook() {
                @Override protected void beforeHookedMethod(MethodHookParam p) throws Throwable {
                    p.setObjectExtra("previousSlowSetup", SLOW_SETUP.get());
                    SLOW_SETUP.set(activeModule.getInt(null) == 172);
                }
                @Override protected void afterHookedMethod(MethodHookParam p) {
                    SLOW_SETUP.set(Boolean.TRUE.equals(p.getObjectExtra("previousSlowSetup")));
                }
            });
            XposedHelpers.findAndHookMethod(MediaRecorder.class, "setVideoFrameRate", int.class, new XC_MethodHook() {
                @Override protected void beforeHookedMethod(MethodHookParam p) {
                    if (SLOW_SETUP.get()) { p.args[0] = 30; XposedBridge.log("[SlowMotionRecorder] playback=30; capture rate retained"); }
                }
            });
            // The current HAL stream is TP10_UBWC, even with SDR session metadata.
            // Main (8-bit) rejects every buffer. Match that producer explicitly;
            // do not pretend changing a UI HDR flag converts the input pixels.
            XposedHelpers.findAndHookMethod(MediaRecorder.class, "setVideoEncoder", int.class, new XC_MethodHook() {
                @Override protected void afterHookedMethod(MethodHookParam p) {
                    if (!SLOW_SETUP.get() || p.hasThrowable() || ((Integer)p.args[0]) != MediaRecorder.VideoEncoder.HEVC) return;
                    ((MediaRecorder)p.thisObject).setVideoEncodingProfileLevel(
                            MediaCodecInfo.CodecProfileLevel.HEVCProfileMain10,
                            MediaCodecInfo.CodecProfileLevel.HEVCMainTierLevel51);
                    XposedBridge.log("[SlowMotionRecorder] HEVC Main10 matches HAL TP10 input");
                }
            });
            XposedHelpers.findAndHookMethod(MediaRecorder.class, "setVideoEncodingBitRate", int.class, new XC_MethodHook() {
                @Override protected void beforeHookedMethod(MethodHookParam p) {
                    if (SLOW_SETUP.get()) p.args[0] = 12000000;
                }
            });
            for (String name : new String[]{"setAudioSource", "setAudioEncoder", "setAudioChannels",
                    "setAudioEncodingBitRate", "setAudioSamplingRate"})
                XposedHelpers.findAndHookMethod(MediaRecorder.class, name, int.class, new XC_MethodHook() {
                    @Override protected void beforeHookedMethod(MethodHookParam p) {
                        if (SLOW_SETUP.get()) p.setResult(null);
                    }
                });
            for (Method selector : pairs.get(0)) XposedBridge.hookMethod(selector, new XC_MethodHook() {
                @Override protected void beforeHookedMethod(MethodHookParam p) {
                    if (FACTORY_DEPTH.get() > 0) p.setResult(false);
                }
            });
            XposedBridge.hookMethod(factory, new XC_MethodHook() {
                @Override protected void beforeHookedMethod(MethodHookParam p) throws Throwable {
                    if (activeModule.getInt(null) != 172) return;
                    p.setObjectExtra("slowRecorderScope", true);
                    FACTORY_DEPTH.set(FACTORY_DEPTH.get() + 1);
                    XposedBridge.log("[SlowMotionRecorder] scoped standard recorder factory");
                }
                @Override protected void afterHookedMethod(MethodHookParam p) {
                    if (Boolean.TRUE.equals(p.getObjectExtra("slowRecorderScope")))
                        FACTORY_DEPTH.set(Math.max(0, FACTORY_DEPTH.get() - 1));
                }
            });
            XposedBridge.log("[SlowMotionRecorder] bound factory=" + factory + " selectors=" + pairs.get(0)
                    + " standard=" + standardClass.getName());
        } catch (Throwable error) {
            XposedBridge.log("[SlowMotionRecorder] not bound: " + error);
        }
    }

    private static void bindRecordState(ClassLoader loader) {
        final CaptureRequest.Key<byte[]> cameraMode = new CaptureRequest.Key<>("com.oplus.camera.mode", byte[].class);
        final CaptureRequest.Key<Integer> recordState = new CaptureRequest.Key<>("com.oplus.video.record.state", Integer.class);
        final CaptureRequest.Key<Integer> eisState = new CaptureRequest.Key<>("com.oplus.eis.record.state", Integer.class);
        final CaptureRequest.Key<Byte> eos = new CaptureRequest.Key<>("org.quic.camera.recording.endOfStream", Byte.class);
        XposedHelpers.findAndHookMethod(CaptureRequest.Builder.class, "build", new XC_MethodHook() {
            @Override protected void beforeHookedMethod(MethodHookParam p) throws Throwable {
                if (activeModule.getInt(null) != 172) return;
                CaptureRequest.Builder builder = (CaptureRequest.Builder)p.thisObject;
                builder.set(cameraMode, "slowvideo_mode\0".getBytes(StandardCharsets.US_ASCII));
                builder.set(recordState, recording ? 1 : 0);
                builder.set(eisState, recording ? 1 : 0);
                builder.set(eos, (byte)0);
            }
        });
        XposedHelpers.findAndHookMethod(MediaRecorder.class, "start", new XC_MethodHook() {
            @Override protected void afterHookedMethod(MethodHookParam p) throws Throwable {
                if (activeModule.getInt(null) == 172 && !p.hasThrowable()) {
                    recording = true;
                    XposedBridge.log("[SlowMotionRecorder] OPlus capture record state=1");
                }
            }
        });
        XposedBridge.hookAllMethods(XposedHelpers.findClass("com.android.camera.module.VideoModule", loader),
                "stopVideoRecording", new XC_MethodHook() {
                    @Override protected void beforeHookedMethod(MethodHookParam p) { recording = false; }
                });
        for (String name : new String[]{"reset", "release"}) XposedHelpers.findAndHookMethod(MediaRecorder.class,
                name, new XC_MethodHook() {
                    @Override protected void beforeHookedMethod(MethodHookParam p) { if (RECORDER_INPUTS.containsKey(p.thisObject)) recording = false; }
                });
    }

    private static void bindLockedComponent(DexKitBridge kit, ClassLoader loader, String tag, String value) throws Throwable {
        var tags = kit.findMethod(FindMethod.create().matcher(MethodMatcher.create()
                .name("getTag").usingStrings(tag).returnType(String.class).paramCount(0)));
        // Literal matching may include the Quality suffix; verify the returned tag.
        tags.removeIf(d -> !d.getUsingStrings().contains(tag));
        if (tags.size() != 1) throw new IllegalStateException("component " + tag + " count=" + tags.size());
        Class<?> owner = tags.get(0).getClassInstance(loader);
        Field items = null;
        for (Class<?> c = owner; c != null; c = c.getSuperclass()) {
            try { items = c.getDeclaredField("mItems"); break; } catch (NoSuchFieldException ignored) {}
        }
        if (items == null || !List.class.isAssignableFrom(items.getType())) throw new IllegalStateException("component item list missing");
        final Field itemField = items; itemField.setAccessible(true);
        XC_MethodHook prune = new XC_MethodHook() {
            @Override protected void afterHookedMethod(MethodHookParam p) throws Throwable {
                Object raw = itemField.get(p.thisObject);
                if (!(raw instanceof List<?>)) return;
                List<Object> kept = new ArrayList<>();
                for (Object item : (List<?>) raw) {
                    if (item == null) continue;
                    boolean match = false;
                    for (Field f : item.getClass().getDeclaredFields()) if (f.getType() == String.class && !Modifier.isStatic(f.getModifiers())) {
                        f.setAccessible(true); if (value.equals(f.get(item))) match = true;
                    }
                    if (match) kept.add(item);
                }
                if (((List<?>)raw).size() != kept.size()) itemField.set(p.thisObject, kept);
                if (p.method instanceof Method && ((Method)p.method).getName().equals("getItems")) p.setResult(kept);
            }
        };
        for (Method m : owner.getDeclaredMethods()) {
            if (m.getName().equals("getItems") || (m.getReturnType() == void.class && m.getParameterCount() == 1))
                XposedBridge.hookMethod(m, prune);
        }
        for (String getter : new String[]{"getComponentValue", "getDefaultValue"})
            XposedHelpers.findAndHookMethod(owner, getter, int.class, new XC_MethodHook() {
                @Override protected void beforeHookedMethod(MethodHookParam p) {
                    if (((Integer)p.args[0]) == 172) p.setResult(value);
                }
            });
        // Prevent old saved high-rate selections from being written back by UI callbacks.
        Method setter = owner.getMethod("setComponentValue", int.class, String.class);
        XposedBridge.hookMethod(setter, new XC_MethodHook() {
            @Override protected void beforeHookedMethod(MethodHookParam p) {
                if (owner.isInstance(p.thisObject) && ((Integer)p.args[0]) == 172) p.args[1] = value;
            }
        });
        XposedBridge.log("[SlowMotionRecorder] component locked " + owner.getName() + "=" + value);
    }
}
