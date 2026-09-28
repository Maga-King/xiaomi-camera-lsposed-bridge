package local.mio.os4camerabridge;

import java.lang.reflect.Method;
import de.robv.android.xposed.XC_MethodHook;
import de.robv.android.xposed.XposedBridge;
import de.robv.android.xposed.XposedHelpers;

/** Optional MAIN-only cloud sensor matrix. Does not gate StyleTrans, colorfix or M3 processing. */
public final class LegendaryCalibrationBridge {
    private static final ThreadLocal<Integer> CCT = new ThreadLocal<>();
    private static boolean installed;
    private LegendaryCalibrationBridge() {}
    static synchronized void install() throws Exception {
        if(installed)return;
        ClassLoader loader=LegendaryCalibrationBridge.class.getClassLoader();
        Class<?> container=Class.forName("local.mio.os4camerabridge.LegendM9Container",false,loader);
        Class<?> metadata=Class.forName("local.mio.os4camerabridge.LegendM9Container$Metadata",false,loader);
        Method wrap=container.getDeclaredMethod("wrap",byte[].class,byte[].class,float[].class,String.class,metadata);
        Method pack;
        try { pack=container.getDeclaredMethod("packToCloudBggr",byte[].class,int.class,int.class,String.class,int.class); }
        catch(NoSuchMethodException older) {
            // Deployed182 owns RGGB packing; its existing per-frame CFA bridge runs first.
            pack=container.getDeclaredMethod("packRggbToCloudBggr",byte[].class,int.class,int.class,String.class);
        }
        Method cipher=container.getDeclaredMethod("rc4XorInPlace",byte[].class,String.class);
        cipher.setAccessible(true);
        XposedBridge.hookMethod(wrap,new XC_MethodHook() {
            @Override protected void beforeHookedMethod(MethodHookParam p) {
                CCT.remove();
                if(LegendaryNativeCaptureBridge.matrixEnabledForContainer())
                    CCT.set(XposedHelpers.getIntField(p.args[4],"cct"));
            }
            @Override protected void afterHookedMethod(MethodHookParam p) { CCT.remove(); }
        });
        XposedBridge.hookMethod(pack,new XC_MethodHook() {
            @Override protected void afterHookedMethod(MethodHookParam p) {
                Integer cct=CCT.get();
                if(cct==null || p.hasThrowable() || !(p.getResult() instanceof byte[])) return;
                try {
                    long started=android.os.SystemClock.elapsedRealtime();
                    float[] matrix=LegendarySensorCalibration.select(cct);
                    if(matrix==null)throw new IllegalArgumentException("Unsupported calibration CCT");
                    byte[] clone=((byte[])p.getResult()).clone();
                    cipher.invoke(null,clone,p.args[3]);
                    long decoded=android.os.SystemClock.elapsedRealtime();
                    long changed=LegendarySensorCalibration.transform(clone,4096,3072,5120,matrix);
                    long transformed=android.os.SystemClock.elapsedRealtime();
                    cipher.invoke(null,clone,p.args[3]);
                    p.setResult(clone);
                    XposedBridge.log("[LegendaryCalibration] optional MAIN cloud matrix applied cct="+cct+" changed="+changed
                            +" rawSqrtContractPreserved=true nativeColorfixUnaffected=true decodeMs="+(decoded-started)
                            +" matrixMs="+(transformed-decoded)+" encodeMs="+(android.os.SystemClock.elapsedRealtime()-transformed));
                } catch(Throwable error) { XposedBridge.log("[LegendaryCalibration] original cloud RAW retained "+error); }
            }
        });
        installed=true;
    }
}
