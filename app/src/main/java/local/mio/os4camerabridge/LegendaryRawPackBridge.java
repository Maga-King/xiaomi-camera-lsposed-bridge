package local.mio.os4camerabridge;

import android.app.Application;
import android.content.Context;
import android.os.SystemClock;
import java.io.File;
import java.lang.reflect.Method;
import de.robv.android.xposed.XC_MethodHook;
import de.robv.android.xposed.XposedBridge;
import de.robv.android.xposed.XposedHelpers;

/** Accelerate only the verified legacy pixel loop; preserve per-frame CFA, transfer and optional calibration. */
public final class LegendaryRawPackBridge {
    private static boolean loaded,disabled;
    private static final Object LOCK=new Object();
    private LegendaryRawPackBridge() {}
    private static native byte[] packPixels(byte[] source,int[] transfer);
    static void install() throws Exception {
        Class<?> container=Class.forName("local.mio.os4camerabridge.LegendM9Container",false,LegendaryRawPackBridge.class.getClassLoader());
        Method pack=container.getDeclaredMethod("packRggbToCloudBggr",byte[].class,int.class,int.class,String.class);
        Method transfer=container.getDeclaredMethod("buildTransferLut",int.class,int.class);
        Method cipher=container.getDeclaredMethod("rc4XorInPlace",byte[].class,String.class);
        transfer.setAccessible(true);cipher.setAccessible(true);
        // Runs AFTER existing before-hooks, so their after-hooks (including optional chart matrix) remain active.
        XposedBridge.hookMethod(pack,new XC_MethodHook(-10000) {
            @Override protected void beforeHookedMethod(MethodHookParam p) {
                synchronized(LOCK) {
                    if(disabled)return;
                    try {
                        long started=SystemClock.elapsedRealtime();load();
                        byte[] source=(byte[])p.args[0];
                        int[] lut=(int[])transfer.invoke(null,p.args[1],p.args[2]);
                        byte[] fast=packPixels(source,lut);
                        if(fast==null || fast.length!=source.length)throw new IllegalStateException("native RAW length");
                        // r13 compared all 15,728,640 encrypted bytes on two independent real captures.
                        // Keep 8,192 independent integer sample checks on EVERY frame without rerunning
                        // the slow full Java pixel loop each time Camera starts.
                        LegendaryRawPackValidation.check(source,fast,lut);
                        cipher.invoke(null,fast,p.args[3]);
                        long fastMs=SystemClock.elapsedRealtime()-started;
                        p.setResult(fast);
                        log("native pixel loop+original cipher ms="+fastMs+" bytes="+fast.length+" checkedSamples=8192 originalTransfer=true subsequentCalibration=true");
                    }catch(Throwable failure){disabled=true;log("legacy packer retained: "+failure);}
                }
            }
        });
    }
    private static void load() throws Exception {
        if(loaded)return;
        Application app=(Application)XposedHelpers.callStaticMethod(Class.forName("android.app.ActivityThread"),"currentApplication");
        if(app==null)throw new IllegalStateException("Application absent");
        Context module=app.createPackageContext("local.mio.os4camerabridge",Context.CONTEXT_IGNORE_SECURITY);
        System.load(new File(module.getApplicationInfo().nativeLibraryDir,"liblegend_raw_pack.so").getPath());
        loaded=true;
    }
    private static void log(String message){XposedBridge.log("[LegendaryRawPack] "+message);}
}
