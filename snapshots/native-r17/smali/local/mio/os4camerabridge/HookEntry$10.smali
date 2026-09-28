.class Llocal/mio/os4camerabridge/HookEntry$10;
.super Landroid/hardware/camera2/CameraCaptureSession$CaptureCallback;
.source "HookEntry.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Llocal/mio/os4camerabridge/HookEntry;->startCommonApsHandoffCapture(Landroid/hardware/camera2/CameraCaptureSession;Landroid/hardware/camera2/CaptureRequest;Landroid/hardware/camera2/CaptureRequest;Landroid/os/Handler;I)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic val$completed:[I

.field final synthetic val$handler:Landroid/os/Handler;

.field final synthetic val$handoffGeneration:I

.field final synthetic val$stillSeed:Landroid/hardware/camera2/CaptureRequest;

.field final synthetic val$transitioned:Ljava/util/concurrent/atomic/AtomicBoolean;


# direct methods
.method constructor <init>([IILjava/util/concurrent/atomic/AtomicBoolean;Landroid/os/Handler;Landroid/hardware/camera2/CaptureRequest;)V
    .locals 0

    .line 1834
    iput-object p1, p0, Llocal/mio/os4camerabridge/HookEntry$10;->val$completed:[I

    iput p2, p0, Llocal/mio/os4camerabridge/HookEntry$10;->val$handoffGeneration:I

    iput-object p3, p0, Llocal/mio/os4camerabridge/HookEntry$10;->val$transitioned:Ljava/util/concurrent/atomic/AtomicBoolean;

    iput-object p4, p0, Llocal/mio/os4camerabridge/HookEntry$10;->val$handler:Landroid/os/Handler;

    iput-object p5, p0, Llocal/mio/os4camerabridge/HookEntry$10;->val$stillSeed:Landroid/hardware/camera2/CaptureRequest;

    invoke-direct {p0}, Landroid/hardware/camera2/CameraCaptureSession$CaptureCallback;-><init>()V

    return-void
.end method

.method static synthetic lambda$onCaptureCompleted$0(ILandroid/hardware/camera2/CameraCaptureSession;Landroid/hardware/camera2/CaptureRequest;Landroid/os/Handler;)V
    .locals 1
    .param p0, "handoffGeneration"    # I
    .param p1, "captureSession"    # Landroid/hardware/camera2/CameraCaptureSession;
    .param p2, "stillSeed"    # Landroid/hardware/camera2/CaptureRequest;
    .param p3, "handler"    # Landroid/os/Handler;

    .line 1884
    invoke-static {}, Llocal/mio/os4camerabridge/HookEntry;->-$$Nest$sfgetcommonApsHandoffGeneration()I

    move-result v0

    if-ne p0, v0, :cond_1

    invoke-static {}, Llocal/mio/os4camerabridge/HookEntry;->-$$Nest$sfgetCOMMON_APS_HANDOFF_IN_FLIGHT()Ljava/util/concurrent/atomic/AtomicBoolean;

    move-result-object v0

    .line 1887
    invoke-virtual {v0}, Ljava/util/concurrent/atomic/AtomicBoolean;->get()Z

    move-result v0

    if-nez v0, :cond_0

    goto :goto_0

    .line 1895
    :cond_0
    invoke-static {p1, p2, p3, p0}, Llocal/mio/os4camerabridge/HookEntry;->-$$Nest$smsubmitCommonApsHandoffBurst(Landroid/hardware/camera2/CameraCaptureSession;Landroid/hardware/camera2/CaptureRequest;Landroid/os/Handler;I)V

    .line 1898
    return-void

    .line 1888
    :cond_1
    :goto_0
    return-void
.end method


# virtual methods
.method public onCaptureBufferLost(Landroid/hardware/camera2/CameraCaptureSession;Landroid/hardware/camera2/CaptureRequest;Landroid/view/Surface;J)V
    .locals 2
    .param p1, "captureSession"    # Landroid/hardware/camera2/CameraCaptureSession;
    .param p2, "request"    # Landroid/hardware/camera2/CaptureRequest;
    .param p3, "target"    # Landroid/view/Surface;
    .param p4, "frameNumber"    # J

    .line 1917
    const-string v0, "warmup"

    const/4 v1, -0x1

    invoke-static {v0, v1, p3, p4, p5}, Llocal/mio/os4camerabridge/HookEntry;->-$$Nest$smlogCommonApsBufferLost(Ljava/lang/String;ILandroid/view/Surface;J)Ljava/lang/String;

    .line 1922
    return-void
.end method

.method public onCaptureCompleted(Landroid/hardware/camera2/CameraCaptureSession;Landroid/hardware/camera2/CaptureRequest;Landroid/hardware/camera2/TotalCaptureResult;)V
    .locals 7
    .param p1, "captureSession"    # Landroid/hardware/camera2/CameraCaptureSession;
    .param p2, "request"    # Landroid/hardware/camera2/CaptureRequest;
    .param p3, "result"    # Landroid/hardware/camera2/TotalCaptureResult;

    .line 1852
    iget v0, p0, Llocal/mio/os4camerabridge/HookEntry$10;->val$handoffGeneration:I

    invoke-static {}, Llocal/mio/os4camerabridge/HookEntry;->-$$Nest$sfgetcommonApsHandoffGeneration()I

    move-result v1

    if-ne v0, v1, :cond_5

    invoke-static {}, Llocal/mio/os4camerabridge/HookEntry;->-$$Nest$sfgetCOMMON_APS_HANDOFF_IN_FLIGHT()Ljava/util/concurrent/atomic/AtomicBoolean;

    move-result-object v0

    .line 1854
    invoke-virtual {v0}, Ljava/util/concurrent/atomic/AtomicBoolean;->get()Z

    move-result v0

    if-eqz v0, :cond_5

    iget-object v0, p0, Llocal/mio/os4camerabridge/HookEntry$10;->val$transitioned:Ljava/util/concurrent/atomic/AtomicBoolean;

    .line 1855
    invoke-virtual {v0}, Ljava/util/concurrent/atomic/AtomicBoolean;->get()Z

    move-result v0

    if-eqz v0, :cond_0

    goto/16 :goto_1

    .line 1858
    :cond_0
    invoke-static {p3}, Llocal/mio/os4camerabridge/HookEntry;->-$$Nest$sfputcommonApsDecisionMetadata(Landroid/hardware/camera2/TotalCaptureResult;)V

    .line 1860
    invoke-static {}, Landroid/os/SystemClock;->elapsedRealtimeNanos()J

    move-result-wide v0

    invoke-static {v0, v1}, Llocal/mio/os4camerabridge/HookEntry;->-$$Nest$sfputcommonApsDecisionMetadataNanos(J)V

    .line 1861
    iget-object v0, p0, Llocal/mio/os4camerabridge/HookEntry$10;->val$completed:[I

    const/4 v1, 0x0

    aget v2, v0, v1

    const/4 v3, 0x1

    add-int/2addr v2, v3

    aput v2, v0, v1

    .line 1862
    .local v2, "count":I
    const/16 v0, 0x8

    if-eq v2, v3, :cond_1

    if-ne v2, v0, :cond_2

    .line 1865
    :cond_1
    new-instance v4, Ljava/lang/StringBuilder;

    invoke-direct {v4}, Ljava/lang/StringBuilder;-><init>()V

    const-string v5, "[CommonAPS] warmup metadata="

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4, v2}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v4

    const-string v5, "/"

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4, v0}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v4

    const-string v5, " frame="

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    .line 1869
    invoke-virtual {p3}, Landroid/hardware/camera2/TotalCaptureResult;->getFrameNumber()J

    move-result-wide v5

    invoke-virtual {v4, v5, v6}, Ljava/lang/StringBuilder;->append(J)Ljava/lang/StringBuilder;

    move-result-object v4

    const-string v5, " iso="

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    sget-object v5, Landroid/hardware/camera2/CaptureResult;->SENSOR_SENSITIVITY:Landroid/hardware/camera2/CaptureResult$Key;

    .line 1870
    invoke-virtual {p3, v5}, Landroid/hardware/camera2/TotalCaptureResult;->get(Landroid/hardware/camera2/CaptureResult$Key;)Ljava/lang/Object;

    move-result-object v5

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v4

    const-string v5, " exposureNs="

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    sget-object v5, Landroid/hardware/camera2/CaptureResult;->SENSOR_EXPOSURE_TIME:Landroid/hardware/camera2/CaptureResult$Key;

    .line 1872
    invoke-virtual {p3, v5}, Landroid/hardware/camera2/TotalCaptureResult;->get(Landroid/hardware/camera2/CaptureResult$Key;)Ljava/lang/Object;

    move-result-object v5

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v4

    const-string v5, " "

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    .line 1875
    invoke-static {}, Llocal/mio/os4camerabridge/HookEntry;->-$$Nest$smcommonApsMemorySnapshot()Ljava/lang/String;

    move-result-object v5

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v4

    .line 1865
    invoke-static {v4}, Llocal/mio/os4camerabridge/HookEntry;->-$$Nest$smlog(Ljava/lang/String;)V

    .line 1877
    :cond_2
    if-lt v2, v0, :cond_4

    iget-object v0, p0, Llocal/mio/os4camerabridge/HookEntry$10;->val$transitioned:Ljava/util/concurrent/atomic/AtomicBoolean;

    .line 1879
    invoke-virtual {v0, v1, v3}, Ljava/util/concurrent/atomic/AtomicBoolean;->compareAndSet(ZZ)Z

    move-result v0

    if-nez v0, :cond_3

    goto :goto_0

    .line 1883
    :cond_3
    iget-object v0, p0, Llocal/mio/os4camerabridge/HookEntry$10;->val$handler:Landroid/os/Handler;

    iget v1, p0, Llocal/mio/os4camerabridge/HookEntry$10;->val$handoffGeneration:I

    iget-object v3, p0, Llocal/mio/os4camerabridge/HookEntry$10;->val$stillSeed:Landroid/hardware/camera2/CaptureRequest;

    iget-object v4, p0, Llocal/mio/os4camerabridge/HookEntry$10;->val$handler:Landroid/os/Handler;

    new-instance v5, Llocal/mio/os4camerabridge/HookEntry$10$$ExternalSyntheticLambda0;

    invoke-direct {v5, v1, p1, v3, v4}, Llocal/mio/os4camerabridge/HookEntry$10$$ExternalSyntheticLambda0;-><init>(ILandroid/hardware/camera2/CameraCaptureSession;Landroid/hardware/camera2/CaptureRequest;Landroid/os/Handler;)V

    invoke-virtual {v0, v5}, Landroid/os/Handler;->post(Ljava/lang/Runnable;)Z

    .line 1899
    return-void

    .line 1881
    :cond_4
    :goto_0
    return-void

    .line 1856
    .end local v2    # "count":I
    :cond_5
    :goto_1
    return-void
.end method

.method public onCaptureFailed(Landroid/hardware/camera2/CameraCaptureSession;Landroid/hardware/camera2/CaptureRequest;Landroid/hardware/camera2/CaptureFailure;)V
    .locals 3
    .param p1, "captureSession"    # Landroid/hardware/camera2/CameraCaptureSession;
    .param p2, "request"    # Landroid/hardware/camera2/CaptureRequest;
    .param p3, "failure"    # Landroid/hardware/camera2/CaptureFailure;

    .line 1906
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "[CommonAPS] warmup request failed frame="

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    .line 1907
    invoke-virtual {p3}, Landroid/hardware/camera2/CaptureFailure;->getFrameNumber()J

    move-result-wide v1

    invoke-virtual {v0, v1, v2}, Ljava/lang/StringBuilder;->append(J)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, " reason="

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    .line 1908
    invoke-virtual {p3}, Landroid/hardware/camera2/CaptureFailure;->getReason()I

    move-result v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, " "

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    .line 1909
    invoke-static {}, Llocal/mio/os4camerabridge/HookEntry;->-$$Nest$smcommonApsMemorySnapshot()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    .line 1906
    invoke-static {v0}, Llocal/mio/os4camerabridge/HookEntry;->-$$Nest$smlog(Ljava/lang/String;)V

    .line 1910
    return-void
.end method

.method public onCaptureStarted(Landroid/hardware/camera2/CameraCaptureSession;Landroid/hardware/camera2/CaptureRequest;JJ)V
    .locals 2
    .param p1, "captureSession"    # Landroid/hardware/camera2/CameraCaptureSession;
    .param p2, "request"    # Landroid/hardware/camera2/CaptureRequest;
    .param p3, "timestamp"    # J
    .param p5, "frameNumber"    # J

    .line 1840
    iget-object v0, p0, Llocal/mio/os4camerabridge/HookEntry$10;->val$completed:[I

    const/4 v1, 0x0

    aget v0, v0, v1

    if-nez v0, :cond_0

    .line 1841
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "[CommonAPS] warmup first request started frame="

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, p5, p6}, Ljava/lang/StringBuilder;->append(J)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, " sensorTs="

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, p3, p4}, Ljava/lang/StringBuilder;->append(J)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Llocal/mio/os4camerabridge/HookEntry;->-$$Nest$smlog(Ljava/lang/String;)V

    .line 1845
    :cond_0
    return-void
.end method
