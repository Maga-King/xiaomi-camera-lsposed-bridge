package local.mio.os4camerabridge;

import android.hardware.camera2.CameraCharacteristics;
import android.hardware.camera2.CaptureResult;
import java.lang.reflect.Method;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Map;
import java.util.WeakHashMap;
import de.robv.android.xposed.XC_MethodHook;
import de.robv.android.xposed.XposedBridge;
import de.robv.android.xposed.XposedHelpers;

/** Bind physical CFA to a same-frame metadata object, not the current UI lens at save time. */
public final class LegendaryRawCfaBridge {
    private record Frame(int cfa, int camera, long timestamp) {}
    private static final Map<Object,Frame> FRAMES = Collections.synchronizedMap(new WeakHashMap<>());
    private static boolean installed;
    private LegendaryRawCfaBridge() {}
    public static synchronized void install(ClassLoader ignored) {
        if (installed) return;
        ArrayList<XC_MethodHook.Unhook> hooks = new ArrayList<>();
        try {
            ClassLoader own=LegendaryRawCfaBridge.class.getClassLoader();
            Class<?> entry=Class.forName("local.mio.os4camerabridge.HookEntry",false,own);
            Class<?> container=Class.forName("local.mio.os4camerabridge.LegendM9Container",false,own);
            Class<?> meta=Class.forName("local.mio.os4camerabridge.LegendM9Container$Metadata",false,own);
            // Refuse a different container which may already own CFA conversion.
            container.getDeclaredMethod("packRggbToCloudBggr",byte[].class,int.class,int.class,String.class);
            Method metadata=entry.getDeclaredMethod("legendMetadata",CaptureResult.class,CaptureResult.class,int.class,int.class);
            Method wrap=container.getDeclaredMethod("wrap",byte[].class,byte[].class,float[].class,String.class,meta);
            hooks.add(XposedBridge.hookMethod(metadata,new XC_MethodHook() {
                @Override protected void afterHookedMethod(MethodHookParam p) {
                    if(p.hasThrowable() || p.getResult()==null) return;
                    try {
                        CaptureResult result=(CaptureResult)p.args[0];
                        int camera=(Integer)p.args[3];
                        if(camera==0) {
                            String physical=result.get(CaptureResult.LOGICAL_MULTI_CAMERA_ACTIVE_PHYSICAL_ID);
                            if(physical==null) throw new IllegalStateException("Logical result has no physical ID");
                            camera=Integer.parseInt(physical);
                        }
                        Map<?,?> chars=(Map<?,?>)XposedHelpers.getStaticObjectField(entry,"CAMERA_CHARACTERISTICS");
                        CameraCharacteristics c=(CameraCharacteristics)chars.get(String.valueOf(camera));
                        if(c==null) throw new IllegalStateException("Physical characteristics absent");
                        Integer cfa=c.get(CameraCharacteristics.SENSOR_INFO_COLOR_FILTER_ARRANGEMENT);
                        Float focal=result.get(CaptureResult.LENS_FOCAL_LENGTH);
                        float[] focals=c.get(CameraCharacteristics.LENS_INFO_AVAILABLE_FOCAL_LENGTHS);
                        Long ts=result.get(CaptureResult.SENSOR_TIMESTAMP);
                        boolean match=false;
                        if(focal!=null && focals!=null) for(float f:focals) if(Math.abs(f-focal)<0.02f) match=true;
                        if(!match || ts==null || ts<=0 || cfa==null || cfa<0 || cfa>3)
                            throw new IllegalStateException("CFA/result lens binding invalid");
                        FRAMES.put(p.getResult(),new Frame(cfa,camera,ts));
                    } catch(Throwable t) { log("frame binding rejected " + t); }
                }
            }));
            hooks.add(XposedBridge.hookMethod(wrap,new XC_MethodHook(9000) {
                @Override protected void beforeHookedMethod(MethodHookParam p) {
                    Frame frame=FRAMES.remove(p.args[4]);
                    if(frame==null) { log("no bound CFA; original packer retained"); return; }
                    try {
                        byte[] original=(byte[])p.args[1];
                        byte[] canonical=LegendaryRawCfaLayout.toRggb(original,4096,3072,frame.cfa);
                        p.args[1]=canonical;
                        log("ts="+frame.timestamp+" camera="+frame.camera+" sourceCfa="+frame.cfa
                                +" -> legacyRGGB changed="+(canonical!=original)+" JPEG/LSC/orientation unchanged");
                    } catch(Throwable t) { log("RAW canonicalization rejected " + t); }
                }
            }));
            installed=true;
            log("installed per-frame physical CFA; main bytes unchanged; no color calibration guessed");
        } catch(Throwable t) { for(XC_MethodHook.Unhook hook:hooks) hook.unhook(); log("install rejected "+t); }
    }
    private static void log(String message) { XposedBridge.log("[LegendaryRawCfa] "+message); }
}
