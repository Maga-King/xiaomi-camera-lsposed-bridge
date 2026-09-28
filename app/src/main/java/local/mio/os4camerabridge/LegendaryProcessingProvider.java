package local.mio.os4camerabridge;

import android.content.ContentProvider;
import android.content.ContentValues;
import android.content.Context;
import android.content.SharedPreferences;
import android.database.Cursor;
import android.graphics.Bitmap;
import android.graphics.BitmapFactory;
import android.graphics.ColorSpace;
import android.net.Uri;
import android.os.Binder;
import android.os.Bundle;
import android.os.ParcelFileDescriptor;
import android.os.SystemClock;
import android.util.Log;
import java.io.*;
import java.nio.file.Files;
import java.util.concurrent.TimeUnit;

/** Read-only cross-app settings and descriptor-based, isolated local rendering. No network. */
public final class LegendaryProcessingProvider extends ContentProvider {
    public static final String AUTHORITY = "local.mio.os4camerabridge.legend";
    public static final Uri URI = Uri.parse("content://" + AUTHORITY);
    public static final String PREFS = "legendary_processing";
    public static final String GAMMA = "optional_aisp_gamma";
    public static final String MATRIX = "optional_sensor_matrix";
    private static final Object RENDER_LOCK = new Object();
    private static volatile String lastStatus = "尚未处理。Gamma 仅在兼容的小米 AISP 接口存在时生效。";
    private static boolean codecLoaded;
    private static String lastTiming = "not measured";

    @Override public boolean onCreate() { grantCameraVisibility(getContext()); return true; }
    static void grantCameraVisibility(Context context) {
        try {
            context.grantUriPermission("com.android.camera", URI,
                    android.content.Intent.FLAG_GRANT_READ_URI_PERMISSION
                    | android.content.Intent.FLAG_GRANT_PERSISTABLE_URI_PERMISSION);
        } catch(Exception error) { Log.w("LegendaryNative", "Camera URI visibility grant unavailable", error); }
    }
    private SharedPreferences preferences() { return getContext().getSharedPreferences(PREFS, Context.MODE_PRIVATE); }
    private void checkCaller() {
        int uid = Binder.getCallingUid();
        if (uid == android.os.Process.myUid() || uid == 0) return;
        String[] packages = getContext().getPackageManager().getPackagesForUid(uid);
        if (packages != null) for (String name : packages) if ("com.android.camera".equals(name)) return;
        throw new SecurityException("Camera-only processing provider");
    }
    @Override public Bundle call(String method, String argument, Bundle request) {
        checkCaller();
        if ("settings".equals(method)) {
            Bundle result = new Bundle();
            result.putBoolean(GAMMA, preferences().getBoolean(GAMMA, false));
            result.putBoolean(MATRIX, preferences().getBoolean(MATRIX, false));
            result.putString("status", lastStatus);
            result.putBoolean("aispAvailable", false); // Do not misreport an APS JPEG gamma substitute as AISP.
            return result;
        }
        if (!"render".equals(method) || request == null) throw new IllegalArgumentException("Unknown operation");
        synchronized (RENDER_LOCK) {
            Bundle result = new Bundle();
            long start = SystemClock.elapsedRealtime();
            lastTiming = "incomplete";
            try {
                result.putLong("bytes", render(request));
                result.putBoolean("ok", true);
                lastStatus = "M" + (request.getInt("mode") == 1 ? "9" : "3") + " 本地处理完成，"
                        + (SystemClock.elapsedRealtime() - start) + " ms；BT.601 全范围；未替代 Gallery 处理。";
            } catch (Throwable error) {
                lastStatus = "本地处理未提交：" + error.getClass().getSimpleName() + ": " + error.getMessage();
                result.putBoolean("ok", false);
                result.putString("error", lastStatus);
                Log.e("LegendaryNative", lastStatus, error);
            }
            result.putString("status", lastStatus);
            result.putString("timing", lastTiming);
            Log.i("LegendaryNative", lastStatus);
            return result;
        }
    }

