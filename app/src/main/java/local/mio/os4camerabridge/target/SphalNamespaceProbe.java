package local.mio.os4camerabridge.target;

/** Safe linker-only probe. It never constructs a beauty engine. */
public final class SphalNamespaceProbe {
    private static boolean loaded;

    public static synchronized void load(String absolutePath) {
        if (!loaded) {
            System.load(absolutePath);
            loaded = true;
        }
    }

    public static native boolean probe(String absoluteSphalPath);

    private SphalNamespaceProbe() {
    }
}
