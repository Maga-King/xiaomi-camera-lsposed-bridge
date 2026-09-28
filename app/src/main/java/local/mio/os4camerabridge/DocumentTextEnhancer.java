package local.mio.os4camerabridge;

import android.graphics.Bitmap;
import android.graphics.BitmapFactory;

import org.tensorflow.lite.DataType;
import org.tensorflow.lite.Interpreter;

import java.io.ByteArrayOutputStream;
import java.io.File;
import java.io.InputStream;
import java.nio.ByteBuffer;
import java.nio.ByteOrder;
import java.util.Arrays;
import java.util.zip.ZipEntry;
import java.util.zip.ZipFile;

/** Runs ColorOS' own document-text luminance network without touching HAL. */
final class DocumentTextEnhancer {
    private static final String MODEL_ASSET =
            "assets/text_enhance_yuv_v1.tflite";
    private static final int MODEL_WIDTH = 2112;
    private static final int MODEL_HEIGHT = 1568;
    private static final int MODEL_PIXELS = MODEL_WIDTH * MODEL_HEIGHT;
    private static final Object LOCK = new Object();
    private static boolean nativeRuntimeLoaded;

    static final class Result {
        final byte[] jpeg;
        final long inferenceMs;
        final long totalMs;
        final double meanAbsDelta;
        final int maxAbsDelta;
        final int changedPixels;

        Result(byte[] jpeg, long inferenceMs, long totalMs,
                double meanAbsDelta, int maxAbsDelta, int changedPixels) {
            this.jpeg = jpeg;
            this.inferenceMs = inferenceMs;
            this.totalMs = totalMs;
            this.meanAbsDelta = meanAbsDelta;
            this.maxAbsDelta = maxAbsDelta;
            this.changedPixels = changedPixels;
        }
    }

    private DocumentTextEnhancer() {
    }

    static Result enhance(byte[] sourceJpeg, String moduleApkPath)
            throws Exception {
        synchronized (LOCK) {
            return enhanceLocked(sourceJpeg, moduleApkPath);
        }
    }

