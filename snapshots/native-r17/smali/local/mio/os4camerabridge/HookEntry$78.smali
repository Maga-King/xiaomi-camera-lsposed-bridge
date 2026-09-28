.class Llocal/mio/os4camerabridge/HookEntry$78;
.super Landroid/hardware/camera2/CameraCaptureSession$CaptureCallback;
.source "HookEntry.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Llocal/mio/os4camerabridge/HookEntry;->wrapYuvBurstCallback(Landroid/hardware/camera2/CameraCaptureSession$CaptureCallback;Landroid/hardware/camera2/CaptureRequest;Ljava/util/List;)Landroid/hardware/camera2/CameraCaptureSession$CaptureCallback;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic val$baseRequest:Landroid/hardware/camera2/CaptureRequest;

.field final synthetic val$indexes:Ljava/util/Map;

.field final synthetic val$original:Landroid/hardware/camera2/CameraCaptureSession$CaptureCallback;


# direct methods
.method constructor <init>(Landroid/hardware/camera2/CaptureRequest;Ljava/util/Map;Landroid/hardware/camera2/CameraCaptureSession$CaptureCallback;)V
    .locals 0

    .line 13147
    iput-object p1, p0, Llocal/mio/os4camerabridge/HookEntry$78;->val$baseRequest:Landroid/hardware/camera2/CaptureRequest;

    iput-object p2, p0, Llocal/mio/os4camerabridge/HookEntry$78;->val$indexes:Ljava/util/Map;

    iput-object p3, p0, Llocal/mio/os4camerabridge/HookEntry$78;->val$original:Landroid/hardware/camera2/CameraCaptureSession$CaptureCallback;

    invoke-direct {p0}, Landroid/hardware/camera2/CameraCaptureSession$CaptureCallback;-><init>()V

    return-void
.end method

.method private index(Landroid/hardware/camera2/CaptureRequest;)I
    .locals 2
    .param p1, "request"    # Landroid/hardware/camera2/CaptureRequest;

    .line 13153
    iget-object v0, p0, Llocal/mio/os4camerabridge/HookEntry$78;->val$indexes:Ljava/util/Map;

    invoke-interface {v0, p1}, Ljava/util/Map;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/lang/Integer;

    .line 13154
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

    .line 13149
    iget-object v0, p0, Llocal/mio/os4camerabridge/HookEntry$78;->val$baseRequest:Landroid/hardware/camera2/CaptureRequest;

    if-eq p1, v0, :cond_1

    iget-object v0, p0, Llocal/mio/os4camerabridge/HookEntry$78;->val$baseRequest:Landroid/hardware/camera2/CaptureRequest;

    invoke-virtual {v0, p1}, Landroid/hardware/camera2/CaptureRequest;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_0

    goto :goto_0

    :cond_0
    const/4 v0, 0x0

    goto :goto_1

    :cond_1
    :goto_0
    const/4 v0, 0x1

    :goto_1
    return v0
.end method