    private long render(Bundle request) throws Exception {
        long started = SystemClock.elapsedRealtime();
        int mode = request.getInt("mode"), lux = request.getInt("lux", -1), cct = request.getInt("cct", -1);
        if ((mode != 1 && mode != 2) || lux < 0 || cct < 1500 || cct > 20000)
            throw new IllegalArgumentException("Invalid same-shot mode/lux/CCT");
        ParcelFileDescriptor input = request.getParcelable("input", ParcelFileDescriptor.class);
        ParcelFileDescriptor output = request.getParcelable("output", ParcelFileDescriptor.class);
        if (input == null || output == null) throw new IllegalArgumentException("Descriptors missing");
        Context context = getContext();
        File nativeDir = new File(context.getApplicationInfo().nativeLibraryDir);
        File models = prepareModels(context);
        if (!codecLoaded) {
            System.load(new File(nativeDir, "liblegend_pixel_codec.so").getPath());
            codecLoaded = true;
        }
        File inputYuv = File.createTempFile("legend_in_", ".nv12", context.getCacheDir());
        File outputYuv = File.createTempFile("legend_out_", ".nv12", context.getCacheDir());
        File log = File.createTempFile("legend_worker_", ".txt", context.getCacheDir());
        long prepared = SystemClock.elapsedRealtime();
        Bitmap bitmap = null;
        try (input; output) {
            BitmapFactory.Options bounds = new BitmapFactory.Options();
            bounds.inJustDecodeBounds = true;
            BitmapFactory.decodeFileDescriptor(input.getFileDescriptor(), null, bounds);
            if (!((bounds.outWidth == 4096 && bounds.outHeight == 3072)
                    || (bounds.outWidth == 3072 && bounds.outHeight == 4096)))
                throw new IllegalArgumentException("Only full-size, clean 12 MP input is supported");
            BitmapFactory.Options options = new BitmapFactory.Options();
            options.inPreferredConfig = Bitmap.Config.ARGB_8888;
            options.inPreferredColorSpace = ColorSpace.get(ColorSpace.Named.SRGB);
            options.inMutable = true;
            bitmap = BitmapFactory.decodeFileDescriptor(input.getFileDescriptor(), null, options);
            if (bitmap == null || bitmap.getColorSpace() == null || !bitmap.getColorSpace().isSrgb())
                throw new IOException("sRGB bitmap decode failed");
            long decoded = SystemClock.elapsedRealtime();
            boolean portrait = bitmap.getWidth() == 3072;
            byte[] nv12 = LegendaryPixelCodec.toNv12(bitmap, portrait);
            if (nv12 == null || nv12.length != 18874368) throw new IOException("NV12 conversion failed");
            try (FileOutputStream stream = new FileOutputStream(inputYuv)) { stream.write(nv12); }
            nv12 = null;
            long inputReady = SystemClock.elapsedRealtime();
            ProcessBuilder builder = new ProcessBuilder(new File(nativeDir, "liblegend_native_worker.so").getPath(),
                    nativeDir.getPath(), models.getPath(), inputYuv.getPath(), outputYuv.getPath(),
                    String.valueOf(mode), String.valueOf(lux), String.valueOf(cct));
            builder.environment().put("LD_LIBRARY_PATH", nativeDir + ":/system/lib64:/vendor/lib64");
            builder.environment().put("M9_QNN_RUNTIME_DIR", nativeDir.getPath());
            builder.environment().put("M9_ADSP_SKEL_DIR", nativeDir.getPath());
            builder.environment().put("M9_DIPS_ASSET_DIR", models.getPath());
            builder.environment().put("M9_QNN_CONTEXT_DIR", models.getPath());
            builder.environment().put("M9_V79_SEGMENT_LIBRARY", new File(nativeDir, "libanc_single_bokeh.so").getPath());
            builder.environment().put("M9_V79_SEGMENT_ASSETS_DIR", models.getPath());
            builder.redirectErrorStream(true).redirectOutput(log);
            Process process = builder.start();
            if (!process.waitFor(12, TimeUnit.SECONDS)) {
                process.destroyForcibly();
                process.waitFor(2, TimeUnit.SECONDS);
                throw new IOException("Native worker timeout; original JPEG retained");
            }
            long workerDone = SystemClock.elapsedRealtime();
            String workerLog = new String(Files.readAllBytes(log.toPath()), java.nio.charset.StandardCharsets.UTF_8);
            File diagnostic=new File(context.getFilesDir(),"legend_worker_last.txt");
            try(FileOutputStream diagnosticOutput=new FileOutputStream(diagnostic)) {
                byte[] details=workerLog.getBytes(java.nio.charset.StandardCharsets.UTF_8);
                diagnosticOutput.write(details,Math.max(0,details.length-32768),Math.min(32768,details.length));
            }
            for (String line : workerLog.split("\n"))
                if (line.startsWith("LegendWorker") || line.contains("dlopen:")) Log.i("LegendaryNative", line);
            if (process.exitValue() != 0 || outputYuv.length() != 18874368)
                throw new IOException("Native worker exit=" + process.exitValue() + " bytes=" + outputYuv.length());
            byte[] rendered = Files.readAllBytes(outputYuv.toPath());
            if (!LegendaryPixelCodec.fromNv12(bitmap, portrait, rendered)) throw new IOException("RGB output conversion failed");
            long rgbReady = SystemClock.elapsedRealtime();
            try (FileOutputStream stream = new FileOutputStream(output.getFileDescriptor())) {
                if (!bitmap.compress(Bitmap.CompressFormat.JPEG, 100, stream)) throw new IOException("JPEG encode failed");
                stream.flush();
                long done=SystemClock.elapsedRealtime();
                lastTiming="prepare="+(prepared-started)+" decode="+(decoded-prepared)
                        +" rgbToNv12AndWrite="+(inputReady-decoded)+" worker="+(workerDone-inputReady)
                        +" readAndNv12ToRgb="+(rgbReady-workerDone)+" jpegEncode="+(done-rgbReady)
                        +" total="+(done-started)+" ms";
                return stream.getChannel().size();
            }
        } finally {
            if (bitmap != null) bitmap.recycle();
            // Exact files created by this operation; no user photos or shared directories are removed.
            inputYuv.delete(); outputYuv.delete(); log.delete();
        }
    }

