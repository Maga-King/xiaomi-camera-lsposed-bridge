.class Llocal/mio/os4camerabridge/HookEntry$11;
.super Landroid/hardware/camera2/CameraCaptureSession$CaptureCallback;
.source "HookEntry.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Llocal/mio/os4camerabridge/HookEntry;->wrapCommonApsBurstCallback(Landroid/hardware/camera2/CameraCaptureSession$CaptureCallback;Landroid/hardware/camera2/CaptureRequest;Ljava/util/List;Ljava/util/concurrent/atomic/AtomicInteger;Z)Landroid/hardware/camera2/CameraCaptureSession$CaptureCallback;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field private final clientSequenceDelivered:Ljava/util/concurrent/atomic/AtomicBoolean;

.field final synthetic val$baseRequest:Landroid/hardware/camera2/CaptureRequest;

.field final synthetic val$clientSequence:Ljava/util/concurrent/atomic/AtomicInteger;

.field final synthetic val$completeClientOnBase:Z

.field final synthetic val$indexes:Ljava/util/Map;

.field final synthetic val$original:Landroid/hardware/camera2/CameraCaptureSession$CaptureCallback;


# direct methods
.method constructor <init>(Landroid/hardware/camera2/CaptureRequest;Ljava/util/Map;Landroid/hardware/camera2/CameraCaptureSession$CaptureCallback;ZLjava/util/concurrent/atomic/AtomicInteger;)V
    .locals 0

    .line 3743
    iput-object p1, p0, Llocal/mio/os4camerabridge/HookEntry$11;->val$baseRequest:Landroid/hardware/camera2/CaptureRequest;

    iput-object p2, p0, Llocal/mio/os4camerabridge/HookEntry$11;->val$indexes:Ljava/util/Map;

    iput-object p3, p0, Llocal/mio/os4camerabridge/HookEntry$11;->val$original:Landroid/hardware/camera2/CameraCaptureSession$CaptureCallback;

    iput-boolean p4, p0, Llocal/mio/os4camerabridge/HookEntry$11;->val$completeClientOnBase:Z

    iput-object p5, p0, Llocal/mio/os4camerabridge/HookEntry$11;->val$clientSequence:Ljava/util/concurrent/atomic/AtomicInteger;

    invoke-direct {p0}, Landroid/hardware/camera2/CameraCaptureSession$CaptureCallback;-><init>()V

    .line 3744
    new-instance p1, Ljava/util/concurrent/atomic/AtomicBoolean;

    const/4 p2, 0x0

    invoke-direct {p1, p2}, Ljava/util/concurrent/atomic/AtomicBoolean;-><init>(Z)V

    iput-object p1, p0, Llocal/mio/os4camerabridge/HookEntry$11;->clientSequenceDelivered:Ljava/util/concurrent/atomic/AtomicBoolean;

    return-void
.end method

.method private index(Landroid/hardware/camera2/CaptureRequest;)I
    .locals 2
    .param p1, "request"    # Landroid/hardware/camera2/CaptureRequest;

    .line 3752
    iget-object v0, p0, Llocal/mio/os4camerabridge/HookEntry$11;->val$indexes:Ljava/util/Map;

    invoke-interface {v0, p1}, Ljava/util/Map;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/lang/Integer;

    .line 3753
    .local v0, "value":Ljava/lang/Integer;
    if-nez v0, :cond_0

    const/4 v1, -0x1

    goto :goto_0

    :cond_0
    invoke-virtual {v0}, Ljava/lang/Integer;->intValue()I

    move-result v1

    :goto_0
    return v1
.end method

.method private isBase(Landroid/hardware/camera2/CaptureRequest;)Z
    .locals 1
    .param p1, "request"    # Landroid/hardware/camera2/CaptureRequest;

    .line 3748
    iget-object v0, p0, Llocal/mio/os4camerabridge/HookEntry$11;->val$baseRequest:Landroid/hardware/camera2/CaptureRequest;

    if-ne p1, v0, :cond_0

    const/4 v0, 0x1

    goto :goto_0

    :cond_0
    const/4 v0, 0x0

    :goto_0
    return v0
.end method


