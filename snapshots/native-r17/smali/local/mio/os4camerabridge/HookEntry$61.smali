.class Llocal/mio/os4camerabridge/HookEntry$61;
.super Landroid/hardware/camera2/CameraCaptureSession$StateCallback;
.source "HookEntry.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Llocal/mio/os4camerabridge/HookEntry;->wrapUnifiedApsStateCallback(Landroid/hardware/camera2/CameraCaptureSession$StateCallback;I)Landroid/hardware/camera2/CameraCaptureSession$StateCallback;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic val$generation:I

.field final synthetic val$original:Landroid/hardware/camera2/CameraCaptureSession$StateCallback;


# direct methods
.method constructor <init>(ILandroid/hardware/camera2/CameraCaptureSession$StateCallback;)V
    .locals 0

    .line 9752
    iput p1, p0, Llocal/mio/os4camerabridge/HookEntry$61;->val$generation:I

    iput-object p2, p0, Llocal/mio/os4camerabridge/HookEntry$61;->val$original:Landroid/hardware/camera2/CameraCaptureSession$StateCallback;

    invoke-direct {p0}, Landroid/hardware/camera2/CameraCaptureSession$StateCallback;-><init>()V

    return-void
.end method


# virtual methods
.method public onActive(Landroid/hardware/camera2/CameraCaptureSession;)V
    .locals 3
    .param p1, "session"    # Landroid/hardware/camera2/CameraCaptureSession;

    .line 9843
    invoke-static {}, Llocal/mio/os4camerabridge/HookEntry;->-$$Nest$sfgetCOMMON_APS_UNIFIED_SESSION_LOCK()Ljava/lang/Object;

    move-result-object v0

    monitor-enter v0

    .line 9844
    :try_start_0
    iget v1, p0, Llocal/mio/os4camerabridge/HookEntry$61;->val$generation:I

    invoke-static {}, Llocal/mio/os4camerabridge/HookEntry;->-$$Nest$sfgetcommonApsUnifiedSessionGeneration()I

    move-result v2

    if-ne v1, v2, :cond_0

    invoke-static {}, Llocal/mio/os4camerabridge/HookEntry;->-$$Nest$sfgetcommonApsUnifiedSessionActive()Z

    move-result v1

    if-eqz v1, :cond_0

    invoke-static {}, Llocal/mio/os4camerabridge/HookEntry;->-$$Nest$sfgetcommonApsUnifiedSession()Landroid/hardware/camera2/CameraCaptureSession;

    move-result-object v1

    if-ne p1, v1, :cond_0

    .line 9847
    iget-object v1, p0, Llocal/mio/os4camerabridge/HookEntry$61;->val$original:Landroid/hardware/camera2/CameraCaptureSession$StateCallback;

    invoke-virtual {v1, p1}, Landroid/hardware/camera2/CameraCaptureSession$StateCallback;->onActive(Landroid/hardware/camera2/CameraCaptureSession;)V

    .line 9849
    :cond_0
    monitor-exit v0

    .line 9850
    return-void

    .line 9849
    :catchall_0
    move-exception v1

    monitor-exit v0
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    throw v1
.end method

.method public onCaptureQueueEmpty(Landroid/hardware/camera2/CameraCaptureSession;)V
    .locals 3
    .param p1, "session"    # Landroid/hardware/camera2/CameraCaptureSession;

    .line 9854
    invoke-static {}, Llocal/mio/os4camerabridge/HookEntry;->-$$Nest$sfgetCOMMON_APS_UNIFIED_SESSION_LOCK()Ljava/lang/Object;

    move-result-object v0

    monitor-enter v0

    .line 9855
    :try_start_0
    iget v1, p0, Llocal/mio/os4camerabridge/HookEntry$61;->val$generation:I

    invoke-static {}, Llocal/mio/os4camerabridge/HookEntry;->-$$Nest$sfgetcommonApsUnifiedSessionGeneration()I

    move-result v2

    if-ne v1, v2, :cond_0

    invoke-static {}, Llocal/mio/os4camerabridge/HookEntry;->-$$Nest$sfgetcommonApsUnifiedSessionActive()Z

    move-result v1

    if-eqz v1, :cond_0

    invoke-static {}, Llocal/mio/os4camerabridge/HookEntry;->-$$Nest$sfgetcommonApsUnifiedSession()Landroid/hardware/camera2/CameraCaptureSession;

    move-result-object v1

    if-ne p1, v1, :cond_0

    .line 9858
    iget-object v1, p0, Llocal/mio/os4camerabridge/HookEntry$61;->val$original:Landroid/hardware/camera2/CameraCaptureSession$StateCallback;

    invoke-virtual {v1, p1}, Landroid/hardware/camera2/CameraCaptureSession$StateCallback;->onCaptureQueueEmpty(Landroid/hardware/camera2/CameraCaptureSession;)V

    .line 9860
    :cond_0
    monitor-exit v0

    .line 9861
    return-void

    .line 9860
    :catchall_0
    move-exception v1

    monitor-exit v0
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    throw v1
.end method