    private static Result enhanceLocked(byte[] sourceJpeg,
            String moduleApkPath) throws Exception {
        long started = android.os.SystemClock.elapsedRealtime();
        if (moduleApkPath == null || moduleApkPath.isEmpty()) {
            throw new IllegalStateException("module APK path is absent");
        }

        BitmapFactory.Options decodeOptions = new BitmapFactory.Options();
        decodeOptions.inPreferredConfig = Bitmap.Config.ARGB_8888;
        decodeOptions.inMutable = true;
        Bitmap full = BitmapFactory.decodeByteArray(
                sourceJpeg, 0, sourceJpeg.length, decodeOptions);
        if (full == null) {
            throw new IllegalStateException("document JPEG decode failed");
        }
        int fullWidth = full.getWidth();
        int fullHeight = full.getHeight();
        long fullPixelCount = (long) fullWidth * fullHeight;
        if (fullWidth < 64 || fullHeight < 64
                || fullPixelCount > 50_000_000L) {
            full.recycle();
            throw new IllegalStateException("unsupported document size "
                    + fullWidth + "x" + fullHeight);
        }

        Bitmap scaled = null;
        Interpreter interpreter = null;
        try {
            scaled = Bitmap.createScaledBitmap(
                    full, MODEL_WIDTH, MODEL_HEIGHT, true);
            int[] modelPixels = new int[MODEL_PIXELS];
            scaled.getPixels(modelPixels, 0, MODEL_WIDTH,
                    0, 0, MODEL_WIDTH, MODEL_HEIGHT);
            if (scaled != full) {
                scaled.recycle();
                scaled = null;
            }

            byte[] inputLuma = new byte[MODEL_PIXELS];
            ByteBuffer input = ByteBuffer.allocateDirect(MODEL_PIXELS)
                    .order(ByteOrder.nativeOrder());
            for (int index = 0; index < MODEL_PIXELS; index++) {
                int color = modelPixels[index];
                int luma = (77 * ((color >>> 16) & 0xff)
                        + 150 * ((color >>> 8) & 0xff)
                        + 29 * (color & 0xff) + 128) >>> 8;
                inputLuma[index] = (byte) luma;
                input.put((byte) luma);
            }
            Arrays.fill(modelPixels, 0);
            modelPixels = null;
            input.rewind();

            ensureNativeRuntimeLoaded(moduleApkPath);
            ByteBuffer model = loadModel(moduleApkPath);
            Interpreter.Options interpreterOptions =
                    new Interpreter.Options().setNumThreads(2);
            interpreter = new Interpreter(model, interpreterOptions);
            int[] inputShape = interpreter.getInputTensor(0).shape();
            int[] outputShape = interpreter.getOutputTensor(0).shape();
            if (!Arrays.equals(inputShape,
                    new int[]{1, MODEL_HEIGHT, MODEL_WIDTH, 1})
                    || !Arrays.equals(outputShape,
                    new int[]{1, MODEL_HEIGHT, MODEL_WIDTH, 1})
                    || interpreter.getInputTensor(0).dataType()
                    != DataType.UINT8
                    || interpreter.getOutputTensor(0).dataType()
                    != DataType.UINT8) {
                throw new IllegalStateException("unexpected model tensors in="
                        + Arrays.toString(inputShape) + " out="
                        + Arrays.toString(outputShape));
            }

            ByteBuffer output = ByteBuffer.allocateDirect(MODEL_PIXELS)
                    .order(ByteOrder.nativeOrder());
            long inferenceStarted = android.os.SystemClock.elapsedRealtime();
            interpreter.run(input, output);
            long inferenceMs = android.os.SystemClock.elapsedRealtime()
                    - inferenceStarted;
            output.rewind();
            byte[] outputLuma = new byte[MODEL_PIXELS];
            output.get(outputLuma);

            long deltaTotal = 0;
            int maxDelta = 0;
            int changedPixels = 0;
            for (int index = 0; index < MODEL_PIXELS; index++) {
                int delta = (outputLuma[index] & 0xff)
                        - (inputLuma[index] & 0xff);
                int absolute = Math.abs(delta);
                deltaTotal += absolute;
                maxDelta = Math.max(maxDelta, absolute);
                if (absolute >= 2) {
                    changedPixels++;
                }
            }

            int pixelCount = Math.toIntExact(fullPixelCount);
            int[] fullPixels = new int[pixelCount];
            full.getPixels(fullPixels, 0, fullWidth,
                    0, 0, fullWidth, fullHeight);
            applyResidual(fullPixels, fullWidth, fullHeight,
                    inputLuma, outputLuma);
            full.setPixels(fullPixels, 0, fullWidth,
                    0, 0, fullWidth, fullHeight);
            Arrays.fill(fullPixels, 0);

            ByteArrayOutputStream encoded = new ByteArrayOutputStream(
                    Math.max(sourceJpeg.length * 2, 4 * 1024 * 1024));
            if (!full.compress(Bitmap.CompressFormat.JPEG, 100, encoded)) {
                throw new IllegalStateException("document JPEG encode failed");
            }
            byte[] jpeg = encoded.toByteArray();
            if (jpeg.length < 4 || jpeg[0] != (byte) 0xff
                    || jpeg[1] != (byte) 0xd8) {
                throw new IllegalStateException("document JPEG output invalid");
            }
            return new Result(jpeg, inferenceMs,
                    android.os.SystemClock.elapsedRealtime() - started,
                    deltaTotal / (double) MODEL_PIXELS,
                    maxDelta, changedPixels);
        } finally {
            if (interpreter != null) {
                interpreter.close();
            }
            if (scaled != null && scaled != full && !scaled.isRecycled()) {
                scaled.recycle();
            }
            if (!full.isRecycled()) {
                full.recycle();
            }
        }
    }