# virtual methods
.method public onCaptureBufferLost(Landroid/hardware/camera2/CameraCaptureSession;Landroid/hardware/camera2/CaptureRequest;Landroid/view/Surface;J)V
    .locals 7
    .param p1, "session"    # Landroid/hardware/camera2/CameraCaptureSession;
    .param p2, "request"    # Landroid/hardware/camera2/CaptureRequest;
    .param p3, "target"    # Landroid/view/Surface;
    .param p4, "frameNumber"    # J

    .line 13235
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "[YuvBurst] buffer lost index="

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-direct {p0, p2}, Llocal/mio/os4camerabridge/HookEntry$78;->index(Landroid/hardware/camera2/CaptureRequest;)I

    move-result v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, " frame="

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, p4, p5}, Ljava/lang/StringBuilder;->append(J)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, " target="

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, p3}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Llocal/mio/os4camerabridge/HookEntry;->-$$Nest$smlog(Ljava/lang/String;)V

    .line 13237
    iget-object v0, p0, Llocal/mio/os4camerabridge/HookEntry$78;->val$original:Landroid/hardware/camera2/CameraCaptureSession$CaptureCallback;

    if-eqz v0, :cond_0

    invoke-direct {p0, p2}, Llocal/mio/os4camerabridge/HookEntry$78;->isBase(Landroid/hardware/camera2/CaptureRequest;)Z

    move-result v0

    if-eqz v0, :cond_0

    .line 13238
    iget-object v1, p0, Llocal/mio/os4camerabridge/HookEntry$78;->val$original:Landroid/hardware/camera2/CameraCaptureSession$CaptureCallback;

    move-object v2, p1

    move-object v3, p2

    move-object v4, p3

    move-wide v5, p4

    .end local p1    # "session":Landroid/hardware/camera2/CameraCaptureSession;
    .end local p2    # "request":Landroid/hardware/camera2/CaptureRequest;
    .end local p3    # "target":Landroid/view/Surface;
    .end local p4    # "frameNumber":J
    .local v2, "session":Landroid/hardware/camera2/CameraCaptureSession;
    .local v3, "request":Landroid/hardware/camera2/CaptureRequest;
    .local v4, "target":Landroid/view/Surface;
    .local v5, "frameNumber":J
    invoke-virtual/range {v1 .. v6}, Landroid/hardware/camera2/CameraCaptureSession$CaptureCallback;->onCaptureBufferLost(Landroid/hardware/camera2/CameraCaptureSession;Landroid/hardware/camera2/CaptureRequest;Landroid/view/Surface;J)V

    goto :goto_0

    .line 13237
    .end local v2    # "session":Landroid/hardware/camera2/CameraCaptureSession;
    .end local v3    # "request":Landroid/hardware/camera2/CaptureRequest;
    .end local v4    # "target":Landroid/view/Surface;
    .end local v5    # "frameNumber":J
    .restart local p1    # "session":Landroid/hardware/camera2/CameraCaptureSession;
    .restart local p2    # "request":Landroid/hardware/camera2/CaptureRequest;
    .restart local p3    # "target":Landroid/view/Surface;
    .restart local p4    # "frameNumber":J
    :cond_0
    move-object v2, p1

    move-object v3, p2

    move-object v4, p3

    move-wide v5, p4

    .line 13241
    .end local p1    # "session":Landroid/hardware/camera2/CameraCaptureSession;
    .end local p2    # "request":Landroid/hardware/camera2/CaptureRequest;
    .end local p3    # "target":Landroid/view/Surface;
    .end local p4    # "frameNumber":J
    .restart local v2    # "session":Landroid/hardware/camera2/CameraCaptureSession;
    .restart local v3    # "request":Landroid/hardware/camera2/CaptureRequest;
    .restart local v4    # "target":Landroid/view/Surface;
    .restart local v5    # "frameNumber":J
    :goto_0
    return-void
.end method