# virtual methods
.method public onCaptureBufferLost(Landroid/hardware/camera2/CameraCaptureSession;Landroid/hardware/camera2/CaptureRequest;Landroid/view/Surface;J)V
    .locals 10
    .param p1, "session"    # Landroid/hardware/camera2/CameraCaptureSession;
    .param p2, "request"    # Landroid/hardware/camera2/CaptureRequest;
    .param p3, "target"    # Landroid/view/Surface;
    .param p4, "frameNumber"    # J

    .line 3866
    invoke-direct {p0, p2}, Llocal/mio/os4camerabridge/HookEntry$11;->index(Landroid/hardware/camera2/CaptureRequest;)I

    move-result v0

    .line 3867
    .local v0, "requestIndex":I
    const-string v1, "still"

    invoke-static {v1, v0, p3, p4, p5}, Llocal/mio/os4camerabridge/HookEntry;->-$$Nest$smlogCommonApsBufferLost(Ljava/lang/String;ILandroid/view/Surface;J)Ljava/lang/String;

    move-result-object v1

    .line 3873
    .local v1, "role":Ljava/lang/String;
    const-string v2, "main-raw10"

    invoke-virtual {v2, v1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v2

    const/4 v3, 0x1

    if-nez v2, :cond_1

    .line 3874
    const-string v2, "dol-raw10"

    invoke-virtual {v2, v1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v2

    if-nez v2, :cond_1

    .line 3875
    const-string v2, "capture-meta"

    invoke-virtual {v2, v1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v2

    if-eqz v2, :cond_0

    goto :goto_0

    :cond_0
    const/4 v2, 0x0

    goto :goto_1

    :cond_1
    :goto_0
    move v2, v3

    .line 3876
    .local v2, "fatal":Z
    :goto_1
    if-eqz v2, :cond_2

    .line 3877
    new-instance v4, Ljava/lang/StringBuilder;

    invoke-direct {v4}, Ljava/lang/StringBuilder;-><init>()V

    const-string v5, "sidecar-buffer-lost-"

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    const-string v5, "-"

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4, p4, p5}, Ljava/lang/StringBuilder;->append(J)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v4

    invoke-static {v4, v3}, Llocal/mio/os4camerabridge/HookEntry;->-$$Nest$smabortCommonApsCapture(Ljava/lang/String;Z)V

    .line 3879
    const-string v3, "capture-buffer-lost"

    invoke-static {v3}, Llocal/mio/os4camerabridge/HookEntry;->-$$Nest$smrestoreActiveHandoff(Ljava/lang/String;)V

    goto :goto_2

    .line 3881
    :cond_2
    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    const-string v4, "[CommonAPS] auxiliary buffer loss tolerated role="

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    const-string v4, " frame="

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3, p4, p5}, Ljava/lang/StringBuilder;->append(J)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    invoke-static {v3}, Llocal/mio/os4camerabridge/HookEntry;->-$$Nest$smlog(Ljava/lang/String;)V

    .line 3884
    :goto_2
    iget-object v3, p0, Llocal/mio/os4camerabridge/HookEntry$11;->val$original:Landroid/hardware/camera2/CameraCaptureSession$CaptureCallback;

    if-eqz v3, :cond_3

    invoke-direct {p0, p2}, Llocal/mio/os4camerabridge/HookEntry$11;->isBase(Landroid/hardware/camera2/CaptureRequest;)Z

    move-result v3

    if-eqz v3, :cond_3

    .line 3885
    iget-object v4, p0, Llocal/mio/os4camerabridge/HookEntry$11;->val$original:Landroid/hardware/camera2/CameraCaptureSession$CaptureCallback;

    move-object v5, p1

    move-object v6, p2

    move-object v7, p3

    move-wide v8, p4

    .end local p1    # "session":Landroid/hardware/camera2/CameraCaptureSession;
    .end local p2    # "request":Landroid/hardware/camera2/CaptureRequest;
    .end local p3    # "target":Landroid/view/Surface;
    .end local p4    # "frameNumber":J
    .local v5, "session":Landroid/hardware/camera2/CameraCaptureSession;
    .local v6, "request":Landroid/hardware/camera2/CaptureRequest;
    .local v7, "target":Landroid/view/Surface;
    .local v8, "frameNumber":J
    invoke-virtual/range {v4 .. v9}, Landroid/hardware/camera2/CameraCaptureSession$CaptureCallback;->onCaptureBufferLost(Landroid/hardware/camera2/CameraCaptureSession;Landroid/hardware/camera2/CaptureRequest;Landroid/view/Surface;J)V

    goto :goto_3

    .line 3884
    .end local v5    # "session":Landroid/hardware/camera2/CameraCaptureSession;
    .end local v6    # "request":Landroid/hardware/camera2/CaptureRequest;
    .end local v7    # "target":Landroid/view/Surface;
    .end local v8    # "frameNumber":J
    .restart local p1    # "session":Landroid/hardware/camera2/CameraCaptureSession;
    .restart local p2    # "request":Landroid/hardware/camera2/CaptureRequest;
    .restart local p3    # "target":Landroid/view/Surface;
    .restart local p4    # "frameNumber":J
    :cond_3
    move-object v5, p1

    move-object v6, p2

    move-object v7, p3

    move-wide v8, p4

    .line 3888
    .end local p1    # "session":Landroid/hardware/camera2/CameraCaptureSession;
    .end local p2    # "request":Landroid/hardware/camera2/CaptureRequest;
    .end local p3    # "target":Landroid/view/Surface;
    .end local p4    # "frameNumber":J
    .restart local v5    # "session":Landroid/hardware/camera2/CameraCaptureSession;
    .restart local v6    # "request":Landroid/hardware/camera2/CaptureRequest;
    .restart local v7    # "target":Landroid/view/Surface;
    .restart local v8    # "frameNumber":J
    :goto_3
    return-void
.end method

.method public onCaptureCompleted(Landroid/hardware/camera2/CameraCaptureSession;Landroid/hardware/camera2/CaptureRequest;Landroid/hardware/camera2/TotalCaptureResult;)V
    .locals 5
    .param p1, "session"    # Landroid/hardware/camera2/CameraCaptureSession;
    .param p2, "request"    # Landroid/hardware/camera2/CaptureRequest;
    .param p3, "result"    # Landroid/hardware/camera2/TotalCaptureResult;

    .line 3802
    invoke-direct {p0, p2}, Llocal/mio/os4camerabridge/HookEntry$11;->index(Landroid/hardware/camera2/CaptureRequest;)I

    move-result v0

    .line 3803
    .local v0, "frameIndex":I
    invoke-static {p3, v0}, Llocal/mio/os4camerabridge/HookEntry;->-$$Nest$smrecordCommonApsCaptureResult(Landroid/hardware/camera2/TotalCaptureResult;I)V

    .line 3804
    iget-object v1, p0, Llocal/mio/os4camerabridge/HookEntry$11;->val$original:Landroid/hardware/camera2/CameraCaptureSession$CaptureCallback;

    if-eqz v1, :cond_0

    invoke-direct {p0, p2}, Llocal/mio/os4camerabridge/HookEntry$11;->isBase(Landroid/hardware/camera2/CaptureRequest;)Z

    move-result v1

    if-eqz v1, :cond_0

    .line 3805
    iget-object v1, p0, Llocal/mio/os4camerabridge/HookEntry$11;->val$original:Landroid/hardware/camera2/CameraCaptureSession$CaptureCallback;

    invoke-virtual {v1, p1, p2, p3}, Landroid/hardware/camera2/CameraCaptureSession$CaptureCallback;->onCaptureCompleted(Landroid/hardware/camera2/CameraCaptureSession;Landroid/hardware/camera2/CaptureRequest;Landroid/hardware/camera2/TotalCaptureResult;)V

    .line 3809
    iget-boolean v1, p0, Llocal/mio/os4camerabridge/HookEntry$11;->val$completeClientOnBase:Z

    if-eqz v1, :cond_0

    iget-object v1, p0, Llocal/mio/os4camerabridge/HookEntry$11;->val$clientSequence:Ljava/util/concurrent/atomic/AtomicInteger;

    if-eqz v1, :cond_0

    .line 3810
    iget-object v1, p0, Llocal/mio/os4camerabridge/HookEntry$11;->val$clientSequence:Ljava/util/concurrent/atomic/AtomicInteger;

    invoke-virtual {v1}, Ljava/util/concurrent/atomic/AtomicInteger;->get()I

    move-result v1

    .line 3811
    .local v1, "sequenceId":I
    if-ltz v1, :cond_0

    iget-object v2, p0, Llocal/mio/os4camerabridge/HookEntry$11;->clientSequenceDelivered:Ljava/util/concurrent/atomic/AtomicBoolean;

    .line 3813
    const/4 v3, 0x0

    const/4 v4, 0x1

    invoke-virtual {v2, v3, v4}, Ljava/util/concurrent/atomic/AtomicBoolean;->compareAndSet(ZZ)Z

    move-result v2

    if-eqz v2, :cond_0

    .line 3814
    iget-object v2, p0, Llocal/mio/os4camerabridge/HookEntry$11;->val$original:Landroid/hardware/camera2/CameraCaptureSession$CaptureCallback;

    .line 3815
    invoke-virtual {p3}, Landroid/hardware/camera2/TotalCaptureResult;->getFrameNumber()J

    move-result-wide v3

    .line 3814
    invoke-virtual {v2, p1, v1, v3, v4}, Landroid/hardware/camera2/CameraCaptureSession$CaptureCallback;->onCaptureSequenceCompleted(Landroid/hardware/camera2/CameraCaptureSession;IJ)V

    .line 3816
    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "[UnifiedAPS] Xiaomi client sequence released on base result id="

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, v1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v2

    const-string v3, " frame="

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    .line 3818
    invoke-virtual {p3}, Landroid/hardware/camera2/TotalCaptureResult;->getFrameNumber()J

    move-result-wide v3

    invoke-virtual {v2, v3, v4}, Ljava/lang/StringBuilder;->append(J)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    .line 3816
    invoke-static {v2}, Llocal/mio/os4camerabridge/HookEntry;->-$$Nest$smlog(Ljava/lang/String;)V

    .line 3822
    .end local v1    # "sequenceId":I
    :cond_0
    return-void
.end method

.method public onCaptureFailed(Landroid/hardware/camera2/CameraCaptureSession;Landroid/hardware/camera2/CaptureRequest;Landroid/hardware/camera2/CaptureFailure;)V
    .locals 2
    .param p1, "session"    # Landroid/hardware/camera2/CameraCaptureSession;
    .param p2, "request"    # Landroid/hardware/camera2/CaptureRequest;
    .param p3, "failure"    # Landroid/hardware/camera2/CaptureFailure;

    .line 3827
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "request-"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-direct {p0, p2}, Llocal/mio/os4camerabridge/HookEntry$11;->index(Landroid/hardware/camera2/CaptureRequest;)I

    move-result v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, "-failed-"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    .line 3828
    invoke-virtual {p3}, Landroid/hardware/camera2/CaptureFailure;->getReason()I

    move-result v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    .line 3827
    const/4 v1, 0x1

    invoke-static {v0, v1}, Llocal/mio/os4camerabridge/HookEntry;->-$$Nest$smabortCommonApsCapture(Ljava/lang/String;Z)V

    .line 3829
    const-string v0, "capture-request-failed"

    invoke-static {v0}, Llocal/mio/os4camerabridge/HookEntry;->-$$Nest$smrestoreActiveHandoff(Ljava/lang/String;)V

    .line 3830
    iget-object v0, p0, Llocal/mio/os4camerabridge/HookEntry$11;->val$original:Landroid/hardware/camera2/CameraCaptureSession$CaptureCallback;

    if-eqz v0, :cond_0

    invoke-direct {p0, p2}, Llocal/mio/os4camerabridge/HookEntry$11;->isBase(Landroid/hardware/camera2/CaptureRequest;)Z

    move-result v0

    if-eqz v0, :cond_0

    .line 3831
    iget-object v0, p0, Llocal/mio/os4camerabridge/HookEntry$11;->val$original:Landroid/hardware/camera2/CameraCaptureSession$CaptureCallback;

    invoke-virtual {v0, p1, p2, p3}, Landroid/hardware/camera2/CameraCaptureSession$CaptureCallback;->onCaptureFailed(Landroid/hardware/camera2/CameraCaptureSession;Landroid/hardware/camera2/CaptureRequest;Landroid/hardware/camera2/CaptureFailure;)V

    .line 3833
    :cond_0
    return-void
.end method

.method public onCaptureProgressed(Landroid/hardware/camera2/CameraCaptureSession;Landroid/hardware/camera2/CaptureRequest;Landroid/hardware/camera2/CaptureResult;)V
    .locals 1
    .param p1, "session"    # Landroid/hardware/camera2/CameraCaptureSession;
    .param p2, "request"    # Landroid/hardware/camera2/CaptureRequest;
    .param p3, "partialResult"    # Landroid/hardware/camera2/CaptureResult;

    .line 3793
    iget-object v0, p0, Llocal/mio/os4camerabridge/HookEntry$11;->val$original:Landroid/hardware/camera2/CameraCaptureSession$CaptureCallback;

    if-eqz v0, :cond_0

    invoke-direct {p0, p2}, Llocal/mio/os4camerabridge/HookEntry$11;->isBase(Landroid/hardware/camera2/CaptureRequest;)Z

    move-result v0

    if-eqz v0, :cond_0

    .line 3794
    iget-object v0, p0, Llocal/mio/os4camerabridge/HookEntry$11;->val$original:Landroid/hardware/camera2/CameraCaptureSession$CaptureCallback;

    invoke-virtual {v0, p1, p2, p3}, Landroid/hardware/camera2/CameraCaptureSession$CaptureCallback;->onCaptureProgressed(Landroid/hardware/camera2/CameraCaptureSession;Landroid/hardware/camera2/CaptureRequest;Landroid/hardware/camera2/CaptureResult;)V

    .line 3797
    :cond_0
    return-void
.end method

.method public onCaptureSequenceAborted(Landroid/hardware/camera2/CameraCaptureSession;I)V
    .locals 3
    .param p1, "session"    # Landroid/hardware/camera2/CameraCaptureSession;
    .param p2, "sequenceId"    # I

    .line 3852
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "sequence-aborted-"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, p2}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    const/4 v1, 0x1

    invoke-static {v0, v1}, Llocal/mio/os4camerabridge/HookEntry;->-$$Nest$smabortCommonApsCapture(Ljava/lang/String;Z)V

    .line 3854
    const-string v0, "capture-sequence-aborted"

    invoke-static {v0}, Llocal/mio/os4camerabridge/HookEntry;->-$$Nest$smrestoreActiveHandoff(Ljava/lang/String;)V

    .line 3855
    iget-object v0, p0, Llocal/mio/os4camerabridge/HookEntry$11;->val$original:Landroid/hardware/camera2/CameraCaptureSession$CaptureCallback;

    if-eqz v0, :cond_1

    iget-boolean v0, p0, Llocal/mio/os4camerabridge/HookEntry$11;->val$completeClientOnBase:Z

    if-eqz v0, :cond_0

    iget-object v0, p0, Llocal/mio/os4camerabridge/HookEntry$11;->clientSequenceDelivered:Ljava/util/concurrent/atomic/AtomicBoolean;

    .line 3857
    const/4 v2, 0x0

    invoke-virtual {v0, v2, v1}, Ljava/util/concurrent/atomic/AtomicBoolean;->compareAndSet(ZZ)Z

    move-result v0

    if-eqz v0, :cond_1

    .line 3858
    :cond_0
    iget-object v0, p0, Llocal/mio/os4camerabridge/HookEntry$11;->val$original:Landroid/hardware/camera2/CameraCaptureSession$CaptureCallback;

    invoke-virtual {v0, p1, p2}, Landroid/hardware/camera2/CameraCaptureSession$CaptureCallback;->onCaptureSequenceAborted(Landroid/hardware/camera2/CameraCaptureSession;I)V

    .line 3860
    :cond_1
    return-void
