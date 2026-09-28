package local.mio.os4camerabridge;

import android.util.Log;

/** Final container boundary; does not hook HAL, preview, exposure or the editor. */
public final class LegendaryContainerIntegrityBridge {
    private LegendaryContainerIntegrityBridge() {}
    public static byte[] finish(byte[] input) {
        try {
            byte[] output=LegendaryContainerIntegrity.repair(input);
            Log.i("LegendContainerIntegrity", "r1-20260908 repaired="+(output!=input)
                    +" bytes="+input.length+"->"+output.length);
            return output;
        } catch (Throwable error) {
            Log.e("LegendContainerIntegrity", "r1-20260908 unchanged on validation failure",error);
            return input;
        }
    }
}