.method public onCaptureCompleted(Landroid/hardware/camera2/CameraCaptureSession;Landroid/hardware/camera2/CaptureRequest;Landroid/hardware/camera2/TotalCaptureResult;)V
    .locals 3
    .param p1, "session"    # Landroid/hardware/camera2/CameraCaptureSession;
    .param p2, "request"    # Landroid/hardware/camera2/CaptureRequest;
    .param p3, "result"    # Landroid/hardware/camera2/TotalCaptureResult;

    .line 13182
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "[YuvBurst] completed index="

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-direct {p0, p2}, Llocal/mio/os4camerabridge/HookEntry$78;->index(Landroid/hardware/camera2/CaptureRequest;)I

    move-result v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, " frame="

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    .line 13183
    invoke-virtual {p3}, Landroid/hardware/camera2/TotalCaptureResult;->getFrameNumber()J

    move-result-wide v1

    invoke-virtual {v0, v1, v2}, Ljava/lang/StringBuilder;->append(J)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, " sensorTs="

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    sget-object v1, Landroid/hardware/camera2/CaptureResult;->SENSOR_TIMESTAMP:Landroid/hardware/camera2/CaptureResult$Key;

    .line 13184
    invoke-static {p3, v1}, Llocal/mio/os4camerabridge/HookEntry;->-$$Nest$smreadResult(Landroid/hardware/camera2/CaptureResult;Landroid/hardware/camera2/CaptureResult$Key;)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, " active="

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    sget-object v1, Landroid/hardware/camera2/CaptureResult;->LOGICAL_MULTI_CAMERA_ACTIVE_PHYSICAL_ID:Landroid/hardware/camera2/CaptureResult$Key;

    .line 13186
    invoke-static {p3, v1}, Llocal/mio/os4camerabridge/HookEntry;->-$$Nest$smreadResult(Landroid/hardware/camera2/CaptureResult;Landroid/hardware/camera2/CaptureResult$Key;)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, " zoom="

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    sget-object v1, Landroid/hardware/camera2/CaptureResult;->CONTROL_ZOOM_RATIO:Landroid/hardware/camera2/CaptureResult$Key;

    .line 13188
    invoke-static {p3, v1}, Llocal/mio/os4camerabridge/HookEntry;->-$$Nest$smreadResult(Landroid/hardware/camera2/CaptureResult;Landroid/hardware/camera2/CaptureResult$Key;)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, " iso="

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    sget-object v1, Landroid/hardware/camera2/CaptureResult;->SENSOR_SENSITIVITY:Landroid/hardware/camera2/CaptureResult$Key;

    .line 13190
    invoke-static {p3, v1}, Llocal/mio/os4camerabridge/HookEntry;->-$$Nest$smreadResult(Landroid/hardware/camera2/CaptureResult;Landroid/hardware/camera2/CaptureResult$Key;)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, " exposureNs="

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    sget-object v1, Landroid/hardware/camera2/CaptureResult;->SENSOR_EXPOSURE_TIME:Landroid/hardware/camera2/CaptureResult$Key;

    .line 13192
    invoke-static {p3, v1}, Llocal/mio/os4camerabridge/HookEntry;->-$$Nest$smreadResult(Landroid/hardware/camera2/CaptureResult;Landroid/hardware/camera2/CaptureResult$Key;)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    .line 13182
    invoke-static {v0}, Llocal/mio/os4camerabridge/HookEntry;->-$$Nest$smlog(Ljava/lang/String;)V

    .line 13194
    iget-object v0, p0, Llocal/mio/os4camerabridge/HookEntry$78;->val$original:Landroid/hardware/camera2/CameraCaptureSession$CaptureCallback;

    if-eqz v0, :cond_0

    invoke-direct {p0, p2}, Llocal/mio/os4camerabridge/HookEntry$78;->isBase(Landroid/hardware/camera2/CaptureRequest;)Z

    move-result v0

    if-eqz v0, :cond_0

    .line 13195
    iget-object v0, p0, Llocal/mio/os4camerabridge/HookEntry$78;->val$original:Landroid/hardware/camera2/CameraCaptureSession$CaptureCallback;

    invoke-virtual {v0, p1, p2, p3}, Landroid/hardware/camera2/CameraCaptureSession$CaptureCallback;->onCaptureCompleted(Landroid/hardware/camera2/CameraCaptureSession;Landroid/hardware/camera2/CaptureRequest;Landroid/hardware/camera2/TotalCaptureResult;)V

    .line 13197
    :cond_0
    return-void
.end method

.method public onCaptureFailed(Landroid/hardware/camera2/CameraCaptureSession;Landroid/hardware/camera2/CaptureRequest;Landroid/hardware/camera2/CaptureFailure;)V
    .locals 3
    .param p1, "session"    # Landroid/hardware/camera2/CameraCaptureSession;
    .param p2, "request"    # Landroid/hardware/camera2/CaptureRequest;
    .param p3, "failure"    # Landroid/hardware/camera2/CaptureFailure;

    .line 13202
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "[YuvBurst] failed index="

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-direct {p0, p2}, Llocal/mio/os4camerabridge/HookEntry$78;->index(Landroid/hardware/camera2/CaptureRequest;)I

    move-result v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, " frame="

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    .line 13203
    invoke-virtual {p3}, Landroid/hardware/camera2/CaptureFailure;->getFrameNumber()J

    move-result-wide v1

    invoke-virtual {v0, v1, v2}, Ljava/lang/StringBuilder;->append(J)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, " reason="

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    .line 13204
    invoke-virtual {p3}, Landroid/hardware/camera2/CaptureFailure;->getReason()I

    move-result v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    .line 13202
    invoke-static {v0}, Llocal/mio/os4camerabridge/HookEntry;->-$$Nest$smlog(Ljava/lang/String;)V

    .line 13205
    iget-object v0, p0, Llocal/mio/os4camerabridge/HookEntry$78;->val$original:Landroid/hardware/camera2/CameraCaptureSession$CaptureCallback;

    if-eqz v0, :cond_0

    invoke-direct {p0, p2}, Llocal/mio/os4camerabridge/HookEntry$78;->isBase(Landroid/hardware/camera2/CaptureRequest;)Z

    move-result v0

    if-eqz v0, :cond_0

    .line 13206
    iget-object v0, p0, Llocal/mio/os4camerabridge/HookEntry$78;->val$original:Landroid/hardware/camera2/CameraCaptureSession$CaptureCallback;

    invoke-virtual {v0, p1, p2, p3}, Landroid/hardware/camera2/CameraCaptureSession$CaptureCallback;->onCaptureFailed(Landroid/hardware/camera2/CameraCaptureSession;Landroid/hardware/camera2/CaptureRequest;Landroid/hardware/camera2/CaptureFailure;)V

    .line 13208
    :cond_0
    return-void
