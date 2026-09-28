package local.mio.os4camerabridge;

/** Narrow experiment: apply the stock tele fallback bit only to rear Photo preview. */
public final class RearTelePreviewPolicy {
    private RearTelePreviewPolicy() {}

    public static boolean eligible(int module, int camera, boolean unified,
            boolean portrait, boolean repeating, float zoom) {
        return module == 163 && camera == 0 && unified && !portrait && repeating
                && Float.isFinite(zoom) && zoom >= 3.0f && zoom <= 20.0f;
    }

    public static int[] mask(int[] previous) {
        if (previous != null && previous.length != 1) return null;
        int current = previous == null ? 0 : previous[0];
        if (current < 0) return null;
        return new int[]{current | 2};
    }
}
