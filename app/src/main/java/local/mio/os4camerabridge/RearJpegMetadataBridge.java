package local.mio.os4camerabridge;

import java.lang.reflect.Field;
import java.lang.reflect.Method;
import java.util.concurrent.atomic.AtomicInteger;
import de.robv.android.xposed.XC_MethodHook;
import de.robv.android.xposed.XposedBridge;

/** 仅修普通后摄 APS 的元数据移植，不改其他模式的私有容器。 */
public final class RearJpegMetadataBridge {
    private static boolean installed;
    private static final AtomicInteger LOGS = new AtomicInteger();
    private RearJpegMetadataBridge() {}
    public static synchronized void install(ClassLoader ignored) {
        if (installed) return;
        try {
            Class<?> entry = Class.forName("local.mio.os4camerabridge.HookEntry", false,
                    RearJpegMetadataBridge.class.getClassLoader());
            Field module = field(entry, "activeCameraModule", int.class);
            Field camera = field(entry, "activeCameraId", int.class);
            Field unified = field(entry, "commonApsUnifiedSessionActive", boolean.class);
            Method transfer = entry.getDeclaredMethod("transplantAppMetadata", byte[].class, byte[].class);
            if (transfer.getReturnType() != byte[].class) throw new IllegalStateException("移植方法签名不符");
            XposedBridge.hookMethod(transfer, new XC_MethodHook() {
                @Override protected void beforeHookedMethod(MethodHookParam p) {
                    try {
                        if (module.getInt(null) != 163 || camera.getInt(null) != 0 || !unified.getBoolean(null)) return;
                        byte[] source = (byte[]) p.args[0], target = (byte[]) p.args[1];
                        byte[] result = RearJpegMetadataPolicy.transfer(source, target);
                        p.setResult(result);
                        if (LOGS.getAndIncrement() < 12) XposedBridge.log("[RearJpegMetadata] source="
                                + source.length + " encoded=" + target.length + " output=" + result.length
                                + " encodedRetained=" + (result == target) + "; ICC follows encoded pixels");
                    } catch (Throwable t) {
                        XposedBridge.log("[RearJpegMetadata] transfer rejected: " + t);
                        p.setThrowable(t);
                    }
                }
            });
            installed = true;
            XposedBridge.log("[RearJpegMetadata] installed v1; rear163 unified only; no pixel conversion");
        } catch (Throwable t) { XposedBridge.log("[RearJpegMetadata] install rejected: " + t); }
    }
    private static Field field(Class<?> owner, String name, Class<?> type) throws Exception {
        Field value = owner.getDeclaredField(name);
        if (value.getType() != type) throw new IllegalStateException("字段类型不符: " + name);
        value.setAccessible(true);
        return value;
    }
}