.end method

.method public onCaptureSequenceCompleted(Landroid/hardware/camera2/CameraCaptureSession;IJ)V
    .locals 3
    .param p1, "session"    # Landroid/hardware/camera2/CameraCaptureSession;
    .param p2, "sequenceId"    # I
    .param p3, "frameNumber"    # J

    .line 3839
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "[CommonAPS] Camera2 sequence complete id="

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, p2}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, " lastFrame="

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, p3, p4}, Ljava/lang/StringBuilder;->append(J)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Llocal/mio/os4camerabridge/HookEntry;->-$$Nest$smlog(Ljava/lang/String;)V

    .line 3841
    iget-object v0, p0, Llocal/mio/os4camerabridge/HookEntry$11;->val$original:Landroid/hardware/camera2/CameraCaptureSession$CaptureCallback;

    if-eqz v0, :cond_1

    iget-boolean v0, p0, Llocal/mio/os4camerabridge/HookEntry$11;->val$completeClientOnBase:Z

    if-eqz v0, :cond_0

    iget-object v0, p0, Llocal/mio/os4camerabridge/HookEntry$11;->clientSequenceDelivered:Ljava/util/concurrent/atomic/AtomicBoolean;

    .line 3843
    const/4 v1, 0x0

    const/4 v2, 0x1

    invoke-virtual {v0, v1, v2}, Ljava/util/concurrent/atomic/AtomicBoolean;->compareAndSet(ZZ)Z

    move-result v0

    if-eqz v0, :cond_1

    .line 3844
    :cond_0
    iget-object v0, p0, Llocal/mio/os4camerabridge/HookEntry$11;->val$original:Landroid/hardware/camera2/CameraCaptureSession$CaptureCallback;

    invoke-virtual {v0, p1, p2, p3, p4}, Landroid/hardware/camera2/CameraCaptureSession$CaptureCallback;->onCaptureSequenceCompleted(Landroid/hardware/camera2/CameraCaptureSession;IJ)V

    .line 3847
    :cond_1
    return-void
