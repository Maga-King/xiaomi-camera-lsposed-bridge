package local.mio.os4camerabridge;

import de.robv.android.xposed.XC_MethodHook;
import de.robv.android.xposed.XposedBridge;

/** Hooks our container boundary only; never changes Gallery selection, RAW, or device identity. */
public final class LegendaryWatermarkBridge {
    private static boolean installed;
    private LegendaryWatermarkBridge() {}
    public static synchronized void install(ClassLoader cameraLoader) {
        if(installed)return;
        try {
            Class<?> container=Class.forName("local.mio.os4camerabridge.LegendM9Container",false,
                    LegendaryWatermarkBridge.class.getClassLoader());
            if(XposedBridge.hookAllMethods(container,"addM9Container",new XC_MethodHook() {
                @Override protected void afterHookedMethod(MethodHookParam p) {
                    preserve(p,((byte[])p.args[1]).length+((byte[])p.args[2]).length);
                }
            }).isEmpty())throw new IllegalStateException("M9 container boundary missing");
            if(XposedBridge.hookAllMethods(container,"addM3Container",new XC_MethodHook() {
                @Override protected void afterHookedMethod(MethodHookParam p) { preserve(p,0); }
            }).isEmpty())throw new IllegalStateException("M3 container boundary missing");
            installed=true;
            XposedBridge.log("[LegendaryWatermark] native watermark metadata preserved, optional frame ROI accepted; no Gallery override");
            try { LegendaryWatermarkResources.install(cameraLoader); }
            catch(Throwable failure) { XposedBridge.log("[LegendaryWatermark] resource scanner unavailable; capture repair stays active: "+failure); }
            try { LegendaryWatermarkUpdateBridge.install(cameraLoader); }
            catch(Throwable failure) { XposedBridge.log("[LegendaryWatermark] update bridge unavailable; capture repair stays active: "+failure); }
        } catch(Throwable failure) { XposedBridge.log("[LegendaryWatermark] install failed: "+failure); }
    }
    private static void preserve(XC_MethodHook.MethodHookParam p,int tail) {
        if(p.hasThrowable() || !(p.getResult() instanceof byte[]))return;
        try {
            byte[] original=(byte[])p.args[0],encoded=(byte[])p.getResult();
            byte[] result=LegendaryWatermarkContainer.preserve(original,encoded,tail);
            p.setResult(result);
            int[] size=JpegWatermarkMetadataPolicy.dimensions(original);
            XposedBridge.log("[LegendaryWatermark] preserved native metadata primary="+size[0]+"x"+size[1]
                    +" tailAdded="+tail+" bytes="+encoded.length+"->"+result.length+" pixelsAndRawUnchanged=true");
        } catch(Throwable invalid) {
            // A missing Legend container is preferable to claiming valid removal bounds over RAW bytes.
            p.setThrowable(invalid);
            XposedBridge.log("[LegendaryWatermark] container rejected; native JPEG remains available: "+invalid);
        }
    }
}
