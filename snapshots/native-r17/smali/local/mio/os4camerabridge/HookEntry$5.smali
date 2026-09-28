.class Llocal/mio/os4camerabridge/HookEntry$5;
.super Lde/robv/android/xposed/XC_MethodHook;
.source "HookEntry.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Llocal/mio/os4camerabridge/HookEntry;->hookOplusCommonPhotoBridge(Ljava/lang/ClassLoader;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# direct methods
.method constructor <init>()V
    .locals 0

    .line 1406
    invoke-direct {p0}, Lde/robv/android/xposed/XC_MethodHook;-><init>()V

    return-void
.end method


# virtual methods
.method protected afterHookedMethod(Lde/robv/android/xposed/XC_MethodHook$MethodHookParam;)V
    .locals 9
    .param p1, "param"    # Lde/robv/android/xposed/XC_MethodHook$MethodHookParam;

    .line 1410
    invoke-static {}, Llocal/mio/os4camerabridge/HookEntry;->-$$Nest$sfgetcommonApsPhotoSessionActive()Z

    move-result v0

    if-eqz v0, :cond_6

    invoke-static {}, Llocal/mio/os4camerabridge/HookEntry;->-$$Nest$sfgetcommonApsReady()Z

    move-result v0

    if-eqz v0, :cond_6

    invoke-static {}, Llocal/mio/os4camerabridge/HookEntry;->-$$Nest$sfgetcommonApsDisabled()Z

    move-result v0

    if-nez v0, :cond_6

    invoke-static {}, Llocal/mio/os4camerabridge/HookEntry;->-$$Nest$sfgetactiveCameraModule()I

    move-result v0

    const/16 v1, 0xa3

    if-ne v0, v1, :cond_6

    sget-object v0, Ljava/lang/Boolean;->TRUE:Ljava/lang/Boolean;

    invoke-static {}, Llocal/mio/os4camerabridge/HookEntry;->-$$Nest$sfgetCOMMON_APS_BURST_GUARD()Ljava/lang/ThreadLocal;

    move-result-object v1

    .line 1414
    invoke-virtual {v1}, Ljava/lang/ThreadLocal;->get()Ljava/lang/Object;

    move-result-object v1

    .line 1413
    invoke-virtual {v0, v1}, Ljava/lang/Boolean;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-nez v0, :cond_6

    invoke-static {}, Llocal/mio/os4camerabridge/HookEntry;->-$$Nest$sfgetcommonRawMainReader()Landroid/media/ImageReader;

    move-result-object v0

    if-eqz v0, :cond_6

    invoke-static {}, Llocal/mio/os4camerabridge/HookEntry;->-$$Nest$sfgetcommonRawDolReader()Landroid/media/ImageReader;

    move-result-object v0

    if-eqz v0, :cond_6

    invoke-static {}, Llocal/mio/os4camerabridge/HookEntry;->-$$Nest$sfgetcommonAuxYuvReader()Landroid/media/ImageReader;

    move-result-object v0

    if-eqz v0, :cond_6

    iget-object v0, p1, Lde/robv/android/xposed/XC_MethodHook$MethodHookParam;->args:[Ljava/lang/Object;

    if-eqz v0, :cond_6

    iget-object v0, p1, Lde/robv/android/xposed/XC_MethodHook$MethodHookParam;->args:[Ljava/lang/Object;

    array-length v0, v0

    const/4 v1, 0x3

    if-lt v0, v1, :cond_6

    iget-object v0, p1, Lde/robv/android/xposed/XC_MethodHook$MethodHookParam;->args:[Ljava/lang/Object;

    const/4 v1, 0x0

    aget-object v0, v0, v1

    instance-of v0, v0, Landroid/hardware/camera2/CaptureRequest;

    if-eqz v0, :cond_6

    .line 1422
    invoke-virtual {p1}, Lde/robv/android/xposed/XC_MethodHook$MethodHookParam;->getThrowable()Ljava/lang/Throwable;

    move-result-object v0

    if-eqz v0, :cond_0

    goto/16 :goto_3

    .line 1425
    :cond_0
    iget-object v0, p1, Lde/robv/android/xposed/XC_MethodHook$MethodHookParam;->args:[Ljava/lang/Object;

    aget-object v0, v0, v1

    check-cast v0, Landroid/hardware/camera2/CaptureRequest;

    .line 1427
    .local v0, "original":Landroid/hardware/camera2/CaptureRequest;
    sget-object v1, Landroid/hardware/camera2/CaptureRequest;->CONTROL_CAPTURE_INTENT:Landroid/hardware/camera2/CaptureRequest$Key;

    invoke-virtual {v0, v1}, Landroid/hardware/camera2/CaptureRequest;->get(Landroid/hardware/camera2/CaptureRequest$Key;)Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Ljava/lang/Integer;

    .line 1429
    .local v1, "intent":Ljava/lang/Integer;
    const/4 v2, 0x2

    invoke-static {v2}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v3

    .line 1431
    invoke-virtual {v3, v1}, Ljava/lang/Integer;->equals(Ljava/lang/Object;)Z

    move-result v3

    if-nez v3, :cond_1

    .line 1432
    return-void

    .line 1435
    :cond_1
    invoke-static {}, Llocal/mio/os4camerabridge/HookEntry;->-$$Nest$smresolveCommonApsDecision()Llocal/mio/os4camerabridge/HookEntry$CommonApsDecision;

    move-result-object v3

    .line 1436
    .local v3, "decision":Llocal/mio/os4camerabridge/HookEntry$CommonApsDecision;
    if-eqz v3, :cond_5

    .line 1437
    invoke-virtual {v3}, Llocal/mio/os4camerabridge/HookEntry$CommonApsDecision;->isSupportedCommon2Dol()Z

    move-result v4

    if-nez v4, :cond_2

    goto/16 :goto_2

    .line 1443
    :cond_2
    iget-object v4, p1, Lde/robv/android/xposed/XC_MethodHook$MethodHookParam;->thisObject:Ljava/lang/Object;

    .line 1444
    invoke-static {v4, v0, v3}, Llocal/mio/os4camerabridge/HookEntry;->-$$Nest$smbuildCommonApsRequestSet(Ljava/lang/Object;Landroid/hardware/camera2/CaptureRequest;Llocal/mio/os4camerabridge/HookEntry$CommonApsDecision;)Ljava/util/ArrayList;

    move-result-object v4

    .line 1447
    .local v4, "burst":Ljava/util/ArrayList;, "Ljava/util/ArrayList<Landroid/hardware/camera2/CaptureRequest;>;"
    if-eqz v4, :cond_4

    .line 1448
    invoke-virtual {v4}, Ljava/util/ArrayList;->size()I

    move-result v5

    iget v6, v3, Llocal/mio/os4camerabridge/HookEntry$CommonApsDecision;->frameCount:I

    if-ne v5, v6, :cond_4

    .line 1449
    invoke-static {v0, v3}, Llocal/mio/os4camerabridge/HookEntry;->-$$Nest$smbeginCommonApsCapture(Landroid/hardware/camera2/CaptureRequest;Llocal/mio/os4camerabridge/HookEntry$CommonApsDecision;)Z

    move-result v5

    if-nez v5, :cond_3

    goto/16 :goto_1

    .line 1456
    :cond_3
    nop

    .line 1457
    const/4 v5, 0x0

    :try_start_0
    invoke-static {v5, v5, v4}, Llocal/mio/os4camerabridge/HookEntry;->-$$Nest$smwrapCommonApsBurstCallback(Landroid/hardware/camera2/CameraCaptureSession$CaptureCallback;Landroid/hardware/camera2/CaptureRequest;Ljava/util/List;)Landroid/hardware/camera2/CameraCaptureSession$CaptureCallback;

    move-result-object v5

    .line 1459
    .local v5, "callback":Landroid/hardware/camera2/CameraCaptureSession$CaptureCallback;
    invoke-static {}, Llocal/mio/os4camerabridge/HookEntry;->-$$Nest$sfgetCOMMON_APS_BURST_GUARD()Ljava/lang/ThreadLocal;

    move-result-object v6

    sget-object v7, Ljava/lang/Boolean;->TRUE:Ljava/lang/Boolean;

    invoke-virtual {v6, v7}, Ljava/lang/ThreadLocal;->set(Ljava/lang/Object;)V

    .line 1460
    iget-object v6, p1, Lde/robv/android/xposed/XC_MethodHook$MethodHookParam;->thisObject:Ljava/lang/Object;

    const-string v7, "captureBurst"

    iget-object v8, p1, Lde/robv/android/xposed/XC_MethodHook$MethodHookParam;->args:[Ljava/lang/Object;

    aget-object v2, v8, v2

    filled-new-array {v4, v5, v2}, [Ljava/lang/Object;

    move-result-object v2

    invoke-static {v6, v7, v2}, Lde/robv/android/xposed/XposedHelpers;->callMethod(Ljava/lang/Object;Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v2

    .line 1463
    .local v2, "sequence":Ljava/lang/Object;
    new-instance v6, Ljava/lang/StringBuilder;

    invoke-direct {v6}, Ljava/lang/StringBuilder;-><init>()V

    const-string v7, "[CommonAPS] submitted isolated "

    invoke-virtual {v6, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    iget v7, v3, Llocal/mio/os4camerabridge/HookEntry$CommonApsDecision;->frameCount:I

    invoke-virtual {v6, v7}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v6

    const-string v7, "-request sidecar: Xiaomi JPEG unchanged, four targets/request bracket="

    invoke-virtual {v6, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    iget v7, v3, Llocal/mio/os4camerabridge/HookEntry$CommonApsDecision;->bracketMode:I

    invoke-virtual {v6, v7}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v6

    const-string v7, " ev="

    invoke-virtual {v6, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    .line 1468
    invoke-virtual {v3}, Llocal/mio/os4camerabridge/HookEntry$CommonApsDecision;->evListString()Ljava/lang/String;

    move-result-object v7

    invoke-virtual {v6, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    const-string v7, " sequence="

    invoke-virtual {v6, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    invoke-virtual {v6, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v6

    invoke-virtual {v6}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v6

    .line 1463
    invoke-static {v6}, Llocal/mio/os4camerabridge/HookEntry;->-$$Nest$smlog(Ljava/lang/String;)V
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .end local v2    # "sequence":Ljava/lang/Object;
    .end local v5    # "callback":Landroid/hardware/camera2/CameraCaptureSession$CaptureCallback;
    goto :goto_0

    .line 1470
    :catchall_0
    move-exception v2

    .line 1471
    .local v2, "throwable":Ljava/lang/Throwable;
    :try_start_1
    const-string v5, "burst-submit-failed"

    const/4 v6, 0x1

    invoke-static {v5, v6}, Llocal/mio/os4camerabridge/HookEntry;->-$$Nest$smabortCommonApsCapture(Ljava/lang/String;Z)V

    .line 1473
    new-instance v5, Ljava/lang/StringBuilder;

    invoke-direct {v5}, Ljava/lang/StringBuilder;-><init>()V

    const-string v6, "[CommonAPS] sidecar burst failed; original Xiaomi capture is unaffected: "

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v5

    invoke-static {v5}, Llocal/mio/os4camerabridge/HookEntry;->-$$Nest$smlog(Ljava/lang/String;)V
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_1

    .line 1477
    .end local v2    # "throwable":Ljava/lang/Throwable;
    :goto_0
    invoke-static {}, Llocal/mio/os4camerabridge/HookEntry;->-$$Nest$sfgetCOMMON_APS_BURST_GUARD()Ljava/lang/ThreadLocal;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/ThreadLocal;->remove()V

    .line 1478
    nop

    .line 1479
    return-void

    .line 1477
    :catchall_1
    move-exception v2

    invoke-static {}, Llocal/mio/os4camerabridge/HookEntry;->-$$Nest$sfgetCOMMON_APS_BURST_GUARD()Ljava/lang/ThreadLocal;

    move-result-object v5

    invoke-virtual {v5}, Ljava/lang/ThreadLocal;->remove()V

    .line 1478
    throw v2

    .line 1451
    :cond_4
    :goto_1
    const-string v2, "[CommonAPS] sidecar proof bypassed; Xiaomi JPEG was already submitted unchanged"

    invoke-static {v2}, Llocal/mio/os4camerabridge/HookEntry;->-$$Nest$smlog(Ljava/lang/String;)V

    .line 1453
    return-void

    .line 1438
    .end local v4    # "burst":Ljava/util/ArrayList;, "Ljava/util/ArrayList<Landroid/hardware/camera2/CaptureRequest;>;"
    :cond_5
    :goto_2
    const-string v2, "[CommonAPS] sidecar proof bypassed; no supported native common/2DOL decision; Xiaomi JPEG unchanged"

    invoke-static {v2}, Llocal/mio/os4camerabridge/HookEntry;->-$$Nest$smlog(Ljava/lang/String;)V

    .line 1441
    return-void

    .line 1423
    .end local v0    # "original":Landroid/hardware/camera2/CaptureRequest;
    .end local v1    # "intent":Ljava/lang/Integer;
    .end local v3    # "decision":Llocal/mio/os4camerabridge/HookEntry$CommonApsDecision;
    :cond_6
    :goto_3
    return-void
.end method