    private static File prepareModels(Context context) throws IOException {
        File directory = new File(context.getNoBackupFilesDir(), "legend_models_r1");
        if (!directory.isDirectory() && !directory.mkdirs()) throw new IOException("Model directory unavailable");
        String[] names = {"styletrans_low_v81_arch79.bin", "styletrans_high_v81_arch79.bin", "styletrans_colorfix_v81_arch79.bin", "leica_m9s2_param.bin"};
        long[] sizes = {10005264, 9939728, 8398912, 1686102};
        for (int index = 0; index < names.length; index++) {
            File target = new File(directory, names[index]);
            if (target.length() == sizes[index]) continue;
            File pending = File.createTempFile("model_", ".part", directory);
            try {
                try (InputStream input = context.getAssets().open("legendary/models/" + names[index]);
                        FileOutputStream output = new FileOutputStream(pending)) {
                    input.transferTo(output); output.getFD().sync();
                }
                if (pending.length() != sizes[index]) throw new IOException("Bundled model length mismatch");
                if (!pending.renameTo(target)) throw new IOException("Model installation failed");
            } finally { pending.delete(); }
        }
        return directory;
    }
    @Override public Cursor query(Uri u, String[] p, String s, String[] a, String o) { throw new UnsupportedOperationException(); }
    @Override public String getType(Uri u) { return null; }
    @Override public Uri insert(Uri u, ContentValues v) { throw new UnsupportedOperationException(); }
    @Override public int delete(Uri u, String s, String[] a) { throw new UnsupportedOperationException(); }
    @Override public int update(Uri u, ContentValues v, String s, String[] a) { throw new UnsupportedOperationException(); }
}