    private static void applyResidual(int[] pixels, int width, int height,
            byte[] inputLuma, byte[] outputLuma) {
        int xDenominator = Math.max(1, width - 1);
        int yDenominator = Math.max(1, height - 1);
        for (int y = 0; y < height; y++) {
            float modelY = y * (MODEL_HEIGHT - 1f) / yDenominator;
            int y0 = Math.min((int) modelY, MODEL_HEIGHT - 1);
            int y1 = Math.min(y0 + 1, MODEL_HEIGHT - 1);
            float yFraction = modelY - y0;
            int row0 = y0 * MODEL_WIDTH;
            int row1 = y1 * MODEL_WIDTH;
            int destinationRow = y * width;
            for (int x = 0; x < width; x++) {
                float modelX = x * (MODEL_WIDTH - 1f) / xDenominator;
                int x0 = Math.min((int) modelX, MODEL_WIDTH - 1);
                int x1 = Math.min(x0 + 1, MODEL_WIDTH - 1);
                float xFraction = modelX - x0;

                float d00 = (outputLuma[row0 + x0] & 0xff)
                        - (inputLuma[row0 + x0] & 0xff);
                float d10 = (outputLuma[row0 + x1] & 0xff)
                        - (inputLuma[row0 + x1] & 0xff);
                float d01 = (outputLuma[row1 + x0] & 0xff)
                        - (inputLuma[row1 + x0] & 0xff);
                float d11 = (outputLuma[row1 + x1] & 0xff)
                        - (inputLuma[row1 + x1] & 0xff);
                float top = d00 + (d10 - d00) * xFraction;
                float bottom = d01 + (d11 - d01) * xFraction;
                int delta = Math.round(top + (bottom - top) * yFraction);

                int index = destinationRow + x;
                int color = pixels[index];
                int alpha = color & 0xff000000;
                int red = clamp8(((color >>> 16) & 0xff) + delta);
                int green = clamp8(((color >>> 8) & 0xff) + delta);
                int blue = clamp8((color & 0xff) + delta);
                pixels[index] = alpha | (red << 16) | (green << 8) | blue;
            }
        }
    }

    private static int clamp8(int value) {
        return Math.max(0, Math.min(255, value));
    }

    private static ByteBuffer loadModel(String moduleApkPath)
            throws Exception {
        try (ZipFile apk = new ZipFile(moduleApkPath)) {
            ZipEntry entry = apk.getEntry(MODEL_ASSET);
            if (entry == null || entry.getSize() <= 0
                    || entry.getSize() > Integer.MAX_VALUE) {
                throw new IllegalStateException("model asset missing");
            }
            ByteBuffer buffer = ByteBuffer.allocateDirect((int) entry.getSize())
                    .order(ByteOrder.nativeOrder());
            try (InputStream input = apk.getInputStream(entry)) {
                byte[] chunk = new byte[16 * 1024];
                int read;
                while ((read = input.read(chunk)) != -1) {
                    buffer.put(chunk, 0, read);
                }
            }
            if (buffer.position() != entry.getSize()) {
                throw new IllegalStateException("short model read "
                        + buffer.position() + "/" + entry.getSize());
            }
            buffer.rewind();
            return buffer;
        }
    }

    /**
     * LSPosed gives module code its own linker namespace.  A plain
     * System.loadLibrary() searches the target Camera app/system paths and
     * selects /system/lib64/libtensorflowlite_jni.so, which clns-12 cannot
     * access.  Load the AAR's extracted arm64 runtime by absolute path before
     * Interpreter initializes.  llvm-readelf confirms its complete closure
     * is only libm/libdl/liblog/libc, all public platform libraries.
     */
    private static void ensureNativeRuntimeLoaded(String moduleApkPath) {
        if (nativeRuntimeLoaded) {
            return;
        }
        File apk = new File(moduleApkPath);
        File codeDirectory = apk.getParentFile();
        if (codeDirectory == null) {
            throw new IllegalStateException("invalid module APK path "
                    + moduleApkPath);
        }
        File library = new File(new File(codeDirectory, "lib/arm64"),
                "libtensorflowlite_jni.so");
        if (!library.isFile() || library.length() == 0L) {
            throw new IllegalStateException("module TFLite JNI missing "
                    + library);
        }
        System.load(library.getAbsolutePath());
        nativeRuntimeLoaded = true;
    }
}
