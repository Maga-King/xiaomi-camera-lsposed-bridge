package local.mio.os4camerabridge;

import android.app.Application;
import android.hardware.camera2.CameraCharacteristics;
import android.hardware.camera2.CaptureResult;
import android.hardware.camera2.TotalCaptureResult;
import android.hardware.camera2.params.LensShadingMap;
import android.media.Image;
import android.os.SystemClock;
import java.io.File;
import java.io.FileOutputStream;
import java.lang.reflect.Method;
import java.nio.charset.StandardCharsets;
import java.util.Map;
import java.util.concurrent.atomic.AtomicInteger;
import de.robv.android.xposed.XC_MethodHook;
import de.robv.android.xposed.XposedBridge;
import de.robv.android.xposed.XposedHelpers;

/** Optional, bounded ordinary Photo reference probe. Never alters requests, images, or cloud metadata. */
public final class LegendaryPhotoRawProbe {
    private static Class<?> entry;
    private static boolean installed;
    private static final AtomicInteger samples = new AtomicInteger();

    private LegendaryPhotoRawProbe() {}

    public static synchronized void install(ClassLoader ignored) {
        if (installed) return;
        try {
            entry = Class.forName("local.mio.os4camerabridge.HookEntry", false,
                    LegendaryPhotoRawProbe.class.getClassLoader());
            Method boundary = entry.getDeclaredMethod("submitCommonApsFrames");
            XposedBridge.hookMethod(boundary, new XC_MethodHook() {
                @Override protected void beforeHookedMethod(MethodHookParam p) {
                    try {
                    if (XposedHelpers.getStaticIntField(entry,"activeCameraModule") != 163
                            || XposedHelpers.getStaticIntField(entry,"activeCameraId") != 0
                            || !XposedHelpers.getStaticBooleanField(entry,"commonApsUnifiedSessionActive")) return;
                    float zoom = (Float) XposedHelpers.getStaticObjectField(entry,"commonApsZoomRatio");
                    if (zoom < 1.0f || zoom >= 3.0f || !Float.isFinite(zoom) || samples.getAndIncrement() >= 2) return;
                        inspect();
                    } catch (Throwable t) { log("inspection skipped; original APS proceeds: " + t); }
                }
            });
            installed = true;
            log("installed diagnosticOnly=true maxShots=2 ordinaryMainOnly=true noImageChanges=true");
        } catch (Throwable t) { log("install rejected " + t); }
    }