.method public onClosed(Landroid/hardware/camera2/CameraCaptureSession;)V
    .locals 3
    .param p1, "session"    # Landroid/hardware/camera2/CameraCaptureSession;

    .line 9877
    invoke-static {}, Llocal/mio/os4camerabridge/HookEntry;->-$$Nest$sfgetCOMMON_APS_UNIFIED_SESSION_LOCK()Ljava/lang/Object;

    move-result-object v0

    monitor-enter v0

    .line 9878
    :try_start_0
    iget v1, p0, Llocal/mio/os4camerabridge/HookEntry$61;->val$generation:I

    invoke-static {}, Llocal/mio/os4camerabridge/HookEntry;->-$$Nest$sfgetcommonApsUnifiedSessionGeneration()I

    move-result v2

    if-ne v1, v2, :cond_1

    invoke-static {}, Llocal/mio/os4camerabridge/HookEntry;->-$$Nest$sfgetcommonApsUnifiedSession()Landroid/hardware/camera2/CameraCaptureSession;

    move-result-object v1

    if-eqz v1, :cond_0

    invoke-static {}, Llocal/mio/os4camerabridge/HookEntry;->-$$Nest$sfgetcommonApsUnifiedSession()Landroid/hardware/camera2/CameraCaptureSession;

    move-result-object v1

    if-eq p1, v1, :cond_0

    goto :goto_0

    .line 9886
    :cond_0
    const/4 v1, 0x0

    invoke-static {v1}, Llocal/mio/os4camerabridge/HookEntry;->-$$Nest$sfputcommonApsUnifiedSessionPending(Z)V

    .line 9887
    invoke-static {v1}, Llocal/mio/os4camerabridge/HookEntry;->-$$Nest$sfputcommonApsUnifiedSessionActive(Z)V

    .line 9888
    const/4 v2, 0x0

    invoke-static {v2}, Llocal/mio/os4camerabridge/HookEntry;->-$$Nest$sfputcommonApsUnifiedSession(Landroid/hardware/camera2/CameraCaptureSession;)V

    .line 9889
    invoke-static {v2}, Llocal/mio/os4camerabridge/HookEntry;->-$$Nest$sfputcommonApsUnifiedSessionParameters(Landroid/hardware/camera2/CaptureRequest;)V

    .line 9890
    invoke-static {v2}, Llocal/mio/os4camerabridge/HookEntry;->-$$Nest$sfputcommonApsUnifiedXiaomiPreviewSurface(Landroid/view/Surface;)V

    .line 9891
    invoke-static {v2}, Llocal/mio/os4camerabridge/HookEntry;->-$$Nest$sfputcommonApsUnifiedXiaomiJpegSurface(Landroid/view/Surface;)V

    .line 9892
    invoke-static {v2}, Llocal/mio/os4camerabridge/HookEntry;->-$$Nest$sfputcommonApsUnifiedXiaomiSecondaryJpegSurface(Landroid/view/Surface;)V

    .line 9893
    const/4 v2, -0x1

    invoke-static {v2}, Llocal/mio/os4camerabridge/HookEntry;->-$$Nest$sfputcommonApsUnifiedCameraModule(I)V

    .line 9894
    invoke-static {v1}, Llocal/mio/os4camerabridge/HookEntry;->-$$Nest$sfputcommonApsUnifiedPortraitSession(Z)V

    .line 9895
    const-string v1, "unified session ended: session-closed"

    invoke-static {v1}, Llocal/mio/os4camerabridge/HookEntry;->-$$Nest$smfailCommonApsShutter(Ljava/lang/String;)V

    .line 9897
    const-string v1, "unified-session-session-closed"

    const/4 v2, 0x1

    invoke-static {v1, v2}, Llocal/mio/os4camerabridge/HookEntry;->-$$Nest$smabortCommonApsCapture(Ljava/lang/String;Z)V

    .line 9899
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "[UnifiedAPS] persistent session left generation="

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    iget v2, p0, Llocal/mio/os4camerabridge/HookEntry$61;->val$generation:I

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, " reason=session-closed"

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-static {v1}, Llocal/mio/os4camerabridge/HookEntry;->-$$Nest$smlog(Ljava/lang/String;)V

    .line 9901
    iget-object v1, p0, Llocal/mio/os4camerabridge/HookEntry$61;->val$original:Landroid/hardware/camera2/CameraCaptureSession$StateCallback;

    invoke-virtual {v1, p1}, Landroid/hardware/camera2/CameraCaptureSession$StateCallback;->onClosed(Landroid/hardware/camera2/CameraCaptureSession;)V

    .line 9902
    monitor-exit v0

    .line 9903
    return-void

    .line 9881
    :cond_1
    :goto_0
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "[UnifiedAPS] stale onClosed suppressed generation="

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    iget v2, p0, Llocal/mio/os4camerabridge/HookEntry$61;->val$generation:I

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, " current="

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-static {}, Llocal/mio/os4camerabridge/HookEntry;->-$$Nest$sfgetcommonApsUnifiedSessionGeneration()I

    move-result v2

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-static {v1}, Llocal/mio/os4camerabridge/HookEntry;->-$$Nest$smlog(Ljava/lang/String;)V

    .line 9884
    monitor-exit v0

    return-void

    .line 9902
    :catchall_0
    move-exception v1

    monitor-exit v0
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    throw v1
.end method

