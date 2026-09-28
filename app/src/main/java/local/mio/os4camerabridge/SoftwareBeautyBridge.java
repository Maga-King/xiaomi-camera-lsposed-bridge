package local.mio.os4camerabridge;

import android.graphics.Bitmap;
import android.util.Size;
import android.os.SystemClock;
import java.lang.reflect.*;
import java.util.*;
import org.luckypray.dexkit.DexKitBridge;
import org.luckypray.dexkit.query.*;
import org.luckypray.dexkit.query.matchers.*;
import de.robv.android.xposed.*;

/** Front Photo only until portrait's separate saving contract has also been verified. */
public final class SoftwareBeautyBridge {
    private static volatile boolean enabled, ready, beautySelected;
    private static volatile int level;
    private static Field camera, mode;
    private static long retryAt, lastLog;
    private static final ThreadLocal<SoftwareSkinSmoothing> FILTER = ThreadLocal.withInitial(SoftwareSkinSmoothing::new);
    private static final ThreadLocal<Integer> PANEL_READ_DEPTH = ThreadLocal.withInitial(()->0);
    private static final String KEY = "pref_beautify_skin_smooth_ratio_key";
    private SoftwareBeautyBridge() {}
    public static void enable() { enabled=true; }
    public static boolean isEnabled() { return enabled; }