.end method

.method public onCaptureProgressed(Landroid/hardware/camera2/CameraCaptureSession;Landroid/hardware/camera2/CaptureRequest;Landroid/hardware/camera2/CaptureResult;)V
    .locals 1
    .param p1, "session"    # Landroid/hardware/camera2/CameraCaptureSession;
    .param p2, "request"    # Landroid/hardware/camera2/CaptureRequest;
    .param p3, "partialResult"    # Landroid/hardware/camera2/CaptureResult;

    .line 13173
    iget-object v0, p0, Llocal/mio/os4camerabridge/HookEntry$78;->val$original:Landroid/hardware/camera2/CameraCaptureSession$CaptureCallback;

    if-eqz v0, :cond_0

    invoke-direct {p0, p2}, Llocal/mio/os4camerabridge/HookEntry$78;->isBase(Landroid/hardware/camera2/CaptureRequest;)Z

    move-result v0

    if-eqz v0, :cond_0

    .line 13174
    iget-object v0, p0, Llocal/mio/os4camerabridge/HookEntry$78;->val$original:Landroid/hardware/camera2/CameraCaptureSession$CaptureCallback;

    invoke-virtual {v0, p1, p2, p3}, Landroid/hardware/camera2/CameraCaptureSession$CaptureCallback;->onCaptureProgressed(Landroid/hardware/camera2/CameraCaptureSession;Landroid/hardware/camera2/CaptureRequest;Landroid/hardware/camera2/CaptureResult;)V

    .line 13177
    :cond_0
    return-void
.end method

.method public onCaptureSequenceAborted(Landroid/hardware/camera2/CameraCaptureSession;I)V
    .locals 2
    .param p1, "session"    # Landroid/hardware/camera2/CameraCaptureSession;
    .param p2, "sequenceId"    # I

    .line 13225
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "[YuvBurst] sequence aborted id="

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, p2}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Llocal/mio/os4camerabridge/HookEntry;->-$$Nest$smlog(Ljava/lang/String;)V

    .line 13226
    iget-object v0, p0, Llocal/mio/os4camerabridge/HookEntry$78;->val$original:Landroid/hardware/camera2/CameraCaptureSession$CaptureCallback;

    if-eqz v0, :cond_0

    .line 13227
    iget-object v0, p0, Llocal/mio/os4camerabridge/HookEntry$78;->val$original:Landroid/hardware/camera2/CameraCaptureSession$CaptureCallback;

    invoke-virtual {v0, p1, p2}, Landroid/hardware/camera2/CameraCaptureSession$CaptureCallback;->onCaptureSequenceAborted(Landroid/hardware/camera2/CameraCaptureSession;I)V

    .line 13229
    :cond_0
    return-void
.end method

.method public onCaptureSequenceCompleted(Landroid/hardware/camera2/CameraCaptureSession;IJ)V
    .locals 2
    .param p1, "session"    # Landroid/hardware/camera2/CameraCaptureSession;
    .param p2, "sequenceId"    # I
    .param p3, "frameNumber"    # J

    .line 13214
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "[YuvBurst] sequence completed id="

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

    .line 13216
    iget-object v0, p0, Llocal/mio/os4camerabridge/HookEntry$78;->val$original:Landroid/hardware/camera2/CameraCaptureSession$CaptureCallback;

    if-eqz v0, :cond_0

    .line 13217
    iget-object v0, p0, Llocal/mio/os4camerabridge/HookEntry$78;->val$original:Landroid/hardware/camera2/CameraCaptureSession$CaptureCallback;

    invoke-virtual {v0, p1, p2, p3, p4}, Landroid/hardware/camera2/CameraCaptureSession$CaptureCallback;->onCaptureSequenceCompleted(Landroid/hardware/camera2/CameraCaptureSession;IJ)V

    .line 13220
    :cond_0
    return-void
