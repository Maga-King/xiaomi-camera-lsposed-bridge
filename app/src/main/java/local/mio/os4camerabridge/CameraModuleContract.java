package local.mio.os4camerabridge;

import java.lang.reflect.Field;
import java.lang.reflect.Method;
import java.lang.reflect.Modifier;

/** Resolves the camera lifecycle owner without assuming an obfuscated class name. */
public final class CameraModuleContract {
    private CameraModuleContract() {}

    public static Class<?> resolveBaseClass(ClassLoader loader)
            throws ReflectiveOperationException {
        return findBaseClass(Class.forName(
                "com.android.camera.module.Camera2Module", false, loader));
    }

    public static Method resolveInitializer(ClassLoader loader)
            throws ReflectiveOperationException {
        return resolveBaseClass(loader).getDeclaredMethod("init");
    }

    public static Method resolveAfSaliency(ClassLoader loader)
            throws ReflectiveOperationException {
        return findAfSaliency(resolveBaseClass(loader));
    }

    static Method findAfSaliency(Class<?> baseModule)
            throws ReflectiveOperationException {
        Method method = baseModule.getDeclaredMethod("isSupportAFSaliency");
        if (method.getReturnType() != boolean.class
                || Modifier.isStatic(method.getModifiers())
                || Modifier.isAbstract(method.getModifiers())) {
            throw new NoSuchMethodException("Invalid AF-saliency contract in "
                    + baseModule.getName());
        }
        return method;
    }

    static Class<?> findBaseClass(Class<?> cameraModule)
            throws ReflectiveOperationException {
        if (cameraModule == null) {
            throw new ClassNotFoundException("Camera module entry is null");
        }
        for (Class<?> candidate = cameraModule; candidate != null;
                candidate = candidate.getSuperclass()) {
            try {
                Field index = candidate.getDeclaredField("mModuleIndex");
                Method init = candidate.getDeclaredMethod("init");
                Method getter = candidate.getDeclaredMethod("getModuleIndex");
                if (index.getType() == int.class
                        && !Modifier.isStatic(index.getModifiers())
                        && init.getReturnType() == void.class
                        && !Modifier.isStatic(init.getModifiers())
                        && !Modifier.isAbstract(init.getModifiers())
                        && getter.getReturnType() == int.class
                        && !Modifier.isStatic(getter.getModifiers())
                        && !Modifier.isAbstract(getter.getModifiers())) {
                    return candidate;
                }
            } catch (NoSuchFieldException | NoSuchMethodException missing) {
                // A PhotoBase/intermediate module need not own the lifecycle.
            }
        }
        throw new NoSuchMethodException("No verified camera lifecycle owner in "
                + cameraModule.getName() + " hierarchy");
    }
}
