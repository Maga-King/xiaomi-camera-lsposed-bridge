.class Llocal/mio/os4camerabridge/HookEntry$68;
.super Lde/robv/android/xposed/XC_MethodHook;
.source "HookEntry.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Llocal/mio/os4camerabridge/HookEntry;->hookFullYuvProbe(Ljava/lang/ClassLoader;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# direct methods
.method constructor <init>()V
    .locals 0

    .line 10566
    invoke-direct {p0}, Lde/robv/android/xposed/XC_MethodHook;-><init>()V

    return-void
.end method


# virtual methods
.method protected beforeHookedMethod(Lde/robv/android/xposed/XC_MethodHook$MethodHookParam;)V
    .locals 10
    .param p1, "param"    # Lde/robv/android/xposed/XC_MethodHook$MethodHookParam;

    .line 10569
    invoke-static {}, Llocal/mio/os4camerabridge/HookEntry;->-$$Nest$sfgetfullYuvSessionActive()Z

    move-result v0

    if-eqz v0, :cond_8

    .line 10570
    invoke-static {}, Llocal/mio/os4camerabridge/HookEntry;->-$$Nest$smisYuvMultiframeEnabled()Z

    move-result v0

    if-eqz v0, :cond_8

    sget-object v0, Ljava/lang/Boolean;->TRUE:Ljava/lang/Boolean;

    invoke-static {}, Llocal/mio/os4camerabridge/HookEntry;->-$$Nest$sfgetYUV_BURST_GUARD()Ljava/lang/ThreadLocal;

    move-result-object v1

    .line 10571
    invoke-virtual {v1}, Ljava/lang/ThreadLocal;->get()Ljava/lang/Object;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/Boolean;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-nez v0, :cond_8

    invoke-static {}, Llocal/mio/os4camerabridge/HookEntry;->-$$Nest$sfgetfullYuvReader()Landroid/media/ImageReader;

    move-result-object v0

    if-eqz v0, :cond_8

    iget-object v0, p1, Lde/robv/android/xposed/XC_MethodHook$MethodHookParam;->args:[Ljava/lang/Object;

    if-eqz v0, :cond_8

    iget-object v0, p1, Lde/robv/android/xposed/XC_MethodHook$MethodHookParam;->args:[Ljava/lang/Object;

    array-length v0, v0

    const/4 v1, 0x3

    if-lt v0, v1, :cond_8

    iget-object v0, p1, Lde/robv/android/xposed/XC_MethodHook$MethodHookParam;->args:[Ljava/lang/Object;

    const/4 v1, 0x0

    aget-object v0, v0, v1

    instance-of v0, v0, Landroid/hardware/camera2/CaptureRequest;

    if-nez v0, :cond_0

    goto/16 :goto_5

    .line 10578
    :cond_0
    iget-object v0, p1, Lde/robv/android/xposed/XC_MethodHook$MethodHookParam;->args:[Ljava/lang/Object;

    aget-object v0, v0, v1

    check-cast v0, Landroid/hardware/camera2/CaptureRequest;

    .line 10579
    .local v0, "original":Landroid/hardware/camera2/CaptureRequest;
    sget-object v2, Landroid/hardware/camera2/CaptureRequest;->CONTROL_CAPTURE_INTENT:Landroid/hardware/camera2/CaptureRequest$Key;

    invoke-virtual {v0, v2}, Landroid/hardware/camera2/CaptureRequest;->get(Landroid/hardware/camera2/CaptureRequest$Key;)Ljava/lang/Object;

    move-result-object v2

    check-cast v2, Ljava/lang/Integer;

    .line 10581
    .local v2, "intent":Ljava/lang/Integer;
    const/4 v3, 0x2

    invoke-static {v3}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v4

    .line 10582
    invoke-virtual {v4, v2}, Ljava/lang/Integer;->equals(Ljava/lang/Object;)Z

    move-result v4

    if-eqz v4, :cond_7

    invoke-static {}, Llocal/mio/os4camerabridge/HookEntry;->-$$Nest$sfgetfullYuvReader()Landroid/media/ImageReader;

    move-result-object v4

    .line 10584
    invoke-virtual {v4}, Landroid/media/ImageReader;->getSurface()Landroid/view/Surface;

    move-result-object v4

    .line 10583
    invoke-static {v0, v4}, Llocal/mio/os4camerabridge/HookEntry;->-$$Nest$smcaptureTargetsSurface(Landroid/hardware/camera2/CaptureRequest;Landroid/view/Surface;)Z

    move-result v4

    if-nez v4, :cond_1

    goto/16 :goto_4

    .line 10587
    :cond_1
    invoke-static {}, Llocal/mio/os4camerabridge/HookEntry;->-$$Nest$smisYuvFusionEnabled()Z

    move-result v4

    if-eqz v4, :cond_2

    invoke-static {}, Llocal/mio/os4camerabridge/HookEntry;->-$$Nest$smawaitFusionSlot()Z

    move-result v4

    if-nez v4, :cond_2

    .line 10588
    const-string v1, "[YuvFusion] stale previous capture; current shot uses original JPEG"

    invoke-static {v1}, Llocal/mio/os4camerabridge/HookEntry;->-$$Nest$smlog(Ljava/lang/String;)V

    .line 10589
    return-void

    .line 10592
    :cond_2
    const/4 v4, 0x1

    :try_start_0
    iget-object v5, p1, Lde/robv/android/xposed/XC_MethodHook$MethodHookParam;->thisObject:Ljava/lang/Object;

    const/4 v6, 0x5

    invoke-static {v5, v0, v6}, Llocal/mio/os4camerabridge/HookEntry;->-$$Nest$smbuildYuvRequestSet(Ljava/lang/Object;Landroid/hardware/camera2/CaptureRequest;I)Ljava/util/ArrayList;

    move-result-object v5

    .line 10594
    .local v5, "burst":Ljava/util/ArrayList;, "Ljava/util/ArrayList<Landroid/hardware/camera2/CaptureRequest;>;"
    if-eqz v5, :cond_6

    invoke-virtual {v5}, Ljava/util/ArrayList;->size()I

    move-result v7

    if-eq v7, v6, :cond_3

    goto/16 :goto_2

    .line 10598
    :cond_3
    invoke-static {v1}, Llocal/mio/os4camerabridge/HookEntry;->-$$Nest$sfputfullYuvFrameCount(I)V

    .line 10599
    invoke-virtual {v5}, Ljava/util/ArrayList;->size()I

    move-result v1

    invoke-static {v1}, Llocal/mio/os4camerabridge/HookEntry;->-$$Nest$sfputfullYuvExpectedFrames(I)V

    .line 10600
    invoke-static {}, Llocal/mio/os4camerabridge/HookEntry;->-$$Nest$smisYuvFusionEnabled()Z

    move-result v1

    const/4 v6, 0x0

    if-eqz v1, :cond_4

    .line 10601
    invoke-static {}, Llocal/mio/os4camerabridge/HookEntry;->-$$Nest$sfgetFUSION_LOCK()Ljava/lang/Object;

    move-result-object v1

    monitor-enter v1
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_1

    .line 10602
    :try_start_1
    invoke-static {}, Llocal/mio/os4camerabridge/HookEntry;->-$$Nest$sfgetFUSION_FRAMES()Ljava/util/ArrayList;

    move-result-object v7

    invoke-virtual {v7}, Ljava/util/ArrayList;->clear()V

    .line 10603
    invoke-static {v6}, Llocal/mio/os4camerabridge/HookEntry;->-$$Nest$sfputpendingFusedJpeg([B)V

    .line 10604
    invoke-static {v6}, Llocal/mio/os4camerabridge/HookEntry;->-$$Nest$sfputfusionFailure(Ljava/lang/String;)V

    .line 10605
    invoke-static {v4}, Llocal/mio/os4camerabridge/HookEntry;->-$$Nest$sfputfusionCapturePending(Z)V

    .line 10606
    monitor-exit v1
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    .line 10607
    :try_start_2
    const-string v1, "[YuvFusion] capture armed for five real frames"

    invoke-static {v1}, Llocal/mio/os4camerabridge/HookEntry;->-$$Nest$smlog(Ljava/lang/String;)V
    :try_end_2
    .catchall {:try_start_2 .. :try_end_2} :catchall_1

    goto :goto_0

    .line 10606
    :catchall_0
    move-exception v3

    :try_start_3
    monitor-exit v1
    :try_end_3
    .catchall {:try_start_3 .. :try_end_3} :catchall_0

    .end local v0    # "original":Landroid/hardware/camera2/CaptureRequest;
    .end local v2    # "intent":Ljava/lang/Integer;
    .end local p0    # "this":Llocal/mio/os4camerabridge/HookEntry$68;
    .end local p1    # "param":Lde/robv/android/xposed/XC_MethodHook$MethodHookParam;
    :try_start_4
    throw v3

    .line 10610
    .restart local v0    # "original":Landroid/hardware/camera2/CaptureRequest;
    .restart local v2    # "intent":Ljava/lang/Integer;
    .restart local p0    # "this":Llocal/mio/os4camerabridge/HookEntry$68;
    .restart local p1    # "param":Lde/robv/android/xposed/XC_MethodHook$MethodHookParam;
    :cond_4
    :goto_0
    iget-object v1, p1, Lde/robv/android/xposed/XC_MethodHook$MethodHookParam;->args:[Ljava/lang/Object;

    aget-object v1, v1, v4

    instance-of v1, v1, Landroid/hardware/camera2/CameraCaptureSession$CaptureCallback;

    if-eqz v1, :cond_5

    .line 10612
    iget-object v1, p1, Lde/robv/android/xposed/XC_MethodHook$MethodHookParam;->args:[Ljava/lang/Object;

    aget-object v1, v1, v4

    move-object v6, v1

    check-cast v6, Landroid/hardware/camera2/CameraCaptureSession$CaptureCallback;

    goto :goto_1

    .line 10613
    :cond_5
    nop

    :goto_1
    nop

    .line 10614
    .local v6, "originalCallback":Landroid/hardware/camera2/CameraCaptureSession$CaptureCallback;
    nop

    .line 10615
    invoke-static {v6, v0, v5}, Llocal/mio/os4camerabridge/HookEntry;->-$$Nest$smwrapYuvBurstCallback(Landroid/hardware/camera2/CameraCaptureSession$CaptureCallback;Landroid/hardware/camera2/CaptureRequest;Ljava/util/List;)Landroid/hardware/camera2/CameraCaptureSession$CaptureCallback;

    move-result-object v1

    .line 10617
    .local v1, "callback":Landroid/hardware/camera2/CameraCaptureSession$CaptureCallback;
    invoke-static {}, Llocal/mio/os4camerabridge/HookEntry;->-$$Nest$sfgetYUV_BURST_GUARD()Ljava/lang/ThreadLocal;

    move-result-object v7

    sget-object v8, Ljava/lang/Boolean;->TRUE:Ljava/lang/Boolean;

    invoke-virtual {v7, v8}, Ljava/lang/ThreadLocal;->set(Ljava/lang/Object;)V

    .line 10618
    iget-object v7, p1, Lde/robv/android/xposed/XC_MethodHook$MethodHookParam;->thisObject:Ljava/lang/Object;

    const-string v8, "captureBurst"

    iget-object v9, p1, Lde/robv/android/xposed/XC_MethodHook$MethodHookParam;->args:[Ljava/lang/Object;

    aget-object v3, v9, v3

    filled-new-array {v5, v1, v3}, [Ljava/lang/Object;

    move-result-object v3

    invoke-static {v7, v8, v3}, Lde/robv/android/xposed/XposedHelpers;->callMethod(Ljava/lang/Object;Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v3

    .line 10621
    .local v3, "sequence":Ljava/lang/Object;
    invoke-virtual {p1, v3}, Lde/robv/android/xposed/XC_MethodHook$MethodHookParam;->setResult(Ljava/lang/Object;)V

    .line 10622
    new-instance v7, Ljava/lang/StringBuilder;

    invoke-direct {v7}, Ljava/lang/StringBuilder;-><init>()V

    const-string v8, "[YuvBurst] submitted atomic burst fullJPEG+YUV=1 YUV-only=4 total=5 sequence="

    invoke-virtual {v7, v8}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v7

    invoke-virtual {v7, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v7

    invoke-virtual {v7}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v7

    invoke-static {v7}, Llocal/mio/os4camerabridge/HookEntry;->-$$Nest$smlog(Ljava/lang/String;)V

    .end local v1    # "callback":Landroid/hardware/camera2/CameraCaptureSession$CaptureCallback;
    .end local v3    # "sequence":Ljava/lang/Object;
    .end local v5    # "burst":Ljava/util/ArrayList;, "Ljava/util/ArrayList<Landroid/hardware/camera2/CaptureRequest;>;"
    .end local v6    # "originalCallback":Landroid/hardware/camera2/CameraCaptureSession$CaptureCallback;
    goto :goto_3

    .line 10595
    .restart local v5    # "burst":Ljava/util/ArrayList;, "Ljava/util/ArrayList<Landroid/hardware/camera2/CaptureRequest;>;"
    :cond_6
    :goto_2
    const-string v1, "[YuvBurst] request clone unavailable; retaining single frame"

    invoke-static {v1}, Llocal/mio/os4camerabridge/HookEntry;->-$$Nest$smlog(Ljava/lang/String;)V
    :try_end_4
    .catchall {:try_start_4 .. :try_end_4} :catchall_1

    .line 10630
    invoke-static {}, Llocal/mio/os4camerabridge/HookEntry;->-$$Nest$sfgetYUV_BURST_GUARD()Ljava/lang/ThreadLocal;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/ThreadLocal;->remove()V

    .line 10596
    return-void

    .line 10624
    .end local v5    # "burst":Ljava/util/ArrayList;, "Ljava/util/ArrayList<Landroid/hardware/camera2/CaptureRequest;>;"
    :catchall_1
    move-exception v1

    .line 10625
    .local v1, "throwable":Ljava/lang/Throwable;
    :try_start_5
    invoke-static {v4}, Llocal/mio/os4camerabridge/HookEntry;->-$$Nest$sfputfullYuvExpectedFrames(I)V

    .line 10626
    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    const-string v4, "burst submission failed: "

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    invoke-static {v3}, Llocal/mio/os4camerabridge/HookEntry;->-$$Nest$smfailFusion(Ljava/lang/String;)V

    .line 10627
    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    const-string v4, "[YuvBurst] submit failed; retaining original capture: "

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    invoke-static {v3}, Llocal/mio/os4camerabridge/HookEntry;->-$$Nest$smlog(Ljava/lang/String;)V
    :try_end_5
    .catchall {:try_start_5 .. :try_end_5} :catchall_2

    .line 10630
    .end local v1    # "throwable":Ljava/lang/Throwable;
    :goto_3
    invoke-static {}, Llocal/mio/os4camerabridge/HookEntry;->-$$Nest$sfgetYUV_BURST_GUARD()Ljava/lang/ThreadLocal;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/ThreadLocal;->remove()V

    .line 10631
    nop

    .line 10632
    return-void

    .line 10630
    :catchall_2
    move-exception v1

    invoke-static {}, Llocal/mio/os4camerabridge/HookEntry;->-$$Nest$sfgetYUV_BURST_GUARD()Ljava/lang/ThreadLocal;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/ThreadLocal;->remove()V

    .line 10631
    throw v1

    .line 10585
    :cond_7
    :goto_4
    return-void

    .line 10576
    .end local v0    # "original":Landroid/hardware/camera2/CaptureRequest;
    .end local v2    # "intent":Ljava/lang/Integer;
    :cond_8
    :goto_5
    return-void
.end method