    private static void inspect() throws Exception {
        long start = SystemClock.elapsedRealtime();
        StringBuilder report = new StringBuilder();
        byte[] firstRaw = null;
        long firstTs = -1;
        Object lock = XposedHelpers.getStaticObjectField(entry,"COMMON_APS_LOCK");
        long identity = XposedHelpers.getStaticLongField(entry,"commonApsIdentity");
        long taskTs = XposedHelpers.getStaticLongField(entry,"commonApsShutterTimestamp");
        report.append("identity=").append(identity).append(" taskTs=").append(taskTs).append('\n');
        synchronized (lock) {
            Map<?,?> frames = (Map<?,?>) XposedHelpers.getStaticObjectField(entry,"COMMON_APS_FRAMES");
            report.append("frames=").append(frames.size()).append('\n');
            for (Object frame : frames.values()) {
                int index = XposedHelpers.getIntField(frame,"index");
                long timestamp = XposedHelpers.getLongField(frame,"timestamp");
                Image main = (Image) XposedHelpers.getObjectField(frame,"main");
                TotalCaptureResult result = (TotalCaptureResult) XposedHelpers.getObjectField(frame,"result");
                report.append("index=").append(index).append(" ts=").append(timestamp);
                if (main == null || result == null) { report.append(" incomplete\n"); continue; }
                report.append(" imageTs=").append(main.getTimestamp()).append(" size=").append(main.getWidth())
                        .append('x').append(main.getHeight()).append(" format=").append(main.getFormat())
                        .append(" resultTs=").append(result.get(CaptureResult.SENSOR_TIMESTAMP))
                        .append(" cameraFrame=").append(result.getFrameNumber())
                        .append(" iso=").append(result.get(CaptureResult.SENSOR_SENSITIVITY))
                        .append(" exposureNs=").append(result.get(CaptureResult.SENSOR_EXPOSURE_TIME))
                        .append(" focal=").append(result.get(CaptureResult.LENS_FOCAL_LENGTH))
                        .append(" activePhysical=").append(result.get(CaptureResult.LOGICAL_MULTI_CAMERA_ACTIVE_PHYSICAL_ID))
                        .append(" physicalKeys=").append(result.getPhysicalCameraTotalResults().keySet());
                Image.Plane[] planes = main.getPlanes();
                if (planes.length != 1) { report.append(" unsupportedPlanes\n"); continue; }
                report.append(" rowStride=").append(planes[0].getRowStride())
                        .append(" pixelStride=").append(planes[0].getPixelStride());
                LensShadingMap lsc = result.get(CaptureResult.STATISTICS_LENS_SHADING_CORRECTION_MAP);
                report.append(" logicalLsc=").append(lsc == null ? "absent" : lsc.getColumnCount()+"x"+lsc.getRowCount()).append('\n');
                // Retain only the already-identified first source frame for offline inspection.
                // This is NOT a declaration that APS chose it as its final fusion base frame.
                if(index==1 && main.getFormat()==37 && main.getWidth()==4096 && main.getHeight()==3072
                        && main.getTimestamp()==timestamp && Long.valueOf(timestamp).equals(result.get(CaptureResult.SENSOR_TIMESTAMP))) {
                    firstRaw = PackedRaw10Copy.copy(planes[0].getBuffer(),4096,3072,planes[0].getRowStride());
                    firstTs = timestamp;
                    Map<?,?> characteristics = (Map<?,?>) XposedHelpers.getStaticObjectField(entry,"CAMERA_CHARACTERISTICS");
                    for (String camera : new String[]{"0","2"}) {
                        CameraCharacteristics c = (CameraCharacteristics) characteristics.get(camera);
                        if(c!=null) report.append("camera=").append(camera).append(" cfa=")
                                .append(c.get(CameraCharacteristics.SENSOR_INFO_COLOR_FILTER_ARRANGEMENT))
                                .append(" black=").append(c.get(CameraCharacteristics.SENSOR_BLACK_LEVEL_PATTERN))
                                .append(" white=").append(c.get(CameraCharacteristics.SENSOR_INFO_WHITE_LEVEL)).append('\n');
                    }
                }
            }
        }
        report.append("copyCostMs=").append(SystemClock.elapsedRealtime()-start).append('\n');
        log(report.toString());
        final byte[] raw = firstRaw;
        final String details = report.toString();
        final long timestamp = firstTs;
        if(raw==null) return;
        Thread writer = new Thread(() -> {
            try {
                Application app=(Application)XposedHelpers.callStaticMethod(
                        XposedHelpers.findClass("android.app.ActivityThread",null),"currentApplication");
                if(app==null || !"com.android.camera".equals(app.getPackageName())) return;
                File dir=new File(app.getCacheDir(),"legendary-photo-reference");
                if(!dir.isDirectory() && !dir.mkdir()) throw new IllegalStateException("mkdir");
                String name="photo_"+identity+"_"+timestamp;
                write(new File(dir,name+".raw10"),raw);
                write(new File(dir,name+".txt"),details.getBytes(StandardCharsets.UTF_8));
                log("saved reference "+name+" bytes="+raw.length+" notCloudAttached=true");
            } catch(Throwable t) { log("reference write failed "+t); }
        },"LegendaryPhotoReference");
        writer.setPriority(Thread.MIN_PRIORITY);
        writer.start();
    }

    private static void write(File file, byte[] bytes) throws Exception {
        if(!file.createNewFile()) throw new IllegalStateException("Refusing overwrite");
        try(FileOutputStream out=new FileOutputStream(file)) { out.write(bytes); }
    }
    private static void log(String message) { XposedBridge.log("[LegendaryPhotoRawProbe] "+message); }
}
