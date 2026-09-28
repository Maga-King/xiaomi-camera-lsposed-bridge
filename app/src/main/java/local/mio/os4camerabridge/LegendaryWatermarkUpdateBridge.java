package local.mio.os4camerabridge;

import android.app.Activity;
import android.os.Looper;
import android.os.SystemClock;
import android.widget.Toast;
import java.lang.ref.WeakReference;
import java.lang.reflect.Method;
import java.util.ArrayList;
import java.util.List;
import de.robv.android.xposed.XC_MethodHook;
import de.robv.android.xposed.XposedBridge;
import de.robv.android.xposed.XposedHelpers;

/** Keep manual watermark refresh manual, scoped to native watermark channels and worker calls. */
public final class LegendaryWatermarkUpdateBridge {
    private static final Object LOCK=new Object();
    private static long requestedAt,deadline;
    private static boolean photoPending,videoPending;
    private static final ThreadLocal<String> MANUAL_CHANNEL=new ThreadLocal<>();
    private static final ThreadLocal<Object> FILTER_OWNER=new ThreadLocal<>();
    private LegendaryWatermarkUpdateBridge() {}

    static void install(ClassLoader loader) throws Exception {
        Class<?> manager=XposedHelpers.findClass("Kh.i",loader);
        Class<?> source=XposedHelpers.findClass("Gh.q",loader);
        Class<?> requester=XposedHelpers.findClass("Te.g",loader);
        Class<?> callback=XposedHelpers.findClass("Kh.f",loader);
        Method click=manager.getDeclaredMethod("a",WeakReference.class,Float.class,boolean.class,boolean.class);
        Method load=source.getDeclaredMethod("a",source,String.class);
        Method request=requester.getDeclaredMethod("d",String.class,boolean.class,boolean.class);
        Method complete=callback.getDeclaredMethod("invoke",Object.class);
        if(click.getReturnType()!=void.class || load.getReturnType()!=String.class
                || !request.getReturnType().getName().equals("Qe.j"))throw new IllegalStateException("native refresh contract changed");

        XposedBridge.hookMethod(click,new XC_MethodHook() {
            @Override protected void beforeHookedMethod(MethodHookParam p) {
                if(!Boolean.TRUE.equals(p.args[2]))return; // Automatic Camera startup remains unchanged.
                Activity activity=(Activity)((WeakReference<?>)p.args[0]).get();
                if(activity==null || activity.isFinishing() || activity.isDestroyed())return;
                long now=SystemClock.elapsedRealtime();
                synchronized(LOCK) {
                    if(requestedAt!=0 && now-requestedAt<30000) {
                        p.setResult(null);message(activity,"正在检查或刚刚检查过，请稍后再试");return;
                    }
                    requestedAt=now;deadline=now+15000;
                    photoPending=true;videoPending=Boolean.TRUE.equals(p.args[3]);
                }
                message(activity,"正在检查水印更新");
                log("manual refresh armed; 30s debounce; no background interval/device-config change");
            }
        });
        XposedBridge.hookMethod(load,new XC_MethodHook() {
            @Override protected void beforeHookedMethod(MethodHookParam p) {
                if(Looper.myLooper()==Looper.getMainLooper())return;
                String channel=(String)p.args[1];boolean manual=false;
                synchronized(LOCK) {
                    if(SystemClock.elapsedRealtime()>deadline)return;
                    if(photoPending && "watermark_config".equals(channel)){photoPending=false;manual=true;}
                    if(videoPending && "video_watermark_config".equals(channel)){videoPending=false;manual=true;}
                }
                if(manual){p.setObjectExtra("manual",true);MANUAL_CHANNEL.set(channel);}
            }
            @Override protected void afterHookedMethod(MethodHookParam p) {
                if(Boolean.TRUE.equals(p.getObjectExtra("manual")))MANUAL_CHANNEL.remove();
            }
        });
        XposedBridge.hookMethod(request,new XC_MethodHook() {
            @Override protected void beforeHookedMethod(MethodHookParam p) {
                String channel=MANUAL_CHANNEL.get();
                if(channel==null || !channel.equals(p.args[0]))return;
                p.args[2]=true; // Stock force-network branch returns fresh data to this same worker call.
                p.setObjectExtra("manual",true);
                log("native force-network request channel="+channel);
            }
            @Override protected void afterHookedMethod(MethodHookParam p) {
                if(!Boolean.TRUE.equals(p.getObjectExtra("manual")))return;
                boolean ok=false;
                try{ok=!p.hasThrowable() && Boolean.TRUE.equals(XposedHelpers.callMethod(p.getResult(),"a"));}
                catch(Throwable ignored){}
                log("native manual result success="+ok+" channel="+p.args[0]);
            }
        });
        XposedBridge.hookMethod(complete,new XC_MethodHook() {
            @Override protected void beforeHookedMethod(MethodHookParam p) {
                if(!XposedHelpers.getBooleanField(p.thisObject,"a"))return;
                Object groups=p.args[0];
                log("manual download callback groups="+(groups instanceof List?((List<?>)groups).size():"null"));
                if(groups==null) {
                    Activity activity=(Activity)((WeakReference<?>)XposedHelpers.getObjectField(p.thisObject,"b")).get();
                    message(activity,"未获取到可用水印更新，已保留本地模板");
                }
            }
        });
        preserveLocalTemplate(loader);
        Class<?> filter=XposedHelpers.findClass("com.xiaomi.camera.cloudwatermark.nativebridge.WmNativeFilter",loader);
        XposedBridge.hookMethod(filter.getDeclaredMethod("a",String.class,String.class,boolean.class,boolean.class,float.class,long.class,int.class),new XC_MethodHook() {
            @Override protected void afterHookedMethod(MethodHookParam p) {
                String out=p.getResult() instanceof String?(String)p.getResult():null;
                log("native template filter brand="+p.args[1]+" leica="+p.args[2]+" redmi="+p.args[3]
                        +" mivi="+p.args[4]+" timestamp="+p.args[5]+" inputChars="+((String)p.args[0]).length()
                        +" outputChars="+(out==null?-1:out.length()));
            }
        });
        log("installed manual-only refresh and explicit no-result feedback; native server filtering retained");
    }

