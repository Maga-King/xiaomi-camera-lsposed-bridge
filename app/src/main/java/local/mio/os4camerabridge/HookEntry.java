package local.mio.os4camerabridge;

import android.app.Application;
import android.app.ActivityManager;
import android.content.Context;
import android.hardware.HardwareBuffer;
import android.hardware.camera2.CameraCaptureSession;
import android.hardware.camera2.CameraCharacteristics;
import android.hardware.camera2.CameraManager;
import android.hardware.camera2.CaptureFailure;
import android.hardware.camera2.CaptureRequest;
import android.hardware.camera2.CaptureResult;
import android.hardware.camera2.TotalCaptureResult;
import android.hardware.camera2.params.BlackLevelPattern;
import android.hardware.camera2.params.LensShadingMap;
import android.hardware.camera2.params.MeteringRectangle;
import android.hardware.camera2.params.OutputConfiguration;
import android.hardware.camera2.params.RggbChannelVector;
import android.hardware.camera2.params.StreamConfigurationMap;
import android.graphics.ImageFormat;
import android.graphics.Bitmap;
import android.graphics.BitmapFactory;
import android.graphics.Matrix;
import android.graphics.Rect;
import android.graphics.YuvImage;
import android.media.Image;
import android.media.ImageReader;
import android.media.MediaScannerConnection;
import android.net.Uri;
import android.opengl.EGL14;
import android.opengl.GLES20;
import android.os.Handler;
import android.os.HandlerThread;
import android.os.Bundle;
import android.os.Parcel;
import android.os.SystemClock;
import android.util.Base64;
import android.util.Size;
import android.util.SizeF;
import android.util.SparseIntArray;
import android.view.Surface;

import com.oplus.camera.facebeauty.OplusFaceBeautyPreview;

import java.io.ByteArrayOutputStream;
import java.io.File;
import java.io.FileOutputStream;
import java.io.InputStream;
import java.nio.ByteBuffer;
import java.nio.ByteOrder;
import java.nio.FloatBuffer;
import java.nio.charset.StandardCharsets;
import java.security.MessageDigest;
import java.lang.reflect.Constructor;
import java.lang.reflect.Method;
import java.lang.reflect.Proxy;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Collections;
import java.util.HashMap;
import java.util.IdentityHashMap;
import java.util.List;
import java.util.Locale;
import java.util.Map;
import java.util.Set;
import java.util.WeakHashMap;
import java.util.concurrent.ConcurrentHashMap;
import java.util.concurrent.atomic.AtomicBoolean;
import java.util.zip.ZipEntry;
import java.util.zip.ZipFile;

import dalvik.system.PathClassLoader;

import de.robv.android.xposed.IXposedHookLoadPackage;
import de.robv.android.xposed.IXposedHookZygoteInit;
import de.robv.android.xposed.XC_MethodHook;
import de.robv.android.xposed.XC_MethodReplacement;
import de.robv.android.xposed.XposedBridge;
import de.robv.android.xposed.XposedHelpers;
import de.robv.android.xposed.callbacks.XC_LoadPackage;

public final class HookEntry implements IXposedHookLoadPackage,
        IXposedHookZygoteInit {
    private static final String TARGET = "com.android.camera";
    private static final String OPLUS_CAMERA = "com.oplus.camera";
    private static final String MEDIA_EDITOR = "com.miui.mediaeditor";
    /**
     * The OPlus native face-shaping preview stack is not namespace-safe in
     * the HyperOS camera process.  Keep the Java beauty UI/request bridge,
     * but do not install any native preview hooks while the other camera
     * modes are being stabilized.
     */
    private static final boolean NATIVE_REMODELING_ENABLED = false;
    private static final String LOG = "[OS4CamBridge] ";
    private static final int XIAOMI_OP_MODE = 0x9002;
    /** Xiaomi's 50 MP module uses its own QCFA session identifier. */
    private static final int XIAOMI_HIGH_PIXEL_OP_MODE = 0x80f3;
    /** Stock ColorOS 16 uses the normal rear CameraUnit session for 50 MP. */
    private static final int OPLUS_HIGH_PIXEL_OP_MODE = 0x8001;
    private static final int XIAOMI_PORTRAIT_DEPTH_FORMAT = 0x20363159;
    private static final int OPLUS_PORTRAIT_1X_OP_MODE = 0x8011;
    private static final int OPLUS_PORTRAIT_2X_OP_MODE = 0x8030;
    private static final int OPLUS_PORTRAIT_TELE_OP_MODE = 0x8010;
    /**
     * Xiaomi assigns 0x8031 to SuperNightVideo.  On the OnePlus 13 camera
     * stack the same value means the second half-body portrait pipeline, so
     * libextensionlayer enters UpdateBokehCameraInfo and aborts while handling
     * the first repeating video request.  ColorOS' camera_unit_config maps
     * both normal and ultra night video to 0x80a2.
     */
    private static final int XIAOMI_VIDEO_NIGHT_OP_MODE = 0x8031;
    private static final int OPLUS_VIDEO_NIGHT_OP_MODE = 0x80a2;
    /** v32 only validates the target app linker namespace; no native init. */
    private static final boolean PREVIEW_NATIVE_PROCESS_ENABLED = false;
    private static final String YUV_PROBE_DIRECTORY =
            "/data/user/0/com.android.camera/files/os4_yuv_probe";
    private static final String YUV_PROBE_MARKER =
            YUV_PROBE_DIRECTORY + "/enable_capture";
    private static final String YUV_MULTIFRAME_MARKER =
            YUV_PROBE_DIRECTORY + "/enable_multiframe";
    private static final String YUV_FUSION_MARKER =
            YUV_PROBE_DIRECTORY + "/enable_fusion";
    private static final String YUV_FUSION_DISABLE_MARKER =
            YUV_PROBE_DIRECTORY + "/disable_fusion";
    private static final String DOCUMENT_AI_DIRECTORY =
            "/data/user/0/com.android.camera/files/os4_document_probe";
    private static final String DOCUMENT_AI_PROBE_MARKER =
            DOCUMENT_AI_DIRECTORY + "/enable_ai_probe";
    private static final String DOCUMENT_AI_DISABLE_MARKER =
            DOCUMENT_AI_DIRECTORY + "/disable_ai_text";
    /**
     * Read-only APS bootstrap probes.  These markers never alter a capture
     * request; they only prove that the ColorOS CameraUnit dex and APS v6
     * client can be linked from Xiaomi Camera's process before the real
     * common-photo graph is connected.
     */
    private static final String OPLUS_APS_PROBE_DIRECTORY =
            "/data/user/0/com.android.camera/files/os4_aps_probe";
    private static final String OPLUS_APS_CLASS_PROBE_MARKER =
            OPLUS_APS_PROBE_DIRECTORY + "/enable_class";
    private static final String OPLUS_APS_CONNECT_PROBE_MARKER =
            OPLUS_APS_PROBE_DIRECTORY + "/enable_connect";
    private static final String OPLUS_APS_GRAPH_PROBE_MARKER =
            OPLUS_APS_PROBE_DIRECTORY + "/enable_graph_init";
    private static final Object YUV_PROBE_LOCK = new Object();
    private static final Object FUSION_LOCK = new Object();
    private static final Object JPEG_POST_LOCK = new Object();
    private static final Object LEGEND_RAW_LOCK = new Object();
    private static final ThreadLocal<Boolean> YUV_BURST_GUARD =
            new ThreadLocal<>();
    private static final Map<CameraCharacteristics, String> CAMERA_IDS =
            Collections.synchronizedMap(new IdentityHashMap<>());
    private static final Map<String, CameraCharacteristics>
            CAMERA_CHARACTERISTICS = new ConcurrentHashMap<>();
    /**
     * Do not inherit pagani/OnePlus 13T's physical IDs.  The OnePlus 13 port
     * exposes three rear physical cameras behind logical camera 0, and their
     * enumeration can change when a different matching vendor/odm build is
     * flashed.  Classify each physical camera from its real horizontal field
     * of view, then build Xiaomi's role table from that runtime topology.
     */
    private static final Set<String> REAR_LOGICAL_PHYSICAL_IDS =
            ConcurrentHashMap.newKeySet();
    private static final Map<String, String> REAR_PHYSICAL_LENS_TYPES =
            new ConcurrentHashMap<>();
    private static final Map<String, Float> REAR_PHYSICAL_FOV =
            new ConcurrentHashMap<>();
    /** Verified OnePlus 13 fallback until all three characteristics arrive. */
    private static volatile int rearMainPhysicalCameraId = 2;
    private static volatile int rearUltraWidePhysicalCameraId = 3;
    private static volatile int rearTelePhysicalCameraId = 4;

    private static final CaptureRequest.Key<int[]> OPLUS_AF_REGION =
            new CaptureRequest.Key<>("com.oplus.control.af.region", int[].class);
    private static final CaptureRequest.Key<int[]> OPLUS_AE_REGION =
            new CaptureRequest.Key<>("com.oplus.control.ae.region", int[].class);
    private static final CaptureRequest.Key<int[]> OPLUS_FACE_BEAUTY_LEVEL =
            new CaptureRequest.Key<>("com.oplus.facebeauty.level", int[].class);
    private static final CaptureRequest.Key<int[]> OPLUS_FACE_BEAUTY_CUSTOM =
            new CaptureRequest.Key<>("com.oplus.facebeauty.custom", int[].class);
    private static final CaptureRequest.Key<byte[]> OPLUS_CAMERA_MODE =
            new CaptureRequest.Key<>("com.oplus.camera.mode", byte[].class);
    /**
     * CameraUnit marks every non-com.oplus.camera client with this byte tag.
     * It is the supported third-party entry into OPlus' 0x8001 stream map;
     * spoofing the system-camera package instead selects a different HAL
     * branch and is deliberately avoided.
     */
    private static final CaptureRequest.Key<byte[]>
            OPLUS_SDK_CAMERA_PACKAGE = new CaptureRequest.Key<>(
            "com.oplus.is.sdk.camera.package", byte[].class);
    private static final CaptureRequest.Key<Boolean>
            OPLUS_IS_FROM_MAIN_MENU = new CaptureRequest.Key<>(
            "com.oplus.camera.is.from.main.menu", Boolean.class);
    /**
     * ColorOS' CameraUnit configures SuperText v2 as an ordinary 0x8001
     * session carrying this mode string.  The raw vendor tag is byte-typed
     * even though CameraUnit exposes it as a Java String.
     */
    private static final byte[] OPLUS_SUPER_TEXT_CAMERA_MODE =
            "super_text_mode_v2\0".getBytes(StandardCharsets.UTF_8);
    private static final CaptureRequest.Key<Integer> OPLUS_SUPER_TEXT_MODE =
            new CaptureRequest.Key<>(
                    "com.oplus.preview.supertext.mode", Integer.class);
    /** Qualcomm/OnePlus session parameter; one still request is fused in HAL. */
    private static final CaptureRequest.Key<Integer> OPLUS_SESSION_MFNR =
            new CaptureRequest.Key<>(
                    "org.codeaurora.qcamera3.sessionParameters.enableMFNR",
                    Integer.class);
    /**
     * Exact array-typed tags emitted by ColorOS Camera for an ordinary rear
     * 1x shot.  The scalar session key above selects the CHI usecase; these
     * per-request arrays describe the four-frame/two-stream APS capture.
     */
    private static final CaptureRequest.Key<int[]> COMMON_APS_MFNR =
            new CaptureRequest.Key<>(
                    "org.codeaurora.qcamera3.sessionParameters.enableMFNR",
                    int[].class);
    private static final CaptureRequest.Key<int[]> COMMON_APS_AI_SCENE =
            new CaptureRequest.Key<>(
                    "com.oplus.ai.scene.app.enable", int[].class);
    private static final CaptureRequest.Key<int[]> COMMON_APS_SUPERNIGHT =
            new CaptureRequest.Key<>(
                    "com.oplus.supernight.mode", int[].class);
    private static final CaptureRequest.Key<int[]> COMMON_APS_REQUEST_NUM =
            new CaptureRequest.Key<>(
                    "com.oplus.capture.request.num", int[].class);
    private static final CaptureRequest.Key<int[]> COMMON_APS_REQUEST_NUM_LIST =
            new CaptureRequest.Key<>(
                    "com.oplus.capture.request.num.list", int[].class);
    private static final CaptureRequest.Key<int[]> COMMON_APS_SALIENT =
            new CaptureRequest.Key<>(
                    "com.oplus.salient.object.detection.enable", int[].class);
    private static final CaptureRequest.Key<int[]> COMMON_APS_FEATURE =
            new CaptureRequest.Key<>(
                    "com.oplus.aps.feature.type", int[].class);
    private static final CaptureRequest.Key<int[]> COMMON_APS_SENSOR_MODE =
            new CaptureRequest.Key<>(
                    "com.oplus.sensor.mode", int[].class);
    private static final CaptureRequest.Key<int[]> COMMON_APS_SENSOR_MODE_LIST =
            new CaptureRequest.Key<>(
                    "com.oplus.sensor.mode.list", int[].class);
    private static final CaptureRequest.Key<int[]> COMMON_APS_REQUEST_INDEX =
            new CaptureRequest.Key<>(
                    "com.oplus.capture.request.idx", int[].class);
    private static final CaptureRequest.Key<int[]> COMMON_APS_IPE_SEQUENCE =
            new CaptureRequest.Key<>(
                    "com.oplus.ipe.sequence", int[].class);
    private static final CaptureRequest.Key<int[]> COMMON_APS_BRACKET_MODE =
            new CaptureRequest.Key<>(
                    "com.oplus.BracketMode", int[].class);
    private static final CaptureRequest.Key<int[]> COMMON_APS_AIS_STATE =
            new CaptureRequest.Key<>(
                    "com.oplus.ais.state", int[].class);
    private static final CaptureRequest.Key<int[]> COMMON_APS_AUTO_HDR =
            new CaptureRequest.Key<>(
                    "com.oplus.auto.hdr.enable", int[].class);
    private static final CaptureRequest.Key<int[]> COMMON_APS_ZOOM_FEATURE =
            new CaptureRequest.Key<>(
                    "com.oplus.aps.zoom.feature", int[].class);
    private static final CaptureRequest.Key<int[]>
            COMMON_APS_SAT_MASTER_CAMERA = new CaptureRequest.Key<>(
            "com.oplus.aps.sat.snapshot.master.camIndex", int[].class);
    private static final CaptureRequest.Key<int[]> COMMON_APS_MOVING_OBJECT =
            new CaptureRequest.Key<>(
                    "com.oplus.moving.object", int[].class);
    private static final CaptureRequest.Key<float[]> OPLUS_ORIGINAL_ZOOM =
            new CaptureRequest.Key<>(
                    "com.oplus.original.zoomRatio", float[].class);
    private static final CaptureRequest.Key<float[]> OPLUS_ZOOM_TARGET =
            new CaptureRequest.Key<>(
                    "com.oplus.zoom.target", float[].class);
    private static final CaptureRequest.Key<int[]> OPLUS_POINT_ZOOM =
            new CaptureRequest.Key<>(
                    "com.oplus.zoom.isPointZoom", int[].class);
    private static final CaptureRequest.Key<float[]> OPLUS_BOKEH_LEVEL =
            new CaptureRequest.Key<>("com.oplus.bokeh.level", float[].class);
    private static final CaptureResult.Key<int[]> OPLUS_FACE_BEAUTY_LEVEL_RESULT =
            new CaptureResult.Key<>("com.oplus.facebeauty.level", int[].class);
    private static final CaptureResult.Key<int[]> OPLUS_FACE_BEAUTY_CUSTOM_RESULT =
            new CaptureResult.Key<>("com.oplus.facebeauty.custom", int[].class);
    private static final CaptureResult.Key<int[]> OPLUS_FB_FACE_INFO_RESULT =
            new CaptureResult.Key<>("com.oplus.fb.face.info", int[].class);
    private static final CaptureResult.Key<int[]> OPLUS_PREVIEW_FFD_RESULT =
            new CaptureResult.Key<>("com.oplus.preview.ffd", int[].class);
    private static final CaptureResult.Key<byte[]> OPLUS_SENSOR_NAME_RESULT =
            new CaptureResult.Key<>("com.oplus.SensorName", byte[].class);
    private static final CaptureResult.Key<Integer> MFNR_TOTAL_FRAMES =
            new CaptureResult.Key<>(
                    "org.quic.camera2.mfnrconfigs.MFNRTotalNumFrames",
                    Integer.class);
    private static final CaptureResult.Key<Integer> MFNR_BLEND_FRAME =
            new CaptureResult.Key<>(
                    "org.quic.camera2.mfnrconfigs.MFNRBlendFrameNum",
                    Integer.class);
    private static final CaptureResult.Key<Integer> SW_MFNR_BLENDED_FRAMES =
            new CaptureResult.Key<>(
                    "com.qti.camera.swmfnrBlendConfidence.SWMFNRBlendedFrames",
                    Integer.class);
    private static final CaptureResult.Key<Float> SW_MFNR_BLEND_CONFIDENCE =
            new CaptureResult.Key<>(
                    "com.qti.camera.swmfnrBlendConfidence.SWMFNRBlendConfidence",
                    Float.class);
    private static final CaptureResult.Key<float[]> OPLUS_MFNR_SHARPNESS =
            new CaptureResult.Key<>("com.oplus.mfnr.sharpnessVal", float[].class);
    private static final CaptureResult.Key<Float> QTI_AEC_LUX_INDEX =
            new CaptureResult.Key<>(
                    "org.quic.camera2.statsconfigs.AECLuxIndex", Float.class);
    private static final CaptureResult.Key<Integer> QTI_AWB_FRAME_CCT =
            new CaptureResult.Key<>(
                    "org.quic.camera2.statsconfigs.AWBFrameControlCCT",
                    Integer.class);
    private static final CaptureResult.Key<Float> QTI_CHI_AEC_LUX =
            new CaptureResult.Key<>("com.qti.chi.statsaec.AecLux", Float.class);
    private static final CaptureResult.Key<Integer> QTI_AWB_CCT =
            new CaptureResult.Key<>("com.qti.stats.awbwrapper.AWBCCT", Integer.class);
    private static final CaptureResult.Key<Float> OPLUS_AWB_SENSOR_CCT =
            new CaptureResult.Key<>("com.oplus.awb.colorsensor.CCT", Float.class);
    private static final CaptureResult.Key<Float> OPLUS_RAW_HDR_LUX_INDEX =
            new CaptureResult.Key<>("com.oplus.rawhdr.isp.luxindex", Float.class);

    private static volatile boolean loggedMivi;
    private static volatile boolean loggedParallel;
    private static volatile boolean loggedRoles;
    private static volatile boolean loggedStillQuality;
    private static volatile boolean loggedMfnrSession;
    private static volatile boolean loggedVideoFpsCompat;
    private static volatile boolean loggedVideoEis60Compat;
    private static volatile boolean loggedVideoAudioCompat;
    private static volatile boolean loggedXiaomiCameraPrivilege;
    private static volatile boolean loggedOplusCameraPrivilege;
    private static volatile boolean loggedLeicaMetadata;
    private static volatile int activeCameraModule = -1;
    private static volatile int activeBeautyModule = -1;
    private static volatile int activeCameraId = -1;
    private static volatile boolean activeBeautyEnabled;
    private static volatile int[] activeBeautyUi13 = new int[13];
    private static volatile int[] activeBeautyPreviewHal14 = new int[14];
    private static volatile String lastBeautyRequestSignature = "";
    private static volatile float lastLoggedZoomRatio = Float.NaN;
    private static volatile String lastLoggedVideoPhysicalZoomSignature = "";
    private static volatile String lastUnifiedPreviewRouteSignature = "";
    private static volatile String lastPhotoFpsSignature = "";
    private static volatile String lastOplusReferenceRouteSignature = "";
    private static volatile int latestLeicaLux = 300;
    private static volatile int latestLeicaCct = 4500;
    private static volatile float latestLeicaZoom = 1.0f;
    private static volatile byte[] leicaParamBlob;
    private static volatile String moduleApkPath;
    private static volatile ImageReader fullYuvReader;
    private static volatile HandlerThread fullYuvThread;
    private static volatile boolean fullYuvSessionActive;
    private static volatile int fullYuvFrameCount;
    private static volatile int fullYuvExpectedFrames = 1;
    private static volatile ImageReader legendRawReader;
    private static volatile HandlerThread legendRawThread;
    private static volatile int legendRawReaderCameraId = -1;
    private static volatile boolean legendRawSessionActive;
    private static volatile int legendRawCameraId = -1;
    // Fail closed until Camera's persisted M3/M9 component or the session
    // parameter identifies the product.  Defaulting to M9 caused a freshly
    // selected M3 shot to inherit the M9 RAW container when Xiaomi reused the
    // already configured module-256 session.
    private static volatile int activeLegendMode;
    private static volatile Context mediaEditorContext;
    private static volatile Uri mediaEditorLegendSourceUri;
    private static final Map<Object, Uri> MEDIA_EDITOR_LEGEND_URIS =
            Collections.synchronizedMap(new WeakHashMap<>());
    private static final Map<Object, Bitmap> MEDIA_EDITOR_LEGEND_BITMAPS =
            Collections.synchronizedMap(new WeakHashMap<>());
    /** Held only across Legendary's reset=8 module recreation. */
    private static volatile float pendingLegendPhysicalZoom = Float.NaN;
    private static volatile int pendingLegendPhysicalCameraId = -1;
    /** Held while ordinary Photo recreates itself on a Pro physical lens. */
    private static volatile float pendingPhotoPhysicalZoom = Float.NaN;
    private static volatile int pendingPhotoPhysicalCameraId = -1;
    private static final Object PHOTO_PRO_DIRECT_SESSION_LOCK = new Object();
    private static volatile CameraCaptureSession photoProDirectSession;
    private static volatile OutputConfiguration photoProDirectPreviewOutput;
    private static volatile Surface photoProDirectPreviewSurface;
    private static volatile Surface photoProDirectJpegSurface;
    private static volatile Surface photoProDirectAnalysisSurface;
    private static volatile boolean photoProDirectSessionPending;
    private static volatile boolean photoProDirectSessionActive;
    private static volatile int photoProDirectSessionGeneration;
    /**
     * Real state owned by Xiaomi's ComponentConfigMotionCapture.  The port
     * updates the top-bar component, but never carries that state into the
     * repeating Camera2 request on OnePlus.  Cache the component answer and
     * use it only while Photo's physical Pro graph is active.
     */
    private static volatile boolean photoMotionCaptureEnabled;
    private static volatile String lastPhotoMotionFpsRewriteSignature = "";
    private static volatile String latestDynamicPhotoSavePath;
    private static volatile long latestDynamicPhotoSavePathNanos;
    private static final Map<Long, LegendRawFrame> LEGEND_RAW_FRAMES =
            new ConcurrentHashMap<>();
    private static final ArrayList<FusionFrame> FUSION_FRAMES =
            new ArrayList<>(5);
    private static final Map<Object, Boolean> DOCUMENT_TASKS_PROCESSED =
            Collections.synchronizedMap(new WeakHashMap<>());
    private static final Set<String> LOGICAL_CAMERA_CONTRACT_LOGGED =
            ConcurrentHashMap.newKeySet();
    private static final Set<String> REAR_TOPOLOGY_LOGGED =
            ConcurrentHashMap.newKeySet();
    private static final Set<String> LOGICAL_LENS_OWNERSHIP_LOGGED =
            ConcurrentHashMap.newKeySet();
    private static final ThreadLocal<Boolean> SHOT_TO_SHOT_EVALUATION =
            new ThreadLocal<>();
    private static final ThreadLocal<Object> DYNAMIC_PHOTO_SAVE_RECORD =
            new ThreadLocal<>();
    private static final ThreadLocal<Boolean> DYNAMIC_PHOTO_MARK_FINISHED =
            new ThreadLocal<>();
    /**
     * The OnePlus HAL result reaches MiCamera2ShotStill, but Xiaomi's direct
     * JPEG compatibility path does not copy it into Rh.r.  Sensor timestamp is
     * also Rh.r's task timestamp, so it is a lossless per-shot join key.
     */
    private static final Map<Long, TotalCaptureResult> STILL_CAPTURE_RESULTS =
            new ConcurrentHashMap<>();
    private static volatile boolean fusionCapturePending;
    private static volatile byte[] pendingFusedJpeg;
    private static volatile String fusionFailure;
    private static final Object PREVIEW_BEAUTY_LOCK = new Object();
    private static OplusFaceBeautyPreview previewBeautyEngine;
    private static Object previewBeautyRenderOwner;
    private static Object previewBeautyEglContext;
    private static int previewBeautyWidth;
    private static int previewBeautyHeight;
    private static String previewBeautyParameterSignature = "";
    private static long previewBeautyRetryAfterMs;
    private static long previewBeautyLastErrorMs;
    private static boolean previewBeautyFirstFrameLogged;
    private static int previewBeautyLandscapeInputTexture;
    private static int previewBeautyLandscapeInputFramebuffer;
    private static int[] previewBeautyLandscapeOutputTextures = new int[2];
    private static int previewBeautyPortraitOutputFramebuffer;
    private static int previewBeautyBlitProgram;
    private static int previewBeautyOutputIndex;
    private static volatile OplusBeautyMetadataFrame latestBeautyMetadata;
    private static volatile byte[] latestFrontSensorName;
    private static volatile long submittedBeautyMetaTimestamp = Long.MIN_VALUE;
    private static volatile long submittedBeautyFfdTimestamp = Long.MIN_VALUE;
    private static volatile boolean loggedBeautyMetadataWaiting;
    private static volatile boolean loggedBeautyMetadataActive;
    private static volatile boolean loggedBeautyFfdActive;
    private static volatile boolean loggedFrontSensorName;
    private static volatile boolean loggedBeautyNativeFeed;
    private static volatile ClassLoader cameraAppClassLoader;
    private static volatile ClassLoader oplusApsClassLoader;
    private static final Object COMMON_APS_LOCK = new Object();
    private static final Object COMMON_APS_UNIFIED_SESSION_LOCK =
            new Object();
    private static final ThreadLocal<Boolean> COMMON_APS_BURST_GUARD =
            new ThreadLocal<>();
    private static final int COMMON_APS_NORMAL_FRAME_COUNT = 4;
    private static final int COMMON_APS_HDR_FRAME_COUNT = 5;
    private static final int PORTRAIT_APS_FRAME_COUNT = 7;
    private static final int COMMON_APS_ULTRAWIDE_FRAME_COUNT = 8;
    private static final int COMMON_APS_MAX_FRAME_COUNT =
            COMMON_APS_ULTRAWIDE_FRAME_COUNT;
    /**
     * A healthy five-frame rear capture returns its final JPEG in about four
     * seconds on this device.  Waiting a full minute after a dead provider
     * only leaves Xiaomi's shot queue wedged, so treat eight seconds without
     * a terminal APS output as a dead client and rebuild it.
     */
    private static final long COMMON_APS_CAPTURE_TIMEOUT_MS = 8_000L;
    /**
     * CameraUnit never submits a common/2DOL still burst immediately from
     * onConfigured().  It starts a repeating preview burst and blocks until
     * preview metadata is flowing.  Besides giving 3A a real result, that
     * first stream-on phase lets the two-sensor SAT graph allocate its large
     * buffers incrementally instead of doing it in the first still request.
     */
    private static final int COMMON_APS_WARMUP_RESULT_COUNT = 8;
    private static final long COMMON_APS_WARMUP_TIMEOUT_MS = 5_000L;
    /**
     * The proof is an isolated Camera2 sidecar.  Xiaomi's already-submitted
     * JPEG request is never mutated or replaced until the APS result has
     * proved both complete and better.
     */
    private static final boolean COMMON_APS_PROOF_ENABLED = false;
    /**
     * A one-shot, marker-gated validation of the only architecture which can
     * satisfy both camera stacks: close Xiaomi's three-output session while
     * retaining CameraDevice, configure the official third-party common-SAT
     * graph, then close it and rebuild Xiaomi through its original T2 call.
     * The portable graph mirrors the nine outputs observed on the working
     * stock OPlus common-SAT session.  Even surfaces which are not explicit
     * still-request targets remain part of CameraUnit's stream topology and
     * therefore must retain their stock order, role and stream-use-case.
     */
    private static final boolean COMMON_APS_HANDOFF_PROBE_ENABLED = true;
    private static final String COMMON_APS_HANDOFF_PROBE_MARKER =
            "/sdcard/Download/os4_enable_session_handoff";
    private static final String COMMON_APS_CAPTURE_PROBE_MARKER =
            "/sdcard/Download/os4_enable_common_aps_capture";
    /**
     * One-shot production validation.  Unlike the automatic graph proof, the
     * marker arms the next ordinary rear Photo shutter.  Xiaomi is allowed to
     * create its real Rh.r task first; its HAL JPEG is then replaced by the
     * completed APS JPEG before Xiaomi's Effect/Exif/Water/Store chain runs.
     */
    private static final String COMMON_APS_SHUTTER_PROBE_MARKER =
            "/sdcard/Download/os4_enable_common_aps_shutter";
    /**
     * One-process proof of the production architecture: keep Xiaomi's three
     * official outputs in the same CameraCaptureSession as the exact nine
     * OPlus common-SAT outputs.  The marker is consumed before configure so a
     * failed 12-stream experiment cannot loop after Camera is restarted.
     */
    private static final String COMMON_APS_UNIFIED_SESSION_MARKER =
            "/sdcard/Download/os4_enable_unified_aps_session";
    /** Compatible rear Photo/Document sessions are rebuilt after every resume. */
    private static final boolean COMMON_APS_UNIFIED_DAILY_ENABLED = true;
    /** The v128 one-shot proved the save chain; daily handoff stays disabled. */
    private static final boolean COMMON_APS_DAILY_SHUTTER_ENABLED = false;
    private static final long COMMON_APS_DOL_STREAM_USE_CASE =
            576460752303489024L;
    /** Legacy OPlus-process diagnostic only; never use this four-surface
     * shortcut for Xiaomi because the native SAT topology requires the
     * physical YUV and PIP outputs even when requests do not target them. */
    private static final boolean OPLUS_MINIMAL_GRAPH_TEST = false;
    private static final String[] COMMON_APS_INIT_ALGORITHMS = new String[]{
            "aps_algo_face_info", "aps_algo_upscale",
            "aps_algo_sw_png_encode", "aps_algo_ice_ainr",
            "aps_algo_facebase_retouch",
            "aps_algo_turbo_hdr", "aps_algo_rectify",
            "aps_algo_text_enhance", "aps_algo_mask_refine",
            "aps_algo_watermark", "aps_algo_face_rectify",
            "aps_algo_face_restore",
            "aps_algo_rotate_mirror", "aps_algo_ai_sr",
            "aps_algo_cfr", "aps_algo_hybridraw",
            "aps_algo_mfnr", "aps_algo_aimoon",
            "aps_algo_merge_hdr", "aps_algo_super_text",
            "aps_algo_filter", "aps_algo_fusion"
    };
    private static final String[] COMMON_APS_PROCESS_ALGORITHMS = new String[]{
            "aps_algo_turbo_hdr", "aps_algo_cfr",
            "aps_algo_mask_refine",
            "aps_algo_rotate_mirror",
            "aps_algo_upscale", "aps_algo_watermark"
    };
    /** Exact algorithm set from a cold-started ColorOS 3x portrait session. */
    private static final String[] PORTRAIT_APS_INIT_ALGORITHMS = new String[]{
            "aps_algo_face_info", "aps_algo_upscale",
            "aps_algo_facebase_retouch", "aps_algo_raw2yuv",
            "aps_algo_turbo_hdr", "aps_algo_mask_refine",
            "aps_algo_watermark", "aps_algo_face_restore",
            "aps_algo_rotate_mirror", "aps_algo_bokeh",
            "aps_algo_mfnr", "aps_algo_filter"
    };
    private static final String[] PORTRAIT_APS_PROCESS_ALGORITHMS =
            new String[]{
                    "aps_algo_turbo_hdr", "aps_algo_raw2yuv",
                    "aps_algo_bokeh", "aps_algo_mask_refine",
                    "aps_algo_rotate_mirror", "aps_algo_upscale",
                    "aps_algo_watermark"
            };
    private static final String[] COMMON_APS_ULTRAWIDE_PROCESS_ALGORITHMS =
            new String[]{
                    "aps_algo_turbo_hdr", "aps_algo_rectify",
                    "aps_algo_cfr", "aps_algo_mask_refine",
                    "aps_algo_rotate_mirror", "aps_algo_upscale",
                    "aps_algo_watermark"
            };
    /** Exact ColorOS 3x common-photo set; tele does not run UW rectify/CFR. */
    private static final String[] COMMON_APS_TELE_PROCESS_ALGORITHMS =
            new String[]{
                    "aps_algo_turbo_hdr", "aps_algo_mask_refine",
                    "aps_algo_rotate_mirror", "aps_algo_upscale",
                    "aps_algo_watermark"
            };
    private static volatile Application xiaomiCameraApplication;
    private static volatile HandlerThread commonApsThread;
    private static volatile Handler commonApsHandler;
    private static volatile ImageReader commonRawMainReader;
    private static volatile ImageReader commonRawDolReader;
    private static volatile ImageReader commonCaptureMetaReader;
    private static volatile ImageReader commonAuxYuvReader;
    private static volatile ImageReader commonPhysical2YuvReader;
    private static volatile ImageReader commonPhysical3YuvReader;
    private static volatile ImageReader commonPhysical4YuvReader;
    private static volatile ImageReader commonSmallYuvReader;
    private static volatile ImageReader commonFullsizeRawReader;
    private static volatile ImageReader portraitCaptureMetaReader;
    private static volatile ImageReader portraitPreviewYuvReader;
    private static volatile ImageReader portraitSmallYuvReader;
    private static volatile ImageReader portraitMainRawReader;
    private static volatile ImageReader portraitAuxRawReader;
    private static volatile ImageReader portraitGraphRawReader;
    private static final AtomicBoolean COMMON_APS_HANDOFF_SCHEDULED =
            new AtomicBoolean(false);
    private static final AtomicBoolean COMMON_APS_HANDOFF_IN_FLIGHT =
            new AtomicBoolean(false);
    private static final AtomicBoolean COMMON_APS_HANDOFF_XIAOMI_RELEASED =
            new AtomicBoolean(false);
    private static final AtomicBoolean COMMON_APS_HANDOFF_T2_OBSERVED =
            new AtomicBoolean(false);
    private static final AtomicBoolean COMMON_APS_HANDOFF_F1_OBSERVED =
            new AtomicBoolean(false);
    private static final AtomicBoolean COMMON_APS_SHUTTER_PREP_SCHEDULED =
            new AtomicBoolean(false);
    private static final AtomicBoolean COMMON_APS_SHUTTER_ARMED =
            new AtomicBoolean(false);
    private static final AtomicBoolean COMMON_APS_SHUTTER_HANDOFF_STARTED =
            new AtomicBoolean(false);
    private static final AtomicBoolean COMMON_APS_UNIFIED_PREVIEW_LOGGED =
            new AtomicBoolean(false);
    private static final AtomicBoolean COMMON_APS_ULTRAWIDE_ROUTE_LOGGED =
            new AtomicBoolean(false);
    private static final AtomicBoolean COMMON_APS_TELE_ROUTE_LOGGED =
            new AtomicBoolean(false);
    private static final AtomicBoolean COMMON_APS_TELE_PREVIEW_DIFF_LOGGED =
            new AtomicBoolean(false);
    private static final Object COMMON_APS_SHUTTER_LOCK = new Object();
    private static final Object COMMON_APS_JPEG_LOOPBACK_LOCK = new Object();
    private static volatile CameraCaptureSession commonApsHandoffSession;
    private static volatile Object commonApsHandoffOwner;
    private static volatile Object[] commonApsHandoffPreviewArgs;
    private static volatile int commonApsHandoffGeneration;
    private static volatile long commonApsShutterTimestamp = -1L;
    private static volatile CaptureRequest commonApsShutterRequest;
    private static volatile byte[] commonApsShutterJpeg;
    private static volatile String commonApsShutterFailure;
    private static volatile boolean commonApsShutterRhSeen;
    private static volatile boolean commonApsUnifiedSessionPending;
    private static volatile boolean commonApsUnifiedSessionActive;
    private static volatile CameraCaptureSession commonApsUnifiedSession;
    private static volatile CaptureRequest
            commonApsUnifiedSessionParameters;
    private static volatile Surface commonApsUnifiedXiaomiPreviewSurface;
    private static volatile Surface commonApsUnifiedXiaomiJpegSurface;
    private static volatile Surface
            commonApsUnifiedXiaomiSecondaryJpegSurface;
    private static volatile int commonApsUnifiedCameraModule = -1;
    private static volatile boolean commonApsUnifiedPortraitSession;
    private static volatile int commonApsUnifiedSessionGeneration;
    private static volatile boolean commonApsUnifiedAutoDisabled;
    private static volatile int commonApsUnifiedConfigureFailures;
    private static volatile boolean commonApsPhotoSessionActive;
    private static volatile boolean commonApsReady;
    private static volatile boolean commonApsDisabled;
    private static volatile boolean commonApsClientPortrait;
    private static volatile Object commonApsClient;
    private static volatile Object commonApsAlgoObject;
    private static volatile Object commonApsWatermark;
    private static volatile int commonApsClientGeneration;
    private static volatile String[] commonApsStartParameterReference;
    private static volatile String[] commonApsBeforeParameterReference;
    private static volatile String[] commonApsFrameParameterReference;
    private static volatile String[] commonApsProcessParameterReference;
    private static volatile String[] commonApsUltraWideStartParameterReference;
    private static volatile String[] commonApsUltraWideBeforeParameterReference;
    private static volatile String[] commonApsUltraWideFrameParameterReference;
    private static volatile String[] commonApsUltraWideProcessParameterReference;
    private static volatile boolean commonApsCaptureInFlight;
    private static volatile boolean commonApsCollecting;
    private static volatile boolean commonApsSubmitScheduled;
    private static volatile boolean commonApsUltraWideCapture;
    private static volatile boolean commonApsTeleCapture;
    private static volatile boolean commonApsPortraitCapture;
    private static volatile int commonApsExpectedFrameCount =
            COMMON_APS_NORMAL_FRAME_COUNT;
    private static volatile int commonApsBracketMode;
    private static volatile int commonApsSuperNightScene = 4;
    private static volatile int commonApsTurboRawScene = 4;
    private static volatile int commonApsFeatureType = 50;
    private static volatile int commonApsAisState = 8;
    private static volatile int[] commonApsEvList = new int[20];
    private static volatile int commonApsOrientation;
    private static volatile float commonApsZoomRatio = 1.0f;
    private static volatile long commonApsAvailableMemory;
    private static volatile TotalCaptureResult commonApsDecisionMetadata;
    private static volatile long commonApsDecisionMetadataNanos;
    private static volatile int commonAuxYuvDrainCount;
    private static volatile long commonApsIdentity = -1L;
    private static volatile long commonApsPictureTimeMillis;
    private static volatile String commonApsPictureTitle;
    private static volatile int commonApsCaptureGeneration;
    private static final Map<Long, CommonApsFrame> COMMON_APS_FRAMES =
            new HashMap<>();
    private static final ArrayList<Image> COMMON_APS_RETAINED_INPUTS =
            new ArrayList<>(COMMON_APS_MAX_FRAME_COUNT * 3);
    private static final AtomicBoolean COMMON_APS_OUTPUT_HANDLED =
            new AtomicBoolean(false);
    private static volatile boolean commonApsJpegNativeLoaded;
    private static volatile boolean commonApsJpegNativeLoadAttempted;
    private static final AtomicBoolean OPLUS_APS_CLASS_PROBED =
            new AtomicBoolean(false);
    private static final AtomicBoolean OPLUS_APS_CONNECT_PROBED =
            new AtomicBoolean(false);
    private static final AtomicBoolean OPLUS_REFERENCE_INIT_DUMPED =
            new AtomicBoolean(false);
    private static final AtomicBoolean OPLUS_REFERENCE_START_DUMPED =
            new AtomicBoolean(false);
    private static final AtomicBoolean OPLUS_REFERENCE_BEFORE_DUMPED =
            new AtomicBoolean(false);
    private static final AtomicBoolean OPLUS_REFERENCE_PARAMETERS_DUMPED =
            new AtomicBoolean(false);
    private static final AtomicBoolean OPLUS_REFERENCE_PROCESS_DUMPED =
            new AtomicBoolean(false);
    private static final AtomicBoolean OPLUS_REFERENCE_SESSION_PARAMS_DUMPED =
            new AtomicBoolean(false);
    private static final AtomicBoolean OPLUS_REFERENCE_SESSION_PARCEL_DUMPED =
            new AtomicBoolean(false);
    private static final AtomicBoolean OPLUS_REFERENCE_PREVIEW_PARAMS_DUMPED =
            new AtomicBoolean(false);
    private static final java.util.concurrent.atomic.AtomicInteger
            OPLUS_REFERENCE_FRAME_COUNT =
            new java.util.concurrent.atomic.AtomicInteger(0);
    private static final java.util.concurrent.atomic.AtomicInteger
            OPLUS_REFERENCE_REQUEST_METADATA_COUNT =
            new java.util.concurrent.atomic.AtomicInteger(0);
    private static final java.util.concurrent.atomic.AtomicInteger
            OPLUS_REFERENCE_STILL_COUNT =
            new java.util.concurrent.atomic.AtomicInteger(0);
    private static final AtomicBoolean
            OPLUS_REFERENCE_STILL_PARCEL_DUMPED =
            new AtomicBoolean(false);
    private static final java.util.concurrent.atomic.AtomicInteger
            OPLUS_REFERENCE_PREVIEW_COUNT =
            new java.util.concurrent.atomic.AtomicInteger(0);
    private static final java.util.concurrent.atomic.AtomicInteger
            OPLUS_REFERENCE_SESSION_COUNT =
            new java.util.concurrent.atomic.AtomicInteger(0);
    private static final java.util.concurrent.atomic.AtomicInteger
            OPLUS_REFERENCE_VIDEO_ZOOM_COUNT =
            new java.util.concurrent.atomic.AtomicInteger(0);
    private static volatile String lastOplusVideoZoomSignature = "";
    private static final java.util.concurrent.atomic.AtomicInteger
            XIAOMI_SESSION_SPEC_COUNT =
            new java.util.concurrent.atomic.AtomicInteger(0);
    private static final Map<Surface, String> OPLUS_REFERENCE_SURFACES =
            Collections.synchronizedMap(new IdentityHashMap<>());
    private static final Map<Surface, String> SESSION_PROBE_READERS =
            Collections.synchronizedMap(new IdentityHashMap<>());
    private static volatile Class<?> targetPreviewWrapperClass;
    private static volatile File targetModuleLibraryDirectory;
    private static volatile boolean targetPreviewNamespaceLogged;
    private static volatile boolean targetSphalClosureProbed;
    private static final FloatBuffer PREVIEW_QUAD_VERTICES =
            directFloatBuffer(new float[]{
                    -1.0f, -1.0f, 1.0f, -1.0f,
                    -1.0f, 1.0f, 1.0f, 1.0f});
    private static final FloatBuffer PREVIEW_TEX_IDENTITY =
            directFloatBuffer(new float[]{
                    0.0f, 0.0f, 1.0f, 0.0f,
                    0.0f, 1.0f, 1.0f, 1.0f});
    private static final FloatBuffer PREVIEW_TEX_ROTATE_CW =
            directFloatBuffer(new float[]{
                    0.0f, 1.0f, 0.0f, 0.0f,
                    1.0f, 1.0f, 1.0f, 0.0f});
    private static final FloatBuffer PREVIEW_TEX_ROTATE_CCW =
            directFloatBuffer(new float[]{
                    1.0f, 0.0f, 1.0f, 1.0f,
                    0.0f, 0.0f, 0.0f, 1.0f});

    private static final class FusionFrame {
        final long timestamp;
        final byte[] y;
        final byte[] vu;

        FusionFrame(long timestamp, byte[] y, byte[] vu) {
            this.timestamp = timestamp;
            this.y = y;
            this.vu = vu;
        }
    }

    private static final class LegendRawFrame {
        final long timestamp;
        final byte[] raw10;
        final int rowStride;
        final int captureCameraId;
        final int sourceWhiteLevel;

        LegendRawFrame(long timestamp, byte[] raw10, int rowStride,
                int captureCameraId, int sourceWhiteLevel) {
            this.timestamp = timestamp;
            this.raw10 = raw10;
            this.rowStride = rowStride;
            this.captureCameraId = captureCameraId;
            this.sourceWhiteLevel = sourceWhiteLevel;
        }
    }

    private static final class CommonApsDecision {
        final int frameCount;
        final int bracketMode;
        final int superNightScene;
        final int turboRawScene;
        final int featureType;
        final int aisState;
        final int[] evList;
        final String source;
        final boolean teleSingleRaw;

        CommonApsDecision(int frameCount, int bracketMode,
                int superNightScene, int turboRawScene, int featureType,
                int aisState, int[] evList, String source) {
            this(frameCount, bracketMode, superNightScene, turboRawScene,
                    featureType, aisState, evList, source, false);
        }

        CommonApsDecision(int frameCount, int bracketMode,
                int superNightScene, int turboRawScene, int featureType,
                int aisState, int[] evList, String source,
                boolean teleSingleRaw) {
            this.frameCount = frameCount;
            this.bracketMode = bracketMode;
            this.superNightScene = superNightScene;
            this.turboRawScene = turboRawScene;
            this.featureType = featureType;
            this.aisState = aisState;
            this.evList = evList == null ? new int[20]
                    : Arrays.copyOf(evList, 20);
            this.source = source;
            this.teleSingleRaw = teleSingleRaw;
        }

        boolean isSupportedCommon2Dol() {
            return (frameCount == COMMON_APS_NORMAL_FRAME_COUNT
                    || frameCount == COMMON_APS_HDR_FRAME_COUNT)
                    && (bracketMode == 0 || bracketMode == 25)
                    && (superNightScene == 1 || superNightScene == 4)
                    && (turboRawScene == 1 || turboRawScene == 4)
                    && featureType == 50;
        }

        boolean isUltraWideSingleRaw() {
            return !teleSingleRaw
                    && frameCount == COMMON_APS_ULTRAWIDE_FRAME_COUNT
                    && bracketMode == 28
                    && superNightScene == 3
                    && turboRawScene == 3
                    && featureType == 48
                    && aisState == 0;
        }

        boolean isTeleSingleRaw() {
            return teleSingleRaw
                    && frameCount == COMMON_APS_ULTRAWIDE_FRAME_COUNT
                    && bracketMode == 28
                    && superNightScene == 3
                    && turboRawScene == 3
                    && featureType == 48
                    && aisState == 0;
        }

        boolean isSingleRaw() {
            return isUltraWideSingleRaw() || isTeleSingleRaw();
        }

        boolean isPortraitDualRaw() {
            return frameCount == PORTRAIT_APS_FRAME_COUNT
                    && bracketMode == 25
                    && superNightScene == 4
                    && turboRawScene == 4
                    && featureType == 48
                    && aisState == 0;
        }

        boolean isSupportedCommonCapture() {
            return isSupportedCommon2Dol() || isSingleRaw()
                    || isPortraitDualRaw();
        }

        String evListString() {
            return Arrays.toString(evList);
        }
    }

    private static final class CommonApsFrame {
        final long timestamp;
        Image main;
        Image dol;
        Image captureMeta;
        TotalCaptureResult result;
        int index;

        CommonApsFrame(long timestamp) {
            this.timestamp = timestamp;
        }

        boolean isComplete() {
            return main != null
                    && (commonApsUltraWideCapture || commonApsTeleCapture
                    || dol != null)
                    && captureMeta != null
                    && result != null
                    && index >= 1
                    && index <= commonApsExpectedFrameCount;
        }
    }

    @Override
    public void initZygote(StartupParam startupParam) {
        moduleApkPath = startupParam.modulePath;
    }

    @Override
    public void handleLoadPackage(XC_LoadPackage.LoadPackageParam lpparam) {
        if (!TARGET.equals(lpparam.packageName)
                && !OPLUS_CAMERA.equals(lpparam.packageName)
                && !MEDIA_EDITOR.equals(lpparam.packageName)) {
            return;
        }

        log("loading v0.4.77 in " + lpparam.processName);
        if (MEDIA_EDITOR.equals(lpparam.packageName)) {
            install("Leica Legendary editor capability bridge",
                    () -> hookMediaEditorLegendCapability(
                            lpparam.classLoader));
            install("Leica Legendary cloud orientation bridge",
                    () -> hookMediaEditorLegendOrientation(
                            lpparam.classLoader));
            return;
        }
        install("Camera2 high-speed privileged-app bridge",
                HookEntry::hookCamera2PrivilegedApps);

        // Keep the framework fix available to ColorOS Camera when both camera
        // packages are installed, but never install Xiaomi implementation
        // hooks into the unrelated OPlus application process.
        if (!TARGET.equals(lpparam.packageName)) {
            if (OPLUS_CAMERA.equals(lpparam.packageName)) {
                install("read-only OPlus framework stream probe",
                        HookEntry::hookOplusFrameworkSessionProbe);
                install("read-only stock OPlus APS reference probe",
                        () -> hookOplusApsReferenceProbe(
                                lpparam.classLoader));
                install("read-only stock OPlus active lens probe",
                        HookEntry::hookOplusActiveLensProbe);
            }
            log("OPlus Camera: scoped Camera2 privilege bridge installed");
            return;
        }

        cameraAppClassLoader = lpparam.classLoader;
        install("read-only Xiaomi ImageReader registry",
                HookEntry::hookSessionImageReaderRegistry);
        install("marker-gated OPlus APS runtime probe",
                () -> hookOplusApsRuntimeProbe(lpparam.classLoader));
        install("OPlus common-photo APS proof bridge",
                () -> hookOplusCommonPhotoBridge(lpparam.classLoader));
        install("recoverable OPlus APS death bridge",
                () -> hookRecoverableCommonApsDeath(lpparam.classLoader));
        install("marker-gated full OPlus session handoff probe",
                () -> hookFullOplusSessionHandoffProbe(
                        lpparam.classLoader));
        install("native Leica Legendary mode entry",
                () -> hookLegendaryMode(lpparam.classLoader));
        install("Leica Legendary RAW10/LSC save bridge",
                () -> hookLegendaryRawPipeline(lpparam.classLoader));
        install("framework role tags", HookEntry::hookFrameworkRoleTags);
        install("OS4 role container", () -> hookRoleContainer(lpparam.classLoader));
        install("logical camera selection",
                () -> hookLogicalCameraSelection(lpparam.classLoader));
        install("Photo/Legendary physical-lens restart protocol",
                () -> hookLegendaryPhysicalLensRestart(
                        lpparam.classLoader));
        install("NV21 image compatibility",
                () -> hookNv21ImageCompatibility(lpparam.classLoader));
        install("capture completion output contract",
                () -> hookCaptureCompletionContract(lpparam.classLoader));
        install("malformed role metadata fallback",
                () -> hookMalformedRoleMetadataFallback(
                        lpparam.classLoader));
        install("front camera ID fallback",
                () -> hookFrontCameraIdFallback(lpparam.classLoader));
        install("watermark shot-to-shot compatibility",
                () -> hookWatermarkShotToShotCompatibility(
                        lpparam.classLoader));
        install("watermark EXIF default compatibility",
                () -> hookWatermarkExifDefaults(lpparam.classLoader));
        install("dynamic photo preview completion",
                () -> hookDynamicPhotoPreviewCompletion(
                        lpparam.classLoader));
        install("dynamic photo PCM audio compatibility",
                () -> hookDynamicPhotoAudioCompatibility(
                        lpparam.classLoader));
        install("dynamic photo save-path compatibility",
                () -> hookDynamicPhotoSavePathCompatibility(
                        lpparam.classLoader));
        install("motion-capture 60fps request bridge",
                () -> hookMotionCaptureFpsBridge(lpparam.classLoader));
        install("rear high-pixel mode availability",
                () -> hookHighPixelModeAvailability(lpparam.classLoader));
        install("front beauty type compatibility",
                () -> hookFrontBeautyTypeCompatibility(lpparam.classLoader));
        install("verified camera module lifecycle",
                () -> hookCameraModuleLifecycle(lpparam.classLoader));
        install("OPlus HAL beauty request bridge",
                () -> hookOplusBeautyRequestBridge(lpparam.classLoader));
        if (NATIVE_REMODELING_ENABLED) {
            install("OPlus preview metadata bridge",
                    HookEntry::hookOplusPreviewMetadata);
            install("OPlus real preview texture bridge",
                    () -> hookOplusPreviewBeauty(lpparam.classLoader));
        } else {
            log("native face-shaping preview disabled; basic HAL beauty retained");
        }
        install("rear regular preview session", () -> hookPreviewSession(lpparam.classLoader));
        install("marker-gated full YUV probe", () -> hookFullYuvProbe(lpparam.classLoader));
        install("one-shot real YUV fusion", () -> hookFusedJpegReplacement(lpparam.classLoader));
        install("independent final JPEG effect pipeline",
                () -> hookFinalJpegEffects(lpparam.classLoader));
        install("native Xiaomi JPEG watermark adapter",
                () -> hookNativeJpegWatermark(lpparam.classLoader));
        install("watermark 35mm focal-length fallback",
                () -> hookWatermarkFocalLength(lpparam.classLoader));
        install("Xiaomi document save pipeline",
                () -> hookDocumentSavePipeline(lpparam.classLoader));
        install("Leica trigger metadata cache",
                HookEntry::hookLeicaCaptureMetadata);
        install("legacy full-resolution JPEG route", () -> hookLegacyJpeg(lpparam.classLoader));
        install("professional-photo direct Camera2 route",
                () -> hookProPhotoParallelCompat(lpparam.classLoader));
        install("OnePlus video FPS/audio compatibility",
                () -> hookVideoCompat(lpparam.classLoader));
        install("unsupported slow-motion mode hidden",
                () -> hookDisableSlowMotion(lpparam.classLoader));
        install("AF saliency guard", () -> hookAfSaliency(lpparam.classLoader));
        install("JPEG chain audit", () -> JpegChainProbe.install(lpparam.classLoader));
        install("Watermark shooting metadata", () -> JpegWatermarkMetadataBridge.install(lpparam.classLoader));
        install("Rear tele preview experiment", () -> RearTelePreviewBridge.install(lpparam.classLoader));
        install("Rear JPEG metadata ownership", () -> RearJpegMetadataBridge.install(lpparam.classLoader));
        install("Rear deferred preview", () -> RearDeferredPreviewBridge.install(lpparam.classLoader));
        install("Rear session parameter alignment", () -> RearSessionParameterBridge.install(lpparam.classLoader));
        install("Video logical wide zoom", () -> VideoLogicalWideZoomBridge.install(lpparam.classLoader));
        install("Generic video session", () -> GenericVideoSessionBridge.install(lpparam.classLoader));
        install("OnePlus three-camera lens ownership",
                () -> hookOnePlusLensOwnership(lpparam.classLoader));
        install("OPlus logical zoom bridge", () -> hookOplusLogicalZoom(lpparam.classLoader));
        install("portrait zoom selection persistence",
                () -> hookPortraitZoomSelectionPersistence(
                        lpparam.classLoader));
        install("OPlus rear photo MFNR session bridge",
                () -> hookOplusMfnrSession(lpparam.classLoader));
        install("HAL still quality hints", HookEntry::hookStillQualityHints);
        install("HAL still result probe", () -> hookStillResultProbe(lpparam.classLoader));
        install("OPlus touch AF/AE bridge",
                () -> hookOplusFocus(lpparam.classLoader));
        log("all hooks installed");
    }

    /**
     * OS4 MediaEditor already contains the newer Legendary cloud client, but
     * its gallery provider restricts the feature to device "nezha" with the
     * LCC theme property.  Change only the provider answer; account, region,
     * consent, upload and cloud-result checks remain owned by Xiaomi.
     */
    private static void hookMediaEditorLegendCapability(ClassLoader loader) {
        Class<?> provider = XposedHelpers.findClass(
                "com.miui.mediaeditor.provider.MediaEditorProviderForGallery",
                loader);
        XposedBridge.hookAllMethods(provider, "call", new XC_MethodHook() {
            @Override
            protected void afterHookedMethod(MethodHookParam param) {
                if (param.args == null || param.args.length < 1) {
                    return;
                }
                String method = String.valueOf(param.args[0]);
                boolean legacyLegend =
                        "method_is_legend_available".equals(method)
                                || "method_is_xm_legend_available".equals(
                                method);
                boolean unifiedCapabilities =
                        "method_is_device_support_capabilities".equals(
                                method);
                if (!legacyLegend && !unifiedCapabilities) {
                    return;
                }
                Bundle result = param.getResult() instanceof Bundle
                        ? (Bundle) param.getResult() : new Bundle();
                if (legacyLegend) {
                    result.putBoolean("key_common_is_available", true);
                }
                // Gallery 5.4 consumes the unified capability bundle and
                // persists both aliases as is_legend_available and
                // is_xm_legend_available.  Populate both without replacing
                // any unrelated MediaEditor capability returned by Xiaomi.
                result.putBoolean("method_is_legend_available", true);
                result.putBoolean("method_is_xm_legend_available", true);
                param.setResult(result);
                log("[LegendM9] MediaEditor provider capability=true method="
                        + method);
            }
        });
        log("[LegendM9] MediaEditor capability hook active");
    }

    /**
     * The M9 cloud service returns sensor-landscape pixels for containers
     * whose primary JPEG carries EXIF orientation 6/8. Rotate that cloud
     * bitmap before MediaEditor's downstream watermark/export stage. This is
     * deliberately dimension-guarded so a server build that already returns
     * portrait pixels is left untouched.
     */
    private static void hookMediaEditorLegendOrientation(
            ClassLoader loader) {
        XposedHelpers.findAndHookMethod(Application.class, "attach",
                Context.class, new XC_MethodHook() {
                    @Override
                    protected void afterHookedMethod(MethodHookParam param) {
                        Context context = (Context) param.thisObject;
                        Context application = context.getApplicationContext();
                        mediaEditorContext = application == null
                                ? context : application;
                    }
                });

        Class<?> processor = XposedHelpers.findClass("yc.j", loader);
        XposedBridge.hookAllMethods(processor, "g", new XC_MethodHook() {
            @Override
            protected void afterHookedMethod(MethodHookParam param) {
                if (param.args != null && param.args.length > 0
                        && param.args[0] instanceof Uri) {
                    mediaEditorLegendSourceUri = (Uri) param.args[0];
                }
            }
        });

        Class<?> collector = XposedHelpers.findClass("yc.i", loader);
        String entityName = "com.miui.mediaeditor.aigc.cloud.internal.legend"
                + ".api.entity.CloudLegendResultEntity";
        XposedBridge.hookAllMethods(collector, "emit", new XC_MethodHook() {
            @Override
            protected void beforeHookedMethod(MethodHookParam param) {
                if (param.args == null || param.args.length == 0
                        || param.args[0] == null) {
                    return;
                }
                try {
                    Object entity = XposedHelpers.getObjectField(
                            param.args[0], "b");
                    if (entity == null || !entityName.equals(
                            entity.getClass().getName())) {
                        return;
                    }
                    Uri source = mediaEditorLegendSourceUri;
                    try {
                        Object owner = XposedHelpers.getObjectField(
                                param.thisObject, "a");
                        Object value = XposedHelpers.getObjectField(owner, "c");
                        if (value instanceof Uri) {
                            source = (Uri) value;
                        }
                    } catch (Throwable ignored) {
                        // The processor-level URI remains a safe fallback.
                    }
                    if (source != null) {
                        MEDIA_EDITOR_LEGEND_URIS.put(entity, source);
                    }
                } catch (Throwable ignored) {
                    // Progress/error emissions do not contain an entity.
                }
            }
        });

        Class<?> entity = XposedHelpers.findClass(entityName, loader);
        XposedBridge.hookAllMethods(entity, "getResultBitmap",
                new XC_MethodHook() {
                    @Override
                    protected void afterHookedMethod(MethodHookParam param) {
                        if (!(param.getResult() instanceof Bitmap)) {
                            return;
                        }
                        Bitmap cached = MEDIA_EDITOR_LEGEND_BITMAPS.get(
                                param.thisObject);
                        if (cached != null) {
                            param.setResult(cached);
                            return;
                        }
                        Uri source = MEDIA_EDITOR_LEGEND_URIS.get(
                                param.thisObject);
                        if (source == null) {
                            source = mediaEditorLegendSourceUri;
                        }
                        int orientation = readMediaEditorExifOrientation(
                                source);
                        Bitmap bitmap = (Bitmap) param.getResult();
                        int degrees = exifRotationDegrees(orientation);
                        if ((orientation == 6 || orientation == 8)
                                && bitmap.getHeight() > bitmap.getWidth()) {
                            degrees = 0;
                        }
                        if (degrees == 0) {
                            MEDIA_EDITOR_LEGEND_BITMAPS.put(
                                    param.thisObject, bitmap);
                            return;
                        }
                        Matrix matrix = new Matrix();
                        matrix.postRotate(degrees);
                        Bitmap rotated = Bitmap.createBitmap(bitmap, 0, 0,
                                bitmap.getWidth(), bitmap.getHeight(), matrix,
                                true);
                        MEDIA_EDITOR_LEGEND_BITMAPS.put(
                                param.thisObject, rotated);
                        param.setResult(rotated);
                        log("[LegendM9] cloud bitmap rotated before watermark"
                                + " exif=" + orientation
                                + " degrees=" + degrees
                                + " input=" + bitmap.getWidth() + "x"
                                + bitmap.getHeight() + " output="
                                + rotated.getWidth() + "x"
                                + rotated.getHeight());
                    }
                });
        log("[LegendM9] MediaEditor cloud orientation hook active");
    }

    private static int readMediaEditorExifOrientation(Uri source) {
        Context context = mediaEditorContext;
        if (context == null || source == null) {
            return 1;
        }
        try (InputStream input = context.getContentResolver()
                .openInputStream(source)) {
            if (input == null) {
                return 1;
            }
            ByteArrayOutputStream header = new ByteArrayOutputStream(65536);
            byte[] buffer = new byte[8192];
            int remaining = 131072;
            while (remaining > 0) {
                int count = input.read(buffer, 0,
                        Math.min(buffer.length, remaining));
                if (count < 0) {
                    break;
                }
                header.write(buffer, 0, count);
                remaining -= count;
            }
            return LegendExifTagger.readOrientation(header.toByteArray());
        } catch (Throwable throwable) {
            log("[LegendM9] source EXIF orientation unavailable: "
                    + throwable);
            return 1;
        }
    }

    private static int exifRotationDegrees(int orientation) {
        if (orientation == 6) {
            return 90;
        }
        if (orientation == 3) {
            return 180;
        }
        if (orientation == 8) {
            return 270;
        }
        return 0;
    }

    /**
     * Run only after Application.attach(), when both Xiaomi's application
     * context and the OPlus Camera resource context are safe to create.  The
     * probe is marker-gated and deliberately does not initialize algorithms,
     * submit buffers, or touch Camera2 requests.
     */
    private static void hookOplusApsRuntimeProbe(ClassLoader appLoader) {
        if (!new File(OPLUS_APS_CLASS_PROBE_MARKER).isFile()
                && !new File(OPLUS_APS_CONNECT_PROBE_MARKER).isFile()) {
            log("[OplusAPSProbe] dormant (no marker)");
            return;
        }
        XposedHelpers.findAndHookMethod(Application.class, "attach",
                Context.class, new XC_MethodHook() {
                    @Override
                    protected void afterHookedMethod(MethodHookParam param) {
                        // Keep the real Application object.  A ContextImpl
                        // created for another package has no Application in
                        // this process; OPlus' holder normalizes such a
                        // Context through getApplicationContext() and would
                        // otherwise store null.
                        Context context = (Context) param.thisObject;
                        runOplusApsRuntimeProbe(context, appLoader);
                    }
                });
        log("[OplusAPSProbe] Application.attach trigger installed");
    }

    private static void runOplusApsRuntimeProbe(Context application,
            ClassLoader appLoader) {
        probeOplusApsClasses(appLoader);
        if (new File(OPLUS_APS_CONNECT_PROBE_MARKER).isFile()) {
            probeOplusApsConnection(application);
        }
    }

    private static void probeOplusApsClasses(ClassLoader appLoader) {
        if (!OPLUS_APS_CLASS_PROBED.compareAndSet(false, true)) {
            return;
        }
        try {
            String dexPath =
                    "/system_ext/framework/com.oplus.camera.unit.sdk.jar"
                            + ":/system_ext/framework/"
                            + "com.oplus.camera.unit.sdk.adapter.jar"
                            + ":/system_ext/framework/oplus-fwk.jar";
            PathClassLoader loader = new PathClassLoader(
                    dexPath, "/system_ext/lib64", appLoader);
            String[] required = new String[]{
                    "com.oplus.ocs.camera.consumer.apsAdapter.algorithm."
                            + "FullApsImpl",
                    "com.oplus.ocs.camera.consumer.apsAdapter.algorithm."
                            + "ApsInterface$ApsListener",
                    "com.oplus.ocs.camera.consumer.apsAdapter.adapter."
                            + "ApsInitParameter",
                    "com.oplus.ocs.camera.consumer.apsAdapter.adapter."
                            + "ApsCaptureParam",
                    "com.oplus.ocs.camera.producer.info."
                            + "CameraCharacteristicsWrapper",
                    "com.oplus.ocs.camera.consumer.apsAdapter.config."
                            + "AlgoSwitchConfig"
            };
            for (String name : required) {
                Class<?> resolved = Class.forName(name, false, loader);
                log("[OplusAPSProbe] linked " + resolved.getName()
                        + " constructors="
                        + resolved.getDeclaredConstructors().length);
            }
            oplusApsClassLoader = loader;
            log("[OplusAPSProbe] class-link complete loader=" + loader);
        } catch (Throwable throwable) {
            oplusApsClassLoader = null;
            OPLUS_APS_CLASS_PROBED.set(false);
            log("[OplusAPSProbe] class-link failed: " + throwable);
        }
    }

    /**
     * Connect and immediately disconnect an otherwise idle APS v6 client.
     * This verifies JNI/linker/service access only; no algorithm graph or
     * camera buffer is created.
     */
    private static void probeOplusApsConnection(Context application) {
        ClassLoader loader = oplusApsClassLoader;
        if (loader == null
                || !OPLUS_APS_CONNECT_PROBED.compareAndSet(false, true)) {
            return;
        }
        // Consume the marker before JNI is touched.  A process-level failure
        // must never turn this diagnostic into a restart loop.
        boolean consumed = new File(
                OPLUS_APS_CONNECT_PROBE_MARKER).delete();
        log("[OplusAPSProbe] one-shot connect marker consumed="
                + consumed);
        HandlerThread thread = new HandlerThread("OS4CamApsProbe");
        thread.start();
        new Handler(thread.getLooper()).post(() -> {
            Object fullAps = null;
            try {
                Context oplusContext = application.createPackageContext(
                        OPLUS_CAMERA, Context.CONTEXT_INCLUDE_CODE
                                | Context.CONTEXT_IGNORE_SECURITY);
                Class<?> contextHolder = Class.forName(
                        "com.oplus.ocs.camera.common.util.ContextHolder",
                        true, loader);
                XposedHelpers.callStaticMethod(contextHolder, "setContext",
                        application);
                Class<?> apsContextHolder = Class.forName(
                        "com.oplus.ocs.camera.consumer.apsAdapter."
                                + "ApsContextHolder", true, loader);
                XposedHelpers.callStaticMethod(apsContextHolder, "setContext",
                        application);
                Object storedContext = XposedHelpers.callStaticMethod(
                        apsContextHolder, "getContext");
                if (!(storedContext instanceof Context)) {
                    throw new IllegalStateException(
                            "APS context holder remained null");
                }
                log("[OplusAPSProbe] callback context="
                        + ((Context) storedContext).getPackageName());

                Class<?> config = Class.forName(
                        "com.oplus.ocs.camera.consumer.apsAdapter.config."
                                + "AlgoSwitchConfig", true, loader);
                XposedHelpers.callStaticMethod(config, "initialize",
                        oplusContext);
                Object version = XposedHelpers.callStaticMethod(
                        config, "getApsVersion");
                Object mode = XposedHelpers.callStaticMethod(
                        config, "getApsMode");
                log("[OplusAPSProbe] config version=" + version
                        + " mode=" + mode
                        + " resourceSource="
                        + oplusContext.getApplicationInfo().sourceDir);

                Class<?> listenerClass = Class.forName(
                        "com.oplus.ocs.camera.consumer.apsAdapter.algorithm."
                                + "ApsInterface$ApsListener", false, loader);
                Object listener = Proxy.newProxyInstance(loader,
                        new Class<?>[]{listenerClass},
                        (proxy, method, args) -> {
                            log("[OplusAPSProbe] callback="
                                    + method.getName());
                            return defaultReflectionValue(
                                    method.getReturnType());
                        });
                Class<?> fullClass = Class.forName(
                        "com.oplus.ocs.camera.consumer.apsAdapter.algorithm."
                                + "FullApsImpl", true, loader);
                fullAps = fullClass
                        .getConstructor(listenerClass, String.class)
                        .newInstance(listener, "V002.000.000");
                Object connected = XposedHelpers.callMethod(
                        fullAps, "connect", 6);
                log("[OplusAPSProbe] native capture connection="
                        + connected);
                if (Boolean.TRUE.equals(connected)
                        && new File(OPLUS_APS_GRAPH_PROBE_MARKER).isFile()) {
                    boolean graphMarkerConsumed = new File(
                            OPLUS_APS_GRAPH_PROBE_MARKER).delete();
                    log("[OplusAPSProbe] graph marker consumed="
                            + graphMarkerConsumed);
                    probeOplusApsHighPixelGraph(fullAps, loader,
                            application, config);
                }
            } catch (Throwable throwable) {
                OPLUS_APS_CONNECT_PROBED.set(false);
                log("[OplusAPSProbe] native connection failed: "
                        + throwable);
                XposedBridge.log(throwable);
            } finally {
                if (fullAps != null) {
                    try {
                        XposedHelpers.callMethod(fullAps, "disconnect");
                        log("[OplusAPSProbe] disconnected cleanly");
                    } catch (Throwable throwable) {
                        log("[OplusAPSProbe] disconnect warning: "
                                + throwable);
                    }
                }
                thread.quitSafely();
            }
        });
    }

    /** Initialize and immediately release the stock OnePlus aiHighPixel@0
     * capture graph.  No ImageReader, camera request, or input frame is
     * involved in this probe. */
    private static void probeOplusApsHighPixelGraph(Object fullAps,
            ClassLoader loader, Context application, Class<?> config)
            throws Throwable {
        CameraManager cameraManager = (CameraManager) application
                .getSystemService(Context.CAMERA_SERVICE);
        CameraCharacteristics characteristics = cameraManager
                .getCameraCharacteristics("0");
        Class<?> wrapperClass = Class.forName(
                "com.oplus.ocs.camera.producer.info."
                        + "CameraCharacteristicsWrapper", true, loader);
        Object wrapper = XposedHelpers.newInstance(wrapperClass,
                application, cameraManager, "0");
        String[] vendorTags = (String[]) XposedHelpers.callMethod(
                wrapper, "getVendorTagAndId");

        Object captureConfig = XposedHelpers.callStaticMethod(
                config, "getCaptureConfig", "aiHighPixel", 0);
        if (captureConfig == null) {
            throw new IllegalStateException(
                    "aiHighPixel@0 APS capture config is null");
        }
        Object algosObject = XposedHelpers.getObjectField(
                captureConfig, "mAlgos");
        if (!(algosObject instanceof Set)) {
            throw new IllegalStateException(
                    "aiHighPixel@0 algorithm set is unavailable: "
                            + algosObject);
        }
        @SuppressWarnings("unchecked")
        Set<String> algorithms = (Set<String>) algosObject;
        if (algorithms.isEmpty()) {
            throw new IllegalStateException(
                    "aiHighPixel@0 algorithm set is empty");
        }

        Class<?> initClass = Class.forName(
                "com.oplus.ocs.camera.consumer.apsAdapter.adapter."
                        + "ApsInitParameter", true, loader);
        Object init = initClass.getConstructor().newInstance();
        XposedHelpers.setIntField(init, "mApsModule", 2);
        XposedHelpers.setObjectField(init, "mInitAlgo",
                algorithms.toArray(new String[0]));
        XposedHelpers.setObjectField(init, "mMetadata", characteristics);
        XposedHelpers.setObjectField(init, "mVendorTags", vendorTags);
        XposedHelpers.setObjectField(init, "mParameters", new String[]{
                "capture_mode", "aiHighPixel",
                "camera_id", "0",
                "logic_camera_id", "0",
                "is_from_system_camera", "true",
                "is_from_camera_extension", "false"
        });
        log("[OplusAPSProbe] aiHighPixel@0 init begin algorithms="
                + algorithms + " vendorTagPairs="
                + (vendorTags == null ? -1 : vendorTags.length / 2));
        boolean initialized = false;
        try {
            XposedHelpers.callMethod(fullAps, "initAlgo", init);
            initialized = true;
            SystemClock.sleep(600L);
            log("[OplusAPSProbe] aiHighPixel@0 init completed");
        } finally {
            if (initialized) {
                XposedHelpers.callMethod(fullAps, "unInitAlgo", 2);
                log("[OplusAPSProbe] aiHighPixel@0 uninit completed");
            }
        }
    }

    private static Object defaultReflectionValue(Class<?> type) {
        if (!type.isPrimitive() || type == Void.TYPE) {
            return null;
        }
        if (type == Boolean.TYPE) {
            return false;
        }
        if (type == Character.TYPE) {
            return '\0';
        }
        if (type == Byte.TYPE) {
            return (byte) 0;
        }
        if (type == Short.TYPE) {
            return (short) 0;
        }
        if (type == Integer.TYPE) {
            return 0;
        }
        if (type == Long.TYPE) {
            return 0L;
        }
        if (type == Float.TYPE) {
            return 0.0f;
        }
        if (type == Double.TYPE) {
            return 0.0d;
        }
        return null;
    }

    /**
     * Sidecar implementation of ColorOS' ordinary-photo APS contract.  The
     * Xiaomi's JPEG request is submitted first and remains byte-for-byte
     * untouched.  A separate burst reproduces ColorOS' four-target common
     * graph: main RAW10, 720p RAW_SENSOR control stream, DOL RAW10 and 1440p
     * YUV control stream.  Only the two RAW10 images enter APS; the control
     * streams are drained after they let CHI complete each request.
     */
    private static void hookOplusCommonPhotoBridge(ClassLoader loader) {
        if (!COMMON_APS_PROOF_ENABLED) {
            log("[CommonAPS] Xiaomi sidecar disabled during exact stock"
                    + " stream-map capture");
            return;
        }
        XposedHelpers.findAndHookMethod(Application.class, "attach",
                Context.class, new XC_MethodHook() {
                    @Override
                    protected void afterHookedMethod(MethodHookParam param) {
                        if (!(param.thisObject instanceof Application)) {
                            return;
                        }
                        xiaomiCameraApplication =
                                (Application) param.thisObject;
                        if (ensureCommonApsInfrastructure()) {
                            scheduleCommonApsInitialization();
                        }
                    }
                });

        Class<?> wrapper = XposedHelpers.findClass("sh.b", loader);
        XposedBridge.hookAllMethods(wrapper, "b", new XC_MethodHook() {
            @Override
            protected void beforeHookedMethod(MethodHookParam param) {
                boolean previous = commonApsPhotoSessionActive;
                commonApsPhotoSessionActive = false;
                if (commonApsDisabled || activeCameraModule != 163
                        || param.args == null || param.args.length != 5
                        || !(param.args[1] instanceof List<?>)) {
                    if (previous) {
                        abortCommonApsCapture("photo-session-left", true);
                    }
                    return;
                }
                try {
                    String cameraId = String.valueOf(
                            XposedHelpers.callMethod(param.thisObject, "c"));
                    if (!"0".equals(cameraId)
                            || !isOrdinaryPhotoSession(param.args)
                            || !ensureCommonApsInfrastructure()) {
                        if (previous) {
                            abortCommonApsCapture(
                                    "ordinary-session-reconfigured", true);
                        }
                        return;
                    }
                    List<?> outputs = (List<?>) param.args[1];
                    String sourceSignature = outputFormatSignature(outputs);
                    boolean mainAdded = appendOutputSurface(outputs,
                            commonRawMainReader.getSurface());
                    boolean dolAdded = appendOutputSurface(outputs,
                            commonRawDolReader.getSurface());
                    boolean auxYuvAdded = appendOutputSurface(outputs,
                            commonAuxYuvReader.getSurface());
                    commonApsPhotoSessionActive = true;
                    scheduleCommonApsInitialization();
                    log("[CommonAPS] rear Photo session added RAW10 main="
                            + mainAdded + " dol=" + dolAdded
                            + " previewYUV=" + auxYuvAdded
                            + " source=" + sourceSignature
                            + " finalOutputs=" + outputs.size());
                } catch (Throwable throwable) {
                    commonApsPhotoSessionActive = false;
                    log("[CommonAPS] session left unchanged after failure: "
                            + throwable);
                }
            }
        });

        Class<?> sessionImpl = XposedHelpers.findClass(
                "android.hardware.camera2.impl.CameraCaptureSessionImpl",
                loader);
        XposedBridge.hookAllMethods(sessionImpl, "capture",
                new XC_MethodHook() {
                    @Override
                    protected void afterHookedMethod(
                            MethodHookParam param) {
                        if (!commonApsPhotoSessionActive || !commonApsReady
                                || commonApsDisabled
                                || activeCameraModule != 163
                                || Boolean.TRUE.equals(
                                COMMON_APS_BURST_GUARD.get())
                                || commonRawMainReader == null
                                || commonRawDolReader == null
                                || commonAuxYuvReader == null
                                || param.args == null
                                || param.args.length < 3
                                || !(param.args[0]
                                instanceof CaptureRequest)
                                || param.getThrowable() != null) {
                            return;
                        }
                        CaptureRequest original =
                                (CaptureRequest) param.args[0];
                        Integer intent = original.get(
                                CaptureRequest.CONTROL_CAPTURE_INTENT);
                        if (!Integer.valueOf(CaptureRequest
                                .CONTROL_CAPTURE_INTENT_STILL_CAPTURE)
                                .equals(intent)) {
                            return;
                        }
                        CommonApsDecision decision =
                                resolveCommonApsDecision();
                        if (decision == null
                                || !decision.isSupportedCommon2Dol()) {
                            log("[CommonAPS] sidecar proof bypassed; no"
                                    + " supported native common/2DOL"
                                    + " decision; Xiaomi JPEG unchanged");
                            return;
                        }
                        ArrayList<CaptureRequest> burst =
                                buildCommonApsRequestSet(
                                        param.thisObject, original,
                                        decision);
                        if (burst == null
                                || burst.size() != decision.frameCount
                                || !beginCommonApsCapture(original,
                                decision)) {
                            log("[CommonAPS] sidecar proof bypassed; Xiaomi"
                                    + " JPEG was already submitted unchanged");
                            return;
                        }
                        try {
                            CameraCaptureSession.CaptureCallback callback =
                                    wrapCommonApsBurstCallback(
                                            null, null, burst);
                            COMMON_APS_BURST_GUARD.set(Boolean.TRUE);
                            Object sequence = XposedHelpers.callMethod(
                                    param.thisObject, "captureBurst", burst,
                                    callback, param.args[2]);
                            log("[CommonAPS] submitted isolated "
                                    + decision.frameCount + "-request"
                                    + " sidecar: Xiaomi JPEG unchanged,"
                                    + " four targets/request bracket="
                                    + decision.bracketMode + " ev="
                                    + decision.evListString()
                                    + " sequence=" + sequence);
                        } catch (Throwable throwable) {
                            abortCommonApsCapture(
                                    "burst-submit-failed", true);
                            log("[CommonAPS] sidecar burst failed; original"
                                    + " Xiaomi capture is unaffected: "
                                    + throwable);
                        } finally {
                            COMMON_APS_BURST_GUARD.remove();
                        }
                    }
                });
        log("[CommonAPS] ordinary rear-photo proof hooks active");
    }

    /**
     * Xiaomi receives this callback when the vendor camera provider dies but
     * its application process survives.  FullApsImpl is backed by an offline
     * binder client, so retaining it across that event guarantees DEAD_REPLY
     * on every later shot.  Invalidate only the rear APS bridge and let
     * Xiaomi's own abnormal-camera handling continue unchanged.
     */
    private static void hookRecoverableCommonApsDeath(ClassLoader loader) {
        Class<?> callback = XposedHelpers.findClass("F1.R2", loader);
        XposedBridge.hookAllMethods(callback, "a", new XC_MethodHook() {
            @Override
            protected void beforeHookedMethod(MethodHookParam param) {
                if (param.args == null || param.args.length != 2
                        || !(param.args[0] instanceof Integer)
                        || !(param.args[1] instanceof Integer)
                        || ((Integer) param.args[0]) != 0) {
                    return;
                }
                invalidateCommonApsClient("camera-provider-abnormal-"
                        + param.args[1], -1);
            }
        });
        log("[CommonAPS] recoverable camera-provider death hook active");
    }

    private static void hookFullOplusSessionHandoffProbe(
            ClassLoader loader) {
        if (!COMMON_APS_HANDOFF_PROBE_ENABLED) {
            log("[HandoffProbe] disabled");
            return;
        }
        File configureMarker = new File(
                COMMON_APS_HANDOFF_PROBE_MARKER);
        File captureMarker = new File(
                COMMON_APS_CAPTURE_PROBE_MARKER);
        final boolean captureProof = captureMarker.isFile();
        final boolean configureProof = !captureProof
                && configureMarker.isFile();
        final boolean automaticProof = captureProof || configureProof;
        File marker = captureProof ? captureMarker : configureMarker;
        if (automaticProof && !marker.delete()) {
            log("[HandoffProbe] marker could not be deleted;"
                    + " in-process one-shot guard remains active");
        }
        Class<?> camera;
        try {
            // The currently installed, already-patched camera uses y0;
            // untouched AAAOS4 uses D0 for the same MiCamera2 class.
            camera = XposedHelpers.findClass("j9.y0", loader);
        } catch (Throwable currentMappingMissing) {
            camera = XposedHelpers.findClass("j9.D0", loader);
        }
        int t2HookCount = XposedBridge.hookAllMethods(
                camera, "T2", new XC_MethodHook() {
            @Override
            protected void afterHookedMethod(MethodHookParam param) {
                if (COMMON_APS_HANDOFF_T2_OBSERVED
                        .compareAndSet(false, true)) {
                    log("[HandoffProbe] T2 observed argc="
                            + (param.args == null ? -1
                            : param.args.length)
                            + " activeModule=" + activeCameraModule
                            + " opMode="
                            + (param.args != null
                            && param.args.length > 5
                            ? param.args[5] : "?"));
                }
                if (param.getThrowable() != null
                        || param.args == null
                        || param.args.length != 9
                        || activeCameraModule != 163
                         || !(param.args[5] instanceof Integer)
                         || (((Integer) param.args[5]) != 0
                         && ((Integer) param.args[5]) != XIAOMI_OP_MODE)) {
                     return;
                 }
                 try {
                    Object wrapper = XposedHelpers.getObjectField(
                            param.thisObject, "v");
                    String cameraId = String.valueOf(
                            XposedHelpers.callMethod(wrapper, "c"));
                    if (!"0".equals(cameraId)) {
                        log("[HandoffProbe] refused non-rear camera="
                                + cameraId);
                        return;
                    }
                    Handler handler = (Handler)
                            XposedHelpers.getObjectField(
                                    param.thisObject, "s");
                     Object[] previewArgs = param.args.clone();
                     commonApsHandoffOwner = param.thisObject;
                     commonApsHandoffPreviewArgs = previewArgs;
                     // Keep the live owner/arguments even without a graph
                     // proof marker.  The one-shot shutter bridge needs the
                     // exact original T2 call to restore Xiaomi after APS.
                     if ((COMMON_APS_DAILY_SHUTTER_ENABLED
                             || new File(COMMON_APS_SHUTTER_PROBE_MARKER)
                             .isFile())
                             && COMMON_APS_SHUTTER_PREP_SCHEDULED
                             .compareAndSet(false, true)) {
                         Application application =
                                 resolveCurrentCameraApplication();
                         if (application != null) {
                             xiaomiCameraApplication = application;
                         }
                         if (!ensureCommonApsInfrastructure()) {
                             throw new IllegalStateException(
                                     "APS shutter reader infrastructure unavailable");
                         }
                         Handler apsHandler = commonApsHandler;
                         if (apsHandler == null) {
                             throw new IllegalStateException(
                                     "APS shutter worker unavailable");
                         }
                         apsHandler.post(() -> {
                             boolean ready = prepareCommonApsClient();
                             log("[ApsShutter] prewarm ready=" + ready
                                     + " owner="
                                     + (commonApsHandoffOwner != null)
                                     + " previewArgs="
                                     + (commonApsHandoffPreviewArgs == null
                                     ? -1
                                     : commonApsHandoffPreviewArgs.length));
                             synchronized (COMMON_APS_SHUTTER_LOCK) {
                                 COMMON_APS_SHUTTER_LOCK.notifyAll();
                             }
                         });
                         log("[ApsShutter] APS prewarm scheduled while Xiaomi"
                                 + " preview remains live daily="
                                 + COMMON_APS_DAILY_SHUTTER_ENABLED);
                     }
                     if (!automaticProof
                             || !COMMON_APS_HANDOFF_SCHEDULED
                             .compareAndSet(false, true)) {
                         return;
                     }
                     if (captureProof) {
                        Application application =
                                resolveCurrentCameraApplication();
                        if (application != null) {
                            xiaomiCameraApplication = application;
                        }
                        if (!ensureCommonApsInfrastructure()) {
                            throw new IllegalStateException(
                                    "APS reader infrastructure unavailable");
                        }
                        Handler apsHandler = commonApsHandler;
                        if (apsHandler == null) {
                            throw new IllegalStateException(
                                    "APS worker unavailable");
                        }
                        apsHandler.post(() -> {
                            boolean ready = prepareCommonApsClient();
                            if (!ready) {
                                log("[HandoffProbe] APS capture proof"
                                        + " stopped before session switch:"
                                        + " client init failed");
                                return;
                            }
                             handler.postDelayed(() ->
                                     startFullOplusSessionHandoffProbe(
                                             param.thisObject, previewArgs,
                                             handler, true, null), 350L);
                         });
                        log("[HandoffProbe] APS init scheduled before"
                                + " one-shot capture handoff");
                    } else {
                         handler.postDelayed(() ->
                                 startFullOplusSessionHandoffProbe(
                                         param.thisObject, previewArgs,
                                         handler, false, null), 1_800L);
                        log("[HandoffProbe] third-party 0x8001/7-output"
                                + " configure proof scheduled after stable"
                                + " Xiaomi preview");
                    }
                } catch (Throwable throwable) {
                    log("[HandoffProbe] scheduling failed without"
                            + " touching Xiaomi session: " + throwable);
                    XposedBridge.log(throwable);
                }
            }
        }).size();
        int f1HookCount = XposedBridge.hookAllMethods(
                camera, "f1", new XC_MethodHook() {
                    @Override
                    protected void beforeHookedMethod(
                            MethodHookParam param) {
                        if (COMMON_APS_HANDOFF_F1_OBSERVED
                                .compareAndSet(false, true)) {
                            log("[HandoffProbe] f1 observed argc="
                                    + (param.args == null ? -1
                                    : param.args.length)
                                    + " activeModule="
                                    + activeCameraModule
                                    + " opMode="
                                    + (param.args != null
                                    && param.args.length > 5
                                    ? param.args[5] : "?"));
                        }
                    }
                }).size();
        log("[HandoffProbe] persistent restore cache armed class="
                + camera.getName()
                + " hooks=T2/"
                + t2HookCount + " f1/" + f1HookCount
                + " autoProof=" + automaticProof);
    }

    private static void startFullOplusSessionHandoffProbe(
            Object owner, Object[] previewArgs, Handler handler,
            boolean captureProof, CaptureRequest stillSeed) {
        if (!COMMON_APS_HANDOFF_IN_FLIGHT
                .compareAndSet(false, true)) {
            failCommonApsShutter("another session handoff is already active");
            return;
        }
        COMMON_APS_HANDOFF_XIAOMI_RELEASED.set(false);
        int generation = ++commonApsHandoffGeneration;
        try {
            Object current = XposedHelpers.getObjectField(owner, "w");
            if (!(current instanceof CameraCaptureSession)) {
                throw new IllegalStateException(
                        "Xiaomi preview session is not configured");
            }
            CaptureRequest sessionParams =
                    loadEmbeddedOplusSessionParams();
            if (!ensureCommonApsInfrastructure()) {
                throw new IllegalStateException(
                        "portable OPlus reader graph unavailable");
            }
            ArrayList<OutputConfiguration> outputs =
                    buildPortableOplusOutputConfigurations();
            logConfiguredOutputs(
                    "[HandoffProbe] official third-party graph", outputs);

            // I2(0) closes only the current CameraCaptureSession; the sh.b
            // wrapper and its CameraDevice remain alive for the transient
            // ColorOS graph and the later original T2 restoration.
            COMMON_APS_HANDOFF_XIAOMI_RELEASED.set(true);
            XposedHelpers.callMethod(owner, "I2", 0);
            log("[HandoffProbe] Xiaomi session released; CameraDevice kept");

            handler.postDelayed(() -> {
                if (generation == commonApsHandoffGeneration
                        && COMMON_APS_HANDOFF_IN_FLIGHT.get()) {
                    if (captureProof) {
                        abortCommonApsCapture(
                                "handoff-watchdog-timeout", true);
                    }
                    restoreXiaomiSessionAfterHandoff(
                            generation, "watchdog-timeout");
                }
            // Keep the transient graph alive until APS has consumed the RAW
            // inputs and returned a JPEG.  A normal stock R2R/Y2Y/Y2J pass
            // takes a few seconds; the old 15 s watchdog could tear down the
            // session while native offline work was still pending.
            }, captureProof ? 30_000L : 6_000L);

            CameraCaptureSession.StateCallback callback =
                    new CameraCaptureSession.StateCallback() {
                        @Override
                        public void onConfigured(
                                CameraCaptureSession session) {
                            if (generation !=
                                    commonApsHandoffGeneration
                                    || !COMMON_APS_HANDOFF_IN_FLIGHT.get()) {
                                session.close();
                                return;
                            }
                            commonApsHandoffSession = session;
                            log("[HandoffProbe] SUCCESS third-party 0x8001"
                                    + " seven-output session configured");
                             if (captureProof) {
                                 startCommonApsHandoffCapture(session,
                                         sessionParams,
                                         stillSeed == null
                                                 ? sessionParams : stillSeed,
                                         handler,
                                         generation);
                            } else {
                                handler.postDelayed(() ->
                                        restoreXiaomiSessionAfterHandoff(
                                                generation,
                                                "configure-proof-complete"),
                                        350L);
                            }
                        }

                        @Override
                        public void onConfigureFailed(
                                CameraCaptureSession session) {
                            commonApsHandoffSession = session;
                            log("[HandoffProbe] third-party graph"
                                    + " onConfigureFailed");
                            restoreXiaomiSessionAfterHandoff(
                                    generation, "configure-failed");
                        }

                        @Override
                        public void onClosed(
                                CameraCaptureSession session) {
                            log("[HandoffProbe] transient session closed");
                        }
                    };
            Object wrapper = XposedHelpers.getObjectField(owner, "v");
            XposedHelpers.callMethod(wrapper, "b", 0x8001, outputs,
                    sessionParams, callback, handler);
            log("[HandoffProbe] third-party graph configure submitted"
                    + " params=" + sessionParams.getKeys().size()
                    + " captureProof=" + captureProof);
        } catch (Throwable throwable) {
            log("[HandoffProbe] switch failed: " + throwable);
            XposedBridge.log(throwable);
            restoreXiaomiSessionAfterHandoff(
                    generation, "switch-exception");
        }
    }

    private static Application resolveCurrentCameraApplication() {
        if (xiaomiCameraApplication != null) {
            return xiaomiCameraApplication;
        }
        try {
            Class<?> activityThread = XposedHelpers.findClass(
                    "android.app.ActivityThread", null);
            Object current = XposedHelpers.callStaticMethod(
                    activityThread, "currentApplication");
            return current instanceof Application
                    ? (Application) current : null;
        } catch (Throwable throwable) {
            log("[HandoffProbe] current Application unavailable: "
                    + throwable);
            return null;
        }
    }

    private static void startCommonApsHandoffCapture(
            CameraCaptureSession session, CaptureRequest warmupSeed,
            CaptureRequest stillSeed,
            Handler handler, int handoffGeneration) {
        try {
            if (handoffGeneration != commonApsHandoffGeneration
                    || !COMMON_APS_HANDOFF_IN_FLIGHT.get()) {
                return;
            }
             CaptureRequest preview = buildCommonApsWarmupRequest(
                     session, warmupSeed);
            AtomicBoolean transitioned = new AtomicBoolean(false);
            int[] completed = new int[]{0};
            CameraCaptureSession.CaptureCallback warmupCallback =
                    new CameraCaptureSession.CaptureCallback() {
                        @Override
                        public void onCaptureStarted(
                                CameraCaptureSession captureSession,
                                CaptureRequest request, long timestamp,
                                long frameNumber) {
                            if (completed[0] == 0) {
                                log("[CommonAPS] warmup first request"
                                        + " started frame=" + frameNumber
                                        + " sensorTs=" + timestamp);
                            }
                        }

                        @Override
                        public void onCaptureCompleted(
                                CameraCaptureSession captureSession,
                                CaptureRequest request,
                                TotalCaptureResult result) {
                            if (handoffGeneration
                                    != commonApsHandoffGeneration
                                    || !COMMON_APS_HANDOFF_IN_FLIGHT.get()
                                    || transitioned.get()) {
                                return;
                            }
                            commonApsDecisionMetadata = result;
                            commonApsDecisionMetadataNanos =
                                    SystemClock.elapsedRealtimeNanos();
                            int count = ++completed[0];
                            if (count == 1
                                    || count ==
                                    COMMON_APS_WARMUP_RESULT_COUNT) {
                                log("[CommonAPS] warmup metadata=" + count
                                        + "/"
                                        + COMMON_APS_WARMUP_RESULT_COUNT
                                        + " frame="
                                        + result.getFrameNumber()
                                        + " iso=" + result.get(
                                        CaptureResult.SENSOR_SENSITIVITY)
                                        + " exposureNs=" + result.get(
                                        CaptureResult.SENSOR_EXPOSURE_TIME)
                                        + " "
                                        + commonApsMemorySnapshot());
                            }
                            if (count
                                    < COMMON_APS_WARMUP_RESULT_COUNT
                                    || !transitioned.compareAndSet(
                                    false, true)) {
                                return;
                            }
                            handler.post(() -> {
                                if (handoffGeneration
                                        != commonApsHandoffGeneration
                                        || !COMMON_APS_HANDOFF_IN_FLIGHT
                                        .get()) {
                                    return;
                                }
                                // CameraUnit keeps its preview repeating
                                // request active and inserts the still burst
                                // ahead of it.  Stopping repeating here made
                                // the first still request lose its preview
                                // output even though both RAW paths started.
                                 submitCommonApsHandoffBurst(
                                         captureSession, stillSeed, handler,
                                         handoffGeneration);
                            });
                        }

                        @Override
                        public void onCaptureFailed(
                                CameraCaptureSession captureSession,
                                CaptureRequest request,
                                CaptureFailure failure) {
                            log("[CommonAPS] warmup request failed"
                                    + " frame=" + failure.getFrameNumber()
                                    + " reason=" + failure.getReason()
                                    + " " + commonApsMemorySnapshot());
                        }

                        @Override
                        public void onCaptureBufferLost(
                                CameraCaptureSession captureSession,
                                CaptureRequest request, Surface target,
                                long frameNumber) {
                            logCommonApsBufferLost("warmup", -1,
                                    target, frameNumber);
                            // CameraUnit waits for valid preview metadata;
                            // a disposable startup buffer is not fatal while
                            // the repeating request can still recover.
                        }
                    };
            int sequence = session.setRepeatingRequest(preview,
                    warmupCallback, handler);
            log("[HandoffProbe] APS preview warmup repeating sequence="
                    + sequence + " targets=preview resultsNeeded="
                    + COMMON_APS_WARMUP_RESULT_COUNT + " "
                    + commonApsMemorySnapshot());
            handler.postDelayed(() -> {
                if (handoffGeneration != commonApsHandoffGeneration
                        || !COMMON_APS_HANDOFF_IN_FLIGHT.get()
                        || !transitioned.compareAndSet(false, true)) {
                    return;
                }
                log("[CommonAPS] warmup timed out completed="
                        + completed[0] + " "
                        + commonApsMemorySnapshot());
                restoreXiaomiSessionAfterHandoff(handoffGeneration,
                        "warmup-timeout");
            }, COMMON_APS_WARMUP_TIMEOUT_MS);
        } catch (Throwable throwable) {
            log("[HandoffProbe] APS warmup submission failed: "
                    + throwable);
            XposedBridge.log(throwable);
            restoreXiaomiSessionAfterHandoff(handoffGeneration,
                    "warmup-submit-failed");
        }
    }

    @SuppressWarnings({"rawtypes", "unchecked"})
    private static CaptureRequest buildCommonApsWarmupRequest(
            CameraCaptureSession session, CaptureRequest seed)
            throws Throwable {
        Object deviceImpl = XposedHelpers.getObjectField(
                session, "mDeviceImpl");
        CaptureRequest.Builder builder = (CaptureRequest.Builder)
                XposedHelpers.callMethod(deviceImpl,
                        "createCaptureRequest",
                        android.hardware.camera2.CameraDevice
                                .TEMPLATE_PREVIEW);
        for (CaptureRequest.Key key : seed.getKeys()) {
            try {
                Object value = seed.get(key);
                if (value != null) {
                    builder.set(key, value);
                }
            } catch (Throwable ignored) {
                // Session-only or synthetic keys are not writable.
            }
        }
        builder.setTag(seed.getTag());
        builder.set(CaptureRequest.CONTROL_CAPTURE_INTENT,
                CaptureRequest.CONTROL_CAPTURE_INTENT_PREVIEW);
        builder.set(OPLUS_SDK_CAMERA_PACKAGE, new byte[]{1});
        builder.set(OPLUS_IS_FROM_MAIN_MENU, Boolean.FALSE);
        builder.addTarget(commonAuxYuvReader.getSurface());
        return builder.build();
    }

    private static void submitCommonApsHandoffBurst(
            CameraCaptureSession session, CaptureRequest seed,
            Handler handler, int handoffGeneration) {
        try {
            if (handoffGeneration != commonApsHandoffGeneration
                    || !COMMON_APS_HANDOFF_IN_FLIGHT.get()) {
                return;
            }
            // Exact successful stock capture observed again in the same
            // scene at 19:03:24: five requests, Bracket25, the fifth EV at
            // -4.0, super-night/turbo-raw scene 4, feature 50 and AIS 7.
            // This decision also selects sensor-mode-list 3/3 below.  Keep
            // the proof coherent as one stock decision; mixing the older
            // 1/1 + 2/2 branch with current scene metadata lost the fifth
            // control output and left TurboHDR with only nine inputs.
            int[] stockHdrEv = new int[20];
            stockHdrEv[4] = -40;
            CommonApsDecision decision = new CommonApsDecision(
                    COMMON_APS_HDR_FRAME_COUNT, 25,
                    4, 4, 50, 7, stockHdrEv,
                    "stock-success-1903-r2r");
            if (!beginCommonApsCapture(seed, decision)) {
                throw new IllegalStateException(
                        "APS start/beforeCapture refused");
            }
            ArrayList<CaptureRequest> requests =
                    buildCommonApsRequestSet(session, seed, decision);
            if (requests == null || requests.size()
                    != decision.frameCount) {
                throw new IllegalStateException(
                        "APS request set unavailable");
            }
            CameraCaptureSession.CaptureCallback callback =
                    wrapCommonApsBurstCallback(null, seed, requests);
            int sequence = session.captureBurst(requests, callback,
                    handler);
            log("[HandoffProbe] APS " + requests.size()
                    + "-request/2DOL burst submitted after warmup"
                    + " sequence=" + sequence + " bracket="
                    + decision.bracketMode + " ev="
                    + decision.evListString()
                    + " targets=main+preview+DOL+capture-meta "
                    + commonApsMemorySnapshot());
        } catch (Throwable throwable) {
            log("[HandoffProbe] APS capture submission failed: "
                    + throwable);
            XposedBridge.log(throwable);
            abortCommonApsCapture("handoff-capture-submit-failed",
                    true);
            restoreXiaomiSessionAfterHandoff(handoffGeneration,
                    "capture-submit-failed");
        }
    }

    private static void submitCommonApsPersistentBurst(
            CameraCaptureSession session, CaptureRequest seed,
            Handler handler) {
        try {
            if (!commonApsUnifiedSessionActive
                    || session == null
                    || session != commonApsUnifiedSession) {
                throw new IllegalStateException(
                        "persistent APS session is no longer current");
            }
            CommonApsDecision decision =
                    persistentCommonApsDecision(seed);
            if (!beginCommonApsCapture(seed, decision)) {
                throw new IllegalStateException(
                        "APS start/beforeCapture refused");
            }
            ArrayList<CaptureRequest> requests =
                    buildCommonApsRequestSet(session, seed, decision);
            if (requests == null
                    || requests.size() != decision.frameCount) {
                throw new IllegalStateException(
                        "persistent APS request set unavailable");
            }
            CameraCaptureSession.CaptureCallback callback =
                    wrapCommonApsBurstCallback(null, seed, requests);
            int sequence = session.captureBurst(requests, callback, handler);
            log("[UnifiedAPS] APS " + requests.size()
                    + "-request APS burst inserted without session switch"
                    + " sequence=" + sequence + " bracket="
                    + decision.bracketMode + " ev="
                    + decision.evListString()
                    + " topology=" + (decision.isTeleSingleRaw()
                    ? "tele-main+preview+capture-meta"
                    : decision.isUltraWideSingleRaw()
                    ? "UW-main+preview+capture-meta"
                    : "main+preview+DOL+capture-meta") + " "
                    + commonApsMemorySnapshot());
        } catch (Throwable throwable) {
            abortCommonApsCapture(
                    "persistent-capture-submit-failed", true);
            failCommonApsShutter(
                    "persistent capture submit failed: " + throwable);
            log("[UnifiedAPS] persistent APS submission failed; original"
                    + " Xiaomi JPEG retained: " + throwable);
            XposedBridge.log(throwable);
        }
    }

    /**
     * Submit the native APS burst as the shutter operation itself.  The old
     * path first sent a two-target Xiaomi trigger and waited for its completed
     * callback before queuing APS.  On this device that made the first useful
     * APS exposure roughly one second later than the user's tap and produced
     * two visible lens/preview transitions.  Forwarding the first APS request
     * through Xiaomi's original callback gives both stacks one sensor
     * timestamp while the remaining requests are private merge inputs.
     */
    private static boolean trySubmitUnifiedApsBurstAtShutter(
            XC_MethodHook.MethodHookParam param,
            CaptureRequest original) {
        if (!commonApsUnifiedSessionActive
                || param == null
                || param.thisObject != commonApsUnifiedSession
                || commonApsUnifiedXiaomiJpegSurface == null
                || original == null
                || param.args == null || param.args.length < 3
                || !(param.thisObject instanceof CameraCaptureSession)
                || param.args[1] != null
                && !(param.args[1]
                instanceof CameraCaptureSession.CaptureCallback)
                || param.args[2] != null
                && !(param.args[2] instanceof Handler)) {
            return false;
        }
        Integer intent = original.get(CaptureRequest.CONTROL_CAPTURE_INTENT);
        if (!Integer.valueOf(CaptureRequest
                .CONTROL_CAPTURE_INTENT_STILL_CAPTURE).equals(intent)
                || (!captureTargetsSurface(original,
                commonApsUnifiedXiaomiJpegSurface)
                && (commonApsUnifiedXiaomiSecondaryJpegSurface == null
                || !captureTargetsSurface(original,
                commonApsUnifiedXiaomiSecondaryJpegSurface)))) {
            return false;
        }
        Handler callbackHandler = param.args[2] instanceof Handler
                ? (Handler) param.args[2] : commonApsHandler;
        if (!commonApsReady || commonApsDisabled
                || commonApsClient == null || callbackHandler == null) {
            log("[UnifiedAPS] direct shutter not ready; retaining trigger"
                    + " route ready=" + commonApsReady
                    + " disabled=" + commonApsDisabled
                    + " client=" + (commonApsClient != null)
                    + " handler=" + (callbackHandler != null));
            return false;
        }
        synchronized (COMMON_APS_SHUTTER_LOCK) {
            if (COMMON_APS_SHUTTER_ARMED.get()
                    || COMMON_APS_SHUTTER_HANDOFF_STARTED.get()
                    || commonApsCaptureInFlight) {
                log("[UnifiedAPS] direct shutter refused; capture active");
                return false;
            }
        }
        try {
            CommonApsDecision decision =
                    persistentCommonApsDecision(original);
            if (!beginCommonApsCapture(original, decision)) {
                throw new IllegalStateException(
                        "APS start/beforeCapture refused");
            }
            ArrayList<CaptureRequest> requests =
                    buildCommonApsRequestSet(
                            param.thisObject, original, decision);
            if (requests == null
                    || requests.size() != decision.frameCount
                    || requests.isEmpty()) {
                throw new IllegalStateException(
                        "direct APS request set unavailable");
            }
            synchronized (COMMON_APS_SHUTTER_LOCK) {
                commonApsShutterTimestamp = -1L;
                commonApsShutterRequest = original;
                commonApsShutterJpeg = null;
                commonApsShutterFailure = null;
                commonApsShutterRhSeen = false;
                COMMON_APS_SHUTTER_ARMED.set(true);
                COMMON_APS_SHUTTER_HANDOFF_STARTED.set(true);
            }
            CameraCaptureSession.CaptureCallback originalCallback =
                    (CameraCaptureSession.CaptureCallback) param.args[1];
            java.util.concurrent.atomic.AtomicInteger clientSequence =
                    new java.util.concurrent.atomic.AtomicInteger(-1);
            CameraCaptureSession.CaptureCallback callback =
                    wrapCommonApsBurstCallback(originalCallback,
                            requests.get(0), requests, clientSequence, true);
            int sequence = ((CameraCaptureSession) param.thisObject)
                    .captureBurst(requests, callback, callbackHandler);
            clientSequence.set(sequence);
            param.setResult(sequence);
            log("[UnifiedAPS] DIRECT shutter submitted APS "
                    + requests.size() + "-request burst sequence="
                    + sequence + " decision=" + decision.source
                    + "; first request owns Xiaomi callback");
            return true;
        } catch (Throwable throwable) {
            abortCommonApsCapture("direct-shutter-submit-failed", true);
            clearCommonApsShutterState();
            log("[UnifiedAPS] direct shutter failed before submission;"
                    + " retaining trigger route: " + throwable);
            XposedBridge.log(throwable);
            return false;
        }
    }

    private static CommonApsDecision persistentCommonApsDecision(
            CaptureRequest seed) {
        if (commonApsUnifiedPortraitSession) {
            int[] portraitEv = new int[20];
            portraitEv[4] = -36;
            portraitEv[5] = -18;
            return new CommonApsDecision(
                    PORTRAIT_APS_FRAME_COUNT, 25,
                    4, 4, 48, 0, portraitEv,
                    "stock-3x-portrait-dual-raw");
        }
        Float zoom = seed == null ? null
                : seed.get(CaptureRequest.CONTROL_ZOOM_RATIO);
        if (zoom != null && Float.isFinite(zoom) && zoom >= 3.0f) {
            // Exact OnePlus 13 3x common-photo decision captured from the
            // stock ColorOS camera.  CameraUnit routes its single RAW stream
            // through physical tele while APS receives role/physical 3/3.
            int[] teleEv = new int[20];
            teleEv[3] = -38;
            teleEv[4] = -19;
            return new CommonApsDecision(
                    COMMON_APS_ULTRAWIDE_FRAME_COUNT, 28,
                    3, 3, 48, 0, teleEv,
                    "persistent-stock-3x-tele-single-raw", true);
        }
        if (zoom != null && Float.isFinite(zoom) && zoom < 1.0f) {
            // Exact native 0.6x fallback observed on this OnePlus 13.  Once
            // previewDecision is fed the normalized UW metadata it may replace
            // this scene-dependent list; until then this is a coherent stock
            // eight-frame decision, not a hybrid with the 1x 2DOL branch.
            int[] ultraWideEv = new int[20];
            ultraWideEv[3] = -38;
            ultraWideEv[4] = -19;
            return new CommonApsDecision(
                    COMMON_APS_ULTRAWIDE_FRAME_COUNT, 28,
                    3, 3, 48, 0, ultraWideEv,
                    "persistent-stock-0.6-single-raw");
        }
        int[] stockHdrEv = new int[20];
        stockHdrEv[4] = -40;
        return new CommonApsDecision(
                COMMON_APS_HDR_FRAME_COUNT, 25,
                4, 4, 50, 7, stockHdrEv,
                "persistent-stock-r2r");
    }

    private static void restoreXiaomiSessionAfterHandoff(
            int generation, String reason) {
        if (generation != commonApsHandoffGeneration
                || !COMMON_APS_HANDOFF_IN_FLIGHT
                .compareAndSet(true, false)) {
            return;
        }
        if (COMMON_APS_SHUTTER_HANDOFF_STARTED.get()
                && commonApsShutterJpeg == null) {
            failCommonApsShutter("handoff-ended-before-jpeg: " + reason);
        }
        commonApsHandoffGeneration++;
        CameraCaptureSession transientSession = commonApsHandoffSession;
        commonApsHandoffSession = null;
        if (transientSession != null) {
            try {
                transientSession.stopRepeating();
            } catch (Throwable ignored) {
                // The configure-only proof does not start repeating.
            }
            try {
                transientSession.close();
            } catch (Throwable ignored) {
                // Continue into the original Xiaomi restoration.
            }
        }
        Object owner = commonApsHandoffOwner;
        Object[] previewArgs = commonApsHandoffPreviewArgs;
        boolean xiaomiWasReleased =
                COMMON_APS_HANDOFF_XIAOMI_RELEASED.getAndSet(false);
        if (!xiaomiWasReleased) {
            log("[HandoffProbe] switch stopped before Xiaomi release;"
                    + " no restore needed reason=" + reason);
            return;
        }
        Runnable restore = () -> {
            try {
                if (owner == null || previewArgs == null
                        || previewArgs.length != 9) {
                    throw new IllegalStateException(
                            "original Xiaomi T2 state unavailable");
                }
                int staleOutputs = clearXiaomiOutputConfigurationState(
                        owner);
                log("[HandoffProbe] cleared " + staleOutputs
                        + " stale Xiaomi OutputConfigurations before T2");
                XposedHelpers.callMethod(owner, "T2", previewArgs);
                log("[HandoffProbe] original Xiaomi T2 restore"
                        + " submitted reason=" + reason);
            } catch (Throwable throwable) {
                log("[HandoffProbe] Xiaomi restore failed reason="
                        + reason + " error=" + throwable);
                XposedBridge.log(throwable);
            }
        };
        if (!scheduleOnXiaomiCameraSetup(restore)) {
            log("[HandoffProbe] CRITICAL restore was not scheduled;"
                    + " CameraSetup scheduler unavailable reason="
                    + reason);
        }
    }

    private static void restoreActiveHandoff(String reason) {
        if (!COMMON_APS_HANDOFF_IN_FLIGHT.get()) {
            return;
        }
        restoreXiaomiSessionAfterHandoff(
                commonApsHandoffGeneration, reason);
    }

    private static void armCommonApsShutter(
            CaptureRequest request, long sensorTimestamp) {
        File marker = new File(COMMON_APS_SHUTTER_PROBE_MARKER);
        boolean markerPresent = marker.isFile();
        boolean unifiedSession = commonApsUnifiedSessionActive
                && commonApsUnifiedSession != null;
        int routeModule = unifiedSession
                ? commonApsUnifiedCameraModule : activeCameraModule;
        if ((!COMMON_APS_DAILY_SHUTTER_ENABLED && !markerPresent
                && !unifiedSession)
                || (unifiedSession
                ? !(isRearClarityModule(routeModule)
                || (commonApsUnifiedPortraitSession
                && routeModule == 171))
                : routeModule != 163)
                || activeCameraId != 0 || request == null
                || sensorTimestamp <= 0L) {
            return;
        }
        if (!commonApsReady || commonApsDisabled
                || commonApsClient == null
                || (!unifiedSession
                && (commonApsHandoffOwner == null
                || commonApsHandoffPreviewArgs == null
                || commonApsHandoffPreviewArgs.length != 9))
                || commonApsHandler == null) {
            log("[ApsShutter] marker retained; prewarm/state not ready"
                    + " ready=" + commonApsReady
                    + " disabled=" + commonApsDisabled
                    + " client=" + (commonApsClient != null)
                    + " owner=" + (commonApsHandoffOwner != null)
                    + " args=" + (commonApsHandoffPreviewArgs == null
                    ? -1 : commonApsHandoffPreviewArgs.length)
                    + " worker=" + (commonApsHandler != null)
                    + " unified=" + unifiedSession);
            return;
        }
        synchronized (COMMON_APS_SHUTTER_LOCK) {
            if (COMMON_APS_SHUTTER_ARMED.get()
                    || COMMON_APS_SHUTTER_HANDOFF_STARTED.get()
                    || COMMON_APS_HANDOFF_IN_FLIGHT.get()
                    || commonApsCaptureInFlight) {
                log("[ApsShutter] marker retained; another capture is active");
                return;
            }
            if (markerPresent && !marker.delete()) {
                log("[ApsShutter] marker delete failed; atomic one-shot guard"
                        + " will still prevent duplicate handoff");
            }
            commonApsShutterTimestamp = sensorTimestamp;
            commonApsShutterRequest = request;
            commonApsShutterJpeg = null;
            commonApsShutterFailure = null;
            commonApsShutterRhSeen = false;
            COMMON_APS_SHUTTER_HANDOFF_STARTED.set(false);
            COMMON_APS_SHUTTER_ARMED.set(true);
        }
        log("[ApsShutter] next Xiaomi Rh.r armed sensorTs="
                + sensorTimestamp + " orientation="
                + readRequest(request, CaptureRequest.JPEG_ORIENTATION)
                + " jpegQ="
                + readRequest(request, CaptureRequest.JPEG_QUALITY)
                + " module=" + routeModule
                + " route=" + (unifiedSession
                ? "persistent-session" : "handoff"));
    }

    private static void startCommonApsShutterAfterXiaomiResult(
            CaptureRequest request, TotalCaptureResult result) {
        if (!COMMON_APS_SHUTTER_ARMED.get() || request == null
                || result == null) {
            return;
        }
        Long resultTimestamp = safeResultValue(
                result, CaptureResult.SENSOR_TIMESTAMP);
        if (resultTimestamp == null || resultTimestamp <= 0L
                || resultTimestamp != commonApsShutterTimestamp) {
            return;
        }
        synchronized (COMMON_APS_SHUTTER_LOCK) {
            if (commonApsShutterRhSeen) {
                commonApsShutterFailure =
                        "Xiaomi JPEG arrived before capture-complete handoff";
                COMMON_APS_SHUTTER_LOCK.notifyAll();
                return;
            }
            commonApsShutterRequest = request;
            if (!COMMON_APS_SHUTTER_HANDOFF_STARTED
                    .compareAndSet(false, true)) {
                return;
            }
        }
        Object owner = commonApsHandoffOwner;
        Object[] previewArgs = commonApsHandoffPreviewArgs;
        Handler apsHandler = commonApsHandler;
        CameraCaptureSession unifiedSession = commonApsUnifiedSession;
        boolean persistent = commonApsUnifiedSessionActive
                && unifiedSession != null;
        if ((!persistent && (owner == null || previewArgs == null
                || previewArgs.length != 9)) || apsHandler == null
                || !commonApsReady) {
            failCommonApsShutter("handoff state disappeared after capture");
            return;
        }
        if (persistent) {
            log("[ApsShutter] Xiaomi capture complete; submitting exact"
                    + " APS burst inside persistent 10-output"
                    + " session sensorTs=" + resultTimestamp
                    + " callbackThread=" + Thread.currentThread().getName()
                    + " apsThread="
                    + apsHandler.getLooper().getThread().getName());
            submitCommonApsPersistentBurst(
                    unifiedSession, request, apsHandler);
            return;
        }
        log("[ApsShutter] Xiaomi capture complete; switching to exact"
                + " nine-output APS graph sensorTs=" + resultTimestamp
                + " callbackThread=" + Thread.currentThread().getName()
                + " apsThread=" + apsHandler.getLooper().getThread().getName());
        // This hook runs on Xiaomi's camera handler.  Release/configure now,
        // before returning to a possible JPEG ImageReader callback.  All APS
        // state/capture callbacks use the independent OS4CommonAPS looper, so
        // Rh.r can wait without starving the transient session.
        startFullOplusSessionHandoffProbe(owner, previewArgs,
                apsHandler, true, request);
    }

    private static void failCommonApsShutter(String reason) {
        if (!COMMON_APS_SHUTTER_ARMED.get()
                && !COMMON_APS_SHUTTER_HANDOFF_STARTED.get()) {
            return;
        }
        boolean changed = false;
        synchronized (COMMON_APS_SHUTTER_LOCK) {
            if (commonApsShutterJpeg == null
                    && commonApsShutterFailure == null) {
                commonApsShutterFailure = reason;
                changed = true;
            }
            COMMON_APS_SHUTTER_LOCK.notifyAll();
        }
        if (changed) {
            log("[ApsShutter] fail-open to original Xiaomi JPEG: " + reason);
        }
    }

    private static void clearCommonApsShutterState() {
        synchronized (COMMON_APS_SHUTTER_LOCK) {
            commonApsShutterTimestamp = -1L;
            commonApsShutterRequest = null;
            commonApsShutterJpeg = null;
            commonApsShutterFailure = null;
            commonApsShutterRhSeen = false;
            COMMON_APS_SHUTTER_HANDOFF_STARTED.set(false);
            COMMON_APS_SHUTTER_ARMED.set(false);
            COMMON_APS_SHUTTER_LOCK.notifyAll();
        }
    }

    private static int clearXiaomiOutputConfigurationState(
            Object owner) throws Exception {
        Object value = null;
        try {
            value = XposedHelpers.getObjectField(owner, "p0");
        } catch (Throwable mappedNameMissing) {
            // AAAOS4 and the currently installed camera use different class
            // names.  If a future build also remaps p0, identify it by its
            // contents instead of guessing another obfuscated field name.
            Class<?> type = owner.getClass();
            while (type != null && value == null) {
                for (java.lang.reflect.Field field
                        : type.getDeclaredFields()) {
                    if (!List.class.isAssignableFrom(field.getType())) {
                        continue;
                    }
                    field.setAccessible(true);
                    Object candidate = field.get(owner);
                    if (isOutputConfigurationList(candidate)) {
                        value = candidate;
                        log("[HandoffProbe] resolved remapped Xiaomi"
                                + " output list field=" + field.getName());
                        break;
                    }
                }
                type = type.getSuperclass();
            }
        }
        if (!(value instanceof List<?>)) {
            throw new NoSuchFieldException(
                    "MiCamera2 OutputConfiguration list");
        }
        List<?> outputs = (List<?>) value;
        if (!outputs.isEmpty() && !isOutputConfigurationList(outputs)) {
            throw new IllegalStateException(
                    "MiCamera2 p0 is not an OutputConfiguration list");
        }
        int count = outputs.size();
        outputs.clear();
        return count;
    }

    private static boolean isOutputConfigurationList(Object value) {
        if (!(value instanceof List<?>)) {
            return false;
        }
        List<?> list = (List<?>) value;
        if (list.isEmpty()) {
            return false;
        }
        for (Object element : list) {
            if (!(element instanceof OutputConfiguration)) {
                return false;
            }
        }
        return true;
    }

    private static boolean scheduleOnXiaomiCameraSetup(Runnable task) {
        try {
            ClassLoader loader = cameraAppClassLoader;
            if (loader == null) {
                throw new IllegalStateException(
                        "camera app ClassLoader unavailable");
            }
            Class<?> schedulers = XposedHelpers.findClass(
                    "com.xiaomi.camera.rx.CameraSchedulers", loader);
            Object scheduler = XposedHelpers.getStaticObjectField(
                    schedulers, "sCameraSetupScheduler");
            Class<?> extensions = XposedHelpers.findClass("Ar.d", loader);
            java.lang.reflect.Method submit = null;
            for (java.lang.reflect.Method candidate
                    : extensions.getDeclaredMethods()) {
                Class<?>[] types = candidate.getParameterTypes();
                if (java.lang.reflect.Modifier.isStatic(
                        candidate.getModifiers())
                        && types.length == 2
                        && types[0].isInstance(scheduler)
                        && Runnable.class.isAssignableFrom(types[1])) {
                    submit = candidate;
                    break;
                }
            }
            if (submit == null) {
                throw new NoSuchMethodException(
                        "CameraSetup scheduler Runnable extension");
            }
            submit.setAccessible(true);
            submit.invoke(null, scheduler, task);
            log("[HandoffProbe] restore queued on CameraSetup via "
                    + extensions.getName() + "." + submit.getName());
            return true;
        } catch (Throwable throwable) {
            log("[HandoffProbe] CameraSetup scheduling failed: "
                    + throwable);
            XposedBridge.log(throwable);
            return false;
        }
    }

    private static ArrayList<OutputConfiguration>
            buildPortableOplusOutputConfigurations() {
        ArrayList<OutputConfiguration> outputs = new ArrayList<>(9);
        // CameraUnit writes packed per-frame vendor metadata into this
        // RAW_SENSOR gralloc buffer.  Stock shares it across the main/DOL
        // pair as ApsCaptureParam.mMetadataBuffer.
        outputs.add(new OutputConfiguration(
                commonCaptureMetaReader.getSurface()));
        outputs.add(new OutputConfiguration(
                commonAuxYuvReader.getSurface()));
        outputs.add(new OutputConfiguration(
                commonRawMainReader.getSurface()));
        outputs.add(physicalOutputConfiguration(
                commonPhysical2YuvReader, "2"));
        outputs.add(physicalOutputConfiguration(
                commonPhysical3YuvReader, "3"));
        outputs.add(physicalOutputConfiguration(
                commonPhysical4YuvReader, "4"));
        outputs.add(new OutputConfiguration(
                commonSmallYuvReader.getSurface()));
        OutputConfiguration dol = new OutputConfiguration(
                commonRawDolReader.getSurface());
        dol.setStreamUseCase(COMMON_APS_DOL_STREAM_USE_CASE);
        outputs.add(dol);
        outputs.add(new OutputConfiguration(
                commonFullsizeRawReader.getSurface()));
        return outputs;
    }

    private static ArrayList<OutputConfiguration>
            buildPortableOplusPortraitOutputConfigurations() {
        ArrayList<OutputConfiguration> outputs = new ArrayList<>(6);
        outputs.add(physicalOutputConfiguration(
                portraitCaptureMetaReader, "4"));
        outputs.add(physicalOutputConfiguration(
                portraitPreviewYuvReader, "4"));
        outputs.add(physicalOutputConfiguration(
                portraitSmallYuvReader, "2"));
        outputs.add(physicalOutputConfiguration(
                portraitMainRawReader, "4"));
        outputs.add(physicalOutputConfiguration(
                portraitAuxRawReader, "2"));
        OutputConfiguration graph = physicalOutputConfiguration(
                portraitGraphRawReader, "4");
        graph.setStreamUseCase(COMMON_APS_DOL_STREAM_USE_CASE);
        outputs.add(graph);
        return outputs;
    }

    private static OutputConfiguration physicalOutputConfiguration(
            ImageReader reader, String physicalCameraId) {
        OutputConfiguration output = new OutputConfiguration(
                reader.getSurface());
        output.setPhysicalCameraId(physicalCameraId);
        return output;
    }

    private static CaptureRequest loadEmbeddedOplusSessionParams()
            throws Exception {
        String apkPath = moduleApkPath;
        if (apkPath == null || apkPath.isEmpty()) {
            throw new IllegalStateException("module APK path unavailable");
        }
        byte[] encoded;
        try (ZipFile apk = new ZipFile(apkPath)) {
            ZipEntry entry = apk.getEntry(
                    "assets/oplus_photo_session_params.b64");
            if (entry == null) {
                throw new IllegalStateException(
                        "embedded OPlus session params missing");
            }
            try (InputStream input = apk.getInputStream(entry)) {
                encoded = readAllBytes(input, (int) entry.getSize());
            }
        }
        byte[] bytes = Base64.decode(encoded, Base64.DEFAULT);
        String digest = sha256(bytes);
        if (bytes.length != 8_840
                || !"43a8a6b4203bec262027d6615e35c80c42607208d71c5b68e4ae0bc951444416"
                .equals(digest)) {
            throw new IllegalStateException(
                    "invalid embedded session parcel bytes="
                            + bytes.length + " sha256=" + digest);
        }
        Parcel parcel = Parcel.obtain();
        try {
            parcel.unmarshall(bytes, 0, bytes.length);
            parcel.setDataPosition(0);
            CaptureRequest request =
                    CaptureRequest.CREATOR.createFromParcel(parcel);
            if (captureRequestHasTargets(request)) {
                throw new IllegalStateException(
                        "embedded session params unexpectedly has targets");
            }
            // The parcel was learned from com.oplus.camera and therefore
            // intentionally has no SDK marker.  CameraUnit's supported
            // third-party path writes these two values before configuring
            // the session.  Mutate a freshly unmarshalled request every time
            // so the embedded system-camera reference remains immutable.
            Object metadata = XposedHelpers.getObjectField(
                    request, "mLogicalCameraSettings");
            XposedHelpers.callMethod(metadata, "set",
                    OPLUS_SDK_CAMERA_PACKAGE, new byte[]{1});
            XposedHelpers.callMethod(metadata, "set",
                    OPLUS_IS_FROM_MAIN_MENU, Boolean.FALSE);
            byte[] sdkPackage = request.get(OPLUS_SDK_CAMERA_PACKAGE);
            Boolean fromMainMenu = request.get(OPLUS_IS_FROM_MAIN_MENU);
            if (sdkPackage == null || sdkPackage.length != 1
                    || sdkPackage[0] != 1
                    || !Boolean.FALSE.equals(fromMainMenu)) {
                throw new IllegalStateException(
                        "third-party session identity did not stick sdk="
                                + Arrays.toString(sdkPackage)
                                + " mainMenu=" + fromMainMenu);
            }
            log("[HandoffProbe] stock session parcel cloned as official"
                    + " third-party request"
                    + " bytes=" + bytes.length + " keys="
                    + request.getKeys().size()
                    + " sdk=" + Arrays.toString(sdkPackage)
                    + " mainMenu=" + fromMainMenu);
            return request;
        } finally {
            parcel.recycle();
        }
    }

    private static CaptureRequest loadEmbeddedOplusPortraitSessionParams()
            throws Exception {
        String apkPath = moduleApkPath;
        if (apkPath == null || apkPath.isEmpty()) {
            throw new IllegalStateException("module APK path unavailable");
        }
        byte[] encoded;
        try (ZipFile apk = new ZipFile(apkPath)) {
            ZipEntry entry = apk.getEntry(
                    "assets/oplus_portrait_3x_session_params.b64");
            if (entry == null) {
                throw new IllegalStateException(
                        "embedded OPlus portrait session params missing");
            }
            try (InputStream input = apk.getInputStream(entry)) {
                encoded = readAllBytes(input, (int) entry.getSize());
            }
        }
        byte[] bytes = Base64.decode(encoded, Base64.DEFAULT);
        String digest = sha256(bytes);
        if (bytes.length != 8_864
                || !"86c79ecd5f6091a80afb71eac67e5deade9d533ab08668b0127a0ae590e3f6c0"
                .equals(digest)) {
            throw new IllegalStateException(
                    "invalid embedded portrait session parcel bytes="
                            + bytes.length + " sha256=" + digest);
        }
        Parcel parcel = Parcel.obtain();
        try {
            parcel.unmarshall(bytes, 0, bytes.length);
            parcel.setDataPosition(0);
            CaptureRequest request =
                    CaptureRequest.CREATOR.createFromParcel(parcel);
            if (captureRequestHasTargets(request)) {
                throw new IllegalStateException(
                        "portrait session params unexpectedly has targets");
            }
            Object metadata = XposedHelpers.getObjectField(
                    request, "mLogicalCameraSettings");
            XposedHelpers.callMethod(metadata, "set",
                    OPLUS_SDK_CAMERA_PACKAGE, new byte[]{1});
            XposedHelpers.callMethod(metadata, "set",
                    OPLUS_IS_FROM_MAIN_MENU, Boolean.FALSE);
            log("[PortraitAPS] exact 3x session parcel loaded bytes="
                    + bytes.length + " keys=" + request.getKeys().size());
            return request;
        } finally {
            parcel.recycle();
        }
    }

    private static CaptureRequest loadEmbeddedOplusPortraitStillRequest()
            throws Exception {
        String apkPath = moduleApkPath;
        if (apkPath == null || apkPath.isEmpty()) {
            throw new IllegalStateException("module APK path unavailable");
        }
        byte[] encoded;
        try (ZipFile apk = new ZipFile(apkPath)) {
            ZipEntry entry = apk.getEntry(
                    "assets/oplus_portrait_3x_still_request.b64");
            if (entry == null) {
                throw new IllegalStateException(
                        "embedded OPlus portrait still request missing");
            }
            try (InputStream input = apk.getInputStream(entry)) {
                encoded = readAllBytes(input, (int) entry.getSize());
            }
        }
        byte[] bytes = Base64.decode(encoded, Base64.DEFAULT);
        String digest = sha256(bytes);
        if (bytes.length != 9_752
                || !"26868d3d4274023943cd148bbfeb4a562d91f74446246d49fc29b3faa0dc90ec"
                .equals(digest)) {
            throw new IllegalStateException(
                    "invalid embedded portrait still parcel bytes="
                            + bytes.length + " sha256=" + digest);
        }
        Parcel parcel = Parcel.obtain();
        try {
            parcel.unmarshall(bytes, 0, bytes.length);
            parcel.setDataPosition(0);
            CaptureRequest request =
                    CaptureRequest.CREATOR.createFromParcel(parcel);
            if (captureRequestHasTargets(request)
                    || request.getKeys().size() != 165) {
                throw new IllegalStateException(
                        "portrait still request contract mismatch targets="
                                + captureRequestHasTargets(request)
                                + " keys=" + request.getKeys().size());
            }
            log("[PortraitAPS] exact 3x still parcel loaded bytes="
                    + bytes.length + " keys=" + request.getKeys().size());
            return request;
        } finally {
            parcel.recycle();
        }
    }

    private static CaptureRequest loadEmbeddedOplusStillRequest()
            throws Exception {
        return loadEmbeddedOplusStillRequest(false, false);
    }

    private static CaptureRequest loadEmbeddedOplusStillRequest(
            boolean ultraWide) throws Exception {
        return loadEmbeddedOplusStillRequest(ultraWide, false);
    }

    private static CaptureRequest loadEmbeddedOplusStillRequest(
            boolean ultraWide, boolean tele) throws Exception {
        String apkPath = moduleApkPath;
        if (apkPath == null || apkPath.isEmpty()) {
            throw new IllegalStateException("module APK path unavailable");
        }
        byte[] bytes;
        try (ZipFile apk = new ZipFile(apkPath)) {
            String assetName = tele
                    ? "assets/oplus_common_3x_still_request.parcel"
                    : ultraWide
                    ? "assets/oplus_common_06_still_request.b64"
                    : "assets/oplus_common_still_request.parcel";
            ZipEntry entry = apk.getEntry(assetName);
            if (entry == null) {
                throw new IllegalStateException(
                        "embedded OPlus still request missing "
                                + assetName);
            }
            try (InputStream input = apk.getInputStream(entry)) {
                bytes = readAllBytes(input, (int) entry.getSize());
            }
            if (ultraWide) {
                bytes = Base64.decode(bytes, Base64.DEFAULT);
            }
        }
        String digest = sha256(bytes);
        int expectedLength = ultraWide ? 10_008 : 10_000;
        String expectedDigest = tele
                ? "dd55a3231cba12018da299811a7239f6fd96e745af70595eb343d7233288bbc5"
                : ultraWide
                ? "9e6e4c9bbbb042497a066e7fd0f4f4e826ce80ebc67e4c102e21e4dadf9809f3"
                : "ca61c75f5ed73b15e5f7b99159db15d1e7a27fc96a17fb0d971adf36443da8d8";
        if (bytes.length != expectedLength
                || !expectedDigest.equals(digest)) {
            throw new IllegalStateException(
                    "invalid embedded still parcel bytes="
                            + bytes.length + " sha256=" + digest);
        }
        Parcel parcel = Parcel.obtain();
        try {
            parcel.unmarshall(bytes, 0, bytes.length);
            parcel.setDataPosition(0);
            CaptureRequest request =
                    CaptureRequest.CREATOR.createFromParcel(parcel);
            if (captureRequestHasTargets(request)) {
                throw new IllegalStateException(
                        "embedded still request unexpectedly has targets");
            }
            int keyCount = request.getKeys().size();
            if (keyCount != 176) {
                throw new IllegalStateException(
                        "embedded still request key mismatch " + keyCount);
            }
            log("[CommonAPS] exact stock "
                    + (tele ? "3x tele" : ultraWide ? "0.6x" : "1x")
                    + " still request loaded bytes="
                    + bytes.length + " keys=" + keyCount
                    + " sdk=" + Arrays.toString(
                    request.get(OPLUS_SDK_CAMERA_PACKAGE))
                    + " mainMenu="
                    + request.get(OPLUS_IS_FROM_MAIN_MENU));
            return request;
        } finally {
            parcel.recycle();
        }
    }

    @SuppressWarnings({"rawtypes", "unchecked"})
    private static int[] copyCaptureRequestKeys(
            CaptureRequest source, CaptureRequest.Builder destination) {
        int copied = 0;
        int nullValues = 0;
        int rejected = 0;
        for (CaptureRequest.Key key : source.getKeys()) {
            try {
                Object value = source.get(key);
                if (value == null) {
                    nullValues++;
                    continue;
                }
                destination.set(key, value);
                copied++;
            } catch (Throwable ignored) {
                // Some synthetic/session-only keys are intentionally not
                // writable through CaptureRequest.Builder.
                rejected++;
            }
        }
        return new int[]{copied, nullValues, rejected};
    }

    @SuppressWarnings({"rawtypes", "unchecked"})
    private static void copyPortableRearControl(
            CaptureRequest source, CaptureRequest.Builder destination,
            CaptureRequest.Key key, int[] stats) {
        try {
            Object value = source.get(key);
            if (value == null) {
                stats[1]++;
                return;
            }
            destination.set(key, value);
            stats[0]++;
        } catch (Throwable ignored) {
            stats[2]++;
        }
    }

    /**
     * Carry only framework-defined, user-visible controls into the stock
     * OPlus still template. Xiaomi vendor tags remain isolated from the
     * CameraUnit contract, while zoom and Pro controls still describe the
     * photograph the user actually requested.
     */
    private static int[] copyPortableRearControls(
            CaptureRequest source, CaptureRequest.Builder destination) {
        int[] stats = new int[]{0, 0, 0};
        copyPortableRearControl(source, destination,
                CaptureRequest.JPEG_ORIENTATION, stats);
        copyPortableRearControl(source, destination,
                CaptureRequest.CONTROL_ZOOM_RATIO, stats);
        copyPortableRearControl(source, destination,
                CaptureRequest.CONTROL_MODE, stats);
        copyPortableRearControl(source, destination,
                CaptureRequest.CONTROL_AE_MODE, stats);
        copyPortableRearControl(source, destination,
                CaptureRequest.CONTROL_AE_EXPOSURE_COMPENSATION, stats);
        copyPortableRearControl(source, destination,
                CaptureRequest.CONTROL_AE_LOCK, stats);
        copyPortableRearControl(source, destination,
                CaptureRequest.CONTROL_AE_REGIONS, stats);
        copyPortableRearControl(source, destination,
                CaptureRequest.CONTROL_AE_PRECAPTURE_TRIGGER, stats);
        copyPortableRearControl(source, destination,
                CaptureRequest.CONTROL_AWB_MODE, stats);
        copyPortableRearControl(source, destination,
                CaptureRequest.CONTROL_AWB_LOCK, stats);
        copyPortableRearControl(source, destination,
                CaptureRequest.CONTROL_AF_MODE, stats);
        copyPortableRearControl(source, destination,
                CaptureRequest.CONTROL_AF_REGIONS, stats);
        copyPortableRearControl(source, destination,
                CaptureRequest.CONTROL_AF_TRIGGER, stats);
        copyPortableRearControl(source, destination,
                CaptureRequest.LENS_FOCUS_DISTANCE, stats);
        copyPortableRearControl(source, destination,
                CaptureRequest.SENSOR_EXPOSURE_TIME, stats);
        copyPortableRearControl(source, destination,
                CaptureRequest.SENSOR_SENSITIVITY, stats);
        copyPortableRearControl(source, destination,
                CaptureRequest.SENSOR_FRAME_DURATION, stats);
        copyPortableRearControl(source, destination,
                CaptureRequest.COLOR_CORRECTION_MODE, stats);
        copyPortableRearControl(source, destination,
                CaptureRequest.COLOR_CORRECTION_GAINS, stats);
        copyPortableRearControl(source, destination,
                CaptureRequest.COLOR_CORRECTION_TRANSFORM, stats);
        copyPortableRearControl(source, destination,
                CaptureRequest.FLASH_MODE, stats);
        return stats;
    }

    private static boolean ensureCommonApsInfrastructure() {
        synchronized (COMMON_APS_LOCK) {
            if (commonApsDisabled) {
                return false;
            }
            if (commonApsThread == null) {
                HandlerThread thread = new HandlerThread(
                        "OS4CommonAps");
                thread.start();
                commonApsThread = thread;
                commonApsHandler = new Handler(thread.getLooper());
            }
            if (commonRawMainReader != null
                    && commonRawDolReader != null
                    && commonCaptureMetaReader != null
                    && commonAuxYuvReader != null
                    && commonPhysical2YuvReader != null
                    && commonPhysical3YuvReader != null
                    && commonPhysical4YuvReader != null
                    && commonSmallYuvReader != null
                    && commonFullsizeRawReader != null) {
                return true;
            }
            closeCommonApsGraphReadersLocked();
            ImageReader main = null;
            ImageReader dol = null;
            ImageReader captureMeta = null;
            ImageReader auxYuv = null;
            ImageReader physical2 = null;
            ImageReader physical3 = null;
            ImageReader physical4 = null;
            ImageReader smallYuv = null;
            ImageReader fullsizeRaw = null;
            try {
                main = ImageReader.newInstance(
                        4096, 3072, ImageFormat.RAW10, 32);
                dol = ImageReader.newInstance(
                        4096, 3072, ImageFormat.RAW10, 32);
                captureMeta = ImageReader.newInstance(
                        1280, 720, ImageFormat.RAW_SENSOR, 32, 64L);
                auxYuv = ImageReader.newInstance(
                        1920, 1440, ImageFormat.YUV_420_888, 35, 259L);
                physical2 = ImageReader.newInstance(
                        4096, 3072, ImageFormat.YUV_420_888, 32, 3L);
                physical3 = ImageReader.newInstance(
                        4096, 3072, ImageFormat.YUV_420_888, 32, 3L);
                physical4 = ImageReader.newInstance(
                        4096, 3072, ImageFormat.YUV_420_888, 32, 3L);
                smallYuv = ImageReader.newInstance(
                        320, 240, ImageFormat.YUV_420_888, 35, 259L);
                fullsizeRaw = ImageReader.newInstance(
                        8192, 6144, ImageFormat.RAW10, 32, 3L);
                main.setOnImageAvailableListener(
                        reader -> onCommonRawAvailable(reader, false),
                        commonApsHandler);
                dol.setOnImageAvailableListener(
                        reader -> onCommonRawAvailable(reader, true),
                        commonApsHandler);
                captureMeta.setOnImageAvailableListener(
                        HookEntry::onCommonCaptureMetaAvailable,
                        commonApsHandler);
                auxYuv.setOnImageAvailableListener(
                        HookEntry::drainCommonPreviewReader,
                        commonApsHandler);
                physical2.setOnImageAvailableListener(
                        reader -> drainCommonStaticReader(
                                reader, "physical2-yuv"),
                        commonApsHandler);
                physical3.setOnImageAvailableListener(
                        reader -> drainCommonStaticReader(
                                reader, "physical3-yuv"),
                        commonApsHandler);
                physical4.setOnImageAvailableListener(
                        reader -> drainCommonStaticReader(
                                reader, "physical4-yuv"),
                        commonApsHandler);
                smallYuv.setOnImageAvailableListener(
                        reader -> drainCommonStaticReader(
                                reader, "small-yuv"),
                        commonApsHandler);
                fullsizeRaw.setOnImageAvailableListener(
                        reader -> drainCommonStaticReader(
                                reader, "fullsize-raw10"),
                        commonApsHandler);
                commonRawMainReader = main;
                commonRawDolReader = dol;
                commonCaptureMetaReader = captureMeta;
                commonAuxYuvReader = auxYuv;
                commonPhysical2YuvReader = physical2;
                commonPhysical3YuvReader = physical3;
                commonPhysical4YuvReader = physical4;
                commonSmallYuvReader = smallYuv;
                commonFullsizeRawReader = fullsizeRaw;
                log("[CommonAPS] stock-order nine-reader graph"
                        + " ready"
                        + " main=output2 RAW10/useCase0"
                        + " dol=output7 RAW10/useCase"
                        + COMMON_APS_DOL_STREAM_USE_CASE
                        + " captureMeta=1280x720 RAW_SENSOR/usage64"
                        + " preview=1920x1440 YUV"
                        + " physical=2/3/4 4096x3072 YUV"
                        + " small=320x240 YUV"
                        + " fullsize=output8 8192x6144 RAW10/useCase0");
                return true;
            } catch (Throwable throwable) {
                closeReaderQuietly(main);
                closeReaderQuietly(dol);
                closeReaderQuietly(captureMeta);
                closeReaderQuietly(auxYuv);
                closeReaderQuietly(physical2);
                closeReaderQuietly(physical3);
                closeReaderQuietly(physical4);
                closeReaderQuietly(smallYuv);
                closeReaderQuietly(fullsizeRaw);
                commonApsDisabled = true;
                log("[CommonAPS] nine-reader creation failed; bridge"
                        + " disabled for this process: " + throwable);
                return false;
            }
        }
    }

    /**
     * ColorOS portrait is not the common-SAT graph with a different mode
     * number.  It has its own six-stream ABI: metadata and preview from
     * physical 4, a small control stream from physical 2, paired RAW10 from
     * physical 4/2, and a final graph-only RAW10 stream-use-case surface.
     */
    private static boolean ensurePortraitApsInfrastructure() {
        synchronized (COMMON_APS_LOCK) {
            if (commonApsDisabled) {
                return false;
            }
            if (commonApsThread == null) {
                HandlerThread thread = new HandlerThread(
                        "OS4CommonAps");
                thread.start();
                commonApsThread = thread;
                commonApsHandler = new Handler(thread.getLooper());
            }
            if (portraitCaptureMetaReader != null
                    && portraitPreviewYuvReader != null
                    && portraitSmallYuvReader != null
                    && portraitMainRawReader != null
                    && portraitAuxRawReader != null
                    && portraitGraphRawReader != null) {
                return true;
            }
            closePortraitApsGraphReadersLocked();
            ImageReader metadata = null;
            ImageReader preview = null;
            ImageReader small = null;
            ImageReader main = null;
            ImageReader auxiliary = null;
            ImageReader graphOnly = null;
            try {
                metadata = ImageReader.newInstance(
                        1920, 1440, ImageFormat.RAW_SENSOR, 32, 64L);
                preview = ImageReader.newInstance(
                        1280, 960, ImageFormat.YUV_420_888, 35, 259L);
                small = ImageReader.newInstance(
                        320, 240, ImageFormat.YUV_420_888, 35, 259L);
                main = ImageReader.newInstance(
                        4096, 3072, ImageFormat.RAW10, 32, 3L);
                auxiliary = ImageReader.newInstance(
                        1920, 1440, ImageFormat.RAW10, 32, 3L);
                graphOnly = ImageReader.newInstance(
                        4096, 3072, ImageFormat.RAW10, 32, 3L);
                metadata.setOnImageAvailableListener(
                        HookEntry::onCommonCaptureMetaAvailable,
                        commonApsHandler);
                preview.setOnImageAvailableListener(
                        HookEntry::drainCommonPreviewReader,
                        commonApsHandler);
                small.setOnImageAvailableListener(
                        reader -> drainCommonStaticReader(
                                reader, "portrait-physical2-small-yuv"),
                        commonApsHandler);
                main.setOnImageAvailableListener(
                        reader -> onCommonRawAvailable(reader, false),
                        commonApsHandler);
                auxiliary.setOnImageAvailableListener(
                        reader -> onCommonRawAvailable(reader, true),
                        commonApsHandler);
                graphOnly.setOnImageAvailableListener(
                        reader -> drainCommonStaticReader(
                                reader, "portrait-graph-raw10"),
                        commonApsHandler);
                portraitCaptureMetaReader = metadata;
                portraitPreviewYuvReader = preview;
                portraitSmallYuvReader = small;
                portraitMainRawReader = main;
                portraitAuxRawReader = auxiliary;
                portraitGraphRawReader = graphOnly;
                log("[PortraitAPS] exact six-reader graph ready"
                        + " metadata=1920x1440 RAW_SENSOR physical4"
                        + " preview=1280x960 YUV physical4"
                        + " control=320x240 YUV physical2"
                        + " main=4096x3072 RAW10 physical4"
                        + " aux=1920x1440 RAW10 physical2"
                        + " graph=4096x3072 RAW10 physical4/useCase"
                        + COMMON_APS_DOL_STREAM_USE_CASE);
                return true;
            } catch (Throwable throwable) {
                closeReaderQuietly(metadata);
                closeReaderQuietly(preview);
                closeReaderQuietly(small);
                closeReaderQuietly(main);
                closeReaderQuietly(auxiliary);
                closeReaderQuietly(graphOnly);
                log("[PortraitAPS] six-reader creation failed; portrait"
                        + " native route unavailable: " + throwable);
                return false;
            }
        }
    }

    private static void closePortraitApsGraphReadersLocked() {
        closeReaderQuietly(portraitCaptureMetaReader);
        closeReaderQuietly(portraitPreviewYuvReader);
        closeReaderQuietly(portraitSmallYuvReader);
        closeReaderQuietly(portraitMainRawReader);
        closeReaderQuietly(portraitAuxRawReader);
        closeReaderQuietly(portraitGraphRawReader);
        portraitCaptureMetaReader = null;
        portraitPreviewYuvReader = null;
        portraitSmallYuvReader = null;
        portraitMainRawReader = null;
        portraitAuxRawReader = null;
        portraitGraphRawReader = null;
    }

    private static void closeCommonApsGraphReadersLocked() {
        closeReaderQuietly(commonRawMainReader);
        closeReaderQuietly(commonRawDolReader);
        closeReaderQuietly(commonCaptureMetaReader);
        closeReaderQuietly(commonAuxYuvReader);
        closeReaderQuietly(commonPhysical2YuvReader);
        closeReaderQuietly(commonPhysical3YuvReader);
        closeReaderQuietly(commonPhysical4YuvReader);
        closeReaderQuietly(commonSmallYuvReader);
        closeReaderQuietly(commonFullsizeRawReader);
        commonRawMainReader = null;
        commonRawDolReader = null;
        commonCaptureMetaReader = null;
        commonAuxYuvReader = null;
        commonPhysical2YuvReader = null;
        commonPhysical3YuvReader = null;
        commonPhysical4YuvReader = null;
        commonSmallYuvReader = null;
        commonFullsizeRawReader = null;
    }

    private static void closeReaderQuietly(ImageReader reader) {
        if (reader == null) {
            return;
        }
        try {
            reader.close();
        } catch (Throwable ignored) {
            // Reader teardown is best-effort on process/session recovery.
        }
    }

    private static void scheduleCommonApsInitialization() {
        Handler handler = commonApsHandler;
        if (handler == null || commonApsReady || commonApsDisabled) {
            return;
        }
        handler.removeCallbacks(COMMON_APS_INITIALIZER);
        handler.post(COMMON_APS_INITIALIZER);
    }

    private static final Runnable COMMON_APS_INITIALIZER = () -> {
        if (!commonApsReady && !commonApsDisabled) {
            prepareCommonApsClient();
        }
    };

    private static void onCommonRawAvailable(ImageReader reader,
            boolean dolStream) {
        while (true) {
            Image image;
            try {
                image = reader.acquireNextImage();
            } catch (Throwable throwable) {
                log("[CommonAPS] " + (dolStream ? "DOL" : "main")
                        + " acquire failed: " + throwable);
                return;
            }
            if (image == null) {
                return;
            }
            boolean retained = false;
            synchronized (COMMON_APS_LOCK) {
                if (commonApsCollecting && commonApsCaptureInFlight) {
                    long timestamp = image.getTimestamp();
                    CommonApsFrame frame = COMMON_APS_FRAMES.get(timestamp);
                    if (frame == null) {
                        frame = new CommonApsFrame(timestamp);
                        COMMON_APS_FRAMES.put(timestamp, frame);
                    }
                    if (dolStream ? frame.dol == null : frame.main == null) {
                        if (dolStream) {
                            frame.dol = image;
                        } else {
                            frame.main = image;
                        }
                        retained = true;
                        log("[CommonAPS] RAW10 "
                                + (dolStream ? "DOL" : "main")
                                + " arrived timestamp=" + timestamp
                                + " groups=" + COMMON_APS_FRAMES.size());
                        scheduleCommonApsSubmitIfReadyLocked();
                    }
                }
            }
            if (!retained) {
                try {
                    image.close();
                } catch (Throwable ignored) {
                    // No APS ownership was transferred.
                }
            }
        }
    }

    private static void onCommonCaptureMetaAvailable(ImageReader reader) {
        while (true) {
            Image image;
            try {
                image = reader.acquireNextImage();
            } catch (Throwable throwable) {
                log("[CommonAPS] capture-meta acquire failed: "
                        + throwable);
                return;
            }
            if (image == null) {
                return;
            }
            boolean retained = false;
            synchronized (COMMON_APS_LOCK) {
                if (commonApsCollecting && commonApsCaptureInFlight) {
                    long timestamp = image.getTimestamp();
                    CommonApsFrame frame = COMMON_APS_FRAMES.get(timestamp);
                    if (frame == null) {
                        frame = new CommonApsFrame(timestamp);
                        COMMON_APS_FRAMES.put(timestamp, frame);
                    }
                    if (frame.captureMeta == null) {
                        frame.captureMeta = image;
                        retained = true;
                        String hardwareDescription;
                        try {
                            hardwareDescription =
                                    describeCommonApsHardwareBuffer(
                                            image.getHardwareBuffer());
                        } catch (Throwable throwable) {
                            hardwareDescription = "unavailable("
                                    + throwable + ")";
                        }
                        log("[CommonAPS] capture-meta arrived timestamp="
                                + timestamp + " image=" + image.getWidth()
                                + "x" + image.getHeight() + "/fmt"
                                + image.getFormat() + " hardware="
                                + hardwareDescription + " groups="
                                + COMMON_APS_FRAMES.size());
                        scheduleCommonApsSubmitIfReadyLocked();
                    }
                }
            }
            if (!retained) {
                closeImageQuietly(image);
            }
        }
    }

    private static void drainCommonPreviewReader(ImageReader reader) {
        while (true) {
            Image image;
            try {
                image = reader.acquireNextImage();
            } catch (Throwable throwable) {
                log("[CommonAPS] preview YUV acquire failed: "
                        + throwable);
                return;
            }
            if (image == null) {
                return;
            }
            long timestamp = image.getTimestamp();
            closeImageQuietly(image);
            synchronized (COMMON_APS_LOCK) {
                if (!commonApsCollecting || !commonApsCaptureInFlight) {
                    continue;
                }
                int count = ++commonAuxYuvDrainCount;
                log("[CommonAPS] preview YUV drained=" + count + "/"
                        + commonApsExpectedFrameCount
                        + " timestamp=" + timestamp);
                scheduleCommonApsSubmitIfReadyLocked();
            }
        }
    }

    private static void drainCommonStaticReader(ImageReader reader,
            String streamName) {
        while (true) {
            Image image;
            try {
                image = reader.acquireNextImage();
            } catch (Throwable throwable) {
                log("[CommonAPS] static " + streamName
                        + " acquire failed: " + throwable);
                return;
            }
            if (image == null) {
                return;
            }
            closeImageQuietly(image);
        }
    }

    private static CommonApsDecision resolveCommonApsDecision() {
        TotalCaptureResult metadata = commonApsDecisionMetadata;
        Object client = commonApsClient;
        if (metadata != null && client != null) {
            try {
                Class<?> parameterClass = Class.forName(
                        "com.oplus.ocs.camera.consumer.apsAdapter.adapter."
                                + "ApsPreviewDecisionParam", true,
                        oplusApsClassLoader);
                Constructor<?> constructor = null;
                for (Constructor<?> candidate
                        : parameterClass.getConstructors()) {
                    if (candidate.getParameterTypes().length == 19) {
                        constructor = candidate;
                        break;
                    }
                }
                if (constructor == null) {
                    throw new NoSuchMethodException(
                            "ApsPreviewDecisionParam/19");
                }
                Object parameters = constructor.newInstance(
                        latestLeicaZoom, metadata,
                        0, 0, 0, 0, 0, 0, 0, 0, 0,
                        "common", 0, 0, 0, 0, 0, 0,
                        new HashMap<String, String>());
                try {
                    ActivityManager manager = (ActivityManager)
                            xiaomiCameraApplication.getSystemService(
                                    Context.ACTIVITY_SERVICE);
                    ActivityManager.MemoryInfo memory =
                            new ActivityManager.MemoryInfo();
                    manager.getMemoryInfo(memory);
                    XposedHelpers.callMethod(parameters, "setAvailMem",
                            memory.availMem);
                } catch (Throwable ignored) {
                    // Native decision accepts zero when memory is unavailable.
                }
                Object nativeResult = invokeMethodByCount(client,
                        "previewDecision", 1, parameters);
                int frameCount = XposedHelpers.getIntField(nativeResult,
                        "mMultiFrameCount");
                int bracketMode = XposedHelpers.getIntField(nativeResult,
                        "mApsBracketMode");
                int superNightScene = XposedHelpers.getIntField(nativeResult,
                        "mSuperNightScene");
                int turboRawScene = XposedHelpers.getIntField(nativeResult,
                        "mTurboRawScene");
                int featureType = XposedHelpers.getIntField(nativeResult,
                        "mApsDecisionFeatureType");
                int aisState = XposedHelpers.getIntField(nativeResult,
                        "mAISState");
                Object evObject = XposedHelpers.getObjectField(nativeResult,
                        "mCaptureEVList");
                int[] evList = evObject instanceof int[]
                        ? (int[]) evObject : new int[20];
                CommonApsDecision decision = new CommonApsDecision(
                        frameCount, bracketMode, superNightScene,
                        turboRawScene, featureType, aisState, evList,
                        "native-previewDecision");
                long ageMs = Math.max(0L,
                        (SystemClock.elapsedRealtimeNanos()
                                - commonApsDecisionMetadataNanos)
                                / 1_000_000L);
                log("[CommonAPS] native decision frames=" + frameCount
                        + " bracket=" + bracketMode + " superNight="
                        + superNightScene + " turboRaw=" + turboRawScene
                        + " feature=" + featureType + " ais=" + aisState
                        + " ev="
                        + decision.evListString() + " metadataAgeMs="
                        + ageMs + " raw=" + nativeResult);
                if (decision.isSupportedCommon2Dol()) {
                    return decision;
                }
            } catch (Throwable throwable) {
                log("[CommonAPS] native previewDecision unavailable: "
                        + throwable);
            }
        }

        // Both fallbacks below were captured from this exact OnePlus 13:
        // normal common/2DOL is 4x EV0/Bracket0; the lower-lux HDR branch is
        // 5x with the fifth exposure at about -3.8EV/Bracket25.  This path is
        // used only when the vendor decision API rejects foreign app state.
        boolean hdr = latestLeicaLux < 350;
        int[] evList = new int[20];
        if (hdr) {
            evList[4] = -38;
        }
        CommonApsDecision fallback = new CommonApsDecision(
                hdr ? COMMON_APS_HDR_FRAME_COUNT
                        : COMMON_APS_NORMAL_FRAME_COUNT,
                hdr ? 25 : 0, 4, 4, 50, hdr ? 7 : 8, evList,
                "stock-observed-lux-fallback");
        log("[CommonAPS] decision fallback lux=" + latestLeicaLux
                + " frames=" + fallback.frameCount + " bracket="
                + fallback.bracketMode + " ev="
                + fallback.evListString());
        return fallback;
    }

    private static boolean applyCommonApsRequestTags(
            CaptureRequest.Builder builder, int index,
            CommonApsDecision decision) {
        try {
            builder.set(COMMON_APS_MFNR, new int[]{1});
            builder.set(COMMON_APS_AI_SCENE, new int[]{1});
            if (decision.isPortraitDualRaw()) {
                // Exact request-level decision captured from ColorOS 3x
                // portrait.  The targetless stock parcel supplies every
                // other vendor key; only the per-frame index is advanced.
                builder.set(COMMON_APS_SUPERNIGHT, new int[]{4});
                builder.set(COMMON_APS_REQUEST_NUM,
                        new int[]{PORTRAIT_APS_FRAME_COUNT});
                builder.set(COMMON_APS_REQUEST_NUM_LIST,
                        new int[]{PORTRAIT_APS_FRAME_COUNT, 4});
                builder.set(COMMON_APS_SALIENT, new int[]{0});
                builder.set(COMMON_APS_FEATURE, new int[]{48});
                builder.set(COMMON_APS_SENSOR_MODE, new int[]{0});
                builder.set(COMMON_APS_SENSOR_MODE_LIST,
                        new int[]{-1, -1, -1, 0,
                                -1, -1, -1, -1});
                builder.set(COMMON_APS_REQUEST_INDEX, new int[]{index});
                builder.set(COMMON_APS_IPE_SEQUENCE, new int[]{1});
                builder.set(COMMON_APS_BRACKET_MODE, new int[]{25});
                builder.set(COMMON_APS_AIS_STATE, new int[]{0});
                builder.set(COMMON_APS_MOVING_OBJECT, new int[]{0});
                return true;
            }
            if (decision.isTeleSingleRaw()) {
                // Exact stock OnePlus 13 rear-tele SAT request.  Preserve the
                // selected >=3x framing while retaining ColorOS' 3x optical
                // handoff contract and eight-frame single-RAW topology.
                float teleZoom = Math.max(3.0f, commonApsZoomRatio);
                builder.set(CaptureRequest.CONTROL_ZOOM_RATIO, teleZoom);
                builder.set(CaptureRequest.SCALER_CROP_REGION,
                        fullRearActiveArray());
                builder.set(CaptureRequest.CONTROL_ENABLE_ZSL, false);
                builder.set(OPLUS_ORIGINAL_ZOOM,
                        new float[]{Math.max(1.0f, teleZoom / 3.0f)});
                builder.set(OPLUS_ZOOM_TARGET, new float[]{0.0f});
                builder.set(OPLUS_POINT_ZOOM, new int[]{0});
                builder.set(COMMON_APS_AUTO_HDR, new int[]{1});
                builder.set(COMMON_APS_ZOOM_FEATURE, new int[]{0});
                builder.set(COMMON_APS_SAT_MASTER_CAMERA, new int[]{2});
                builder.set(COMMON_APS_SUPERNIGHT, new int[]{3});
                builder.set(COMMON_APS_REQUEST_NUM, new int[]{8});
                builder.set(COMMON_APS_REQUEST_NUM_LIST,
                        new int[]{8, 0});
                builder.set(COMMON_APS_SALIENT, new int[]{1});
                builder.set(COMMON_APS_FEATURE, new int[]{48});
                builder.set(COMMON_APS_SENSOR_MODE, new int[]{0});
                builder.set(COMMON_APS_SENSOR_MODE_LIST,
                        new int[]{3, -1, 2, 0, -1, -1, -1, -1});
                builder.set(COMMON_APS_REQUEST_INDEX, new int[]{index});
                builder.set(COMMON_APS_IPE_SEQUENCE, new int[]{1});
                builder.set(COMMON_APS_BRACKET_MODE, new int[]{28});
                builder.set(COMMON_APS_AIS_STATE, new int[]{0});
                builder.set(COMMON_APS_MOVING_OBJECT, new int[]{0});
                return true;
            }
            if (decision.isUltraWideSingleRaw()) {
                // Exact stock OnePlus 13 ultra-wide SAT route.  The user-facing
                // Xiaomi item is 0.7x, while CameraUnit's native UW contract is
                // the optical 0.6x route captured from physical camera 2.
                builder.set(CaptureRequest.CONTROL_ZOOM_RATIO, 0.6f);
                builder.set(CaptureRequest.SCALER_CROP_REGION,
                        fullRearActiveArray());
                builder.set(CaptureRequest.CONTROL_ENABLE_ZSL, false);
                builder.set(OPLUS_ORIGINAL_ZOOM, new float[]{1.0f});
                builder.set(OPLUS_ZOOM_TARGET, new float[]{-1.0f});
                builder.set(OPLUS_POINT_ZOOM, new int[]{0});
                builder.set(COMMON_APS_AUTO_HDR, new int[]{1});
                builder.set(COMMON_APS_ZOOM_FEATURE, new int[]{0});
                builder.set(COMMON_APS_SAT_MASTER_CAMERA, new int[]{0});
                builder.set(COMMON_APS_SUPERNIGHT, new int[]{3});
                builder.set(COMMON_APS_REQUEST_NUM, new int[]{8});
                builder.set(COMMON_APS_REQUEST_NUM_LIST,
                        new int[]{8, 0});
                builder.set(COMMON_APS_SALIENT, new int[]{1});
                builder.set(COMMON_APS_FEATURE, new int[]{48});
                builder.set(COMMON_APS_SENSOR_MODE, new int[]{0});
                builder.set(COMMON_APS_SENSOR_MODE_LIST,
                        new int[]{2, -1, 0, 2, -1, -1, -1, -1});
                builder.set(COMMON_APS_REQUEST_INDEX, new int[]{index});
                builder.set(COMMON_APS_IPE_SEQUENCE, new int[]{1});
                builder.set(COMMON_APS_BRACKET_MODE, new int[]{28});
                builder.set(COMMON_APS_AIS_STATE, new int[]{0});
                builder.set(COMMON_APS_MOVING_OBJECT, new int[]{0});
                return true;
            }
            builder.set(COMMON_APS_SUPERNIGHT,
                    new int[]{decision.superNightScene});
            builder.set(COMMON_APS_REQUEST_NUM,
                    new int[]{decision.frameCount});
            builder.set(COMMON_APS_REQUEST_NUM_LIST,
                    new int[]{decision.frameCount,
                            COMMON_APS_NORMAL_FRAME_COUNT});
            builder.set(COMMON_APS_SALIENT, new int[]{1});
            builder.set(COMMON_APS_FEATURE,
                    new int[]{decision.featureType});
            builder.set(COMMON_APS_SENSOR_MODE, new int[]{3});
            builder.set(COMMON_APS_SENSOR_MODE_LIST,
                    decision.superNightScene == 1
                            ? new int[]{3, -1, 2, 2,
                            -1, -1, -1, -1}
                            : new int[]{3, -1, 3, 3,
                            -1, -1, -1, -1});
            builder.set(COMMON_APS_REQUEST_INDEX, new int[]{index});
            builder.set(COMMON_APS_IPE_SEQUENCE, new int[]{1});
            builder.set(COMMON_APS_BRACKET_MODE,
                    new int[]{decision.bracketMode});
            builder.set(COMMON_APS_AIS_STATE,
                    new int[]{decision.aisState});
            return true;
        } catch (Throwable throwable) {
            log("[CommonAPS] request tags rejected index=" + index
                    + ": " + throwable);
            return false;
        }
    }

    @SuppressWarnings({"rawtypes", "unchecked"})
    private static ArrayList<CaptureRequest> buildCommonApsRequestSet(
            Object captureSession, CaptureRequest original,
            CommonApsDecision decision) {
        try {
            Object deviceImpl = XposedHelpers.getObjectField(
                    captureSession, "mDeviceImpl");
            boolean ultraWide = decision.isUltraWideSingleRaw();
            boolean tele = decision.isTeleSingleRaw();
            boolean singleRaw = decision.isSingleRaw();
            boolean portrait = decision.isPortraitDualRaw();
            CaptureRequest stockStill = portrait
                    ? loadEmbeddedOplusPortraitStillRequest()
                    : loadEmbeddedOplusStillRequest(ultraWide, tele);
            ArrayList<CaptureRequest> requests =
                    new ArrayList<>(decision.frameCount);
            for (int index = 1; index <= decision.frameCount; index++) {
                CaptureRequest.Builder builder = (CaptureRequest.Builder)
                        XposedHelpers.callMethod(deviceImpl,
                                "createCaptureRequest",
                                android.hardware.camera2.CameraDevice
                                        .TEMPLATE_STILL_CAPTURE);
                // Start from the exact system-camera request.  It carries the
                // vendor contract which makes CameraUnit populate the full
                // 1280x720 capture-meta buffer and route RAW through R2R.
                // Do not bulk-copy Xiaomi's request afterward: that replaces
                // overlapping OPlus vendor values with foreign CameraX/Mivi
                // state. Copy only framework controls which describe the
                // requested framing and the optional Pro exposure.
                int[] stockCopy = copyCaptureRequestKeys(
                        stockStill, builder);
                int[] xiaomiCopy = copyPortableRearControls(
                        original, builder);
                builder.setTag(original.getTag());
                builder.set(CaptureRequest.CONTROL_CAPTURE_INTENT,
                        CaptureRequest.CONTROL_CAPTURE_INTENT_STILL_CAPTURE);
                // These are session parameters, not ordinary per-frame
                // controls.  The portable graph was configured through the
                // supported third-party identity, so the still request must
                // retain the same values.  v111 proved that copying the stock
                // identity (SDK key absent/mainMenu=true) makes Camera2 issue
                // a mid-burst configureStreams; the vendor HAL then faults
                // while flushing the half-reconfigured SAT graph.
                builder.set(OPLUS_SDK_CAMERA_PACKAGE, new byte[]{1});
                builder.set(OPLUS_IS_FROM_MAIN_MENU, Boolean.FALSE);
                if (portrait) {
                    // Stock order from the successful 3x capture: main RAW,
                    // physical-2 small control, auxiliary RAW, metadata,
                    // physical-4 preview control.  The sixth graph RAW stays
                    // configured but is intentionally not a request target.
                    builder.addTarget(
                            portraitMainRawReader.getSurface());
                    builder.addTarget(
                            portraitSmallYuvReader.getSurface());
                    builder.addTarget(
                            portraitAuxRawReader.getSurface());
                    builder.addTarget(
                            portraitCaptureMetaReader.getSurface());
                    builder.addTarget(
                            portraitPreviewYuvReader.getSurface());
                } else if (singleRaw) {
                    // Stock 0.6x and 3x SAT target order: preview-YUV,
                    // capture metadata, one RAW10. DOL remains configured at
                    // output7 but is intentionally not targeted.
                    builder.addTarget(commonAuxYuvReader.getSurface());
                    builder.addTarget(commonCaptureMetaReader.getSurface());
                    builder.addTarget(commonRawMainReader.getSurface());
                } else {
                    builder.addTarget(commonRawMainReader.getSurface());
                    // Stock OPlus puts this YUV surface on every still request
                    // as well as on the repeating request. It is part of the
                    // offline graph/metadata-sink contract.
                    builder.addTarget(commonAuxYuvReader.getSurface());
                    builder.addTarget(commonRawDolReader.getSurface());
                    builder.addTarget(commonCaptureMetaReader.getSurface());
                }
                // A captureBurst temporarily replaces the repeating request.
                // Keep Xiaomi's configured preview suffix targeted by every
                // native APS exposure so the visible stream does not stop for
                // the whole 5/8-frame merge. It is appended after the fixed
                // OPlus stream-index ABI and is never passed to APS itself.
                boolean keepsVisiblePreview = commonApsUnifiedSessionActive
                        && commonApsUnifiedXiaomiPreviewSurface != null;
                if (keepsVisiblePreview) {
                    builder.addTarget(commonApsUnifiedXiaomiPreviewSurface);
                }
                // Capture-meta is the fourth stock still target.  Its
                // HardwareBuffer is submitted with both DOL inputs.
                if (!applyCommonApsRequestTags(builder, index,
                        decision)) {
                    return null;
                }
                CaptureRequest request = builder.build();
                if (index == 1) {
                    log("[CommonAPS] still request merge stock="
                            + Arrays.toString(stockCopy)
                            + " xiaomi=" + Arrays.toString(xiaomiCopy)
                            + " finalKeys=" + request.getKeys().size()
                            + " sdk=" + Arrays.toString(request.get(
                            OPLUS_SDK_CAMERA_PACKAGE))
                            + " mainMenu=" + request.get(
                            OPLUS_IS_FROM_MAIN_MENU)
                            + " topology=" + (portrait
                            ? "portrait-7x-dualRAW" : ultraWide
                            ? "UW-8x-singleRAW" : tele
                            ? "tele-8x-singleRAW" : "common-2DOL")
                            + " visiblePreview=" + keepsVisiblePreview);
                }
                requests.add(request);
            }
            return requests;
        } catch (Throwable throwable) {
            log("[CommonAPS] request cloning failed: " + throwable);
            return null;
        }
    }

    private static CameraCaptureSession.CaptureCallback
            wrapCommonApsBurstCallback(
            CameraCaptureSession.CaptureCallback original,
            CaptureRequest baseRequest, List<CaptureRequest> requests) {
        return wrapCommonApsBurstCallback(original, baseRequest, requests,
                null, false);
    }

    private static CameraCaptureSession.CaptureCallback
            wrapCommonApsBurstCallback(
            CameraCaptureSession.CaptureCallback original,
            CaptureRequest baseRequest, List<CaptureRequest> requests,
            java.util.concurrent.atomic.AtomicInteger clientSequence,
            boolean completeClientOnBase) {
        Map<CaptureRequest, Integer> indexes = new IdentityHashMap<>();
        for (int i = 0; i < requests.size(); i++) {
            indexes.put(requests.get(i), i + 1);
        }
        return new CameraCaptureSession.CaptureCallback() {
            private final AtomicBoolean clientSequenceDelivered =
                    new AtomicBoolean(false);

            private boolean isBase(CaptureRequest request) {
                return request == baseRequest;
            }

            private int index(CaptureRequest request) {
                Integer value = indexes.get(request);
                return value == null ? -1 : value;
            }

            @Override
            public void onCaptureStarted(CameraCaptureSession session,
                    CaptureRequest request, long timestamp,
                    long frameNumber) {
                int frameIndex = index(request);
                if (frameIndex == 1 && timestamp > 0L) {
                    synchronized (COMMON_APS_SHUTTER_LOCK) {
                        if (COMMON_APS_SHUTTER_ARMED.get()
                                && COMMON_APS_SHUTTER_HANDOFF_STARTED.get()
                                && commonApsShutterTimestamp <= 0L) {
                            commonApsShutterTimestamp = timestamp;
                            commonApsShutterRequest = request;
                            log("[UnifiedAPS] DIRECT shutter sensorTs="
                                    + timestamp + " frame=" + frameNumber);
                        }
                    }
                    synchronized (COMMON_APS_LOCK) {
                        if (commonApsCaptureInFlight
                                && commonApsIdentity < 0L) {
                            commonApsIdentity = timestamp;
                            log("[CommonAPS] merge identity locked to first"
                                    + " sensor timestamp=" + timestamp);
                        }
                    }
                }
                log("[CommonAPS] request started index=" + frameIndex
                        + " sensorTs=" + timestamp + " frame="
                        + frameNumber);
                if (original != null && isBase(request)) {
                    original.onCaptureStarted(session, request, timestamp,
                            frameNumber);
                }
            }

            @Override
            public void onCaptureProgressed(CameraCaptureSession session,
                    CaptureRequest request, CaptureResult partialResult) {
                if (original != null && isBase(request)) {
                    original.onCaptureProgressed(session, request,
                            partialResult);
                }
            }

            @Override
            public void onCaptureCompleted(CameraCaptureSession session,
                    CaptureRequest request, TotalCaptureResult result) {
                int frameIndex = index(request);
                recordCommonApsCaptureResult(result, frameIndex);
                if (original != null && isBase(request)) {
                    original.onCaptureCompleted(session, request, result);
                    // Xiaomi only owns the first request. Do not keep its
                    // shutter/UI state tied to the remaining private APS merge
                    // inputs; their ImageReader/APS path continues normally.
                    if (completeClientOnBase && clientSequence != null) {
                        int sequenceId = clientSequence.get();
                        if (sequenceId >= 0
                                && clientSequenceDelivered
                                .compareAndSet(false, true)) {
                            original.onCaptureSequenceCompleted(session,
                                    sequenceId, result.getFrameNumber());
                            log("[UnifiedAPS] Xiaomi client sequence released"
                                    + " on base result id=" + sequenceId
                                    + " frame=" + result.getFrameNumber());
                        }
                    }
                }
            }

            @Override
            public void onCaptureFailed(CameraCaptureSession session,
                    CaptureRequest request, CaptureFailure failure) {
                abortCommonApsCapture("request-" + index(request)
                        + "-failed-" + failure.getReason(), true);
                restoreActiveHandoff("capture-request-failed");
                if (original != null && isBase(request)) {
                    original.onCaptureFailed(session, request, failure);
                }
            }

            @Override
            public void onCaptureSequenceCompleted(
                    CameraCaptureSession session, int sequenceId,
                    long frameNumber) {
                log("[CommonAPS] Camera2 sequence complete id="
                        + sequenceId + " lastFrame=" + frameNumber);
                if (original != null && (!completeClientOnBase
                        || clientSequenceDelivered
                        .compareAndSet(false, true))) {
                    original.onCaptureSequenceCompleted(session,
                            sequenceId, frameNumber);
                }
            }

            @Override
            public void onCaptureSequenceAborted(
                    CameraCaptureSession session, int sequenceId) {
                abortCommonApsCapture("sequence-aborted-" + sequenceId,
                        true);
                restoreActiveHandoff("capture-sequence-aborted");
                if (original != null && (!completeClientOnBase
                        || clientSequenceDelivered
                        .compareAndSet(false, true))) {
                    original.onCaptureSequenceAborted(session, sequenceId);
                }
            }

            @Override
            public void onCaptureBufferLost(CameraCaptureSession session,
                    CaptureRequest request, Surface target,
                    long frameNumber) {
                int requestIndex = index(request);
                String role = logCommonApsBufferLost("still",
                        requestIndex, target, frameNumber);
                // APS consumes only these three outputs.  Preview/PIP and the
                // physical YUVs are graph-control streams: CameraUnit itself
                // can occasionally drop one during a five-frame 2DOL burst
                // without invalidating either RAW pair or capture metadata.
                boolean fatal = "main-raw10".equals(role)
                        || "dol-raw10".equals(role)
                        || "capture-meta".equals(role);
                if (fatal) {
                    abortCommonApsCapture("sidecar-buffer-lost-"
                            + role + "-" + frameNumber, true);
                    restoreActiveHandoff("capture-buffer-lost");
                } else {
                    log("[CommonAPS] auxiliary buffer loss tolerated role="
                            + role + " frame=" + frameNumber);
                }
                if (original != null && isBase(request)) {
                    original.onCaptureBufferLost(session, request, target,
                            frameNumber);
                }
            }
        };
    }

    private static String logCommonApsBufferLost(String phase,
            int requestIndex, Surface target, long frameNumber) {
        String role = commonApsSurfaceRole(target);
        log("[CommonAPS] buffer lost phase=" + phase
                + " requestIndex=" + requestIndex
                + " frame=" + frameNumber + " role=" + role
                + " id=" + safeSurfaceProperty("getSurfaceId", target)
                + " size=" + safeSurfaceProperty("getSurfaceSize", target)
                + " format=" + safeSurfaceProperty(
                "getSurfaceFormat", target)
                + " usage=" + safeSurfaceProperty(
                "getSurfaceUsage", target)
                + " surface=" + target + " "
                + commonApsMemorySnapshot());
        return role;
    }

    private static String commonApsSurfaceRole(Surface target) {
        if (target == null) {
            return "null";
        }
        ImageReader reader = commonRawMainReader;
        if (reader != null && target == reader.getSurface()) {
            return "main-raw10";
        }
        reader = commonRawDolReader;
        if (reader != null && target == reader.getSurface()) {
            return "dol-raw10";
        }
        reader = commonCaptureMetaReader;
        if (reader != null && target == reader.getSurface()) {
            return "capture-meta";
        }
        reader = commonAuxYuvReader;
        if (reader != null && target == reader.getSurface()) {
            return "preview-yuv";
        }
        reader = commonSmallYuvReader;
        if (reader != null && target == reader.getSurface()) {
            return "pip-yuv";
        }
        reader = commonPhysical2YuvReader;
        if (reader != null && target == reader.getSurface()) {
            return "physical2-yuv";
        }
        reader = commonPhysical3YuvReader;
        if (reader != null && target == reader.getSurface()) {
            return "physical3-yuv";
        }
        reader = commonPhysical4YuvReader;
        if (reader != null && target == reader.getSurface()) {
            return "physical4-yuv";
        }
        reader = commonFullsizeRawReader;
        if (reader != null && target == reader.getSurface()) {
            return "fullsize-raw10";
        }
        return "unmapped";
    }

    private static String commonApsMemorySnapshot() {
        try {
            Application application = resolveCurrentCameraApplication();
            ActivityManager manager = application == null ? null
                    : (ActivityManager) application.getSystemService(
                    Context.ACTIVITY_SERVICE);
            ActivityManager.MemoryInfo memory =
                    new ActivityManager.MemoryInfo();
            if (manager != null) {
                manager.getMemoryInfo(memory);
            }
            Runtime runtime = Runtime.getRuntime();
            long heapUsed = runtime.totalMemory() - runtime.freeMemory();
            return "memAvailMiB=" + (memory.availMem / 1_048_576L)
                    + " low=" + memory.lowMemory
                    + " heapUsedMiB=" + (heapUsed / 1_048_576L)
                    + "/" + (runtime.maxMemory() / 1_048_576L);
        } catch (Throwable throwable) {
            return "mem=unavailable(" + throwable.getClass()
                    .getSimpleName() + ")";
        }
    }

    private static void recordCommonApsCaptureResult(
            TotalCaptureResult result, int index) {
        Long timestamp = result.get(CaptureResult.SENSOR_TIMESTAMP);
        if (timestamp == null || index < 1
                || index > commonApsExpectedFrameCount) {
            abortCommonApsCapture("invalid-result-index-" + index, true);
            return;
        }
        synchronized (COMMON_APS_LOCK) {
            if (!commonApsCollecting || !commonApsCaptureInFlight) {
                return;
            }
            if (index == 1 && commonApsIdentity < 0L) {
                commonApsIdentity = timestamp;
                log("[CommonAPS] merge identity fallback locked from first"
                        + " result timestamp=" + timestamp);
            }
            CommonApsFrame frame = COMMON_APS_FRAMES.get(timestamp);
            if (frame == null) {
                frame = new CommonApsFrame(timestamp);
                COMMON_APS_FRAMES.put(timestamp, frame);
            }
            frame.result = result;
            frame.index = index;
            log("[CommonAPS] metadata index=" + index
                    + " frame=" + result.getFrameNumber()
                    + " timestamp=" + timestamp + " iso="
                    + result.get(CaptureResult.SENSOR_SENSITIVITY)
                    + " exposureNs="
                    + result.get(CaptureResult.SENSOR_EXPOSURE_TIME));
            scheduleCommonApsSubmitIfReadyLocked();
        }
    }

    private static void scheduleCommonApsSubmitIfReadyLocked() {
        if (!commonApsCollecting || commonApsSubmitScheduled
                || COMMON_APS_FRAMES.size()
                < commonApsExpectedFrameCount
                || commonAuxYuvDrainCount
                < commonApsExpectedFrameCount) {
            return;
        }
        boolean[] complete =
                new boolean[commonApsExpectedFrameCount + 1];
        for (CommonApsFrame frame : COMMON_APS_FRAMES.values()) {
            if (frame.isComplete()) {
                complete[frame.index] = true;
            }
        }
        for (int index = 1;
                index <= commonApsExpectedFrameCount; index++) {
            if (!complete[index]) {
                return;
            }
        }
        commonApsCollecting = false;
        commonApsSubmitScheduled = true;
        Handler handler = commonApsHandler;
        if (handler != null) {
            handler.post(HookEntry::submitCommonApsFrames);
        }
    }

    private static boolean prepareCommonApsClient() {
        synchronized (COMMON_APS_LOCK) {
            final boolean portraitClient =
                    commonApsUnifiedPortraitSession;
            if (commonApsReady
                    && commonApsClientPortrait == portraitClient) {
                return true;
            }
            if (commonApsDisabled) {
                return false;
            }
            if (commonApsClient != null) {
                Object stale = commonApsClient;
                commonApsReady = false;
                commonApsClient = null;
                commonApsAlgoObject = null;
                commonApsWatermark = null;
                closeCommonApsImagesLocked();
                COMMON_APS_FRAMES.clear();
                try {
                    XposedHelpers.callMethod(stale, "abortCaptures");
                } catch (Throwable ignored) {
                    // A topology transition normally has no active capture.
                }
                try {
                    XposedHelpers.callMethod(stale, "unInitAlgo", 1);
                } catch (Throwable ignored) {
                    // Continue to disconnect the topology-specific client.
                }
                try {
                    XposedHelpers.callMethod(stale, "disconnect");
                } catch (Throwable ignored) {
                    // A disconnected offline service is already unusable.
                }
                log("[CommonAPS] client topology switched to "
                        + (portraitClient ? "portrait" : "common"));
            }
            final int clientGeneration = ++commonApsClientGeneration;
            Application application = xiaomiCameraApplication;
            if (application == null) {
                log("[CommonAPS] initialization deferred: Application"
                        + " is not attached yet");
                return false;
            }
            Object fullAps = null;
            boolean initialized = false;
            try {
                probeOplusApsClasses(application.getClassLoader());
                ClassLoader apsLoader = oplusApsClassLoader;
                if (apsLoader == null) {
                    throw new IllegalStateException(
                            "private APS class loader unavailable");
                }
                Context oplusContext = application.createPackageContext(
                        OPLUS_CAMERA, Context.CONTEXT_INCLUDE_CODE
                                | Context.CONTEXT_IGNORE_SECURITY);

                // Callback/command holders need this process' real
                // Application.  Only the XML/config parser uses OPlus Camera's
                // foreign resource context.
                Class<?> contextHolder = Class.forName(
                        "com.oplus.ocs.camera.common.util.ContextHolder",
                        true, apsLoader);
                XposedHelpers.callStaticMethod(contextHolder, "setContext",
                        application);
                Class<?> apsContextHolder = Class.forName(
                        "com.oplus.ocs.camera.consumer.apsAdapter."
                                + "ApsContextHolder", true, apsLoader);
                XposedHelpers.callStaticMethod(apsContextHolder,
                        "setContext", application);
                Class<?> config = Class.forName(
                        "com.oplus.ocs.camera.consumer.apsAdapter.config."
                                + "AlgoSwitchConfig", true, apsLoader);
                XposedHelpers.callStaticMethod(config, "initialize",
                        oplusContext);

                Class<?> listenerClass = Class.forName(
                        "com.oplus.ocs.camera.consumer.apsAdapter.algorithm."
                                + "ApsInterface$ApsListener", false,
                        apsLoader);
                Object listener = Proxy.newProxyInstance(apsLoader,
                        new Class<?>[]{listenerClass},
                        (proxy, method, args) -> {
                            String name = method.getName();
                            if ("onCaptureReceived".equals(name)
                                    && args != null && args.length > 0) {
                                if (clientGeneration
                                        == commonApsClientGeneration) {
                                    onCommonApsCaptureReceived(args[0]);
                                } else {
                                    log("[CommonAPS] stale capture callback"
                                            + " ignored clientGeneration="
                                            + clientGeneration + " current="
                                            + commonApsClientGeneration);
                                }
                            } else if ("onServiceDied".equals(name)) {
                                invalidateCommonApsClient(
                                        "APS-service-died",
                                        clientGeneration);
                            } else if (!"onPreviewReceived".equals(name)) {
                                log("[CommonAPS] callback=" + name);
                            }
                            return defaultReflectionValue(
                                    method.getReturnType());
                        });
                Class<?> fullClass = Class.forName(
                        "com.oplus.ocs.camera.consumer.apsAdapter.algorithm."
                                + "FullApsImpl", true, apsLoader);
                fullAps = fullClass
                        .getConstructor(listenerClass, String.class)
                        .newInstance(listener, "V002.000.000");
                Object connected = XposedHelpers.callMethod(
                        fullAps, "connect", 6);
                if (!Boolean.TRUE.equals(connected)) {
                    throw new IllegalStateException(
                            "APS connect(6) returned " + connected);
                }

                CameraManager cameraManager = (CameraManager) application
                        .getSystemService(Context.CAMERA_SERVICE);
                CameraCharacteristics characteristics = cameraManager
                        .getCameraCharacteristics("0");
                Class<?> wrapperClass = Class.forName(
                        "com.oplus.ocs.camera.producer.info."
                                + "CameraCharacteristicsWrapper", true,
                        apsLoader);
                Object characteristicsWrapper = XposedHelpers.newInstance(
                        wrapperClass, application, cameraManager, "0");
                String[] vendorTags = (String[]) XposedHelpers.callMethod(
                        characteristicsWrapper, "getVendorTagAndId");

                Class<?> initClass = Class.forName(
                        "com.oplus.ocs.camera.consumer.apsAdapter.adapter."
                                + "ApsInitParameter", true, apsLoader);
                Object init = initClass.getConstructor().newInstance();
                XposedHelpers.setIntField(init, "mApsModule", 1);
                XposedHelpers.setObjectField(init, "mInitAlgo",
                        (portraitClient
                                ? PORTRAIT_APS_INIT_ALGORITHMS
                                : COMMON_APS_INIT_ALGORITHMS).clone());
                XposedHelpers.setObjectField(init, "mMetadata",
                        characteristics);
                XposedHelpers.setObjectField(init, "mVendorTags",
                        vendorTags);
                XposedHelpers.setObjectField(init, "mParameters",
                        commonApsInitParameterPairs(
                                application, portraitClient));
                XposedHelpers.callMethod(fullAps, "initAlgo", init);
                initialized = true;

                Class<?> algoObjectClass = Class.forName(
                        "com.oplus.ocs.camera.consumer.apsAdapter.adapter."
                                + "ApsCaptureAlgoOBJParam", true, apsLoader);
                Object algoObject = algoObjectClass.getConstructor()
                        .newInstance();
                // Keep the stock six-node capture graph intact: its final
                // watermark node participates in pipeline construction.  Do
                // not, however, give APS any OPlus/Hasselblad watermark data.
                // APSClient explicitly supports a null ApsWatermarkParam; the
                // unmarked base image is later owned by Xiaomi's watermark
                // renderer, while all OPlus watermark switches remain off.
                Object watermark = null;

                // Validate both embedded captures before a Camera2 request is
                // ever expanded.  No file under /data participates at runtime.
                commonApsStartParameterReference =
                        loadCommonApsParameterAsset(
                                "oplus_common_start_params.tsv", 90);
                commonApsBeforeParameterReference =
                        loadCommonApsParameterAsset(
                                "oplus_common_before_params.tsv", 11);
                commonApsFrameParameterReference =
                        loadCommonApsParameterAsset(
                                "oplus_common_frame_params.tsv", 170);
                commonApsProcessParameterReference =
                        loadCommonApsParameterAsset(
                                "oplus_common_process_params.tsv", 180);
                commonApsUltraWideStartParameterReference =
                        loadCommonApsParameterAsset(
                                "oplus_common_06_start_params.tsv", 90);
                commonApsUltraWideBeforeParameterReference =
                        loadCommonApsParameterAsset(
                                "oplus_common_06_before_params.tsv", 11);
                commonApsUltraWideFrameParameterReference =
                        loadCommonApsParameterAsset(
                                "oplus_common_06_frame_params.tsv", 170);
                commonApsUltraWideProcessParameterReference =
                        loadCommonApsParameterAsset(
                                "oplus_common_06_process_params.tsv", 180);
                if (clientGeneration != commonApsClientGeneration) {
                    try {
                        XposedHelpers.callMethod(fullAps,
                                "unInitAlgo", 1);
                    } catch (Throwable ignored) {
                        // Initialization was invalidated while connecting.
                    }
                    try {
                        XposedHelpers.callMethod(fullAps, "disconnect");
                    } catch (Throwable ignored) {
                        // The stale client must never be published.
                    }
                    log("[CommonAPS] initialized client became stale before"
                            + " publish generation=" + clientGeneration
                            + " current=" + commonApsClientGeneration);
                    return false;
                }
                commonApsClient = fullAps;
                commonApsAlgoObject = algoObject;
                commonApsWatermark = watermark;
                commonApsClientPortrait = portraitClient;
                commonApsReady = true;
                log("[CommonAPS] module=1 "
                        + (portraitClient ? "portrait" : "common")
                        + " graph ready initAlgorithms="
                        + (portraitClient
                        ? PORTRAIT_APS_INIT_ALGORITHMS.length
                        : COMMON_APS_INIT_ALGORITHMS.length)
                        + " processAlgorithms="
                        + Arrays.toString(COMMON_APS_PROCESS_ALGORITHMS)
                        + " vendorTagPairs="
                        + (vendorTags == null ? -1
                        : vendorTags.length / 2)
                        + " start/before/frame/processPairs="
                        + commonApsStartParameterReference.length / 2
                        + "/"
                        + commonApsBeforeParameterReference.length / 2
                        + "/"
                        + commonApsFrameParameterReference.length / 2
                        + "/"
                        + commonApsProcessParameterReference.length / 2);
                return true;
            } catch (Throwable throwable) {
                commonApsReady = false;
                commonApsDisabled = true;
                commonApsClient = null;
                commonApsClientPortrait = false;
                if (fullAps != null) {
                    if (initialized) {
                        try {
                            XposedHelpers.callMethod(fullAps,
                                    "unInitAlgo", 1);
                        } catch (Throwable ignored) {
                            // Continue to disconnect this failed client.
                        }
                    }
                    try {
                        XposedHelpers.callMethod(fullAps, "disconnect");
                    } catch (Throwable ignored) {
                        // Fail closed for this process.
                    }
                }
                log("[CommonAPS] graph initialization failed; bridge"
                        + " disabled for this process: " + throwable);
                XposedBridge.log(throwable);
                return false;
            }
        }
    }

    /**
     * Detach a FullApsImpl whose offline binder can no longer reach the
     * current camera provider.  This is deliberately recoverable: assets or
     * class-link failures still set commonApsDisabled during initialization,
     * while provider/service death merely causes the next session prewarm to
     * construct a fresh client.
     */
    private static void invalidateCommonApsClient(
            String reason, int expectedClientGeneration) {
        final Object staleClient;
        final boolean hadState;
        final int invalidatedGeneration;
        synchronized (COMMON_APS_LOCK) {
            if (expectedClientGeneration >= 0
                    && expectedClientGeneration
                    != commonApsClientGeneration) {
                log("[CommonAPS] stale invalidation ignored reason="
                        + reason + " expected=" + expectedClientGeneration
                        + " current=" + commonApsClientGeneration);
                return;
            }
            staleClient = commonApsClient;
            hadState = commonApsReady || staleClient != null
                    || commonApsCaptureInFlight || commonApsCollecting
                    || !COMMON_APS_FRAMES.isEmpty()
                    || !COMMON_APS_RETAINED_INPUTS.isEmpty();
            if (!hadState) {
                return;
            }
            invalidatedGeneration = ++commonApsClientGeneration;
            commonApsReady = false;
            commonApsClient = null;
            commonApsClientPortrait = false;
            commonApsAlgoObject = null;
            commonApsWatermark = null;
            commonApsCaptureGeneration++;
            commonApsCaptureInFlight = false;
            commonApsCollecting = false;
            commonApsSubmitScheduled = false;
            COMMON_APS_OUTPUT_HANDLED.set(true);
            closeCommonApsImagesLocked();
            COMMON_APS_FRAMES.clear();
        }

        failCommonApsShutter("APS client invalidated: " + reason);
        Runnable teardown = () -> {
            if (staleClient != null) {
                try {
                    XposedHelpers.callMethod(staleClient,
                            "abortCaptures");
                } catch (Throwable ignored) {
                    // A dead binder is the expected reason for this path.
                }
                try {
                    XposedHelpers.callMethod(staleClient,
                            "unInitAlgo", 1);
                } catch (Throwable ignored) {
                    // Continue to disconnect the stale native client.
                }
                try {
                    XposedHelpers.callMethod(staleClient, "disconnect");
                } catch (Throwable ignored) {
                    // The stale object has already been detached from use.
                }
            }
            log("[CommonAPS] client invalidated recoverably reason="
                    + reason + " generation=" + invalidatedGeneration);
        };
        Handler handler = commonApsHandler;
        if (handler != null) {
            handler.post(teardown);
            // A provider restart normally leads to a new Camera2 session and
            // its own prewarm.  This delayed attempt also repairs an APS-only
            // service death when the Camera2 session itself remains valid.
            handler.postDelayed(() -> {
                if (!commonApsDisabled && !commonApsReady
                        && commonApsUnifiedSessionActive
                        && invalidatedGeneration
                        == commonApsClientGeneration) {
                    prepareCommonApsClient();
                }
            }, 1_500L);
        } else {
            teardown.run();
        }
    }

    private static String[] commonApsInitParameterPairs(
            Context context, boolean portrait) {
        long availableMemory = 4_294_967_296L;
        long totalMemory = 15_841_136_640L;
        try {
            ActivityManager manager = (ActivityManager) context
                    .getSystemService(Context.ACTIVITY_SERVICE);
            ActivityManager.MemoryInfo info =
                    new ActivityManager.MemoryInfo();
            manager.getMemoryInfo(info);
            availableMemory = info.availMem;
            totalMemory = info.totalMem;
        } catch (Throwable ignored) {
            // The captured OnePlus 13 values remain a safe fallback.
        }
        if (portrait) {
            return new String[]{
                    "raw_value", "none",
                    "motion_capture_enable", "0",
                    "is_from_camera_extension", "false",
                    "thermal_level", "-1",
                    "is_from_system_camera", "true",
                    "avai_memory", String.valueOf(availableMemory),
                    "preview_height", "960",
                    "hyperlapse_video_output_size", "1280x960",
                    "is_from_main_menu_app", "true",
                    "hdr_trans_preview", "false",
                    "video_3hdr_10bit", "0",
                    "quick_jpeg_version", "2",
                    "size_mode", "0",
                    "preview_callback_type", "0",
                    "is_ai_flash_support", "false",
                    "ultra_hdr_enable", "0",
                    "preview_width", "1280",
                    "is_torch_flash_support", "true",
                    "macro_closeup_enable", "0",
                    "capture_mode", "portrait",
                    "logic_camera_id", "0",
                    "total_memory", String.valueOf(totalMemory),
                    "simulationStateFlag", "0",
                    "asd_default_state", "1",
                    "10bits_enable", "0",
                    "quick_jpeg", "true",
                    "camera_id", "0",
                    "operation_mode", String.valueOf(
                    OPLUS_PORTRAIT_TELE_OP_MODE),
                    "video_live_photo_enable", "false",
                    "high_pic_size_enable", "0",
                    "simulationTimes", "0",
                    "package_name", OPLUS_CAMERA
            };
        }
        return new String[]{
                "raw_value", "none",
                "motion_capture_enable", "0",
                "is_from_camera_extension", "false",
                "thermal_level", "-1",
                "is_from_system_camera", "true",
                "avai_memory", String.valueOf(availableMemory),
                "preview_height", "1440",
                "hyperlapse_video_output_size", "1920x1440",
                "is_from_main_menu_app", "true",
                "hdr_trans_preview", "false",
                "video_3hdr_10bit", "0",
                "quick_jpeg_version", "2",
                "size_mode", "0",
                "preview_callback_type", "0",
                "is_ai_flash_support", "false",
                "camera_feature", "commonSatHal",
                "ultra_hdr_enable", "0",
                "preview_width", "1920",
                "is_torch_flash_support", "true",
                "macro_closeup_enable", "0",
                "capture_mode", "common",
                "logic_camera_id", "0",
                "total_memory", String.valueOf(totalMemory),
                "simulationStateFlag", "0",
                "asd_default_state", "1",
                "10bits_enable", "0",
                "quick_jpeg", "true",
                "camera_id", "0",
                "operation_mode", "32769",
                "video_live_photo_enable", "false",
                "high_pic_size_enable", "0",
                "simulationTimes", "0",
                "package_name", OPLUS_CAMERA
        };
    }

    private static String[] loadCommonApsParameterAsset(String name,
            int minimumPairCount) throws Exception {
        String apkPath = moduleApkPath;
        if (apkPath == null || apkPath.isEmpty()) {
            throw new IllegalStateException("module APK path unavailable");
        }
        byte[] bytes;
        try (ZipFile apk = new ZipFile(apkPath)) {
            ZipEntry entry = apk.getEntry("assets/" + name);
            if (entry == null) {
                throw new IllegalStateException(
                        "missing embedded asset " + name);
            }
            try (InputStream input = apk.getInputStream(entry)) {
                bytes = readAllBytes(input, (int) entry.getSize());
            }
        }
        String text = new String(bytes, StandardCharsets.UTF_8);
        ArrayList<String> pairs = new ArrayList<>();
        for (String line : text.split("\\r?\\n")) {
            if (line.isEmpty()) {
                continue;
            }
            int tab = line.indexOf('\t');
            if (tab <= 0) {
                throw new IllegalStateException(
                        "invalid APS asset line in " + name);
            }
            pairs.add(line.substring(0, tab));
            pairs.add(line.substring(tab + 1));
        }
        if (pairs.size() < minimumPairCount * 2
                || (pairs.size() & 1) != 0) {
            throw new IllegalStateException("invalid " + name
                    + " elements=" + pairs.size());
        }
        return pairs.toArray(new String[0]);
    }

    private static String[] dynamicCommonApsPairs(String[] reference,
            TotalCaptureResult metadata) {
        ArrayList<String> safe = new ArrayList<>(reference.length);
        for (int i = 0; i + 1 < reference.length; i += 2) {
            String key = reference[i];
            // Never transplant the location captured while learning the stock
            // contract.  Absence is preferable to a fabricated 0,0 EXIF row.
            if ("gps_coords".equals(key) || "gps_time".equals(key)) {
                continue;
            }
            safe.add(key);
            safe.add(reference[i + 1]);
        }
        String[] pairs = safe.toArray(new String[0]);
        setCommonApsPair(pairs, "identity",
                String.valueOf(commonApsIdentity));
        setCommonApsPair(pairs, "picture_date_time",
                String.valueOf(commonApsPictureTimeMillis));
        setCommonApsPair(pairs, "picture_title",
                commonApsPictureTitle == null ? "IMG_APS_PROOF"
                        : commonApsPictureTitle);
        setCommonApsPair(pairs, "avai_memory",
                String.valueOf(commonApsAvailableMemory));
        setCommonApsPair(pairs, "orientation",
                String.valueOf(commonApsOrientation));
        setCommonApsPair(pairs, "zoom_ratio",
                String.valueOf(commonApsZoomRatio));
        setCommonApsPair(pairs, "zoom_display_ratio",
                String.valueOf(commonApsZoomRatio));
        setCommonApsPair(pairs, "zoom_focal_length",
                String.valueOf(commonApsFocalLength35Mm()));
        setCommonApsPair(pairs, "picture_exif_flag",
                String.valueOf((commonApsOrientation == 90
                        || commonApsOrientation == 270)
                        ? 1_048_608 : 1_048_576));
        setCommonApsPair(pairs, "input_ev_list:",
                Arrays.toString(commonApsEvList));
        setCommonApsPair(pairs, "capture_request_num",
                String.valueOf(commonApsExpectedFrameCount));
        setCommonApsPair(pairs, "decision_bracket_mode",
                String.valueOf(commonApsBracketMode));
        setCommonApsPair(pairs, "capture_feature_type",
                String.valueOf(commonApsFeatureType));
        setCommonApsPair(pairs, "super_night_scene",
                String.valueOf(commonApsSuperNightScene));
        setCommonApsPair(pairs, "turbo_raw_sence",
                String.valueOf(commonApsTurboRawScene));
        setCommonApsPair(pairs, "decision_feature_type",
                String.valueOf(commonApsFeatureType));
        setCommonApsPair(pairs, "ais_state",
                String.valueOf(commonApsAisState));
        // CameraUnit's stock common-capture contract deliberately identifies
        // the SDK bridge as com.android.shell.  This is not the Java process
        // package; native APS uses it when selecting the privileged offline
        // feature graph.  Replacing it with com.android.camera bypassed R2R.
        setCommonApsPair(pairs, "caller_package", "com.android.shell");
        setCommonApsPair(pairs, "jpeg_callback_hardware_buf", "true");
        // APS produces an unwatermarked base image.  Xiaomi's own watermark
        // renderer remains the sole final watermark owner.
        setCommonApsPair(pairs, "watermark_enable", "0");
        setCommonApsPair(pairs, "watermark_makeup_enable", "0");
        setCommonApsPair(pairs,
                "quick_jpeg_watermark_process_in_aps", "false");
        if (commonApsPortraitCapture) {
            applyPortraitApsParameterOverrides(pairs);
        }
        if (commonApsUltraWideCapture) {
            setCommonApsPair(pairs, "captureStreamNumber", "1");
            setCommonApsPair(pairs, "zsl_frame_cnt", "0");
            setCommonApsPair(pairs, "process_aidl_bpc", "0");
            setCommonApsPair(pairs, "meta_index", "7");
            setCommonApsPair(pairs, "hal_base_frame_index", "7");
            setCommonApsPair(pairs, "case_algo_name",
                    "ALGO_TURBO_HDR_NIGHT");
            setCommonApsPair(pairs, "watermark_focalLength35Mm", "15");
            setCommonApsPair(pairs, "watermark_lens_aperture", "2.05");
        }
        if (commonApsTeleCapture) {
            setCommonApsPair(pairs, "capture_master_pipeline", "2");
            setCommonApsPair(pairs, "previewdecision_sensor_mode", "0");
            setCommonApsPair(pairs, "previewdecision_sensor_mode_list",
                    "[3, -1, 2, 0, -1, -1, -1, -1]");
            setCommonApsPair(pairs, "captureStreamNumber", "1");
            setCommonApsPair(pairs, "zsl_frame_cnt", "0");
            setCommonApsPair(pairs, "process_aidl_bpc", "0");
            setCommonApsPair(pairs, "meta_index", "7");
            setCommonApsPair(pairs, "hal_base_frame_index", "7");
            setCommonApsPair(pairs, "case_algo_name",
                    "ALGO_TURBO_HDR_NIGHT");
            setCommonApsPair(pairs, "sat_open", "1");
            setCommonApsPair(pairs, "key_is_telephoto", "false");
            setCommonApsPair(pairs, "watermark_focalLength35Mm",
                    String.valueOf(commonApsFocalLength35Mm()));
            setCommonApsPair(pairs, "watermark_lens_aperture", "2.6");
        }
        if (metadata != null) {
            Integer iso = metadata.get(CaptureResult.SENSOR_SENSITIVITY);
            Long exposure = metadata.get(
                    CaptureResult.SENSOR_EXPOSURE_TIME);
            if (iso != null) {
                setCommonApsPair(pairs, "watermark_iso",
                        String.valueOf(iso));
            }
            if (exposure != null) {
                setCommonApsPair(pairs, "watermark_exposure_time",
                        String.valueOf(exposure));
            }
        }
        return pairs;
    }

    private static int commonApsFocalLength35Mm() {
        if (commonApsUltraWideCapture) {
            return 15;
        }
        if (commonApsTeleCapture) {
            return Math.max(73,
                    Math.round((73.0f / 3.0f) * commonApsZoomRatio));
        }
        return Math.max(14, Math.round(23.0f * commonApsZoomRatio));
    }

    private static void setCommonApsPair(String[] pairs, String key,
            String value) {
        for (int i = 0; i + 1 < pairs.length; i += 2) {
            if (key.equals(pairs[i])) {
                pairs[i + 1] = value;
                return;
            }
        }
    }

    private static String[] dynamicCommonApsLifecyclePairs(
            String[] reference, boolean startPhase) {
        String[] pairs = reference.clone();
        setCommonApsPair(pairs, "capture_algo_list",
                startPhase
                        ? " " + String.join(", ",
                        commonApsActiveProcessAlgorithms()) + " "
                        : "[" + String.join(", ",
                        commonApsActiveProcessAlgorithms()) + "]");
        setCommonApsPair(pairs, "burst_shot_flag_id",
                String.valueOf(commonApsPictureTimeMillis));
        setCommonApsPair(pairs, "capture_request_num",
                String.valueOf(commonApsExpectedFrameCount));
        setCommonApsPair(pairs, "capture_frame_count",
                String.valueOf(commonApsExpectedFrameCount));
        setCommonApsPair(pairs, "decision_bracket_mode",
                String.valueOf(commonApsBracketMode));
        setCommonApsPair(pairs, "capture_feature_type",
                String.valueOf(commonApsFeatureType));
        setCommonApsPair(pairs, "decision_feature_type",
                String.valueOf(commonApsFeatureType));
        setCommonApsPair(pairs, "super_night_scene",
                String.valueOf(commonApsSuperNightScene));
        setCommonApsPair(pairs, "turbo_raw_sence",
                String.valueOf(commonApsTurboRawScene));
        setCommonApsPair(pairs, "ais_state",
                String.valueOf(commonApsAisState));
        setCommonApsPair(pairs, "input_ev_list:",
                Arrays.toString(commonApsEvList));
        setCommonApsPair(pairs, "zoom_ratio",
                String.valueOf(commonApsZoomRatio));
        setCommonApsPair(pairs, "zoom_display_ratio",
                String.valueOf(commonApsZoomRatio));
        setCommonApsPair(pairs, "zoom_focal_length",
                String.valueOf(commonApsFocalLength35Mm()));
        setCommonApsPair(pairs, "caller_package", "com.android.shell");
        // Keep APS' graph node, but never hand it an OPlus watermark payload.
        // Xiaomi remains the only owner of the final visible watermark.
        setCommonApsPair(pairs, "watermark_enable", "0");
        setCommonApsPair(pairs, "watermark_makeup_enable", "0");
        setCommonApsPair(pairs,
                "quick_jpeg_watermark_process_in_aps", "false");
        if (commonApsPortraitCapture) {
            applyPortraitApsParameterOverrides(pairs);
        }
        if (commonApsUltraWideCapture) {
            setCommonApsPair(pairs, "capture_master_pipeline", "0");
            setCommonApsPair(pairs, "previewdecision_sensor_mode", "0");
            setCommonApsPair(pairs, "previewdecision_sensor_mode_list",
                    "[2, -1, 0, 2, -1, -1, -1, -1]");
            setCommonApsPair(pairs, "meta_index", "7");
            setCommonApsPair(pairs, "hal_base_frame_index", "7");
            setCommonApsPair(pairs, "captureStreamNumber", "1");
            setCommonApsPair(pairs, "process_aidl_bpc", "0");
            setCommonApsPair(pairs, "case_algo_name",
                    "ALGO_TURBO_HDR_NIGHT");
        }
        if (commonApsTeleCapture) {
            setCommonApsPair(pairs, "capture_master_pipeline", "2");
            setCommonApsPair(pairs, "previewdecision_sensor_mode", "0");
            setCommonApsPair(pairs, "previewdecision_sensor_mode_list",
                    "[3, -1, 2, 0, -1, -1, -1, -1]");
            setCommonApsPair(pairs, "meta_index", "7");
            setCommonApsPair(pairs, "hal_base_frame_index", "7");
            setCommonApsPair(pairs, "captureStreamNumber", "1");
            setCommonApsPair(pairs, "process_aidl_bpc", "0");
            setCommonApsPair(pairs, "case_algo_name",
                    "ALGO_TURBO_HDR_NIGHT");
            setCommonApsPair(pairs, "sat_open", "1");
            setCommonApsPair(pairs, "key_is_telephoto", "false");
        }
        return pairs;
    }

    private static void applyPortraitApsParameterOverrides(
            String[] pairs) {
        setCommonApsPair(pairs, "capture_mode", "portrait");
        setCommonApsPair(pairs, "operation_mode",
                String.valueOf(OPLUS_PORTRAIT_TELE_OP_MODE));
        setCommonApsPair(pairs, "capture_master_pipeline", "2");
        setCommonApsPair(pairs, "previewdecision_sensor_mode", "0");
        setCommonApsPair(pairs, "previewdecision_sensor_mode_list",
                "[-1, -1, -1, 0, -1, -1, -1, -1]");
        setCommonApsPair(pairs, "process_aidl_bpc", "0");
        setCommonApsPair(pairs, "captureStreamNumber", "");
        setCommonApsPair(pairs, "case_algo_name",
                "ALGO_BOKEH_TURBO_HDR_DAYTIME");
        setCommonApsPair(pairs, "portrait_support_zoom_crop", "true");
        setCommonApsPair(pairs, "preview_width", "1280");
        setCommonApsPair(pairs, "preview_height", "960");
        setCommonApsPair(pairs, "rtb_enable", "1");
        setCommonApsPair(pairs, "blur_edit_enable", "true");
        setCommonApsPair(pairs, "blur_value", "27");
        setCommonApsPair(pairs, "blur_show", "5.0");
        setCommonApsPair(pairs, "blur_apertures_list",
                "[16.0, 14.0, 13.0, 11.0, 10.0, 9.0, 8.0, 7.1, 6.3,"
                        + " 5.6, 5.0, 4.5, 4.0, 3.5, 3.2, 2.8, 2.5, 2.2,"
                        + " 2.0, 1.8, 1.6, 1.4]");
        setCommonApsPair(pairs, "blur_value_list",
                "[3.0, 5.0, 7.0, 12.0, 14.0, 16.0, 18.0, 20.0, 22.0,"
                        + " 24.0, 27.0, 32.0, 38.0, 45.0, 51.0, 60.0,"
                        + " 69.0, 78.0, 84.0, 91.0, 96.0, 100.0]");
        setCommonApsPair(pairs, "sat_open", "0");
        setCommonApsPair(pairs, "group_photo_support", "0");
        setCommonApsPair(pairs, "meta_index", "1");
        setCommonApsPair(pairs, "hal_base_frame_index", "1");
        setCommonApsPair(pairs, "zsl_frame_cnt", "4");
        setCommonApsPair(pairs, "zoom_focal_length", "-1");
    }

    private static String[] commonApsActiveProcessAlgorithms() {
        if (commonApsPortraitCapture) {
            return PORTRAIT_APS_PROCESS_ALGORITHMS;
        }
        if (commonApsTeleCapture) {
            return COMMON_APS_TELE_PROCESS_ALGORITHMS;
        }
        return commonApsUltraWideCapture
                ? COMMON_APS_ULTRAWIDE_PROCESS_ALGORITHMS
                : COMMON_APS_PROCESS_ALGORITHMS;
    }

    private static Object newCommonApsParameters(String[] pairs)
            throws Throwable {
        ClassLoader apsLoader = oplusApsClassLoader;
        Class<?> parametersClass = Class.forName(
                "com.oplus.ocs.camera.consumer.apsAdapter.adapter."
                        + "ApsParameters", true, apsLoader);
        Object parameters = parametersClass.getConstructor().newInstance();
        for (int i = 0; i + 1 < pairs.length; i += 2) {
            XposedHelpers.callMethod(parameters, "set",
                    pairs[i], pairs[i + 1]);
        }
        return parameters;
    }

    private static boolean beginCommonApsCapture(
            CaptureRequest original, CommonApsDecision decision) {
        synchronized (COMMON_APS_LOCK) {
            if (!commonApsReady || commonApsDisabled
                    || commonApsClient == null
                    || commonApsCaptureInFlight
                    || decision == null
                    || !decision.isSupportedCommonCapture()) {
                if (commonApsCaptureInFlight) {
                    log("[CommonAPS] prior APS result still pending; current"
                            + " Xiaomi JPEG is not expanded");
                }
                return false;
            }
            try {
                closeCommonApsImagesLocked();
                COMMON_APS_FRAMES.clear();
                commonApsExpectedFrameCount = decision.frameCount;
                commonApsBracketMode = decision.bracketMode;
                commonApsSuperNightScene = decision.superNightScene;
                commonApsTurboRawScene = decision.turboRawScene;
                commonApsFeatureType = decision.featureType;
                commonApsAisState = decision.aisState;
                commonApsEvList = Arrays.copyOf(decision.evList, 20);
                commonApsUltraWideCapture =
                        decision.isUltraWideSingleRaw();
                commonApsTeleCapture = decision.isTeleSingleRaw();
                commonApsPortraitCapture =
                        decision.isPortraitDualRaw();
                Integer orientation = original.get(
                        CaptureRequest.JPEG_ORIENTATION);
                commonApsOrientation = orientation == null ? 0
                        : ((orientation % 360) + 360) % 360;
                Float zoomRatio = original.get(
                        CaptureRequest.CONTROL_ZOOM_RATIO);
                commonApsZoomRatio = commonApsUltraWideCapture ? 0.6f
                        : zoomRatio == null
                        || !Float.isFinite(zoomRatio)
                        ? 1.0f : Math.max(0.6f,
                        Math.min(20.0f, zoomRatio));
                commonApsAvailableMemory = 0L;
                try {
                    ActivityManager manager = (ActivityManager)
                            xiaomiCameraApplication.getSystemService(
                                    Context.ACTIVITY_SERVICE);
                    ActivityManager.MemoryInfo memory =
                            new ActivityManager.MemoryInfo();
                    manager.getMemoryInfo(memory);
                    commonApsAvailableMemory = memory.availMem;
                } catch (Throwable ignored) {
                    // Zero is accepted by APS if the memory service is absent.
                }
                commonAuxYuvDrainCount = 0;
                // Stock does not invent an identity before Camera2 starts.
                // ApsProcessor locks the merge identity to the first sensor
                // timestamp and only frame/process parameters carry it.
                commonApsIdentity = -1L;
                commonApsPictureTimeMillis = System.currentTimeMillis();
                commonApsPictureTitle = "IMG" +
                        new java.text.SimpleDateFormat(
                                "yyyyMMddHHmmss", Locale.US)
                                .format(new java.util.Date(
                                        commonApsPictureTimeMillis));
                commonApsCaptureGeneration++;
                int generation = commonApsCaptureGeneration;
                int clientGeneration = commonApsClientGeneration;
                commonApsSubmitScheduled = false;
                COMMON_APS_OUTPUT_HANDLED.set(false);
                boolean singleRaw = commonApsUltraWideCapture
                        || commonApsTeleCapture;
                String[] startPairs = dynamicCommonApsLifecyclePairs(
                        singleRaw
                                ? commonApsUltraWideStartParameterReference
                                : commonApsStartParameterReference, true);
                String[] beforePairs = dynamicCommonApsLifecyclePairs(
                        singleRaw
                                ? commonApsUltraWideBeforeParameterReference
                                : commonApsBeforeParameterReference, false);
                Object started = XposedHelpers.callMethod(
                        commonApsClient, "startCapture",
                        newCommonApsParameters(startPairs));
                Object before = XposedHelpers.callMethod(
                        commonApsClient, "beforeCapture",
                        newCommonApsParameters(beforePairs));
                commonApsCaptureInFlight = true;
                commonApsCollecting = true;
                Handler handler = commonApsHandler;
                if (handler != null) {
                    handler.postDelayed(() -> {
                        synchronized (COMMON_APS_LOCK) {
                            if (!commonApsCaptureInFlight
                                    || generation !=
                                    commonApsCaptureGeneration) {
                                return;
                            }
                        }
                        invalidateCommonApsClient(
                                "capture-timeout-" + generation,
                                clientGeneration);
                        restoreActiveHandoff("capture-timeout");
                    }, COMMON_APS_CAPTURE_TIMEOUT_MS);
                }
                // ColorOS' ApsCaptureAdapterImpl deliberately discards both
                // return values.  On this vendor build beforeCapture may
                // return -1 even though the subsequent frame/process path is
                // valid, so only thrown exceptions are fatal here.
                log("[CommonAPS] start/before identity=pending-first-sensor"
                        + " pairs=" + startPairs.length / 2 + "/"
                        + beforePairs.length / 2
                        + " results=" + started + "/"
                        + before + " orientation=" + commonApsOrientation
                        + " zoom=" + commonApsZoomRatio
                        + " decision=" + decision.source + "/frames="
                        + commonApsExpectedFrameCount + "/bracket="
                        + commonApsBracketMode + "/ais="
                        + commonApsAisState + "/topology="
                        + (commonApsUltraWideCapture
                        ? "UW-singleRAW" : commonApsTeleCapture
                        ? "tele-singleRAW" : commonApsPortraitCapture
                        ? "portrait-dualRAW" : "common-2DOL"));
                return true;
            } catch (Throwable throwable) {
                commonApsCaptureInFlight = false;
                commonApsCollecting = false;
                commonApsSubmitScheduled = false;
                commonApsUltraWideCapture = false;
                commonApsTeleCapture = false;
                commonApsPortraitCapture = false;
                try {
                    XposedHelpers.callMethod(commonApsClient,
                            "abortCaptures");
                } catch (Throwable ignored) {
                    // The original Xiaomi request is still safe to submit.
                }
                closeCommonApsImagesLocked();
                COMMON_APS_FRAMES.clear();
                log("[CommonAPS] start/before failed: " + throwable);
                return false;
            }
        }
    }

    private static void submitCommonApsFrames() {
        int frameCount = commonApsExpectedFrameCount;
        boolean ultraWide = commonApsUltraWideCapture;
        boolean tele = commonApsTeleCapture;
        boolean singleRaw = ultraWide || tele;
        boolean portrait = commonApsPortraitCapture;
        CommonApsFrame[] ordered =
                new CommonApsFrame[frameCount];
        synchronized (COMMON_APS_LOCK) {
            if (!commonApsCaptureInFlight || !commonApsSubmitScheduled) {
                return;
            }
            for (CommonApsFrame frame : COMMON_APS_FRAMES.values()) {
                if (frame.isComplete()) {
                    ordered[frame.index - 1] = frame;
                }
            }
            for (CommonApsFrame frame : ordered) {
                if (frame == null) {
                    abortCommonApsCapture(
                            "complete-frame-set-became-sparse", true);
                    restoreActiveHandoff("sparse-frame-set");
                    return;
                }
            }
            long firstSensorTimestamp = ordered[0].timestamp;
            if (commonApsIdentity != firstSensorTimestamp) {
                log("[CommonAPS] correcting merge identity "
                        + commonApsIdentity + " -> first input timestamp "
                        + firstSensorTimestamp);
                commonApsIdentity = firstSensorTimestamp;
            }
            for (CommonApsFrame frame : ordered) {
                COMMON_APS_RETAINED_INPUTS.add(frame.main);
                if (!singleRaw) {
                    COMMON_APS_RETAINED_INPUTS.add(frame.dol);
                }
                COMMON_APS_RETAINED_INPUTS.add(frame.captureMeta);
            }
            COMMON_APS_FRAMES.clear();
        }
        try {
            int submitted = 0;
            for (CommonApsFrame frame : ordered) {
                HardwareBuffer metadataBuffer =
                        frame.captureMeta.getHardwareBuffer();
                if (metadataBuffer == null || metadataBuffer.isClosed()) {
                    throw new IllegalStateException(
                            "capture-meta HardwareBuffer unavailable index="
                                    + frame.index);
                }
                String[] frameParameters = dynamicCommonApsPairs(
                        singleRaw
                                ? commonApsUltraWideFrameParameterReference
                                : commonApsFrameParameterReference,
                        frame.result);
                submitCommonApsImage(frame.main,
                        portrait ? portraitMainRawReader
                                : commonRawMainReader,
                        frame.result.getFrameNumber(), frame.result,
                        frameParameters,
                        "surface_key_picture", metadataBuffer,
                        portrait ? 0 : tele ? 3 : ultraWide ? 2 : 0,
                        portrait ? 4 : tele ? 3 : ultraWide ? 2 : 0);
                submitted++;
                if (!singleRaw) {
                    submitCommonApsImage(frame.dol,
                            portrait ? portraitAuxRawReader
                                    : commonRawDolReader,
                            frame.result.getFrameNumber(), frame.result,
                            frameParameters,
                            portrait ? "surface_key_picture"
                                    : "surface_key_picture_dol",
                            metadataBuffer,
                            portrait ? 2 : 0,
                            portrait ? 2 : 0);
                    submitted++;
                }
                log("[CommonAPS] addFrameBuff index=" + frame.index
                        + " timestamp=" + frame.timestamp
                        + " cameraFrame="
                        + frame.result.getFrameNumber()
                        + " meta="
                        + describeCommonApsHardwareBuffer(metadataBuffer)
                        + " submitted=" + submitted + "/"
                        + (frameCount * (singleRaw ? 1 : 2)));
            }
            String[] processParameters = dynamicCommonApsPairs(
                    singleRaw
                            ? commonApsUltraWideProcessParameterReference
                            : commonApsProcessParameterReference,
                    ordered[0].result);
            Object processed = invokeMethodByCount(commonApsClient,
                    "processImages", 7, processParameters,
                    commonApsActiveProcessAlgorithms().clone(),
                    commonApsAlgoObject, commonApsWatermark,
                    null, null, null);
            log("[CommonAPS] processImages submitted result=" + processed
                    + " identity=" + commonApsIdentity
                    + " inputs=" + (frameCount * (singleRaw ? 1 : 2))
                    + " contract=" + (portrait
                    ? "portrait-dualRAW" : ultraWide
                    ? "UW-singleRAW" : tele
                    ? "tele-singleRAW" : "2DOL") + " bracket="
                    + commonApsBracketMode);
            // Input ownership has moved to APS, but the framework streams and
            // metadata sink must stay alive through R2R -> Y2Y -> Y2J.  The
            // output callback (or timeout/error path) restores Xiaomi.
        } catch (Throwable throwable) {
            log("[CommonAPS] frame/process transfer failed: "
                    + throwable);
            XposedBridge.log(throwable);
            abortCommonApsCapture("process-transfer-failed", true);
            restoreActiveHandoff("process-transfer-failed");
        }
    }

    private static void submitCommonApsImage(Image image,
            ImageReader reader, long frameNumber,
            TotalCaptureResult metadata, String[] parameters,
            String surfaceUsage,
            HardwareBuffer metadataBuffer, int streamRole,
            int physicalCameraId) throws Throwable {
        ClassLoader apsLoader = oplusApsClassLoader;
        HardwareBuffer hardwareBuffer = image.getHardwareBuffer();
        Class<?> imageBufferClass = Class.forName(
                "com.oplus.ocs.camera.consumer.apsAdapter.adapter."
                        + "ApsResult$ImageBuffer", true, apsLoader);
        Object imageBuffer = imageBufferClass.getConstructor(
                ImageReader.class, Image.class, HardwareBuffer.class,
                long.class, int.class, String.class, String.class,
                int.class).newInstance(reader, image, hardwareBuffer,
                image.getTimestamp(), 0, null, surfaceUsage,
                ImageFormat.RAW10);

        Class<?> captureParamClass = Class.forName(
                "com.oplus.ocs.camera.consumer.apsAdapter.adapter."
                        + "ApsCaptureParam", true, apsLoader);
        Constructor<?> constructor = null;
        for (Constructor<?> candidate
                : captureParamClass.getConstructors()) {
            if (candidate.getParameterTypes().length == 24) {
                constructor = candidate;
                break;
            }
        }
        if (constructor == null) {
            throw new NoSuchMethodException(
                    "ApsCaptureParam 24-argument constructor");
        }
        String evList = Arrays.toString(commonApsEvList);
        Object captureParam = constructor.newInstance(
                frameNumber, imageBuffer,
                streamRole, physicalCameraId, 0, null, null, null,
                null, null, false, 21, 0, false, false, 0,
                "0", evList, false, 0, "", 0, "", metadataBuffer);
        Object result = invokeMethodByCount(commonApsClient,
                "addFrameBuff", 4, captureParam, parameters,
                commonApsActiveProcessAlgorithms().clone(),
                commonApsWatermark);
        log("[CommonAPS] native addFrame ack=" + result
                + " frame=" + frameNumber
                + " timestamp=" + image.getTimestamp()
                + " usage=" + surfaceUsage
                + " role=" + streamRole
                + " physical=" + physicalCameraId
                + " imageBuffer=" + imageBuffer);
        if (result instanceof Number
                && ((Number) result).intValue() < 0) {
            throw new IllegalStateException("addFrameBuff "
                    + surfaceUsage + " returned " + result);
        }
    }

    private static Object invokeMethodByCount(Object target, String name,
            int parameterCount, Object... args) throws Throwable {
        for (java.lang.reflect.Method method
                : target.getClass().getMethods()) {
            if (name.equals(method.getName())
                    && method.getParameterTypes().length == parameterCount) {
                method.setAccessible(true);
                try {
                    return method.invoke(target, args);
                } catch (java.lang.reflect.InvocationTargetException error) {
                    throw error.getCause() == null ? error
                            : error.getCause();
                }
            }
        }
        throw new NoSuchMethodException(name + "/" + parameterCount);
    }

    private static void onCommonApsCaptureReceived(Object result) {
        Object imageBuffer = null;
        Object image = null;
        try {
            image = XposedHelpers.callMethod(result, "getImage");
            imageBuffer = XposedHelpers.callMethod(result,
                    "getImageBuffer");
            Object copy = XposedHelpers.getObjectField(result,
                    "mCopyBuffer");
            Object hardwareObject = XposedHelpers.getObjectField(result,
                    "mHwbuffer");
            if (!(hardwareObject instanceof HardwareBuffer)
                    && imageBuffer != null) {
                try {
                    hardwareObject = XposedHelpers.callMethod(imageBuffer,
                            "getHardwareBuffer");
                } catch (Throwable ignored) {
                    // Some callbacks expose the output only in mHwbuffer.
                }
            }
            if (!(copy instanceof byte[])
                    && hardwareObject instanceof HardwareBuffer
                    && ensureCommonApsJpegNativeLoaded()) {
                try {
                    byte[] hardwareJpeg =
                            nativeCopyApsJpegFromHardwareBuffer(
                                    (HardwareBuffer) hardwareObject);
                    if (isJpegBytes(hardwareJpeg)) {
                        copy = hardwareJpeg;
                        log("[CommonAPS] copied JPEG BLOB bytes="
                                + hardwareJpeg.length);
                    }
                } catch (Throwable throwable) {
                    // A returned capture buffer is terminal even when an OEM
                    // allocator cannot be mapped.  Recovery below must still
                    // restore Xiaomi immediately instead of waiting 30 s.
                    log("[CommonAPS] JPEG BLOB copy failed: " + throwable);
                }
            }
            int width = XposedHelpers.getIntField(result, "mWidth");
            int height = XposedHelpers.getIntField(result, "mHeight");
            int bufferType = XposedHelpers.getIntField(result,
                    "mBufferType");
            int rotation = XposedHelpers.getIntField(result, "mRotation");
            long identity = XposedHelpers.getLongField(result,
                    "mIdentity");
            int byteCount = copy instanceof byte[]
                    ? ((byte[]) copy).length : -1;
            Object messageType = safeCommonApsResultField(result,
                    "mMessageType");
            Object pipelineName = safeCommonApsResultField(result,
                    "mPipelineName");
            Object captureError = safeCommonApsResultField(result,
                    "mCaptureErrorCode");
            Object frameworkError = safeCommonApsResultField(result,
                    "mFrameworkErrorCode");
            Object heifInAps = safeCommonApsResultField(result,
                    "mbHeifProcessInAps");
            Object dngInAps = safeCommonApsResultField(result,
                    "mbDngProcessInAps");
            Object outputCount = safeCommonApsResultField(result,
                    "mOutputPictureCount");
            Object outputIndex = safeCommonApsResultField(result,
                    "mOutputPictureIndex");
            Object resultStrings = safeCommonApsResultField(result,
                    "mResultString");
            Object resultMap = safeCommonApsResultField(result,
                    "mResultMap");
            String hardwareDescription = hardwareObject
                    instanceof HardwareBuffer
                    ? describeCommonApsHardwareBuffer(
                    (HardwareBuffer) hardwareObject)
                    : String.valueOf(hardwareObject);
            log("[CommonAPS] OUTPUT identity=" + identity
                    + " messageType=" + messageType
                    + " pipeline=" + pipelineName
                    + " bufferType=" + bufferType + " size=" + width
                    + "x" + height + " rotation=" + rotation
                    + " copyBytes=" + byteCount + " image=" + image
                    + " imageBuffer=" + imageBuffer
                    + " hardware=" + hardwareDescription
                    + " output=" + outputIndex + "/" + outputCount
                    + " heifInAps=" + heifInAps
                    + " dngInAps=" + dngInAps
                    + " captureError=" + captureError
                    + " frameworkError=" + frameworkError);
            log("[CommonAPS] OUTPUT resultStrings="
                    + compactCommonApsResultValue(resultStrings, 6000)
                    + " resultMap="
                    + compactCommonApsResultValue(resultMap, 6000));
            boolean validJpeg = copy instanceof byte[]
                    && isJpegBytes((byte[]) copy);
            boolean captureOutput = messageType instanceof Number
                    && ((Number) messageType).intValue() == 1;
            if ((validJpeg || captureOutput)
                    && COMMON_APS_OUTPUT_HANDLED.compareAndSet(
                    false, true)) {
                 try {
                     if (validJpeg) {
                          if (COMMON_APS_SHUTTER_HANDOFF_STARTED.get()
                                  && COMMON_APS_SHUTTER_ARMED.get()) {
                              byte[] deliveredJpeg = (byte[]) copy;
                              synchronized (COMMON_APS_SHUTTER_LOCK) {
                                  commonApsShutterJpeg = deliveredJpeg;
                                  commonApsShutterFailure = null;
                                  COMMON_APS_SHUTTER_LOCK.notifyAll();
                              }
                              boolean loopedBack = false;
                              if (commonApsUnifiedSessionActive) {
                                  loopedBack =
                                          queueUnifiedApsJpegToXiaomiReader(
                                                  deliveredJpeg,
                                                  commonApsShutterTimestamp);
                              }
                              log("[ApsShutter] APS JPEG delivered to Xiaomi"
                                      + " Rh.r bytes="
                                      + deliveredJpeg.length
                                      + " identity=" + identity
                                      + " size=" + width + "x" + height
                                      + " loopback=" + loopedBack);
                         } else {
                             saveCommonApsProofJpeg((byte[]) copy,
                                     width, height, identity);
                         }
                     } else {
                         log("[CommonAPS] terminal capture output contained"
                                 + " no readable JPEG; restoring Xiaomi");
                         failCommonApsShutter(
                                 "terminal-output-without-readable-jpeg");
                     }
                 } catch (Throwable throwable) {
                     log("[CommonAPS] proof JPEG save failed: " + throwable);
                     failCommonApsShutter(
                             "output-delivery-failed: " + throwable);
                 } finally {
                    finishCommonApsCapture("output-received");
                    restoreActiveHandoff("aps-output-received");
                }
            }
        } catch (Throwable throwable) {
            log("[CommonAPS] output inspection failed: " + throwable);
            XposedBridge.log(throwable);
        } finally {
            try {
                if (imageBuffer != null) {
                    XposedHelpers.callMethod(imageBuffer, "close");
                } else if (image instanceof Image) {
                    ((Image) image).close();
                }
            } catch (Throwable ignored) {
                // Output ownership has ended even if close is idempotent.
            }
        }
    }

    private static Object safeCommonApsResultField(Object result,
            String fieldName) {
        try {
            return XposedHelpers.getObjectField(result, fieldName);
        } catch (Throwable throwable) {
            return "<unavailable:" + throwable.getClass().getSimpleName()
                    + ">";
        }
    }

    private static String describeCommonApsHardwareBuffer(
            HardwareBuffer buffer) {
        try {
            return "HardwareBuffer{" + buffer.getWidth() + "x"
                    + buffer.getHeight() + ",layers="
                    + buffer.getLayers() + ",format="
                    + buffer.getFormat() + ",usage="
                    + buffer.getUsage() + ",closed="
                    + buffer.isClosed() + "}";
        } catch (Throwable throwable) {
            return "HardwareBuffer{inspectFailed=" + throwable + "}";
        }
    }

    private static String compactCommonApsResultValue(Object value,
            int maximumLength) {
        String text;
        if (value instanceof Object[]) {
            text = Arrays.deepToString((Object[]) value);
        } else {
            text = String.valueOf(value);
        }
        if (text.length() <= maximumLength) {
            return text;
        }
        return text.substring(0, maximumLength) + "...<truncated "
                + (text.length() - maximumLength) + " chars>";
    }

    private static boolean isJpegBytes(byte[] bytes) {
        return bytes != null && bytes.length >= 4
                && (bytes[0] & 0xff) == 0xff
                && (bytes[1] & 0xff) == 0xd8
                && (bytes[bytes.length - 2] & 0xff) == 0xff
                && (bytes[bytes.length - 1] & 0xff) == 0xd9;
    }

    private static void saveCommonApsProofJpeg(byte[] jpeg,
            int width, int height, long identity) throws Exception {
        Application application = xiaomiCameraApplication;
        if (application == null) {
            throw new IllegalStateException("Xiaomi application unavailable");
        }
        // This is an internal contract probe, not a user photograph.  The
        // stock APS watermark contract may resolve a Hasselblad style while
        // we prove R2R/Y2Y/Y2J, so never publish the proof into DCIM or
        // MediaStore.  The eventual production path receives an unwatermarked
        // APS base and applies Xiaomi's existing watermark afterwards.
        // Xiaomi periodically wipes its cache directory after a Camera2
        // session rebuild.  Keep the one-shot proof in private files until
        // the host has inspected and removed it; production never depends on
        // this file or on any other /data artifact.
        File cameraDirectory = new File(application.getFilesDir(),
                "os4_aps_proof");
        if (!cameraDirectory.exists() && !cameraDirectory.mkdirs()) {
            throw new IllegalStateException(
                    "cannot create " + cameraDirectory);
        }
        String title = commonApsPictureTitle == null
                ? "IMG_APS_" + identity : commonApsPictureTitle;
        File output = new File(cameraDirectory,
                title + "_APS_PROOF.jpg");
        try (FileOutputStream stream = new FileOutputStream(output)) {
            stream.write(jpeg);
            stream.getFD().sync();
        }
        log("[CommonAPS] internal proof JPEG saved path=" + output
                + " bytes=" + jpeg.length + " declared=" + width
                + "x" + height);
    }

    private static synchronized boolean
            ensureCommonApsJpegNativeLoaded() {
        if (commonApsJpegNativeLoaded) {
            return true;
        }
        if (commonApsJpegNativeLoadAttempted) {
            return false;
        }
        commonApsJpegNativeLoadAttempted = true;
        try {
            String apkPath = moduleApkPath;
            File codeDirectory = apkPath == null
                    ? null : new File(apkPath).getParentFile();
            File library = codeDirectory == null ? null
                    : new File(new File(codeDirectory, "lib/arm64"),
                    "libos4apsjpeg.so");
            if (library == null || !library.isFile()) {
                String description = String.valueOf(
                        HookEntry.class.getClassLoader());
                String marker = "module=";
                int start = description.indexOf(marker);
                int end = start < 0 ? -1
                        : description.indexOf("/base.apk", start);
                if (start >= 0 && end >= 0) {
                    String resolvedApk = description.substring(
                            start + marker.length(),
                            end + "/base.apk".length());
                    File resolvedDirectory = new File(resolvedApk)
                            .getParentFile();
                    library = resolvedDirectory == null ? null
                            : new File(new File(resolvedDirectory,
                            "lib/arm64"), "libos4apsjpeg.so");
                }
            }
            if (library == null || !library.isFile()
                    || library.length() == 0L) {
                throw new IllegalStateException(
                        "module JPEG JNI unavailable: " + library);
            }
            System.load(library.getAbsolutePath());
            commonApsJpegNativeLoaded = true;
            log("[CommonAPS] JPEG BLOB copier loaded " + library);
            return true;
        } catch (Throwable throwable) {
            log("[CommonAPS] JPEG BLOB copier load failed: "
                    + throwable);
            return false;
        }
    }

    private static native byte[] nativeCopyApsJpegFromHardwareBuffer(
            HardwareBuffer buffer);

    private static native int nativeQueueJpegToSurface(
            Surface surface, byte[] jpeg, long timestamp);

    private static void finishCommonApsCapture(String reason) {
        synchronized (COMMON_APS_LOCK) {
            commonApsCaptureGeneration++;
            commonApsCaptureInFlight = false;
            commonApsCollecting = false;
            commonApsSubmitScheduled = false;
            commonApsUltraWideCapture = false;
            commonApsTeleCapture = false;
            commonApsPortraitCapture = false;
            COMMON_APS_FRAMES.clear();
            closeCommonApsImagesLocked();
        }
        log("[CommonAPS] capture finished reason=" + reason);
    }

    private static void abortCommonApsCapture(String reason,
            boolean notifyNative) {
        Object client;
        boolean hadCapture;
        synchronized (COMMON_APS_LOCK) {
            hadCapture = commonApsCaptureInFlight
                    || commonApsCollecting
                    || !COMMON_APS_FRAMES.isEmpty()
                    || !COMMON_APS_RETAINED_INPUTS.isEmpty();
            commonApsCaptureGeneration++;
            commonApsCaptureInFlight = false;
            commonApsCollecting = false;
            commonApsSubmitScheduled = false;
            commonApsUltraWideCapture = false;
            commonApsTeleCapture = false;
            commonApsPortraitCapture = false;
            client = commonApsClient;
        }
        if (notifyNative && client != null && hadCapture) {
            try {
                XposedHelpers.callMethod(client, "abortCaptures");
            } catch (Throwable throwable) {
                log("[CommonAPS] native abort warning: " + throwable);
            }
        }
        synchronized (COMMON_APS_LOCK) {
            closeCommonApsImagesLocked();
            COMMON_APS_FRAMES.clear();
        }
        if (hadCapture) {
            log("[CommonAPS] capture aborted reason=" + reason);
        }
    }

    private static void closeCommonApsImagesLocked() {
        for (CommonApsFrame frame : COMMON_APS_FRAMES.values()) {
            closeImageQuietly(frame.main);
            closeImageQuietly(frame.dol);
            closeImageQuietly(frame.captureMeta);
        }
        COMMON_APS_FRAMES.clear();
        for (Image image : COMMON_APS_RETAINED_INPUTS) {
            closeImageQuietly(image);
        }
        COMMON_APS_RETAINED_INPUTS.clear();
    }

    private static void closeImageQuietly(Image image) {
        if (image == null) {
            return;
        }
        try {
            image.close();
        } catch (Throwable ignored) {
            // Image close is idempotent on the framework implementation.
        }
    }

    /**
     * Keep a read-only identity map between framework surfaces and the
     * ImageReaders which created them.  SurfaceUtils exposes the negotiated
     * size/format/usage, while ImageReader adds maxImages and the public
     * buffer format.  Nothing in this hook changes a reader or surface.
     */
    private static void hookSessionImageReaderRegistry() {
        XposedBridge.hookAllMethods(ImageReader.class, "newInstance",
                new XC_MethodHook() {
                    @Override
                    protected void beforeHookedMethod(MethodHookParam param) {
                        if (activeCameraModule != 171 || param.args == null
                                || param.args.length < 4
                                || !(param.args[0] instanceof Integer)
                                || !(param.args[1] instanceof Integer)
                                || !(param.args[2] instanceof Integer)
                                || ((Integer) param.args[2])
                                != XIAOMI_PORTRAIT_DEPTH_FORMAT) {
                            return;
                        }
                        // The OnePlus 13 logical camera publishes no Y16
                        // stream at all. ColorOS portrait instead carries a
                        // 1280x960 YUV auxiliary stream; retain Xiaomi's
                        // depth callback slot while giving CameraService a
                        // stream it can actually configure.
                        param.args[0] = 1280;
                        param.args[1] = 960;
                        param.args[2] = ImageFormat.YUV_420_888;
                        log("[PortraitDepthContract] Y16 "
                                + XIAOMI_PORTRAIT_DEPTH_FORMAT
                                + " replaced by ColorOS auxiliary YUV"
                                + " 1280x960");
                    }

                    @Override
                    protected void afterHookedMethod(MethodHookParam param) {
                        if (!(param.getResult() instanceof ImageReader)) {
                            return;
                        }
                        try {
                            ImageReader reader =
                                    (ImageReader) param.getResult();
                            Surface surface = reader.getSurface();
                            String spec = reader.getWidth() + "x"
                                    + reader.getHeight() + "/fmt"
                                    + reader.getImageFormat() + "/max"
                                    + reader.getMaxImages() + "/usage"
                                    + reader.getUsage();
                            SESSION_PROBE_READERS.put(surface, spec);
                            if (SESSION_PROBE_READERS.size() <= 80) {
                                log("[StreamSpec] ImageReader " + spec
                                        + " surface=" + surface);
                            }
                        } catch (Throwable throwable) {
                            log("[StreamSpec] ImageReader inspect failed: "
                                    + throwable);
                        }
                    }
                });
    }

    /**
     * CameraUnit does not use Xiaomi's sh.b wrapper, so observe the common
     * framework methods in the stock OPlus process.  Logging both the
     * high-level create call and configureStreamsChecked gives us the exact
     * output set and operation mode which the OnePlus HAL accepts.
     */
    private static void hookOplusFrameworkSessionProbe() {
        hookSessionImageReaderRegistry();
        Class<?> device = XposedHelpers.findClass(
                "android.hardware.camera2.impl.CameraDeviceImpl", null);
        XC_MethodHook probe = new XC_MethodHook() {
            @Override
            protected void beforeHookedMethod(MethodHookParam param) {
                int ordinal = OPLUS_REFERENCE_SESSION_COUNT
                        .incrementAndGet();
                if (ordinal > 24) {
                    return;
                }
                String method = param.method == null ? "unknown"
                        : param.method.getName();
                if (OPLUS_MINIMAL_GRAPH_TEST
                        && "createCaptureSessionInternal".equals(method)) {
                    reduceOplusCommonGraphForTest(param);
                }
                log("[OplusSessionSpec] #" + ordinal + " method="
                        + method + " argc="
                        + (param.args == null ? 0 : param.args.length));
                if (param.args == null) {
                    return;
                }
                for (int index = 0; index < param.args.length; index++) {
                    Object argument = param.args[index];
                    if (argument instanceof List<?>
                            && containsOutputConfiguration(
                            (List<?>) argument)) {
                        logConfiguredOutputs("[OplusSessionSpec] #"
                                        + ordinal + " arg" + index,
                                (List<?>) argument);
                        continue;
                    }
                    if (argument != null && argument.getClass().getName()
                            .equals("android.hardware.camera2.params."
                                    + "SessionConfiguration")) {
                        try {
                            Object outputs = XposedHelpers.callMethod(
                                    argument, "getOutputConfigurations");
                            Object sessionType = XposedHelpers.callMethod(
                                    argument, "getSessionType");
                            log("[OplusSessionSpec] #" + ordinal
                                    + " arg" + index + " sessionType="
                                    + sessionType);
                            if (outputs instanceof List<?>) {
                                logConfiguredOutputs(
                                        "[OplusSessionSpec] #" + ordinal
                                                + " sessionConfig",
                                        (List<?>) outputs);
                            }
                        } catch (Throwable throwable) {
                            log("[OplusSessionSpec] SessionConfiguration"
                                    + " inspect failed: " + throwable);
                        }
                        continue;
                    }
                    if (argument instanceof Integer
                            || argument instanceof Long
                            || argument instanceof String
                            || argument instanceof CaptureRequest
                            || (argument != null && argument.getClass()
                            .getName().contains("InputConfiguration"))) {
                        log("[OplusSessionSpec] #" + ordinal + " arg"
                                + index + "=" + argument + " class="
                                + argument.getClass().getName());
                        if (argument instanceof CaptureRequest
                                && OPLUS_REFERENCE_SESSION_PARAMS_DUMPED
                                .compareAndSet(false, true)) {
                            dumpOplusSessionRequestParcel(
                                    (CaptureRequest) argument);
                            logCaptureRequestKeyMap(
                                    "[OplusSessionParam]",
                                    (CaptureRequest) argument);
                        }
                    }
                }
            }
        };
        XposedBridge.hookAllMethods(device,
                "createCaptureSessionInternal", probe);
        XposedBridge.hookAllMethods(device,
                "configureStreamsChecked", probe);
        log("[OplusSessionSpec] CameraDeviceImpl probe active; minimalTest="
                + OPLUS_MINIMAL_GRAPH_TEST);
    }

    /**
     * Preserve the exact targetless stock ColorOS session request using the
     * framework's own Parcelable representation. This is a temporary
     * reference artifact: after validation its bytes are embedded in the
     * module, so the finished bridge has no /data dependency.
     */
    private static void dumpOplusSessionRequestParcel(
            CaptureRequest request) {
        if (!OPLUS_REFERENCE_SESSION_PARCEL_DUMPED
                .compareAndSet(false, true)) {
            return;
        }
        Parcel parcel = Parcel.obtain();
        try {
            request.writeToParcel(parcel, 0);
            byte[] bytes = parcel.marshall();
            File output = new File(
                    "/data/user/0/com.oplus.camera/files/"
                            + "os4_oplus_session_params.parcel");
            File parent = output.getParentFile();
            if (parent != null && !parent.exists() && !parent.mkdirs()) {
                throw new IllegalStateException(
                        "cannot create " + parent);
            }
            try (FileOutputStream stream = new FileOutputStream(output)) {
                stream.write(bytes);
                stream.getFD().sync();
            }
            log("[OplusSessionParcel] saved bytes=" + bytes.length
                    + " sha256=" + sha256(bytes)
                    + " path=" + output);
        } catch (Throwable throwable) {
            log("[OplusSessionParcel] save failed: " + throwable);
            XposedBridge.log(throwable);
        } finally {
            parcel.recycle();
        }
    }

    @SuppressWarnings("unchecked")
    private static void reduceOplusCommonGraphForTest(
            XC_MethodHook.MethodHookParam param) {
        if (param.args == null || param.args.length < 5
                || !(param.args[1] instanceof List<?>)) {
            return;
        }
        List<?> original = (List<?>) param.args[1];
        Object mode = param.args[4];
        if (original.size() != 9 || !(mode instanceof Integer)
                || ((Integer) mode) != 0x8001) {
            return;
        }
        ArrayList<OutputConfiguration> minimal = new ArrayList<>(4);
        for (Object item : original) {
            if (!(item instanceof OutputConfiguration)) {
                continue;
            }
            OutputConfiguration output = (OutputConfiguration) item;
            Surface surface;
            try {
                surface = output.getSurface();
            } catch (Throwable ignored) {
                continue;
            }
            int format = configuredOutputFormat(output);
            Object sizeObject = safeSurfaceProperty(
                    "getSurfaceSize", surface);
            if (!(sizeObject instanceof Size)) {
                continue;
            }
            Size size = (Size) sizeObject;
            boolean auxRaw = format == ImageFormat.RAW_SENSOR
                    && size.getWidth() == 1280
                    && size.getHeight() == 720;
            boolean preview = format == ImageFormat.YUV_420_888
                    && size.getWidth() == 1920
                    && size.getHeight() == 1440;
            boolean raw10 = format == ImageFormat.RAW10
                    && size.getWidth() == 4096
                    && size.getHeight() == 3072;
            if (auxRaw || preview || raw10) {
                minimal.add(output);
            }
        }
        if (minimal.size() != 4) {
            log("[OplusMinimalGraph] refused without mutation: original="
                    + original.size() + " matched=" + minimal.size());
            return;
        }
        param.args[1] = minimal;
        log("[OplusMinimalGraph] test 0x8001 outputs 9 -> 4;");
        logConfiguredOutputs("[OplusMinimalGraph] retained", minimal);
    }

    private static boolean containsOutputConfiguration(List<?> outputs) {
        for (Object output : outputs) {
            if (output instanceof OutputConfiguration) {
                return true;
            }
        }
        return false;
    }

    private static void logConfiguredOutputs(
            String prefix, List<?> outputs) {
        log(prefix + " outputCount=" + outputs.size());
        for (int index = 0; index < outputs.size(); index++) {
            Object output = outputs.get(index);
            if (!(output instanceof OutputConfiguration)) {
                log(prefix + " output" + index + " class="
                        + (output == null ? "null"
                        : output.getClass().getName()));
                continue;
            }
            OutputConfiguration configuration =
                    (OutputConfiguration) output;
            StringBuilder config = new StringBuilder();
            config.append(prefix).append(" output").append(index)
                    .append(" configuredFormat=")
                    .append(configuredOutputFormat(configuration))
                    .append(" group=")
                    .append(safeOutputProperty(configuration,
                            "getSurfaceGroupId"))
                    .append(" physical=")
                    .append(safeOutputProperty(configuration,
                            "getPhysicalCameraId"))
                    .append(" useCase=")
                    .append(safeOutputProperty(configuration,
                            "getStreamUseCase"))
                    .append(" dynamicRange=")
                    .append(safeOutputProperty(configuration,
                            "getDynamicRangeProfile"));
            log(config.toString());
            try {
                List<Surface> surfaces = configuration.getSurfaces();
                for (int surfaceIndex = 0;
                        surfaceIndex < surfaces.size(); surfaceIndex++) {
                    Surface surface = surfaces.get(surfaceIndex);
                    Object usage = safeSurfaceProperty(
                            "getSurfaceUsage", surface);
                    String usageText = usage instanceof Number
                            ? usage + "/0x" + Long.toHexString(
                            ((Number) usage).longValue())
                            : String.valueOf(usage);
                    String reader = SESSION_PROBE_READERS.get(surface);
                    if (reader == null) {
                        reader = OPLUS_REFERENCE_SURFACES.get(surface);
                    }
                    log(prefix + " output" + index + ".surface"
                            + surfaceIndex + " id="
                            + safeSurfaceProperty("getSurfaceId", surface)
                            + " size="
                            + safeSurfaceProperty("getSurfaceSize", surface)
                            + " format="
                            + safeSurfaceProperty(
                            "getSurfaceFormat", surface)
                            + " dataspace="
                            + safeSurfaceProperty(
                            "getSurfaceDataspace", surface)
                            + " usage=" + usageText
                            + " reader=" + reader
                            + " surface=" + surface);
                }
            } catch (Throwable throwable) {
                log(prefix + " output" + index
                        + " surface inspect failed: " + throwable);
            }
        }
    }

    private static Object safeOutputProperty(
            OutputConfiguration output, String method) {
        try {
            return XposedHelpers.callMethod(output, method);
        } catch (Throwable ignored) {
            return "?";
        }
    }

    private static Object safeSurfaceProperty(
            String method, Surface surface) {
        try {
            return XposedHelpers.callStaticMethod(
                    XposedHelpers.findClass(
                            "android.hardware.camera2.utils.SurfaceUtils",
                            null),
                    method, surface);
        } catch (Throwable ignored) {
            return "?";
        }
    }

    /**
     * Observe one stock OPlus still capture so the Xiaomi bridge can use the
     * exact current-device frame contract instead of stale copied constants.
     * Every hook is read-only and all dumps are bounded.
     */
    private static void hookOplusApsReferenceProbe(ClassLoader loader) {
        Class<?> fullAps = XposedHelpers.findClass(
                "com.oplus.ocs.camera.consumer.apsAdapter.algorithm."
                        + "FullApsImpl", loader);
        XposedBridge.hookAllMethods(fullAps, "startCapture",
                new XC_MethodHook() {
                    @Override
                    protected void beforeHookedMethod(MethodHookParam param) {
                        if (param.args == null || param.args.length != 1
                                || param.args[0] == null
                                || !OPLUS_REFERENCE_START_DUMPED
                                .compareAndSet(false, true)) {
                            return;
                        }
                        try {
                            logApsStringArray(
                                    "[OplusReference] START_PARAM",
                                    XposedHelpers.callMethod(param.args[0],
                                            "getParameters"));
                        } catch (Throwable throwable) {
                            log("[OplusReference] START_PARAM read failed: "
                                    + throwable);
                        }
                    }
                });
        XposedBridge.hookAllMethods(fullAps, "beforeCapture",
                new XC_MethodHook() {
                    @Override
                    protected void beforeHookedMethod(MethodHookParam param) {
                        if (param.args == null || param.args.length != 1
                                || param.args[0] == null
                                || !OPLUS_REFERENCE_BEFORE_DUMPED
                                .compareAndSet(false, true)) {
                            return;
                        }
                        try {
                            logApsStringArray(
                                    "[OplusReference] BEFORE_PARAM",
                                    XposedHelpers.callMethod(param.args[0],
                                            "getParameters"));
                        } catch (Throwable throwable) {
                            log("[OplusReference] BEFORE_PARAM read failed: "
                                    + throwable);
                        }
                    }
                });
        XposedBridge.hookAllMethods(fullAps, "setRequestMetadata",
                new XC_MethodHook() {
                    @Override
                    protected void beforeHookedMethod(MethodHookParam param) {
                        if (param.args == null || param.args.length != 1
                                || param.args[0] == null) {
                            return;
                        }
                        int count = OPLUS_REFERENCE_REQUEST_METADATA_COUNT
                                .incrementAndGet();
                        if (count > 24) {
                            return;
                        }
                        try {
                            Object request = param.args[0];
                            long logicalPtr = XposedHelpers.getLongField(
                                    request, "mLogicMetadata");
                            Object physical = XposedHelpers.getObjectField(
                                    request, "mPhysicalMetadatas");
                            log("[OplusReference] REQUEST_METADATA #"
                                    + count
                                    + " logicalId="
                                    + XposedHelpers.getIntField(request,
                                    "mLogicalId")
                                    + " logicPtr=" + logicalPtr
                                    + "/0x" + Long.toHexString(logicalPtr)
                                    + " physical=" + physical
                                    + " master="
                                    + XposedHelpers.getIntField(request,
                                    "mMasterCameraId")
                                    + " activeMap="
                                    + XposedHelpers.getIntField(request,
                                    "mActiveMap"));
                        } catch (Throwable throwable) {
                            log("[OplusReference] REQUEST_METADATA read"
                                    + " failed: " + throwable);
                        }
                    }
                });
        XposedBridge.hookAllMethods(fullAps, "initAlgo",
                new XC_MethodHook() {
                    @Override
                    protected void beforeHookedMethod(MethodHookParam param) {
                        if (param.args == null || param.args.length == 0
                                || param.args[0] == null
                                || !OPLUS_REFERENCE_INIT_DUMPED
                                .compareAndSet(false, true)) {
                            return;
                        }
                        try {
                            Object init = param.args[0];
                            logApsStringArray("[OplusReference] INIT_PARAM",
                                    XposedHelpers.getObjectField(init,
                                            "mParameters"));
                            logApsStringArray("[OplusReference] INIT_ALGO",
                                    XposedHelpers.getObjectField(init,
                                            "mInitAlgo"));
                            Object vendorTags = XposedHelpers.getObjectField(
                                    init, "mVendorTags");
                            log("[OplusReference] INIT module="
                                    + XposedHelpers.getIntField(init,
                                    "mApsModule")
                                    + " vendorTagElements="
                                    + (vendorTags instanceof Object[]
                                    ? ((Object[]) vendorTags).length : -1)
                                    + " metadata="
                                    + XposedHelpers.getObjectField(init,
                                    "mMetadata"));
                        } catch (Throwable throwable) {
                            log("[OplusReference] INIT read failed: "
                                    + throwable);
                        }
                    }
                });
        XposedBridge.hookAllMethods(fullAps, "addFrameBuff",
                new XC_MethodHook() {
                    @Override
                    protected void beforeHookedMethod(MethodHookParam param) {
                        if (param.args == null || param.args.length < 4) {
                            return;
                        }
                        int frame = OPLUS_REFERENCE_FRAME_COUNT
                                .incrementAndGet();
                        if (frame > 12) {
                            return;
                        }
                        try {
                            Object capture = param.args[0];
                            log("[OplusReference] FRAME #" + frame + " "
                                    + capture);
                            Object imageBuffer = XposedHelpers.callMethod(
                                    capture, "getImageBuffer");
                            Object metaBuffer = XposedHelpers.callMethod(
                                    capture, "getMetaBuffer");
                            Object metadataBuffer = XposedHelpers.callMethod(
                                    capture, "getMetadataBuffer");
                            log("[OplusReference] FRAME_BUFFER #" + frame
                                    + " "
                                    + describeOplusImageBuffer(imageBuffer)
                                    + " metaBuffer={"
                                    + describeOplusImageBuffer(metaBuffer)
                                    + "} metadataBuffer={"
                                    + describeOplusHardwareBuffer(
                                    metadataBuffer)
                                    + "}"
                                    + " logicMeta="
                                    + XposedHelpers.callMethod(capture,
                                    "getLogicMeta")
                                    + " physicMeta="
                                    + XposedHelpers.callMethod(capture,
                                    "getPhysicMeta"));
                            if (OPLUS_REFERENCE_PARAMETERS_DUMPED
                                    .compareAndSet(false, true)) {
                                logApsStringArray(
                                        "[OplusReference] FRAME_PARAM",
                                        param.args[1]);
                                logApsStringArray(
                                        "[OplusReference] FRAME_ALGO",
                                        param.args[2]);
                                log("[OplusReference] WATERMARK "
                                        + param.args[3]);
                            }
                        } catch (Throwable throwable) {
                            log("[OplusReference] FRAME read failed: "
                                    + throwable);
                        }
                    }
                });
        XposedBridge.hookAllMethods(fullAps, "processImages",
                new XC_MethodHook() {
                    @Override
                    protected void beforeHookedMethod(MethodHookParam param) {
                        if (param.args == null || param.args.length < 7
                                || !OPLUS_REFERENCE_PROCESS_DUMPED
                                .compareAndSet(false, true)) {
                            return;
                        }
                        try {
                            logApsStringArray(
                                    "[OplusReference] PROCESS_PARAM",
                                    param.args[0]);
                            logApsStringArray(
                                    "[OplusReference] PROCESS_ALGO",
                                    param.args[1]);
                            for (int i = 2; i < param.args.length; i++) {
                                Object value = param.args[i];
                                log("[OplusReference] PROCESS_ARG" + i
                                        + " class="
                                        + (value == null ? "null"
                                        : value.getClass().getName())
                                        + " value=" + value);
                            }
                        } catch (Throwable throwable) {
                            log("[OplusReference] PROCESS read failed: "
                                    + throwable);
                        }
                    }
                });

        XposedBridge.hookAllMethods(ImageReader.class, "newInstance",
                new XC_MethodHook() {
                    @Override
                    protected void afterHookedMethod(MethodHookParam param) {
                        if (!(param.getResult() instanceof ImageReader)) {
                            return;
                        }
                        ImageReader reader = (ImageReader) param.getResult();
                        try {
                            Surface surface = reader.getSurface();
                            String spec = reader.getWidth() + "x"
                                    + reader.getHeight() + "/fmt"
                                    + reader.getImageFormat() + "/max"
                                    + reader.getMaxImages() + "/usage"
                                    + reader.getUsage();
                            OPLUS_REFERENCE_SURFACES.put(surface, spec);
                            log("[OplusReference] READER " + reader
                                    + " surface=" + surface
                                    + " spec=" + spec);
                        } catch (Throwable throwable) {
                            log("[OplusReference] READER read failed: "
                                    + throwable);
                        }
                    }
                });

        Class<?> builder = XposedHelpers.findClass(
                "android.hardware.camera2.CaptureRequest$Builder", loader);
        XposedBridge.hookAllMethods(builder, "build", new XC_MethodHook() {
            @Override
            protected void afterHookedMethod(MethodHookParam param) {
                if (!(param.getResult() instanceof CaptureRequest)) {
                    return;
                }
                CaptureRequest request = (CaptureRequest) param.getResult();
                Integer intent = request.get(
                        CaptureRequest.CONTROL_CAPTURE_INTENT);
                if (!Integer.valueOf(
                        CaptureRequest.CONTROL_CAPTURE_INTENT_STILL_CAPTURE)
                        .equals(intent)) {
                    logOplusVideoZoomContract(request);
                    int previewOrdinal = OPLUS_REFERENCE_PREVIEW_COUNT
                            .incrementAndGet();
                    if (previewOrdinal <= 16) {
                        logOplusRequestTargets("PREVIEW_REQUEST",
                                previewOrdinal, intent, request);
                    }
                    if (captureRequestHasTargets(request)
                            && OPLUS_REFERENCE_PREVIEW_PARAMS_DUMPED
                            .compareAndSet(false, true)) {
                        logCaptureRequestKeyMap(
                                "[OplusPreviewParam]", request);
                    }
                    return;
                }
                int ordinal = OPLUS_REFERENCE_STILL_COUNT.incrementAndGet();
                if (ordinal > 8) {
                    return;
                }
                logOplusRequestTargets("STILL_REQUEST", ordinal,
                        intent, request);
                if (OPLUS_REFERENCE_STILL_PARCEL_DUMPED
                        .compareAndSet(false, true)) {
                    dumpOplusStillRequestParcel(request);
                }
                for (CaptureRequest.Key<?> key : request.getKeys()) {
                    String name = key.getName();
                    if (!isOplusReferenceRequestKey(name)) {
                        continue;
                    }
                    try {
                        log("[OplusReference] REQ #" + ordinal + " "
                                + name + "="
                                + apsValueString(request.get(key)));
                    } catch (Throwable ignored) {
                        // Vendor keys may disappear between list/get.
                    }
                }
            }
        });
        log("[OplusReference] read-only stock capture hooks active");
    }

    /**
     * Log the stable endpoints of ColorOS' video SAT request.  Intermediate
     * animation ratios are intentionally ignored: the endpoint request is the
     * contract Xiaomi must reproduce, while logging every animation frame
     * makes the physical hand-off impossible to audit reliably.
     */
    private static void logOplusVideoZoomContract(CaptureRequest request) {
        try {
            if (!captureRequestHasTargets(request)) {
                return;
            }
            byte[] modeBytes = request.get(OPLUS_CAMERA_MODE);
            if (modeBytes == null || !"video_mode".equals(
                    new String(modeBytes, StandardCharsets.UTF_8)
                            .replace("\u0000", ""))) {
                return;
            }
            Float zoomValue = request.get(CaptureRequest.CONTROL_ZOOM_RATIO);
            if (zoomValue == null || !isOnePlusVideoZoomEndpoint(zoomValue)) {
                return;
            }
            float[] originalZoom = request.get(OPLUS_ORIGINAL_ZOOM);
            float[] targetZoom = request.get(OPLUS_ZOOM_TARGET);
            int[] pointZoom = request.get(OPLUS_POINT_ZOOM);
            String signature = Math.round(zoomValue * 1000.0f) + ":"
                    + Arrays.toString(originalZoom) + ":"
                    + Arrays.toString(targetZoom) + ":"
                    + Arrays.toString(pointZoom);
            if (signature.equals(lastOplusVideoZoomSignature)) {
                return;
            }
            lastOplusVideoZoomSignature = signature;
            int ordinal = OPLUS_REFERENCE_VIDEO_ZOOM_COUNT.incrementAndGet();
            if (ordinal > 24) {
                return;
            }
            log("[OplusVideoZoom] #" + ordinal + " zoom=" + zoomValue
                    + " original=" + Arrays.toString(originalZoom)
                    + " target=" + Arrays.toString(targetZoom)
                    + " point=" + Arrays.toString(pointZoom)
                    + " intent=" + request.get(
                    CaptureRequest.CONTROL_CAPTURE_INTENT)
                    + " fps=" + request.get(
                    CaptureRequest.CONTROL_AE_TARGET_FPS_RANGE)
                    + " crop=" + request.get(
                    CaptureRequest.SCALER_CROP_REGION));
            for (CaptureRequest.Key<?> key : request.getKeys()) {
                String name = key.getName();
                if (!isOplusVideoZoomContractKey(name)) {
                    continue;
                }
                try {
                    log("[OplusVideoZoom] #" + ordinal + " " + name + "="
                            + apsValueString(request.get(key)));
                } catch (Throwable ignored) {
                    // A vendor key can disappear between getKeys() and get().
                }
            }
        } catch (Throwable throwable) {
            log("[OplusVideoZoom] read failed: " + throwable);
        }
    }

    private static boolean isOnePlusVideoZoomEndpoint(float zoom) {
        for (float endpoint : new float[]{0.6f, 1.0f, 2.0f, 3.0f, 6.0f}) {
            if (Math.abs(zoom - endpoint) <= 0.015f) {
                return true;
            }
        }
        return false;
    }

    private static boolean isOplusVideoZoomContractKey(String name) {
        if (name == null) {
            return false;
        }
        String lower = name.toLowerCase(Locale.US);
        return lower.contains("zoom")
                || lower.contains("sensor.mode")
                || lower.contains("feature.type")
                || lower.contains("camera.mode")
                || lower.contains("master")
                || lower.contains("sat")
                || lower.contains("video")
                || lower.contains("eis")
                || lower.contains("fps")
                || lower.contains("streammap");
    }

    private static void dumpOplusStillRequestParcel(
            CaptureRequest request) {
        Object originalSurfaces = null;
        try {
            // CaptureRequest's normal Parcelable includes four live Surface
            // objects and therefore cannot be marshalled to byte[].  Swap in
            // an empty set only for the synchronous write, then restore the
            // exact original object before the builder returns to ColorOS.
            originalSurfaces = XposedHelpers.getObjectField(
                    request, "mSurfaceSet");
            XposedHelpers.setObjectField(request, "mSurfaceSet",
                    new android.util.ArraySet<Surface>());
            Parcel requestParcel = Parcel.obtain();
            try {
                request.writeToParcel(requestParcel, 0);
                byte[] bytes = requestParcel.marshall();
                saveOplusReferenceParcel(bytes,
                        "os4_oplus_common_still_request.parcel");
                log("[OplusStillParcel] targetless request saved bytes="
                        + bytes.length + " keys=" + request.getKeys().size()
                        + " sha256=" + sha256(bytes));
            } finally {
                requestParcel.recycle();
            }

            Object logicalMetadata = XposedHelpers.getObjectField(
                    request, "mLogicalCameraSettings");
            Parcel metadataParcel = Parcel.obtain();
            try {
                XposedHelpers.callMethod(logicalMetadata,
                        "writeToParcel", metadataParcel, 0);
                byte[] metadataBytes = metadataParcel.marshall();
                saveOplusReferenceParcel(metadataBytes,
                        "os4_oplus_common_still_metadata.parcel");
                log("[OplusStillParcel] logical metadata saved bytes="
                        + metadataBytes.length + " sha256="
                        + sha256(metadataBytes));
            } finally {
                metadataParcel.recycle();
            }
        } catch (Throwable throwable) {
            log("[OplusStillParcel] save failed: " + throwable);
            XposedBridge.log(throwable);
        } finally {
            if (originalSurfaces != null) {
                try {
                    XposedHelpers.setObjectField(request, "mSurfaceSet",
                            originalSurfaces);
                } catch (Throwable throwable) {
                    log("[OplusStillParcel] CRITICAL surface restore failed: "
                            + throwable);
                    XposedBridge.log(throwable);
                }
            }
        }
    }

    private static void saveOplusReferenceParcel(byte[] bytes,
            String name) throws Exception {
        File output = new File(
                "/data/user/0/com.oplus.camera/files/", name);
        File parent = output.getParentFile();
        if (parent != null && !parent.exists() && !parent.mkdirs()) {
            throw new IllegalStateException("cannot create " + parent);
        }
        try (FileOutputStream stream = new FileOutputStream(output)) {
            stream.write(bytes);
            stream.getFD().sync();
        }
    }

    private static void logOplusRequestTargets(String kind, int ordinal,
            Integer intent, CaptureRequest request) {
        try {
            Object targets = XposedHelpers.callMethod(
                    request, "getTargets");
            log("[OplusReference] " + kind + " #" + ordinal
                    + " intent=" + intent + " targets=" + targets);
            if (!(targets instanceof Iterable<?>)) {
                return;
            }
            int targetIndex = 0;
            for (Object target : (Iterable<?>) targets) {
                String spec = target instanceof Surface
                        ? OPLUS_REFERENCE_SURFACES.get(target) : null;
                if (spec == null && target instanceof Surface) {
                    spec = SESSION_PROBE_READERS.get(target);
                }
                log("[OplusReference] " + kind + "_TARGET #"
                        + ordinal + "." + (++targetIndex)
                        + " surface=" + target + " readerSpec=" + spec);
            }
        } catch (Throwable throwable) {
            log("[OplusReference] " + kind
                    + " target inspect failed: " + throwable);
        }
    }

    private static boolean captureRequestHasTargets(CaptureRequest request) {
        try {
            Object targets = XposedHelpers.callMethod(request, "getTargets");
            if (targets instanceof Iterable<?>) {
                return ((Iterable<?>) targets).iterator().hasNext();
            }
        } catch (Throwable ignored) {
            // Read-only probe; an inaccessible target set means false.
        }
        return false;
    }

    private static void logCaptureRequestKeyMap(
            String prefix, CaptureRequest request) {
        try {
            List<CaptureRequest.Key<?>> keys = request.getKeys();
            log(prefix + " keyCount=" + keys.size());
            int index = 0;
            for (CaptureRequest.Key<?> key : keys) {
                Object value;
                try {
                    value = request.get(key);
                } catch (Throwable throwable) {
                    value = "<read-error:" + throwable + ">";
                }
                log(prefix + " [" + (index++) + "] "
                        + key.getName() + "=" + apsValueString(value));
            }
        } catch (Throwable throwable) {
            log(prefix + " dump failed: " + throwable);
        }
    }

    private static String describeOplusImageBuffer(Object imageBuffer) {
        if (imageBuffer == null) {
            return "buffer=null";
        }
        try {
            Object readerObject = XposedHelpers.callMethod(
                    imageBuffer, "getImageReader");
            Object imageObject = XposedHelpers.callMethod(
                    imageBuffer, "getImage");
            Object hardwareObject = XposedHelpers.callMethod(
                    imageBuffer, "getHardwareBuffer");
            StringBuilder out = new StringBuilder();
            out.append("reader=").append(readerObject);
            if (readerObject instanceof ImageReader) {
                ImageReader reader = (ImageReader) readerObject;
                out.append(" readerSpec=")
                        .append(reader.getWidth()).append('x')
                        .append(reader.getHeight()).append("/fmt")
                        .append(reader.getImageFormat()).append("/max")
                        .append(reader.getMaxImages()).append("/usage")
                        .append(reader.getUsage()).append("/surface=")
                        .append(reader.getSurface());
            }
            out.append(" image=").append(imageObject);
            if (imageObject instanceof Image) {
                Image image = (Image) imageObject;
                out.append(" imageSpec=")
                        .append(image.getWidth()).append('x')
                        .append(image.getHeight()).append("/fmt")
                        .append(image.getFormat()).append("/planes")
                        .append(image.getPlanes().length).append("/ts")
                        .append(image.getTimestamp());
            }
            out.append(" hardware=").append(hardwareObject);
            if (hardwareObject instanceof android.hardware.HardwareBuffer) {
                android.hardware.HardwareBuffer hardware =
                        (android.hardware.HardwareBuffer) hardwareObject;
                out.append(" hardwareSpec=")
                        .append(hardware.getWidth()).append('x')
                        .append(hardware.getHeight()).append("/fmt")
                        .append(hardware.getFormat()).append("/layers")
                        .append(hardware.getLayers()).append("/usage")
                        .append(hardware.getUsage());
            }
            // The two common-photo RAW10 streams have identical public
            // ImageReader geometry.  APS distinguishes them by the private
            // surface-usage/pipeline fields, so include those in the
            // read-only stock trace before reproducing the contract in the
            // Xiaomi process.
            out.append(" privateSpec=type")
                    .append(XposedHelpers.getIntField(imageBuffer, "mType"))
                    .append("/fmt")
                    .append(XposedHelpers.getIntField(imageBuffer, "mFormat"))
                    .append("/pipeline=")
                    .append(XposedHelpers.getObjectField(
                            imageBuffer, "mPipelineName"))
                    .append("/surfaceUsage=")
                    .append(XposedHelpers.getObjectField(
                            imageBuffer, "mSurfaceUsage"));
            return out.toString();
        } catch (Throwable throwable) {
            return "buffer=" + imageBuffer + " readError=" + throwable;
        }
    }

    private static String describeOplusHardwareBuffer(Object buffer) {
        if (buffer == null) {
            return "buffer=null";
        }
        if (!(buffer instanceof android.hardware.HardwareBuffer)) {
            return "class=" + buffer.getClass().getName()
                    + " value=" + buffer;
        }
        try {
            android.hardware.HardwareBuffer hardware =
                    (android.hardware.HardwareBuffer) buffer;
            return "buffer=" + hardware
                    + " size=" + hardware.getWidth() + "x"
                    + hardware.getHeight()
                    + "/fmt" + hardware.getFormat()
                    + "/layers" + hardware.getLayers()
                    + "/usage" + hardware.getUsage()
                    + "/closed=" + hardware.isClosed();
        } catch (Throwable throwable) {
            return "buffer=" + buffer + " readError=" + throwable;
        }
    }

    private static boolean isOplusReferenceRequestKey(String name) {
        return name != null && (name.contains("capture.request")
                || name.contains("aps.feature")
                || name.contains("enableMFNR")
                || name.contains("BracketMode")
                || name.contains("sensor.mode")
                || name.contains("ai.scene")
                || name.contains("autoHDR")
                || name.contains("supernight")
                || name.contains("salient")
                || name.contains("ipe.sequence")
                || name.contains("mfnr")
                || name.equals("android.sensor.exposureTime")
                || name.equals("android.sensor.sensitivity")
                || name.equals("android.noiseReduction.mode")
                || name.equals("android.edge.mode")
                || name.equals("android.jpeg.quality"));
    }

    private static void logApsStringArray(String prefix, Object value) {
        if (!(value instanceof String[])) {
            log(prefix + " value=" + value);
            return;
        }
        String[] entries = (String[]) value;
        log(prefix + " elements=" + entries.length);
        for (int i = 0; i < entries.length; i += 2) {
            String right = i + 1 < entries.length
                    ? entries[i + 1] : "<missing>";
            log(prefix + " [" + (i / 2) + "] "
                    + entries[i] + "=" + right);
        }
    }

    private static String apsValueString(Object value) {
        if (value instanceof byte[]) {
            return Arrays.toString((byte[]) value);
        }
        if (value instanceof int[]) {
            return Arrays.toString((int[]) value);
        }
        if (value instanceof long[]) {
            return Arrays.toString((long[]) value);
        }
        if (value instanceof float[]) {
            return Arrays.toString((float[]) value);
        }
        if (value instanceof double[]) {
            return Arrays.toString((double[]) value);
        }
        if (value instanceof Object[]) {
            return Arrays.deepToString((Object[]) value);
        }
        return String.valueOf(value);
    }

    private static void hookLegendaryMode(ClassLoader loader) {
        Class<?> entry = XposedHelpers.findClass(
                "com.android.camera.features.mode.legendary.LegendaryEnter",
                loader);
        XposedBridge.hookAllMethods(entry, "support",
                XC_MethodReplacement.returnConstant(true));

        // The product selector is persisted independently of the Camera2
        // session.  Observe that source of truth as well as the vendor tag:
        // changing M9 -> M3 does not necessarily rebuild the existing
        // session, so relying only on Builder.set left activeLegendMode stale.
        Class<?> componentData = XposedHelpers.findClass(
                "com.android.camera.data.data.c", loader);
        XposedBridge.hookAllMethods(componentData, "getComponentValue",
                new XC_MethodHook() {
                    @Override
                    protected void afterHookedMethod(MethodHookParam param) {
                        if (isLegendaryComponentCall(param)) {
                            updateActiveLegendMode(param.getResult(),
                                    "component-read");
                        }
                    }
                });
        XposedBridge.hookAllMethods(componentData, "setComponentValue",
                new XC_MethodHook() {
                    @Override
                    protected void beforeHookedMethod(MethodHookParam param) {
                        if (isLegendaryComponentCall(param)
                                && param.args.length >= 2) {
                            updateActiveLegendMode(param.args[1],
                                    "component-write");
                        }
                    }
                });

        // The OnePlus HAL has no Xiaomi-only sessionparams.legendMode vendor
        // tag.  Remember M9/M3 selection for our save path, then suppress only
        // that unsupported key before CameraMetadataNative sees it.
        XposedBridge.hookAllMethods(CaptureRequest.Builder.class, "set",
                new XC_MethodHook() {
                    @Override
                    protected void beforeHookedMethod(MethodHookParam param) {
                        if (param.args == null || param.args.length != 2
                                || !(param.args[0]
                                instanceof CaptureRequest.Key<?>)) {
                            return;
                        }
                        CaptureRequest.Key<?> key =
                                (CaptureRequest.Key<?>) param.args[0];
                        if (!"com.xiaomi.sessionparams.legendMode".equals(
                                key.getName())) {
                            return;
                        }
                        if (param.args[1] instanceof Number) {
                            int mode = ((Number) param.args[1]).intValue();
                            if (mode == 1 || mode == 2) {
                                activeLegendMode = mode;
                            }
                        }
                        param.setResult(null);
                        log("[LegendM9] suppressed unsupported HAL tag; mode="
                                + activeLegendMode);
                    }
                });
        log("[LegendM9] native mode entry exposed; HAL tag guard active");
    }

    private static boolean isLegendaryComponentCall(
            XC_MethodHook.MethodHookParam param) {
        if (param.args == null || param.args.length < 1
                || !(param.args[0] instanceof Number)
                || ((Number) param.args[0]).intValue() != 256) {
            return false;
        }
        try {
            return "pref_legendary_mode_key".equals(String.valueOf(
                    XposedHelpers.callMethod(param.thisObject, "getKey",
                            256)));
        } catch (Throwable ignored) {
            return false;
        }
    }

    private static void updateActiveLegendMode(Object value, String source) {
        String product = String.valueOf(value);
        int mode;
        if ("M9".equals(product)) {
            mode = 1;
        } else if ("M3".equals(product)) {
            mode = 2;
        } else {
            return;
        }
        if (activeLegendMode != mode) {
            activeLegendMode = mode;
            log("[LegendMode] product=" + product + " mode=" + mode
                    + " source=" + source);
        }
    }

    /**
     * Adds Pro's genuine RAW_SENSOR side output to Legendary captures, packs
     * its Bayer samples into the M9 container's required RAW10 layout, and
     * joins it to Xiaomi's final Rh.r save task by the sensor timestamp. The original
     * full-resolution JPEG remains untouched unless RAW, LSC and per-frame
     * exposure metadata all validate.
     */
    private static void hookLegendaryRawPipeline(ClassLoader loader) {
        Class<?> wrapper = XposedHelpers.findClass("sh.b", loader);
        XposedBridge.hookAllMethods(wrapper, "b", new XC_MethodHook() {
            @Override
            protected void beforeHookedMethod(MethodHookParam param) {
                legendRawSessionActive = false;
                if (activeCameraModule != 256 || activeLegendMode != 1
                        || param.args == null || param.args.length != 5
                        || !(param.args[1] instanceof List<?>)) {
                    return;
                }
                try {
                    String cameraId = String.valueOf(
                            XposedHelpers.callMethod(param.thisObject, "c"));
                    int numericCameraId = Integer.parseInt(cameraId);
                    if (!isRearDirectCaptureCamera(numericCameraId)
                            || !supportsLegendRawSensor(numericCameraId)
                            || !ensureLegendRawReader(numericCameraId)) {
                        return;
                    }
                    legendRawCameraId = numericCameraId;
                    boolean added = appendOutputSurface(
                            (List<?>) param.args[1],
                            legendRawReader.getSurface());
                    legendRawSessionActive = true;
                    synchronized (LEGEND_RAW_LOCK) {
                        LEGEND_RAW_FRAMES.clear();
                    }
                    log("[LegendM9] RAW_SENSOR session output "
                            + (added ? "added" : "already present")
                            + " camera=" + numericCameraId
                            + " size=4096x3072 outputs="
                            + ((List<?>) param.args[1]).size());
                } catch (Throwable throwable) {
                    legendRawSessionActive = false;
                    log("[LegendM9] RAW_SENSOR session rejected; stock JPEG path: "
                            + throwable);
                }
            }
        });

        XposedBridge.hookAllMethods(wrapper, "a", new XC_MethodHook() {
            @Override
            protected void afterHookedMethod(MethodHookParam param) {
                if (!legendRawSessionActive || activeCameraModule != 256
                        || activeLegendMode != 1 || legendRawReader == null
                        || param.args == null || param.args.length != 2
                        || !"SHOT".equals(String.valueOf(param.args[0]))
                        || !(param.getResult()
                        instanceof CaptureRequest.Builder)) {
                    return;
                }
                try {
                    CaptureRequest.Builder builder =
                            (CaptureRequest.Builder) param.getResult();
                    builder.addTarget(legendRawReader.getSurface());
                    builder.set(CaptureRequest.STATISTICS_LENS_SHADING_MAP_MODE,
                            CaptureRequest
                                    .STATISTICS_LENS_SHADING_MAP_MODE_ON);
                    log("[LegendM9] RAW_SENSOR+LSC attached to SHOT request");
                } catch (Throwable throwable) {
                    log("[LegendM9] SHOT RAW target rejected; stock JPEG path: "
                            + throwable);
                }
            }
        });

        Class<?> storeTask = XposedHelpers.findClass("s7.d", loader);
        Class<?> parallelTask = XposedHelpers.findClass("Rh.r", loader);
        XposedBridge.hookAllMethods(storeTask, "c", new XC_MethodHook() {
            @Override
            protected void afterHookedMethod(MethodHookParam param) {
                if (activeCameraModule != 256 || activeLegendMode != 1) {
                    return;
                }

                /*
                 * The stock OS4 store task advertises itself as a streaming
                 * writer.  That makes p7.c defer EXIF serialization until
                 * after our M9 container has been assembled.  Its streaming
                 * JPEG writer then stops at EOI and silently drops the RAW,
                 * LSC and MiContainer tail.  Xiaomi's original M9 bridge runs
                 * after EXIF and immediately before Storage, so make only the
                 * Legendary M9 store task non-streaming to restore that order.
                 */
                param.setResult(false);
                log("[LegendM9] store streaming disabled; EXIF will precede "
                        + "container assembly");
            }
        });
        XposedBridge.hookAllMethods(storeTask, "a", new XC_MethodHook() {
            @Override
            protected void beforeHookedMethod(MethodHookParam param) {
                if (activeCameraModule != 256
                        || param.args == null || param.args.length != 1
                        || !parallelTask.isInstance(param.args[0])) {
                    return;
                }
                if (activeLegendMode == 1) {
                    if (legendRawSessionActive) {
                        wrapLegendaryStoreTask(param.args[0]);
                    } else {
                        tagLegendaryStoreTask(param.args[0], 1);
                    }
                } else if (activeLegendMode == 2) {
                    tagLegendaryStoreTask(param.args[0], 2);
                }
            }
        });
        log("[LegendM9] Pro RAW_SENSOR/LSC/store hooks active");
    }

    private static boolean supportsLegendRawSensor(int cameraId) {
        try {
            CameraCharacteristics characteristics = CAMERA_CHARACTERISTICS.get(
                    String.valueOf(cameraId));
            StreamConfigurationMap map = characteristics == null ? null
                    : characteristics.get(CameraCharacteristics
                    .SCALER_STREAM_CONFIGURATION_MAP);
            Size[] sizes = map == null ? null
                    : map.getOutputSizes(ImageFormat.RAW_SENSOR);
            if (sizes != null) {
                for (Size size : sizes) {
                    if (size.getWidth() == LegendM9Container.RAW_WIDTH
                            && size.getHeight()
                            == LegendM9Container.RAW_HEIGHT) {
                        return true;
                    }
                }
            }
            log("[LegendM9] camera=" + cameraId
                    + " has no 4096x3072 RAW_SENSOR output; tagged JPEG fallback");
        } catch (Throwable throwable) {
            log("[LegendM9] RAW_SENSOR capability query failed camera="
                    + cameraId + ": " + throwable);
        }
        return false;
    }

    private static void tagLegendaryStoreTask(Object task, int mode) {
        try {
            Object sourceData = XposedHelpers.getObjectField(task, "a");
            byte[] jpeg = (byte[]) XposedHelpers.getObjectField(
                    sourceData, "i");
            // This boundary follows native watermark EXIF serialization. The file may
            // end with a removal PNG, not primary EOI; never discard that valid tail.
            if (!LegendaryContainerIntegrity.hasCompletePrimaryJpeg(jpeg)) {
                return;
            }
            byte[] tagged = mode == 2
                    ? LegendM9Container.wrapM3(jpeg)
                    : LegendExifTagger.tag(jpeg, mode);
            XposedHelpers.setObjectField(sourceData, "i", tagged);
            log("[LegendMode] capture tagged mode=" + mode
                    + " input=" + jpeg.length + " output=" + tagged.length
                    + " readback=" + LegendExifTagger.read(tagged));
        } catch (Throwable throwable) {
            log("[LegendMode] tag failed mode=" + mode + ": " + throwable);
        }
    }

    private static boolean ensureLegendRawReader(int cameraId) {
        synchronized (LEGEND_RAW_LOCK) {
            if (legendRawReader != null
                    && legendRawReaderCameraId == cameraId) {
                return true;
            }
            try {
                HandlerThread thread = legendRawThread;
                if (thread == null || !thread.isAlive()) {
                    thread = new HandlerThread("OS4LegendRawSensor");
                    thread.start();
                    legendRawThread = thread;
                }
                Handler handler = new Handler(thread.getLooper());
                ImageReader reader = ImageReader.newInstance(
                        LegendM9Container.RAW_WIDTH,
                        LegendM9Container.RAW_HEIGHT,
                        ImageFormat.RAW_SENSOR, 3);
                reader.setOnImageAvailableListener(
                        available -> onLegendRawAvailable(
                                available, cameraId), handler);
                ImageReader previous = legendRawReader;
                legendRawReader = reader;
                legendRawReaderCameraId = cameraId;
                if (previous != null) {
                    // The old Camera2 session may still be detaching this
                    // consumer surface during a physical-lens switch.
                    handler.postDelayed(previous::close, 2000L);
                }
                log("[LegendM9] ImageReader ready 4096x3072 RAW_SENSOR max=3"
                        + " camera=" + cameraId);
                return true;
            } catch (Throwable throwable) {
                log("[LegendM9] RAW_SENSOR ImageReader creation failed: "
                        + throwable);
                return false;
            }
        }
    }

    private static void onLegendRawAvailable(ImageReader reader,
            int captureCameraId) {
        Image image = null;
        try {
            image = reader.acquireNextImage();
            if (image == null) {
                return;
            }
            if (image.getFormat() != ImageFormat.RAW_SENSOR
                    || image.getWidth() != LegendM9Container.RAW_WIDTH
                    || image.getHeight() != LegendM9Container.RAW_HEIGHT) {
                throw new IllegalArgumentException("unexpected RAW geometry "
                        + image.getWidth() + "x" + image.getHeight()
                        + "/" + image.getFormat());
            }
            Image.Plane[] planes = image.getPlanes();
            if (planes.length != 1) {
                throw new IllegalArgumentException(
                        "RAW_SENSOR plane count=" + planes.length);
            }
            Image.Plane plane = planes[0];
            int rowStride = plane.getRowStride();
            int pixelStride = plane.getPixelStride();
            if (pixelStride < 2
                    || rowStride < LegendM9Container.RAW_WIDTH
                    * pixelStride) {
                throw new IllegalArgumentException("RAW_SENSOR layout row="
                        + rowStride + " pixel=" + pixelStride);
            }
            ByteBuffer source = plane.getBuffer().duplicate()
                    .order(ByteOrder.LITTLE_ENDIAN);
            int base = source.position();
            byte[] raw = new byte[LegendM9Container.RAW_BYTES];
            int whiteLevel = legendRawWhiteLevel(captureCameraId);
            for (int row = 0; row < LegendM9Container.RAW_HEIGHT; row++) {
                int sourceOffset = base + row * rowStride;
                int destination = row * LegendM9Container.RAW_STRIDE;
                int sourceRowEnd = sourceOffset
                        + (LegendM9Container.RAW_WIDTH - 1) * pixelStride + 2;
                if (sourceRowEnd
                        > source.limit()) {
                    throw new IllegalArgumentException(
                            "RAW_SENSOR plane buffer truncated at row " + row);
                }
                for (int column = 0;
                        column < LegendM9Container.RAW_WIDTH; column += 4) {
                    int p0 = normalizeRaw10Sample(source.getShort(
                            sourceOffset + column * pixelStride) & 0xffff,
                            whiteLevel);
                    int p1 = normalizeRaw10Sample(source.getShort(
                            sourceOffset + (column + 1) * pixelStride) & 0xffff,
                            whiteLevel);
                    int p2 = normalizeRaw10Sample(source.getShort(
                            sourceOffset + (column + 2) * pixelStride) & 0xffff,
                            whiteLevel);
                    int p3 = normalizeRaw10Sample(source.getShort(
                            sourceOffset + (column + 3) * pixelStride) & 0xffff,
                            whiteLevel);
                    raw[destination++] = (byte) (p0 >>> 2);
                    raw[destination++] = (byte) (p1 >>> 2);
                    raw[destination++] = (byte) (p2 >>> 2);
                    raw[destination++] = (byte) (p3 >>> 2);
                    raw[destination++] = (byte) ((p0 & 0x3)
                            | ((p1 & 0x3) << 2)
                            | ((p2 & 0x3) << 4)
                            | ((p3 & 0x3) << 6));
                }
            }
            long timestamp = image.getTimestamp();
            LegendRawFrame frame = new LegendRawFrame(
                    timestamp, raw, rowStride, captureCameraId, whiteLevel);
            synchronized (LEGEND_RAW_LOCK) {
                LEGEND_RAW_FRAMES.put(timestamp, frame);
                if (LEGEND_RAW_FRAMES.size() > 4) {
                    long oldest = Long.MAX_VALUE;
                    for (Long value : LEGEND_RAW_FRAMES.keySet()) {
                        oldest = Math.min(oldest, value);
                    }
                    if (oldest != Long.MAX_VALUE) {
                        LEGEND_RAW_FRAMES.remove(oldest);
                    }
                }
                LEGEND_RAW_LOCK.notifyAll();
            }
            log("[LegendM9] RAW_SENSOR packed to RAW10 ts=" + timestamp
                    + " bytes=" + raw.length + " inputStride=" + rowStride
                    + " pixelStride=" + pixelStride
                    + " camera=" + captureCameraId
                    + " white=" + whiteLevel);
        } catch (Throwable throwable) {
            log("[LegendM9] RAW_SENSOR frame rejected: " + throwable);
        } finally {
            if (image != null) {
                image.close();
            }
        }
    }

    private static int legendRawWhiteLevel(int cameraId) {
        try {
            CameraCharacteristics characteristics =
                    CAMERA_CHARACTERISTICS.get(String.valueOf(cameraId));
            Integer value = characteristics == null ? null
                    : characteristics.get(
                    CameraCharacteristics.SENSOR_INFO_WHITE_LEVEL);
            if (value != null && value > 0) {
                return value;
            }
        } catch (Throwable ignored) {
            // Ten-bit is the verified OnePlus 13 fallback.
        }
        return 1023;
    }

    private static int normalizeRaw10Sample(int sample, int whiteLevel) {
        int value = Math.max(0, sample);
        if (whiteLevel > 1023) {
            value = Math.round(value * (1023.0f / whiteLevel));
        }
        return Math.min(1023, value);
    }

    private static void wrapLegendaryStoreTask(Object task) {
        long timestamp = -1L;
        try {
            Object sourceData = XposedHelpers.getObjectField(task, "a");
            byte[] jpeg = (byte[]) XposedHelpers.getObjectField(
                    sourceData, "i");
            if (!isJpeg(jpeg)) {
                return;
            }
            timestamp = XposedHelpers.getLongField(sourceData, "f");
            LegendRawFrame rawFrame = awaitLegendRaw(timestamp, 6000L);
            if (rawFrame == null) {
                throw new IllegalStateException(
                        "RAW10 timeout for task timestamp " + timestamp);
            }
            TotalCaptureResult result = legendCaptureResult(task, timestamp);
            if (result == null) {
                throw new IllegalStateException(
                        "TotalCaptureResult absent for " + timestamp);
            }
            int physicalCameraId = resolveLegendPhysicalCameraId(
                    result, rawFrame.captureCameraId);
            if (rawFrame.captureCameraId != 0
                    && physicalCameraId != rawFrame.captureCameraId) {
                throw new IllegalStateException("RAW/result camera mismatch "
                        + rawFrame.captureCameraId + "/" + physicalCameraId);
            }
            TotalCaptureResult metadataResult = selectLegendMetadataResult(
                    result, physicalCameraId);
            float[] lsc = legendLensShadingMap(metadataResult, result);
            int orientation = XposedHelpers.getIntField(sourceData, "c");
            String basename = legendTaskBasename(task);
            LegendM9Container.Metadata metadata = legendMetadata(
                    metadataResult, result, orientation,
                    physicalCameraId);
            long started = SystemClock.elapsedRealtime();
            byte[] wrapped = LegendM9Container.wrap(
                    jpeg, rawFrame.raw10, lsc, basename, metadata);
            XposedHelpers.setObjectField(sourceData, "i", wrapped);
            log("[LegendM9] committed basename=" + basename
                    + " ts=" + timestamp + " JPEG=" + jpeg.length
                    + " RAW=" + rawFrame.raw10.length
                    + " output=" + wrapped.length
                    + " iso=" + metadata.sensitivityIso
                    + " cct=" + metadata.cct
                    + " lux=" + metadata.luxIndex
                    + " levels=" + metadata.blackLevel + "/"
                    + metadata.whiteLevel
                    + " camera=" + physicalCameraId
                    + " sensorType=" + metadata.sensorType
                    + " sourceCfa=" + metadata.sourceCfa
                    + " costMs="
                    + (SystemClock.elapsedRealtime() - started)
                    + " triple-binding=pass");
        } catch (Throwable throwable) {
            log("[LegendM9] container rejected; original JPEG retained: "
                    + throwable);
        } finally {
            if (timestamp > 0L) {
                synchronized (LEGEND_RAW_LOCK) {
                    LEGEND_RAW_FRAMES.remove(timestamp);
                }
                STILL_CAPTURE_RESULTS.remove(timestamp);
            }
        }
    }

    private static LegendRawFrame awaitLegendRaw(long timestamp,
            long timeoutMs) {
        long deadline = SystemClock.elapsedRealtime() + timeoutMs;
        synchronized (LEGEND_RAW_LOCK) {
            while (true) {
                LegendRawFrame frame = LEGEND_RAW_FRAMES.get(timestamp);
                if (frame != null) {
                    return frame;
                }
                long remaining = deadline - SystemClock.elapsedRealtime();
                if (remaining <= 0L) {
                    return null;
                }
                try {
                    LEGEND_RAW_LOCK.wait(remaining);
                } catch (InterruptedException exception) {
                    Thread.currentThread().interrupt();
                    return null;
                }
            }
        }
    }

    private static TotalCaptureResult legendCaptureResult(Object task,
            long timestamp) {
        try {
            Object captureData = XposedHelpers.getObjectField(task, "f");
            Object total = XposedHelpers.getObjectField(captureData, "b");
            if (total instanceof TotalCaptureResult) {
                return (TotalCaptureResult) total;
            }
            Object capture = XposedHelpers.getObjectField(captureData, "c");
            if (capture instanceof TotalCaptureResult) {
                return (TotalCaptureResult) capture;
            }
        } catch (Throwable ignored) {
            // The direct JPEG route commonly leaves captureData empty.
        }
        return STILL_CAPTURE_RESULTS.get(timestamp);
    }

    private static TotalCaptureResult selectLegendMetadataResult(
            TotalCaptureResult logical, int cameraId) {
        try {
            Map<String, TotalCaptureResult> physical =
                    logical.getPhysicalCameraTotalResults();
            TotalCaptureResult main = physical.get(String.valueOf(cameraId));
            if (main != null) {
                Long timestamp = safeResultValue(main,
                        CaptureResult.SENSOR_TIMESTAMP);
                if (timestamp != null && timestamp > 0L) {
                    return main;
                }
            }
        } catch (Throwable ignored) {
            // Logical metadata is a complete fallback for the main stream.
        }
        return logical;
    }

    private static int resolveLegendPhysicalCameraId(
            TotalCaptureResult logical, int captureCameraId) {
        if (captureCameraId != 0) {
            return captureCameraId;
        }
        int active = physicalIdFirst(valueByName(logical,
                "android.logicalMultiCamera.activePhysicalId"));
        if (isRearDirectCaptureCamera(active) && active != 0) {
            return active;
        }
        Float focal = safeResultValue(logical,
                CaptureResult.LENS_FOCAL_LENGTH);
        if (focal != null && Float.isFinite(focal) && focal > 0.0f) {
            int closest = closestRearCameraForFocalLength(focal);
            if (closest > 0) {
                return closest;
            }
        }
        try {
            Map<String, TotalCaptureResult> physical =
                    logical.getPhysicalCameraTotalResults();
            if (physical.size() == 1) {
                int only = Integer.parseInt(
                        physical.keySet().iterator().next());
                if (isRearDirectCaptureCamera(only) && only != 0) {
                    return only;
                }
            }
        } catch (Throwable ignored) {
            // Fall back to the runtime-classified main camera.
        }
        return rearMainPhysicalCameraId;
    }

    private static int physicalIdFirst(Object value) {
        try {
            if (value instanceof String) {
                return Integer.parseInt(((String) value).trim());
            }
            if (value instanceof byte[]) {
                String text = new String((byte[]) value,
                        StandardCharsets.UTF_8).replace("\0", "").trim();
                return Integer.parseInt(text);
            }
            if (value instanceof Number) {
                return ((Number) value).intValue();
            }
            if (value instanceof int[] && ((int[]) value).length > 0) {
                return ((int[]) value)[0];
            }
        } catch (Throwable ignored) {
            // Missing/opaque tags are expected on direct physical sessions.
        }
        return -1;
    }

    private static int closestRearCameraForFocalLength(float focal) {
        int[] candidates = {rearMainPhysicalCameraId,
                rearUltraWidePhysicalCameraId, rearTelePhysicalCameraId};
        int closest = -1;
        float error = Float.MAX_VALUE;
        for (int cameraId : candidates) {
            try {
                CameraCharacteristics characteristics =
                        CAMERA_CHARACTERISTICS.get(String.valueOf(cameraId));
                float[] values = characteristics == null ? null
                        : characteristics.get(CameraCharacteristics
                        .LENS_INFO_AVAILABLE_FOCAL_LENGTHS);
                if (values == null) {
                    continue;
                }
                for (float candidate : values) {
                    float candidateError = Math.abs(candidate - focal);
                    if (candidateError < error) {
                        error = candidateError;
                        closest = cameraId;
                    }
                }
            } catch (Throwable ignored) {
                // Try the remaining physical cameras.
            }
        }
        return closest;
    }

    private static float[] legendLensShadingMap(CaptureResult preferred,
            CaptureResult logical) {
        LensShadingMap map = safeResultValue(preferred,
                CaptureResult.STATISTICS_LENS_SHADING_CORRECTION_MAP);
        if (map == null && preferred != logical) {
            map = safeResultValue(logical,
                    CaptureResult.STATISTICS_LENS_SHADING_CORRECTION_MAP);
        }
        if (map == null) {
            throw new IllegalArgumentException("LSC map absent");
        }
        if (map.getRowCount() != 13 || map.getColumnCount() != 17
                || map.getGainFactorCount()
                != LegendM9Container.LSC_FLOATS) {
            throw new IllegalArgumentException("LSC geometry="
                    + map.getColumnCount() + "x" + map.getRowCount()
                    + " factors=" + map.getGainFactorCount());
        }
        float[] values = new float[map.getGainFactorCount()];
        map.copyGainFactors(values, 0);
        return values;
    }

    private static LegendM9Container.Metadata legendMetadata(
            CaptureResult preferred, CaptureResult logical,
            int taskOrientation, int cameraId) {
        Integer iso = resultOrLogical(preferred, logical,
                CaptureResult.SENSOR_SENSITIVITY);
        Long exposureNs = resultOrLogical(preferred, logical,
                CaptureResult.SENSOR_EXPOSURE_TIME);
        Integer jpegOrientation = resultOrLogical(preferred, logical,
                CaptureResult.JPEG_ORIENTATION);

        float awbR = floatByNames(preferred, logical,
                "org.quic.camera2.statsconfigs.AWBFrameControlRGain");
        float awbG = floatByNames(preferred, logical,
                "org.quic.camera2.statsconfigs.AWBFrameControlGGain");
        float awbB = floatByNames(preferred, logical,
                "org.quic.camera2.statsconfigs.AWBFrameControlBGain");
        if (!positive(awbR) || !positive(awbG) || !positive(awbB)) {
            RggbChannelVector gains = resultOrLogical(preferred, logical,
                    CaptureResult.COLOR_CORRECTION_GAINS);
            if (gains != null) {
                awbR = gains.getRed();
                awbG = (gains.getGreenEven() + gains.getGreenOdd()) * 0.5f;
                awbB = gains.getBlue();
            }
        }
        float adrc = floatByNames(preferred, logical,
                "org.quic.camera2.statsconfigs.AECCompenADRCGain",
                "com.qti.stats_control.drc_gain");
        float isp = floatByNames(preferred, logical,
                "org.quic.camera2.statsconfigs.AECLinearGain",
                "com.qti.sensorbps.gain");
        float cctValue = floatByNames(preferred, logical,
                "org.quic.camera2.statsconfigs.AWBFrameControlCCT",
                "com.qti.stats.awbwrapper.AWBCCT",
                "com.oplus.awb.colorsensor.CCT");
        float luxValue = floatByNames(preferred, logical,
                "org.quic.camera2.statsconfigs.AECLuxIndex",
                "com.qti.chi.statsaec.AecLux",
                "com.oplus.rawhdr.isp.luxindex",
                "com.oplus.light.sensor.lux");

        int black = dynamicBlackLevel(resultOrLogical(preferred, logical,
                CaptureResult.SENSOR_DYNAMIC_BLACK_LEVEL));
        Integer whiteResult = resultOrLogical(preferred, logical,
                CaptureResult.SENSOR_DYNAMIC_WHITE_LEVEL);
        int white = whiteResult == null ? -1 : whiteResult;
        CameraCharacteristics characteristics = CAMERA_CHARACTERISTICS.get(
                String.valueOf(cameraId));
        if (characteristics == null) {
            characteristics = CAMERA_CHARACTERISTICS.get("0");
        }
        if (black < 0 && characteristics != null) {
            black = staticBlackLevel(characteristics.get(
                    CameraCharacteristics.SENSOR_BLACK_LEVEL_PATTERN));
        }
        if (white < 0 && characteristics != null) {
            Integer staticWhite = characteristics.get(
                    CameraCharacteristics.SENSOR_INFO_WHITE_LEVEL);
            white = staticWhite == null ? -1 : staticWhite;
        }
        // The M9 tail describes packed RAW10 even when its source was the
        // professional RAW_SENSOR stream. Keep black/white levels in the same
        // ten-bit numeric domain as the packed Bayer samples.
        if (white > 1023) {
            if (black >= 0) {
                black = Math.round(black * (1023.0f / white));
            }
            white = 1023;
        }
        int orientation = taskOrientation;
        if (orientation != 0 && orientation != 90
                && orientation != 180 && orientation != 270) {
            orientation = jpegOrientation == null ? 0 : jpegOrientation;
        }
        int sensorType = legendSensorType(cameraId);
        int sourceCfa = legendSourceCfa(cameraId);
        return new LegendM9Container.Metadata(
                iso == null ? -1 : iso,
                awbR, awbG, awbB, adrc, isp,
                exposureNs == null ? Float.NaN
                        : exposureNs / 1_000_000.0f,
                orientation,
                Float.isFinite(cctValue) ? Math.round(cctValue) : -1,
                Float.isFinite(luxValue) ? Math.max(0,
                        Math.round(luxValue)) : -1,
                black, white, 0, sensorType, sourceCfa);
    }

    private static int legendSensorType(int cameraId) {
        if (cameraId == rearUltraWidePhysicalCameraId) {
            return 2;
        }
        if (cameraId == rearTelePhysicalCameraId) {
            return 3;
        }
        return 1;
    }

    private static int legendSourceCfa(int cameraId) {
        try {
            CameraCharacteristics characteristics =
                    CAMERA_CHARACTERISTICS.get(String.valueOf(cameraId));
            Integer value = characteristics == null ? null
                    : characteristics.get(CameraCharacteristics
                    .SENSOR_INFO_COLOR_FILTER_ARRANGEMENT);
            if (value != null && value >= 0 && value <= 3) {
                return value;
            }
        } catch (Throwable ignored) {
            // Use only the verified OnePlus 13 role fallbacks below.
        }
        if (cameraId == rearUltraWidePhysicalCameraId
                || cameraId == rearTelePhysicalCameraId) {
            return CameraCharacteristics
                    .SENSOR_INFO_COLOR_FILTER_ARRANGEMENT_GBRG;
        }
        return CameraCharacteristics.SENSOR_INFO_COLOR_FILTER_ARRANGEMENT_RGGB;
    }

    private static int dynamicBlackLevel(float[] values) {
        if (values == null || values.length == 0) {
            return -1;
        }
        float min = Float.POSITIVE_INFINITY;
        float max = Float.NEGATIVE_INFINITY;
        float sum = 0.0f;
        for (float value : values) {
            if (!Float.isFinite(value) || value < 0.0f) {
                return -1;
            }
            min = Math.min(min, value);
            max = Math.max(max, value);
            sum += value;
        }
        return max - min > 8.0f ? -1
                : Math.round(sum / values.length);
    }

    private static int staticBlackLevel(BlackLevelPattern pattern) {
        if (pattern == null) {
            return -1;
        }
        int[] values = {
                pattern.getOffsetForIndex(0, 0),
                pattern.getOffsetForIndex(1, 0),
                pattern.getOffsetForIndex(0, 1),
                pattern.getOffsetForIndex(1, 1)
        };
        int min = Integer.MAX_VALUE;
        int max = Integer.MIN_VALUE;
        int sum = 0;
        for (int value : values) {
            min = Math.min(min, value);
            max = Math.max(max, value);
            sum += value;
        }
        return max - min > 8 ? -1 : Math.round(sum / 4.0f);
    }

    private static float floatByNames(CaptureResult preferred,
            CaptureResult logical, String... names) {
        for (String name : names) {
            float value = floatFirst(valueByName(preferred, name));
            if (Float.isFinite(value)) {
                return value;
            }
            if (preferred != logical) {
                value = floatFirst(valueByName(logical, name));
                if (Float.isFinite(value)) {
                    return value;
                }
            }
        }
        return Float.NaN;
    }

    @SuppressWarnings({"rawtypes", "unchecked"})
    private static Object valueByName(CaptureResult result, String name) {
        if (result == null) {
            return null;
        }
        try {
            for (CaptureResult.Key<?> key : result.getKeys()) {
                if (name.equals(key.getName())) {
                    return result.get((CaptureResult.Key) key);
                }
            }
        } catch (Throwable ignored) {
            // Vendor result keys vary by active physical sensor.
        }
        return null;
    }

    private static float floatFirst(Object value) {
        if (value instanceof Number) {
            return ((Number) value).floatValue();
        }
        if (value instanceof float[] && ((float[]) value).length > 0) {
            return ((float[]) value)[0];
        }
        if (value instanceof int[] && ((int[]) value).length > 0) {
            return ((int[]) value)[0];
        }
        if (value instanceof long[] && ((long[]) value).length > 0) {
            return ((long[]) value)[0];
        }
        return Float.NaN;
    }

    private static boolean positive(float value) {
        return Float.isFinite(value) && value > 0.0f;
    }

    private static <T> T resultOrLogical(CaptureResult preferred,
            CaptureResult logical, CaptureResult.Key<T> key) {
        T value = safeResultValue(preferred, key);
        if (value == null && preferred != logical) {
            value = safeResultValue(logical, key);
        }
        return value;
    }

    private static String legendTaskBasename(Object task) {
        Object storage = XposedHelpers.getObjectField(task, "k");
        String value = objectStringField(storage, "b");
        if (value == null) {
            value = objectStringField(storage, "j");
        }
        if (value == null) {
            value = objectStringField(storage, "g");
        }
        if (value == null) {
            throw new IllegalArgumentException("save task basename absent");
        }
        return value;
    }

    private static String objectStringField(Object object, String field) {
        if (object == null) {
            return null;
        }
        try {
            Object value = XposedHelpers.getObjectField(object, field);
            return value instanceof String && !((String) value).isEmpty()
                    ? (String) value : null;
        } catch (Throwable ignored) {
            return null;
        }
    }

    /**
     * The OnePlus front camera exposes no Xiaomi beauty JSON scene.  OS4 then
     * falls back to the legacy shine item "1", although this APK's
     * FragmentBeauty no longer accepts that item and throws
     * RuntimeException("unknown beauty type").  Its built-in smooth panel is
     * item "2".  Normalize only the final front still/portrait list consumed
     * by FragmentBeauty; all rear, video and filter items remain untouched.
     */
    private static void hookFrontBeautyTypeCompatibility(ClassLoader loader) {
        Class<?> componentShine = XposedHelpers.findClass("v2.k0", loader);

        // Fix the unsupported value at its only constructor. Relying on F()
        // alone is too late: FragmentBeauty can retain the list item created
        // by r() even when the selected value returned by F() is normalized.
        XposedBridge.hookAllMethods(componentShine, "r", new XC_MethodHook() {
            @Override
            protected void afterHookedMethod(MethodHookParam param) {
                Object item = param.getResult();
                if (rewriteLegacyBeautyItem(item)) {
                    log("[BeautyCompat] legacy item factory 1 -> 2");
                }
            }
        });

        // R() is the component's mode/camera reInit boundary. Normalize both
        // collections because i0 is the exact list consumed by FragmentBeauty
        // while mItems is the source used by subsequent refreshes.
        XposedBridge.hookAllMethods(componentShine, "R", new XC_MethodHook() {
            @Override
            protected void afterHookedMethod(MethodHookParam param) {
                try {
                    int mode = XposedHelpers.getIntField(
                            param.thisObject, "mCurrentMode");
                    if (mode != 163 && mode != 171) {
                        return;
                    }
                    int rewritten = rewriteLegacyBeautyItems(
                            XposedHelpers.getObjectField(param.thisObject, "mItems"));
                    rewritten += rewriteLegacyBeautyItems(
                            XposedHelpers.getObjectField(param.thisObject, "i0"));
                    if (rewritten > 0) {
                        log("[BeautyCompat] reInit normalized mode=" + mode
                                + " rewritten=" + rewritten
                                + " types=" + describeBeautyTypes(
                                XposedHelpers.getObjectField(
                                        param.thisObject, "mItems")));
                    }
                } catch (Throwable throwable) {
                    log("[BeautyCompat] reInit normalization failed: "
                            + throwable);
                }
            }
        });

        XposedBridge.hookAllMethods(componentShine, "F", new XC_MethodHook() {
            @Override
            protected void afterHookedMethod(MethodHookParam param) {
                try {
                    boolean front = XposedHelpers.getBooleanField(
                            param.thisObject, "a");
                    int mode = XposedHelpers.getIntField(
                            param.thisObject, "mCurrentMode");
                    if (!front || (mode != 163 && mode != 171)) {
                        return;
                    }

                    int rewritten = rewriteLegacyBeautyItems(
                            XposedHelpers.getObjectField(param.thisObject, "i0"));
                    Object selected = param.getResult();
                    if ("1".equals(selected)) {
                        param.setResult("2");
                        rewritten++;
                    }
                    if (rewritten > 0) {
                        log("[BeautyCompat] front mode=" + mode
                                + " legacy item 1 -> smooth item 2; changes="
                                + rewritten);
                    }
                } catch (Throwable throwable) {
                    log("[BeautyCompat] final-list normalization failed: "
                            + throwable);
                }
            }
        });

        // nr() is called immediately before FragmentBeauty iterates i0. This
        // is the last safe boundary at which the full fragment can still be
        // initialized normally; do not suppress its RuntimeException after a
        // partially-built view hierarchy.
        Class<?> fragmentBeauty = XposedHelpers.findClass(
                "com.android.camera.fragment.M", loader);
        XposedBridge.hookAllMethods(fragmentBeauty, "nr", new XC_MethodHook() {
            @Override
            protected void beforeHookedMethod(MethodHookParam param) {
                try {
                    if (param.args != null && param.args.length == 1
                            && "1".equals(param.args[0])) {
                        param.args[0] = "2";
                    }
                    Object shine = XposedHelpers.getObjectField(
                            param.thisObject, "n");
                    if (shine == null) {
                        return;
                    }
                    int mode = XposedHelpers.getIntField(shine, "mCurrentMode");
                    if (mode != 163 && mode != 171) {
                        return;
                    }
                    Object finalItems = XposedHelpers.getObjectField(shine, "i0");
                    int rewritten = rewriteLegacyBeautyItems(finalItems);
                    log("[BeautyCompat] pre-consume mode=" + mode
                            + " remainingLegacy=" + countBeautyType(finalItems, "1")
                            + " rewritten=" + rewritten
                            + " types=" + describeBeautyTypes(finalItems));
                } catch (Throwable throwable) {
                    log("[BeautyCompat] pre-consume normalization failed: "
                            + throwable);
                }
            }
        });

        // Type 2 is Xiaomi's simple smooth slider. Type 4 is its separate
        // remodeling page; the APK has a complete implementation but rejects
        // it because BeautyUtils has no OPlus scene adapter. Mark only this
        // built-in type as valid, then populate it with the eight preferences
        // that have a proven one-to-one OPlus HAL13 mapping.
        Class<?> beautyUtils = XposedHelpers.findClass("F1.u0", loader);
        XposedBridge.hookAllMethods(beautyUtils, "e", new XC_MethodHook() {
            @Override
            protected void afterHookedMethod(MethodHookParam param) {
                if (param.args != null && param.args.length == 1
                        && "4".equals(param.args[0])) {
                    param.setResult(true);
                }
            }
        });

        Class<?> typeElementsBeauty = XposedHelpers.findClass("fn.c", loader);
        XposedBridge.hookAllMethods(typeElementsBeauty, "f", new XC_MethodHook() {
            @Override
            protected void beforeHookedMethod(MethodHookParam param) {
                if (param.args != null && param.args.length == 3
                        && "4".equals(param.args[2])) {
                    param.setObjectExtra("os4OplusBeautyPanel", Boolean.TRUE);
                }
            }

            @Override
            protected void afterHookedMethod(MethodHookParam param) {
                if (!Boolean.TRUE.equals(param.getObjectExtra(
                        "os4OplusBeautyPanel"))) {
                    return;
                }
                try {
                    String[] keys = new String[]{
                            "pref_beautify_skin_smooth_ratio_key",
                            "pref_beautify_slim_face_ratio_key",
                            "pref_beautify_enlarge_eye_ratio_key",
                            "pref_beautify_down_head_narrow",
                            "pref_beautify_slim_nose_ratio_key",
                            "pref_beautify_hairline_ratio_key",
                            "pref_beautify_temple",
                            "pref_beautify_cheekbone"
                    };
                    ArrayList<Object> controls = new ArrayList<>(keys.length);
                    for (String key : keys) {
                        Object control = XposedHelpers.callStaticMethod(
                                typeElementsBeauty, "c", "4", key,
                                false, param.args[1]);
                        if (control != null) {
                            controls.add(control);
                        }
                    }
                    param.setResult(controls);
                    log("[BeautyCompat] OPlus mapped controls="
                            + controls.size());
                } catch (Throwable throwable) {
                    log("[BeautyCompat] mapped panel construction failed: "
                            + throwable);
                }
            }
        });
        XposedBridge.hookAllMethods(typeElementsBeauty, "g", new XC_MethodHook() {
            @Override
            protected void beforeHookedMethod(MethodHookParam param) {
                if (param.args != null && param.args.length == 5
                        && "4".equals(param.args[0])
                        && Boolean.TRUE.equals(param.args[3])) {
                    param.args[3] = false;
                }
            }
        });
        log("[BeautyCompat] still/portrait simple+mapped-panel bridge active");
    }

    private static boolean rewriteLegacyBeautyItem(Object item) {
        if (item == null) {
            return false;
        }
        try {
            if ("1".equals(XposedHelpers.getObjectField(item, "q"))) {
                XposedHelpers.setObjectField(item, "q", "2");
                return true;
            }
        } catch (Throwable ignored) {
            // Not a component data item.
        }
        return false;
    }

    private static int rewriteLegacyBeautyItems(Object rawItems) {
        if (!(rawItems instanceof List<?>)) {
            return 0;
        }
        int rewritten = 0;
        for (Object item : (List<?>) rawItems) {
            if (item == null) {
                continue;
            }
            if (rewriteLegacyBeautyItem(item)) {
                rewritten++;
            }
        }
        return rewritten;
    }

    private static int countBeautyType(Object rawItems, String wanted) {
        if (!(rawItems instanceof List<?>)) {
            return -1;
        }
        int count = 0;
        for (Object item : (List<?>) rawItems) {
            if (item == null) {
                continue;
            }
            try {
                if (wanted.equals(XposedHelpers.getObjectField(item, "q"))) {
                    count++;
                }
            } catch (Throwable ignored) {
                // Mixed lists are allowed.
            }
        }
        return count;
    }

    private static String describeBeautyTypes(Object rawItems) {
        if (!(rawItems instanceof List<?>)) {
            return "[]";
        }
        ArrayList<String> types = new ArrayList<>();
        for (Object item : (List<?>) rawItems) {
            try {
                types.add(String.valueOf(
                        XposedHelpers.getObjectField(item, "q")));
            } catch (Throwable ignored) {
                types.add("?");
            }
        }
        return types.toString();
    }

    /** Mode routing must not depend on optional beauty helper compatibility. */
    private static void hookCameraModuleLifecycle(ClassLoader loader)
            throws ReflectiveOperationException {
        Method initialize = CameraModuleContract.resolveInitializer(loader);
        XposedBridge.hookMethod(initialize, new XC_MethodHook() {
            @Override
            protected void beforeHookedMethod(MethodHookParam param) {
                try {
                    int module = XposedHelpers.getIntField(
                            param.thisObject, "mModuleIndex");
                    activeCameraModule = module;
                    activeBeautyModule = (module == 163 || module == 171)
                            ? module : -1;
                    activeBeautyEnabled = false;
                    activeBeautyUi13 = new int[13];
                    activeBeautyPreviewHal14 = new int[14];
                    lastBeautyRequestSignature = "";
                    log("[ModuleContract] module=" + module
                            + " scope=" + activeBeautyModule);
                } catch (Throwable throwable) {
                    activeCameraModule = -1;
                    activeBeautyModule = -1;
                    activeBeautyEnabled = false;
                    activeBeautyUi13 = new int[13];
                    activeBeautyPreviewHal14 = new int[14];
                    log("[ModuleContract] module scope failed: " + throwable);
                }
            }
        });
        log("[ModuleContract] bound " + initialize.getDeclaringClass().getName()
                + "#init()");
    }

    /** Translate Xiaomi beauty preferences at its common request boundary. */
    private static void hookOplusBeautyRequestBridge(ClassLoader loader) {
        Class<?> beautyValues = XposedHelpers.findClass("x4.r", loader);
        Class<?> beautyPreferences = XposedHelpers.findClass(
                "com.android.camera.data.data.i", loader);
        Class<?> beautyApplier = XposedHelpers.findClass("n9.b", loader);
        XposedHelpers.findAndHookMethod(
                beautyApplier,
                "f",
                CaptureRequest.Builder.class,
                Map.class,
                java.util.Set.class,
                beautyValues,
                new XC_MethodHook() {
                    @Override
                    protected void afterHookedMethod(MethodHookParam param) {
                        if (activeBeautyModule != 163
                                && activeBeautyModule != 171) {
                            return;
                        }
                        if (param.args == null || param.args.length != 4
                                || !(param.args[0]
                                instanceof CaptureRequest.Builder)
                                || param.args[3] == null) {
                            return;
                        }
                        try {
                            CaptureRequest.Builder builder =
                                    (CaptureRequest.Builder) param.args[0];
                            int[] ui13 = buildOplusBeautyUi13(
                                    param.args[3], beautyPreferences);
                            int[] previewHal14 =
                                    convertOplusBeautyUiToPreviewHal(ui13);
                            boolean enabled = false;
                            for (int value : ui13) {
                                if (value != 0) {
                                    enabled = true;
                                    break;
                                }
                            }
                            int[] level = new int[]{enabled ? 102 : 0};
                            activeBeautyUi13 = ui13.clone();
                            activeBeautyPreviewHal14 = previewHal14.clone();
                            activeBeautyEnabled = enabled;
                            builder.set(OPLUS_FACE_BEAUTY_LEVEL, level);
                            // Stock ColorOS requests expose the semantic
                            // custom-menu array here. The native preview JNI
                            // consumes a separate 14-slot reordered array.
                            builder.set(OPLUS_FACE_BEAUTY_CUSTOM, ui13);
                            if (activeBeautyModule == 171) {
                                builder.set(OPLUS_CAMERA_MODE,
                                        "portrait_mode\0".getBytes(
                                                StandardCharsets.UTF_8));
                                builder.set(OPLUS_BOKEH_LEVEL,
                                        new float[]{0.27f});
                            }

                            String signature = activeBeautyModule + ":"
                                    + Arrays.toString(level) + ":"
                                    + Arrays.toString(ui13);
                            if (!signature.equals(lastBeautyRequestSignature)) {
                                lastBeautyRequestSignature = signature;
                                log("[BeautyBridge] module="
                                        + activeBeautyModule
                                        + " level=" + Arrays.toString(level)
                                        + " ui13="
                                        + Arrays.toString(ui13)
                                        + " previewHal14="
                                        + Arrays.toString(previewHal14));
                            }
                        } catch (Throwable throwable) {
                            log("[BeautyBridge] request injection failed: "
                                    + throwable);
                        }
                    }
                });
        log("[BeautyBridge] Xiaomi BeautyValues -> OPlus HAL13 active for"
                + " still/portrait");
    }

    private static int[] buildOplusBeautyUi13(
            Object values, Class<?> beautyPreferences) {
        // ColorOS custom-menu semantic order: smooth, whitening, thin-face,
        // touch-up, little-head, big-eye, narrow-face, short-face, hairline,
        // temple, cheekbone, thin-nose and 3D/solid.
        int[] ui = new int[13];
        // Read the user's component preferences directly. Xiaomi's d0()
        // deliberately omits several fields when the foreign HAL advertises
        // beauty version 1, even though the UI persists them correctly. The
        // preference boundary is therefore the authoritative value source for
        // the mapped OPlus panel; BeautyValues remains a safe fallback.
        ui[0] = beautyPreference(beautyPreferences, values,
                "pref_beautify_skin_smooth_ratio_key", "d", true);
        ui[1] = 0;
        ui[2] = beautyPreference(beautyPreferences, values,
                "pref_beautify_slim_face_ratio_key", "c", true);
        ui[3] = 0;
        ui[4] = beautyPreference(beautyPreferences, values,
                "pref_beautify_down_head_narrow", "q", true);
        ui[5] = beautyPreference(beautyPreferences, values,
                "pref_beautify_enlarge_eye_ratio_key", "e", true);
        ui[6] = 0;
        ui[7] = 0;
        ui[8] = beautyPreference(beautyPreferences, values,
                "pref_beautify_hairline_ratio_key", "m", false);
        ui[9] = beautyPreference(beautyPreferences, values,
                "pref_beautify_temple", "s", true);
        ui[10] = beautyPreference(beautyPreferences, values,
                "pref_beautify_cheekbone", "t", true);
        ui[11] = beautyPreference(beautyPreferences, values,
                "pref_beautify_slim_nose_ratio_key", "l", true);
        ui[12] = 0;
        return ui;
    }

    /** Exact ColorOS FilterUtil custom-menu to preview-engine mapping. */
    private static int[] convertOplusBeautyUiToPreviewHal(int[] ui) {
        int[] hal = new int[14];
        if (ui == null || ui.length < 13) {
            return hal;
        }
        hal[0] = ui[0];
        hal[1] = ui[2];
        hal[2] = ui[4];
        hal[3] = 0;
        hal[4] = ui[5];
        hal[5] = ui[11];
        hal[6] = 0;
        hal[7] = ui[12];
        hal[8] = ui[7];
        hal[9] = ui[6];
        hal[10] = ui[8];
        hal[11] = ui[9];
        hal[12] = ui[10];
        hal[13] = ui[1];
        return hal;
    }

    /**
     * Runs ColorOS' actual face-beauty renderer inside Xiaomi's GL thread.
     * ru.i.f() has just copied the camera OES texture into the current input
     * side of su.a's double buffer. The native engine writes the other side;
     * only a successful native return swaps it into the rest of Xiaomi's
     * preview pipeline.
     */
    private static void hookOplusPreviewBeauty(ClassLoader loader) {
        Class<?> previewRenderEngine = XposedHelpers.findClass("ru.i", loader);

        XposedBridge.hookAllMethods(previewRenderEngine, "k",
                new XC_MethodHook() {
                    @Override
                    protected void afterHookedMethod(MethodHookParam param) {
                        if (isOplusPreviewBeautyRequested()) {
                            // Force Xiaomi to materialize the OES camera frame
                            // as a 2D double-buffer texture even when no stock
                            // renderer is active.
                            param.setResult(true);
                        }
                    }
                });

        XposedBridge.hookAllMethods(previewRenderEngine, "f",
                new XC_MethodHook() {
                    @Override
                    protected void afterHookedMethod(MethodHookParam param) {
                        if (!isOplusPreviewBeautyRequested()
                                || param.args == null
                                || param.args.length != 2
                                || !Boolean.TRUE.equals(param.args[1])) {
                            return;
                        }
                        processOplusPreviewBeauty(param.thisObject);
                    }
                });

        log("[PreviewBeauty] real ColorOS texture hook active at ru.i.f");
    }

    private static void hookOplusPreviewMetadata() {
        XposedBridge.hookAllConstructors(TotalCaptureResult.class,
                new XC_MethodHook() {
                    @Override
                    protected void afterHookedMethod(MethodHookParam param) {
                        if (!(param.thisObject instanceof TotalCaptureResult)
                                || activeCameraId != 1
                                || (activeBeautyModule != 163
                                && activeBeautyModule != 171)) {
                            return;
                        }
                        TotalCaptureResult result =
                                (TotalCaptureResult) param.thisObject;
                        try {
                            byte[] sensor = result.get(
                                    OPLUS_SENSOR_NAME_RESULT);
                            if (sensor != null && sensor.length > 0) {
                                latestFrontSensorName = sensor.clone();
                                if (!loggedFrontSensorName) {
                                    loggedFrontSensorName = true;
                                    log("[BeautyMeta] front sensor="
                                            + printableSensorName(sensor)
                                            + " bytes=" + sensor.length);
                                }
                            }
                        } catch (Throwable ignored) {
                            // The verified dodgefront fallback remains valid.
                        }
                        try {
                            Long timestamp = result.get(
                                    CaptureResult.SENSOR_TIMESTAMP);
                            int[] faceInfo = result.get(
                                    OPLUS_FB_FACE_INFO_RESULT);
                            int[] ffd = result.get(
                                    OPLUS_PREVIEW_FFD_RESULT);
                            if (timestamp == null || timestamp <= 0L
                                    || faceInfo == null) {
                                if (!loggedBeautyMetadataWaiting) {
                                    loggedBeautyMetadataWaiting = true;
                                    log("[BeautyMeta] waiting sensorTs="
                                            + timestamp + " faceInfo="
                                            + (faceInfo == null ? "null"
                                            : faceInfo.length) + " ffd="
                                            + (ffd == null ? "null"
                                            : ffd.length));
                                }
                                return;
                            }
                            OplusBeautyMetadataFrame frame =
                                    new OplusBeautyMetadataFrame(
                                    timestamp,
                                    packOplusBeautyMetadata(
                                            timestamp, faceInfo),
                                    ffd == null ? null
                                            : packOplusBeautyMetadata(
                                            timestamp, ffd),
                                    faceInfo.length,
                                    ffd == null ? -1 : ffd.length,
                                    faceInfo.length > 1 ? faceInfo[1] : -1,
                                    SystemClock.elapsedRealtime());
                            latestBeautyMetadata = frame;
                            if (!loggedBeautyMetadataActive) {
                                loggedBeautyMetadataActive = true;
                                log("[BeautyMeta] face info active ts="
                                        + timestamp + " ints="
                                        + frame.faceIntCount + " faces="
                                        + frame.faceCount);
                            }
                            if (frame.ffdPayload != null
                                    && !loggedBeautyFfdActive) {
                                loggedBeautyFfdActive = true;
                                log("[BeautyMeta] ffd active ts="
                                        + timestamp + " ints="
                                        + frame.ffdIntCount);
                            }
                        } catch (Throwable throwable) {
                            if (!loggedBeautyMetadataWaiting) {
                                loggedBeautyMetadataWaiting = true;
                                log("[BeautyMeta] result read failed: "
                                        + throwable);
                            }
                        }
                    }
                });
        log("[BeautyMeta] TotalCaptureResult observer active");
    }

    private static boolean isOplusPreviewBeautyRequested() {
        return activeCameraId == 1
                && (activeBeautyModule == 163 || activeBeautyModule == 171)
                && activeBeautyEnabled;
    }

    private static void processOplusPreviewBeauty(Object renderOwner) {
        synchronized (PREVIEW_BEAUTY_LOCK) {
            long now = SystemClock.uptimeMillis();
            if (now < previewBeautyRetryAfterMs) {
                return;
            }
            try {
                Object doubleBuffer = XposedHelpers.getObjectField(
                        renderOwner, "D");
                if (doubleBuffer == null) {
                    return;
                }
                Object inputBuffer = XposedHelpers.getObjectField(
                        doubleBuffer, "a");
                Object outputBuffer = XposedHelpers.getObjectField(
                        doubleBuffer, "b");
                if (inputBuffer == null || outputBuffer == null) {
                    return;
                }
                int[] inputTextures = (int[]) XposedHelpers.getObjectField(
                        inputBuffer, "b");
                int[] outputTextures = (int[]) XposedHelpers.getObjectField(
                        outputBuffer, "b");
                Size size = (Size) XposedHelpers.getObjectField(
                        inputBuffer, "d");
                if (inputTextures == null || inputTextures.length == 0
                        || outputTextures == null
                        || outputTextures.length == 0 || size == null
                        || inputTextures[0] <= 0 || outputTextures[0] <= 0) {
                    return;
                }

                Object eglContext = android.opengl.EGL14
                        .eglGetCurrentContext();
                if (eglContext == null || eglContext == android.opengl.EGL14
                        .EGL_NO_CONTEXT) {
                    return;
                }
                int width = size.getWidth();
                int height = size.getHeight();
                int nativeWidth = Math.max(width, height);
                int nativeHeight = Math.min(width, height);
                int capmode = activeBeautyModule == 171 ? 2 : 0;
                ensureTargetPreviewNamespaceLoaded();
                probeTargetSphalClosure();
                if (!PREVIEW_NATIVE_PROCESS_ENABLED) {
                    return;
                }
                if (previewBeautyEngine == null
                        || previewBeautyRenderOwner != renderOwner
                        || previewBeautyEglContext != eglContext
                        || previewBeautyWidth != nativeWidth
                        || previewBeautyHeight != nativeHeight) {
                    destroyOplusPreviewBeautyOnGlThread();
                }

                if (!ensurePreviewBeautyGlResources(
                        nativeWidth, nativeHeight)) {
                    previewBeautyRetryAfterMs = now + 1000L;
                    return;
                }

                if (previewBeautyEngine == null) {
                    ensureOplusPreviewLibraryLoaded();
                    OplusFaceBeautyPreview engine =
                            new OplusFaceBeautyPreview();
                    applyOplusPreviewParameters(engine,
                            activeBeautyPreviewHal14, true);
                    byte[] sensorName = resolvedFrontSensorName();
                    int init = engine.init(nativeWidth, nativeHeight,
                            7, 1, "", "",
                            Locale.getDefault().toLanguageTag(),
                            true, true, sensorName, capmode);
                    if (init != 0) {
                        try {
                            engine.destroy();
                        } catch (Throwable ignored) {
                            // Failed initialization may have no native handle.
                        }
                        previewBeautyRetryAfterMs = now + 5000L;
                        log("[PreviewBeauty] native init failed ret=" + init
                                + " size=" + nativeWidth + "x"
                                + nativeHeight + " sensor="
                                + printableSensorName(sensorName)
                                + " capmode=" + capmode);
                        return;
                    }
                    previewBeautyEngine = engine;
                    previewBeautyRenderOwner = renderOwner;
                    previewBeautyEglContext = eglContext;
                    previewBeautyWidth = nativeWidth;
                    previewBeautyHeight = nativeHeight;
                    previewBeautyParameterSignature = "";
                    previewBeautyFirstFrameLogged = false;
                    submittedBeautyMetaTimestamp = Long.MIN_VALUE;
                    submittedBeautyFfdTimestamp = Long.MIN_VALUE;
                    log("[PreviewBeauty] native init success version=7 size="
                            + nativeWidth + "x" + nativeHeight
                            + " sensor=" + printableSensorName(sensorName)
                            + " capmode=" + capmode);
                }

                int[] parameters = activeBeautyPreviewHal14.clone();
                String signature = activeBeautyEnabled + ":"
                        + Arrays.toString(parameters);
                if (!signature.equals(previewBeautyParameterSignature)) {
                    applyOplusPreviewParameters(previewBeautyEngine,
                            parameters, activeBeautyEnabled);
                    previewBeautyParameterSignature = signature;
                    log("[PreviewBeauty] native params ui13="
                            + Arrays.toString(activeBeautyUi13)
                            + " hal14=" + Arrays.toString(parameters));
                }

                int inputRotation = width < height ? 1 : 0;
                if (!blitPreviewBeautyTexture(inputTextures[0],
                        previewBeautyLandscapeInputFramebuffer,
                        nativeWidth, nativeHeight, inputRotation)) {
                    return;
                }
                feedOplusPreviewMetadata(previewBeautyEngine);

                int slot = previewBeautyOutputIndex++ & 1;
                int landscapeOutput =
                        previewBeautyLandscapeOutputTextures[slot];
                int result = previewBeautyEngine.process(
                        previewBeautyLandscapeInputTexture,
                        new int[]{landscapeOutput},
                        new int[]{1, nativeWidth, nativeHeight}, parameters);
                if (result == 0) {
                    GLES20.glBindFramebuffer(GLES20.GL_FRAMEBUFFER,
                            previewBeautyPortraitOutputFramebuffer);
                    GLES20.glFramebufferTexture2D(
                            GLES20.GL_FRAMEBUFFER,
                            GLES20.GL_COLOR_ATTACHMENT0,
                            GLES20.GL_TEXTURE_2D, outputTextures[0], 0);
                    int framebufferStatus = GLES20
                            .glCheckFramebufferStatus(
                                    GLES20.GL_FRAMEBUFFER);
                    GLES20.glBindFramebuffer(GLES20.GL_FRAMEBUFFER, 0);
                    if (framebufferStatus
                            != GLES20.GL_FRAMEBUFFER_COMPLETE) {
                        if (now - previewBeautyLastErrorMs > 3000L) {
                            previewBeautyLastErrorMs = now;
                            log("[PreviewBeauty] Xiaomi output FBO"
                                    + " incomplete=0x"
                                    + Integer.toHexString(
                                    framebufferStatus));
                        }
                        return;
                    }
                    int outputRotation = width < height ? -1 : 0;
                    if (!blitPreviewBeautyTexture(landscapeOutput,
                            previewBeautyPortraitOutputFramebuffer,
                            width, height, outputRotation)) {
                        return;
                    }
                    XposedHelpers.callMethod(doubleBuffer, "d");
                    if (!previewBeautyFirstFrameLogged) {
                        previewBeautyFirstFrameLogged = true;
                        log("[PreviewBeauty] first processed texture swapped"
                                + " input=" + inputTextures[0]
                                + " landscape="
                                + previewBeautyLandscapeInputTexture
                                + " nativeOut=" + landscapeOutput
                                + " XiaomiOut=" + outputTextures[0]
                                + " display=" + width + "x" + height
                                + " native=" + nativeWidth + "x"
                                + nativeHeight);
                    }
                } else if (now - previewBeautyLastErrorMs > 3000L) {
                    previewBeautyLastErrorMs = now;
                    log("[PreviewBeauty] native process bypass ret=" + result);
                }
            } catch (Throwable throwable) {
                previewBeautyRetryAfterMs = now + 5000L;
                if (now - previewBeautyLastErrorMs > 3000L) {
                    previewBeautyLastErrorMs = now;
                    log("[PreviewBeauty] native bridge bypass: " + throwable);
                }
                destroyOplusPreviewBeautyOnGlThread();
            }
        }
    }

    private static boolean ensurePreviewBeautyGlResources(
            int width, int height) {
        if (previewBeautyLandscapeInputTexture != 0
                && previewBeautyLandscapeInputFramebuffer != 0
                && previewBeautyLandscapeOutputTextures[0] != 0
                && previewBeautyLandscapeOutputTextures[1] != 0
                && previewBeautyPortraitOutputFramebuffer != 0
                && previewBeautyBlitProgram != 0) {
            return true;
        }
        previewBeautyLandscapeInputTexture =
                createPreviewBeautyTexture(width, height);
        previewBeautyLandscapeInputFramebuffer =
                createPreviewBeautyFramebuffer(
                        previewBeautyLandscapeInputTexture);
        GLES20.glGenTextures(
                previewBeautyLandscapeOutputTextures.length,
                previewBeautyLandscapeOutputTextures, 0);
        for (int texture : previewBeautyLandscapeOutputTextures) {
            configurePreviewBeautyTexture(texture, width, height);
        }
        int[] framebuffer = new int[1];
        GLES20.glGenFramebuffers(1, framebuffer, 0);
        previewBeautyPortraitOutputFramebuffer = framebuffer[0];
        previewBeautyBlitProgram = createPreviewBeautyBlitProgram();
        GLES20.glBindTexture(GLES20.GL_TEXTURE_2D, 0);
        boolean ready = previewBeautyLandscapeInputTexture != 0
                && previewBeautyLandscapeInputFramebuffer != 0
                && previewBeautyLandscapeOutputTextures[0] != 0
                && previewBeautyLandscapeOutputTextures[1] != 0
                && previewBeautyPortraitOutputFramebuffer != 0
                && previewBeautyBlitProgram != 0;
        log("[PreviewBeauty] GL resources ready=" + ready
                + " native=" + width + "x" + height
                + " input=" + previewBeautyLandscapeInputTexture
                + " outputs=" + Arrays.toString(
                previewBeautyLandscapeOutputTextures));
        return ready;
    }

    private static int createPreviewBeautyTexture(int width, int height) {
        int[] texture = new int[1];
        GLES20.glGenTextures(1, texture, 0);
        configurePreviewBeautyTexture(texture[0], width, height);
        return texture[0];
    }

    private static void configurePreviewBeautyTexture(
            int texture, int width, int height) {
        GLES20.glBindTexture(GLES20.GL_TEXTURE_2D, texture);
        GLES20.glTexParameteri(GLES20.GL_TEXTURE_2D,
                GLES20.GL_TEXTURE_MIN_FILTER, GLES20.GL_LINEAR);
        GLES20.glTexParameteri(GLES20.GL_TEXTURE_2D,
                GLES20.GL_TEXTURE_MAG_FILTER, GLES20.GL_LINEAR);
        GLES20.glTexParameteri(GLES20.GL_TEXTURE_2D,
                GLES20.GL_TEXTURE_WRAP_S, GLES20.GL_CLAMP_TO_EDGE);
        GLES20.glTexParameteri(GLES20.GL_TEXTURE_2D,
                GLES20.GL_TEXTURE_WRAP_T, GLES20.GL_CLAMP_TO_EDGE);
        GLES20.glTexImage2D(GLES20.GL_TEXTURE_2D, 0, GLES20.GL_RGBA,
                width, height, 0, GLES20.GL_RGBA,
                GLES20.GL_UNSIGNED_BYTE, null);
    }

    private static int createPreviewBeautyFramebuffer(int texture) {
        int[] framebuffer = new int[1];
        GLES20.glGenFramebuffers(1, framebuffer, 0);
        GLES20.glBindFramebuffer(GLES20.GL_FRAMEBUFFER, framebuffer[0]);
        GLES20.glFramebufferTexture2D(GLES20.GL_FRAMEBUFFER,
                GLES20.GL_COLOR_ATTACHMENT0, GLES20.GL_TEXTURE_2D,
                texture, 0);
        int status = GLES20.glCheckFramebufferStatus(
                GLES20.GL_FRAMEBUFFER);
        GLES20.glBindFramebuffer(GLES20.GL_FRAMEBUFFER, 0);
        if (status != GLES20.GL_FRAMEBUFFER_COMPLETE) {
            log("[PreviewBeauty] landscape FBO incomplete=0x"
                    + Integer.toHexString(status));
            GLES20.glDeleteFramebuffers(1, framebuffer, 0);
            return 0;
        }
        return framebuffer[0];
    }

    private static int createPreviewBeautyBlitProgram() {
        String vertex = "attribute vec2 aPosition;"
                + "attribute vec2 aTexCoord;varying vec2 vTexCoord;"
                + "void main(){gl_Position=vec4(aPosition,0.0,1.0);"
                + "vTexCoord=aTexCoord;}";
        String fragment = "precision mediump float;"
                + "uniform sampler2D uTexture;varying vec2 vTexCoord;"
                + "void main(){gl_FragColor=texture2D(uTexture,vTexCoord);}";
        int vertexShader = compilePreviewBeautyShader(
                GLES20.GL_VERTEX_SHADER, vertex);
        int fragmentShader = compilePreviewBeautyShader(
                GLES20.GL_FRAGMENT_SHADER, fragment);
        if (vertexShader == 0 || fragmentShader == 0) {
            return 0;
        }
        int program = GLES20.glCreateProgram();
        GLES20.glAttachShader(program, vertexShader);
        GLES20.glAttachShader(program, fragmentShader);
        GLES20.glLinkProgram(program);
        int[] linked = new int[1];
        GLES20.glGetProgramiv(program, GLES20.GL_LINK_STATUS, linked, 0);
        GLES20.glDeleteShader(vertexShader);
        GLES20.glDeleteShader(fragmentShader);
        if (linked[0] == 0) {
            log("[PreviewBeauty] blit link failed: "
                    + GLES20.glGetProgramInfoLog(program));
            GLES20.glDeleteProgram(program);
            return 0;
        }
        return program;
    }

    private static int compilePreviewBeautyShader(
            int type, String source) {
        int shader = GLES20.glCreateShader(type);
        GLES20.glShaderSource(shader, source);
        GLES20.glCompileShader(shader);
        int[] compiled = new int[1];
        GLES20.glGetShaderiv(shader, GLES20.GL_COMPILE_STATUS,
                compiled, 0);
        if (compiled[0] == 0) {
            log("[PreviewBeauty] shader compile failed: "
                    + GLES20.glGetShaderInfoLog(shader));
            GLES20.glDeleteShader(shader);
            return 0;
        }
        return shader;
    }

    private static FloatBuffer directFloatBuffer(float[] values) {
        FloatBuffer buffer = ByteBuffer
                .allocateDirect(values.length * 4)
                .order(ByteOrder.nativeOrder()).asFloatBuffer();
        buffer.put(values).position(0);
        return buffer;
    }

    /** rotation: 1=clockwise, -1=counter-clockwise, 0=identity. */
    private static boolean blitPreviewBeautyTexture(
            int inputTexture, int outputFramebuffer,
            int outputWidth, int outputHeight, int rotation) {
        if (inputTexture == 0 || outputFramebuffer == 0
                || previewBeautyBlitProgram == 0) {
            return false;
        }
        int[] oldFramebuffer = new int[1];
        int[] oldProgram = new int[1];
        int[] oldViewport = new int[4];
        int[] oldActiveTexture = new int[1];
        GLES20.glGetIntegerv(GLES20.GL_FRAMEBUFFER_BINDING,
                oldFramebuffer, 0);
        GLES20.glGetIntegerv(GLES20.GL_CURRENT_PROGRAM, oldProgram, 0);
        GLES20.glGetIntegerv(GLES20.GL_VIEWPORT, oldViewport, 0);
        GLES20.glGetIntegerv(GLES20.GL_ACTIVE_TEXTURE,
                oldActiveTexture, 0);
        boolean blendEnabled = GLES20.glIsEnabled(GLES20.GL_BLEND);
        GLES20.glBindFramebuffer(GLES20.GL_FRAMEBUFFER, outputFramebuffer);
        GLES20.glViewport(0, 0, outputWidth, outputHeight);
        GLES20.glDisable(GLES20.GL_BLEND);
        GLES20.glUseProgram(previewBeautyBlitProgram);
        int position = GLES20.glGetAttribLocation(
                previewBeautyBlitProgram, "aPosition");
        int texCoord = GLES20.glGetAttribLocation(
                previewBeautyBlitProgram, "aTexCoord");
        int sampler = GLES20.glGetUniformLocation(
                previewBeautyBlitProgram, "uTexture");
        PREVIEW_QUAD_VERTICES.position(0);
        FloatBuffer coordinates = rotation > 0
                ? PREVIEW_TEX_ROTATE_CW
                : rotation < 0 ? PREVIEW_TEX_ROTATE_CCW
                : PREVIEW_TEX_IDENTITY;
        coordinates.position(0);
        GLES20.glEnableVertexAttribArray(position);
        GLES20.glEnableVertexAttribArray(texCoord);
        GLES20.glVertexAttribPointer(position, 2, GLES20.GL_FLOAT,
                false, 0, PREVIEW_QUAD_VERTICES);
        GLES20.glVertexAttribPointer(texCoord, 2, GLES20.GL_FLOAT,
                false, 0, coordinates);
        GLES20.glActiveTexture(GLES20.GL_TEXTURE0);
        GLES20.glBindTexture(GLES20.GL_TEXTURE_2D, inputTexture);
        GLES20.glUniform1i(sampler, 0);
        GLES20.glDrawArrays(GLES20.GL_TRIANGLE_STRIP, 0, 4);
        int error = GLES20.glGetError();
        GLES20.glDisableVertexAttribArray(position);
        GLES20.glDisableVertexAttribArray(texCoord);
        GLES20.glBindTexture(GLES20.GL_TEXTURE_2D, 0);
        GLES20.glUseProgram(oldProgram[0]);
        GLES20.glBindFramebuffer(GLES20.GL_FRAMEBUFFER,
                oldFramebuffer[0]);
        GLES20.glViewport(oldViewport[0], oldViewport[1],
                oldViewport[2], oldViewport[3]);
        GLES20.glActiveTexture(oldActiveTexture[0]);
        if (blendEnabled) {
            GLES20.glEnable(GLES20.GL_BLEND);
        }
        if (error != GLES20.GL_NO_ERROR) {
            log("[PreviewBeauty] blit GL error=0x"
                    + Integer.toHexString(error));
            return false;
        }
        return true;
    }

    private static void feedOplusPreviewMetadata(
            OplusFaceBeautyPreview engine) {
        OplusBeautyMetadataFrame frame = latestBeautyMetadata;
        long timestamp = System.nanoTime();
        if (frame != null && frame.timestamp > 0L
                && SystemClock.elapsedRealtime() - frame.observedElapsed
                <= 1500L) {
            timestamp = frame.timestamp;
            if (submittedBeautyMetaTimestamp != frame.timestamp
                    && engine.updataMetaParams(
                    frame.facePayload.clone()) == 0) {
                submittedBeautyMetaTimestamp = frame.timestamp;
            }
            if (frame.ffdPayload != null
                    && submittedBeautyFfdTimestamp != frame.timestamp
                    && engine.updataFfd(frame.ffdPayload.clone()) == 0) {
                submittedBeautyFfdTimestamp = frame.timestamp;
            }
            if (!loggedBeautyNativeFeed
                    && submittedBeautyMetaTimestamp == frame.timestamp) {
                loggedBeautyNativeFeed = true;
                log("[BeautyMeta] native feed active ts="
                        + frame.timestamp + " faces=" + frame.faceCount
                        + " ffd=" + (frame.ffdPayload != null));
            }
        }
        engine.updataPreviewParams(timestamp);
        engine.setPreviewParams("preview_zoom_state", "0");
    }

    private static byte[] packOplusBeautyMetadata(
            long timestamp, int[] values) {
        ByteBuffer buffer = ByteBuffer
                .allocate(8 + values.length * 4)
                .order(ByteOrder.LITTLE_ENDIAN);
        buffer.putLong(timestamp);
        for (int value : values) {
            buffer.putInt(value);
        }
        return buffer.array();
    }

    private static byte[] resolvedFrontSensorName() {
        byte[] observed = latestFrontSensorName;
        if (observed != null
                && printableSensorName(observed).startsWith("dodgefront")) {
            return observed.clone();
        }
        byte[] fallback = new byte[24];
        byte[] name = "dodgefront".getBytes(StandardCharsets.UTF_8);
        System.arraycopy(name, 0, fallback, 0, name.length);
        return fallback;
    }

    private static String printableSensorName(byte[] sensor) {
        if (sensor == null) {
            return "<null>";
        }
        int length = 0;
        while (length < sensor.length && sensor[length] != 0) {
            length++;
        }
        return new String(sensor, 0, length, StandardCharsets.UTF_8);
    }

    private static final class OplusBeautyMetadataFrame {
        final long timestamp;
        final byte[] facePayload;
        final byte[] ffdPayload;
        final int faceIntCount;
        final int ffdIntCount;
        final int faceCount;
        final long observedElapsed;

        OplusBeautyMetadataFrame(long timestamp, byte[] facePayload,
                byte[] ffdPayload, int faceIntCount, int ffdIntCount,
                int faceCount, long observedElapsed) {
            this.timestamp = timestamp;
            this.facePayload = facePayload;
            this.ffdPayload = ffdPayload;
            this.faceIntCount = faceIntCount;
            this.ffdIntCount = ffdIntCount;
            this.faceCount = faceCount;
            this.observedElapsed = observedElapsed;
        }
    }

    private static synchronized void ensureTargetPreviewNamespaceLoaded()
            throws Exception {
        if (targetPreviewWrapperClass != null) {
            return;
        }
        ClassLoader appLoader = cameraAppClassLoader;
        if (appLoader == null) {
            throw new IllegalStateException(
                    "camera app class loader unavailable");
        }
        String loaderDescription = String.valueOf(
                HookEntry.class.getClassLoader());
        String marker = "module=";
        int start = loaderDescription.indexOf(marker);
        int apkEnd = start < 0 ? -1
                : loaderDescription.indexOf("/base.apk", start);
        if (start < 0 || apkEnd < 0) {
            throw new IllegalStateException(
                    "module code path unavailable: " + loaderDescription);
        }
        String apkPath = loaderDescription.substring(
                start + marker.length(), apkEnd + "/base.apk".length());
        File codeDirectory = new File(apkPath).getParentFile();
        if (codeDirectory == null) {
            throw new IllegalStateException(
                    "invalid module APK path: " + apkPath);
        }
        File productJni = new File(new File(codeDirectory, "lib/arm64"),
                "libApsFaceBeautyPreviewJni.so");
        if (!productJni.isFile() || productJni.length() == 0L) {
            throw new IllegalStateException(
                    "module Product JNI missing: " + productJni);
        }

        // Define a second copy of the exact JNI wrapper in MiuiCamera's own
        // PathClassLoader. System.load() then associates the Product JNI with
        // the privileged camera namespace instead of LSPosed's clns-12.
        XposedHelpers.callMethod(appLoader, "addDexPath", apkPath);
        Class<?> wrapper = Class.forName(
                "com.oplus.camera.facebeauty.OplusFaceBeautyPreview",
                true, appLoader);
        if (wrapper.getClassLoader() != appLoader) {
            throw new IllegalStateException(
                    "wrapper escaped target loader: "
                            + wrapper.getClassLoader());
        }
        XposedHelpers.callStaticMethod(wrapper, "load",
                productJni.getAbsolutePath());
        targetPreviewWrapperClass = wrapper;
        targetModuleLibraryDirectory = productJni.getParentFile();
        if (!targetPreviewNamespaceLogged) {
            targetPreviewNamespaceLogged = true;
            log("[PreviewNamespace] Product JNI loaded through target="
                    + appLoader + " wrapper=" + wrapper.getClassLoader()
                    + " native=" + productJni);
        }
    }

    private static synchronized void probeTargetSphalClosure()
            throws Exception {
        if (targetSphalClosureProbed) {
            return;
        }
        ClassLoader appLoader = cameraAppClassLoader;
        File libraryDirectory = targetModuleLibraryDirectory;
        if (appLoader == null || libraryDirectory == null) {
            throw new IllegalStateException(
                    "target namespace was not initialized");
        }
        File probeLibrary = new File(libraryDirectory,
                "libsphalnamespaceprobe.so");
        if (!probeLibrary.isFile()) {
            throw new IllegalStateException(
                    "SPHAL probe JNI missing: " + probeLibrary);
        }
        Class<?> probeClass = Class.forName(
                "local.mio.os4camerabridge.target.SphalNamespaceProbe",
                true, appLoader);
        XposedHelpers.callStaticMethod(probeClass, "load",
                probeLibrary.getAbsolutePath());
        String[] closure = new String[]{
                "/odm/lib64/libFaceBeautyJni.so",
                "/odm/lib64/lib2DSlender.so",
                "/odm/lib64/libODNN.so"
        };
        for (String path : closure) {
            Object result = XposedHelpers.callStaticMethod(
                    probeClass, "probe", path);
            if (!Boolean.TRUE.equals(result)) {
                throw new IllegalStateException(
                        "system SPHAL closure missing: " + path);
            }
        }
        targetSphalClosureProbed = true;
        log("[PreviewNamespace] system SPHAL closure verified="
                + Arrays.toString(closure));
    }

    private static void ensureOplusPreviewLibraryLoaded()
            throws Exception {
        String loaderDescription = String.valueOf(
                HookEntry.class.getClassLoader());
        String marker = "module=";
        int start = loaderDescription.indexOf(marker);
        int apkEnd = start < 0 ? -1
                : loaderDescription.indexOf("/base.apk", start);
        if (start < 0 || apkEnd < 0) {
            throw new IllegalStateException(
                    "module code path unavailable: " + loaderDescription);
        }
        String apkPath = loaderDescription.substring(
                start + marker.length(), apkEnd + "/base.apk".length());
        File codeDirectory = new File(apkPath).getParentFile();
        if (codeDirectory == null) {
            throw new IllegalStateException("invalid module APK path: "
                    + apkPath);
        }
        File libraryDirectory = new File(codeDirectory, "lib/arm64");
        String[] dependencyOrder = new String[]{
                "libvndksupport.so",
                "lib2DSlender.so",
                "libFaceBeautyJni.so"
        };
        for (String name : dependencyOrder) {
            File dependency = new File(libraryDirectory, name);
            if (!dependency.isFile() || dependency.length() == 0L) {
                throw new IllegalStateException(
                        "module JNI dependency missing: " + dependency);
            }
            // LSPosed loads the module dex through its own isolated classloader
            // namespace. Loading only the Product JNI by absolute path does
            // not add the APK's nativeLibraryDir to that namespace's search
            // path, so its DT_NEEDED libvndksupport cannot be resolved even
            // though all four files were extracted beside it. Preload the
            // exact local closure into the same caller namespace first.
            System.load(dependency.getAbsolutePath());
        }
        File library = new File(libraryDirectory,
                "libApsFaceBeautyPreviewJni.so");
        if (!library.isFile() || library.length() == 0L) {
            throw new IllegalStateException("module JNI missing: " + library);
        }
        OplusFaceBeautyPreview.load(library.getAbsolutePath());
    }

    private static void applyOplusPreviewParameters(
            OplusFaceBeautyPreview engine, int[] parameters,
            boolean enabled) {
        engine.setPreviewParams("preview_face_beauty_enable",
                enabled ? "1" : "0");
        engine.setPreviewParams("preview_ai_video_state", "0");
        engine.setPreviewParams("preview_face_dr_state", "0");
        engine.setPreviewParams("preview_beauty_type",
                enabled ? "2" : "0");
        engine.setPreviewParams("preview_beauty_status",
                enabled ? "0" : "1");
        engine.setPreviewParams("preview_makeup_support", "false");
        engine.setPreviewParams("preview_makeup_type", "none");
        engine.setPreviewParams("preview_makeup_value", "0");
        engine.setPreviewParams("preview_texture_format", "0");
        engine.setPreviewParams("preview_StretchFace_value",
                String.valueOf(parameters[8]));
        engine.setPreviewParams("preview_NarrowFace_value",
                String.valueOf(parameters[9]));
        engine.setPreviewParams("preview_DragHairline_value",
                String.valueOf(parameters[10]));
        engine.setPreviewParams("preview_FullTemple_value",
                String.valueOf(parameters[11]));
        engine.setPreviewParams("preview_SqueezeZygoma_value",
                String.valueOf(parameters[12]));
        engine.setPreviewParams("preview_Whitening_value",
                String.valueOf(parameters[13]));
    }

    private static void destroyOplusPreviewBeautyOnGlThread() {
        if (previewBeautyEngine != null) {
            try {
                previewBeautyEngine.destroy();
            } catch (Throwable throwable) {
                log("[PreviewBeauty] native destroy warning: " + throwable);
            }
        }
        previewBeautyEngine = null;
        previewBeautyRenderOwner = null;
        previewBeautyEglContext = null;
        previewBeautyWidth = 0;
        previewBeautyHeight = 0;
        previewBeautyParameterSignature = "";
        previewBeautyFirstFrameLogged = false;
        submittedBeautyMetaTimestamp = Long.MIN_VALUE;
        submittedBeautyFfdTimestamp = Long.MIN_VALUE;
        loggedBeautyNativeFeed = false;
        if (previewBeautyLandscapeInputFramebuffer != 0) {
            GLES20.glDeleteFramebuffers(1,
                    new int[]{previewBeautyLandscapeInputFramebuffer}, 0);
        }
        if (previewBeautyPortraitOutputFramebuffer != 0) {
            GLES20.glDeleteFramebuffers(1,
                    new int[]{previewBeautyPortraitOutputFramebuffer}, 0);
        }
        if (previewBeautyLandscapeInputTexture != 0) {
            GLES20.glDeleteTextures(1,
                    new int[]{previewBeautyLandscapeInputTexture}, 0);
        }
        GLES20.glDeleteTextures(
                previewBeautyLandscapeOutputTextures.length,
                previewBeautyLandscapeOutputTextures, 0);
        if (previewBeautyBlitProgram != 0) {
            GLES20.glDeleteProgram(previewBeautyBlitProgram);
        }
        previewBeautyLandscapeInputTexture = 0;
        previewBeautyLandscapeInputFramebuffer = 0;
        previewBeautyLandscapeOutputTextures = new int[2];
        previewBeautyPortraitOutputFramebuffer = 0;
        previewBeautyBlitProgram = 0;
        previewBeautyOutputIndex = 0;
    }

    private static int beautyPreference(
            Class<?> preferences,
            Object values,
            String key,
            String fallbackField,
            boolean signed) {
        try {
            Object raw = XposedHelpers.callStaticMethod(preferences, "w", key);
            if (raw instanceof Integer) {
                int value = (Integer) raw;
                if (value != -1 && value != -1000) {
                    return signed
                            ? Math.max(-100, Math.min(100, value))
                            : Math.max(0, Math.min(100, value));
                }
            }
        } catch (Throwable ignored) {
            // Fall through to the request's BeautyValues snapshot.
        }
        return beautyField(values, fallbackField, signed);
    }

    private static int beautyField(
            Object values, String field, boolean signed) {
        int value = XposedHelpers.getIntField(values, field);
        if (value == -1 || value == -1000) {
            return 0;
        }
        return signed
                ? Math.max(-100, Math.min(100, value))
                : Math.max(0, Math.min(100, value));
    }

    private static void hookFrameworkRoleTags() {
        XposedHelpers.findAndHookMethod(
                CameraManager.class,
                "getCameraCharacteristics",
                String.class,
                new XC_MethodHook() {
                    @Override
                    protected void afterHookedMethod(MethodHookParam param) {
                        if (!param.hasThrowable() && param.getResult() instanceof CameraCharacteristics) {
                            CameraCharacteristics characteristics =
                                    (CameraCharacteristics) param.getResult();
                            String cameraId = (String) param.args[0];
                            CAMERA_IDS.put(characteristics, cameraId);
                            CAMERA_CHARACTERISTICS.put(cameraId,
                                    characteristics);
                            recordRearLensTopology(cameraId, characteristics);
                        }
                    }
                });

        XposedHelpers.findAndHookMethod(
                CameraCharacteristics.class,
                "get",
                CameraCharacteristics.Key.class,
                new XC_MethodHook() {
                    @Override
                    protected void beforeHookedMethod(MethodHookParam param) {
                        if (!(param.args[0] instanceof CameraCharacteristics.Key)) {
                            return;
                        }
                        String cameraId = CAMERA_IDS.get((CameraCharacteristics) param.thisObject);
                        if (cameraId == null) {
                            return;
                        }
                        String name = ((CameraCharacteristics.Key<?>) param.args[0]).getName();
                        if (isRoleIdsKey(name)) {
                            int[] roles = rolesFor(cameraId);
                            if (roles != null) {
                                param.setResult(roles.clone());
                                logRolesOnce("framework metadata", cameraId, roles);
                            }
                        } else if (isRoleIdKey(name)) {
                            Integer role = primaryRoleFor(cameraId);
                            if (role != null) {
                                param.setResult(role);
                            }
                        }
                    }
                });
    }

    private static void hookRoleContainer(ClassLoader loader) {
        Class<?> roleContainer = XposedHelpers.findClass("u6.e", loader);
        XposedHelpers.findAndHookMethod(roleContainer, "a", boolean.class, new XC_MethodHook() {
            @Override
            protected void afterHookedMethod(MethodHookParam param) {
                try {
                    SparseIntArray map = (SparseIntArray) XposedHelpers.getObjectField(param.thisObject, "h");
                    if (map == null) {
                        map = new SparseIntArray(24);
                        XposedHelpers.setObjectField(param.thisObject, "h", map);
                    }
                    populateRoleMap(map);
                    log("[RoleMap] role container populated, entries=" + map.size());
                } catch (Throwable first) {
                    log("[RoleMap] direct field injection unavailable: " + first);
                }
            }
        });

        XposedHelpers.findAndHookMethod(roleContainer, "q", int.class, new XC_MethodHook() {
            @Override
            protected void afterHookedMethod(MethodHookParam param) {
                int role = (Integer) param.args[0];
                int camera = cameraForRole(role);
                if (camera >= 0) {
                    param.setResult(camera);
                }
            }
        });
        log("[RoleMap] OS4 u6.e init/query fallback active");
    }

    /** Keep ordinary Xiaomi modes logical; Video, Pro and M9 use role cameras. */
    private static void hookLogicalCameraSelection(ClassLoader loader) {
        Class<?> roleFacade = XposedHelpers.findClass("u6.f", loader);
        Class<?> actualCamera = XposedHelpers.findClass("B2.c", loader);
        Class<?> zoomData = XposedHelpers.findClass(
                "com.android.camera.data.data.i", loader);
        XposedHelpers.findAndHookMethod(actualCamera, "c",
                int.class, int.class, boolean.class,
                new XC_MethodHook() {
                    @Override
                    protected void afterHookedMethod(MethodHookParam param) {
                        if (param.hasThrowable()
                                || !(param.getResult() instanceof Integer)
                                || !(param.args[0] instanceof Integer)
                                || !(param.args[1] instanceof Integer)) {
                            return;
                        }
                        int facing = (Integer) param.args[0];
                        if (facing != 0 && facing != 1) {
                            return;
                        }
                        int moduleIndex = (Integer) param.args[1];
                        if (facing == 0 && (moduleIndex == 162
                                || moduleIndex == 163
                                || moduleIndex == 167
                                || moduleIndex == 256)) {
                            // Xiaomi's ordinary video graph (0x803c) is not
                            // ColorOS' logical SAT graph (0x8021).  Keeping
                            // camera 0 open and feeding it sub-1x ratios makes
                            // libHIS enter a null transition state.  Let the
                            // affected module open the runtime role-selected
                            // OnePlus physical camera instead: 2 main, 3 UW,
                            // or 4 tele on the current pandora topology. M9
                            // deliberately follows Pro's physical RAW graph.
                            int selected = (Integer) param.getResult();
                            float legendZoom = Float.NaN;
                            if (moduleIndex == 163 || moduleIndex == 256) {
                                // Xiaomi's stock module-0x100 branch switches
                                // to UW below 1x, but deliberately keeps its
                                // logical camera for every ratio above 1x. M9
                                // now uses Pro's physical 0x8003 graph, so map
                                // its saved ratio to the OnePlus 13 roles at
                                // the one actual-open-camera boundary. A
                                // changed return value lets Xiaomi perform its
                                // own orderly close/reopen instead of trying
                                // to retarget a live Camera2 session.
                                float pendingZoom = moduleIndex == 163
                                        ? pendingPhotoPhysicalZoom
                                        : pendingLegendPhysicalZoom;
                                Object zoom = Float.isFinite(pendingZoom)
                                        ? pendingZoom
                                        : XposedHelpers.callStaticMethod(
                                        zoomData, "N",
                                        new Class<?>[]{int.class},
                                        moduleIndex);
                                if (zoom instanceof Float) {
                                    legendZoom = (Float) zoom;
                                }
                                int desired = legendZoom < 1.0f
                                        ? rearUltraWidePhysicalCameraId
                                        : legendZoom >= 3.0f
                                        ? rearTelePhysicalCameraId
                                        : rearMainPhysicalCameraId;
                                if (selected != desired) {
                                    selected = desired;
                                    param.setResult(selected);
                                }
                            }
                            String signature = "physical-role:"
                                    + moduleIndex + ":" + selected + ":"
                                    + Math.round(legendZoom * 100.0f);
                            if (LOGICAL_CAMERA_CONTRACT_LOGGED.add(signature)) {
                                log("[PhysicalZoomRoute] module="
                                        + moduleIndex + " retained"
                                        + " role-selected camera=" + selected
                                        + (moduleIndex == 163
                                        || moduleIndex == 256
                                        ? " zoom=" + legendZoom : ""));
                            }
                            return;
                        }
                        try {
                            Object roles = XposedHelpers.callStaticMethod(
                                    roleFacade, "T");
                            Object initialized = XposedHelpers.callMethod(
                                    roles, "isInitialized");
                            if (!(initialized instanceof Boolean)
                                    || !((Boolean) initialized)) {
                                return;
                            }
                        } catch (Throwable ignored) {
                            // Initialization has not completed; preserve Xiaomi's
                            // original early-return behavior.
                            return;
                        }
                        int selected = (Integer) param.getResult();
                        if (selected != facing) {
                            param.setResult(facing);
                            String signature = facing + ":"
                                    + moduleIndex + ":" + selected;
                            if (LOGICAL_CAMERA_CONTRACT_LOGGED.add(signature)) {
                                log("[LogicalCameraContract] mode=0x"
                                        + Integer.toHexString(
                                        moduleIndex)
                                        + " facing=" + facing
                                        + " physical=" + selected
                                        + " -> logical=" + facing);
                            }
                        }
                    }
                });
        log("[LogicalCameraSelection] Photo/M9 map 0.6/1/3 to physical"
                + " UW/main/tele; other ordinary modes retain logical IDs");
    }

    /**
     * Legendary exposes Xiaomi's ordinary numeric zoom strip even though its
     * capture graph has deliberately been upgraded to Pro's direct physical
     * RAW session.  A normal zoom click therefore only updates the crop on
     * the already-open camera and never gives B2.c another opportunity to
     * select UW/main/tele.
     *
     * Intercept only a click which crosses a physical-lens boundary, persist
     * the selected numeric ratio through Xiaomi's own zoom data API, then
     * issue the same StartControl(reset=8, viewConfig=2) restart used by the
     * native Pro lens switch.  Same-lens clicks (1x/2x and 3x/6x) stay on the
     * stock smooth digital-zoom path.
     */
    private static void hookLegendaryPhysicalLensRestart(
            ClassLoader loader) {
        Class<?> zoomFragment = XposedHelpers.findClass("H4.Z", loader);
        Class<?> zoomData = XposedHelpers.findClass(
                "com.android.camera.data.data.D", loader);
        Class<?> zoomSettings = XposedHelpers.findClass(
                "com.android.camera.data.data.i", loader);
        Class<?> startControl = XposedHelpers.findClass(
                "com.android.camera.module.loader.base.StartControl",
                loader);

        // reset=8 recreates the module and its stock initialization writes 1x
        // before the second actual-camera-id query. Keep the user selection
        // visible to that query until the target physical session exists.
        XposedHelpers.findAndHookMethod(zoomSettings, "N", int.class,
                new XC_MethodHook() {
                    @Override
                    protected void afterHookedMethod(
                            MethodHookParam param) {
                        if (param.args == null || param.args.length != 1
                                || !(param.args[0] instanceof Integer)) {
                            return;
                        }
                        int module = (Integer) param.args[0];
                        float pending = module == 163
                                ? pendingPhotoPhysicalZoom
                                : module == 256
                                ? pendingLegendPhysicalZoom : Float.NaN;
                        if (Float.isFinite(pending)) {
                            param.setResult(pending);
                        }
                    }
                });
        XposedHelpers.findAndHookMethod(zoomFragment, "jr",
                int.class, int.class, new XC_MethodHook() {
                    @Override
                    protected void beforeHookedMethod(
                            MethodHookParam param) {
                        int module = activeCameraModule;
                        if ((module != 163 && module != 256)
                                || param.args == null
                                || param.args.length < 1
                                || !(param.args[0] instanceof Integer)) {
                            return;
                        }
                        try {
                            int childIndex = (Integer) param.args[0];
                            Object zoomView = XposedHelpers.getObjectField(
                                    param.thisObject, "j");
                            Object child = XposedHelpers.callMethod(
                                    zoomView, "getChildAt", childIndex);
                            Object value = XposedHelpers.callMethod(
                                    child, "getZoomRatio");
                            if (!(value instanceof Float)) {
                                return;
                            }
                            float targetZoom = (Float) value;
                            int targetCamera = targetZoom < 1.0f
                                    ? rearUltraWidePhysicalCameraId
                                    : targetZoom >= 3.0f
                                    ? rearTelePhysicalCameraId
                                    : rearMainPhysicalCameraId;
                            if (activeCameraId == targetCamera) {
                                return;
                            }

                            // Stop jr before it writes a digital crop to the
                            // old camera. B2.c will consume this saved value
                            // while the replacement module is being created.
                            param.setResult(null);
                            if (module == 163) {
                                pendingPhotoPhysicalZoom = targetZoom;
                                pendingPhotoPhysicalCameraId = targetCamera;
                            } else {
                                pendingLegendPhysicalZoom = targetZoom;
                                pendingLegendPhysicalCameraId = targetCamera;
                            }
                            XposedHelpers.callStaticMethod(zoomData, "C0",
                                    new Class<?>[]{float.class, int.class},
                                    targetZoom, module);

                            Object activity = XposedHelpers.callMethod(
                                    param.thisObject, "getActivity");
                            if (activity == null) {
                                log("[PhysicalLensRestart] module=" + module
                                        + " no activity; zoom=" + targetZoom);
                                clearPendingPhysicalLens(module);
                                return;
                            }
                            Object control = XposedHelpers.callStaticMethod(
                                    startControl, "create",
                                    new Class<?>[]{int.class}, module);
                            control = XposedHelpers.callMethod(control,
                                    "setResetType", 8);
                            control = XposedHelpers.callMethod(control,
                                    "setViewConfigType", 2);
                            control = XposedHelpers.callMethod(control,
                                    "setNeedBlurAnimation", true);
                            log("[PhysicalLensRestart] module=" + module
                                    + " zoom=" + targetZoom + " camera="
                                    + activeCameraId + " -> " + targetCamera
                                    + " reset=8");
                            XposedHelpers.callMethod(activity, "J7", control);
                        } catch (Throwable throwable) {
                            clearPendingPhysicalLens(activeCameraModule);
                            // If Xiaomi changes this UI implementation, leave
                            // its original numeric zoom behavior intact.
                            log("[PhysicalLensRestart] ignored: " + throwable);
                        }
                    }
                });
        log("[PhysicalLensRestart] Photo/M9 numeric zoom boundary hook active");
    }

    private static void clearPendingPhysicalLens(int module) {
        if (module == 163) {
            pendingPhotoPhysicalZoom = Float.NaN;
            pendingPhotoPhysicalCameraId = -1;
        } else if (module == 256) {
            pendingLegendPhysicalZoom = Float.NaN;
            pendingLegendPhysicalCameraId = -1;
        }
    }

    /** Accept every Xiaomi image-format marker except the explicit YUV_420_888 value. */
    private static void hookNv21ImageCompatibility(ClassLoader loader) {
        Class<?> roleFacade = XposedHelpers.findClass("u6.f", loader);
        Class<?> capabilityUtils = XposedHelpers.findClass("j9.f", loader);
        Class<?> imageUtils = XposedHelpers.findClass("Qg.f", loader);
        XposedBridge.hookAllMethods(imageUtils, "n", new XC_MethodHook() {
            @Override
            protected void afterHookedMethod(MethodHookParam param) {
                if (param.hasThrowable()
                        || Boolean.TRUE.equals(param.getResult())) {
                    return;
                }
                int format = -1;
                try {
                    Object roles = XposedHelpers.callStaticMethod(
                            roleFacade, "T");
                    Object capability = XposedHelpers.callMethod(roles, "P");
                    if (capability != null) {
                        Object value = XposedHelpers.callStaticMethod(
                                capabilityUtils, "N0", capability);
                        if (value instanceof Integer) {
                            format = (Integer) value;
                        }
                    }
                } catch (Throwable ignored) {
                    // Missing OPlus format metadata is the case this repair
                    // is intended to handle; -1 is treated as NV21.
                }
                if (format != 1) {
                    param.setResult(true);
                    if (LOGICAL_CAMERA_CONTRACT_LOGGED.add("nv21:" + format)) {
                        log("[LogicalCameraContract] NV21 accepted metadata="
                                + format);
                    }
                }
            }
        });
        log("[Nv21Compatibility] missing/OPlus format metadata accepted");
    }

    /**
     * Finish the bridged portrait shot on Xiaomi's real quick-view callback.
     *
     * In this camera build the portrait implementation is j9.B0 and inherits
     * D() from j9.z0. The stock mask (capture-complete | image-processed)
     * waits for Xiaomi MIVI to turn the early JPEG into a second image. The
     * native OPlus APS bridge has already produced the final JPEG, so it is
     * posted to Xiaomi's quick-view ImageReader and the legal completion mask
     * is (capture-complete | quick-view-received). Keep this strictly scoped
     * to the active tele-portrait bridge; native Xiaomi paths remain intact.
     */
    private static void hookCaptureCompletionContract(ClassLoader loader) {
        XC_MethodHook completionMaskHook = new XC_MethodHook() {
            @Override
            protected void afterHookedMethod(MethodHookParam param) {
                if (param.hasThrowable()
                        || !(param.getResult() instanceof Integer)
                        || !(commonApsUnifiedPortraitSession
                        && commonApsUnifiedSessionActive
                        || photoProDirectSessionActive
                        && activeCameraModule == 163)) {
                    return;
                }
                int original = (Integer) param.getResult();
                int corrected = (original & ~0x2) | 0x4;
                if (corrected != original) {
                    param.setResult(corrected);
                    String owner = param.method.getDeclaringClass().getName();
                    if (LOGICAL_CAMERA_CONTRACT_LOGGED.add(
                            "mask:" + owner + ":" + original)) {
                        log("[LogicalCameraContract] " + owner
                                + ".D output mask " + original
                                + " -> " + corrected);
                    }
                }
            }
        };
        XposedBridge.hookAllMethods(
                XposedHelpers.findClass("j9.z0", loader),
                "D", completionMaskHook);
        XposedBridge.hookAllMethods(
                XposedHelpers.findClass("j9.H0", loader),
                "D", completionMaskHook);
        log("[CaptureCompletion] current z0/H0 direct-JPEG quick-view"
                + " contract armed conditionally");
    }

    /**
     * Xiaomi decides whether AudioRecord may deliver already-compressed AAC
     * from Xiaomi-only vendor properties. Those properties are present in
     * this port, but the OnePlus audio framework rejects ENCODING_AAC_LC
     * capture with -ENOSYS. Let the existing live-photo recorder use its
     * normal PCM AudioRecord + MediaCodec AAC path instead. No audio is
     * removed and video recording outside the camera process is untouched.
     */
    private static void hookDynamicPhotoAudioCompatibility(
            ClassLoader loader) {
        RearLivePhotoBridge.install(loader);
    }

    /**
     * Direct JPEG capture keeps Camera2Module's final save path, but Xiaomi's
     * non-parallel ParallelTaskData constructor receives null on this branch.
     * LiveShot names its companion MP4 from StorageData.shotSavePath and used
     * to dereference that null. Carry the path already selected by Xiaomi's
     * CameraConfigManager into only the immediately following Photo task.
     */
    private static void hookDynamicPhotoSavePathCompatibility(
            ClassLoader loader) {
        RearLivePhotoBridge.install(loader);
    }

    /**
     * HyperOS keeps the predictive/motion shutter state in r2.G.  On the
     * transplanted OnePlus feature table the UI remains available, but
     * Camera2Module's Xiaomi-only capability branch never applies a usable
     * preview frame rate.  Observe the component's own answer rather than a
     * duplicated preference, then let the already validated physical Photo
     * graph translate ON into a standard fixed 60 fps Camera2 request.
     */
    private static void hookMotionCaptureFpsBridge(ClassLoader loader) {
        Class<?> motionComponent = XposedHelpers.findClass("r2.G", loader);
        XposedHelpers.findAndHookMethod(motionComponent, "isSwitchOn",
                int.class, new XC_MethodHook() {
                    @Override
                    protected void afterHookedMethod(MethodHookParam param) {
                        if (param.hasThrowable()
                                || !(param.args[0] instanceof Integer)
                                || !(param.getResult() instanceof Boolean)) {
                            return;
                        }
                        int module = (Integer) param.args[0];
                        if (module != 163) {
                            return;
                        }
                        boolean enabled = (Boolean) param.getResult();
                        if (photoMotionCaptureEnabled != enabled) {
                            photoMotionCaptureEnabled = enabled;
                            lastPhotoMotionFpsRewriteSignature = "";
                            lastPhotoFpsSignature = "";
                            log("[MotionCaptureFps] component module="
                                    + module + " enabled=" + enabled);
                        }
                    }
                });
        log("[MotionCaptureFps] Xiaomi component-state bridge armed");
    }

    /** Ignore only empty or stride-invalid OPlus role metadata arrays. */
    private static void hookMalformedRoleMetadataFallback(
            ClassLoader loader) {
        Class<?> capabilityUtils = XposedHelpers.findClass("j9.f", loader);
        XposedBridge.hookAllMethods(capabilityUtils, "v0",
                new XC_MethodHook() {
                    @Override
                    protected void afterHookedMethod(MethodHookParam param) {
                        Throwable failure = param.getThrowable();
                        if (!(failure instanceof IllegalArgumentException)) {
                            return;
                        }
                        String message = String.valueOf(failure.getMessage());
                        if (!message.startsWith("invalid buffer length")
                                && !"empty buffer".equals(message)) {
                            return;
                        }
                        // v0 is void. Clearing the known validation exception
                        // matches a normal return without forging role entries.
                        param.setResult(null);
                        log("[LogicalCameraContract] malformed OPlus role"
                                + " metadata ignored: " + message);
                    }
                });
        log("[RoleMetadata] empty/stride-invalid arrays fail open");
    }

    /** Return Android's conventional front logical ID when role 1 is absent. */
    private static void hookFrontCameraIdFallback(ClassLoader loader) {
        Class<?> roleContainer = XposedHelpers.findClass("u6.e", loader);
        XposedBridge.hookAllMethods(roleContainer, "A",
                new XC_MethodHook() {
                    @Override
                    protected void afterHookedMethod(MethodHookParam param) {
                        if (!param.hasThrowable()
                                && param.getResult() instanceof Integer
                                && ((Integer) param.getResult()) < 0) {
                            param.setResult(1);
                            log("[LogicalCameraContract] missing front role"
                                    + " fell back to logical camera 1");
                        }
                    }
                });
        log("[FrontCameraId] logical camera 1 fallback active");
    }

    /** Keep Xiaomi watermarks real while removing their shot-to-shot gate. */
    private static void hookWatermarkShotToShotCompatibility(
            ClassLoader loader) {
        Class<?> imageManager = XposedHelpers.findClass("l6.g", loader);
        XposedBridge.hookAllMethods(imageManager, "v",
                new XC_MethodHook() {
                    @Override
                    protected void beforeHookedMethod(MethodHookParam param) {
                        SHOT_TO_SHOT_EVALUATION.set(Boolean.TRUE);
                    }

                    @Override
                    protected void afterHookedMethod(MethodHookParam param) {
                        SHOT_TO_SHOT_EVALUATION.remove();
                    }
                });
        Class<?> watermarkPreference = XposedHelpers.findClass("Gg.P", loader);
        XposedBridge.hookAllMethods(watermarkPreference, "g",
                new XC_MethodHook() {
                    @Override
                    protected void beforeHookedMethod(MethodHookParam param) {
                        if (Boolean.TRUE.equals(
                                SHOT_TO_SHOT_EVALUATION.get())) {
                            param.setResult(false);
                        }
                    }
                });

        Class<?> camera2Module = XposedHelpers.findClass(
                "com.android.camera.module.Camera2Module", loader);
        XposedBridge.hookAllMethods(camera2Module,
                "isCloudWatermarkProcessing", new XC_MethodHook() {
                    @Override
                    protected void afterHookedMethod(MethodHookParam param) {
                        if (!param.hasThrowable()
                                && param.getResult() instanceof Boolean) {
                            param.setResult(false);
                        }
                    }
                });
        log("[WatermarkShotToShot] capture gate removed; EXIF unchanged");
    }

    /**
     * Keep Xiaomi's native watermark renderer alive when the OPlus result
     * omits one of the optional photographic fields.  Real values are never
     * changed.  Defaults are supplied only for null, empty, non-finite or
     * non-positive inputs that otherwise make the formatter abandon the
     * complete watermark row.
     */
    private static void hookWatermarkExifDefaults(ClassLoader loader) {
        int installed = 0;

        Class<?> modernFormatter = XposedHelpers.findClassIfExists(
                "com.xiaomi.cam.watermark.a", loader);
        if (modernFormatter != null) {
            XposedHelpers.findAndHookMethod(modernFormatter, "E0",
                    int.class, int.class, String.class, String.class,
                    float.class, new XC_MethodHook() {
                        @Override
                        protected void beforeHookedMethod(
                                MethodHookParam param) {
                            boolean changed = false;
                            if ((Integer) param.args[0] <= 0) {
                                param.args[0] = 23;
                                changed = true;
                            }
                            if ((Integer) param.args[1] <= 0) {
                                param.args[1] = 100;
                                changed = true;
                            }
                            if (!(param.args[3] instanceof String)
                                    || ((String) param.args[3]).isEmpty()) {
                                param.args[3] = "1/60";
                                changed = true;
                            }
                            float aperture = (Float) param.args[4];
                            if (!Float.isFinite(aperture)
                                    || aperture <= 0.0f) {
                                param.args[4] = 1.59375f;
                                changed = true;
                            }
                            if (changed && LOGICAL_CAMERA_CONTRACT_LOGGED.add(
                                    "watermark-exif-modern")) {
                                log("[WatermarkExif] filled missing modern"
                                        + " focal/aperture/shutter/ISO values");
                            }
                        }
                    });
            installed++;
        }

        Class<?> legacyFormatter = XposedHelpers.findClassIfExists(
                "fs.d", loader);
        if (legacyFormatter != null) {
            XposedHelpers.findAndHookMethod(legacyFormatter, "o",
                    int.class, String.class, float.class, int.class,
                    new XC_MethodHook() {
                        @Override
                        protected void beforeHookedMethod(
                                MethodHookParam param) {
                            boolean changed = false;
                            if ((Integer) param.args[0] <= 0) {
                                param.args[0] = 23;
                                changed = true;
                            }
                            if (!(param.args[1] instanceof String)
                                    || ((String) param.args[1]).isEmpty()) {
                                param.args[1] = "1/60";
                                changed = true;
                            }
                            float aperture = (Float) param.args[2];
                            if (!Float.isFinite(aperture)
                                    || aperture <= 0.0f) {
                                param.args[2] = 1.59375f;
                                changed = true;
                            }
                            if ((Integer) param.args[3] <= 0) {
                                param.args[3] = 100;
                                changed = true;
                            }
                            if (changed && LOGICAL_CAMERA_CONTRACT_LOGGED.add(
                                    "watermark-exif-legacy")) {
                                log("[WatermarkExif] filled missing legacy"
                                        + " focal/aperture/shutter/ISO values");
                            }
                        }
                    });
            installed++;
        }

        if (installed == 0) {
            throw new IllegalStateException(
                    "No supported Xiaomi watermark formatter found");
        }
        log("[WatermarkExif] formatter compatibility hooks=" + installed);
    }

    /**
     * The preview-HEIC saver already resolves the real parallel-process
     * record. Xiaomi only marks it finished when the final-image-failed flag
     * is set, leaving valid dynamic photos pending forever on this HAL. Keep
     * the record before run(), observe the normal finish call, then issue the
     * same DbUtil finish call only when the successful path omitted it.
     */
    private static void hookDynamicPhotoPreviewCompletion(
            ClassLoader loader) {
        Class<?> previewHeicRunnable = XposedHelpers.findClass("s7.f", loader);
        Class<?> parallelDatabase = XposedHelpers.findClass("ou.P3", loader);
        Class<?> databaseUtility = XposedHelpers.findClass("H2.a", loader);
        Class<?> saveRecord = XposedHelpers.findClass("E2.a", loader);
        Class<?> cameraGlobal = XposedHelpers.findClass(
                "com.xiaomi.camera.basic.Global", loader);

        XposedHelpers.findAndHookMethod(databaseUtility, "c",
                Context.class, saveRecord, new XC_MethodHook() {
                    @Override
                    protected void beforeHookedMethod(MethodHookParam param) {
                        Object expected = DYNAMIC_PHOTO_SAVE_RECORD.get();
                        if (expected != null && param.args != null
                                && param.args.length == 2
                                && param.args[1] == expected) {
                            DYNAMIC_PHOTO_MARK_FINISHED.set(Boolean.TRUE);
                        }
                    }
                });

        XposedBridge.hookAllMethods(previewHeicRunnable, "run",
                new XC_MethodHook() {
                    @Override
                    protected void beforeHookedMethod(MethodHookParam param) {
                        DYNAMIC_PHOTO_SAVE_RECORD.remove();
                        DYNAMIC_PHOTO_MARK_FINISHED.remove();
                        try {
                            Object parallelTask = XposedHelpers.getObjectField(
                                    param.thisObject, "b");
                            Object storageData = XposedHelpers.getObjectField(
                                    parallelTask, "k");
                            String savePath = (String) XposedHelpers
                                    .getObjectField(storageData, "g");
                            if (savePath == null || savePath.isEmpty()) {
                                return;
                            }
                            Object database = XposedHelpers.callStaticMethod(
                                    parallelDatabase, "y");
                            Object record = XposedHelpers.callMethod(
                                    database, "f", savePath);
                            if (record != null) {
                                DYNAMIC_PHOTO_SAVE_RECORD.set(record);
                            }
                        } catch (Throwable throwable) {
                            log("[DynamicPhotoCompletion] record lookup failed: "
                                    + throwable);
                        }
                    }

                    @Override
                    protected void afterHookedMethod(MethodHookParam param) {
                        Object record = DYNAMIC_PHOTO_SAVE_RECORD.get();
                        boolean alreadyFinished = Boolean.TRUE.equals(
                                DYNAMIC_PHOTO_MARK_FINISHED.get());
                        try {
                            if (!param.hasThrowable() && record != null
                                    && !alreadyFinished) {
                                Object application = XposedHelpers
                                        .callStaticMethod(cameraGlobal,
                                                "getApplication");
                                XposedHelpers.callStaticMethod(databaseUtility,
                                        "c", application, record);
                                log("[DynamicPhotoCompletion] preview HEIC"
                                        + " marked finished");
                            }
                        } catch (Throwable throwable) {
                            log("[DynamicPhotoCompletion] finish failed: "
                                    + throwable);
                        } finally {
                            DYNAMIC_PHOTO_SAVE_RECORD.remove();
                            DYNAMIC_PHOTO_MARK_FINISHED.remove();
                        }
                    }
                });
        log("[DynamicPhotoCompletion] preview HEIC completion active");
    }

    /**
     * The ported Xiaomi feature profile can fall back to its empty generic
     * device class even though the OnePlus 13 exposes an 8192x6144 rear
     * stream.  Keep Xiaomi's own PixelModule and UI, but make the entry
     * available; the session hook below translates only its otherwise
     * unsupported operation mode to the exact 0x8001 mode measured from the
     * stock ColorOS 50 MP module.
     */
    private static void hookHighPixelModeAvailability(ClassLoader loader) {
        Class<?> entry = XposedHelpers.findClass(
                "com.android.camera.features.mode.pixel.PixelModuleEntry",
                loader);
        XposedBridge.hookAllMethods(entry, "support", new XC_MethodHook() {
            @Override
            protected void afterHookedMethod(MethodHookParam param) {
                Object original = param.getResult();
                String featureDescription = "unavailable";
                try {
                    Class<?> holder = XposedHelpers.findClass(
                            "Je.b$b", loader);
                    Object dataItem = XposedHelpers.getStaticObjectField(
                            holder, "f7377a");
                    Object feature = XposedHelpers.getObjectField(
                            dataItem, "f7371e");
                    Object resolution = XposedHelpers.callMethod(
                            feature, "Q0");
                    featureDescription = feature.getClass().getName()
                            + " Q0=" + resolution;
                } catch (Throwable throwable) {
                    featureDescription = "probe failed: " + throwable;
                }
                param.setResult(true);
                log("[HighPixelContract] entry original=" + original
                        + " forced=true feature=" + featureDescription);
            }
        });
        log("[HighPixelContract] PixelModule entry bridge active");
    }

    private static void hookPreviewSession(ClassLoader loader) {
        Class<?> wrapper = XposedHelpers.findClass("sh.b", loader);
        XposedHelpers.findAndHookMethod(
                wrapper,
                "b",
                int.class,
                ArrayList.class,
                CaptureRequest.class,
                CameraCaptureSession.StateCallback.class,
                Handler.class,
                new XC_MethodHook() {
                    @Override
                    protected void beforeHookedMethod(MethodHookParam param) {
                        if (!(param.args[0] instanceof Integer)) {
                            return;
                        }
                        String cameraId = String.valueOf(XposedHelpers.callMethod(param.thisObject, "c"));
                        try {
                            activeCameraId = Integer.parseInt(cameraId);
                        } catch (NumberFormatException ignored) {
                            activeCameraId = -1;
                        }
                        int operationMode = (Integer) param.args[0];
                        int outputCount = param.args[1] instanceof List
                                ? ((List<?>) param.args[1]).size() : -1;
                        log("[SessionProbe] camera=" + cameraId
                                + " mode=0x" + Integer.toHexString(operationMode)
                                + " outputs=" + outputCount);
                         if (param.args[1] instanceof List<?>) {
                            int specOrdinal = XIAOMI_SESSION_SPEC_COUNT
                                    .incrementAndGet();
                            if (specOrdinal <= 24) {
                                logConfiguredOutputs(
                                        "[XiaomiSessionSpec] #"
                                                + specOrdinal + " camera="
                                                + cameraId + " mode=0x"
                                                + Integer.toHexString(
                                                operationMode),
                                        (List<?>) param.args[1]);
                             }
                         }
                         int unifiedSessionGeneration =
                                 beginUnifiedApsSessionEpoch(
                                         cameraId, operationMode);
                         int photoDirectGeneration =
                                 beginPhotoProDirectSessionEpoch();
                         if (tryEnableUnifiedPortraitApsSession(
                                 param, cameraId, operationMode,
                                 unifiedSessionGeneration)) {
                             return;
                         }
                         if (tryEnableUnifiedApsSession(param, cameraId,
                                 operationMode,
                                 unifiedSessionGeneration)) {
                             return;
                         }
                        if (tryEnablePhotoProDirectSession(param, cameraId,
                                operationMode, photoDirectGeneration)) {
                            return;
                        }
                        if (activeCameraModule == 256
                                && activeLegendMode == 1
                                && operationMode == 0
                                && activeCameraId != 0
                                && isRearDirectCaptureCamera(activeCameraId)
                                && param.args[1] instanceof List<?>
                                && isLegendProCaptureOutputs(
                                (List<?>) param.args[1])) {
                            // Professional mode on this device opens the
                            // selected physical lens with exactly this
                            // PRIVATE + JPEG + RAW_SENSOR graph under 0x8003.
                            // Reusing that complete contract fixes the weak
                            // logical-camera JPEG without involving Photo APS.
                            param.args[0] = 0x8003;
                            log("[LegendProCapture] camera=" + cameraId
                                    + " mode=0 -> 0x8003 outputs="
                                    + outputCount);
                            if (activeCameraId
                                    == pendingLegendPhysicalCameraId
                                    && Float.isFinite(
                                    pendingLegendPhysicalZoom)) {
                                float completedZoom =
                                        pendingLegendPhysicalZoom;
                                pendingLegendPhysicalZoom = Float.NaN;
                                pendingLegendPhysicalCameraId = -1;
                                log("[LegendLensRestart] target session ready"
                                        + " camera=" + activeCameraId
                                        + " zoom=" + completedZoom
                                        + "; transient lock released");
                            }
                            return;
                        }
                        if (operationMode == XIAOMI_VIDEO_NIGHT_OP_MODE) {
                            param.args[0] = OPLUS_VIDEO_NIGHT_OP_MODE;
                            log("[VideoNightCompat] camera=" + cameraId
                                    + " mode=0x8031 -> 0x80a2; outputs="
                                    + outputCount);
                            return;
                        }
                        if (operationMode == XIAOMI_HIGH_PIXEL_OP_MODE
                                && "0".equals(cameraId)) {
                            param.args[0] = OPLUS_HIGH_PIXEL_OP_MODE;
                            log("[HighPixelContract] camera=0 mode=0x80f3"
                                    + " -> stock ColorOS mode=0x8001; outputs="
                                    + outputCount);
                            return;
                        }
                        if (operationMode == 0x8002
                                && param.args[1] instanceof List<?>) {
                            float zoom = getPortraitSessionZoom(param.args[2]);
                            // ColorOS native portrait modes require their own
                            // six-stream RAW/YUV APS graph. Feeding Xiaomi's
                            // preview + dual-BLOB graph to those modes reaches
                            // CamX PostPipelineCreate and aborts the provider.
                            // Mode 0 is the HAL's public compatible pipeline;
                            // keep all four Xiaomi callbacks intact and apply
                            // the OPlus beauty/bokeh request tags separately.
                            param.args[0] = 0;
                            logPortraitOutputGraph((List<?>) param.args[1]);
                            log("[PortraitContract] camera=" + cameraId
                                    + " Xiaomi mode=0x8002 -> compatible mode=0"
                                    + " zoom=" + zoom
                                    + " complete graph retained outputs="
                                    + outputCount);
                            return;
                        }
                        if (operationMode != XIAOMI_OP_MODE) {
                            return;
                        }
                        if (!"0".equals(cameraId)) {
                            return;
                        }
                        param.args[0] = 0;
                        log("[SessionCompat] camera=0 mode=0x9002 -> regular(0), outputs=" + outputCount);
                    }
                 });
        hookUnifiedApsRepeatingRequests(loader);
        hookPhotoProDirectRequests(loader);
        log("[SessionCompat] OS4 sh.b hook active");
    }

    private static boolean isLegendProCaptureOutputs(List<?> outputs) {
        boolean preview = false;
        boolean jpeg = false;
        boolean rawSensor = false;
        for (Object output : outputs) {
            if (!(output instanceof OutputConfiguration)) {
                continue;
            }
            int format = configuredOutputFormat(output);
            preview |= format == 34;
            jpeg |= format == 33 || format == ImageFormat.JPEG;
            rawSensor |= format == ImageFormat.RAW_SENSOR;
        }
        return preview && jpeg && rawSensor;
    }

    /**
     * Ordinary Photo's UI and save pipeline can consume the same direct HAL
     * JPEG as Pro, but its stock session also carries a 1440x1080 analysis
     * YUV Surface. The OnePlus 0x8003 Pro usecase has been proven on all three
     * physical rear cameras with exactly PRIVATE + JPEG. Keep Xiaomi's own
     * preview/JPEG readers, drop only that unneeded analysis Surface, and
     * rebuild requests which still reference it below.
     */
    @SuppressWarnings({"rawtypes", "unchecked"})
    private static boolean tryEnablePhotoProDirectSession(
            XC_MethodHook.MethodHookParam param, String cameraId,
            int operationMode, int generation) {
        if (activeCameraModule != 163
                || activeCameraId == 0
                || !isRearDirectCaptureCamera(activeCameraId)
                || (operationMode != 0 && operationMode != XIAOMI_OP_MODE)
                || !(param.args[1] instanceof List<?>)) {
            return false;
        }
        List<?> original = (List<?>) param.args[1];
        if (!isRearClarityOutputs(original)) {
            return false;
        }
        try {
            OutputConfiguration preview = null;
            OutputConfiguration jpeg = null;
            Surface analysisSurface = null;
            int dropped = 0;
            for (Object output : original) {
                if (!(output instanceof OutputConfiguration)) {
                    throw new IllegalStateException(
                            "Photo output is not OutputConfiguration");
                }
                int format = configuredOutputFormat(output);
                if (format == 34) {
                    preview = (OutputConfiguration) output;
                } else if (format == ImageFormat.JPEG || format == 33) {
                    jpeg = (OutputConfiguration) output;
                } else if (format == ImageFormat.YUV_420_888) {
                    analysisSurface = firstConfiguredSurface(
                            (OutputConfiguration) output);
                    dropped++;
                }
            }
            Surface previewSurface = firstConfiguredSurface(preview);
            Surface jpegSurface = firstConfiguredSurface(jpeg);
            if (preview == null || jpegSurface == null) {
                throw new IllegalStateException(
                        "Photo direct preview/JPEG Surface missing");
            }
            ArrayList directOutputs = new ArrayList(2);
            directOutputs.add(preview);
            directOutputs.add(jpeg);

            CaptureRequest sessionParameters =
                    param.args[2] instanceof CaptureRequest
                            ? (CaptureRequest) param.args[2] : null;
            if (sessionParameters != null) {
                try {
                    Object metadata = XposedHelpers.getObjectField(
                            sessionParameters, "mLogicalCameraSettings");
                    XposedHelpers.callMethod(metadata, "set",
                            OPLUS_SESSION_MFNR, 1);
                } catch (Throwable throwable) {
                    log("[PhotoProDirect] optional MFNR session tag retained"
                            + " original: " + throwable);
                }
            }

            synchronized (PHOTO_PRO_DIRECT_SESSION_LOCK) {
                if (generation != photoProDirectSessionGeneration) {
                    throw new IllegalStateException(
                            "Photo direct configure superseded generation="
                                    + generation);
                }
                photoProDirectSession = null;
                photoProDirectPreviewOutput = preview;
                photoProDirectPreviewSurface = previewSurface;
                photoProDirectJpegSurface = jpegSurface;
                photoProDirectAnalysisSurface = analysisSurface;
                photoProDirectSessionPending = true;
                photoProDirectSessionActive = false;
            }
            CameraCaptureSession.StateCallback originalCallback =
                    (CameraCaptureSession.StateCallback) param.args[3];
            param.args[0] = 0x8003;
            param.args[1] = directOutputs;
            param.args[3] = wrapPhotoProDirectStateCallback(
                    originalCallback, generation);
            logConfiguredOutputs("[PhotoProDirect] physical Pro JPEG graph",
                    directOutputs);
            log("[PhotoProDirect] module=163 camera=" + cameraId
                    + " mode=0x" + Integer.toHexString(operationMode)
                    + "->0x8003 outputs=" + original.size() + "->2"
                    + " droppedYuv=" + dropped + " MFNR=1");
            return true;
        } catch (Throwable throwable) {
            clearPhotoProDirectSession(generation, null);
            log("[PhotoProDirect] original Xiaomi graph retained: "
                    + throwable);
            XposedBridge.log(throwable);
            return false;
        }
    }

    private static int beginPhotoProDirectSessionEpoch() {
        synchronized (PHOTO_PRO_DIRECT_SESSION_LOCK) {
            int generation = ++photoProDirectSessionGeneration;
            photoProDirectSession = null;
            photoProDirectPreviewOutput = null;
            photoProDirectPreviewSurface = null;
            photoProDirectJpegSurface = null;
            photoProDirectAnalysisSurface = null;
            photoProDirectSessionPending = false;
            photoProDirectSessionActive = false;
            return generation;
        }
    }

    private static void clearPhotoProDirectSession(
            int generation, CameraCaptureSession session) {
        synchronized (PHOTO_PRO_DIRECT_SESSION_LOCK) {
            if (generation != photoProDirectSessionGeneration
                    || session != null && session != photoProDirectSession) {
                return;
            }
            photoProDirectSession = null;
            photoProDirectPreviewOutput = null;
            photoProDirectPreviewSurface = null;
            photoProDirectJpegSurface = null;
            photoProDirectAnalysisSurface = null;
            photoProDirectSessionPending = false;
            photoProDirectSessionActive = false;
        }
    }

    private static CameraCaptureSession.StateCallback
            wrapPhotoProDirectStateCallback(
            CameraCaptureSession.StateCallback original, int generation) {
        return new CameraCaptureSession.StateCallback() {
            @Override
            public void onConfigured(CameraCaptureSession session) {
                boolean accepted;
                synchronized (PHOTO_PRO_DIRECT_SESSION_LOCK) {
                    accepted = generation == photoProDirectSessionGeneration
                            && photoProDirectSessionPending;
                    if (accepted) {
                        photoProDirectSession = session;
                        if (photoProDirectPreviewSurface == null) {
                            photoProDirectPreviewSurface =
                                    firstConfiguredSurface(
                                            photoProDirectPreviewOutput);
                        }
                        photoProDirectSessionPending = false;
                        photoProDirectSessionActive = true;
                    }
                }
                if (accepted) {
                    if (activeCameraId == pendingPhotoPhysicalCameraId
                            && Float.isFinite(pendingPhotoPhysicalZoom)) {
                        log("[PhotoProDirect] target lens ready camera="
                                + activeCameraId + " zoom="
                                + pendingPhotoPhysicalZoom);
                        clearPendingPhysicalLens(163);
                    }
                    log("[PhotoProDirect] configured generation="
                            + generation + " session=" + session);
                } else {
                    log("[PhotoProDirect] stale onConfigured generation="
                            + generation);
                }
                original.onConfigured(session);
            }

            @Override
            public void onConfigureFailed(CameraCaptureSession session) {
                clearPhotoProDirectSession(generation, null);
                log("[PhotoProDirect] configure failed generation="
                        + generation + "; rollback APK remains available");
                original.onConfigureFailed(session);
            }

            @Override
            public void onReady(CameraCaptureSession session) {
                original.onReady(session);
            }

            @Override
            public void onActive(CameraCaptureSession session) {
                original.onActive(session);
            }

            @Override
            public void onCaptureQueueEmpty(CameraCaptureSession session) {
                original.onCaptureQueueEmpty(session);
            }

            @Override
            public void onSurfacePrepared(CameraCaptureSession session,
                    Surface surface) {
                original.onSurfacePrepared(session, surface);
            }

            @Override
            public void onClosed(CameraCaptureSession session) {
                clearPhotoProDirectSession(generation, session);
                original.onClosed(session);
            }
        };
    }

    /**
     * Every sh.b session creation supersedes the preceding attempt, including
     * transitions from Unified Photo to an incompatible mode.  Advancing the
     * epoch before the compatibility gate prevents a delayed onClosed from an
     * old Photo session from clearing Xiaomi's newly configured session.
     */
    private static int beginUnifiedApsSessionEpoch(
            String cameraId, int operationMode) {
        final int generation;
        final boolean hadUnifiedState;
        synchronized (COMMON_APS_UNIFIED_SESSION_LOCK) {
            hadUnifiedState = commonApsUnifiedSessionPending
                    || commonApsUnifiedSessionActive
                    || commonApsUnifiedSession != null;
            generation = ++commonApsUnifiedSessionGeneration;
            commonApsUnifiedSessionPending = false;
            commonApsUnifiedSessionActive = false;
            commonApsUnifiedSession = null;
            commonApsUnifiedSessionParameters = null;
            commonApsUnifiedXiaomiPreviewSurface = null;
            commonApsUnifiedXiaomiJpegSurface = null;
            commonApsUnifiedXiaomiSecondaryJpegSurface = null;
            commonApsUnifiedCameraModule = -1;
            commonApsUnifiedPortraitSession = false;
        }
        if (hadUnifiedState) {
            failCommonApsShutter("unified session superseded");
            abortCommonApsCapture("unified-session-superseded", true);
            log("[UnifiedAPS] previous session superseded by generation="
                    + generation + " camera=" + cameraId + " mode=0x"
                    + Integer.toHexString(operationMode));
        }
        return generation;
    }

    /**
     * Route only the telephoto portrait branch through the native ColorOS
     * portrait ABI.  Xiaomi 1x/2x remain on the already stable compatible
     * session until their two distinct ColorOS operation modes have been
     * captured and verified separately.
     */
    @SuppressWarnings({"rawtypes", "unchecked"})
    private static boolean tryEnableUnifiedPortraitApsSession(
            XC_MethodHook.MethodHookParam param, String cameraId,
            int operationMode, int generation) {
        if (!"0".equals(cameraId)
                || activeCameraModule != 171
                || operationMode != 0x8002
                || !(param.args[1] instanceof List<?>)) {
            return false;
        }
        float zoom = getPortraitSessionZoom(param.args[2]);
        if (zoom < 2.8f
                || !isXiaomiPortraitOutputs((List<?>) param.args[1])) {
            return false;
        }
        try {
            Application application = resolveCurrentCameraApplication();
            if (application != null) {
                xiaomiCameraApplication = application;
            }
            if (!ensurePortraitApsInfrastructure()) {
                throw new IllegalStateException(
                        "exact portrait six-reader graph unavailable");
            }
            CaptureRequest sessionParams =
                    loadEmbeddedOplusPortraitSessionParams();
            Object logicalMetadata = XposedHelpers.getObjectField(
                    sessionParams, "mLogicalCameraSettings");
            XposedHelpers.callMethod(logicalMetadata, "set",
                    CaptureRequest.CONTROL_ZOOM_RATIO, zoom);
            XposedHelpers.callMethod(logicalMetadata, "set",
                    OPLUS_BOKEH_LEVEL, new float[]{0.27f});

            ArrayList<OutputConfiguration> nativeOutputs =
                    buildPortableOplusPortraitOutputConfigurations();
            ArrayList combined = new ArrayList(nativeOutputs.size() + 1);
            combined.addAll(nativeOutputs);

            OutputConfiguration previewOutput = null;
            Surface primaryJpeg = null;
            Surface secondaryJpeg = null;
            for (Object output : (List<?>) param.args[1]) {
                if (!(output instanceof OutputConfiguration)) {
                    continue;
                }
                int format = configuredOutputFormat(output);
                Surface surface = ((OutputConfiguration) output)
                        .getSurface();
                if (format == 34) {
                    previewOutput = (OutputConfiguration) output;
                } else if (format == ImageFormat.JPEG || format == 33) {
                    if (primaryJpeg == null) {
                        primaryJpeg = surface;
                    } else if (secondaryJpeg == null) {
                        secondaryJpeg = surface;
                    }
                }
            }
            if (previewOutput == null || previewOutput.getSurface() == null
                    || primaryJpeg == null || secondaryJpeg == null) {
                throw new IllegalStateException(
                        "Xiaomi portrait output surfaces incomplete");
            }
            combined.add(previewOutput);

            CameraCaptureSession.StateCallback originalCallback =
                    (CameraCaptureSession.StateCallback) param.args[3];
            synchronized (COMMON_APS_UNIFIED_SESSION_LOCK) {
                if (generation != commonApsUnifiedSessionGeneration) {
                    throw new IllegalStateException(
                            "portrait configure superseded generation="
                                    + generation);
                }
                commonApsUnifiedSession = null;
                commonApsUnifiedSessionParameters = sessionParams;
                commonApsUnifiedXiaomiPreviewSurface =
                        previewOutput.getSurface();
                commonApsUnifiedXiaomiJpegSurface = primaryJpeg;
                commonApsUnifiedXiaomiSecondaryJpegSurface =
                        secondaryJpeg;
                commonApsUnifiedCameraModule = activeCameraModule;
                commonApsUnifiedPortraitSession = true;
                commonApsUnifiedSessionActive = false;
                commonApsUnifiedSessionPending = true;
            }
            COMMON_APS_UNIFIED_PREVIEW_LOGGED.set(false);
            param.args[0] = OPLUS_PORTRAIT_TELE_OP_MODE;
            param.args[1] = combined;
            param.args[2] = sessionParams;
            param.args[3] = wrapUnifiedApsStateCallback(
                    originalCallback, generation);

            Handler worker = commonApsHandler;
            if (worker != null) {
                worker.post(() -> {
                    boolean ready = prepareCommonApsClient();
                    log("[PortraitAPS] native APS prewarm ready=" + ready
                            + " generation=" + generation);
                });
            }
            logConfiguredOutputs(
                    "[PortraitAPS] exact-six + Xiaomi-preview; JPEG loopback",
                    combined);
            log("[PortraitAPS] configure submitted generation="
                    + generation + " mode=0x8010 outputs="
                    + combined.size() + " zoom=" + zoom
                    + " nativePrefix=6 XiaomiPreviewSuffix=1 params="
                    + sessionParams.getKeys().size());
            return true;
        } catch (Throwable throwable) {
            synchronized (COMMON_APS_UNIFIED_SESSION_LOCK) {
                if (generation == commonApsUnifiedSessionGeneration) {
                    commonApsUnifiedSessionPending = false;
                    commonApsUnifiedSessionActive = false;
                    commonApsUnifiedSession = null;
                    commonApsUnifiedSessionParameters = null;
                    commonApsUnifiedXiaomiPreviewSurface = null;
                    commonApsUnifiedXiaomiJpegSurface = null;
                    commonApsUnifiedXiaomiSecondaryJpegSurface = null;
                    commonApsUnifiedCameraModule = -1;
                    commonApsUnifiedPortraitSession = false;
                }
            }
            log("[PortraitAPS] native route not submitted; compatible"
                    + " Xiaomi graph retained: " + throwable);
            XposedBridge.log(throwable);
            return false;
        }
    }

    @SuppressWarnings({"rawtypes", "unchecked"})
    private static boolean tryEnableUnifiedApsSession(
            XC_MethodHook.MethodHookParam param, String cameraId,
            int operationMode, int generation) {
        File marker = new File(COMMON_APS_UNIFIED_SESSION_MARKER);
        boolean markerPresent = marker.isFile();
        if (!COMMON_APS_UNIFIED_DAILY_ENABLED && !markerPresent) {
            return false;
        }
        if (!"0".equals(cameraId)
                || !isRearClarityModule(activeCameraModule)
                || (operationMode != 0 && operationMode != XIAOMI_OP_MODE)
                || !(param.args[1] instanceof List<?>)
                || !isRearClarityOutputs((List<?>) param.args[1])) {
            log("[UnifiedAPS] marker retained until compatible rear still"
                    + " camera=" + cameraId + " module="
                    + activeCameraModule + " mode=0x"
                    + Integer.toHexString(operationMode) + " signature="
                    + (param.args[1] instanceof List<?>
                    ? outputFormatSignature((List<?>) param.args[1]) : "?"));
            return false;
        }
        // Photo/Document sessions are legitimately recreated after a mode or
        // lens change, Gallery round-trip, and Activity resume.  The callback
        // generation already makes an old session's close event harmless, so
        // a process-lifetime one-shot latch would incorrectly drop APS after
        // the first resume.  A real configure failure still fails open for
        // this process; a marker is an explicit diagnostic retry override.
        if (commonApsUnifiedAutoDisabled && !markerPresent) {
            log("[UnifiedAPS] automatic route bypassed after configure"
                    + " failure; original Xiaomi session retained");
            return false;
        }
        if (markerPresent) {
            commonApsUnifiedAutoDisabled = false;
            commonApsUnifiedConfigureFailures = 0;
            if (!marker.delete()) {
                log("[UnifiedAPS] recovery marker delete failed;"
                        + " generation guard still isolates stale callbacks");
            }
        }
        try {
            Application application = resolveCurrentCameraApplication();
            if (application != null) {
                xiaomiCameraApplication = application;
            }
            if (!ensureCommonApsInfrastructure()) {
                throw new IllegalStateException(
                        "exact nine-reader APS graph unavailable");
            }
            CaptureRequest sessionParams =
                    loadEmbeddedOplusSessionParams();
            ArrayList<OutputConfiguration> oplusOutputs =
                    buildPortableOplusOutputConfigurations();
            ArrayList combined = new ArrayList(
                    oplusOutputs.size() + 1);
            // OPlus stream indices are a native CameraUnit ABI.  Keep its
            // exact 0..8 ordering and append Xiaomi's untouched outputs only
            // after that fixed prefix.
            combined.addAll(oplusOutputs);
            Object xiaomiPreviewOutput = null;
            Object xiaomiJpegOutput = null;
            for (Object output : (List<?>) param.args[1]) {
                if (configuredOutputFormat(output) == 34) {
                    if (xiaomiPreviewOutput != null) {
                        throw new IllegalStateException(
                                "ordinary Photo has multiple PRIVATE previews");
                    }
                    xiaomiPreviewOutput = output;
                } else if (configuredOutputFormat(output) == 33
                        || configuredOutputFormat(output)
                        == ImageFormat.JPEG) {
                    if (xiaomiJpegOutput != null) {
                        throw new IllegalStateException(
                                "ordinary Photo has multiple JPEG outputs");
                    }
                    xiaomiJpegOutput = output;
                }
            }
            if (xiaomiPreviewOutput == null) {
                throw new IllegalStateException(
                        "ordinary Photo PRIVATE preview missing");
            }
            if (!(xiaomiPreviewOutput instanceof OutputConfiguration)) {
                throw new IllegalStateException(
                        "ordinary Photo preview is not OutputConfiguration");
            }
            Surface xiaomiPreviewSurface = RearDeferredPreviewBridge.prepare(
                    (OutputConfiguration) xiaomiPreviewOutput, generation);
            if (!(xiaomiJpegOutput instanceof OutputConfiguration)) {
                throw new IllegalStateException(
                        "ordinary Photo JPEG OutputConfiguration missing");
            }
            Surface xiaomiJpegSurface =
                    ((OutputConfiguration) xiaomiJpegOutput).getSurface();
            if (xiaomiJpegSurface == null) {
                throw new IllegalStateException(
                        "ordinary Photo JPEG Surface missing");
            }
            // The first 12-stream proof reached the HAL but was rejected.
            // v131 proved this ten-stream live preview.  v132 proved that an
            // eleventh HAL JPEG is rejected, so keep Xiaomi's JPEG Surface
            // outside Camera2 and feed APS bytes back through its Surface.
            combined.add(xiaomiPreviewOutput);

            CameraCaptureSession.StateCallback originalCallback =
                    (CameraCaptureSession.StateCallback) param.args[3];
            synchronized (COMMON_APS_UNIFIED_SESSION_LOCK) {
                if (generation != commonApsUnifiedSessionGeneration) {
                    throw new IllegalStateException(
                            "session configure superseded before submit"
                                    + " generation=" + generation
                                    + " current="
                                    + commonApsUnifiedSessionGeneration);
                }
                commonApsUnifiedSession = null;
                commonApsUnifiedSessionParameters = sessionParams;
                commonApsUnifiedXiaomiPreviewSurface =
                        xiaomiPreviewSurface;
                commonApsUnifiedXiaomiJpegSurface = xiaomiJpegSurface;
                commonApsUnifiedXiaomiSecondaryJpegSurface = null;
                commonApsUnifiedCameraModule = activeCameraModule;
                commonApsUnifiedPortraitSession = false;
                commonApsUnifiedSessionActive = false;
                commonApsUnifiedSessionPending = true;
            }
            COMMON_APS_UNIFIED_PREVIEW_LOGGED.set(false);
            param.args[0] = 0x8001;
            param.args[1] = combined;
            param.args[2] = sessionParams;
            param.args[3] = wrapUnifiedApsStateCallback(
                    originalCallback, generation);

            Handler worker = commonApsHandler;
            if (worker != null) {
                worker.post(() -> {
                    boolean ready = prepareCommonApsClient();
                    log("[UnifiedAPS] native APS prewarm ready=" + ready
                            + " generation=" + generation);
                });
            }
            logConfiguredOutputs(
                    "[UnifiedAPS] exact-nine + Xiaomi-preview; JPEG loopback",
                    combined);
            log("[UnifiedAPS] configure submitted generation=" + generation
                    + " mode=0x8001 outputs=" + combined.size()
                    + " module=" + commonApsUnifiedCameraModule
                    + " OPlusPrefix=9 XiaomiPreviewSuffix=1 params="
                    + sessionParams.getKeys().size()
                    + " daily=" + COMMON_APS_UNIFIED_DAILY_ENABLED);
            return true;
        } catch (Throwable throwable) {
            synchronized (COMMON_APS_UNIFIED_SESSION_LOCK) {
                if (generation == commonApsUnifiedSessionGeneration) {
                    commonApsUnifiedSessionPending = false;
                    commonApsUnifiedSessionActive = false;
                    commonApsUnifiedSession = null;
                    commonApsUnifiedSessionParameters = null;
                    commonApsUnifiedXiaomiPreviewSurface = null;
                    commonApsUnifiedXiaomiJpegSurface = null;
                    commonApsUnifiedXiaomiSecondaryJpegSurface = null;
                    commonApsUnifiedCameraModule = -1;
                    commonApsUnifiedPortraitSession = false;
                }
            }
            commonApsUnifiedAutoDisabled = true;
            commonApsUnifiedConfigureFailures++;
            log("[UnifiedAPS] proof abandoned before Camera2 configure;"
                    + " original Xiaomi session retained; automatic route"
                    + " disabled for this process failures="
                    + commonApsUnifiedConfigureFailures + ": " + throwable);
            XposedBridge.log(throwable);
            return false;
        }
    }

    private static CameraCaptureSession.StateCallback
            wrapUnifiedApsStateCallback(
            CameraCaptureSession.StateCallback original, int generation) {
        return new CameraCaptureSession.StateCallback() {
            @Override
            public void onConfigured(CameraCaptureSession session) {
                boolean stale;
                synchronized (COMMON_APS_UNIFIED_SESSION_LOCK) {
                    stale = generation
                            != commonApsUnifiedSessionGeneration
                            || (!commonApsUnifiedSessionPending
                            && session != commonApsUnifiedSession);
                    if (!stale) {
                        commonApsUnifiedSession = session;
                        commonApsUnifiedSessionPending = false;
                        commonApsUnifiedSessionActive = true;
                        commonApsUnifiedConfigureFailures = 0;
                        log("[UnifiedAPS] SUCCESS persistent "
                                + (commonApsUnifiedPortraitSession
                                ? "7-output portrait" : "10-output common")
                                + " session"
                                + " configured generation=" + generation
                                + "; forwarding to Xiaomi preview");
                        // Serialize the callback with the next sh.b session
                        // epoch.  Otherwise a new session can start between
                        // this check and Xiaomi receiving onConfigured.
                        original.onConfigured(session);
                    }
                }
                if (stale) {
                    log("[UnifiedAPS] stale onConfigured suppressed"
                            + " generation=" + generation + " current="
                            + commonApsUnifiedSessionGeneration);
                    try {
                        session.close();
                    } catch (Throwable ignored) {
                        // The superseded framework session may already close.
                    }
                }
            }

            @Override
            public void onConfigureFailed(CameraCaptureSession session) {
                synchronized (COMMON_APS_UNIFIED_SESSION_LOCK) {
                    if (generation != commonApsUnifiedSessionGeneration
                            || (commonApsUnifiedSession != null
                            && session != commonApsUnifiedSession)) {
                        log("[UnifiedAPS] stale onConfigureFailed suppressed"
                                + " generation=" + generation + " current="
                                + commonApsUnifiedSessionGeneration);
                        return;
                    }
                    boolean portraitFailure =
                            commonApsUnifiedPortraitSession;
                    if (!portraitFailure) {
                        commonApsUnifiedAutoDisabled = true;
                        commonApsUnifiedConfigureFailures++;
                    }
                    commonApsUnifiedSessionPending = false;
                    commonApsUnifiedSessionActive = false;
                    commonApsUnifiedSession = null;
                    commonApsUnifiedSessionParameters = null;
                    commonApsUnifiedXiaomiPreviewSurface = null;
                    commonApsUnifiedXiaomiJpegSurface = null;
                    commonApsUnifiedXiaomiSecondaryJpegSurface = null;
                    commonApsUnifiedCameraModule = -1;
                    commonApsUnifiedPortraitSession = false;
                    log("[UnifiedAPS] disabling automatic route for this"
                            + " session after HAL configure failure route="
                            + (portraitFailure ? "portrait" : "common")
                            + " count=" + commonApsUnifiedConfigureFailures);
                    failCommonApsShutter(
                            "unified session ended: configure-failed");
                    abortCommonApsCapture(
                            "unified-session-configure-failed", true);
                    log("[UnifiedAPS] native graph onConfigureFailed; Xiaomi may"
                            + " rebuild its original session without a loop");
                    original.onConfigureFailed(session);
                }
            }

            @Override
            public void onReady(CameraCaptureSession session) {
                synchronized (COMMON_APS_UNIFIED_SESSION_LOCK) {
                    if (generation == commonApsUnifiedSessionGeneration
                            && commonApsUnifiedSessionActive
                            && session == commonApsUnifiedSession) {
                        original.onReady(session);
                    }
                }
            }

            @Override
            public void onActive(CameraCaptureSession session) {
                synchronized (COMMON_APS_UNIFIED_SESSION_LOCK) {
                    if (generation == commonApsUnifiedSessionGeneration
                            && commonApsUnifiedSessionActive
                            && session == commonApsUnifiedSession) {
                        original.onActive(session);
                    }
                }
            }

            @Override
            public void onCaptureQueueEmpty(CameraCaptureSession session) {
                synchronized (COMMON_APS_UNIFIED_SESSION_LOCK) {
                    if (generation == commonApsUnifiedSessionGeneration
                            && commonApsUnifiedSessionActive
                            && session == commonApsUnifiedSession) {
                        original.onCaptureQueueEmpty(session);
                    }
                }
            }

            @Override
            public void onSurfacePrepared(CameraCaptureSession session,
                    Surface surface) {
                synchronized (COMMON_APS_UNIFIED_SESSION_LOCK) {
                    if (generation == commonApsUnifiedSessionGeneration
                            && commonApsUnifiedSessionActive
                            && session == commonApsUnifiedSession) {
                        original.onSurfacePrepared(session, surface);
                    }
                }
            }

            @Override
            public void onClosed(CameraCaptureSession session) {
                synchronized (COMMON_APS_UNIFIED_SESSION_LOCK) {
                    if (generation != commonApsUnifiedSessionGeneration
                            || (commonApsUnifiedSession != null
                            && session != commonApsUnifiedSession)) {
                        log("[UnifiedAPS] stale onClosed suppressed"
                                + " generation=" + generation + " current="
                                + commonApsUnifiedSessionGeneration);
                        return;
                    }
                    commonApsUnifiedSessionPending = false;
                    commonApsUnifiedSessionActive = false;
                    commonApsUnifiedSession = null;
                    commonApsUnifiedSessionParameters = null;
                    commonApsUnifiedXiaomiPreviewSurface = null;
                    commonApsUnifiedXiaomiJpegSurface = null;
                    commonApsUnifiedXiaomiSecondaryJpegSurface = null;
                    commonApsUnifiedCameraModule = -1;
                    commonApsUnifiedPortraitSession = false;
                    failCommonApsShutter(
                            "unified session ended: session-closed");
                    abortCommonApsCapture(
                            "unified-session-session-closed", true);
                    log("[UnifiedAPS] persistent session left generation="
                            + generation + " reason=session-closed");
                    original.onClosed(session);
                }
            }
        };
    }

    private static void hookUnifiedApsRepeatingRequests(
            ClassLoader loader) {
        Class<?> sessionImpl = XposedHelpers.findClass(
                "android.hardware.camera2.impl.CameraCaptureSessionImpl",
                loader);
        XposedBridge.hookAllMethods(sessionImpl, "setRepeatingRequest",
                new XC_MethodHook() {
                    @Override
                    protected void beforeHookedMethod(MethodHookParam param) {
                        if (param.args != null && param.args.length >= 1
                                && param.args[0] instanceof CaptureRequest) {
                            param.args[0] = augmentUnifiedApsRepeatingRequest(
                                    param.thisObject,
                                    (CaptureRequest) param.args[0]);
                        }
                    }
                });
        XposedBridge.hookAllMethods(sessionImpl, "setRepeatingBurst",
                new XC_MethodHook() {
                    @Override
                    protected void beforeHookedMethod(MethodHookParam param) {
                        if (!commonApsUnifiedSessionActive
                                || param.thisObject
                                != commonApsUnifiedSession
                                || param.args == null
                                || param.args.length < 1
                                || !(param.args[0] instanceof List<?>)) {
                            return;
                        }
                        ArrayList<CaptureRequest> rewritten =
                                new ArrayList<>();
                        for (Object item : (List<?>) param.args[0]) {
                            if (!(item instanceof CaptureRequest)) {
                                return;
                            }
                            rewritten.add(augmentUnifiedApsRepeatingRequest(
                                    param.thisObject,
                                    (CaptureRequest) item));
                        }
                        param.args[0] = rewritten;
                    }
                });
        XposedBridge.hookAllMethods(sessionImpl, "capture",
                new XC_MethodHook() {
                    @Override
                    protected void beforeHookedMethod(MethodHookParam param) {
                        if (param.args != null && param.args.length >= 1
                                && param.args[0] instanceof CaptureRequest) {
                            CaptureRequest original =
                                    (CaptureRequest) param.args[0];
                            if (trySubmitUnifiedApsBurstAtShutter(
                                    param, original)) {
                                return;
                            }
                            CaptureRequest replacement =
                                    rewriteUnifiedApsXiaomiStillRequest(
                                            param.thisObject, original);
                            if (replacement == original) {
                                // Tap-to-focus and AE precapture are submitted
                                // as one-shot PREVIEW requests.  They must be
                                // rebuilt against the exact session parameter
                                // parcel too; otherwise Camera2 sees a changed
                                // OPlus session key, reconfigures the live
                                // nine-output graph and the vendor HAL faults
                                // while flushing that half-reconfigured graph.
                                replacement =
                                        augmentUnifiedApsRepeatingRequest(
                                                param.thisObject, original);
                            }
                            param.args[0] = replacement;
                        }
                    }
                });
        XposedBridge.hookAllMethods(sessionImpl, "captureBurst",
                new XC_MethodHook() {
                    @Override
                    protected void beforeHookedMethod(MethodHookParam param) {
                        if (!commonApsUnifiedSessionActive
                                || param.thisObject
                                != commonApsUnifiedSession
                                || param.args == null
                                || param.args.length < 1
                                || !(param.args[0] instanceof List<?>)) {
                            return;
                        }
                        ArrayList<CaptureRequest> rewritten =
                                new ArrayList<>();
                        boolean changed = false;
                        for (Object item : (List<?>) param.args[0]) {
                            if (!(item instanceof CaptureRequest)) {
                                return;
                            }
                            CaptureRequest source = (CaptureRequest) item;
                            CaptureRequest replacement =
                                    rewriteUnifiedApsXiaomiStillRequest(
                                            param.thisObject, source);
                            rewritten.add(replacement);
                            changed |= replacement != source;
                        }
                        if (changed) {
                            param.args[0] = rewritten;
                        }
                    }
                });
        log("[UnifiedAPS] repeating/still request bridge installed");
    }

    /**
     * Camera2 rejects a request which still targets Photo's analysis reader
     * after the session has been reduced to Pro's exact PRIVATE + JPEG graph.
     * Rebuild only such requests on the same CameraDevice, preserving every
     * Xiaomi control, tag and callback. Preview/3A target PRIVATE; a still
     * capture targets JPEG (and PRIVATE only when Xiaomi requested both).
     */
    private static void hookPhotoProDirectRequests(ClassLoader loader) {
        Class<?> sessionImpl = XposedHelpers.findClass(
                "android.hardware.camera2.impl.CameraCaptureSessionImpl",
                loader);
        XposedBridge.hookAllMethods(sessionImpl, "setRepeatingRequest",
                new XC_MethodHook() {
                    @Override
                    protected void beforeHookedMethod(MethodHookParam param) {
                        rewritePhotoProDirectArgument(param, false);
                    }
                });
        XposedBridge.hookAllMethods(sessionImpl, "setRepeatingBurst",
                new XC_MethodHook() {
                    @Override
                    protected void beforeHookedMethod(MethodHookParam param) {
                        rewritePhotoProDirectArgument(param, true);
                    }
                });
        XposedBridge.hookAllMethods(sessionImpl, "capture",
                new XC_MethodHook() {
                    @Override
                    protected void beforeHookedMethod(MethodHookParam param) {
                        rewritePhotoProDirectArgument(param, false);
                    }
                });
        XposedBridge.hookAllMethods(sessionImpl, "captureBurst",
                new XC_MethodHook() {
                    @Override
                    protected void beforeHookedMethod(MethodHookParam param) {
                        rewritePhotoProDirectArgument(param, true);
                    }
                });
        log("[PhotoProDirect] request target sanitizer installed");
    }

    @SuppressWarnings("unchecked")
    private static void rewritePhotoProDirectArgument(
            XC_MethodHook.MethodHookParam param, boolean burst) {
        if (!photoProDirectSessionActive
                || param.thisObject != photoProDirectSession
                || param.args == null || param.args.length == 0) {
            return;
        }
        if (!burst) {
            if (param.args[0] instanceof CaptureRequest) {
                param.args[0] = rewritePhotoProDirectRequest(
                        param.thisObject, (CaptureRequest) param.args[0]);
            }
            return;
        }
        if (!(param.args[0] instanceof List<?>)) {
            return;
        }
        ArrayList<CaptureRequest> rewritten = new ArrayList<>();
        boolean changed = false;
        for (Object item : (List<?>) param.args[0]) {
            if (!(item instanceof CaptureRequest)) {
                return;
            }
            CaptureRequest source = (CaptureRequest) item;
            CaptureRequest replacement = rewritePhotoProDirectRequest(
                    param.thisObject, source);
            rewritten.add(replacement);
            changed |= replacement != source;
        }
        if (changed) {
            param.args[0] = rewritten;
        }
    }

    private static CaptureRequest rewritePhotoProDirectRequest(
            Object session, CaptureRequest original) {
        Surface preview = photoProDirectPreviewSurface;
        Surface jpeg = photoProDirectJpegSurface;
        Surface analysis = photoProDirectAnalysisSurface;
        if (!photoProDirectSessionActive
                || session != photoProDirectSession
                || jpeg == null || original == null) {
            return original;
        }
        try {
            ArrayList<Surface> originalTargets =
                    readCaptureRequestTargets(original);
            boolean hasPreview = false;
            boolean hasJpeg = false;
            boolean hasUnconfigured = false;
            Surface previewCandidate = preview;
            for (Surface target : originalTargets) {
                if (preview != null
                        && (target == preview || preview.equals(target))) {
                    hasPreview = true;
                } else if (target == jpeg || jpeg.equals(target)) {
                    hasJpeg = true;
                } else if (analysis != null
                        && (target == analysis || analysis.equals(target))) {
                    hasUnconfigured = true;
                } else {
                    // Photo's preview OutputConfiguration is deferred on this
                    // framework. Its real Surface first becomes observable in
                    // the repeating request after configure/finalize.
                    if (previewCandidate == null) {
                        previewCandidate = target;
                        hasPreview = true;
                    } else if (target == previewCandidate
                            || previewCandidate.equals(target)) {
                        hasPreview = true;
                    } else {
                        hasUnconfigured = true;
                    }
                }
            }
            if (preview == null && previewCandidate != null) {
                photoProDirectPreviewSurface = previewCandidate;
                preview = previewCandidate;
                log("[PhotoProDirect] deferred preview Surface resolved from"
                        + " first request: " + previewCandidate);
            }
            Integer intent = original.get(
                    CaptureRequest.CONTROL_CAPTURE_INTENT);
            boolean still = Integer.valueOf(CaptureRequest
                    .CONTROL_CAPTURE_INTENT_STILL_CAPTURE).equals(intent)
                    || hasJpeg;
            android.util.Range<Integer> requestedFps = original.get(
                    CaptureRequest.CONTROL_AE_TARGET_FPS_RANGE);
            android.util.Range<Integer> motionFps = android.util.Range.create(
                    60, 60);
            boolean rewriteMotionFps = photoMotionCaptureEnabled
                    && !still && !motionFps.equals(requestedFps);
            if (!hasUnconfigured && !rewriteMotionFps) {
                return original;
            }
            Object deviceImpl = XposedHelpers.getObjectField(
                    session, "mDeviceImpl");
            CaptureRequest.Builder builder = (CaptureRequest.Builder)
                    XposedHelpers.callMethod(deviceImpl,
                            "createCaptureRequest", still
                                    ? android.hardware.camera2.CameraDevice
                                    .TEMPLATE_STILL_CAPTURE
                                    : android.hardware.camera2.CameraDevice
                                    .TEMPLATE_PREVIEW);
            int[] copied = copyCaptureRequestKeys(original, builder);
            builder.setTag(original.getTag());
            if (still) {
                builder.addTarget(jpeg);
                if (hasPreview && preview != null) {
                    builder.addTarget(preview);
                }
            } else {
                if (preview == null) {
                    throw new IllegalStateException(
                            "deferred preview Surface unresolved");
                }
                builder.addTarget(preview);
                if (photoMotionCaptureEnabled) {
                    builder.set(CaptureRequest.CONTROL_AE_TARGET_FPS_RANGE,
                            motionFps);
                }
            }
            CaptureRequest replacement = builder.build();
            int replacementTargetCount = still
                    ? (hasPreview ? 2 : 1) : 1;
            log("[PhotoProDirect] request sanitized intent=" + intent
                    + " targets=" + originalTargets.size() + "->"
                    + replacementTargetCount + " still=" + still
                    + " copied=" + Arrays.toString(copied));
            if (rewriteMotionFps) {
                String signature = activeCameraId + ":" + requestedFps
                        + "->" + motionFps;
                if (!signature.equals(
                        lastPhotoMotionFpsRewriteSignature)) {
                    lastPhotoMotionFpsRewriteSignature = signature;
                    log("[MotionCaptureFps] repeating request "
                            + signature + " targets="
                            + originalTargets.size() + "->"
                            + replacementTargetCount);
                }
            }
            return replacement;
        } catch (Throwable throwable) {
            log("[PhotoProDirect] request unchanged after sanitize failure: "
                    + throwable);
            return original;
        }
    }

    @SuppressWarnings({"rawtypes", "unchecked"})
    private static CaptureRequest rewriteUnifiedApsXiaomiStillRequest(
            Object session, CaptureRequest original) {
        ImageReader nativePreviewReader = commonApsUnifiedPortraitSession
                ? portraitPreviewYuvReader : commonAuxYuvReader;
        if (!commonApsUnifiedSessionActive
                || session != commonApsUnifiedSession
                || commonApsUnifiedXiaomiJpegSurface == null
                || commonApsUnifiedXiaomiPreviewSurface == null
                || nativePreviewReader == null || original == null) {
            return original;
        }
        Integer intent = original.get(
                CaptureRequest.CONTROL_CAPTURE_INTENT);
        if (!Integer.valueOf(CaptureRequest
                .CONTROL_CAPTURE_INTENT_STILL_CAPTURE).equals(intent)
                || (!captureTargetsSurface(original,
                commonApsUnifiedXiaomiJpegSurface)
                && (commonApsUnifiedXiaomiSecondaryJpegSurface == null
                || !captureTargetsSurface(original,
                commonApsUnifiedXiaomiSecondaryJpegSurface)))) {
            return original;
        }
        try {
            ArrayList<Surface> originalTargets =
                    readCaptureRequestTargets(original);
            Object deviceImpl = XposedHelpers.getObjectField(
                    session, "mDeviceImpl");
            CaptureRequest.Builder builder = (CaptureRequest.Builder)
                    XposedHelpers.callMethod(deviceImpl,
                            "createCaptureRequest",
                            android.hardware.camera2.CameraDevice
                                    .TEMPLATE_STILL_CAPTURE);
            int[] copied;
            int[] stabilized = new int[]{0, 0, 0};
            int[] portable = new int[]{0, 0, 0};
            if (commonApsUnifiedPortraitSession
                    && commonApsUnifiedSessionParameters != null) {
                copied = copyCaptureRequestKeys(
                        commonApsUnifiedSessionParameters, builder);
                portable = copyPortableRearControls(original, builder);
            } else {
                copied = copyCaptureRequestKeys(original, builder);
                if (commonApsUnifiedSessionParameters != null) {
                    // The embedded 129-key parcel is the exact request used
                    // as SessionConfiguration#setSessionParameters. Overlay it
                    // after Xiaomi's request so every session key remains
                    // byte-for-byte stable, then restore per-frame controls.
                    stabilized = copyCaptureRequestKeys(
                            commonApsUnifiedSessionParameters, builder);
                    portable = copyPortableRearControls(original, builder);
                }
            }
            builder.setTag(original.getTag());
            builder.set(CaptureRequest.CONTROL_CAPTURE_INTENT,
                    CaptureRequest.CONTROL_CAPTURE_INTENT_STILL_CAPTURE);
            builder.set(OPLUS_SDK_CAMERA_PACKAGE, new byte[]{1});
            builder.set(OPLUS_IS_FROM_MAIN_MENU, Boolean.FALSE);
            applyUnifiedOplusLensRoute(builder, original, false);
            // Produce a real sensor result for Xiaomi's j9.f1 callback, but
            // never target its unconfigured JPEG/analysis readers.  APS owns
            // the RAW burst and later writes the finished JPEG to that reader.
            builder.addTarget(commonApsUnifiedXiaomiPreviewSurface);
            builder.addTarget(nativePreviewReader.getSurface());
            CaptureRequest replacement = builder.build();
            log("[UnifiedAPS] Xiaomi still request converted to trigger"
                    + " targets=" + originalTargets.size() + "->2"
                    + " copied=" + Arrays.toString(copied)
                    + " stabilized=" + Arrays.toString(stabilized)
                    + " portable=" + Arrays.toString(portable)
                    + " route=" + (commonApsUnifiedPortraitSession
                    ? "portrait" : "common")
                    + " orientation=" + original.get(
                    CaptureRequest.JPEG_ORIENTATION)
                    + " tag=" + original.getTag());
            return replacement;
        } catch (Throwable throwable) {
            log("[UnifiedAPS] still trigger rebuild failed; request retained: "
                    + throwable);
            return original;
        }
    }

    @SuppressWarnings({"rawtypes", "unchecked"})
    private static CaptureRequest augmentUnifiedApsRepeatingRequest(
            Object session, CaptureRequest original) {
        ImageReader nativePreviewReader = commonApsUnifiedPortraitSession
                ? portraitPreviewYuvReader : commonAuxYuvReader;
        if (!commonApsUnifiedSessionActive
                || session != commonApsUnifiedSession
                || nativePreviewReader == null
                || commonApsUnifiedXiaomiPreviewSurface == null
                || original == null) {
            return original;
        }
        try {
            ArrayList<Surface> originalTargets =
                    readCaptureRequestTargets(original);
            boolean hasAux = false;
            boolean hasVisiblePreview = false;
            for (Surface target : originalTargets) {
                if (target == nativePreviewReader.getSurface()
                        || nativePreviewReader.getSurface().equals(target)) {
                    hasAux = true;
                }
                if (target == commonApsUnifiedXiaomiPreviewSurface
                        || commonApsUnifiedXiaomiPreviewSurface
                        .equals(target)) {
                    hasVisiblePreview = true;
                }
            }
            Object deviceImpl = XposedHelpers.getObjectField(
                    session, "mDeviceImpl");
            CaptureRequest.Builder builder = (CaptureRequest.Builder)
                    XposedHelpers.callMethod(deviceImpl,
                            "createCaptureRequest",
                            android.hardware.camera2.CameraDevice
                                    .TEMPLATE_PREVIEW);
            int[] copied;
            int[] stabilized = new int[]{0, 0, 0};
            int[] portable = new int[]{0, 0, 0};
            if (commonApsUnifiedPortraitSession
                    && commonApsUnifiedSessionParameters != null) {
                copied = copyCaptureRequestKeys(
                        commonApsUnifiedSessionParameters, builder);
                portable = copyPortableRearControls(original, builder);
            } else {
                copied = copyCaptureRequestKeys(original, builder);
                if (commonApsUnifiedSessionParameters != null) {
                    stabilized = copyCaptureRequestKeys(
                            commonApsUnifiedSessionParameters, builder);
                    portable = copyPortableRearControls(original, builder);
                }
            }
            builder.setTag(original.getTag());
            int keptXiaomiTargets = 0;
            for (Surface target : originalTargets) {
                if (target == commonApsUnifiedXiaomiPreviewSurface
                        || commonApsUnifiedXiaomiPreviewSurface
                        .equals(target)) {
                    builder.addTarget(target);
                    keptXiaomiTargets++;
                }
            }
            if (keptXiaomiTargets != 1) {
                throw new IllegalStateException(
                        "visible Xiaomi preview target count="
                                + keptXiaomiTargets);
            }
            builder.addTarget(nativePreviewReader.getSurface());
            builder.set(OPLUS_SDK_CAMERA_PACKAGE, new byte[]{1});
            builder.set(OPLUS_IS_FROM_MAIN_MENU, Boolean.FALSE);
            applyUnifiedOplusLensRoute(builder, original, true);
            CaptureRequest replacement = builder.build();
            logTelePreviewContractDiffOnce(replacement);
            if (COMMON_APS_UNIFIED_PREVIEW_LOGGED
                    .compareAndSet(false, true)) {
                log("[UnifiedAPS] Xiaomi repeating preview augmented"
                        + " targets=" + originalTargets.size()
                        + "->" + (keptXiaomiTargets + 1)
                        + " droppedUnconfigured="
                        + (originalTargets.size() - keptXiaomiTargets)
                        + " copied=" + Arrays.toString(copied)
                        + " stabilized=" + Arrays.toString(stabilized)
                        + " portable=" + Arrays.toString(portable)
                        + " route=" + (commonApsUnifiedPortraitSession
                        ? "portrait" : "common")
                        + " sdk=[1] mainMenu=false");
            }
            Integer afTrigger = original.get(
                    CaptureRequest.CONTROL_AF_TRIGGER);
            Integer aeTrigger = original.get(
                    CaptureRequest.CONTROL_AE_PRECAPTURE_TRIGGER);
            if ((afTrigger != null
                    && afTrigger != CaptureRequest.CONTROL_AF_TRIGGER_IDLE)
                    || (aeTrigger != null
                    && aeTrigger != CaptureRequest
                    .CONTROL_AE_PRECAPTURE_TRIGGER_IDLE)) {
                log("[UnifiedAPS] transient 3A request normalized"
                        + " afTrigger=" + afTrigger
                        + " aeTrigger=" + aeTrigger
                        + " targets=" + originalTargets.size() + "->2"
                        + " stabilized=" + Arrays.toString(stabilized)
                        + " sdk=" + Arrays.toString(replacement.get(
                        OPLUS_SDK_CAMERA_PACKAGE))
                        + " mainMenu=" + replacement.get(
                        OPLUS_IS_FROM_MAIN_MENU));
            }
            return replacement;
        } catch (Throwable throwable) {
            log("[UnifiedAPS] preview request left unchanged after rebuild"
                    + " failure: " + throwable);
            return original;
        }
    }

    private static boolean isUnifiedUltraWideRequest(
            CaptureRequest request) {
        if (request == null) {
            return false;
        }
        try {
            Float ratio = request.get(CaptureRequest.CONTROL_ZOOM_RATIO);
            return ratio != null && Float.isFinite(ratio)
                    && ratio <= 0.71f;
        } catch (Throwable ignored) {
            return false;
        }
    }

    @SuppressWarnings({"rawtypes", "unchecked"})
    private static void logTelePreviewContractDiffOnce(
            CaptureRequest current) {
        try {
            Float zoom = current == null ? null
                    : current.get(CaptureRequest.CONTROL_ZOOM_RATIO);
            if (zoom == null || !Float.isFinite(zoom) || zoom < 3.0f
                    || !COMMON_APS_TELE_PREVIEW_DIFF_LOGGED
                    .compareAndSet(false, true)) {
                return;
            }
            CaptureRequest stock = loadEmbeddedOplusStillRequest(
                    false, true);
            HashMap<String, CaptureRequest.Key<?>> currentKeys =
                    new HashMap<>();
            for (CaptureRequest.Key<?> key : current.getKeys()) {
                currentKeys.put(key.getName(), key);
            }
            int compared = 0;
            int different = 0;
            for (CaptureRequest.Key<?> stockKey : stock.getKeys()) {
                String name = stockKey.getName();
                String lower = name == null ? ""
                        : name.toLowerCase(Locale.US);
                if (!(lower.startsWith("com.oplus.")
                        || lower.startsWith("org.codeaurora.")
                        || lower.startsWith("org.quic.")
                        || lower.equals("android.control.captureintent")
                        || lower.equals("android.control.enablezsl")
                        || lower.equals("android.control.zoomratio")
                        || lower.equals("android.scaler.cropregion"))
                        || lower.contains("availablestreammap")) {
                    continue;
                }
                compared++;
                CaptureRequest.Key<?> currentKey = currentKeys.get(name);
                Object stockValue = stock.get((CaptureRequest.Key) stockKey);
                Object currentValue = currentKey == null ? "<absent>"
                        : current.get((CaptureRequest.Key) currentKey);
                String stockText = apsValueString(stockValue);
                String currentText = apsValueString(currentValue);
                if (!stockText.equals(currentText)) {
                    different++;
                    log("[TelePreviewDiff] " + name + " stock="
                            + stockText + " current=" + currentText);
                }
            }
            log("[TelePreviewDiff] complete compared=" + compared
                    + " different=" + different + " currentKeys="
                    + current.getKeys().size() + " stockKeys="
                    + stock.getKeys().size());
        } catch (Throwable throwable) {
            log("[TelePreviewDiff] audit failed: " + throwable);
            XposedBridge.log(throwable);
        }
    }

    /**
     * Normalize Xiaomi's outer zoom stops to ColorOS' logical SAT routes.
     * Slider transition ratios retain continuous zoom; the APS still burst
     * later uses an exact embedded stock request for either optical endpoint.
     */
    private static void applyUnifiedOplusLensRoute(
            CaptureRequest.Builder builder, CaptureRequest source,
            boolean repeating) {
        Float sourceRatio = source == null ? null
                : source.get(CaptureRequest.CONTROL_ZOOM_RATIO);
        float ratio = sourceRatio == null || !Float.isFinite(sourceRatio)
                ? 1.0f : sourceRatio;
        builder.set(CaptureRequest.CONTROL_ZOOM_RATIO, ratio);
        builder.set(CaptureRequest.SCALER_CROP_REGION,
                fullRearActiveArray());
        if (commonApsUnifiedPortraitSession) {
            builder.set(OPLUS_CAMERA_MODE,
                    "portrait_mode\0".getBytes(StandardCharsets.UTF_8));
            builder.set(OPLUS_BOKEH_LEVEL, new float[]{0.27f});
            builder.set(COMMON_APS_MFNR, new int[]{1});
            return;
        }
        if (ratio >= 3.0f) {
            builder.set(CaptureRequest.CONTROL_ENABLE_ZSL, false);
            if (repeating) {
                builder.set(CaptureRequest.CONTROL_AF_MODE,
                        CaptureRequest.CONTROL_AF_MODE_CONTINUOUS_PICTURE);
            }
            builder.set(OPLUS_ORIGINAL_ZOOM,
                    new float[]{ratio});
            builder.set(OPLUS_ZOOM_TARGET,
                    new float[]{0.0f});
            builder.set(OPLUS_POINT_ZOOM, new int[]{0});
            builder.set(COMMON_APS_AUTO_HDR, new int[]{1});
            builder.set(COMMON_APS_ZOOM_FEATURE, new int[]{0});
            builder.set(COMMON_APS_SAT_MASTER_CAMERA, new int[]{2});
            builder.set(COMMON_APS_SENSOR_MODE, new int[]{0});
            builder.set(COMMON_APS_SENSOR_MODE_LIST,
                    new int[]{3, -1, 2, 0, -1, -1, -1, -1});
            builder.set(COMMON_APS_FEATURE, new int[]{48});
            builder.set(COMMON_APS_AIS_STATE, new int[]{0});
            builder.set(COMMON_APS_SUPERNIGHT, new int[]{0});
            builder.set(COMMON_APS_REQUEST_NUM, new int[]{0});
            builder.set(COMMON_APS_REQUEST_NUM_LIST, new int[]{0, 0});
            builder.set(COMMON_APS_MOVING_OBJECT, new int[]{0});
            builder.set(COMMON_APS_IPE_SEQUENCE, new int[]{1});
            builder.set(COMMON_APS_BRACKET_MODE, new int[]{28});
            if (COMMON_APS_TELE_ROUTE_LOGGED.compareAndSet(false, true)) {
                log("[UnifiedAPS] Xiaomi >=3x normalized to OPlus tele SAT"
                        + " route ratio=" + ratio + " crop="
                        + fullRearActiveArray() + " sensorMode=0 master=2"
                        + " phase="
                        + (repeating ? "repeating" : "trigger"));
            }
            return;
        }
        if (ratio > 0.71f) {
            return;
        }
        builder.set(CaptureRequest.CONTROL_ENABLE_ZSL, false);
        if (repeating) {
            builder.set(CaptureRequest.CONTROL_AF_MODE,
                    CaptureRequest.CONTROL_AF_MODE_CONTINUOUS_PICTURE);
        }
        builder.set(OPLUS_ORIGINAL_ZOOM, new float[]{1.0f});
        builder.set(OPLUS_ZOOM_TARGET, new float[]{-1.0f});
        builder.set(OPLUS_POINT_ZOOM, new int[]{0});
        builder.set(COMMON_APS_AUTO_HDR, new int[]{1});
        builder.set(COMMON_APS_ZOOM_FEATURE, new int[]{0});
        builder.set(COMMON_APS_SAT_MASTER_CAMERA, new int[]{0});
        builder.set(COMMON_APS_SENSOR_MODE, new int[]{0});
        builder.set(COMMON_APS_SENSOR_MODE_LIST,
                new int[]{2, -1, 0, 2, -1, -1, -1, -1});
        builder.set(COMMON_APS_FEATURE, new int[]{48});
        builder.set(COMMON_APS_AIS_STATE, new int[]{0});
        builder.set(COMMON_APS_SUPERNIGHT, new int[]{0});
        builder.set(COMMON_APS_REQUEST_NUM, new int[]{0});
        builder.set(COMMON_APS_REQUEST_NUM_LIST, new int[]{0, 0});
        builder.set(COMMON_APS_MOVING_OBJECT, new int[]{0});
        builder.set(COMMON_APS_IPE_SEQUENCE, new int[]{1});
        builder.set(COMMON_APS_BRACKET_MODE, new int[]{28});
        if (COMMON_APS_ULTRAWIDE_ROUTE_LOGGED.compareAndSet(false, true)) {
            log("[UnifiedAPS] Xiaomi 0.7x normalized to OPlus UW SAT route"
                    + " ratio=" + ratio + " crop="
                    + fullRearActiveArray() + " sensorMode=0 master=0"
                    + " phase=" + (repeating ? "repeating" : "trigger"));
        }
    }

    private static ArrayList<Surface> readCaptureRequestTargets(
            CaptureRequest request) throws Throwable {
        Object rawTargets = XposedHelpers.callMethod(request, "getTargets");
        if (!(rawTargets instanceof Iterable<?>)) {
            throw new IllegalStateException(
                    "CaptureRequest targets are not iterable");
        }
        ArrayList<Surface> targets = new ArrayList<>();
        for (Object target : (Iterable<?>) rawTargets) {
            if (!(target instanceof Surface)) {
                throw new IllegalStateException(
                        "CaptureRequest target is not a Surface");
            }
            targets.add((Surface) target);
        }
        return targets;
    }

    private static boolean queueUnifiedApsJpegToXiaomiReader(
            byte[] jpeg, long timestamp) {
        if (!isJpegBytes(jpeg) || timestamp <= 0L
                || commonApsUnifiedXiaomiJpegSurface == null
                || !commonApsUnifiedSessionActive) {
            return false;
        }
        synchronized (COMMON_APS_JPEG_LOOPBACK_LOCK) {
            try {
                if (!ensureCommonApsJpegNativeLoaded()) {
                    throw new IllegalStateException(
                            "native JPEG Surface bridge unavailable");
                }
                int result = nativeQueueJpegToSurface(
                        commonApsUnifiedXiaomiJpegSurface, jpeg, timestamp);
                if (result != 0) {
                    throw new IllegalStateException(
                            "native JPEG Surface bridge result=" + result);
                }
                log("[UnifiedAPS] APS JPEG posted into Xiaomi ImageReader"
                        + " bytes=" + jpeg.length
                        + " timestamp=" + timestamp);
                return true;
            } catch (Throwable throwable) {
                log("[UnifiedAPS] native JPEG Surface loopback failed: "
                        + throwable);
                XposedBridge.log(throwable);
                return false;
            }
        }
    }

    private static float getPortraitSessionZoom(Object sessionParameters) {
        if (sessionParameters instanceof CaptureRequest) {
            try {
                Float zoom = ((CaptureRequest) sessionParameters).get(
                        CaptureRequest.CONTROL_ZOOM_RATIO);
                if (zoom != null && zoom > 0.0f) {
                    return zoom;
                }
            } catch (Throwable throwable) {
                log("[PortraitContract] session zoom read failed: "
                        + throwable);
            }
        }
        // Xiaomi portrait opens at 2x on this build.  This is also the least
        // surprising ColorOS portrait graph when no session zoom is present.
        return 2.0f;
    }

    private static void logPortraitOutputGraph(List<?> outputs) {
        for (int index = 0; index < outputs.size(); index++) {
            Object output = outputs.get(index);
            if (!(output instanceof OutputConfiguration)) {
                log("[PortraitProbe] index=" + index + " type="
                        + (output == null ? "null"
                        : output.getClass().getName()));
                continue;
            }
            try {
                OutputConfiguration configuration =
                        (OutputConfiguration) output;
                for (Surface surface : configuration.getSurfaces()) {
                    Object format = XposedHelpers.callStaticMethod(
                            XposedHelpers.findClass(
                                    "android.hardware.camera2.utils.SurfaceUtils",
                                    null),
                            "getSurfaceFormat",
                            surface);
                    Object size = XposedHelpers.callStaticMethod(
                            XposedHelpers.findClass(
                                    "android.hardware.camera2.utils.SurfaceUtils",
                                    null),
                            "getSurfaceSize",
                            surface);
                    log("[PortraitProbe] index=" + index
                            + " format=0x"
                            + Integer.toHexString((Integer) format)
                            + " size=" + size
                            + " physical="
                            + XposedHelpers.callMethod(configuration,
                                    "getPhysicalCameraId"));
                }
            } catch (Throwable throwable) {
                log("[PortraitProbe] index=" + index
                        + " inspect failed: " + throwable);
            }
        }
    }

    /**
     * A diagnostic-only side output for the normal rear still path.  It is
     * enabled by a one-shot file inside the camera app data directory and
     * never replaces Xiaomi's JPEG.  Keeping the first experiment read-only
     * lets us prove the exact buffer geometry and content before attempting
     * any multi-frame post-processing.
     */
    private static void hookFullYuvProbe(ClassLoader loader) {
        Class<?> wrapper = XposedHelpers.findClass("sh.b", loader);
        XposedBridge.hookAllMethods(wrapper, "b", new XC_MethodHook() {
            @Override
            protected void beforeHookedMethod(MethodHookParam param) {
                fullYuvSessionActive = false;
                if (!isYuvProbeEnabled()
                        || param.args == null
                        || param.args.length != 5
                        || !(param.args[1] instanceof List)) {
                    return;
                }
                try {
                    String cameraId = String.valueOf(
                            XposedHelpers.callMethod(param.thisObject, "c"));
                    if (!"0".equals(cameraId)) {
                        return;
                    }
                    boolean explicitProbe = isExplicitYuvProbeEnabled();
                    boolean ordinaryPhoto = isOrdinaryPhotoSession(param.args);
                    if (!explicitProbe
                            && (!isProductionFusionEnabled()
                            || !ordinaryPhoto)) {
                        log("[YuvFusion] session skipped camera=0 signature="
                                + outputFormatSignature((List<?>) param.args[1])
                                + " mode=" + param.args[0]);
                        return;
                    }
                    if (!ensureFullYuvReader()) {
                        return;
                    }
                    List<?> outputs = (List<?>) param.args[1];
                    String sourceSignature = outputFormatSignature(outputs);
                    boolean added = appendOutputSurface(
                            outputs, fullYuvReader.getSurface());
                    fullYuvSessionActive = true;
                    log("[YuvProbe] session output "
                            + (added ? "added" : "already present")
                            + " camera=0 size=4096x3072 outputs="
                            + outputs.size()
                            + " sourceSignature="
                            + sourceSignature
                            + " ordinaryPhoto=" + ordinaryPhoto
                            + " explicit=" + explicitProbe);
                } catch (Throwable throwable) {
                    fullYuvSessionActive = false;
                    log("[YuvProbe] session output unchanged: " + throwable);
                }
            }
        });

        XposedBridge.hookAllMethods(wrapper, "a", new XC_MethodHook() {
            @Override
            protected void afterHookedMethod(MethodHookParam param) {
                if (!fullYuvSessionActive
                        || !isYuvProbeEnabled()
                        || param.args == null
                        || param.args.length != 2
                        || !"SHOT".equals(String.valueOf(param.args[0]))
                        || !(param.getResult() instanceof CaptureRequest.Builder)
                        || fullYuvReader == null) {
                    return;
                }
                try {
                    String cameraId = String.valueOf(
                            XposedHelpers.callMethod(param.thisObject, "c"));
                    if (!"0".equals(cameraId)) {
                        return;
                    }
                    ((CaptureRequest.Builder) param.getResult()).addTarget(
                            fullYuvReader.getSurface());
                    log("[YuvProbe] attached full YUV target to rear SHOT");
                } catch (Throwable throwable) {
                    log("[YuvProbe] SHOT target unchanged: " + throwable);
                }
            }
        });

        Class<?> sessionImpl = XposedHelpers.findClass(
                "android.hardware.camera2.impl.CameraCaptureSessionImpl",
                loader);
        XposedBridge.hookAllMethods(sessionImpl, "capture", new XC_MethodHook() {
            @Override
            protected void beforeHookedMethod(MethodHookParam param) {
                if (!fullYuvSessionActive
                        || !isYuvMultiframeEnabled()
                        || Boolean.TRUE.equals(YUV_BURST_GUARD.get())
                        || fullYuvReader == null
                        || param.args == null
                        || param.args.length < 3
                        || !(param.args[0] instanceof CaptureRequest)) {
                    return;
                }
                CaptureRequest original = (CaptureRequest) param.args[0];
                Integer intent = original.get(
                        CaptureRequest.CONTROL_CAPTURE_INTENT);
                if (!Integer.valueOf(CaptureRequest
                        .CONTROL_CAPTURE_INTENT_STILL_CAPTURE).equals(intent)
                        || !captureTargetsSurface(original,
                        fullYuvReader.getSurface())) {
                    return;
                }
                if (isYuvFusionEnabled() && !awaitFusionSlot()) {
                    log("[YuvFusion] stale previous capture; current shot uses original JPEG");
                    return;
                }
                try {
                    ArrayList<CaptureRequest> burst = buildYuvRequestSet(
                            param.thisObject, original, 5);
                    if (burst == null || burst.size() != 5) {
                        log("[YuvBurst] request clone unavailable; retaining single frame");
                        return;
                    }
                    fullYuvFrameCount = 0;
                    fullYuvExpectedFrames = burst.size();
                    if (isYuvFusionEnabled()) {
                        synchronized (FUSION_LOCK) {
                            FUSION_FRAMES.clear();
                            pendingFusedJpeg = null;
                            fusionFailure = null;
                            fusionCapturePending = true;
                        }
                        log("[YuvFusion] capture armed for five real frames");
                    }
                    CameraCaptureSession.CaptureCallback originalCallback =
                            param.args[1] instanceof
                                    CameraCaptureSession.CaptureCallback
                                    ? (CameraCaptureSession.CaptureCallback)
                                    param.args[1] : null;
                    CameraCaptureSession.CaptureCallback callback =
                            wrapYuvBurstCallback(originalCallback,
                                    original, burst);
                    YUV_BURST_GUARD.set(Boolean.TRUE);
                    Object sequence = XposedHelpers.callMethod(
                            param.thisObject, "captureBurst", burst,
                            callback, param.args[2]);
                    param.setResult(sequence);
                    log("[YuvBurst] submitted atomic burst fullJPEG+YUV=1"
                            + " YUV-only=4 total=5 sequence=" + sequence);
                } catch (Throwable throwable) {
                    fullYuvExpectedFrames = 1;
                    failFusion("burst submission failed: " + throwable);
                    log("[YuvBurst] submit failed; retaining original capture: "
                            + throwable);
                } finally {
                    YUV_BURST_GUARD.remove();
                }
            }
        });
        log("[YuvProbe] OS4 one-shot probe hook active; stock JPEG retained");
    }

    private static boolean isYuvProbeEnabled() {
        return isExplicitYuvProbeEnabled()
                || isProductionFusionEnabled();
    }

    private static boolean isExplicitYuvProbeEnabled() {
        return new File(YUV_PROBE_MARKER).isFile()
                || new File(YUV_MULTIFRAME_MARKER).isFile()
                || new File(YUV_FUSION_MARKER).isFile();
    }

    private static boolean isYuvMultiframeEnabled() {
        return new File(YUV_MULTIFRAME_MARKER).isFile()
                || isYuvFusionEnabled();
    }

    private static boolean isYuvFusionEnabled() {
        return new File(YUV_FUSION_MARKER).isFile()
                || isProductionFusionEnabled();
    }

    private static boolean isProductionFusionEnabled() {
        // The legacy Java YUV path was an experiment, not the Xiaomi ISP
        // pipeline.  Its loose output-signature test also matched Document
        // mode and appended an unwanted full-resolution YUV stream.  Retain
        // the explicit diagnostic markers, but never enable it in production.
        return false;
    }

    private static boolean isOrdinaryPhotoSession(Object[] args) {
        if (args == null || args.length != 5
                || !(args[0] instanceof Integer)
                || ((Integer) args[0]) != 0
                || !(args[1] instanceof List)) {
            return false;
        }
        return isOrdinaryPhotoOutputs((List<?>) args[1]);
    }

    private static boolean isOrdinaryPhotoOutputs(List<?> outputs) {
        if (outputs.size() != 3) {
            return false;
        }
        int preview = 0;
        int jpeg = 0;
        int yuv = 0;
        for (Object output : outputs) {
            int format = configuredOutputFormat(output);
            if (format == 34) {
                preview++;
            } else if (format == ImageFormat.JPEG || format == 33) {
                // OutputConfiguration stores JPEG surfaces internally as
                // HAL_PIXEL_FORMAT_BLOB (33), while camera framework logs
                // expose the public ImageFormat.JPEG value (256).
                jpeg++;
            } else if (format == ImageFormat.YUV_420_888) {
                yuv++;
            }
        }
        return preview == 1 && jpeg == 1 && yuv == 1;
    }

    private static boolean isRearClarityModule(int module) {
        // Photo and Document both need the ColorOS nine-output RAW/2DOL graph.
        // The three-output Xiaomi HAL-JPEG path is stable but bypasses the APS
        // merge and is visibly below the already-proven native image quality.
        return module == 163 || module == 186;
    }

    /**
     * Rear Photo and Document use PRIVATE+JPEG+YUV. Pro/JPG can omit the
     * small Xiaomi YUV output. Reject RAW/DNG, depth and every unfamiliar
     * surface so those modes keep their existing validated session graph.
     */
    private static boolean isRearClarityOutputs(List<?> outputs) {
        if (outputs.size() < 2 || outputs.size() > 3) {
            return false;
        }
        int preview = 0;
        int jpeg = 0;
        int yuv = 0;
        int other = 0;
        for (Object output : outputs) {
            int format = configuredOutputFormat(output);
            if (format == 34) {
                preview++;
            } else if (format == ImageFormat.JPEG || format == 33) {
                jpeg++;
            } else if (format == ImageFormat.YUV_420_888) {
                yuv++;
            } else {
                other++;
            }
        }
        return preview == 1 && jpeg == 1 && yuv <= 1 && other == 0;
    }

    private static boolean isXiaomiPortraitOutputs(List<?> outputs) {
        if (outputs.size() != 4) {
            return false;
        }
        int preview = 0;
        int jpeg = 0;
        int yuv = 0;
        int other = 0;
        for (Object output : outputs) {
            int format = configuredOutputFormat(output);
            if (format == 34) {
                preview++;
            } else if (format == ImageFormat.JPEG || format == 33) {
                jpeg++;
            } else if (format == ImageFormat.YUV_420_888) {
                yuv++;
            } else {
                other++;
            }
        }
        return preview == 1 && jpeg == 2 && yuv == 1 && other == 0;
    }

    private static String outputFormatSignature(List<?> outputs) {
        ArrayList<Integer> formats = new ArrayList<>(outputs.size());
        for (Object output : outputs) {
            formats.add(configuredOutputFormat(output));
        }
        return formats.toString();
    }

    private static int configuredOutputFormat(Object output) {
        try {
            return XposedHelpers.getIntField(output, "mConfiguredFormat");
        } catch (Throwable ignored) {
            try {
                Object surface = XposedHelpers.callMethod(output, "getSurface");
                Object format = XposedHelpers.callStaticMethod(
                        XposedHelpers.findClass(
                                "android.hardware.camera2.utils.SurfaceUtils",
                                null),
                        "getSurfaceFormat", surface);
                return format instanceof Integer ? (Integer) format : -1;
            } catch (Throwable throwable) {
                return -1;
            }
        }
    }

    private static Surface firstConfiguredSurface(
            OutputConfiguration output) {
        if (output == null) {
            return null;
        }
        try {
            List<Surface> surfaces = output.getSurfaces();
            if (surfaces != null && !surfaces.isEmpty()) {
                return surfaces.get(0);
            }
        } catch (Throwable ignored) {
            // Older framework builds expose only getSurface().
        }
        try {
            return output.getSurface();
        } catch (Throwable ignored) {
            return null;
        }
    }

    private static boolean ensureFullYuvReader() {
        synchronized (YUV_PROBE_LOCK) {
            if (fullYuvReader != null) {
                return true;
            }
            try {
                HandlerThread thread = new HandlerThread("OS4FullYuvProbe");
                thread.start();
                Handler handler = new Handler(thread.getLooper());
                ImageReader reader = ImageReader.newInstance(
                        4096, 3072, ImageFormat.YUV_420_888, 8);
                reader.setOnImageAvailableListener(
                        HookEntry::onFullYuvAvailable, handler);
                fullYuvThread = thread;
                fullYuvReader = reader;
                log("[YuvProbe] ImageReader ready 4096x3072 YUV_420_888 max=8");
                return true;
            } catch (Throwable throwable) {
                log("[YuvProbe] ImageReader creation failed: " + throwable);
                return false;
            }
        }
    }

    private static void onFullYuvAvailable(ImageReader reader) {
        Image image = null;
        try {
            image = reader.acquireNextImage();
            if (image == null) {
                return;
            }
            int sequence = ++fullYuvFrameCount;
            if (fusionCapturePending) {
                collectFusionFrame(image, sequence);
                return;
            }
            File directory = new File(YUV_PROBE_DIRECTORY);
            if (!directory.exists() && !directory.mkdirs()) {
                throw new IllegalStateException("cannot create " + directory);
            }
            String stem = "rear_" + image.getWidth() + "x"
                    + image.getHeight() + "_" + image.getTimestamp();
            StringBuilder metadata = new StringBuilder()
                    .append("width=").append(image.getWidth()).append('\n')
                    .append("height=").append(image.getHeight()).append('\n')
                    .append("format=").append(image.getFormat()).append('\n')
                    .append("timestamp=").append(image.getTimestamp()).append('\n')
                    .append("sequence=").append(sequence).append('\n');
            Image.Plane[] planes = image.getPlanes();
            for (int i = 0; i < planes.length; i++) {
                Image.Plane plane = planes[i];
                File output = new File(directory, stem + "_p" + i + ".bin");
                String sha256 = writeAndHash(output,
                        plane.getBuffer().duplicate());
                metadata.append("plane").append(i).append(".file=")
                        .append(output.getName()).append('\n')
                        .append("plane").append(i).append(".bytes=")
                        .append(output.length()).append('\n')
                        .append("plane").append(i).append(".rowStride=")
                        .append(plane.getRowStride()).append('\n')
                        .append("plane").append(i).append(".pixelStride=")
                        .append(plane.getPixelStride()).append('\n')
                        .append("plane").append(i).append(".sha256=")
                        .append(sha256).append('\n');
            }
            File meta = new File(directory, stem + ".txt");
            try (FileOutputStream output = new FileOutputStream(meta)) {
                output.write(metadata.toString().getBytes(StandardCharsets.UTF_8));
                output.getFD().sync();
            }
            boolean complete = sequence >= fullYuvExpectedFrames;
            boolean markerRemoved = false;
            if (complete) {
                markerRemoved = new File(YUV_PROBE_MARKER).delete()
                        | new File(YUV_MULTIFRAME_MARKER).delete();
            }
            log("[YuvProbe] captured real frame#" + sequence
                    + " ts=" + image.getTimestamp()
                    + " size=" + image.getWidth() + "x" + image.getHeight()
                    + " planes=" + planes.length
                    + " metadata=" + meta.getAbsolutePath()
                    + " expected=" + fullYuvExpectedFrames
                    + " complete=" + complete
                    + " oneShotRemoved=" + markerRemoved
                    + "; stock JPEG untouched");
        } catch (Throwable throwable) {
            log("[YuvProbe] frame dump failed: " + throwable);
        } finally {
            if (image != null) {
                try {
                    image.close();
                } catch (Throwable ignored) {
                    // This listener owns the diagnostic image.
                }
            }
        }
    }

    private static void collectFusionFrame(Image image, int sequence) {
        try {
            if (image.getWidth() != 4096 || image.getHeight() != 3072
                    || image.getFormat() != ImageFormat.YUV_420_888) {
                throw new IllegalArgumentException("unexpected YUV "
                        + image.getWidth() + "x" + image.getHeight()
                        + " format=" + image.getFormat());
            }
            Image.Plane[] planes = image.getPlanes();
            if (planes.length != 3) {
                throw new IllegalArgumentException(
                        "unexpected plane count=" + planes.length);
            }
            byte[] y = copyPlane(planes[0], 4096, 3072);
            byte[] vu = copyVuPlanes(planes[1], planes[2], 4096, 3072);
            FusionFrame frame = new FusionFrame(image.getTimestamp(), y, vu);
            ArrayList<FusionFrame> ready = null;
            synchronized (FUSION_LOCK) {
                if (!fusionCapturePending) {
                    return;
                }
                FUSION_FRAMES.add(frame);
                log("[YuvFusion] collected frame#" + sequence
                        + " ts=" + frame.timestamp
                        + " ySha256=" + sha256(frame.y)
                        + " count=" + FUSION_FRAMES.size() + "/5");
                if (FUSION_FRAMES.size() == 5) {
                    ready = new ArrayList<>(FUSION_FRAMES);
                }
            }
            if (ready != null) {
                long start = System.currentTimeMillis();
                byte[] jpeg = fuseToJpeg(ready);
                long elapsed = System.currentTimeMillis() - start;
                synchronized (FUSION_LOCK) {
                    if (fusionCapturePending) {
                        pendingFusedJpeg = jpeg;
                        FUSION_LOCK.notifyAll();
                    }
                }
                log("[YuvFusion] real five-frame fusion ready bytes="
                        + jpeg.length + " elapsedMs=" + elapsed);
            }
        } catch (Throwable throwable) {
            failFusion("frame collection/merge failed: " + throwable);
            log("[YuvFusion] failed; original JPEG retained: " + throwable);
        }
    }

    private static byte[] copyPlane(
            Image.Plane plane, int width, int height) {
        ByteBuffer source = plane.getBuffer().duplicate();
        int base = source.position();
        int rowStride = plane.getRowStride();
        int pixelStride = plane.getPixelStride();
        byte[] output = new byte[width * height];
        if (rowStride == width && pixelStride == 1
                && source.remaining() >= output.length) {
            source.get(output);
            return output;
        }
        for (int row = 0; row < height; row++) {
            int sourceRow = base + row * rowStride;
            int outputRow = row * width;
            for (int column = 0; column < width; column++) {
                output[outputRow + column] = source.get(
                        sourceRow + column * pixelStride);
            }
        }
        return output;
    }

    private static byte[] copyVuPlanes(Image.Plane uPlane,
            Image.Plane vPlane, int width, int height) {
        ByteBuffer u = uPlane.getBuffer().duplicate();
        ByteBuffer v = vPlane.getBuffer().duplicate();
        int uBase = u.position();
        int vBase = v.position();
        int chromaWidth = width / 2;
        int chromaHeight = height / 2;
        byte[] output = new byte[width * chromaHeight];
        for (int row = 0; row < chromaHeight; row++) {
            int uRow = uBase + row * uPlane.getRowStride();
            int vRow = vBase + row * vPlane.getRowStride();
            int outputRow = row * width;
            for (int column = 0; column < chromaWidth; column++) {
                int outputIndex = outputRow + column * 2;
                output[outputIndex] = v.get(
                        vRow + column * vPlane.getPixelStride());
                output[outputIndex + 1] = u.get(
                        uRow + column * uPlane.getPixelStride());
            }
        }
        return output;
    }

    private static byte[] fuseToJpeg(List<FusionFrame> frames)
            throws Exception {
        final int width = 4096;
        final int height = 3072;
        FusionFrame base = frames.get(0);
        int[][] shifts = new int[frames.size()][2];
        for (int index = 1; index < frames.size(); index++) {
            shifts[index] = estimateTranslation(base.y, frames.get(index).y,
                    width, height);
            log("[YuvFusion] alignment frame=" + (index + 1)
                    + " dx=" + shifts[index][0]
                    + " dy=" + shifts[index][1]);
        }

        byte[] nv21 = new byte[width * height * 3 / 2];
        long acceptedY = mergeLuma(frames, shifts, nv21, width, height, 8);
        long acceptedChroma = mergeChroma(frames, shifts, nv21,
                width, height, 12);
        long possibleY = (long) width * height * (frames.size() - 1);
        long possibleChroma = (long) width * (height / 2)
                * (frames.size() - 1);
        log("[YuvFusion] accepted luma=" + acceptedY + "/" + possibleY
                + " chromaBytes=" + acceptedChroma + "/" + possibleChroma);

        YuvImage yuv = new YuvImage(
                nv21, ImageFormat.NV21, width, height, null);
        ByteArrayOutputStream output = new ByteArrayOutputStream(5 * 1024 * 1024);
        if (!yuv.compressToJpeg(new Rect(0, 0, width, height), 96, output)) {
            throw new IllegalStateException("YuvImage JPEG encoder returned false");
        }
        byte[] jpeg = output.toByteArray();
        if (!isJpeg(jpeg)) {
            throw new IllegalStateException("software encoder returned invalid JPEG");
        }
        return jpeg;
    }

    private static int[] estimateTranslation(
            byte[] base, byte[] frame, int width, int height) {
        int bestDxCells = 0;
        int bestDyCells = 0;
        long best = Long.MAX_VALUE;
        final int scale = 8;
        final int searchCells = 16;
        for (int dy = -searchCells; dy <= searchCells; dy++) {
            for (int dx = -searchCells; dx <= searchCells; dx++) {
                long sad = 0;
                int samples = 0;
                for (int y = 24; y < height / scale - 24; y += 4) {
                    int sourceY = (y + dy) * scale;
                    if (sourceY < 0 || sourceY >= height) {
                        continue;
                    }
                    int baseRow = y * scale * width;
                    int sourceRow = sourceY * width;
                    for (int x = 24; x < width / scale - 24; x += 4) {
                        int sourceX = (x + dx) * scale;
                        if (sourceX < 0 || sourceX >= width) {
                            continue;
                        }
                        sad += Math.abs((base[baseRow + x * scale] & 0xff)
                                - (frame[sourceRow + sourceX] & 0xff));
                        samples++;
                    }
                }
                if (samples > 0 && sad < best) {
                    best = sad;
                    bestDxCells = dx;
                    bestDyCells = dy;
                }
            }
        }

        int coarseDx = bestDxCells * scale;
        int coarseDy = bestDyCells * scale;
        int bestDx = coarseDx;
        int bestDy = coarseDy;
        best = Long.MAX_VALUE;
        for (int dy = coarseDy - 7; dy <= coarseDy + 7; dy++) {
            for (int dx = coarseDx - 7; dx <= coarseDx + 7; dx++) {
                long sad = 0;
                int samples = 0;
                for (int y = 144; y < height - 144; y += 16) {
                    int sourceY = y + dy;
                    if (sourceY < 0 || sourceY >= height) {
                        continue;
                    }
                    int baseRow = y * width;
                    int sourceRow = sourceY * width;
                    for (int x = 144; x < width - 144; x += 16) {
                        int sourceX = x + dx;
                        if (sourceX < 0 || sourceX >= width) {
                            continue;
                        }
                        sad += Math.abs((base[baseRow + x] & 0xff)
                                - (frame[sourceRow + sourceX] & 0xff));
                        samples++;
                    }
                }
                if (samples > 0 && sad < best) {
                    best = sad;
                    bestDx = dx;
                    bestDy = dy;
                }
            }
        }
        return new int[]{bestDx, bestDy};
    }

    private static long mergeLuma(List<FusionFrame> frames,
            int[][] shifts, byte[] output, int width, int height,
            int threshold) {
        byte[] base = frames.get(0).y;
        long accepted = 0;
        for (int y = 0; y < height; y++) {
            int row = y * width;
            for (int x = 0; x < width; x++) {
                int baseValue = base[row + x] & 0xff;
                int sum = baseValue;
                int count = 1;
                for (int index = 1; index < frames.size(); index++) {
                    int sourceX = x + shifts[index][0];
                    int sourceY = y + shifts[index][1];
                    if (sourceX < 0 || sourceX >= width
                            || sourceY < 0 || sourceY >= height) {
                        continue;
                    }
                    int value = frames.get(index).y[
                            sourceY * width + sourceX] & 0xff;
                    if (Math.abs(value - baseValue) <= threshold) {
                        sum += value;
                        count++;
                        accepted++;
                    }
                }
                output[row + x] = (byte) ((sum + count / 2) / count);
            }
        }
        return accepted;
    }

    private static long mergeChroma(List<FusionFrame> frames,
            int[][] shifts, byte[] output, int width, int height,
            int threshold) {
        int chromaHeight = height / 2;
        int outputOffset = width * height;
        byte[] base = frames.get(0).vu;
        long accepted = 0;
        for (int row = 0; row < chromaHeight; row++) {
            int rowOffset = row * width;
            for (int column = 0; column < width / 2; column++) {
                int pairOffset = rowOffset + column * 2;
                for (int component = 0; component < 2; component++) {
                    int baseValue = base[pairOffset + component] & 0xff;
                    int sum = baseValue;
                    int count = 1;
                    for (int index = 1; index < frames.size(); index++) {
                        int sourceColumn = column
                                + Math.round(shifts[index][0] / 2.0f);
                        int sourceRow = row
                                + Math.round(shifts[index][1] / 2.0f);
                        if (sourceColumn < 0 || sourceColumn >= width / 2
                                || sourceRow < 0
                                || sourceRow >= chromaHeight) {
                            continue;
                        }
                        int value = frames.get(index).vu[
                                sourceRow * width + sourceColumn * 2
                                        + component] & 0xff;
                        if (Math.abs(value - baseValue) <= threshold) {
                            sum += value;
                            count++;
                            accepted++;
                        }
                    }
                    output[outputOffset + pairOffset + component] =
                            (byte) ((sum + count / 2) / count);
                }
            }
        }
        return accepted;
    }

    private static boolean replaceFinalJpegWithCommonAps(
            XC_MethodHook.MethodHookParam param) {
        if (!COMMON_APS_SHUTTER_ARMED.get()
                || param.args == null || param.args.length != 2
                || !(param.args[0] instanceof Integer)
                || ((Integer) param.args[0]) != 0
                || !(param.args[1] instanceof byte[])) {
            return false;
        }
        byte[] original = (byte[]) param.args[1];
        if (!isJpeg(original)) {
            return false;
        }
        long taskTimestamp;
        Object sourceData;
        try {
            sourceData = XposedHelpers.getObjectField(
                    param.thisObject, "a");
            taskTimestamp = XposedHelpers.getLongField(sourceData, "f");
        } catch (Throwable throwable) {
            log("[ApsShutter] Rh.r timestamp unavailable; original retained: "
                    + throwable);
            return false;
        }
        if (commonApsShutterTimestamp > 0L
                && taskTimestamp != commonApsShutterTimestamp) {
            return false;
        }

        byte[] apsJpeg;
        String failure;
        boolean timedOut = false;
        synchronized (COMMON_APS_SHUTTER_LOCK) {
            commonApsShutterRhSeen = true;
            if (!COMMON_APS_SHUTTER_HANDOFF_STARTED.get()) {
                commonApsShutterFailure =
                        "Rh.r arrived before APS handoff started";
            }
            long deadline = SystemClock.elapsedRealtime() + 24_000L;
            while (COMMON_APS_SHUTTER_HANDOFF_STARTED.get()
                    && commonApsShutterJpeg == null
                    && commonApsShutterFailure == null) {
                long remaining = deadline - SystemClock.elapsedRealtime();
                if (remaining <= 0L) {
                    commonApsShutterFailure = "APS Rh.r wait timeout";
                    timedOut = true;
                    break;
                }
                try {
                    COMMON_APS_SHUTTER_LOCK.wait(remaining);
                } catch (InterruptedException exception) {
                    Thread.currentThread().interrupt();
                    commonApsShutterFailure = "APS Rh.r wait interrupted";
                    break;
                }
            }
            apsJpeg = commonApsShutterJpeg;
            failure = commonApsShutterFailure;
        }

        try {
            if (isJpeg(apsJpeg)) {
                byte[] replacement = transplantAppMetadata(original, apsJpeg);
                if (!isJpeg(replacement)) {
                    throw new IllegalStateException(
                            "metadata transplant returned invalid JPEG");
                }
                param.args[1] = replacement;
                log("[ApsShutter] Rh.r base replaced original="
                        + original.length + " APS=" + apsJpeg.length
                        + " transplanted=" + replacement.length
                        + " taskTs=" + taskTimestamp
                        + "; Xiaomi Effect/Exif/Water/Store continues");
            } else {
                log("[ApsShutter] original Xiaomi JPEG retained taskTs="
                        + taskTimestamp + " reason=" + failure);
            }
        } catch (Throwable throwable) {
            log("[ApsShutter] replacement rejected; original retained: "
                    + throwable);
        } finally {
            if (timedOut) {
                abortCommonApsCapture("Rh.r-wait-timeout", true);
                restoreActiveHandoff("Rh.r-wait-timeout");
            }
            clearCommonApsShutterState();
        }
        // This Rh.r belongs to the one-shot APS state even on fail-open.  Do
        // not let the older software-YUV proof claim the same JPEG.
        return true;
    }

    private static void hookFusedJpegReplacement(ClassLoader loader) {
        Class<?> task = XposedHelpers.findClass("Rh.r", loader);
        XposedBridge.hookAllMethods(task, "a", new XC_MethodHook() {
            @Override
            protected void beforeHookedMethod(MethodHookParam param) {
                if (replaceFinalJpegWithCommonAps(param)) {
                    return;
                }
                if (param.args == null || param.args.length != 2
                        || !(param.args[0] instanceof Integer)
                        || ((Integer) param.args[0]) != 0
                        || !(param.args[1] instanceof byte[])
                        || !fusionCapturePending) {
                    return;
                }
                byte[] original = (byte[]) param.args[1];
                byte[] fused = null;
                String failure;
                long deadline = System.currentTimeMillis() + 10_000L;
                synchronized (FUSION_LOCK) {
                    while (fusionCapturePending
                            && pendingFusedJpeg == null
                            && fusionFailure == null) {
                        long remaining = deadline - System.currentTimeMillis();
                        if (remaining <= 0) {
                            fusionFailure = "fusion timeout";
                            break;
                        }
                        try {
                            FUSION_LOCK.wait(remaining);
                        } catch (InterruptedException exception) {
                            Thread.currentThread().interrupt();
                            fusionFailure = "wait interrupted";
                            break;
                        }
                    }
                    fused = pendingFusedJpeg;
                    failure = fusionFailure;
                }
                try {
                    if (isJpeg(fused)) {
                        byte[] replacement = transplantAppMetadata(
                                original, fused);
                        if (isJpeg(replacement)) {
                            param.args[1] = replacement;
                            log("[YuvFusion] replaced final JPEG original="
                                    + original.length + " fused="
                                    + replacement.length
                                    + " EXIF/ICC transplanted");
                        }
                    } else {
                        log("[YuvFusion] fallback to original JPEG reason="
                                + failure);
                    }
                } catch (Throwable throwable) {
                    log("[YuvFusion] replacement rejected; original retained: "
                            + throwable);
                } finally {
                    synchronized (FUSION_LOCK) {
                        fusionCapturePending = false;
                        pendingFusedJpeg = null;
                        fusionFailure = null;
                        FUSION_FRAMES.clear();
                        FUSION_LOCK.notifyAll();
                    }
                    File oneShot = new File(YUV_FUSION_MARKER);
                    if (oneShot.isFile()) {
                        boolean removed = oneShot.delete();
                        log("[YuvFusion] one-shot marker removed=" + removed);
                    }
                }
            }
        });
        log("[YuvFusion] Rh.r final-JPEG replacement hook active");
    }

    private static void hookLeicaCaptureMetadata() {
        XposedBridge.hookAllConstructors(TotalCaptureResult.class,
                new XC_MethodHook() {
                    @Override
                    protected void afterHookedMethod(MethodHookParam param) {
                        if (!(param.thisObject instanceof TotalCaptureResult)
                                || activeBeautyModule != 163) {
                            return;
                        }
                        TotalCaptureResult result =
                                (TotalCaptureResult) param.thisObject;
                        commonApsDecisionMetadata = result;
                        commonApsDecisionMetadataNanos =
                                SystemClock.elapsedRealtimeNanos();
                        Float lux = firstResultValue(result,
                                QTI_AEC_LUX_INDEX,
                                QTI_CHI_AEC_LUX,
                                OPLUS_RAW_HDR_LUX_INDEX);
                        Number cct = firstResultValue(result,
                                QTI_AWB_FRAME_CCT,
                                QTI_AWB_CCT,
                                OPLUS_AWB_SENSOR_CCT);
                        Float zoom = safeResultValue(result,
                                CaptureResult.CONTROL_ZOOM_RATIO);
                        if (lux != null && Float.isFinite(lux)
                                && lux >= 0.0f) {
                            latestLeicaLux = Math.max(0,
                                    Math.min(999, Math.round(lux)));
                        }
                        if (cct != null) {
                            int value = Math.round(cct.floatValue());
                            if (value > 0) {
                                latestLeicaCct = Math.max(1,
                                        Math.min(10000, value));
                            }
                        }
                        if (zoom != null && Float.isFinite(zoom)
                                && zoom > 0.0f) {
                            latestLeicaZoom = zoom;
                        }
                        try {
                            CaptureRequest routeRequest = result.getRequest();
                            Object requestFps = routeRequest == null
                                    ? null : routeRequest.get(CaptureRequest
                                    .CONTROL_AE_TARGET_FPS_RANGE);
                            Object resultFps = safeResultValue(result,
                                    CaptureResult
                                            .CONTROL_AE_TARGET_FPS_RANGE);
                            Long frameDuration = safeResultValue(result,
                                    CaptureResult.SENSOR_FRAME_DURATION);
                            String fpsSignature = requestFps + ":"
                                    + resultFps + ":" + frameDuration;
                            if (!fpsSignature.equals(lastPhotoFpsSignature)) {
                                lastPhotoFpsSignature = fpsSignature;
                                double measuredLimit = frameDuration == null
                                        || frameDuration <= 0L
                                        ? 0.0
                                        : 1_000_000_000.0 / frameDuration;
                                log("[PhotoFps] request=" + requestFps
                                        + " result=" + resultFps
                                        + " frameDurationNs="
                                        + frameDuration + " maxByDuration="
                                        + String.format(Locale.US, "%.1f",
                                        measuredLimit));
                            }
                            Integer routeIntent = routeRequest == null
                                    ? null : routeRequest.get(
                                    CaptureRequest.CONTROL_CAPTURE_INTENT);
                            Float requestZoom = routeRequest == null
                                    ? null : routeRequest.get(
                                    CaptureRequest.CONTROL_ZOOM_RATIO);
                            String activePhysical = safeResultValue(result,
                                    CaptureResult
                                            .LOGICAL_MULTI_CAMERA_ACTIVE_PHYSICAL_ID);
                            Float focal = safeResultValue(result,
                                    CaptureResult.LENS_FOCAL_LENGTH);
                            float[] originalZoom = routeRequest == null
                                    ? null : routeRequest.get(
                                    OPLUS_ORIGINAL_ZOOM);
                            float[] targetZoom = routeRequest == null
                                    ? null : routeRequest.get(
                                    OPLUS_ZOOM_TARGET);
                            int[] satMaster = routeRequest == null
                                    ? null : routeRequest.get(
                                    COMMON_APS_SAT_MASTER_CAMERA);
                            String routeSignature = routeIntent + ":"
                                    + requestZoom + ":" + activePhysical
                                    + ":" + focal + ":"
                                    + Arrays.toString(originalZoom) + ":"
                                    + Arrays.toString(targetZoom) + ":"
                                    + Arrays.toString(satMaster);
                            if (!routeSignature.equals(
                                    lastUnifiedPreviewRouteSignature)) {
                                lastUnifiedPreviewRouteSignature =
                                        routeSignature;
                                log("[UnifiedRoute] phase="
                                        + (Integer.valueOf(CaptureRequest
                                        .CONTROL_CAPTURE_INTENT_STILL_CAPTURE)
                                        .equals(routeIntent)
                                        ? "still" : "preview")
                                        + " requestZoom=" + requestZoom
                                        + " resultZoom=" + zoom
                                        + " active=" + activePhysical
                                        + " focal=" + focal
                                        + " original="
                                        + Arrays.toString(originalZoom)
                                        + " target="
                                        + Arrays.toString(targetZoom)
                                        + " master="
                                        + Arrays.toString(satMaster));
                            }
                        } catch (Throwable routeReadFailure) {
                            log("[UnifiedRoute] result read failed: "
                                    + routeReadFailure);
                        }
                        if (!loggedLeicaMetadata && lux != null
                                && cct != null) {
                            loggedLeicaMetadata = true;
                            log("[LeicaMeta] live lux=" + latestLeicaLux
                                    + " cct=" + latestLeicaCct
                                    + " zoom=" + latestLeicaZoom);
                        }
                    }
                });
        log("[LeicaMeta] TotalCaptureResult lux/CCT/zoom cache active");
    }

    private static void hookOplusActiveLensProbe() {
        XposedBridge.hookAllConstructors(TotalCaptureResult.class,
                new XC_MethodHook() {
                    @Override
                    protected void afterHookedMethod(MethodHookParam param) {
                        if (!(param.thisObject instanceof TotalCaptureResult)) {
                            return;
                        }
                        try {
                            TotalCaptureResult result =
                                    (TotalCaptureResult) param.thisObject;
                            CaptureRequest request = result.getRequest();
                            if (request == null || !captureRequestHasTargets(
                                    request)) {
                                return;
                            }
                            Float requestZoom = request.get(
                                    CaptureRequest.CONTROL_ZOOM_RATIO);
                            Float resultZoom = safeResultValue(result,
                                    CaptureResult.CONTROL_ZOOM_RATIO);
                            String active = safeResultValue(result,
                                    CaptureResult
                                            .LOGICAL_MULTI_CAMERA_ACTIVE_PHYSICAL_ID);
                            Float focal = safeResultValue(result,
                                    CaptureResult.LENS_FOCAL_LENGTH);
                            Integer intent = request.get(
                                    CaptureRequest.CONTROL_CAPTURE_INTENT);
                            String signature = intent + ":" + requestZoom
                                    + ":" + resultZoom + ":" + active
                                    + ":" + focal;
                            if (signature.equals(
                                    lastOplusReferenceRouteSignature)) {
                                return;
                            }
                            lastOplusReferenceRouteSignature = signature;
                            log("[OplusActiveLens] intent=" + intent
                                    + " requestZoom=" + requestZoom
                                    + " resultZoom=" + resultZoom
                                    + " active=" + active + " focal="
                                    + focal);
                            for (CaptureRequest.Key<?> key
                                    : request.getKeys()) {
                                String name = key.getName();
                                String lower = name == null ? ""
                                        : name.toLowerCase(Locale.US);
                                if (!(lower.contains("zoom")
                                        || lower.contains("fallback")
                                        || lower.contains("sat.snapshot")
                                        || lower.contains("sensor.mode")
                                        || lower.contains("light.sensor.lux")
                                        || lower.contains("pip.preview.sensor")
                                        || lower.contains("supernight")
                                        || lower.contains("capture.request"))) {
                                    continue;
                                }
                                try {
                                    log("[OplusActiveLens] " + name + "="
                                            + apsValueString(request.get(
                                            key)));
                                } catch (Throwable ignored) {
                                    // Vendor key can disappear mid-result.
                                }
                            }
                        } catch (Throwable throwable) {
                            log("[OplusActiveLens] read failed: "
                                    + throwable);
                        }
                    }
                });
        log("[OplusActiveLens] stock TotalCaptureResult probe active");
    }

    @SafeVarargs
    private static <T> T firstResultValue(
            CaptureResult result, CaptureResult.Key<? extends T>... keys) {
        for (CaptureResult.Key<? extends T> key : keys) {
            T value = safeResultValue(result, key);
            if (value != null) {
                return value;
            }
        }
        return null;
    }

    private static <T> T safeResultValue(
            CaptureResult result, CaptureResult.Key<T> key) {
        try {
            return result.get(key);
        } catch (Throwable ignored) {
            return null;
        }
    }

    /**
     * Document mode successfully runs Xiaomi's preview detector on this port,
     * but the direct OnePlus JPEG route is saved by k7.l (Image).  That task
     * list omits p7.b (Doc), unlike Xiaomi's normal k7.s (Parallel) list:
     * Water -> Effect -> Doc -> Exif -> StoreImage.  The interceptor itself
     * and libDocumentProcess.so are both healthy, so restore the missing
     * stage at the task boundary instead of approximating its processing.
     */
    private static void hookDocumentSavePipeline(ClassLoader loader) {
        Class<?> docModule = XposedHelpers.findClass(
                "com.android.camera.features.mode.doc.DocModule", loader);
        Class<?> parallelTaskData = XposedHelpers.findClass("Rh.r", loader);
        Class<?> docTask = XposedHelpers.findClass("p7.b", loader);
        Class<?> exifTask = XposedHelpers.findClass("p7.c", loader);
        Class<?> docInterceptor = XposedHelpers.findClass("Bn.a", loader);
        Class<?> interceptorContext = XposedHelpers.findClass("Zp.b", loader);
        Class<?> interceptorData = XposedHelpers.findClass("Zp.d", loader);

        // Keep a diagnostic/repair at the producer as well.  Usually the
        // interceptor is already present; the broken route only lacks its
        // consumer task.  If a vendor feature gate skipped it, recreate the
        // exact stock interceptor from DocModule's live manager/shot data.
        XposedBridge.hookAllMethods(docModule,
                "appendPhotoSaveInterceptors", new XC_MethodHook() {
                    @Override
                    protected void afterHookedMethod(MethodHookParam param) {
                        if (activeCameraModule != 186
                                || param.args == null
                                || param.args.length != 1
                                || param.args[0] == null) {
                            return;
                        }
                        try {
                            Object raw = XposedHelpers.getObjectField(
                                    param.args[0], "a");
                            if (!(raw instanceof List<?>)) {
                                log("[DocumentBridge] interceptor list missing");
                                return;
                            }
                            @SuppressWarnings("unchecked")
                            List<Object> interceptors = (List<Object>) raw;
                            boolean found = false;
                            ArrayList<String> names = new ArrayList<>();
                            for (Object interceptor : interceptors) {
                                String name = interceptor == null
                                        ? "null"
                                        : interceptor.getClass().getName();
                                names.add(name);
                                if (interceptor != null
                                        && docInterceptor.isInstance(interceptor)) {
                                    found = true;
                                }
                            }
                            if (!found) {
                                Object manager = XposedHelpers.getObjectField(
                                        param.thisObject, "mDocumentManager");
                                Object shotData = XposedHelpers.getObjectField(
                                        param.thisObject, "mDocShotData");
                                if (manager != null && shotData != null) {
                                    interceptors.add(XposedHelpers.newInstance(
                                            docInterceptor, manager, shotData));
                                    names.add("Bn.a(restored)");
                                    found = true;
                                }
                            }
                            log("[DocumentBridge] interceptors=" + names
                                    + " doc=" + found);
                        } catch (Throwable throwable) {
                            log("[DocumentBridge] interceptor repair failed: "
                                    + throwable);
                        }
                    }
                });

        // A proper Parallel saver already runs its p7.b stage.  Remember it
        // so the Image-route fallback below never processes a JPEG twice.
        XposedBridge.hookAllMethods(docTask, "a", new XC_MethodHook() {
            @Override
            protected void beforeHookedMethod(MethodHookParam param) {
                if (param.args != null && param.args.length == 1
                        && parallelTaskData.isInstance(param.args[0])) {
                    DOCUMENT_TASKS_PROCESSED.put(param.args[0], Boolean.TRUE);
                }
            }
        });

        // The actual port chooses k7.l (Image): Water, Effect, Exif, Store.
        // Run the exact p7.b interceptor logic immediately before Exif.  The
        // p7.b Dex class intentionally has no constructor of its own (stock
        // invokes p7.d.<init> directly), so it cannot be reflectively inserted
        // even though decompiled Java appears to contain `new p7.b()`.
        XposedHelpers.findAndHookMethod(exifTask, "a",
                parallelTaskData, new XC_MethodHook() {
                    @Override
                    protected void beforeHookedMethod(MethodHookParam param) {
                        if (activeCameraModule != 186
                                || param.args == null
                                || param.args.length != 1
                                || !parallelTaskData.isInstance(param.args[0])) {
                            return;
                        }
                        Object task = param.args[0];
                        synchronized (DOCUMENT_TASKS_PROCESSED) {
                            if (DOCUMENT_TASKS_PROCESSED.containsKey(task)) {
                                return;
                            }
                            DOCUMENT_TASKS_PROCESSED.put(task, Boolean.TRUE);
                        }
                        long started = SystemClock.elapsedRealtime();
                        try {
                            runDocumentInterceptor(task, interceptorContext,
                                    interceptorData);
                            log("[DocumentBridge] native Doc completed before"
                                    + " Exif costMs="
                                    + (SystemClock.elapsedRealtime() - started));
                        } catch (Throwable throwable) {
                            log("[DocumentBridge] native Doc failed before Exif: "
                                    + throwable);
                        }
                    }
                });
        log("[DocumentBridge] native Xiaomi document pipeline active");
    }

    private static void runDocumentInterceptor(Object task,
            Class<?> interceptorContext, Class<?> interceptorData) {
        Object chain = XposedHelpers.getObjectField(task, "m");
        if (chain == null) {
            throw new IllegalStateException("photo interceptor chain is null");
        }
        Object shot = XposedHelpers.getObjectField(task, "a");
        byte[] jpeg = (byte[]) XposedHelpers.getObjectField(shot, "i");
        if (!isJpeg(jpeg)) {
            throw new IllegalStateException("document JPEG is absent");
        }
        Object exifData = XposedHelpers.getObjectField(task, "e");
        Object exif = XposedHelpers.callMethod(exifData, "getExif", jpeg);
        int exifOrientation = (Integer) XposedHelpers.callMethod(exif, "r");
        int shootOrientation = XposedHelpers.getIntField(shot, "c");
        int width = XposedHelpers.getIntField(shot, "a");
        int height = XposedHelpers.getIntField(shot, "b");
        if ((shootOrientation + exifOrientation) % 180 != 0) {
            int swap = width;
            width = height;
            height = swap;
        }
        long timestamp = XposedHelpers.getLongField(shot, "g");
        Object location = XposedHelpers.callMethod(exifData, "getLocation");
        boolean needUpdate = (Boolean) XposedHelpers.callMethod(
                exifData, "getNeedUpdate");
        String algorithmName = (String) XposedHelpers.callMethod(
                exifData, "getAlgorithmName");
        Object pictureInfo = XposedHelpers.callMethod(
                exifData, "getPictureInfo");

        Object context = XposedHelpers.newInstance(interceptorContext,
                width, height, timestamp, location, needUpdate,
                algorithmName, pictureInfo, task);
        Object data = XposedHelpers.newInstance(interceptorData,
                jpeg, context, false, false, true);
        Object processedData = XposedHelpers.callMethod(chain, "a", data);
        if (processedData == null) {
            throw new IllegalStateException("interceptor returned null");
        }
        byte[] processed = (byte[]) XposedHelpers.getObjectField(
                processedData, "a");
        if (!isJpeg(processed)) {
            throw new IllegalStateException(
                    "interceptor returned invalid JPEG");
        }
        byte[] finalJpeg = processed;
        if (!new File(DOCUMENT_AI_DISABLE_MARKER).isFile()) {
            boolean probe = new File(DOCUMENT_AI_PROBE_MARKER).isFile();
            if (probe) {
                writeDocumentProbe("before.jpg", processed);
            }
            try {
                DocumentTextEnhancer.Result enhanced =
                        DocumentTextEnhancer.enhance(
                                processed, moduleApkPath);
                if (isJpeg(enhanced.jpeg)) {
                    finalJpeg = enhanced.jpeg;
                    if (probe) {
                        writeDocumentProbe("after.jpg", finalJpeg);
                    }
                    log("[DocumentAI] ColorOS text model applied bytes="
                            + processed.length + "->" + finalJpeg.length
                            + " inferenceMs=" + enhanced.inferenceMs
                            + " totalMs=" + enhanced.totalMs
                            + " meanAbsDelta="
                            + String.format(Locale.US, "%.3f",
                            enhanced.meanAbsDelta)
                            + " maxDelta=" + enhanced.maxAbsDelta
                            + " changed=" + enhanced.changedPixels);
                }
            } catch (Throwable throwable) {
                log("[DocumentAI] original retained: " + throwable);
            }
        }
        XposedHelpers.callMethod(task, "O", finalJpeg, null, null);
        log("[DocumentBridge] JPEG=" + jpeg.length + "->"
                + finalJpeg.length + " size=" + width + "x" + height
                + " orientation=" + shootOrientation + "+"
                + exifOrientation);
    }

    private static void writeDocumentProbe(String name, byte[] jpeg) {
        try {
            File directory = new File(DOCUMENT_AI_DIRECTORY);
            if (!directory.exists() && !directory.mkdirs()) {
                throw new IllegalStateException("mkdir failed");
            }
            try (FileOutputStream output = new FileOutputStream(
                    new File(directory, name))) {
                output.write(jpeg);
            }
        } catch (Throwable throwable) {
            log("[DocumentAI] debug JPEG write failed: " + throwable);
        }
    }

    /**
     * The OnePlus HAL's direct JPEG route is deliberately kept because it is
     * the only stable full-resolution capture path on this port.  Xiaomi's
     * preview renderer, however, never gets a chance to process that JPEG:
     * it only writes com.xiaomi.mivi2.render for the absent Mivi service.
     *
     * Build the exact Candy script and decrypted LUT list from the live
     * EffectController, then execute it in CandySDK's bitmap backend before
     * Rh.r stores the final image.  This reuses Xiaomi's own parameter
     * compiler and color math without reviving Mivi, changing shot type, or
     * coupling filters to the watermark pipeline.
     */
    private static void hookFinalJpegEffects(ClassLoader loader) {
        Class<?> task = XposedHelpers.findClass("Rh.r", loader);
        Class<?> renderTag = XposedHelpers.findClass(
                "com.xiaomi.camera.mivi.filter.MIVIRenderTag", loader);
        Class<?> candySdk = XposedHelpers.findClass(
                "com.xiaomi.milab.filtersdk.CandySDK", loader);
        XposedBridge.hookAllMethods(task, "a", new XC_MethodHook() {
            @Override
            protected void beforeHookedMethod(MethodHookParam param) {
                if (param.args == null || param.args.length != 2
                        || !(param.args[0] instanceof Integer)
                        || ((Integer) param.args[0]) != 0
                        || !(param.args[1] instanceof byte[])
                        || activeBeautyModule != 163) {
                    return;
                }
                byte[] original = (byte[]) param.args[1];
                if (!isJpeg(original)) {
                    return;
                }
                long started = SystemClock.elapsedRealtime();
                try {
                    synchronized (JPEG_POST_LOCK) {
                        byte[] processed = renderFinalJpegEffects(
                                original, renderTag, candySdk);
                        if (isJpeg(processed)) {
                            param.args[1] = processed;
                            log("[JpegEffects] final JPEG replaced bytes="
                                    + original.length + "->"
                                    + processed.length + " costMs="
                                    + (SystemClock.elapsedRealtime() - started));
                        }
                    }
                } catch (Throwable throwable) {
                    log("[JpegEffects] original retained: " + throwable);
                }
            }
        });
        log("[JpegEffects] independent Rh.r pipeline active");
    }

    /**
     * Xiaomi's normal cloud-watermark task expects a YUV/Mivi result.  For
     * parallelType 4/104 (a JPEG supplied directly by the HAL) it deliberately
     * performs metadata bookkeeping only, because Xiaomi's own HAL has already
     * rendered the selected watermark.  The OnePlus HAL does not implement
     * com.xiaomi.camera.watermark.enable, leaving the original JPEG untouched.
     *
     * Re-enter Xiaomi's own Bitmap capture adapter after that no-op.  Ls.j.e
     * converts the decoded JPEG to I420, fills the live template parameters,
     * invokes S8.d.f/WatermarkRemover, and writes the resulting JPEG back into
     * the same Rh.r task.  This preserves the single native Water -> Effect ->
     * Exif -> Store owner instead of adding an asynchronous or hand-drawn
     * fallback layer.
     */
    private static void hookNativeJpegWatermark(ClassLoader loader) {
        Class<?> waterTask = XposedHelpers.findClass("p7.g", loader);
        Class<?> bitmapWatermarkAdapter = XposedHelpers.findClass(
                "Ls.j", loader);
        ThreadLocal<byte[]> inputJpeg = new ThreadLocal<>();
        XposedBridge.hookAllMethods(waterTask, "a", new XC_MethodHook() {
            @Override
            protected void beforeHookedMethod(MethodHookParam param) {
                inputJpeg.remove();
                try {
                    if (param.args == null || param.args.length != 1
                            || param.args[0] == null) {
                        return;
                    }
                    Object sourceData = XposedHelpers.getObjectField(
                            param.args[0], "a");
                    byte[] jpeg = (byte[]) XposedHelpers.getObjectField(
                            sourceData, "i");
                    if (isJpeg(jpeg)) {
                        inputJpeg.set(jpeg);
                    }
                } catch (Throwable ignored) {
                    inputJpeg.remove();
                }
            }

            @Override
            protected void afterHookedMethod(MethodHookParam param) {
                byte[] jpegBeforeWater = inputJpeg.get();
                inputJpeg.remove();
                // Legend keeps RAW dimensions independent of the native watermark frame.
                // Its container adapter preserves the actual image ROI/removal metadata.
                if (param.hasThrowable() || param.args == null
                        || param.args.length != 1 || param.args[0] == null
                        || jpegBeforeWater == null) {
                    return;
                }
                Object task = param.args[0];
                Bitmap bitmap = null;
                Object effectData = null;
                Object captureData = null;
                int originalQuality = -1;
                boolean bridgedCaptureResult = false;
                Object orientationData = null;
                int originalTaskOrientation = 0;
                boolean normalizedTaskOrientation = false;
                boolean watermarkRendered = false;
                long started = SystemClock.elapsedRealtime();
                try {
                    Object auxiliaryData = XposedHelpers.getObjectField(
                            task, "b");
                    int parallelType = XposedHelpers.getIntField(
                            auxiliaryData, "f");
                    Object waterData = XposedHelpers.getObjectField(
                            task, "l");
                    if (!XposedHelpers.getBooleanField(
                            waterData, "e")) {
                        return;
                    }
                    Object sourceData = XposedHelpers.getObjectField(
                            task, "a");
                    byte[] jpeg = (byte[]) XposedHelpers.getObjectField(
                            sourceData, "i");
                    if (!isJpeg(jpeg)) {
                        log("[NativeWatermark] skip non-JPEG type="
                                + parallelType);
                        return;
                    }
                    // p7.g has already had first ownership of the Water task.
                    // If it replaced the input, Xiaomi's native YUV/HEIF path
                    // rendered the watermark and must not be run a second time.
                    if (jpeg != jpegBeforeWater) {
                        log("[NativeWatermark] native Water already replaced"
                                + " type=" + parallelType);
                        return;
                    }

                    BitmapFactory.Options options = new BitmapFactory.Options();
                    options.inPreferredConfig = Bitmap.Config.ARGB_8888;
                    options.inMutable = true;
                    bitmap = BitmapFactory.decodeByteArray(
                            jpeg, 0, jpeg.length, options);
                    if (bitmap == null) {
                        throw new IllegalStateException(
                                "HAL JPEG decode returned null");
                    }
                    int bitmapWidth = bitmap.getWidth();
                    int bitmapHeight = bitmap.getHeight();

                    int taskOrientation = XposedHelpers.getIntField(
                            sourceData, "c");
                    originalTaskOrientation = XposedHelpers.getIntField(
                            sourceData, "d");
                    // OPlus APS has already emitted display-oriented pixels:
                    // a portrait shot is physically 3072x4096. Xiaomi's
                    // Bitmap watermark encoder normally receives the
                    // sensor-landscape JPEG and rotates it using this task
                    // field. Keeping the stale 90/270 here rotates our
                    // already-upright image a second time, while the newly
                    // composed watermark remains upright. Normalize only
                    // ordinary Photo's portrait APS result; native Xiaomi
                    // modes and landscape captures keep their own contract.
                    if ((activeCameraModule == 163 || activeCameraModule == 256
                            && LegendaryNativeCaptureBridge.isPhotoApsSource(sourceData))
                            && bitmapHeight > bitmapWidth
                            && (originalTaskOrientation == 90
                            || originalTaskOrientation == 270)) {
                        orientationData = sourceData;
                        XposedHelpers.setIntField(sourceData, "d", 0);
                        normalizedTaskOrientation = true;
                        log("[NativeWatermark] display-oriented APS portrait"
                                + " " + bitmapWidth + "x" + bitmapHeight
                                + " orientation=" + taskOrientation
                                + " jpegRotation="
                                + originalTaskOrientation + " -> 0");
                    }

                    // This value is consumed by S8.d.f's sole JPEG encoder.
                    // Restore it immediately so no later Effect/Exif task has
                    // its configuration mutated by the adapter.
                    effectData = XposedHelpers.getObjectField(
                            task, "d");
                    originalQuality = XposedHelpers.getIntField(
                            effectData, "g");
                    XposedHelpers.setIntField(effectData, "g", 100);
                    captureData = XposedHelpers.getObjectField(
                            task, "f");
                    Object captureResult = XposedHelpers.getObjectField(
                            captureData, "c");
                    Object totalCaptureResult = XposedHelpers.getObjectField(
                            captureData, "b");
                    long taskTimestamp = XposedHelpers.getLongField(
                            sourceData, "f");
                    boolean joinedByTimestamp = false;
                    if (totalCaptureResult == null) {
                        TotalCaptureResult cached =
                                STILL_CAPTURE_RESULTS.remove(taskTimestamp);
                        if (cached != null) {
                            // Keep the real TotalCaptureResult in the task so
                            // the following Exif stage can consume it too.
                            XposedHelpers.setObjectField(
                                    captureData, "b", cached);
                            totalCaptureResult = cached;
                            joinedByTimestamp = true;
                        }
                    }
                    if (captureResult == null && totalCaptureResult != null) {
                        // TotalCaptureResult extends CaptureResult.  Xiaomi's
                        // Bitmap adapter only checks field c, while this HAL's
                        // save task commonly populates only field b.
                        XposedHelpers.setObjectField(
                                captureData, "c", totalCaptureResult);
                        captureResult = totalCaptureResult;
                        bridgedCaptureResult = true;
                    }
                    String watermarkId = (String) XposedHelpers.getObjectField(
                            waterData, "w");
                    log("[NativeWatermark] entering Xiaomi Bitmap adapter"
                            + " type=" + parallelType + " captureResult="
                            + (captureResult != null) + " bridged="
                            + bridgedCaptureResult + " joined="
                            + joinedByTimestamp + " taskTs=" + taskTimestamp
                            + " id=" + watermarkId);
                    XposedHelpers.callStaticMethod(
                            bitmapWatermarkAdapter, "e", task, bitmap);

                    byte[] rendered = (byte[]) XposedHelpers.getObjectField(
                            sourceData, "i");
                    if (!isJpeg(rendered) || rendered == jpeg) {
                        throw new IllegalStateException(
                                "official Bitmap adapter returned original JPEG");
                    }
                    watermarkRendered = true;
                    log("[NativeWatermark] Xiaomi template rendered type="
                            + parallelType + " q=100 bytes=" + jpeg.length
                            + "->" + rendered.length + " size="
                            + bitmapWidth + "x" + bitmapHeight
                            + " costMs="
                            + (SystemClock.elapsedRealtime() - started));
                } catch (Throwable throwable) {
                    // The original p7.g branch has already left a valid JPEG
                    // in the task, so failure here is safely fail-open.
                    log("[NativeWatermark] original retained: " + throwable);
                } finally {
                    if (normalizedTaskOrientation && !watermarkRendered
                            && orientationData != null) {
                        try {
                            XposedHelpers.setIntField(orientationData, "d",
                                    originalTaskOrientation);
                        } catch (Throwable ignored) {
                            // Preserve the original task if rendering failed.
                        }
                    }
                    if (bridgedCaptureResult && captureData != null) {
                        try {
                            XposedHelpers.setObjectField(
                                    captureData, "c", null);
                        } catch (Throwable ignored) {
                            // The save task is already valid without the bridge.
                        }
                    }
                    if (effectData != null && originalQuality >= 0) {
                        try {
                            XposedHelpers.setIntField(
                                    effectData, "g", originalQuality);
                        } catch (Throwable ignored) {
                            // Keep the valid image even if an OEM field moved.
                        }
                    }
                    if (bitmap != null && !bitmap.isRecycled()) {
                        bitmap.recycle();
                    }
                }
            }
        });
        log("[NativeWatermark] HAL-JPEG adapter installed");
    }

    /**
     * Xiaomi's watermark parser reads the private result tag
     * com.xiaomi.sensor.info.focalLength35mm.  OPlus exposes the physical
     * focal length and logical zoom through standard Camera2 keys instead.
     * A zero focal value makes WmExifView intentionally hide the complete
     * focal/aperture/shutter/ISO row, so provide the equivalent focal length
     * only when Xiaomi's own tag is absent.
     */
    private static void hookWatermarkFocalLength(ClassLoader loader) {
        Class<?> resultParser = XposedHelpers.findClass("j9.m0", loader);
        XposedBridge.hookAllMethods(resultParser, "c", new XC_MethodHook() {
            @Override
            protected void afterHookedMethod(MethodHookParam param) {
                if (param.hasThrowable() || param.args == null
                        || param.args.length != 1
                        || !(param.args[0] instanceof CaptureResult)) {
                    return;
                }
                Object original = param.getResult();
                if (original instanceof Number
                        && ((Number) original).floatValue() > 0.0f) {
                    return;
                }
                CaptureResult result = (CaptureResult) param.args[0];
                Float physicalFocal = safeResultValue(
                        result, CaptureResult.LENS_FOCAL_LENGTH);
                Float zoom = safeResultValue(
                        result, CaptureResult.CONTROL_ZOOM_RATIO);
                if (physicalFocal == null || physicalFocal <= 0.0f) {
                    return;
                }
                float logicalZoom = zoom != null && Float.isFinite(zoom)
                        && zoom > 0.0f ? zoom : 1.0f;
                float equivalent35mm = Math.max(
                        1.0f, Math.round(23.0f * logicalZoom));
                param.setResult(equivalent35mm);
                log("[NativeWatermark] focal35 fallback physical="
                        + physicalFocal + " zoom=" + logicalZoom
                        + " equivalent=" + equivalent35mm);
            }
        });
        log("[NativeWatermark] 35mm focal fallback installed");
    }

    @SuppressWarnings("unchecked")
    private static byte[] renderFinalJpegEffects(
            byte[] original, Class<?> renderTagClass, Class<?> candySdkClass)
            throws Exception {
        BitmapFactory.Options options = new BitmapFactory.Options();
        options.inPreferredConfig = Bitmap.Config.ARGB_8888;
        options.inMutable = true;
        Bitmap bitmap = BitmapFactory.decodeByteArray(
                original, 0, original.length, options);
        if (bitmap == null) {
            throw new IllegalStateException("JPEG decode returned null");
        }

        ArrayList<Bitmap> lutBitmaps = null;
        Bitmap leicaBaseLut = null;
        int cvType = -1;
        String leicaBaseScript = null;
        String leicaDebug = "off";
        boolean mirroredFront = false;
        try {
            Object tag = XposedHelpers.newInstance(
                    renderTagClass,
                    bitmap.getWidth(), bitmap.getHeight(),
                    0, 0, 3.001f, false);
            ArrayList<String> scripts = (ArrayList<String>)
                    XposedHelpers.callMethod(tag, "getCandyParams");
            lutBitmaps = (ArrayList<Bitmap>)
                    XposedHelpers.callMethod(tag, "getLutBitmaps");

            // Vivid is the ISP/HAL baseline.  Classic enables Xiaomi's
            // separate mileicafilter offline node.  Recreate that node from
            // the exact OS4 parameter blob: scene/lux/CCT-selectable 17^3 LUT
            // plus its zoom/lux/CCT-selectable CvStyle shading parameters.
            cvType = getCurrentCvType(renderTagClass.getClassLoader());
            int cvFilterId = XposedHelpers.getIntField(
                    tag, "mCvFilterEffectId");
            if (cvType == 1) {
                LeicaRenderEffect effect = createLeicaClassicEffect(
                        renderTagClass.getClassLoader(),
                        leicaSceneForCvFilter(cvFilterId),
                        latestLeicaLux, latestLeicaCct,
                        latestLeicaZoom,
                        bitmap.getWidth(), bitmap.getHeight());
                leicaBaseLut = effect.lut;
                leicaBaseScript = effect.script;
                leicaDebug = effect.debug;
            }

            String primaryScript = scripts != null && !scripts.isEmpty()
                    && scripts.get(0) != null ? scripts.get(0) : "";
            if (leicaBaseScript != null) {
                primaryScript = primaryScript.isEmpty()
                        ? leicaBaseScript
                        : leicaBaseScript + "@" + primaryScript;
            }
            boolean hasPrimary = !primaryScript.isEmpty();
            boolean hasSharpen = false;
            boolean hasSecondary = false;
            if (scripts != null) {
                for (int index = 0; index < scripts.size(); index++) {
                    String script = scripts.get(index);
                    if (script != null && script.contains("SharpenEffect")) {
                        hasSharpen = true;
                    }
                    if (index > 0 && script != null && !script.isEmpty()) {
                        hasSecondary = true;
                    }
                }
            }
            boolean mirrorRequested = shouldMirrorFront(
                    renderTagClass.getClassLoader());

            if (!hasPrimary && !hasSecondary && !mirrorRequested) {
                log("[JpegEffects] no active effect; HAL JPEG retained bytes="
                        + original.length);
                return original;
            }

            if (hasPrimary) {
                Object sdk = XposedHelpers.newInstance(candySdkClass, 5);
                try {
                    String pipeline = "CopyInput@" + primaryScript;
                    XposedHelpers.callMethod(sdk, "i", pipeline);
                    int[] indices = (int[]) XposedHelpers.callMethod(
                            sdk, "b", pipeline);
                    ArrayList<Bitmap> pipelineLuts = new ArrayList<>();
                    if (leicaBaseLut != null) {
                        pipelineLuts.add(leicaBaseLut);
                    }
                    if (lutBitmaps != null) {
                        pipelineLuts.addAll(lutBitmaps);
                    }
                    if (!pipelineLuts.isEmpty()) {
                        if (indices == null
                                || indices.length < pipelineLuts.size()) {
                            throw new IllegalStateException(
                                    "Candy LUT slots="
                                            + (indices == null
                                            ? -1 : indices.length)
                                            + " bitmaps="
                                            + pipelineLuts.size());
                        }
                        for (int index = 0;
                                index < pipelineLuts.size(); index++) {
                            Bitmap lut = pipelineLuts.get(index);
                            if (lut == null || lut.isRecycled()) {
                                throw new IllegalStateException(
                                        "invalid LUT bitmap " + index);
                            }
                            XposedHelpers.callMethod(
                                    sdk, "f", indices[index], lut);
                        }
                    }
                    XposedHelpers.callMethod(sdk, "c", bitmap,
                            new float[]{0.0f, 0.0f,
                                    bitmap.getWidth(), bitmap.getHeight()});
                } finally {
                    XposedHelpers.callMethod(sdk, "e");
                }
            }

            if (scripts != null) {
                for (int index = 1; index < scripts.size(); index++) {
                    String script = scripts.get(index);
                    if (script == null || script.isEmpty()) {
                        continue;
                    }
                    applyBitmapCandyScript(bitmap, candySdkClass, script);
                }
            }

            // The direct HAL JPEG is unusually compressed (~1.8 MiB for
            // 12.5 MP) and bypasses Xiaomi's normal texture/detail stage.
            // Supply a restrained default only when the selected style did
            // not already request sharpening, avoiding halos and double
            // sharpening for custom styles.
            if (!hasSharpen) {
                applyBitmapCandyScript(bitmap, candySdkClass,
                        "SharpenEffect;SharpenIntensity=0.18;");
            }

            if (mirrorRequested) {
                int orientation = readExifOrientation(original);
                mirroredFront = mirrorBitmapForDisplayedOrientation(
                        bitmap, orientation);
                log("[FrontMirror] pref=true orientation=" + orientation
                        + " applied=" + mirroredFront);
            }

            ByteArrayOutputStream encoded = new ByteArrayOutputStream(
                    Math.max(original.length * 2, 4 * 1024 * 1024));
            if (!bitmap.compress(Bitmap.CompressFormat.JPEG, 100, encoded)) {
                throw new IllegalStateException("JPEG encode returned false");
            }
            byte[] replacement = transplantAppMetadata(
                    original, encoded.toByteArray());
            if (!isJpeg(replacement)) {
                throw new IllegalStateException("invalid encoded JPEG");
            }
            log("[JpegEffects] scripts=" + scripts
                    + " cvType=" + cvType
                    + " classicBase=" + (leicaBaseScript != null)
                    + " leica=" + leicaDebug
                    + " luts="
                    + ((lutBitmaps == null ? 0 : lutBitmaps.size())
                            + (leicaBaseLut == null ? 0 : 1))
                    + " mirror=" + mirroredFront
                    + " size=" + bitmap.getWidth() + "x"
                    + bitmap.getHeight());
            return replacement;
        } finally {
            if (lutBitmaps != null) {
                for (Bitmap lut : lutBitmaps) {
                    if (lut != null && !lut.isRecycled()) {
                        lut.recycle();
                    }
                }
            }
            if (leicaBaseLut != null && !leicaBaseLut.isRecycled()) {
                leicaBaseLut.recycle();
            }
            if (!bitmap.isRecycled()) {
                bitmap.recycle();
            }
        }
    }

    private static final class LeicaRenderEffect {
        final Bitmap lut;
        final String script;
        final String debug;

        LeicaRenderEffect(Bitmap lut, String script, String debug) {
            this.lut = lut;
            this.script = script;
            this.debug = debug;
        }
    }

    private static final class LeicaTriggerEntry {
        final int min;
        final int max;
        final int parameterIndex;

        LeicaTriggerEntry(int min, int max, int parameterIndex) {
            this.min = min;
            this.max = max;
            this.parameterIndex = parameterIndex;
        }
    }

    private static final class LeicaTriggerGroup {
        final int min;
        final int max;
        final LeicaTriggerEntry[] cct;

        LeicaTriggerGroup(int min, int max, LeicaTriggerEntry[] cct) {
            this.min = min;
            this.max = max;
            this.cct = cct;
        }
    }

    private static final class LeicaTriggerTable {
        final LeicaTriggerGroup[] groups;
        final int end;

        LeicaTriggerTable(LeicaTriggerGroup[] groups, int end) {
            this.groups = groups;
            this.end = end;
        }
    }

    private static final class LeicaTriggerBlend {
        final int[] indices;
        final float[] weights;

        LeicaTriggerBlend(int[] indices, float[] weights) {
            this.indices = indices;
            this.weights = weights;
        }
    }

    private static LeicaRenderEffect createLeicaClassicEffect(
            ClassLoader loader, String requestedScene, int lux, int cct,
            float zoom, int width, int height) throws Exception {
        byte[] parameters = getLeicaParamBlob(loader);
        int sceneTable = findLeicaSceneTable(parameters, requestedScene);
        String scene = requestedScene;
        if (sceneTable < 0) {
            scene = "common";
            sceneTable = findLeicaSceneTable(parameters, scene);
        }
        if (sceneTable < 0) {
            throw new IllegalStateException("Leica common scene missing");
        }

        LeicaTriggerBlend lutBlend = selectLeicaTrigger(
                readLeicaTriggerTable(parameters, sceneTable).groups,
                lux, cct);
        int dimension = le16(parameters, 18);
        int lutOffset = le16(parameters, 16);
        if (dimension != 17 || lutOffset != 4096) {
            throw new IllegalStateException("unexpected Leica LUT layout "
                    + dimension + "@" + lutOffset);
        }
        int lutSize = dimension * dimension * dimension * 3;
        byte[] blendedCube = blendLeicaBytes(parameters, lutOffset,
                lutSize, lutBlend);
        Bitmap lutBitmap = createCandyHaldLut(blendedCube, dimension);

        int lutCount = maxLeicaLutIndex(parameters) + 1;
        int shadingOffset = lutOffset + lutCount * lutSize;
        LeicaTriggerBlend shadingBlend = selectLeicaShadingTrigger(
                parameters, zoom, lux, cct);
        float[] shading = blendLeicaFloats(parameters, shadingOffset,
                8, shadingBlend);
        String script = "CubeLutEffect;cube_strength=1.0;lut_type=0;"
                + "@CvStyleEffect;Width=" + width
                + ";Height=" + height
                + ";SmoothStartValue=" + shading[0]
                + ";SmoothEndValue=" + shading[1]
                + ";SmoothCoordScale=" + shading[2]
                + ";SmoothValueScale=" + shading[3]
                + ";LightDarkPreserveK=" + shading[4]
                + ";LightDarkPreserveB=" + shading[5]
                + ";LightDarkPreserveV=" + shading[6]
                + ";LightDarkPreserveT=" + shading[7] + ";";
        String debug = scene + "/lux=" + lux + "/cct=" + cct
                + "/zoom=" + zoom
                + "/lut=" + Arrays.toString(lutBlend.indices)
                + "/w=" + Arrays.toString(lutBlend.weights)
                + "/shade=" + Arrays.toString(shadingBlend.indices);
        return new LeicaRenderEffect(lutBitmap, script, debug);
    }

    private static String leicaSceneForCvFilter(int cvFilterId) {
        switch (cvFilterId & 0xffff) {
            case 146:
                return "food";
            case 147:
                return "protrait";
            case 148:
                return "night";
            case 149:
                return "plants";
            case 150:
                return "sunrise_sunset";
            default:
                return "common";
        }
    }

    private static byte[] getLeicaParamBlob(ClassLoader loader)
            throws Exception {
        byte[] cached = leicaParamBlob;
        if (cached != null) {
            return cached;
        }
        byte[] loaded = null;
        String apkPath = moduleApkPath;
        if (apkPath != null && !apkPath.isEmpty()) {
            try (ZipFile apk = new ZipFile(apkPath)) {
                ZipEntry entry = apk.getEntry(
                        "assets/leica_filter_param.bin");
                if (entry != null) {
                    try (InputStream input = apk.getInputStream(entry)) {
                        loaded = readAllBytes(input, (int) entry.getSize());
                    }
                }
            }
        }
        if (loaded == null) {
            Object target = XposedHelpers.callStaticMethod(
                    XposedHelpers.findClass(
                            "com.xiaomi.camera.basic.Global", loader),
                    "getContext");
            if (!(target instanceof Context)) {
                throw new IllegalStateException(
                        "camera context unavailable for Leica asset");
            }
            Context module = ((Context) target).createPackageContext(
                    "local.mio.os4camerabridge",
                    Context.CONTEXT_IGNORE_SECURITY);
            try (InputStream input = module.getAssets().open(
                    "leica_filter_param.bin")) {
                loaded = readAllBytes(input, 1_685_750);
            }
        }
        if (loaded.length != 1_685_750 || le16(loaded, 0) != 6
                || le16(loaded, 16) != 4096
                || le16(loaded, 18) != 17) {
            throw new IllegalStateException(
                    "invalid Leica parameter asset bytes=" + loaded.length);
        }
        leicaParamBlob = loaded;
        log("[Leica] exact AAAOS4 parameter asset loaded bytes="
                + loaded.length);
        return loaded;
    }

    private static byte[] readAllBytes(InputStream input, int expected)
            throws Exception {
        ByteArrayOutputStream output = new ByteArrayOutputStream(
                Math.max(32 * 1024, expected));
        byte[] buffer = new byte[32 * 1024];
        int count;
        while ((count = input.read(buffer)) >= 0) {
            if (count > 0) {
                output.write(buffer, 0, count);
            }
        }
        return output.toByteArray();
    }

    private static int findLeicaSceneTable(
            byte[] data, String requestedScene) {
        int count = le16(data, 0);
        int offset = 1024;
        for (int index = 0; index < count; index++) {
            int size = le16(data, 2 + index * 2);
            if (requestedScene.equals(readLeicaAscii(data, offset, 64))) {
                return offset + 64;
            }
            offset += size;
        }
        return -1;
    }

    private static String readLeicaAscii(
            byte[] data, int offset, int size) {
        int end = offset;
        int limit = Math.min(data.length, offset + size);
        while (end < limit && data[end] != 0 && data[end] != ' ') {
            end++;
        }
        return new String(data, offset, Math.max(0, end - offset),
                StandardCharsets.US_ASCII);
    }

    private static LeicaTriggerTable readLeicaTriggerTable(
            byte[] data, int offset) {
        int count = le16(data, offset);
        int cursor = offset + 2;
        if (count <= 0 || count > 32) {
            throw new IllegalStateException(
                    "invalid Leica trigger count=" + count);
        }
        LeicaTriggerGroup[] groups = new LeicaTriggerGroup[count];
        for (int groupIndex = 0; groupIndex < count; groupIndex++) {
            int min = le16(data, cursor);
            int max = le16(data, cursor + 2);
            int cctCount = le16(data, cursor + 4);
            cursor += 6;
            if (cctCount <= 0 || cctCount > 32) {
                throw new IllegalStateException(
                        "invalid Leica CCT trigger count=" + cctCount);
            }
            LeicaTriggerEntry[] entries =
                    new LeicaTriggerEntry[cctCount];
            for (int cctIndex = 0; cctIndex < cctCount; cctIndex++) {
                entries[cctIndex] = new LeicaTriggerEntry(
                        le16(data, cursor), le16(data, cursor + 2),
                        le16(data, cursor + 4));
                cursor += 6;
            }
            groups[groupIndex] = new LeicaTriggerGroup(min, max, entries);
        }
        return new LeicaTriggerTable(groups, cursor);
    }

    private static LeicaTriggerBlend selectLeicaShadingTrigger(
            byte[] data, float zoom, int lux, int cct) {
        int sceneCount = le16(data, 0);
        int cursor = 1024;
        for (int index = 0; index < sceneCount; index++) {
            cursor += le16(data, 2 + index * 2);
        }
        LeicaTriggerTable selected = null;
        while (cursor + 6 < 4096) {
            float recordZoom = leFloat(data, cursor);
            int groupCount = le16(data, cursor + 4);
            if (!Float.isFinite(recordZoom) || recordZoom <= 0.0f
                    || recordZoom > 100.0f
                    || groupCount <= 0 || groupCount > 32) {
                break;
            }
            LeicaTriggerTable candidate = readLeicaTriggerTable(
                    data, cursor + 4);
            selected = candidate;
            cursor = candidate.end;
            // The original std::map path uses lower_bound(zoom).
            if (zoom <= recordZoom) {
                break;
            }
        }
        if (selected == null) {
            throw new IllegalStateException("Leica shading table missing");
        }
        return selectLeicaTrigger(selected.groups, lux, cct);
    }

    private static LeicaTriggerBlend selectLeicaTrigger(
            LeicaTriggerGroup[] groups, int lux, int cct) {
        int currentLux = findCurrentLeicaGroup(groups, lux);
        int previousLux = currentLux;
        if (currentLux > 0 && lux < groups[currentLux].min) {
            previousLux--;
        }
        LeicaTriggerGroup previousGroup = groups[previousLux];
        LeicaTriggerGroup currentGroup = groups[currentLux];
        int[] previousCct = findLeicaCctBounds(previousGroup.cct, cct);
        int[] currentCct = findLeicaCctBounds(currentGroup.cct, cct);

        LeicaTriggerEntry a = previousGroup.cct[previousCct[0]];
        LeicaTriggerEntry b = previousGroup.cct[previousCct[1]];
        LeicaTriggerEntry c = currentGroup.cct[currentCct[0]];
        LeicaTriggerEntry d = currentGroup.cct[currentCct[1]];
        float luxFraction = previousLux == currentLux ? 0.0f
                : leicaGapFraction(lux,
                        previousGroup.max, currentGroup.min);
        float previousCctFraction = previousCct[0] == previousCct[1]
                ? 0.0f : leicaGapFraction(cct, a.max, b.min);
        float currentCctFraction = currentCct[0] == currentCct[1]
                ? 0.0f : leicaGapFraction(cct, c.max, d.min);
        float oneMinusLux = 1.0f - luxFraction;
        return new LeicaTriggerBlend(
                new int[]{a.parameterIndex, b.parameterIndex,
                        c.parameterIndex, d.parameterIndex},
                new float[]{
                        oneMinusLux * (1.0f - previousCctFraction),
                        oneMinusLux * previousCctFraction,
                        luxFraction * (1.0f - currentCctFraction),
                        luxFraction * currentCctFraction});
    }

    private static int findCurrentLeicaGroup(
            LeicaTriggerGroup[] groups, int value) {
        for (int index = 0; index < groups.length; index++) {
            if (value <= groups[index].max) {
                return index;
            }
        }
        return groups.length - 1;
    }

    private static int[] findLeicaCctBounds(
            LeicaTriggerEntry[] entries, int value) {
        int current = entries.length - 1;
        for (int index = 0; index < entries.length; index++) {
            if (value <= entries[index].max) {
                current = index;
                break;
            }
        }
        int previous = current;
        if (current > 0 && value < entries[current].min) {
            previous--;
        }
        return new int[]{previous, current};
    }

    private static float leicaGapFraction(
            int value, int previousMax, int currentMin) {
        int distance = currentMin - previousMax;
        if (distance == 0) {
            return 0.0f;
        }
        return Math.max(0.0f, Math.min(1.0f,
                (value - previousMax) / (float) distance));
    }

    private static int maxLeicaLutIndex(byte[] data) {
        int sceneCount = le16(data, 0);
        int offset = 1024;
        int maximum = -1;
        for (int scene = 0; scene < sceneCount; scene++) {
            LeicaTriggerTable table = readLeicaTriggerTable(
                    data, offset + 64);
            for (LeicaTriggerGroup group : table.groups) {
                for (LeicaTriggerEntry entry : group.cct) {
                    maximum = Math.max(maximum, entry.parameterIndex);
                }
            }
            offset += le16(data, 2 + scene * 2);
        }
        return maximum;
    }

    private static byte[] blendLeicaBytes(
            byte[] data, int poolOffset, int parameterSize,
            LeicaTriggerBlend blend) {
        byte[] output = new byte[parameterSize];
        for (int offset = 0; offset < parameterSize; offset++) {
            float value = 0.0f;
            for (int index = 0; index < 4; index++) {
                value += (data[poolOffset
                        + blend.indices[index] * parameterSize
                        + offset] & 0xff) * blend.weights[index];
            }
            output[offset] = (byte) Math.max(0, Math.min(255,
                    Math.round(value)));
        }
        return output;
    }

    private static float[] blendLeicaFloats(
            byte[] data, int poolOffset, int valuesPerParameter,
            LeicaTriggerBlend blend) {
        float[] output = new float[valuesPerParameter];
        int parameterSize = valuesPerParameter * 4;
        for (int valueIndex = 0;
                valueIndex < valuesPerParameter; valueIndex++) {
            for (int index = 0; index < 4; index++) {
                output[valueIndex] += leFloat(data,
                        poolOffset + blend.indices[index] * parameterSize
                                + valueIndex * 4)
                        * blend.weights[index];
            }
        }
        return output;
    }

    private static Bitmap createCandyHaldLut(
            byte[] cube, int dimension) {
        final int expanded = 64;
        final int haldSize = 512;
        int[] pixels = new int[haldSize * haldSize];
        for (int blue = 0; blue < expanded; blue++) {
            int blueScaled = blue * (dimension - 1);
            int blueLow = blueScaled / (expanded - 1);
            int blueHigh = Math.min(dimension - 1, blueLow + 1);
            float blueFraction = (blueScaled % (expanded - 1))
                    / (float) (expanded - 1);
            int tileX = blue % 8;
            int tileY = blue / 8;
            for (int green = 0; green < expanded; green++) {
                int greenScaled = green * (dimension - 1);
                int greenLow = greenScaled / (expanded - 1);
                int greenHigh = Math.min(dimension - 1, greenLow + 1);
                float greenFraction = (greenScaled % (expanded - 1))
                        / (float) (expanded - 1);
                int y = tileY * expanded + green;
                for (int red = 0; red < expanded; red++) {
                    int redScaled = red * (dimension - 1);
                    int redLow = redScaled / (expanded - 1);
                    int redHigh = Math.min(dimension - 1, redLow + 1);
                    float redFraction = (redScaled % (expanded - 1))
                            / (float) (expanded - 1);
                    int outRed = sampleLeicaCube(cube, dimension,
                            blueLow, blueHigh, blueFraction,
                            greenLow, greenHigh, greenFraction,
                            redLow, redHigh, redFraction, 0);
                    int outGreen = sampleLeicaCube(cube, dimension,
                            blueLow, blueHigh, blueFraction,
                            greenLow, greenHigh, greenFraction,
                            redLow, redHigh, redFraction, 1);
                    int outBlue = sampleLeicaCube(cube, dimension,
                            blueLow, blueHigh, blueFraction,
                            greenLow, greenHigh, greenFraction,
                            redLow, redHigh, redFraction, 2);
                    int x = tileX * expanded + red;
                    pixels[y * haldSize + x] = 0xff000000
                            | (outRed << 16) | (outGreen << 8) | outBlue;
                }
            }
        }
        Bitmap bitmap = Bitmap.createBitmap(
                haldSize, haldSize, Bitmap.Config.ARGB_8888);
        bitmap.setPixels(pixels, 0, haldSize,
                0, 0, haldSize, haldSize);
        return bitmap;
    }

    private static int sampleLeicaCube(
            byte[] cube, int dimension,
            int blueLow, int blueHigh, float blueFraction,
            int greenLow, int greenHigh, float greenFraction,
            int redLow, int redHigh, float redFraction,
            int channel) {
        float c000 = leicaCubeValue(cube, dimension,
                blueLow, greenLow, redLow, channel);
        float c001 = leicaCubeValue(cube, dimension,
                blueLow, greenLow, redHigh, channel);
        float c010 = leicaCubeValue(cube, dimension,
                blueLow, greenHigh, redLow, channel);
        float c011 = leicaCubeValue(cube, dimension,
                blueLow, greenHigh, redHigh, channel);
        float c100 = leicaCubeValue(cube, dimension,
                blueHigh, greenLow, redLow, channel);
        float c101 = leicaCubeValue(cube, dimension,
                blueHigh, greenLow, redHigh, channel);
        float c110 = leicaCubeValue(cube, dimension,
                blueHigh, greenHigh, redLow, channel);
        float c111 = leicaCubeValue(cube, dimension,
                blueHigh, greenHigh, redHigh, channel);
        float c00 = c000 + (c001 - c000) * redFraction;
        float c01 = c010 + (c011 - c010) * redFraction;
        float c10 = c100 + (c101 - c100) * redFraction;
        float c11 = c110 + (c111 - c110) * redFraction;
        float c0 = c00 + (c01 - c00) * greenFraction;
        float c1 = c10 + (c11 - c10) * greenFraction;
        return Math.max(0, Math.min(255,
                Math.round(c0 + (c1 - c0) * blueFraction)));
    }

    private static int leicaCubeValue(
            byte[] cube, int dimension,
            int blue, int green, int red, int channel) {
        return cube[(((blue * dimension) + green) * dimension + red)
                * 3 + channel] & 0xff;
    }

    private static int le16(byte[] data, int offset) {
        if (offset < 0 || offset + 2 > data.length) {
            throw new IllegalArgumentException(
                    "Leica u16 outside asset at " + offset);
        }
        return (data[offset] & 0xff)
                | ((data[offset + 1] & 0xff) << 8);
    }

    private static float leFloat(byte[] data, int offset) {
        int bits = le16(data, offset)
                | (le16(data, offset + 2) << 16);
        return Float.intBitsToFloat(bits);
    }

    private static void applyBitmapCandyScript(
            Bitmap bitmap, Class<?> candySdkClass, String script) {
        Object sdk = XposedHelpers.newInstance(candySdkClass, 5);
        try {
            XposedHelpers.callMethod(sdk, "a", script);
            XposedHelpers.callMethod(sdk, "c", bitmap,
                    new float[]{0.0f, 0.0f,
                            bitmap.getWidth(), bitmap.getHeight()});
        } finally {
            XposedHelpers.callMethod(sdk, "e");
        }
    }

    private static int getCurrentCvType(ClassLoader loader) {
        try {
            Object value = XposedHelpers.callStaticMethod(
                    XposedHelpers.findClass(
                            "com.android.camera.data.data.i", loader),
                    "o");
            return value instanceof Number
                    ? ((Number) value).intValue() : -1;
        } catch (Throwable throwable) {
            log("[Leica] cannot read cv type: " + throwable);
            return -1;
        }
    }

    private static boolean shouldMirrorFront(ClassLoader loader) {
        if (activeCameraId != 1 || activeBeautyModule != 163) {
            return false;
        }
        try {
            Object value = XposedHelpers.callStaticMethod(
                    XposedHelpers.findClass(
                            "com.android.camera.data.data.v", loader),
                    "R");
            return Boolean.TRUE.equals(value);
        } catch (Throwable throwable) {
            log("[FrontMirror] cannot read setting: " + throwable);
            return false;
        }
    }

    /**
     * Mirror in displayed coordinates without allocating a second 12.5 MP
     * bitmap.  JPEG orientations 6/8 rotate the stored pixels by 90 degrees,
     * so their displayed horizontal mirror is a stored vertical mirror.
     */
    private static boolean mirrorBitmapForDisplayedOrientation(
            Bitmap bitmap, int orientation) {
        if (orientation == 2 || orientation == 4
                || orientation == 5 || orientation == 7) {
            // The EXIF transform already contains a mirror operation.
            return false;
        }
        int width = bitmap.getWidth();
        int height = bitmap.getHeight();
        if (orientation == 6 || orientation == 8) {
            int[] top = new int[width];
            int[] bottom = new int[width];
            for (int y = 0; y < height / 2; y++) {
                int opposite = height - 1 - y;
                bitmap.getPixels(top, 0, width, 0, y, width, 1);
                bitmap.getPixels(bottom, 0, width, 0, opposite, width, 1);
                bitmap.setPixels(bottom, 0, width, 0, y, width, 1);
                bitmap.setPixels(top, 0, width, 0, opposite, width, 1);
            }
            return true;
        }
        int[] row = new int[width];
        for (int y = 0; y < height; y++) {
            bitmap.getPixels(row, 0, width, 0, y, width, 1);
            for (int left = 0, right = width - 1;
                    left < right; left++, right--) {
                int pixel = row[left];
                row[left] = row[right];
                row[right] = pixel;
            }
            bitmap.setPixels(row, 0, width, 0, y, width, 1);
        }
        return true;
    }

    private static int readExifOrientation(byte[] jpeg) {
        if (!isJpeg(jpeg)) {
            return 1;
        }
        int offset = 2;
        while (offset + 4 <= jpeg.length) {
            if ((jpeg[offset] & 0xff) != 0xff) {
                break;
            }
            int marker = jpeg[offset + 1] & 0xff;
            if (marker == 0xda || marker == 0xd9) {
                break;
            }
            int length = readUnsignedShort(jpeg, offset + 2, false);
            if (length < 2 || offset + 2 + length > jpeg.length) {
                break;
            }
            int payload = offset + 4;
            if (marker == 0xe1 && length >= 16
                    && payload + 6 <= jpeg.length
                    && jpeg[payload] == 'E' && jpeg[payload + 1] == 'x'
                    && jpeg[payload + 2] == 'i' && jpeg[payload + 3] == 'f'
                    && jpeg[payload + 4] == 0 && jpeg[payload + 5] == 0) {
                int tiff = payload + 6;
                boolean little;
                if (jpeg[tiff] == 'I' && jpeg[tiff + 1] == 'I') {
                    little = true;
                } else if (jpeg[tiff] == 'M' && jpeg[tiff + 1] == 'M') {
                    little = false;
                } else {
                    return 1;
                }
                if (readUnsignedShort(jpeg, tiff + 2, little) != 42) {
                    return 1;
                }
                long relativeIfd = readUnsignedInt(jpeg, tiff + 4, little);
                long ifdLong = tiff + relativeIfd;
                if (ifdLong < 0 || ifdLong + 2 > jpeg.length) {
                    return 1;
                }
                int ifd = (int) ifdLong;
                int count = readUnsignedShort(jpeg, ifd, little);
                for (int index = 0; index < count; index++) {
                    int entry = ifd + 2 + index * 12;
                    if (entry < 0 || entry + 12 > jpeg.length) {
                        return 1;
                    }
                    if (readUnsignedShort(jpeg, entry, little) == 0x0112) {
                        int value = readUnsignedShort(
                                jpeg, entry + 8, little);
                        return value >= 1 && value <= 8 ? value : 1;
                    }
                }
                return 1;
            }
            offset += 2 + length;
        }
        return 1;
    }

    private static int readUnsignedShort(
            byte[] data, int offset, boolean littleEndian) {
        if (offset < 0 || offset + 2 > data.length) {
            return 0;
        }
        int first = data[offset] & 0xff;
        int second = data[offset + 1] & 0xff;
        return littleEndian
                ? first | (second << 8)
                : (first << 8) | second;
    }

    private static long readUnsignedInt(
            byte[] data, int offset, boolean littleEndian) {
        if (offset < 0 || offset + 4 > data.length) {
            return -1L;
        }
        long first = data[offset] & 0xffL;
        long second = data[offset + 1] & 0xffL;
        long third = data[offset + 2] & 0xffL;
        long fourth = data[offset + 3] & 0xffL;
        return littleEndian
                ? first | (second << 8) | (third << 16) | (fourth << 24)
                : (first << 24) | (second << 16) | (third << 8) | fourth;
    }

    private static void failFusion(String reason) {
        synchronized (FUSION_LOCK) {
            if (!fusionCapturePending) {
                return;
            }
            fusionFailure = reason;
            FUSION_LOCK.notifyAll();
        }
    }

    private static boolean awaitFusionSlot() {
        long deadline = System.currentTimeMillis() + 12_000L;
        synchronized (FUSION_LOCK) {
            if (fusionCapturePending) {
                log("[YuvFusion] waiting for previous capture to finish");
            }
            while (fusionCapturePending) {
                long remaining = deadline - System.currentTimeMillis();
                if (remaining <= 0) {
                    fusionCapturePending = false;
                    pendingFusedJpeg = null;
                    fusionFailure = "stale overlapping capture cleared";
                    FUSION_FRAMES.clear();
                    FUSION_LOCK.notifyAll();
                    return false;
                }
                try {
                    FUSION_LOCK.wait(remaining);
                } catch (InterruptedException exception) {
                    Thread.currentThread().interrupt();
                    return false;
                }
            }
            return true;
        }
    }

    private static String sha256(byte[] data) throws Exception {
        MessageDigest digest = MessageDigest.getInstance("SHA-256");
        digest.update(data);
        StringBuilder hex = new StringBuilder(64);
        for (byte value : digest.digest()) {
            hex.append(String.format("%02x", value & 0xff));
        }
        return hex.toString();
    }

    private static boolean isJpeg(byte[] data) {
        return data != null && data.length >= 4
                && (data[0] & 0xff) == 0xff
                && (data[1] & 0xff) == 0xd8
                && (data[data.length - 2] & 0xff) == 0xff
                && (data[data.length - 1] & 0xff) == 0xd9;
    }

    private static byte[] transplantAppMetadata(
            byte[] original, byte[] encoded) {
        ByteArrayOutputStream segments = new ByteArrayOutputStream(4096);
        int position = 2;
        while (position + 4 <= original.length
                && (original[position] & 0xff) == 0xff) {
            int marker = original[position + 1] & 0xff;
            if (marker == 0xda || marker == 0xd9) {
                break;
            }
            if ((marker >= 0xd0 && marker <= 0xd7) || marker == 0x01) {
                position += 2;
                continue;
            }
            int length = ((original[position + 2] & 0xff) << 8)
                    | (original[position + 3] & 0xff);
            int total = length + 2;
            if (length < 2 || position + total > original.length) {
                break;
            }
            if (marker == 0xe1 || marker == 0xe2 || marker == 0xed) {
                segments.write(original, position, total);
            }
            position += total;
        }
        byte[] app = segments.toByteArray();
        ByteArrayOutputStream output = new ByteArrayOutputStream(
                encoded.length + app.length);
        output.write(encoded, 0, 2);
        output.write(app, 0, app.length);
        output.write(encoded, 2, encoded.length - 2);
        return output.toByteArray();
    }

    private static String writeAndHash(File output, ByteBuffer buffer)
            throws Exception {
        MessageDigest digest = MessageDigest.getInstance("SHA-256");
        byte[] chunk = new byte[64 * 1024];
        try (FileOutputStream stream = new FileOutputStream(output)) {
            while (buffer.hasRemaining()) {
                int count = Math.min(buffer.remaining(), chunk.length);
                buffer.get(chunk, 0, count);
                stream.write(chunk, 0, count);
                digest.update(chunk, 0, count);
            }
            stream.getFD().sync();
        }
        StringBuilder hex = new StringBuilder(64);
        for (byte value : digest.digest()) {
            hex.append(String.format("%02x", value & 0xff));
        }
        return hex.toString();
    }

    @SuppressWarnings("unchecked")
    private static boolean appendOutputSurface(List<?> outputs, Surface surface) {
        for (Object item : outputs) {
            if (item instanceof OutputConfiguration
                    && ((OutputConfiguration) item).getSurface() == surface) {
                return false;
            }
        }
        ((List<OutputConfiguration>) outputs).add(
                new OutputConfiguration(surface));
        return true;
    }

    private static boolean captureTargetsSurface(
            CaptureRequest request, Surface target) {
        try {
            Object targets = XposedHelpers.callMethod(request, "getTargets");
            if (targets instanceof Iterable) {
                for (Object surface : (Iterable<?>) targets) {
                    if (surface == target || target.equals(surface)) {
                        return true;
                    }
                }
            }
        } catch (Throwable throwable) {
            log("[YuvBurst] target inspection failed: " + throwable);
        }
        return false;
    }

    @SuppressWarnings({"rawtypes", "unchecked"})
    private static ArrayList<CaptureRequest> buildYuvRequestSet(
            Object captureSession, CaptureRequest original, int frameCount) {
        try {
            Object deviceImpl = XposedHelpers.getObjectField(
                    captureSession, "mDeviceImpl");
            CaptureRequest.Builder builder = (CaptureRequest.Builder)
                    XposedHelpers.callMethod(deviceImpl,
                            "createCaptureRequest",
                            android.hardware.camera2.CameraDevice
                                    .TEMPLATE_STILL_CAPTURE);
            for (CaptureRequest.Key key : original.getKeys()) {
                try {
                    Object value = original.get(key);
                    if (value != null) {
                        builder.set(key, value);
                    }
                } catch (Throwable ignored) {
                    // Synthetic/session-only keys are not writable here.
                }
            }
            builder.setTag(original.getTag());
            builder.addTarget(fullYuvReader.getSurface());
            ArrayList<CaptureRequest> requests = new ArrayList<>(frameCount);
            requests.add(original);
            for (int i = 1; i < frameCount; i++) {
                requests.add(builder.build());
            }
            return requests;
        } catch (Throwable throwable) {
            log("[YuvBurst] request cloning failed: " + throwable);
            return null;
        }
    }

    private static CameraCaptureSession.CaptureCallback wrapYuvBurstCallback(
            CameraCaptureSession.CaptureCallback original,
            CaptureRequest baseRequest,
            List<CaptureRequest> requests) {
        Map<CaptureRequest, Integer> indexes =
                new IdentityHashMap<>();
        for (int i = 0; i < requests.size(); i++) {
            indexes.put(requests.get(i), i + 1);
        }
        return new CameraCaptureSession.CaptureCallback() {
            private boolean isBase(CaptureRequest request) {
                return request == baseRequest || baseRequest.equals(request);
            }

            private int index(CaptureRequest request) {
                Integer value = indexes.get(request);
                return value == null ? -1 : value;
            }

            @Override
            public void onCaptureStarted(CameraCaptureSession session,
                    CaptureRequest request, long timestamp,
                    long frameNumber) {
                log("[YuvBurst] started index=" + index(request)
                        + " sensorTs=" + timestamp
                        + " frame=" + frameNumber);
                if (original != null && isBase(request)) {
                    original.onCaptureStarted(session, request,
                            timestamp, frameNumber);
                }
            }

            @Override
            public void onCaptureProgressed(CameraCaptureSession session,
                    CaptureRequest request, CaptureResult partialResult) {
                if (original != null && isBase(request)) {
                    original.onCaptureProgressed(session, request,
                            partialResult);
                }
            }

            @Override
            public void onCaptureCompleted(CameraCaptureSession session,
                    CaptureRequest request, TotalCaptureResult result) {
                log("[YuvBurst] completed index=" + index(request)
                        + " frame=" + result.getFrameNumber()
                        + " sensorTs=" + readResult(result,
                        CaptureResult.SENSOR_TIMESTAMP)
                        + " active=" + readResult(result,
                        CaptureResult.LOGICAL_MULTI_CAMERA_ACTIVE_PHYSICAL_ID)
                        + " zoom=" + readResult(result,
                        CaptureResult.CONTROL_ZOOM_RATIO)
                        + " iso=" + readResult(result,
                        CaptureResult.SENSOR_SENSITIVITY)
                        + " exposureNs=" + readResult(result,
                        CaptureResult.SENSOR_EXPOSURE_TIME));
                if (original != null && isBase(request)) {
                    original.onCaptureCompleted(session, request, result);
                }
            }

            @Override
            public void onCaptureFailed(CameraCaptureSession session,
                    CaptureRequest request, CaptureFailure failure) {
                log("[YuvBurst] failed index=" + index(request)
                        + " frame=" + failure.getFrameNumber()
                        + " reason=" + failure.getReason());
                if (original != null && isBase(request)) {
                    original.onCaptureFailed(session, request, failure);
                }
            }

            @Override
            public void onCaptureSequenceCompleted(
                    CameraCaptureSession session, int sequenceId,
                    long frameNumber) {
                log("[YuvBurst] sequence completed id=" + sequenceId
                        + " lastFrame=" + frameNumber);
                if (original != null) {
                    original.onCaptureSequenceCompleted(
                            session, sequenceId, frameNumber);
                }
            }

            @Override
            public void onCaptureSequenceAborted(
                    CameraCaptureSession session, int sequenceId) {
                log("[YuvBurst] sequence aborted id=" + sequenceId);
                if (original != null) {
                    original.onCaptureSequenceAborted(session, sequenceId);
                }
            }

            @Override
            public void onCaptureBufferLost(CameraCaptureSession session,
                    CaptureRequest request, Surface target,
                    long frameNumber) {
                log("[YuvBurst] buffer lost index=" + index(request)
                        + " frame=" + frameNumber + " target=" + target);
                if (original != null && isBase(request)) {
                    original.onCaptureBufferLost(
                            session, request, target, frameNumber);
                }
            }
        };
    }

    private static void hookLegacyJpeg(ClassLoader loader) {
        Class<?> deviceConfig = XposedHelpers.findClass("Je.b", loader);
        XposedBridge.hookAllMethods(deviceConfig, "b1", new XC_MethodReplacement() {
            @Override
            protected Object replaceHookedMethod(MethodHookParam param) {
                if (!loggedMivi) {
                    loggedMivi = true;
                    log("[CaptureRoute] Je.b.b1 MIVI2 -> false");
                }
                return false;
            }
        });

        Class<?> module = XposedHelpers.findClass("com.android.camera.module.Camera2Module", loader);
        XposedBridge.hookAllMethods(module, "isParallelSessionEnable", new XC_MethodHook() {
            @Override
            protected void afterHookedMethod(MethodHookParam param) {
                boolean original = Boolean.TRUE.equals(param.getResult());
                param.setResult(false);
                if (!loggedParallel) {
                    loggedParallel = true;
                    log("[CaptureRoute] parallel=" + original + " -> false; full JPEG ImageReader requested");
                }
            }
        });

        Class<?> miCamera2 = XposedHelpers.findClass("j9.y0", loader);
        XposedBridge.hookAllMethods(miCamera2, "U1", new XC_MethodHook() {
            @Override
            protected void beforeHookedMethod(MethodHookParam param) {
                try {
                    Object state = XposedHelpers.getObjectField(param.thisObject, "F");
                    Object settings = XposedHelpers.getObjectField(state, "a");
                    int algoType = XposedHelpers.getIntField(settings, "a1");
                    if (algoType == 16) {
                        XposedHelpers.setIntField(settings, "a1", 0);
                        log("[CaptureRoute] algoType 16(MIVIStill) -> 0(MiCamera2ShotStill)");
                    }
                } catch (Throwable throwable) {
                    log("[CaptureRoute] algo remap failed: " + throwable);
                }
            }
        });
        log("[CaptureRoute] OS4 legacy JPEG hooks active");
    }

    /**
     * ProModule overrides Camera2Module's parallel-session decision.  On the
     * port that override starts Xiaomi's unavailable MiPostProc graph and the
     * app kills itself after the session fails.  Disable only the ProModule
     * override so professional JPEG/RAW use its retained direct Camera2
     * readers and manual controls.
     */
    private static void hookProPhotoParallelCompat(ClassLoader loader) {
        Class<?> proModule = XposedHelpers.findClass(
                "com.android.camera.features.mode.pro.photo.ProModule",
                loader);
        XposedBridge.hookAllMethods(proModule,
                "isParallelSessionEnable",
                XC_MethodReplacement.returnConstant(false));
        log("[ProCompat] module 167 Xiaomi MiPostProc parallel graph disabled;"
                + " direct Camera2 JPEG/RAW session retained");
    }

    /**
     * OS4 reduces the standard Camera2/CamcorderProfile list through a
     * Xiaomi-only vendor table.  That table is absent on the OnePlus camera
     * provider, so valid 1080p60 and 4K60 rows disappear from the selector.
     * Restore only those two combinations; all other quality decisions stay
     * stock.
     *
     * The same port also reports Xiaomi's compressed AudioRecord input as
     * available.  The OnePlus audio HAL accepts 48 kHz stereo CAMCORDER PCM,
     * but not ENCODING_AAC_LC as an AudioRecord input.  Force the recorder's
     * existing PCM + MediaCodec AAC path instead of muting video or changing
     * its microphone/source configuration.
     */
    private static void hookVideoCompat(ClassLoader loader) {
        Class<?> quality = XposedHelpers.findClass("r2.f0", loader);
        XposedBridge.hookAllMethods(quality, "E", new XC_MethodHook() {
            @Override
            protected void afterHookedMethod(MethodHookParam param) {
                if (param.args == null || param.args.length != 3
                        || !(param.args[0] instanceof Integer)
                        || !(param.args[1] instanceof Integer)) {
                    return;
                }
                int width = (Integer) param.args[0];
                int height = (Integer) param.args[1];
                if ((width == 1920 && height == 1080)
                        || (width == 3840 && height == 2160)) {
                    boolean original = Boolean.TRUE.equals(param.getResult());
                    param.setResult(true);
                    if (!loggedVideoFpsCompat) {
                        loggedVideoFpsCompat = true;
                        log("[VideoCompat] restored OnePlus HAL 60fps rows;"
                                + " first=" + width + "x" + height
                                + " original=" + original);
                    }
                }
            }
        });

        Class<?> capabilityUtils = XposedHelpers.findClass("j9.f", loader);
        XposedBridge.hookAllMethods(capabilityUtils, "P0",
                new XC_MethodHook() {
                    @Override
                    protected void afterHookedMethod(MethodHookParam param) {
                        if (param.args == null || param.args.length != 2
                                || !Integer.valueOf(6).equals(param.args[0])) {
                            return;
                        }
                        boolean original = Boolean.TRUE.equals(
                                param.getResult());
                        param.setResult(true);
                        if (!loggedVideoEis60Compat) {
                            loggedVideoEis60Compat = true;
                            log("[VideoCompat] restored 1080p60 EIS"
                                    + " capability; original=" + original);
                        }
                    }
                });

        Class<?> codecRecorder = XposedHelpers.findClass("Sp.i", loader);
        XposedBridge.hookAllMethods(codecRecorder, "l",
                new XC_MethodReplacement() {
                    @Override
                    protected Object replaceHookedMethod(MethodHookParam param) {
                        if (!loggedVideoAudioCompat) {
                            loggedVideoAudioCompat = true;
                            log("[VideoAudioCompat] disabled unsupported"
                                    + " direct AAC AudioRecord input;"
                                    + " using PCM + MediaCodec AAC");
                        }
                        return false;
                    }
                });
        log("[VideoCompat] OS4 1080p/4K 60fps and PCM audio bridge installed");
    }

    /**
     * HyperOS' Camera2 extension exempts camera packages listed in
     * persist.vendor.camera.privapp.list from the AOSP constrained-HFR
     * Surface restrictions. The ported camera runs as platform_app_36 and
     * SELinux denies it access to that vendor property, so the framework sees
     * an empty list and rejects the vendor-supported YUV/encoder graph.
     *
     * Intercept the exact framework decision instead of rewriting the vendor
     * property or injecting a MediaCodec Surface. The latter produced a
     * stale/EOS input Surface and never delivered video frames. Keep this
     * allow-list deliberately limited to the two real OEM camera packages so
     * no other client gains the relaxed high-speed path.
     */
    private static void hookCamera2PrivilegedApps() {
        Class<?> cameraExtStub = XposedHelpers.findClass(
                "android.hardware.camera2.impl.CameraExtStub", null);
        XposedBridge.hookAllMethods(cameraExtStub, "isPrivilegedApp",
                new XC_MethodHook() {
                    @Override
                    protected void beforeHookedMethod(MethodHookParam param) {
                        if (param.args == null || param.args.length != 1
                                || !(param.args[0] instanceof String)) {
                            return;
                        }
                        String packageName = (String) param.args[0];
                        if (TARGET.equals(packageName)) {
                            param.setResult(true);
                            if (!loggedXiaomiCameraPrivilege) {
                                loggedXiaomiCameraPrivilege = true;
                                log("[SlowMotionCompat] Camera2 privileged app: "
                                        + packageName);
                            }
                        } else if (OPLUS_CAMERA.equals(packageName)) {
                            param.setResult(true);
                            if (!loggedOplusCameraPrivilege) {
                                loggedOplusCameraPrivilege = true;
                                log("[SlowMotionCompat] Camera2 privileged app: "
                                        + packageName);
                            }
                        }
                    }
                });
        log("[SlowMotionCompat] scoped CameraExtStub bridge installed for "
                + TARGET + " and " + OPLUS_CAMERA);
    }

    /**
     * The OnePlus 13 HAL can create Xiaomi's constrained-HFR session but the
     * port does not deliver a usable encoded video track. Do not expose a
     * mode which can only end with "recording too short". Returning false at
     * the module-entry support boundary removes the item from both the main
     * selector and More page while leaving ordinary 60 fps video untouched.
     */
    private static void hookDisableSlowMotion(ClassLoader loader) {
        Class<?> entry = XposedHelpers.findClass(
                "com.android.camera.features.mode.slow.SlowMotionModuleEntry",
                loader);
        XposedBridge.hookAllMethods(entry, "support",
                XC_MethodReplacement.returnConstant(false));
        log("[SlowMotionCompat] unsupported module 172 hidden");
    }

    private static void hookAfSaliency(ClassLoader loader)
            throws ReflectiveOperationException {
        Method saliency = CameraModuleContract.resolveAfSaliency(loader);
        XposedBridge.hookMethod(
                saliency,
                XC_MethodReplacement.returnConstant(false));
        log("[FocusCompat] Xiaomi AF saliency disabled on "
                + saliency.getDeclaringClass().getName());
    }

    /**
     * Xiaomi calculates the correct UI ratio, but on this port its capability
     * path writes only SCALER_CROP_REGION and leaves CONTROL_ZOOM_RATIO at 1.
     * Camera 0 is the OnePlus logical rear camera and advertises the standard
     * [0.6, 20] range, so restore that ratio at the common request boundary and
     * leave physical-lens selection to the OPlus HAL-SAT implementation.
     */
    private static void hookOplusLogicalZoom(ClassLoader loader) {
        Class<?> requestBuilder = XposedHelpers.findClass("j9.k0", loader);
        Class<?> capabilityUtils = XposedHelpers.findClass("j9.f", loader);
        XposedBridge.hookAllMethods(requestBuilder, "k1", new XC_MethodHook() {
            @Override
            protected void afterHookedMethod(MethodHookParam param) {
                if (param.args == null || param.args.length < 3
                        || !(param.args[0] instanceof CaptureRequest.Builder)
                        || param.args[1] == null || param.args[2] == null) {
                    return;
                }
                try {
                    Object cameraIdValue = XposedHelpers.callStaticMethod(
                            capabilityUtils, "k", param.args[1]);
                    if (!(cameraIdValue instanceof Integer)) {
                        return;
                    }
                    int requestCameraId = (Integer) cameraIdValue;
                    float uiRatio = XposedHelpers.getFloatField(param.args[2], "c0");
                    float ratio = Math.max(0.6f, Math.min(20.0f, uiRatio));
                    CaptureRequest.Builder builder =
                            (CaptureRequest.Builder) param.args[0];
                    if (activeCameraModule == 162
                            || activeCameraModule == 163
                            || activeCameraModule == 167
                            || activeCameraModule == 256) {
                        applyPhysicalRoleZoom(builder, requestCameraId,
                                ratio, activeCameraModule);
                        return;
                    }
                    if (requestCameraId != 0) {
                        return;
                    }
                    Object oldCrop = builder.get(CaptureRequest.SCALER_CROP_REGION);
                    Rect fullActiveArray = fullRearActiveArray();
                    builder.set(CaptureRequest.CONTROL_ZOOM_RATIO, ratio);
                    // ColorOS writes CONTROL_ZOOM_RATIO directly and keeps a
                    // full active-array crop.  Clearing this to null let the
                    // foreign Xiaomi crop coordinates survive in another
                    // request path; at 0.7x CameraUnit expanded them to
                    // 16384x12288 and crashed the provider.
                    builder.set(CaptureRequest.SCALER_CROP_REGION,
                            fullActiveArray);
                    if (ratio >= 3.0f) {
                        applyLogicalOplusTeleRoute(builder, ratio);
                    } else {
                        clearLogicalOplusTeleRoute(builder);
                    }
                    if (Float.isNaN(lastLoggedZoomRatio)
                            || Math.abs(lastLoggedZoomRatio - ratio) >= 0.01f) {
                        lastLoggedZoomRatio = ratio;
                        log("[LogicalZoom] camera=0 ui=" + uiRatio
                                + " request=" + ratio
                                + " crop=" + fullActiveArray
                                + " replacedCrop=" + oldCrop);
                    }
                } catch (Throwable throwable) {
                    log("[LogicalZoom] request unchanged: " + throwable);
                }
            }
        });
        log("[LogicalZoom] OS4 j9.k0.k1 hook active");
    }

    /**
     * CONTROL_ZOOM_RATIO alone selects the OnePlus ultra-wide, but camera 0
     * deliberately keeps the main sensor at exactly 3x unless the ColorOS SAT
     * ownership metadata accompanies the repeating request.  These values are
     * the exact rear-tele contract captured from this OnePlus 13; applying the
     * route at Xiaomi's common request boundary also keeps preview and still
     * capture on the same physical lens.
     */
    private static void applyLogicalOplusTeleRoute(
            CaptureRequest.Builder builder, float ratio) {
        if (ratio < 3.0f) {
            return;
        }
        builder.set(CaptureRequest.CONTROL_ENABLE_ZSL, false);
        // ColorOS keeps CONTROL_ZOOM_RATIO in logical-camera coordinates,
        // while this private value is relative to the selected 3x physical
        // tele camera.  Its exact stock 3x request therefore carries 1.0.
        // Writing the logical 3.0 here selected physical 4 briefly, then the
        // private SAT decision interpreted it as an extra 3x crop and fell
        // back to main 2 about 200 ms later.
        builder.set(OPLUS_ORIGINAL_ZOOM,
                new float[]{Math.max(1.0f, ratio / 3.0f)});
        builder.set(OPLUS_ZOOM_TARGET, new float[]{0.0f});
        builder.set(OPLUS_POINT_ZOOM, new int[]{0});
        builder.set(COMMON_APS_AUTO_HDR, new int[]{1});
        builder.set(COMMON_APS_ZOOM_FEATURE, new int[]{0});
        builder.set(COMMON_APS_SAT_MASTER_CAMERA, new int[]{2});
        builder.set(COMMON_APS_SENSOR_MODE, new int[]{0});
        builder.set(COMMON_APS_SENSOR_MODE_LIST,
                new int[]{3, -1, 2, 0, -1, -1, -1, -1});
        builder.set(COMMON_APS_FEATURE, new int[]{48});
        builder.set(COMMON_APS_AIS_STATE, new int[]{0});
        builder.set(COMMON_APS_SUPERNIGHT, new int[]{0});
        builder.set(COMMON_APS_REQUEST_NUM, new int[]{0});
        builder.set(COMMON_APS_REQUEST_NUM_LIST, new int[]{0, 0});
        builder.set(COMMON_APS_MOVING_OBJECT, new int[]{0});
        builder.set(COMMON_APS_IPE_SEQUENCE, new int[]{1});
        builder.set(COMMON_APS_BRACKET_MODE, new int[]{28});
    }

    private static void clearLogicalOplusTeleRoute(
            CaptureRequest.Builder builder) {
        builder.set(OPLUS_ORIGINAL_ZOOM, null);
        builder.set(OPLUS_ZOOM_TARGET, null);
        builder.set(OPLUS_POINT_ZOOM, null);
        builder.set(COMMON_APS_AUTO_HDR, null);
        builder.set(COMMON_APS_ZOOM_FEATURE, null);
        builder.set(COMMON_APS_SAT_MASTER_CAMERA, null);
        builder.set(COMMON_APS_SENSOR_MODE, null);
        builder.set(COMMON_APS_SENSOR_MODE_LIST, null);
        builder.set(COMMON_APS_FEATURE, null);
        builder.set(COMMON_APS_AIS_STATE, null);
        builder.set(COMMON_APS_SUPERNIGHT, null);
        builder.set(COMMON_APS_REQUEST_NUM, null);
        builder.set(COMMON_APS_REQUEST_NUM_LIST, null);
        builder.set(COMMON_APS_MOVING_OBJECT, null);
        builder.set(COMMON_APS_IPE_SEQUENCE, null);
        builder.set(COMMON_APS_BRACKET_MODE, null);
    }

    /**
     * Xiaomi video and Pro use physical-role sessions.  They must not be
     * driven as ColorOS logical SAT: the stream graph and request ABI differ.
     * Keep CONTROL_ZOOM_RATIO neutral and express only the digital portion as
     * a crop on the physical lens that Xiaomi selected.
     */
    private static void applyPhysicalRoleZoom(
            CaptureRequest.Builder builder, int cameraId, float uiRatio,
            int moduleIndex) {
        float opticalUiBaseline;
        if (cameraId == rearUltraWidePhysicalCameraId) {
            opticalUiBaseline = 0.6f;
        } else if (cameraId == rearTelePhysicalCameraId) {
            opticalUiBaseline = 3.0f;
        } else {
            opticalUiBaseline = 1.0f;
        }
        // These modules normalize UW (display 0.6x arrives as c0=1.0).
        // Video and M9 retain the global ratio on tele (3x/6x arrives as
        // c0=3/6), while Pro normalizes tele to its role (c0=1/2).
        float cameraRelativeRatio;
        if (cameraId == rearUltraWidePhysicalCameraId
                && moduleIndex == 163) {
            // Photo's Xiaomi SAT model expresses its saved 0.6x endpoint as
            // the inverse main-relative value 1/0.6=1.6667 after reopening
            // the physical UW camera. Pro supplies the already-normalized
            // 1.0. On the direct Photo graph both must mean the full UW
            // active array, otherwise 0.6x is cropped back to roughly 1x.
            cameraRelativeRatio = 1.0f;
        } else if (cameraId == rearTelePhysicalCameraId
                && moduleIndex != 167) {
            cameraRelativeRatio = uiRatio / 3.0f;
        } else {
            cameraRelativeRatio = uiRatio;
        }
        float digitalRatio = Math.max(1.0f,
                Math.min(20.0f, cameraRelativeRatio));
        float estimatedUiRatio;
        if (cameraId == rearUltraWidePhysicalCameraId) {
            estimatedUiRatio = uiRatio * 0.6f;
        } else if (cameraId == rearTelePhysicalCameraId
                && moduleIndex == 167) {
            estimatedUiRatio = uiRatio * 3.0f;
        } else {
            estimatedUiRatio = uiRatio;
        }
        Rect active = activeArrayForCamera(cameraId);
        Rect crop = centeredCrop(active, digitalRatio);
        builder.set(CaptureRequest.CONTROL_ZOOM_RATIO, 1.0f);
        builder.set(CaptureRequest.SCALER_CROP_REGION, crop);
        String signature = moduleIndex + ":" + cameraId + ":"
                + Math.round(uiRatio * 100.0f) + ":"
                + Math.round(digitalRatio * 100.0f);
        if (!signature.equals(lastLoggedVideoPhysicalZoomSignature)) {
            lastLoggedVideoPhysicalZoomSignature = signature;
            log("[PhysicalZoomRoute] module=" + moduleIndex
                    + " camera=" + cameraId
                    + " relative=" + uiRatio
                    + " estimatedUi=" + estimatedUiRatio
                    + " opticalBase=" + opticalUiBaseline
                    + " digital=" + digitalRatio
                    + " crop=" + crop);
        }
    }

    private static Rect activeArrayForCamera(int cameraId) {
        try {
            CameraCharacteristics characteristics =
                    CAMERA_CHARACTERISTICS.get(String.valueOf(cameraId));
            Rect active = characteristics == null ? null
                    : characteristics.get(
                    CameraCharacteristics.SENSOR_INFO_ACTIVE_ARRAY_SIZE);
            if (active != null && active.width() > 0
                    && active.height() > 0) {
                return new Rect(active);
            }
        } catch (Throwable throwable) {
            log("[PhysicalZoomRoute] camera=" + cameraId
                    + " active-array fallback: " + throwable);
        }
        return fullRearActiveArray();
    }

    private static Rect centeredCrop(Rect active, float ratio) {
        if (active == null || active.width() <= 0 || active.height() <= 0
                || !Float.isFinite(ratio) || ratio <= 1.001f) {
            return active == null ? new Rect(0, 0, 4096, 3072)
                    : new Rect(active);
        }
        int width = Math.max(2,
                ((int) Math.floor(active.width() / ratio)) & ~1);
        int height = Math.max(2,
                ((int) Math.floor(active.height() / ratio)) & ~1);
        int left = active.left + ((active.width() - width) / 2 & ~1);
        int top = active.top + ((active.height() - height) / 2 & ~1);
        return new Rect(left, top, left + width, top + height);
    }

    /**
     * Xiaomi's zoom stack assumes that crossing one of its role-derived
     * bounds requires closing the current camera and opening a physical ID.
     * That is correct on Xiaomi HALs but breaks OPlus' logical SAT session:
     * the UI stalls while the provider owns a different stream graph, and
     * video/pro can end at an unsupported physical-camera configuration.
     *
     * Keep camera 0 open, expose the OnePlus 13's native 0.6/1/3 boundaries,
     * and let CONTROL_ZOOM_RATIO select physical cameras inside CameraHW.
     */
    private static void hookOnePlusLensOwnership(ClassLoader loader) {
        Class<?> zoomRatios = XposedHelpers.findClass("ur.i", loader);
        hookStaticFloatResult(zoomRatios, "j", 0.6f,
                "ultrawide boundary");
        hookStaticFloatResult(zoomRatios, "h", 3.0f,
                "tele boundary");
        // OnePlus 13 has one tele camera. Xiaomi's ordinary-tele and
        // ultra-tele compatibility roles therefore share the same handoff.
        hookStaticFloatResult(zoomRatios, "i", 3.0f,
                "ultra-tele compatibility boundary");

        Class<?> cameraSettings = XposedHelpers.findClass(
                "com.android.camera.data.data.i", loader);
        XC_MethodHook boxedStopInputHook = new XC_MethodHook() {
            @Override
            protected void beforeHookedMethod(MethodHookParam param) {
                if (param.args == null || param.args.length != 4
                        || !(param.args[3] instanceof Float[])) {
                    return;
                }
                Float[] original = (Float[]) param.args[3];
                Float[] normalized = normalizeOnePlus13ZoomStops(original);
                if (normalized != original) {
                    param.args[3] = normalized;
                    String signature = "zoom-stops-boxed:"
                            + Arrays.toString(original);
                    if (LOGICAL_LENS_OWNERSHIP_LOGGED.add(signature)) {
                        log("[LogicalZoomStops] boxed "
                                + Arrays.toString(original) + " -> "
                                + Arrays.toString(normalized));
                    }
                }
            }
        };
        // Several managers read ur.i.b directly. Intercept the two consumers
        // after normal class initialization instead of touching that final
        // field early (which would initialize the feature table too soon).
        XposedBridge.hookAllMethods(zoomRatios, "q", boxedStopInputHook);
        XposedBridge.hookAllMethods(cameraSettings, "W",
                boxedStopInputHook);
        XposedBridge.hookAllMethods(cameraSettings, "U",
                new XC_MethodHook() {
                    @Override
                    protected void afterHookedMethod(MethodHookParam param) {
                        if (param.hasThrowable()
                                || !(param.getResult() instanceof float[])) {
                            return;
                        }
                        float[] original = (float[]) param.getResult();
                        float[] normalized = normalizeOnePlus13ZoomStops(
                                original);
                        if (normalized == original) {
                            return;
                        }
                        param.setResult(normalized);
                        String mode = param.args != null
                                && param.args.length > 0
                                ? String.valueOf(param.args[0]) : "?";
                        String signature = "zoom-stops-U:" + mode + ":"
                                + Arrays.toString(original);
                        if (LOGICAL_LENS_OWNERSHIP_LOGGED.add(signature)) {
                            log("[LogicalZoomStops] mode=" + mode + " "
                                    + Arrays.toString(original) + " -> "
                                    + Arrays.toString(normalized));
                        }
                    }
                });

        Class<?> modernZoomToggle = XposedHelpers.findClassIfExists(
                "com.xiaomi.camera.features.zoom.ui.view.toggle."
                        + "ZoomRatioToggleView", loader);
        if (modernZoomToggle != null) {
            XposedBridge.hookAllMethods(modernZoomToggle, "setZoomArray",
                    new XC_MethodHook() {
                        @Override
                        protected void beforeHookedMethod(
                                MethodHookParam param) {
                            if (param.args == null || param.args.length != 1
                                    || !(param.args[0] instanceof float[])) {
                                return;
                            }
                            float[] original = (float[]) param.args[0];
                            float[] normalized =
                                    normalizeOnePlus13ZoomStops(original);
                            if (normalized != original) {
                                param.args[0] = normalized;
                                String signature = "zoom-stops-modern:"
                                        + Arrays.toString(original);
                                if (LOGICAL_LENS_OWNERSHIP_LOGGED.add(
                                        signature)) {
                                    log("[LogicalZoomStops] modern "
                                            + Arrays.toString(original)
                                            + " -> "
                                            + Arrays.toString(normalized));
                                }
                            }
                        }
                    });
        }

        Class<?> zoomManager = XposedHelpers.findClass("g9.h", loader);
        XposedBridge.hookAllMethods(zoomManager, "e7", new XC_MethodHook() {
            @Override
            protected void beforeHookedMethod(MethodHookParam param) {
                Object module = param.args != null && param.args.length >= 3
                        ? param.args[2] : null;
                if (moduleKeepsOplusLogicalSat(module)) {
                    logLogicalLensOwnership(module, "continuous");
                    param.setResult(false);
                }
            }
        });
        XposedBridge.hookAllMethods(zoomManager, "l8", new XC_MethodHook() {
            @Override
            protected void beforeHookedMethod(MethodHookParam param) {
                Object module = param.args != null && param.args.length >= 5
                        ? param.args[4] : null;
                if (moduleKeepsOplusLogicalSat(module)) {
                    logLogicalLensOwnership(module, "professional");
                    param.setResult(false);
                }
            }
        });
        XposedBridge.hookAllMethods(zoomManager, "j8", new XC_MethodHook() {
            @Override
            protected void beforeHookedMethod(MethodHookParam param) {
                Object module = param.args != null && param.args.length >= 1
                        ? param.args[0] : null;
                if (moduleKeepsOplusLogicalSat(module)) {
                    logLogicalLensOwnership(module, "physical reopen");
                    // Static void helper: a null result skips the body.
                    param.setResult(null);
                }
            }
        });

        // A few specialized managers call j8 directly and then report that a
        // reopen happened. j8 is suppressed above; returning false lets the
        // caller continue submitting the new ratio instead of freezing UI.
        for (String className : new String[]{"h9.A", "h9.D", "h9.h"}) {
            Class<?> specialized = XposedHelpers.findClassIfExists(
                    className, loader);
            if (specialized == null) {
                continue;
            }
            XposedBridge.hookAllMethods(specialized, "J7",
                    new XC_MethodHook() {
                        @Override
                        protected void afterHookedMethod(
                                MethodHookParam param) {
                            Object module = zoomManagerModule(
                                    param.thisObject);
                            if (moduleKeepsOplusLogicalSat(module)) {
                                param.setResult(false);
                            }
                        }
                    });
        }

        Class<?> proZoomManager = XposedHelpers.findClassIfExists(
                "h9.C", loader);
        if (proZoomManager != null) {
            XposedBridge.hookAllMethods(proZoomManager, "v5",
                    new XC_MethodHook() {
                        @Override
                        protected void afterHookedMethod(
                                MethodHookParam param) {
                            param.setResult(android.util.Range.create(
                                    0.6f, 20.0f));
                        }
                    });
        }

        Class<?> zoomToggle = XposedHelpers.findClassIfExists(
                "com.android.camera.ui.zoom.ZoomRatioToggleView", loader);
        if (zoomToggle != null) {
            XposedBridge.hookAllMethods(zoomToggle, "setCurrentMode",
                    new XC_MethodHook() {
                        @Override
                        protected void beforeHookedMethod(
                                MethodHookParam param) {
                            if (param.args != null
                                    && param.args.length == 1
                                    && param.args[0] instanceof Integer
                                    && (Integer) param.args[0] == 167) {
                                // Only the widget state machine is delegated;
                                // ProModule and manual controls remain 167.
                                param.args[0] = 163;
                                if (LOGICAL_LENS_OWNERSHIP_LOGGED.add(
                                        "pro-toggle")) {
                                    log("[LogicalLensOwnership] Pro zoom UI"
                                            + " delegates to photo SAT model");
                                }
                            }
                        }
                    });
        }
        log("[LogicalLensOwnership] OnePlus 13 stops=0.6/1/2/3/6"
                + " boundaries=0.6/1/3 photo=HAL-SAT video=physical-role");
    }

    /**
     * Re-map only short, recognizable discrete zoom-stop arrays.  Continuous
     * slider arrays contain intermediate values and are returned untouched.
     */
    private static float[] normalizeOnePlus13ZoomStops(float[] original) {
        if (original == null || original.length < 2
                || original.length > 8) {
            return original;
        }
        ArrayList<Float> stops = new ArrayList<>(original.length);
        boolean hasOne = false;
        boolean changed = false;
        for (float value : original) {
            if (!Float.isFinite(value)) {
                return original;
            }
            float mapped;
            if (value >= 0.5f && value <= 0.85f) {
                mapped = 0.6f;
            } else if (Math.abs(value - 1.0f) <= 0.08f) {
                mapped = 1.0f;
                hasOne = true;
            } else if (Math.abs(value - 2.0f) <= 0.08f) {
                mapped = 2.0f;
            } else if (Math.abs(value - 3.0f) <= 0.08f) {
                mapped = 3.0f;
            } else if (Math.abs(value - 5.0f) <= 0.15f) {
                mapped = 3.0f;
            } else if (Math.abs(value - 6.0f) <= 0.15f) {
                mapped = 6.0f;
            } else if (Math.abs(value - 10.0f) <= 0.3f) {
                mapped = 6.0f;
            } else {
                return original;
            }
            if (Math.abs(mapped - value) > 0.001f) {
                changed = true;
            }
            if (stops.isEmpty()
                    || Math.abs(stops.get(stops.size() - 1) - mapped)
                    > 0.001f) {
                stops.add(mapped);
            } else {
                changed = true;
            }
        }
        if (!hasOne || !changed) {
            return original;
        }
        float[] normalized = new float[stops.size()];
        for (int i = 0; i < stops.size(); i++) {
            normalized[i] = stops.get(i);
        }
        return normalized;
    }

    private static Float[] normalizeOnePlus13ZoomStops(Float[] original) {
        if (original == null) {
            return original;
        }
        float[] primitive = new float[original.length];
        for (int i = 0; i < original.length; i++) {
            if (original[i] == null) {
                return original;
            }
            primitive[i] = original[i];
        }
        float[] normalized = normalizeOnePlus13ZoomStops(primitive);
        if (normalized == primitive) {
            return original;
        }
        Float[] boxed = new Float[normalized.length];
        for (int i = 0; i < normalized.length; i++) {
            boxed[i] = normalized[i];
        }
        return boxed;
    }

    private static void hookStaticFloatResult(
            Class<?> owner, String methodName, float value,
            String description) {
        XposedBridge.hookAllMethods(owner, methodName,
                new XC_MethodHook() {
                    @Override
                    protected void afterHookedMethod(MethodHookParam param) {
                        if (!param.hasThrowable()
                                && (param.args == null
                                || param.args.length == 0)) {
                            param.setResult(value);
                        }
                    }
                });
        log("[LogicalLensOwnership] " + description + "=" + value);
    }

    private static Object zoomManagerModule(Object zoomManager) {
        if (zoomManager == null) {
            return null;
        }
        try {
            Object reference = XposedHelpers.getObjectField(
                    zoomManager, "b");
            if (reference instanceof java.lang.ref.Reference) {
                return ((java.lang.ref.Reference<?>) reference).get();
            }
        } catch (Throwable ignored) {
            // Obfuscation alias changed; the safety guard simply stays off.
        }
        return null;
    }

    private static boolean moduleUsesRearLogicalCamera(Object module) {
        if (module == null) {
            return false;
        }
        try {
            Object cameraId = XposedHelpers.callMethod(
                    module, "getActualCameraId");
            if (cameraId instanceof Number) {
                return ((Number) cameraId).intValue() == 0;
            }
        } catch (Throwable ignored) {
            try {
                Object manager = XposedHelpers.callMethod(
                        module, "getCameraManager");
                Object cameraId = XposedHelpers.callMethod(
                        manager, "getActualCameraId");
                return cameraId instanceof Number
                        && ((Number) cameraId).intValue() == 0;
            } catch (Throwable ignoredAgain) {
                return false;
            }
        }
        return false;
    }

    private static boolean moduleKeepsOplusLogicalSat(Object module) {
        // Module 162 is ordinary video (Xiaomi 0x803c rather than ColorOS'
        // five-stream 0x8021 SAT graph). Module 167 is direct Camera2 Pro
        // JPEG/RAW (0x8003), whose logical-camera preview is stride-corrupt on
        // this port. Both deliberately retain Xiaomi's physical-role reopen.
        int moduleIndex = moduleIndexOf(module);
        return moduleIndex != 162 && moduleIndex != 167
                && moduleUsesRearLogicalCamera(module);
    }

    private static int moduleIndexOf(Object module) {
        if (module == null) {
            return -1;
        }
        try {
            Object value = XposedHelpers.callMethod(module,
                    "getModuleIndex");
            return value instanceof Number
                    ? ((Number) value).intValue() : -1;
        } catch (Throwable ignored) {
            return -1;
        }
    }

    private static void logLogicalLensOwnership(
            Object module, String path) {
        int moduleIndex = moduleIndexOf(module);
        String signature = path + ":" + moduleIndex;
        if (LOGICAL_LENS_OWNERSHIP_LOGGED.add(signature)) {
            log("[LogicalLensOwnership] module=" + moduleIndex
                    + " path=" + path
                    + " Xiaomi physical reopen suppressed;"
                    + " OPlus SAT owns rear lenses");
        }
    }

    /**
     * Portrait changes 1x/2x/5x by rebuilding module 171. Xiaomi validates
     * the just-selected value against a device-feature table before reopening
     * the camera; that table is absent on the port, so a valid value is reset
     * to the device default (2x). Accept only finite ratios inside the actual
     * OnePlus logical-camera range and let Xiaomi retain its stored value.
     */
    private static void hookPortraitZoomSelectionPersistence(
            ClassLoader loader) {
        Class<?> runningZoom = XposedHelpers.findClassIfExists(
                "v2.A0", loader);
        if (runningZoom == null) {
            // Older Xiaomi camera builds use this alias for the same class.
            runningZoom = XposedHelpers.findClassIfExists("h0.q0", loader);
        }
        if (runningZoom == null) {
            throw new IllegalStateException(
                    "ComponentRunningZoom class not found");
        }
        final String runningZoomClass = runningZoom.getName();
        XposedHelpers.findAndHookMethod(
                runningZoom,
                "checkValueValid",
                int.class,
                String.class,
                new XC_MethodHook() {
                    @Override
                    protected void beforeHookedMethod(MethodHookParam param) {
                        if ((Integer) param.args[0] != 171
                                || !(param.args[1] instanceof String)) {
                            return;
                        }
                        try {
                            float ratio = Float.parseFloat(
                                    (String) param.args[1]);
                            if (Float.isFinite(ratio)
                                    && ratio >= 0.6f && ratio <= 20.0f) {
                                param.setResult(true);
                                log("[PortraitZoomPersistence] retained "
                                        + ratio + "x across module rebuild");
                            }
                        } catch (NumberFormatException ignored) {
                            // Let Xiaomi reject malformed persisted values.
                        }
                    }
                });
        log("[PortraitZoomPersistence] module-171 validation bridge active"
                + " class=" + runningZoomClass);
    }

    private static Rect fullRearActiveArray() {
        try {
            CameraCharacteristics characteristics =
                    CAMERA_CHARACTERISTICS.get("0");
            Rect active = characteristics == null ? null
                    : characteristics.get(
                    CameraCharacteristics.SENSOR_INFO_ACTIVE_ARRAY_SIZE);
            if (active != null && active.width() > 0
                    && active.height() > 0) {
                return new Rect(active);
            }
        } catch (Throwable throwable) {
            log("[LogicalZoom] active-array lookup failed: " + throwable);
        }
        // Exact camera-0 crop captured from the stock OnePlus 13 camera.
        return new Rect(0, 0, 4096, 3072);
    }

    private static void hookOplusFocus(ClassLoader loader) {
        /*
         * CameraUnit does not use the same region for both metadata paths
         * below 1x. Its standard CONTROL_AF/AE_REGIONS are calculated in the
         * 1x active array, while com.oplus.control.*.region retains the
         * expanded ultra-wide coordinates. Xiaomi writes only the expanded
         * rectangle to the standard key; an edge tap can consequently contain
         * a negative x/y and the framework cannot unmarshal it later.
         */
        Class<?> requestBuilder = XposedHelpers.findClass("j9.k0", loader);
        hookXiaomiFocusRegionWriter(requestBuilder, "b", false);
        hookXiaomiFocusRegionWriter(requestBuilder, "c", true);

        XposedBridge.hookAllMethods(CaptureRequest.Builder.class, "build", new XC_MethodHook() {
            @Override
            protected void beforeHookedMethod(MethodHookParam param) {
                CaptureRequest.Builder builder = (CaptureRequest.Builder) param.thisObject;
                try {
                    Integer trigger = builder.get(CaptureRequest.CONTROL_AF_TRIGGER);
                    if (trigger == null || trigger != CaptureRequest.CONTROL_AF_TRIGGER_START) {
                        return;
                    }
                    Float ratio = builder.get(CaptureRequest.CONTROL_ZOOM_RATIO);
                    if (ratio != null && Float.isFinite(ratio)
                            && ratio < 0.999f) {
                        // The j9.k0 writers above already installed the
                        // ColorOS dual-coordinate contract. Reading Xiaomi's
                        // old negative standard AE region here would itself
                        // throw while CameraMetadata unmarshals it.
                        return;
                    }
                    Integer mode = builder.get(CaptureRequest.CONTROL_AF_MODE);
                    MeteringRectangle[] af = null;
                    MeteringRectangle[] ae = null;
                    try {
                        af = builder.get(CaptureRequest.CONTROL_AF_REGIONS);
                        if (af != null && af.length > 0) {
                            if (mode != null
                                    && mode != CaptureRequest.CONTROL_AF_MODE_OFF) {
                                builder.set(CaptureRequest.CONTROL_AF_MODE,
                                        CaptureRequest.CONTROL_AF_MODE_AUTO);
                            }
                            builder.set(OPLUS_AF_REGION, oplusRegion(af[0]));
                        }
                    } catch (Throwable throwable) {
                        log("[FocusBridge] standard AF unavailable: "
                                + throwable);
                    }
                    try {
                        ae = builder.get(CaptureRequest.CONTROL_AE_REGIONS);
                        if (ae != null && ae.length > 0) {
                            builder.set(OPLUS_AE_REGION,
                                    oplusRegion(ae[0]));
                        }
                    } catch (Throwable throwable) {
                        log("[FocusBridge] standard AE unavailable: "
                                + throwable);
                    }
                    log("[FocusBridge] afMode=" + mode
                            + " af=" + Arrays.toString(af)
                            + " ae=" + Arrays.toString(ae));
                } catch (Throwable throwable) {
                    log("[FocusBridge] request unchanged: " + throwable);
                }
            }

            @Override
            protected void afterHookedMethod(MethodHookParam param) {
                if (activeCameraId != 0
                        || activeCameraModule != 163
                        || !(param.getResult() instanceof CaptureRequest)) {
                    return;
                }
                CaptureRequest request = (CaptureRequest) param.getResult();
                Float ratio = request.get(CaptureRequest.CONTROL_ZOOM_RATIO);
                if (ratio != null && Float.isFinite(ratio)
                        && ratio >= 3.0f) {
                    // Read-only one-shot audit.  The logical mode-0 graph can
                    // activate physical 4 for one frame and then falls back to
                    // main 2. Compare the first fully built >=3x request with
                    // ColorOS' exact stock tele request to expose the missing
                    // ownership/fallback tag without changing live capture.
                    logTelePreviewContractDiffOnce(request);
                }
            }
        });
        log("[FocusBridge] OPlus dual-coordinate region hook active");
    }

    private static void hookXiaomiFocusRegionWriter(Class<?> requestBuilder,
            String methodName, boolean autofocus) {
        XposedBridge.hookAllMethods(requestBuilder, methodName,
                new XC_MethodHook() {
                    @Override
                    protected void afterHookedMethod(MethodHookParam param) {
                        if (param.args == null || param.args.length != 2
                                || !(param.args[0]
                                instanceof CaptureRequest.Builder)
                                || param.args[1] == null) {
                            return;
                        }
                        try {
                            CaptureRequest.Builder builder =
                                    (CaptureRequest.Builder) param.args[0];
                            Object rawRegions = XposedHelpers.getObjectField(
                                    param.args[1], autofocus ? "c" : "b");
                            if (!(rawRegions instanceof MeteringRectangle[])) {
                                return;
                            }
                            MeteringRectangle[] regions =
                                    (MeteringRectangle[]) rawRegions;
                            if (regions.length == 0 || regions[0] == null) {
                                return;
                            }
                            float ratio = XposedHelpers.getFloatField(
                                    param.args[1], "c0");
                            if (!Float.isFinite(ratio) || ratio <= 0.0f) {
                                ratio = 1.0f;
                            }
                            MeteringRectangle original = regions[0];
                            CaptureRequest.Key<int[]> vendorKey = autofocus
                                    ? OPLUS_AF_REGION : OPLUS_AE_REGION;
                            builder.set(vendorKey, oplusRegion(original));

                            if (ratio < 0.999f
                                    && original.getWidth() > 0
                                    && original.getHeight() > 0
                                    && original.getMeteringWeight() > 0) {
                                MeteringRectangle standard =
                                        mapExpandedFocusRegionToActive(
                                                original, ratio,
                                                fullRearActiveArray());
                                builder.set(autofocus
                                                ? CaptureRequest.CONTROL_AF_REGIONS
                                                : CaptureRequest.CONTROL_AE_REGIONS,
                                        new MeteringRectangle[]{standard});
                                log("[FocusBridge] "
                                        + (autofocus ? "AF" : "AE")
                                        + " ratio=" + ratio
                                        + " private=" + Arrays.toString(
                                        oplusRegion(original))
                                        + " standard=" + standard);
                            }
                        } catch (Throwable throwable) {
                            log("[FocusBridge] Xiaomi "
                                    + (autofocus ? "AF" : "AE")
                                    + " writer unchanged: " + throwable);
                        }
                    }
                });
    }

    private static MeteringRectangle mapExpandedFocusRegionToActive(
            MeteringRectangle source, float ratio, Rect active) {
        float centerX = active.exactCenterX();
        float centerY = active.exactCenterY();
        int left = clampFocusCoordinate(Math.round(centerX
                        + (source.getX() - centerX) * ratio),
                active.left, active.right - 1);
        int top = clampFocusCoordinate(Math.round(centerY
                        + (source.getY() - centerY) * ratio),
                active.top, active.bottom - 1);
        int right = clampFocusCoordinate(Math.round(centerX
                        + (source.getX() + source.getWidth() - centerX)
                        * ratio),
                left + 1, active.right);
        int bottom = clampFocusCoordinate(Math.round(centerY
                        + (source.getY() + source.getHeight() - centerY)
                        * ratio),
                top + 1, active.bottom);
        int weight = Math.max(MeteringRectangle.METERING_WEIGHT_MIN,
                Math.min(MeteringRectangle.METERING_WEIGHT_MAX,
                        source.getMeteringWeight()));
        return new MeteringRectangle(
                new Rect(left, top, right, bottom), weight);
    }

    private static int clampFocusCoordinate(int value, int minimum,
            int maximum) {
        return Math.max(minimum, Math.min(maximum, value));
    }

    private static void hookStillQualityHints() {
        XposedBridge.hookAllMethods(CaptureRequest.Builder.class, "build", new XC_MethodHook() {
            @Override
            protected void beforeHookedMethod(MethodHookParam param) {
                CaptureRequest.Builder builder = (CaptureRequest.Builder) param.thisObject;
                try {
                    if (activeCameraId == 0
                            && activeCameraModule != 162
                            && activeCameraModule != 167) {
                        Float logicalRatio = builder.get(
                                CaptureRequest.CONTROL_ZOOM_RATIO);
                        if (logicalRatio != null
                                && Float.isFinite(logicalRatio)
                                && logicalRatio >= 3.0f) {
                            applyLogicalOplusTeleRoute(
                                    builder, logicalRatio);
                            String signature = activeCameraModule + ":"
                                    + Math.round(logicalRatio * 100.0f);
                            if (LOGICAL_LENS_OWNERSHIP_LOGGED.add(
                                    "final-tele:" + signature)) {
                                log("[LogicalTeleFinal] module="
                                        + activeCameraModule
                                        + " ratio=" + logicalRatio
                                        + " relative="
                                        + Math.max(1.0f,
                                        logicalRatio / 3.0f)
                                        + " master=2 sensorModes="
                                        + "[3,-1,2,0,-1,-1,-1,-1]");
                            }
                        }
                    }
                    Integer intent = builder.get(CaptureRequest.CONTROL_CAPTURE_INTENT);
                    if (intent == null
                            || intent != CaptureRequest.CONTROL_CAPTURE_INTENT_STILL_CAPTURE) {
                        return;
                    }
                    builder.set(CaptureRequest.NOISE_REDUCTION_MODE,
                            CaptureRequest.NOISE_REDUCTION_MODE_HIGH_QUALITY);
                    builder.set(CaptureRequest.EDGE_MODE,
                            CaptureRequest.EDGE_MODE_HIGH_QUALITY);
                    builder.set(CaptureRequest.COLOR_CORRECTION_ABERRATION_MODE,
                            CaptureRequest.COLOR_CORRECTION_ABERRATION_MODE_HIGH_QUALITY);
                    builder.set(CaptureRequest.SHADING_MODE,
                            CaptureRequest.SHADING_MODE_HIGH_QUALITY);
                    if (isRearDirectCaptureCamera(activeCameraId)
                            && (activeCameraModule == 163
                            || activeCameraModule == 167
                            || activeCameraModule == 256)) {
                        builder.set(CaptureRequest.CONTROL_ENABLE_ZSL, false);
                        builder.set(CaptureRequest.JPEG_QUALITY, (byte) 100);
                    }
                    if (!loggedStillQuality) {
                        loggedStillQuality = true;
                        log("[StillQuality] still request NR/EDGE/CA/SHADING=HQ");
                    }
                } catch (Throwable throwable) {
                    if (!loggedStillQuality) {
                        loggedStillQuality = true;
                        log("[StillQuality] optional HQ hints partially rejected: " + throwable);
                    }
                }
            }
        });
        log("[StillQuality] HQ request hook active");
    }

    /**
     * Qualcomm declares enableMFNR as a session key, not a per-capture key.
     * The compatibility path previously wrote it only while building the
     * final still request.  That value is visible in CaptureRequest logs but
     * arrives after the CHI usecase has already been selected, so the OnePlus
     * provider keeps the single-frame JPEG graph.
     *
     * Xiaomi's sh.b wrapper passes the immutable request to
     * SessionConfiguration.setSessionParameters.  Mutate its private native
     * metadata immediately before that call, preserving all Xiaomi session
     * keys and physical-camera settings.  Limit the experiment to the rear
     * normal-photo and Legendary modules; portrait, document and video keep
     * their already validated session graphs.
     */
    private static void hookOplusMfnrSession(ClassLoader loader) {
        Class<?> wrapper = XposedHelpers.findClass("sh.b", loader);
        XposedBridge.hookAllMethods(wrapper, "b", new XC_MethodHook() {
            @Override
            protected void beforeHookedMethod(MethodHookParam param) {
                if (param.args == null || param.args.length != 5
                        || !(param.args[2] instanceof CaptureRequest)
                        || !isRearDirectCaptureCamera(activeCameraId)
                        || (activeCameraModule != 163
                        && activeCameraModule != 256)) {
                    return;
                }
                CaptureRequest session = (CaptureRequest) param.args[2];
                try {
                    Object metadata = XposedHelpers.getObjectField(
                            session, "mLogicalCameraSettings");
                    XposedHelpers.callMethod(metadata, "set",
                            OPLUS_SESSION_MFNR, 1);
                    Integer applied = session.get(OPLUS_SESSION_MFNR);
                    log("[MfnrSession] module=" + activeCameraModule
                            + " camera=" + activeCameraId
                            + " enableMFNR=" + applied
                            + " sessionType=" + param.args[0]);
                    loggedMfnrSession = true;
                } catch (Throwable throwable) {
                    if (!loggedMfnrSession) {
                        loggedMfnrSession = true;
                        log("[MfnrSession] original session retained: "
                                + throwable);
                    }
                }
            }
        });
        log("[MfnrSession] rear Photo/M9 session hook active");
    }

    private static boolean isRearDirectCaptureCamera(int cameraId) {
        return cameraId == 0
                || cameraId == rearMainPhysicalCameraId
                || cameraId == rearUltraWidePhysicalCameraId
                || cameraId == rearTelePhysicalCameraId;
    }

    private static void hookStillResultProbe(ClassLoader loader) {
        // Runtime name of JADX's C4721f1: the capture callback used only by
        // MiCamera2ShotStill, so preview results do not flood the module log.
        Class<?> stillCallback = XposedHelpers.findClass("j9.f1", loader);
        XposedBridge.hookAllMethods(stillCallback, "onCaptureStarted",
                new XC_MethodHook() {
                    @Override
                    protected void afterHookedMethod(MethodHookParam param) {
                        if (param.args == null || param.args.length < 4
                                || !(param.args[1] instanceof CaptureRequest)
                                || !(param.args[2] instanceof Long)) {
                            return;
                        }
                        CaptureRequest request =
                                (CaptureRequest) param.args[1];
                        Integer intent = request.get(
                                CaptureRequest.CONTROL_CAPTURE_INTENT);
                        if (intent != null && intent
                                == CaptureRequest
                                .CONTROL_CAPTURE_INTENT_STILL_CAPTURE) {
                            armCommonApsShutter(request,
                                    (Long) param.args[2]);
                        }
                    }
                });
        XposedBridge.hookAllMethods(stillCallback, "onCaptureCompleted", new XC_MethodHook() {
            @Override
            protected void afterHookedMethod(MethodHookParam param) {
                if (param.args.length < 3 || !(param.args[2] instanceof TotalCaptureResult)) {
                    return;
                }
                CaptureRequest request = param.args[1] instanceof CaptureRequest
                        ? (CaptureRequest) param.args[1] : null;
                TotalCaptureResult result = (TotalCaptureResult) param.args[2];
                Long sensorTimestamp = safeResultValue(
                        result, CaptureResult.SENSOR_TIMESTAMP);
                Integer captureIntent = request == null ? null
                        : request.get(CaptureRequest.CONTROL_CAPTURE_INTENT);
                if (sensorTimestamp != null && sensorTimestamp > 0L
                        && captureIntent != null
                        && captureIntent == CaptureRequest.CONTROL_CAPTURE_INTENT_STILL_CAPTURE) {
                    STILL_CAPTURE_RESULTS.put(sensorTimestamp, result);
                    // Single capture normally leaves no entry behind.  This
                    // bounds stale results from abandoned/burst save tasks.
                    if (STILL_CAPTURE_RESULTS.size() > 16) {
                        long cutoff = sensorTimestamp - 10_000_000_000L;
                        STILL_CAPTURE_RESULTS.keySet().removeIf(
                                timestamp -> timestamp < cutoff);
                    }
                }
                log("[StillProbe] intent=" + readRequest(request, CaptureRequest.CONTROL_CAPTURE_INTENT)
                        + " zsl=" + readRequest(request, CaptureRequest.CONTROL_ENABLE_ZSL)
                        + " jpegQ=" + readRequest(request, CaptureRequest.JPEG_QUALITY)
                        + " nr=" + readRequest(request, CaptureRequest.NOISE_REDUCTION_MODE)
                        + " edge=" + readRequest(request, CaptureRequest.EDGE_MODE)
                        + " ca=" + readRequest(request,
                                CaptureRequest.COLOR_CORRECTION_ABERRATION_MODE)
                        + " shading=" + readRequest(request, CaptureRequest.SHADING_MODE)
                        + " oplusMode=" + readRequestByteArray(request,
                                OPLUS_CAMERA_MODE)
                        + " oplusSuperText=" + readRequest(request,
                                OPLUS_SUPER_TEXT_MODE)
                        + " oplusMFNR=" + readRequest(request,
                                OPLUS_SESSION_MFNR)
                        + " originalZoom=" + readRequestFloatArray(request,
                                OPLUS_ORIGINAL_ZOOM)
                        + " zoomTarget=" + readRequestFloatArray(request,
                                OPLUS_ZOOM_TARGET)
                        + " satMaster=" + readRequestIntArray(request,
                                COMMON_APS_SAT_MASTER_CAMERA)
                        + " sensorModes=" + readRequestIntArray(request,
                                COMMON_APS_SENSOR_MODE_LIST)
                        + " beautyLevel=" + readRequestIntArray(request,
                                OPLUS_FACE_BEAUTY_LEVEL)
                        + " beautyCustom=" + readRequestIntArray(request,
                                OPLUS_FACE_BEAUTY_CUSTOM)
                        + " resultBeautyLevel=" + readResultIntArray(result,
                                OPLUS_FACE_BEAUTY_LEVEL_RESULT)
                        + " resultBeautyCustom=" + readResultIntArray(result,
                                OPLUS_FACE_BEAUTY_CUSTOM_RESULT)
                        + " sequence=" + result.getSequenceId()
                        + " frame=" + result.getFrameNumber()
                        + " sensorTs=" + sensorTimestamp
                        + " logical=" + describeResult(result)
                        + " physical=" + describePhysicalResults(result));
                startCommonApsShutterAfterXiaomiResult(request, result);
            }
        });
        log("[StillProbe] MiCamera2ShotStill result/shutter hooks active");
    }

    private static <T> String readRequest(CaptureRequest request, CaptureRequest.Key<T> key) {
        if (request == null) {
            return "no-request";
        }
        try {
            return String.valueOf(request.get(key));
        } catch (Throwable throwable) {
            return "unsupported(" + throwable.getClass().getSimpleName() + ")";
        }
    }

    private static <T> String readResult(CaptureResult result, CaptureResult.Key<T> key) {
        try {
            return String.valueOf(result.get(key));
        } catch (Throwable throwable) {
            return "unsupported(" + throwable.getClass().getSimpleName() + ")";
        }
    }

    private static String readRequestIntArray(
            CaptureRequest request, CaptureRequest.Key<int[]> key) {
        if (request == null) {
            return "no-request";
        }
        try {
            return Arrays.toString(request.get(key));
        } catch (Throwable throwable) {
            return "unsupported(" + throwable.getClass().getSimpleName() + ")";
        }
    }

    private static String readRequestFloatArray(
            CaptureRequest request, CaptureRequest.Key<float[]> key) {
        if (request == null) {
            return "no-request";
        }
        try {
            return Arrays.toString(request.get(key));
        } catch (Throwable throwable) {
            return "unsupported(" + throwable.getClass().getSimpleName()
                    + ")";
        }
    }

    private static String readRequestByteArray(
            CaptureRequest request, CaptureRequest.Key<byte[]> key) {
        if (request == null) {
            return "no-request";
        }
        try {
            byte[] value = request.get(key);
            if (value == null) {
                return "null";
            }
            int end = 0;
            while (end < value.length && value[end] != 0) {
                end++;
            }
            return new String(value, 0, end, StandardCharsets.UTF_8);
        } catch (Throwable throwable) {
            return "unsupported(" + throwable.getClass().getSimpleName()
                    + ")";
        }
    }

    private static String readResultIntArray(
            CaptureResult result, CaptureResult.Key<int[]> key) {
        try {
            return Arrays.toString(result.get(key));
        } catch (Throwable throwable) {
            return "unsupported(" + throwable.getClass().getSimpleName() + ")";
        }
    }

    private static String describeResult(CaptureResult result) {
        return "{active=" + readResult(result,
                CaptureResult.LOGICAL_MULTI_CAMERA_ACTIVE_PHYSICAL_ID)
                + ",focal=" + readResult(result, CaptureResult.LENS_FOCAL_LENGTH)
                + ",zoom=" + readResult(result, CaptureResult.CONTROL_ZOOM_RATIO)
                + ",iso=" + readResult(result, CaptureResult.SENSOR_SENSITIVITY)
                + ",exposureNs=" + readResult(result, CaptureResult.SENSOR_EXPOSURE_TIME)
                + ",total=" + readResult(result, MFNR_TOTAL_FRAMES)
                + ",blendFrame=" + readResult(result, MFNR_BLEND_FRAME)
                + ",swBlended=" + readResult(result, SW_MFNR_BLENDED_FRAMES)
                + ",confidence=" + readResult(result, SW_MFNR_BLEND_CONFIDENCE)
                + ",oplusSharpness=" + readResultArray(result, OPLUS_MFNR_SHARPNESS)
                + "}";
    }

    private static String describePhysicalResults(TotalCaptureResult result) {
        try {
            Map<String, TotalCaptureResult> physical = result.getPhysicalCameraTotalResults();
            if (physical == null || physical.isEmpty()) {
                return "{}";
            }
            StringBuilder description = new StringBuilder("{");
            boolean first = true;
            for (Map.Entry<String, TotalCaptureResult> entry : physical.entrySet()) {
                if (!first) {
                    description.append(',');
                }
                first = false;
                description.append(entry.getKey())
                        .append('=')
                        .append(describeResult(entry.getValue()));
            }
            return description.append('}').toString();
        } catch (Throwable throwable) {
            return "unsupported(" + throwable.getClass().getSimpleName() + ")";
        }
    }

    private static String readResultArray(
            CaptureResult result, CaptureResult.Key<float[]> key) {
        try {
            return Arrays.toString(result.get(key));
        } catch (Throwable throwable) {
            return "unsupported(" + throwable.getClass().getSimpleName() + ")";
        }
    }

    private static int[] oplusRegion(MeteringRectangle region) {
        return new int[]{
                region.getX(),
                region.getY(),
                region.getX() + region.getWidth(),
                region.getY() + region.getHeight(),
                region.getMeteringWeight()
        };
    }

    private static boolean isRoleIdsKey(String name) {
        return "com.xiaomi.cameraid.role.cameraIds".equals(name)
                || "xiaomi.cameraid.role.cameraIds".equals(name);
    }

    private static boolean isRoleIdKey(String name) {
        return "com.xiaomi.cameraid.role.cameraId".equals(name)
                || "xiaomi.cameraid.role.cameraId".equals(name);
    }

    private static int[] rolesFor(String cameraId) {
        if ("0".equals(cameraId)) {
            return new int[]{60, 61, 62, 63, 66, 67, 100, 300};
        }
        if ("1".equals(cameraId)) {
            return new int[]{1, 40, 80, 81, 101, 301};
        }
        String lensType = REAR_PHYSICAL_LENS_TYPES.get(cameraId);
        if ("main".equals(lensType)
                || lensType == null && cameraId.equals(
                String.valueOf(rearMainPhysicalCameraId))) {
            return new int[]{0};
        }
        if ("ultrawide".equals(lensType)
                || lensType == null && cameraId.equals(
                String.valueOf(rearUltraWidePhysicalCameraId))) {
            return new int[]{21, 22, 24};
        }
        if ("tele".equals(lensType)
                || lensType == null && cameraId.equals(
                String.valueOf(rearTelePhysicalCameraId))) {
            // OnePlus 13 has one tele sensor. It serves both of Xiaomi's
            // ordinary-tele and ultra-tele compatibility roles.
            return new int[]{20, 23, 65};
        }
        return null;
    }

    private static Integer primaryRoleFor(String cameraId) {
        if ("0".equals(cameraId)) return 60;
        if ("1".equals(cameraId)) return 1;
        int[] roles = rolesFor(cameraId);
        return roles == null || roles.length == 0 ? null : roles[0];
    }

    private static int cameraForRole(int role) {
        if (role == 60 || role == 61 || role == 62 || role == 63
                || role == 66 || role == 67 || role == 100 || role == 300) {
            return 0;
        }
        if (role == 1 || role == 40 || role == 80 || role == 81
                || role == 101 || role == 301) {
            return 1;
        }
        if (role == 0) {
            return rearMainPhysicalCameraId;
        }
        if (role == 21 || role == 22 || role == 24) {
            return rearUltraWidePhysicalCameraId;
        }
        if (role == 20 || role == 23 || role == 65) {
            return rearTelePhysicalCameraId;
        }
        return -1;
    }

    private static void populateRoleMap(SparseIntArray map) {
        putCameraRoles(map, "0");
        putCameraRoles(map, "1");
        putCameraRoles(map, "2");
        putCameraRoles(map, "3");
        putCameraRoles(map, "4");
    }

    private static void putCameraRoles(
            SparseIntArray map, String cameraId) {
        int[] roles = rolesFor(cameraId);
        if (roles == null) {
            return;
        }
        int numericId = Integer.parseInt(cameraId);
        for (int role : roles) {
            map.put(role, numericId);
        }
    }

    private static void recordRearLensTopology(
            String cameraId, CameraCharacteristics characteristics) {
        try {
            if ("0".equals(cameraId)) {
                Set<String> physicalIds =
                        characteristics.getPhysicalCameraIds();
                if (physicalIds != null && !physicalIds.isEmpty()) {
                    REAR_LOGICAL_PHYSICAL_IDS.clear();
                    REAR_LOGICAL_PHYSICAL_IDS.addAll(physicalIds);
                    String signature = "physicalIds:" + physicalIds;
                    if (REAR_TOPOLOGY_LOGGED.add(signature)) {
                        log("[RearTopology] logical camera 0 physicalIds="
                                + physicalIds);
                    }
                }
                return;
            }
            int numericId = Integer.parseInt(cameraId);
            if (numericId <= 1
                    || !REAR_LOGICAL_PHYSICAL_IDS.isEmpty()
                    && !REAR_LOGICAL_PHYSICAL_IDS.contains(cameraId)) {
                return;
            }
            Integer facing = characteristics.get(
                    CameraCharacteristics.LENS_FACING);
            if (facing != null
                    && facing != CameraCharacteristics.LENS_FACING_BACK) {
                return;
            }
            float[] focalLengths = characteristics.get(
                    CameraCharacteristics.LENS_INFO_AVAILABLE_FOCAL_LENGTHS);
            if (focalLengths == null || focalLengths.length == 0) {
                return;
            }
            float focal = Float.MAX_VALUE;
            for (float candidate : focalLengths) {
                if (Float.isFinite(candidate) && candidate > 0.0f) {
                    focal = Math.min(focal, candidate);
                }
            }
            if (!Float.isFinite(focal) || focal == Float.MAX_VALUE) {
                return;
            }
            SizeF sensor = characteristics.get(
                    CameraCharacteristics.SENSOR_INFO_PHYSICAL_SIZE);
            float horizontalFov = Float.NaN;
            if (sensor != null && sensor.getWidth() > 0.0f) {
                horizontalFov = (float) Math.toDegrees(2.0d * Math.atan(
                        sensor.getWidth() / (2.0d * focal)));
            }
            final String lensType;
            if (Float.isFinite(horizontalFov)) {
                if (horizontalFov >= 85.0f) {
                    lensType = "ultrawide";
                } else if (horizontalFov <= 50.0f) {
                    lensType = "tele";
                } else {
                    lensType = "main";
                }
            } else if (focal <= 5.0f) {
                lensType = "ultrawide";
            } else if (focal >= 10.0f) {
                lensType = "tele";
            } else {
                lensType = "main";
            }
            REAR_PHYSICAL_LENS_TYPES.put(cameraId, lensType);
            REAR_PHYSICAL_FOV.put(cameraId, horizontalFov);
            switch (lensType) {
                case "main":
                    rearMainPhysicalCameraId = numericId;
                    break;
                case "ultrawide":
                    rearUltraWidePhysicalCameraId = numericId;
                    break;
                case "tele":
                    rearTelePhysicalCameraId = numericId;
                    break;
                default:
                    return;
            }
            String signature = cameraId + ":" + lensType;
            if (REAR_TOPOLOGY_LOGGED.add(signature)) {
                log("[RearTopology] camera=" + cameraId
                        + " lens=" + lensType
                        + " focalMm=" + focal
                        + " horizontalFov=" + horizontalFov
                        + " roles=" + Arrays.toString(
                        rolesFor(cameraId)));
            }
        } catch (Throwable throwable) {
            log("[RearTopology] camera=" + cameraId
                    + " classification preserved fallback: "
                    + throwable);
        }
    }

    private static void logRolesOnce(String source, String cameraId, int[] roles) {
        if (!loggedRoles) {
            loggedRoles = true;
            log("[RoleMap] " + source + " active; camera=" + cameraId
                    + " roles=" + Arrays.toString(roles));
        }
    }

    private static void install(String name, ThrowingRunnable runnable) {
        try {
            runnable.run();
        } catch (Throwable throwable) {
            log(name + " unavailable: " + throwable);
            XposedBridge.log(throwable);
        }
    }

    private static void log(String message) {
        XposedBridge.log(LOG + message);
    }

    private interface ThrowingRunnable {
        void run() throws Throwable;
    }
}
