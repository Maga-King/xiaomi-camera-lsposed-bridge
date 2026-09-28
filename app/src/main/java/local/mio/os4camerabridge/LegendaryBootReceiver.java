package local.mio.os4camerabridge;
import android.content.BroadcastReceiver;
import android.content.Context;
import android.content.Intent;
/** Restores the camera-specific provider visibility grant after a reboot; no resident service. */
public final class LegendaryBootReceiver extends BroadcastReceiver {
    @Override public void onReceive(Context context, Intent intent) {
        if(Intent.ACTION_BOOT_COMPLETED.equals(intent.getAction()) || Intent.ACTION_MY_PACKAGE_REPLACED.equals(intent.getAction()))
            LegendaryProcessingProvider.grantCameraVisibility(context);
    }
}