.end method

.method public onCaptureStarted(Landroid/hardware/camera2/CameraCaptureSession;Landroid/hardware/camera2/CaptureRequest;JJ)V
    .locals 8
    .param p1, "session"    # Landroid/hardware/camera2/CameraCaptureSession;
    .param p2, "request"    # Landroid/hardware/camera2/CaptureRequest;
    .param p3, "timestamp"    # J
    .param p5, "frameNumber"    # J

    .line 13161
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "[YuvBurst] started index="

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-direct {p0, p2}, Llocal/mio/os4camerabridge/HookEntry$78;->index(Landroid/hardware/camera2/CaptureRequest;)I

    move-result v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, " sensorTs="

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, p3, p4}, Ljava/lang/StringBuilder;->append(J)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, " frame="

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, p5, p6}, Ljava/lang/StringBuilder;->append(J)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Llocal/mio/os4camerabridge/HookEntry;->-$$Nest$smlog(Ljava/lang/String;)V

    .line 13164
    iget-object v0, p0, Llocal/mio/os4camerabridge/HookEntry$78;->val$original:Landroid/hardware/camera2/CameraCaptureSession$CaptureCallback;

    if-eqz v0, :cond_0

    invoke-direct {p0, p2}, Llocal/mio/os4camerabridge/HookEntry$78;->isBase(Landroid/hardware/camera2/CaptureRequest;)Z

    move-result v0

    if-eqz v0, :cond_0

    .line 13165
    iget-object v1, p0, Llocal/mio/os4camerabridge/HookEntry$78;->val$original:Landroid/hardware/camera2/CameraCaptureSession$CaptureCallback;

    move-object v2, p1

    move-object v3, p2

    move-wide v4, p3

    move-wide v6, p5

    .end local p1    # "session":Landroid/hardware/camera2/CameraCaptureSession;
    .end local p2    # "request":Landroid/hardware/camera2/CaptureRequest;
    .end local p3    # "timestamp":J
    .end local p5    # "frameNumber":J
    .local v2, "session":Landroid/hardware/camera2/CameraCaptureSession;
    .local v3, "request":Landroid/hardware/camera2/CaptureRequest;
    .local v4, "timestamp":J
    .local v6, "frameNumber":J
    invoke-virtual/range {v1 .. v7}, Landroid/hardware/camera2/CameraCaptureSession$CaptureCallback;->onCaptureStarted(Landroid/hardware/camera2/CameraCaptureSession;Landroid/hardware/camera2/CaptureRequest;JJ)V

    goto :goto_0

    .line 13164
    .end local v2    # "session":Landroid/hardware/camera2/CameraCaptureSession;
    .end local v3    # "request":Landroid/hardware/camera2/CaptureRequest;
    .end local v4    # "timestamp":J
    .end local v6    # "frameNumber":J
    .restart local p1    # "session":Landroid/hardware/camera2/CameraCaptureSession;
    .restart local p2    # "request":Landroid/hardware/camera2/CaptureRequest;
    .restart local p3    # "timestamp":J
    .restart local p5    # "frameNumber":J
    :cond_0
    move-object v2, p1

    move-object v3, p2

    move-wide v4, p3

    move-wide v6, p5

    .line 13168
    .end local p1    # "session":Landroid/hardware/camera2/CameraCaptureSession;
    .end local p2    # "request":Landroid/hardware/camera2/CaptureRequest;
    .end local p3    # "timestamp":J
    .end local p5    # "frameNumber":J
    .restart local v2    # "session":Landroid/hardware/camera2/CameraCaptureSession;
    .restart local v3    # "request":Landroid/hardware/camera2/CaptureRequest;
    .restart local v4    # "timestamp":J
    .restart local v6    # "frameNumber":J
    :goto_0
    return-void
.end method