.method public onConfigureFailed(Landroid/hardware/camera2/CameraCaptureSession;)V
    .locals 5
    .param p1, "session"    # Landroid/hardware/camera2/CameraCaptureSession;

    .line 9792
    invoke-static {}, Llocal/mio/os4camerabridge/HookEntry;->-$$Nest$sfgetCOMMON_APS_UNIFIED_SESSION_LOCK()Ljava/lang/Object;

    move-result-object v0

    monitor-enter v0

    .line 9793
    :try_start_0
    iget v1, p0, Llocal/mio/os4camerabridge/HookEntry$61;->val$generation:I

    invoke-static {}, Llocal/mio/os4camerabridge/HookEntry;->-$$Nest$sfgetcommonApsUnifiedSessionGeneration()I

    move-result v2

    if-ne v1, v2, :cond_3

    invoke-static {}, Llocal/mio/os4camerabridge/HookEntry;->-$$Nest$sfgetcommonApsUnifiedSession()Landroid/hardware/camera2/CameraCaptureSession;

    move-result-object v1

    if-eqz v1, :cond_0

    invoke-static {}, Llocal/mio/os4camerabridge/HookEntry;->-$$Nest$sfgetcommonApsUnifiedSession()Landroid/hardware/camera2/CameraCaptureSession;

    move-result-object v1

    if-eq p1, v1, :cond_0

    goto :goto_1

    .line 9801
    :cond_0
    invoke-static {}, Llocal/mio/os4camerabridge/HookEntry;->-$$Nest$sfgetcommonApsUnifiedPortraitSession()Z

    move-result v1

    .line 9803
    .local v1, "portraitFailure":Z
    const/4 v2, 0x1

    if-nez v1, :cond_1

    .line 9804
    invoke-static {v2}, Llocal/mio/os4camerabridge/HookEntry;->-$$Nest$sfputcommonApsUnifiedAutoDisabled(Z)V

    .line 9805
    invoke-static {}, Llocal/mio/os4camerabridge/HookEntry;->-$$Nest$sfgetcommonApsUnifiedConfigureFailures()I

    move-result v3

    add-int/2addr v3, v2

    invoke-static {v3}, Llocal/mio/os4camerabridge/HookEntry;->-$$Nest$sfputcommonApsUnifiedConfigureFailures(I)V

    .line 9807
    :cond_1
    const/4 v3, 0x0

    invoke-static {v3}, Llocal/mio/os4camerabridge/HookEntry;->-$$Nest$sfputcommonApsUnifiedSessionPending(Z)V

    .line 9808
    invoke-static {v3}, Llocal/mio/os4camerabridge/HookEntry;->-$$Nest$sfputcommonApsUnifiedSessionActive(Z)V

    .line 9809
    const/4 v4, 0x0

    invoke-static {v4}, Llocal/mio/os4camerabridge/HookEntry;->-$$Nest$sfputcommonApsUnifiedSession(Landroid/hardware/camera2/CameraCaptureSession;)V

    .line 9810
    invoke-static {v4}, Llocal/mio/os4camerabridge/HookEntry;->-$$Nest$sfputcommonApsUnifiedSessionParameters(Landroid/hardware/camera2/CaptureRequest;)V

    .line 9811
    invoke-static {v4}, Llocal/mio/os4camerabridge/HookEntry;->-$$Nest$sfputcommonApsUnifiedXiaomiPreviewSurface(Landroid/view/Surface;)V

    .line 9812
    invoke-static {v4}, Llocal/mio/os4camerabridge/HookEntry;->-$$Nest$sfputcommonApsUnifiedXiaomiJpegSurface(Landroid/view/Surface;)V

    .line 9813
    invoke-static {v4}, Llocal/mio/os4camerabridge/HookEntry;->-$$Nest$sfputcommonApsUnifiedXiaomiSecondaryJpegSurface(Landroid/view/Surface;)V

    .line 9814
    const/4 v4, -0x1

    invoke-static {v4}, Llocal/mio/os4camerabridge/HookEntry;->-$$Nest$sfputcommonApsUnifiedCameraModule(I)V

    .line 9815
    invoke-static {v3}, Llocal/mio/os4camerabridge/HookEntry;->-$$Nest$sfputcommonApsUnifiedPortraitSession(Z)V

    .line 9816
    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    const-string v4, "[UnifiedAPS] disabling automatic route for this session after HAL configure failure route="

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    .line 9818
    if-eqz v1, :cond_2

    const-string v4, "portrait"

    goto :goto_0

    :cond_2
    const-string v4, "common"

    :goto_0
    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    const-string v4, " count="

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-static {}, Llocal/mio/os4camerabridge/HookEntry;->-$$Nest$sfgetcommonApsUnifiedConfigureFailures()I

    move-result v4

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    .line 9816
    invoke-static {v3}, Llocal/mio/os4camerabridge/HookEntry;->-$$Nest$smlog(Ljava/lang/String;)V

    .line 9820
    const-string v3, "unified session ended: configure-failed"

    invoke-static {v3}, Llocal/mio/os4camerabridge/HookEntry;->-$$Nest$smfailCommonApsShutter(Ljava/lang/String;)V

    .line 9822
    const-string v3, "unified-session-configure-failed"

    invoke-static {v3, v2}, Llocal/mio/os4camerabridge/HookEntry;->-$$Nest$smabortCommonApsCapture(Ljava/lang/String;Z)V

    .line 9824
    const-string v2, "[UnifiedAPS] native graph onConfigureFailed; Xiaomi may rebuild its original session without a loop"

    invoke-static {v2}, Llocal/mio/os4camerabridge/HookEntry;->-$$Nest$smlog(Ljava/lang/String;)V

    .line 9826
    iget-object v2, p0, Llocal/mio/os4camerabridge/HookEntry$61;->val$original:Landroid/hardware/camera2/CameraCaptureSession$StateCallback;

    invoke-virtual {v2, p1}, Landroid/hardware/camera2/CameraCaptureSession$StateCallback;->onConfigureFailed(Landroid/hardware/camera2/CameraCaptureSession;)V

    .line 9827
    .end local v1    # "portraitFailure":Z
    monitor-exit v0

    .line 9828
    return-void

    .line 9796
    :cond_3
    :goto_1
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "[UnifiedAPS] stale onConfigureFailed suppressed generation="

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    iget v2, p0, Llocal/mio/os4camerabridge/HookEntry$61;->val$generation:I

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, " current="

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-static {}, Llocal/mio/os4camerabridge/HookEntry;->-$$Nest$sfgetcommonApsUnifiedSessionGeneration()I

    move-result v2

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-static {v1}, Llocal/mio/os4camerabridge/HookEntry;->-$$Nest$smlog(Ljava/lang/String;)V

    .line 9799
    monitor-exit v0

    return-void

    .line 9827
    :catchall_0
    move-exception v1

    monitor-exit v0
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    throw v1
.end method

