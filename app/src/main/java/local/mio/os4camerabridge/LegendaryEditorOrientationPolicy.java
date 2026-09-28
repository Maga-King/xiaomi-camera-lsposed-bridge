package local.mio.os4camerabridge;

/** A cloud bitmap already in portrait coordinates must not inherit a sensor rotation. */
public final class LegendaryEditorOrientationPolicy {
    private LegendaryEditorOrientationPolicy() {}
    public static boolean shouldNormalize(int mode, int orientation, int sourceWidth,
            int sourceHeight, int outputWidth, int outputHeight) {
        if (mode != 1 || (orientation != 6 && orientation != 8)
                || sourceWidth <= sourceHeight || sourceHeight <= 0
                || outputHeight <= outputWidth || outputWidth <= 0) return false;
        // Only the exact swapped aspect (including 2x cloud upscaling) is proven.
        // Cropped/watermarked geometry needs a separate contract, not a guess.
        return (long) outputWidth * sourceWidth == (long) outputHeight * sourceHeight;
    }
}
