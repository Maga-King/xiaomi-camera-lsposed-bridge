package local.mio.os4camerabridge;

import android.view.View;
import java.lang.reflect.Field;
import java.lang.reflect.Method;
import java.lang.reflect.Modifier;
import java.util.LinkedHashSet;
import java.util.ArrayList;
import java.util.List;
import org.luckypray.dexkit.DexKitBridge;
import org.luckypray.dexkit.query.FindMethod;
import org.luckypray.dexkit.query.matchers.MethodMatcher;
import org.luckypray.dexkit.query.enums.StringMatchType;
import de.robv.android.xposed.XC_MethodHook;
import de.robv.android.xposed.XposedBridge;

/** Resolve the list actually consumed by FragmentBeauty, not a version's aliases. */
public final class BeautyPanelContractBridge {
    private BeautyPanelContractBridge() {}

    public static void bind(DexKitBridge bridge, ClassLoader loader) {
        try {
            var views = bridge.findMethod(FindMethod.create().matcher(MethodMatcher.create()
                    .usingStrings("unknown beauty type", "shineType: ", "2")
                    .returnType(void.class).paramTypes(View.class)));
            if (views.size() != 1) throw new IllegalStateException("beauty consumer count=" + views.size());
            var consumer = views.get(0);
            Method init = consumer.getMethodInstance(loader);
            if (Modifier.isStatic(init.getModifiers())) throw new IllegalStateException("static beauty consumer");
            LinkedHashSet<Field> lists = new LinkedHashSet<>();
            LinkedHashSet<Field> values = new LinkedHashSet<>();
            for (var use : consumer.getUsingFields()) {
                Field field = use.getField().getFieldInstance(loader);
                if (Modifier.isStatic(field.getModifiers())) continue;
                if (field.getType() == List.class) lists.add(field);
                if (field.getType() == String.class && field.getDeclaringClass().getName()
                        .startsWith("com.android.camera.data.data.")) values.add(field);
            }
            if (lists.size() != 1 || values.size() != 1)
                throw new IllegalStateException("beauty fields lists=" + lists + " values=" + values);
            Field list = lists.iterator().next();
            Field value = values.iterator().next();
            Class<?> component = list.getDeclaringClass();
            LinkedHashSet<Method> selectedMethods = new LinkedHashSet<>();
            for (var invoked : consumer.getInvokes()) {
                if (!invoked.isMethod() || !invoked.getDeclaredClassName().equals(component.getName())
                        || invoked.getParamCount() != 0 || !invoked.getReturnTypeName().equals("java.lang.String")) continue;
                Method method = invoked.getMethodInstance(loader);
                if (!Modifier.isStatic(method.getModifiers())) selectedMethods.add(method);
            }
            if (selectedMethods.size() != 1) throw new IllegalStateException("beauty selection=" + selectedMethods);
            // Cross-check that the same owner constructs the legacy value for this exact item type.
            var factories = bridge.findMethod(FindMethod.create().matcher(MethodMatcher.create()
                    .declaredClass(component).addUsingString("1", StringMatchType.Equals)
                    .paramCount(0).returnType(value.getDeclaringClass())));
            if (factories.size() != 1 || !Modifier.isStatic(factories.get(0).getModifiers()))
                throw new IllegalStateException("beauty legacy factory count=" + factories.size());
            boolean writesValue = factories.get(0).getUsingFields().stream()
                    .anyMatch(use -> use.getField().getDescriptor().equals(valueDescriptor(value)));
            if (!writesValue) throw new IllegalStateException("legacy item field not used by factory");
            Field mode = inheritedField(component, "mCurrentMode");
            if (mode.getType() != int.class || Modifier.isStatic(mode.getModifiers()))
                throw new IllegalStateException("invalid component mode");
            list.setAccessible(true);
            value.setAccessible(true);
            mode.setAccessible(true);
            Field sourceItems = inheritedField(component, "mItems");
            if (sourceItems.getType() != List.class || Modifier.isStatic(sourceItems.getModifiers()))
                throw new IllegalStateException("invalid source items");
            sourceItems.setAccessible(true);
            Method selected = selectedMethods.iterator().next();
            XposedBridge.hookMethod(selected, new XC_MethodHook() {
                @Override protected void beforeHookedMethod(MethodHookParam p) {
                    try {
                        int current = mode.getInt(p.thisObject);
                        if (current != 163 && current != 171) return;
                        int changed = normalizeItems(p.thisObject, list, value);
                        changed += normalizeItems(p.thisObject, sourceItems, value);
                        if (changed != 0) XposedBridge.log("[BeautyPanelContract] mode=" + current
                                + " normalized legacy 1 -> smooth 2, unsupported reshape 4 hidden; changes=" + changed);
                    } catch (Throwable error) { XposedBridge.log("[BeautyPanelContract] list unavailable: " + error); }
                }
                @Override protected void afterHookedMethod(MethodHookParam p) {
                    try {
                        int current = mode.getInt(p.thisObject);
                        if ((current == 163 || current == 171) && !p.hasThrowable()
                                && ("1".equals(p.getResult()) || "4".equals(p.getResult()))) {
                            Object raw = list.get(p.thisObject);
                            if (raw instanceof List<?>) for (Object item : (List<?>) raw)
                                if (value.getDeclaringClass().isInstance(item) && "2".equals(value.get(item))) {
                                    p.setResult("2");
                                    break;
                                }
                        }
                    } catch (Throwable error) { XposedBridge.log("[BeautyPanelContract] selection unavailable: " + error); }
                }
            });
            XposedBridge.log("[BeautyPanelContract] bound consumer=" + init + " selected=" + selected
                    + " list=" + list + " value=" + value + "; UI only, no pixel-effect claim");
        } catch (Throwable error) { XposedBridge.log("[BeautyPanelContract] skipped: " + error); }
    }

    private static int normalizeItems(Object component, Field items, Field value) throws IllegalAccessException {
        Object raw = items.get(component);
        if (!(raw instanceof List<?>)) return 0;
        ArrayList<Object> normalized = new ArrayList<>();
        int changed = 0;
        for (Object item : (List<?>) raw) {
            if (value.getDeclaringClass().isInstance(item)) {
                Object type = value.get(item);
                if ("4".equals(type)) { changed++; continue; }
                if ("1".equals(type)) { value.set(item, "2"); changed++; }
            }
            normalized.add(item);
        }
        if (changed != 0) items.set(component, normalized);
        return changed;
    }

    private static String valueDescriptor(Field field) {
        return "L" + field.getDeclaringClass().getName().replace('.', '/') + ";->" + field.getName() + ":Ljava/lang/String;";
    }

    private static Field inheritedField(Class<?> owner, String name) throws NoSuchFieldException {
        for (Class<?> type = owner; type != null; type = type.getSuperclass()) {
            try { return type.getDeclaredField(name); } catch (NoSuchFieldException ignored) {}
        }
        throw new NoSuchFieldException(name);
    }
}
