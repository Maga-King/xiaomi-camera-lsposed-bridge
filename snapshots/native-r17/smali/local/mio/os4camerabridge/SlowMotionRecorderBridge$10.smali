.class Llocal/mio/os4camerabridge/SlowMotionRecorderBridge$10;
.super Lde/robv/android/xposed/XC_MethodHook;
.source "SlowMotionRecorderBridge.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Llocal/mio/os4camerabridge/SlowMotionRecorderBridge;->bindRecordState(Ljava/lang/ClassLoader;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic val$cameraMode:Landroid/hardware/camera2/CaptureRequest$Key;

.field final synthetic val$eisState:Landroid/hardware/camera2/CaptureRequest$Key;

.field final synthetic val$eos:Landroid/hardware/camera2/CaptureRequest$Key;

.field final synthetic val$recordState:Landroid/hardware/camera2/CaptureRequest$Key;


# direct methods
.method constructor <init>(Landroid/hardware/camera2/CaptureRequest$Key;Landroid/hardware/camera2/CaptureRequest$Key;Landroid/hardware/camera2/CaptureRequest$Key;Landroid/hardware/camera2/CaptureRequest$Key;)V
    .locals 0

    .line 180
    iput-object p1, p0, Llocal/mio/os4camerabridge/SlowMotionRecorderBridge$10;->val$cameraMode:Landroid/hardware/camera2/CaptureRequest$Key;

    iput-object p2, p0, Llocal/mio/os4camerabridge/SlowMotionRecorderBridge$10;->val$recordState:Landroid/hardware/camera2/CaptureRequest$Key;

    iput-object p3, p0, Llocal/mio/os4camerabridge/SlowMotionRecorderBridge$10;->val$eisState:Landroid/hardware/camera2/CaptureRequest$Key;

    iput-object p4, p0, Llocal/mio/os4camerabridge/SlowMotionRecorderBridge$10;->val$eos:Landroid/hardware/camera2/CaptureRequest$Key;

    invoke-direct {p0}, Lde/robv/android/xposed/XC_MethodHook;-><init>()V

    return-void
.end method


# virtual methods
.method protected beforeHookedMethod(Lde/robv/android/xposed/XC_MethodHook$MethodHookParam;)V
    .locals 3
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/lang/Throwable;
        }
    .end annotation

    .line 182
    invoke-static {}, Llocal/mio/os4camerabridge/SlowMotionRecorderBridge;->-$$Nest$sfgetactiveModule()Ljava/lang/reflect/Field;

    move-result-object v0

    const/4 v1, 0x0

    invoke-virtual {v0, v1}, Ljava/lang/reflect/Field;->getInt(Ljava/lang/Object;)I

    move-result v0

    const/16 v1, 0xac

    if-eq v0, v1, :cond_0

    return-void

    .line 183
    :cond_0
    iget-object p1, p1, Lde/robv/android/xposed/XC_MethodHook$MethodHookParam;->thisObject:Ljava/lang/Object;

    check-cast p1, Landroid/hardware/camera2/CaptureRequest$Builder;

    .line 184
    iget-object v0, p0, Llocal/mio/os4camerabridge/SlowMotionRecorderBridge$10;->val$cameraMode:Landroid/hardware/camera2/CaptureRequest$Key;

    const-string v1, "slowvideo_mode\u0000"

    sget-object v2, Ljava/nio/charset/StandardCharsets;->US_ASCII:Ljava/nio/charset/Charset;

    invoke-virtual {v1, v2}, Ljava/lang/String;->getBytes(Ljava/nio/charset/Charset;)[B

    move-result-object v1

    invoke-virtual {p1, v0, v1}, Landroid/hardware/camera2/CaptureRequest$Builder;->set(Landroid/hardware/camera2/CaptureRequest$Key;Ljava/lang/Object;)V

    .line 185
    iget-object v0, p0, Llocal/mio/os4camerabridge/SlowMotionRecorderBridge$10;->val$recordState:Landroid/hardware/camera2/CaptureRequest$Key;

    invoke-static {}, Llocal/mio/os4camerabridge/SlowMotionRecorderBridge;->-$$Nest$sfgetrecording()Z

    move-result v1

    invoke-static {v1}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v1

    invoke-virtual {p1, v0, v1}, Landroid/hardware/camera2/CaptureRequest$Builder;->set(Landroid/hardware/camera2/CaptureRequest$Key;Ljava/lang/Object;)V

    .line 186
    iget-object v0, p0, Llocal/mio/os4camerabridge/SlowMotionRecorderBridge$10;->val$eisState:Landroid/hardware/camera2/CaptureRequest$Key;

    invoke-static {}, Llocal/mio/os4camerabridge/SlowMotionRecorderBridge;->-$$Nest$sfgetrecording()Z

    move-result v1

    invoke-static {v1}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v1

    invoke-virtual {p1, v0, v1}, Landroid/hardware/camera2/CaptureRequest$Builder;->set(Landroid/hardware/camera2/CaptureRequest$Key;Ljava/lang/Object;)V

    .line 187
    iget-object v0, p0, Llocal/mio/os4camerabridge/SlowMotionRecorderBridge$10;->val$eos:Landroid/hardware/camera2/CaptureRequest$Key;

    const/4 v1, 0x0

    invoke-static {v1}, Ljava/lang/Byte;->valueOf(B)Ljava/lang/Byte;

    move-result-object v1

    invoke-virtual {p1, v0, v1}, Landroid/hardware/camera2/CaptureRequest$Builder;->set(Landroid/hardware/camera2/CaptureRequest$Key;Ljava/lang/Object;)V

    .line 188
    return-void
.end method