.method public onConfigured(Landroid/hardware/camera2/CameraCaptureSession;)V
    .locals 5
    .param p1, "session"    # Landroid/hardware/camera2/CameraCaptureSession;

    .line 9756
    invoke-static {}, Llocal/mio/os4camerabridge/HookEntry;->-$$Nest$sfgetCOMMON_APS_UNIFIED_SESSION_LOCK()Ljava/lang/Object;

    move-result-object v0

    monitor-enter v0

    .line 9757
    :try_start_0
    iget v1, p0, Llocal/mio/os4camerabridge/HookEntry$61;->val$generation:I

    invoke-static {}, Llocal/mio/os4camerabridge/HookEntry;->-$$Nest$sfgetcommonApsUnifiedSessionGeneration()I

    move-result v2

    const/4 v3, 0x1

    const/4 v4, 0x0

    if-ne v1, v2, :cond_1

    invoke-static {}, Llocal/mio/os4camerabridge/HookEntry;->-$$Nest$sfgetcommonApsUnifiedSessionPending()Z

    move-result v1

    if-nez v1, :cond_0

    invoke-static {}, Llocal/mio/os4camerabridge/HookEntry;->-$$Nest$sfgetcommonApsUnifiedSession()Landroid/hardware/camera2/CameraCaptureSession;

    move-result-object v1

    if-eq p1, v1, :cond_0

    goto :goto_0

    :cond_0
    move v1, v4

    goto :goto_1

    :cond_1
    :goto_0
    move v1, v3

    .line 9761
    .local v1, "stale":Z
    :goto_1
    if-nez v1, :cond_3

    .line 9762
    invoke-static {p1}, Llocal/mio/os4camerabridge/HookEntry;->-$$Nest$sfputcommonApsUnifiedSession(Landroid/hardware/camera2/CameraCaptureSession;)V

    .line 9763
    invoke-static {v4}, Llocal/mio/os4camerabridge/HookEntry;->-$$Nest$sfputcommonApsUnifiedSessionPending(Z)V

    .line 9764
    invoke-static {v3}, Llocal/mio/os4camerabridge/HookEntry;->-$$Nest$sfputcommonApsUnifiedSessionActive(Z)V

    .line 9765
    invoke-static {v4}, Llocal/mio/os4camerabridge/HookEntry;->-$$Nest$sfputcommonApsUnifiedConfigureFailures(I)V

    .line 9766
    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "[UnifiedAPS] SUCCESS persistent "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    .line 9767
    invoke-static {}, Llocal/mio/os4camerabridge/HookEntry;->-$$Nest$sfgetcommonApsUnifiedPortraitSession()Z

    move-result v3

    if-eqz v3, :cond_2

    .line 9768
    const-string v3, "7-output portrait"

    goto :goto_2

    :cond_2
    const-string v3, "10-output common"

    :goto_2
    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    const-string v3, " session configured generation="

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    iget v3, p0, Llocal/mio/os4camerabridge/HookEntry$61;->val$generation:I

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v2

    const-string v3, "; forwarding to Xiaomi preview"

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    .line 9766
    invoke-static {v2}, Llocal/mio/os4camerabridge/HookEntry;->-$$Nest$smlog(Ljava/lang/String;)V

    .line 9775
    iget-object v2, p0, Llocal/mio/os4camerabridge/HookEntry$61;->val$original:Landroid/hardware/camera2/CameraCaptureSession$StateCallback;

    invoke-virtual {v2, p1}, Landroid/hardware/camera2/CameraCaptureSession$StateCallback;->onConfigured(Landroid/hardware/camera2/CameraCaptureSession;)V

    .line 9777
    :cond_3
    monitor-exit v0
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_1

    .line 9778
    if-eqz v1, :cond_4

    .line 9779
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "[UnifiedAPS] stale onConfigured suppressed generation="

    invoke-virtual {v0, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    iget v2, p0, Llocal/mio/os4camerabridge/HookEntry$61;->val$generation:I

    invoke-virtual {v0, v2}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v2, " current="

    invoke-virtual {v0, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-static {}, Llocal/mio/os4camerabridge/HookEntry;->-$$Nest$sfgetcommonApsUnifiedSessionGeneration()I

    move-result v2

    invoke-virtual {v0, v2}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Llocal/mio/os4camerabridge/HookEntry;->-$$Nest$smlog(Ljava/lang/String;)V

    .line 9783
    :try_start_1
    invoke-virtual {p1}, Landroid/hardware/camera2/CameraCaptureSession;->close()V
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    .line 9786
    goto :goto_3

    .line 9784
    :catchall_0
    move-exception v0

    .line 9788
    :cond_4
    :goto_3
    return-void

    .line 9777
    .end local v1    # "stale":Z
    :catchall_1
    move-exception v1

    :try_start_2
    monitor-exit v0
    :try_end_2
    .catchall {:try_start_2 .. :try_end_2} :catchall_1

    throw v1
.end method

.method public onReady(Landroid/hardware/camera2/CameraCaptureSession;)V
    .locals 3
    .param p1, "session"    # Landroid/hardware/camera2/CameraCaptureSession;

    .line 9832
    invoke-static {}, Llocal/mio/os4camerabridge/HookEntry;->-$$Nest$sfgetCOMMON_APS_UNIFIED_SESSION_LOCK()Ljava/lang/Object;

    move-result-object v0

    monitor-enter v0

    .line 9833
    :try_start_0
    iget v1, p0, Llocal/mio/os4camerabridge/HookEntry$61;->val$generation:I

    invoke-static {}, Llocal/mio/os4camerabridge/HookEntry;->-$$Nest$sfgetcommonApsUnifiedSessionGeneration()I

    move-result v2

    if-ne v1, v2, :cond_0

    invoke-static {}, Llocal/mio/os4camerabridge/HookEntry;->-$$Nest$sfgetcommonApsUnifiedSessionActive()Z

    move-result v1

    if-eqz v1, :cond_0

    invoke-static {}, Llocal/mio/os4camerabridge/HookEntry;->-$$Nest$sfgetcommonApsUnifiedSession()Landroid/hardware/camera2/CameraCaptureSession;

    move-result-object v1

    if-ne p1, v1, :cond_0

    .line 9836
    iget-object v1, p0, Llocal/mio/os4camerabridge/HookEntry$61;->val$original:Landroid/hardware/camera2/CameraCaptureSession$StateCallback;

    invoke-virtual {v1, p1}, Landroid/hardware/camera2/CameraCaptureSession$StateCallback;->onReady(Landroid/hardware/camera2/CameraCaptureSession;)V

    .line 9838
    :cond_0
    monitor-exit v0

    .line 9839
    return-void

    .line 9838
    :catchall_0
    move-exception v1

    monitor-exit v0
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    throw v1
.end method

.method public onSurfacePrepared(Landroid/hardware/camera2/CameraCaptureSession;Landroid/view/Surface;)V
    .locals 3
    .param p1, "session"    # Landroid/hardware/camera2/CameraCaptureSession;
    .param p2, "surface"    # Landroid/view/Surface;

    .line 9866
    invoke-static {}, Llocal/mio/os4camerabridge/HookEntry;->-$$Nest$sfgetCOMMON_APS_UNIFIED_SESSION_LOCK()Ljava/lang/Object;

    move-result-object v0

    monitor-enter v0

    .line 9867
    :try_start_0
    iget v1, p0, Llocal/mio/os4camerabridge/HookEntry$61;->val$generation:I

    invoke-static {}, Llocal/mio/os4camerabridge/HookEntry;->-$$Nest$sfgetcommonApsUnifiedSessionGeneration()I

    move-result v2

    if-ne v1, v2, :cond_0

    invoke-static {}, Llocal/mio/os4camerabridge/HookEntry;->-$$Nest$sfgetcommonApsUnifiedSessionActive()Z

    move-result v1

    if-eqz v1, :cond_0

    invoke-static {}, Llocal/mio/os4camerabridge/HookEntry;->-$$Nest$sfgetcommonApsUnifiedSession()Landroid/hardware/camera2/CameraCaptureSession;

    move-result-object v1

    if-ne p1, v1, :cond_0

    .line 9870
    iget-object v1, p0, Llocal/mio/os4camerabridge/HookEntry$61;->val$original:Landroid/hardware/camera2/CameraCaptureSession$StateCallback;

    invoke-virtual {v1, p1, p2}, Landroid/hardware/camera2/CameraCaptureSession$StateCallback;->onSurfacePrepared(Landroid/hardware/camera2/CameraCaptureSession;Landroid/view/Surface;)V

    .line 9872
    :cond_0
    monitor-exit v0

    .line 9873
    return-void

    .line 9872
    :catchall_0
    move-exception v1

    monitor-exit v0
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    throw v1
.end method