    public static void bind(DexKitBridge kit, ClassLoader loader) {
        try {
            Class<?> entry=Class.forName("local.mio.os4camerabridge.HookEntry",false,SoftwareBeautyBridge.class.getClassLoader());
            camera=entry.getDeclaredField("activeCameraId"); mode=entry.getDeclaredField("activeBeautyModule");
            camera.setAccessible(true); mode.setAccessible(true);
            var panels=kit.findMethod(FindMethod.create().matcher(MethodMatcher.create()
                    .usingStrings("BeautySmoothLevelFragment").returnType(String.class).paramCount(0)));
            if(panels.size()!=1) throw new IllegalStateException("smooth panel count="+panels.size());
            Class<?> panel=panels.get(0).getClassInstance(loader);
            var selectedMethods=kit.findMethod(FindMethod.create().matcher(MethodMatcher.create()
                    .declaredClass(panel).returnType(boolean.class).paramCount(0)));
            if(selectedMethods.size()!=1) throw new IllegalStateException("beauty enabled selector count="+selectedMethods.size());
            final Method selectedMethod=selectedMethods.get(0).getMethodInstance(loader);
            selectedMethod.setAccessible(true);
            var uses=kit.findMethod(FindMethod.create().matcher(MethodMatcher.create().declaredClass(panel).usingStrings(KEY)));
            Set<Method> readers=new LinkedHashSet<>(),writers=new LinkedHashSet<>();
            for(var use:uses) for(var call:use.getInvokes()) {
                if(!call.isMethod()) continue;
                Method method=call.getMethodInstance(loader); Class<?>[] params=method.getParameterTypes();
                if(!Modifier.isStatic(method.getModifiers()) || params.length!=2) continue;
                if(method.getReturnType()==int.class && params[0]==String.class && !params[1].isPrimitive()) readers.add(method);
                if(method.getReturnType()==void.class && params[0]==int.class && params[1]==String.class) writers.add(method);
            }
            if(readers.isEmpty() || readers.size()>2 || writers.size()!=1)
                throw new IllegalStateException("beauty value boundary readers="+readers+" writers="+writers);
            // Stored-value getter calls the default getter, not vice versa. Keep only
            // the outer stored-value reader so default=40 cannot overwrite slider=100.
            Set<Method> defaults=new LinkedHashSet<>();
            for(var use:uses) for(var call:use.getInvokes()) {
                if(!call.isMethod() || !readers.contains(call.getMethodInstance(loader))) continue;
                for(var nested:call.getInvokes()) if(nested.isMethod()) {
                    Method child=nested.getMethodInstance(loader);
                    if(readers.contains(child) && !child.equals(call.getMethodInstance(loader))) defaults.add(child);
                }
            }
            readers.removeAll(defaults);
            if(readers.size()!=1) throw new IllegalStateException("stored beauty reader ambiguous: "+readers);
            // These strings occur in constructors, not class field constants. Resolve their
            // actual declaring owners, then validate the draw/buffer graph before any hook.
            var engines=kit.findMethod(FindMethod.create().matcher(MethodMatcher.create()
                    .usingStrings("New PreviewRenderEngine instance isSupport10Bit: ")));
            var doubles=kit.findMethod(FindMethod.create().matcher(MethodMatcher.create().usingStrings("New DoubleBuffer")));
            Set<Class<?>> engineOwners=new LinkedHashSet<>(),doubleOwners=new LinkedHashSet<>();
            for(var candidate:engines) engineOwners.add(candidate.getClassInstance(loader));
            for(var candidate:doubles) doubleOwners.add(candidate.getClassInstance(loader));
            // Camera has another DoubleBuffer implementation with the same diagnostic.
            // Accept only buffer types actually held by the resolved preview engine.
            Set<Class<?>> referencedBuffers=new LinkedHashSet<>();
            for(Class<?> owner:engineOwners) for(Field field:owner.getDeclaredFields())
                if(!Modifier.isStatic(field.getModifiers()) && doubleOwners.contains(field.getType())) referencedBuffers.add(field.getType());
            doubleOwners.retainAll(referencedBuffers);
            if(engineOwners.size()!=1 || doubleOwners.size()!=1)
                throw new IllegalStateException("preview owners engines="+engineOwners+" doubles="+doubleOwners);
            Class<?> engine=engineOwners.iterator().next(),doubleType=doubleOwners.iterator().next();
            var draws=kit.findMethod(FindMethod.create().matcher(MethodMatcher.create().declaredClass(engine)
                    .returnType(void.class).paramTypes(int.class,boolean.class)));
            if(draws.size()!=1) throw new IllegalStateException("OES materialize count="+draws.size());
            Method draw=draws.get(0).getMethodInstance(loader);
            Set<Field> holders=new LinkedHashSet<>(),inputs=new LinkedHashSet<>();
            for(var use:draws.get(0).getUsingFields()) {
                Field field=use.getField().getFieldInstance(loader);
                if(field.getDeclaringClass()==engine && field.getType()==doubleType) holders.add(field);
                if(field.getDeclaringClass()==doubleType && !Modifier.isStatic(field.getModifiers())) inputs.add(field);
            }
            if(holders.size()!=1 || inputs.size()!=1) throw new IllegalStateException("double-buffer contract ambiguous");
            Field holder=holders.iterator().next(),input=inputs.iterator().next(),output=null;
            for(Field field:doubleType.getDeclaredFields()) if(!field.equals(input) && field.getType()==input.getType()) {
                if(output!=null) throw new IllegalStateException("multiple output buffers"); output=field;
            }
            if(output==null) throw new IllegalStateException("no output buffer");
            // Array semantics are independently checked against this APK's FBO allocator/release.
            // Remaining per-version field aliases are type-checked, not advertised as universal.
            Class<?> buffer=input.getType();
            Field texture=buffer.getDeclaredField("b"),framebuffer=buffer.getDeclaredField("c");
            if(texture.getType()!=int[].class || framebuffer.getType()!=int[].class) throw new IllegalStateException("buffer array mismatch");
            Field size=null;
            for(Field field:buffer.getDeclaredFields()) if(field.getType()==Size.class) {
                if(size!=null) throw new IllegalStateException("ambiguous size"); size=field;
            }
            if(size==null) throw new IllegalStateException("missing size");
            Set<Method> gates=new LinkedHashSet<>();
            var bools=kit.findMethod(FindMethod.create().matcher(MethodMatcher.create().declaredClass(engine)
                    .returnType(boolean.class).paramCount(0)));
            for(var candidate:bools) {
                Set<Field> collectionFields=new LinkedHashSet<>();
                for(var use:candidate.getUsingFields()) {
                    Field field=use.getField().getFieldInstance(loader);
                    if(field.getDeclaringClass()==engine && field.getType()==ArrayList.class) collectionFields.add(field);
                }
                if(collectionFields.size()==2) gates.add(candidate.getMethodInstance(loader));
            }
            if(gates.size()!=1) throw new IllegalStateException("materialization gate count="+gates.size());
            for(Field field:new Field[]{holder,input,output,texture,framebuffer,size}) field.setAccessible(true);
            final Field out=output,dimensions=size;
            for(var use:uses) if(use.isMethod()) XposedBridge.hookMethod(use.getMethodInstance(loader),new XC_MethodHook(){
                @Override protected void beforeHookedMethod(MethodHookParam p){PANEL_READ_DEPTH.set(PANEL_READ_DEPTH.get()+1);}
                @Override protected void afterHookedMethod(MethodHookParam p){
                    PANEL_READ_DEPTH.set(Math.max(0,PANEL_READ_DEPTH.get()-1));
                    if(!p.hasThrowable()) try {
                        beautySelected=Boolean.TRUE.equals(selectedMethod.invoke(p.thisObject));
                        if(PANEL_READ_DEPTH.get()==0) XposedBridge.log("[SoftwareBeauty] panel enabled="+beautySelected+" level="+level);
                    } catch(Throwable ignored){beautySelected=false;}
                }
            });
            for(Method reader:readers) XposedBridge.hookMethod(reader,new XC_MethodHook(){
                @Override protected void afterHookedMethod(MethodHookParam p){
                    if(PANEL_READ_DEPTH.get()>0 && KEY.equals(p.args[0]) && !p.hasThrowable() && p.getResult() instanceof Integer)
                        level=clamp((Integer)p.getResult());
                }
            });
            XposedBridge.hookMethod(writers.iterator().next(),new XC_MethodHook(){
                @Override protected void afterHookedMethod(MethodHookParam p){
                    if(KEY.equals(p.args[1]) && !p.hasThrowable()) {
                        level=clamp((Integer)p.args[0]); XposedBridge.log("[SoftwareBeauty] slider="+level);
                    }
                }
            });
            XposedBridge.hookMethod(gates.iterator().next(),new XC_MethodHook(){
                @Override protected void afterHookedMethod(MethodHookParam p){if(strength()>0) p.setResult(true);}
            });
            XposedBridge.hookMethod(draw,new XC_MethodHook(){
                @Override protected void afterHookedMethod(MethodHookParam p){
                    float amount=strength(); long now=SystemClock.elapsedRealtime();
                    if(amount<=0 || !Boolean.TRUE.equals(p.args[1]) || p.hasThrowable() || now<retryAt) return;
                    try {
                        Object buffers=holder.get(p.thisObject); if(buffers==null) return;
                        Object from=input.get(buffers),to=out.get(buffers); if(from==null || to==null) return;
                        int tex=((int[])texture.get(from))[0], fbo=((int[])framebuffer.get(to))[0];
                        Size inputSize=(Size)dimensions.get(from),outputSize=(Size)dimensions.get(to);
                        if(!inputSize.equals(outputSize)) return;
                        if(FILTER.get().draw(tex,fbo,inputSize.getWidth(),inputSize.getHeight(),amount)) {
                            input.set(buffers,to); out.set(buffers,from);
                            if(now-lastLog>10000){lastLog=now;XposedBridge.log("[SoftwareBeauty] preview texture="+tex+" size="+inputSize+" amount="+amount);}
                        }
                    } catch(Throwable error){retryAt=now+5000;XposedBridge.log("[SoftwareBeauty] preview retained: "+error);}
                }
            });
            ready=true;
            var jpegSetters=kit.findMethod(FindMethod.create().matcher(MethodMatcher.create()
                    .usingStrings("fillJpegData: dataLen=").paramTypes(int.class,byte[].class).returnType(void.class)));
            if(jpegSetters.size()==1) {
                Class<?> task=jpegSetters.get(0).getClassInstance(loader);
                for(Method candidate:task.getDeclaredMethods()) {
                    Class<?>[] signature=candidate.getParameterTypes();
                    if(candidate.getReturnType()!=void.class || signature.length==0) continue;
                    boolean hasBytes=false;
                    for(Class<?> type:signature) if(type==byte[].class) hasBytes=true;
                    if(!hasBytes) continue;
                    XposedBridge.hookMethod(candidate,new XC_MethodHook(){
                        @Override protected void beforeHookedMethod(MethodHookParam p){
                            if(!inScope()) return;
                            for(Object value:p.args) if(value instanceof byte[]) {
                                byte[] bytes=(byte[])value;
                                XposedBridge.log("[SoftwareBeauty] JPEG boundary="+p.method+" length="+bytes.length
                                    +" jpeg="+(bytes.length>2 && (bytes[0]&255)==255 && (bytes[1]&255)==216)+" level="+level);
                            }
                        }
                    });
                }
            }
            XposedBridge.log("[SoftwareBeauty] bound draw="+draw+" gate="+gates+" readers="+readers+" writers="+writers+"; front Photo only");
        } catch(Throwable error){ready=false;XposedBridge.log("[SoftwareBeauty] not activated: "+error);}
    }
    private static int clamp(int value){return Math.max(0,Math.min(100,value));}
    private static float strength(){
        if(!ready || !enabled || !beautySelected) return 0;
        return inScope() ? level/100f : 0;
    }
    private static boolean inScope(){
        try{return camera.getInt(null)==1 && mode.getInt(null)==163;}
        catch(Throwable ignored){return false;}
    }
    public static boolean processBitmap(Bitmap bitmap){
        float amount=strength(); if(amount<=0) return false;
        long start=SystemClock.elapsedRealtime();
        try {
            boolean changed=SoftwareSkinSmoothing.apply(bitmap,amount);
            XposedBridge.log("[SoftwareBeauty] still changed="+changed+" size="+bitmap.getWidth()+"x"+bitmap.getHeight()
                    +" amount="+amount+" elapsedMs="+(SystemClock.elapsedRealtime()-start)+"; same Bitmap, no extra JPEG encode");
            return changed;
        } catch(Throwable error){XposedBridge.log("[SoftwareBeauty] still retained: "+error);return false;}
    }
}
