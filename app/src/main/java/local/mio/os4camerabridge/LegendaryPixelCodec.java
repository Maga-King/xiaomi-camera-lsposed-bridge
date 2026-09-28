package local.mio.os4camerabridge;
import android.graphics.Bitmap;
/** Full-range BT.601 NV12, sRGB bitmap input; portrait rotation is reversible. */
public final class LegendaryPixelCodec {
    private LegendaryPixelCodec() {}
    public static native byte[] toNv12(Bitmap bitmap, boolean portrait);
    public static native boolean fromNv12(Bitmap bitmap, boolean portrait, byte[] nv12);
}