.end method

.method public onCaptureStarted(Landroid/hardware/camera2/CameraCaptureSession;Landroid/hardware/camera2/CaptureRequest;JJ)V
    .locals 9
    .param p1, "session"    # Landroid/hardware/camera2/CameraCaptureSession;
    .param p2, "request"    # Landroid/hardware/camera2/CaptureRequest;
    .param p3, "timestamp"    # J
    .param p5, "frameNumber"    # J

    .line 3760
    invoke-direct {p0, p2}, Llocal/mio/os4camerabridge/HookEntry$11;->index(Landroid/hardware/camera2/CaptureRequest;)I

    move-result v1

    .line 3761
    .local v1, "frameIndex":I
    const/4 v0, 0x1

    if-ne v1, v0, :cond_2

    const-wide/16 v2, 0x0

    cmp-long v0, p3, v2

    if-lez v0, :cond_2

    .line 3762
    invoke-static {}, Llocal/mio/os4camerabridge/HookEntry;->-$$Nest$sfgetCOMMON_APS_SHUTTER_LOCK()Ljava/lang/Object;

    move-result-object v4

    monitor-enter v4

    .line 3763
    :try_start_0
    invoke-static {}, Llocal/mio/os4camerabridge/HookEntry;->-$$Nest$sfgetCOMMON_APS_SHUTTER_ARMED()Ljava/util/concurrent/atomic/AtomicBoolean;

    move-result-object v0

    invoke-virtual {v0}, Ljava/util/concurrent/atomic/AtomicBoolean;->get()Z

    move-result v0

    if-eqz v0, :cond_0

    invoke-static {}, Llocal/mio/os4camerabridge/HookEntry;->-$$Nest$sfgetCOMMON_APS_SHUTTER_HANDOFF_STARTED()Ljava/util/concurrent/atomic/AtomicBoolean;

    move-result-object v0

    .line 3764
    invoke-virtual {v0}, Ljava/util/concurrent/atomic/AtomicBoolean;->get()Z

    move-result v0

    if-eqz v0, :cond_0

    invoke-static {}, Llocal/mio/os4camerabridge/HookEntry;->-$$Nest$sfgetcommonApsShutterTimestamp()J

    move-result-wide v5

    cmp-long v0, v5, v2

    if-gtz v0, :cond_0

    .line 3766
    invoke-static {p3, p4}, Llocal/mio/os4camerabridge/HookEntry;->-$$Nest$sfputcommonApsShutterTimestamp(J)V

    .line 3767
    invoke-static {p2}, Llocal/mio/os4camerabridge/HookEntry;->-$$Nest$sfputcommonApsShutterRequest(Landroid/hardware/camera2/CaptureRequest;)V

    .line 3768
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v5, "[UnifiedAPS] DIRECT shutter sensorTs="

    invoke-virtual {v0, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, p3, p4}, Ljava/lang/StringBuilder;->append(J)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v5, " frame="

    invoke-virtual {v0, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, p5, p6}, Ljava/lang/StringBuilder;->append(J)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Llocal/mio/os4camerabridge/HookEntry;->-$$Nest$smlog(Ljava/lang/String;)V

    .line 3771
    :cond_0
    monitor-exit v4
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_1

    .line 3772
    invoke-static {}, Llocal/mio/os4camerabridge/HookEntry;->-$$Nest$sfgetCOMMON_APS_LOCK()Ljava/lang/Object;

    move-result-object v5

    monitor-enter v5

    .line 3773
    :try_start_1
    invoke-static {}, Llocal/mio/os4camerabridge/HookEntry;->-$$Nest$sfgetcommonApsCaptureInFlight()Z

    move-result v0

    if-eqz v0, :cond_1

    invoke-static {}, Llocal/mio/os4camerabridge/HookEntry;->-$$Nest$sfgetcommonApsIdentity()J

    move-result-wide v6

    cmp-long v0, v6, v2

    if-gez v0, :cond_1

    .line 3775
    invoke-static {p3, p4}, Llocal/mio/os4camerabridge/HookEntry;->-$$Nest$sfputcommonApsIdentity(J)V

    .line 3776
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "[CommonAPS] merge identity locked to first sensor timestamp="

    invoke-virtual {v0, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, p3, p4}, Ljava/lang/StringBuilder;->append(J)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Llocal/mio/os4camerabridge/HookEntry;->-$$Nest$smlog(Ljava/lang/String;)V

    .line 3779
    :cond_1
    monitor-exit v5

    goto :goto_0

    :catchall_0
    move-exception v0

    monitor-exit v5
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    throw v0

    .line 3771
    :catchall_1
    move-exception v0

    :try_start_2
    monitor-exit v4
    :try_end_2
    .catchall {:try_start_2 .. :try_end_2} :catchall_1

    throw v0

    .line 3781
    :cond_2
    :goto_0
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "[CommonAPS] request started index="

    invoke-virtual {v0, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v2, " sensorTs="

    invoke-virtual {v0, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, p3, p4}, Ljava/lang/StringBuilder;->append(J)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v2, " frame="

    invoke-virtual {v0, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, p5, p6}, Ljava/lang/StringBuilder;->append(J)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Llocal/mio/os4camerabridge/HookEntry;->-$$Nest$smlog(Ljava/lang/String;)V

    .line 3784
    iget-object v0, p0, Llocal/mio/os4camerabridge/HookEntry$11;->val$original:Landroid/hardware/camera2/CameraCaptureSession$CaptureCallback;

    if-eqz v0, :cond_3

    invoke-direct {p0, p2}, Llocal/mio/os4camerabridge/HookEntry$11;->isBase(Landroid/hardware/camera2/CaptureRequest;)Z

    move-result v0

    if-eqz v0, :cond_3

    .line 3785
    iget-object v2, p0, Llocal/mio/os4camerabridge/HookEntry$11;->val$original:Landroid/hardware/camera2/CameraCaptureSession$CaptureCallback;

    move-object v3, p1

    move-object v4, p2

    move-wide v5, p3

    move-wide v7, p5

    .end local p1    # "session":Landroid/hardware/camera2/CameraCaptureSession;
    .end local p2    # "request":Landroid/hardware/camera2/CaptureRequest;
    .end local p3    # "timestamp":J
    .end local p5    # "frameNumber":J
    .local v3, "session":Landroid/hardware/camera2/CameraCaptureSession;
    .local v4, "request":Landroid/hardware/camera2/CaptureRequest;
    .local v5, "timestamp":J
    .local v7, "frameNumber":J
    invoke-virtual/range {v2 .. v8}, Landroid/hardware/camera2/CameraCaptureSession$CaptureCallback;->onCaptureStarted(Landroid/hardware/camera2/CameraCaptureSession;Landroid/hardware/camera2/CaptureRequest;JJ)V

    goto :goto_1

    .line 3784
    .end local v3    # "session":Landroid/hardware/camera2/CameraCaptureSession;
    .end local v4    # "request":Landroid/hardware/camera2/CaptureRequest;
    .end local v5    # "timestamp":J
    .end local v7    # "frameNumber":J
    .restart local p1    # "session":Landroid/hardware/camera2/CameraCaptureSession;
    .restart local p2    # "request":Landroid/hardware/camera2/CaptureRequest;
    .restart local p3    # "timestamp":J
    .restart local p5    # "frameNumber":J
    :cond_3
    move-object v3, p1

    move-object v4, p2

    move-wide v5, p3

    move-wide v7, p5

    .line 3788
    .end local p1    # "session":Landroid/hardware/camera2/CameraCaptureSession;
    .end local p2    # "request":Landroid/hardware/camera2/CaptureRequest;
    .end local p3    # "timestamp":J
    .end local p5    # "frameNumber":J
    .restart local v3    # "session":Landroid/hardware/camera2/CameraCaptureSession;
    .restart local v4    # "request":Landroid/hardware/camera2/CaptureRequest;
    .restart local v5    # "timestamp":J
    .restart local v7    # "frameNumber":J
    :goto_1
    return-void
.end method
