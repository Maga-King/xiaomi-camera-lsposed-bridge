package local.mio.os4camerabridge;

/** Host-side contract tests; do not load Android, Xposed, or initialize a camera. */
public final class CameraModuleContractTest {
    static class LifecycleOwner {
        protected int mModuleIndex;
        public final void init() {}
        public int getModuleIndex() { return mModuleIndex; }
        public boolean isSupportAFSaliency() { return true; }
    }
    static class PhotoBase extends LifecycleOwner {}
    static class CameraEntry extends PhotoBase {}
    static class ShadowField extends PhotoBase { int mModuleIndex; }
    static class UnrelatedSynthetic { public void run() {} }
    static class WrongField {
        String mModuleIndex;
        public void init() {}
        public int getModuleIndex() { return 163; }
    }
    static class WrongGetter {
        int mModuleIndex;
        public void init() {}
        public long getModuleIndex() { return 163; }
    }
    static class StaticInitializer {
        int mModuleIndex;
        public static void init() {}
        public int getModuleIndex() { return 163; }
    }
    static abstract class AbstractInitializer {
        int mModuleIndex;
        public abstract void init();
        public int getModuleIndex() { return 163; }
    }
    static class WrongAfReturn { public int isSupportAFSaliency() { return 1; } }
    static class StaticAf { public static boolean isSupportAFSaliency() { return true; } }
    static abstract class AbstractAf { public abstract boolean isSupportAFSaliency(); }

    private static int checked;
    private static void resolves(Class<?> entry, Class<?> expected) throws Exception {
        if (CameraModuleContract.findBaseClass(entry) != expected) {
            throw new AssertionError("Wrong lifecycle owner: " + entry);
        }
        checked++;
    }
    private static void rejects(Class<?> entry) throws Exception {
        try {
            CameraModuleContract.findBaseClass(entry);
            throw new AssertionError("Accepted invalid lifecycle: " + entry);
        } catch (ReflectiveOperationException expected) {
            checked++;
        }
    }
    private static void rejectsAf(Class<?> owner) throws Exception {
        try {
            CameraModuleContract.findAfSaliency(owner);
            throw new AssertionError("Accepted invalid AF contract: " + owner);
        } catch (ReflectiveOperationException expected) {
            checked++;
        }
    }
    public static void main(String[] args) throws Exception {
        resolves(CameraEntry.class, LifecycleOwner.class);
        resolves(LifecycleOwner.class, LifecycleOwner.class);
        resolves(ShadowField.class, LifecycleOwner.class);
        rejects(UnrelatedSynthetic.class);
        rejects(WrongField.class);
        rejects(WrongGetter.class);
        rejects(StaticInitializer.class);
        rejects(AbstractInitializer.class);
        rejects(null);
        if (CameraModuleContract.findAfSaliency(LifecycleOwner.class)
                .getDeclaringClass() != LifecycleOwner.class) {
            throw new AssertionError("Wrong AF owner");
        }
        checked++;
        rejectsAf(WrongAfReturn.class);
        rejectsAf(StaticAf.class);
        rejectsAf(AbstractAf.class);
        rejectsAf(UnrelatedSynthetic.class);
        System.out.println("CameraModuleContract: " + checked + " checks passed");
    }
}