    private static void preserveLocalTemplate(ClassLoader loader) throws Exception {
        Class<?> base=XposedHelpers.findClass("Gg.P",loader);
        XposedBridge.hookMethod(base.getDeclaredMethod("d",boolean.class),new XC_MethodHook() {
            @Override protected void beforeHookedMethod(MethodHookParam p) {
                if("Gg.U".equals(p.thisObject.getClass().getName()))FILTER_OWNER.set(p.thisObject);
            }
            @Override protected void afterHookedMethod(MethodHookParam p) {
                if(FILTER_OWNER.get()==p.thisObject)FILTER_OWNER.remove();
            }
        });
        XposedBridge.hookMethod(base.getDeclaredMethod("f"),new XC_MethodHook() {
            @Override protected void afterHookedMethod(MethodHookParam p) {
                if(FILTER_OWNER.get()!=p.thisObject || !(p.getResult() instanceof List))return;
                List<?> ids=(List<?>)p.getResult();
                if(ids.isEmpty() || ids.contains("135"))return; // Empty means all local templates, never narrow it.
                ArrayList<Object> withLocal=new ArrayList<>(ids);withLocal.add("135");p.setResult(withLocal);
            }
        });
    }
    private static void message(Activity activity,String text) {
        if(activity==null || activity.isFinishing() || activity.isDestroyed())return;
        activity.runOnUiThread(()->Toast.makeText(activity,text,Toast.LENGTH_SHORT).show());
    }
    private static void log(String text){XposedBridge.log("[WatermarkUpdate] "+text);}
}
