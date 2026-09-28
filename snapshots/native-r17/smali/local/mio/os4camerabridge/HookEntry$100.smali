.class Llocal/mio/os4camerabridge/HookEntry$100;
.super Lde/robv/android/xposed/XC_MethodHook;
.source "HookEntry.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Llocal/mio/os4camerabridge/HookEntry;->hookStillQualityHints()V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# direct methods
.method constructor <init>()V
    .locals 0

    .line 14305
    invoke-direct {p0}, Lde/robv/android/xposed/XC_MethodHook;-><init>()V

    return-void
.end method


# virtual methods
.method protected beforeHookedMethod(Lde/robv/android/xposed/XC_MethodHook$MethodHookParam;)V
    .locals 9
    .param p1, "param"    # Lde/robv/android/xposed/XC_MethodHook$MethodHookParam;

    .line 14308
    iget-object v0, p1, Lde/robv/android/xposed/XC_MethodHook$MethodHookParam;->thisObject:Ljava/lang/Object;

    check-cast v0, Landroid/hardware/camera2/CaptureRequest$Builder;

    .line 14310
    .local v0, "builder":Landroid/hardware/camera2/CaptureRequest$Builder;
    const/4 v1, 0x1

    :try_start_0
    invoke-static {}, Llocal/mio/os4camerabridge/HookEntry;->-$$Nest$sfgetactiveCameraId()I

    move-result v2

    const/16 v3, 0xa7

    if-nez v2, :cond_0

    invoke-static {}, Llocal/mio/os4camerabridge/HookEntry;->-$$Nest$sfgetactiveCameraModule()I

    move-result v2

    const/16 v4, 0xa2

    if-eq v2, v4, :cond_0

    invoke-static {}, Llocal/mio/os4camerabridge/HookEntry;->-$$Nest$sfgetactiveCameraModule()I

    move-result v2

    if-eq v2, v3, :cond_0

    .line 14313
    sget-object v2, Landroid/hardware/camera2/CaptureRequest;->CONTROL_ZOOM_RATIO:Landroid/hardware/camera2/CaptureRequest$Key;

    invoke-virtual {v0, v2}, Landroid/hardware/camera2/CaptureRequest$Builder;->get(Landroid/hardware/camera2/CaptureRequest$Key;)Ljava/lang/Object;

    move-result-object v2

    check-cast v2, Ljava/lang/Float;

    .line 14315
    .local v2, "logicalRatio":Ljava/lang/Float;
    if-eqz v2, :cond_0

    .line 14316
    invoke-virtual {v2}, Ljava/lang/Float;->floatValue()F

    move-result v4

    invoke-static {v4}, Ljava/lang/Float;->isFinite(F)Z

    move-result v4

    if-eqz v4, :cond_0

    .line 14317
    invoke-virtual {v2}, Ljava/lang/Float;->floatValue()F

    move-result v4

    const/high16 v5, 0x40400000    # 3.0f

    cmpl-float v4, v4, v5

    if-ltz v4, :cond_0

    .line 14318
    nop

    .line 14319
    invoke-virtual {v2}, Ljava/lang/Float;->floatValue()F

    move-result v4

    .line 14318
    invoke-static {v0, v4}, Llocal/mio/os4camerabridge/HookEntry;->-$$Nest$smapplyLogicalOplusTeleRoute(Landroid/hardware/camera2/CaptureRequest$Builder;F)V

    .line 14320
    new-instance v4, Ljava/lang/StringBuilder;

    invoke-direct {v4}, Ljava/lang/StringBuilder;-><init>()V

    invoke-static {}, Llocal/mio/os4camerabridge/HookEntry;->-$$Nest$sfgetactiveCameraModule()I

    move-result v6

    invoke-virtual {v4, v6}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v4

    const-string v6, ":"

    invoke-virtual {v4, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    .line 14321
    invoke-virtual {v2}, Ljava/lang/Float;->floatValue()F

    move-result v6

    const/high16 v7, 0x42c80000    # 100.0f

    mul-float/2addr v6, v7

    invoke-static {v6}, Ljava/lang/Math;->round(F)I

    move-result v6

    invoke-virtual {v4, v6}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v4

    .line 14322
    .local v4, "signature":Ljava/lang/String;
    invoke-static {}, Llocal/mio/os4camerabridge/HookEntry;->-$$Nest$sfgetLOGICAL_LENS_OWNERSHIP_LOGGED()Ljava/util/Set;

    move-result-object v6

    new-instance v7, Ljava/lang/StringBuilder;

    invoke-direct {v7}, Ljava/lang/StringBuilder;-><init>()V

    const-string v8, "final-tele:"

    invoke-virtual {v7, v8}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v7

    invoke-virtual {v7, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v7

    invoke-virtual {v7}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v7

    invoke-interface {v6, v7}, Ljava/util/Set;->add(Ljava/lang/Object;)Z

    move-result v6

    if-eqz v6, :cond_0

    .line 14324
    new-instance v6, Ljava/lang/StringBuilder;

    invoke-direct {v6}, Ljava/lang/StringBuilder;-><init>()V

    const-string v7, "[LogicalTeleFinal] module="

    invoke-virtual {v6, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    invoke-static {}, Llocal/mio/os4camerabridge/HookEntry;->-$$Nest$sfgetactiveCameraModule()I

    move-result v7

    invoke-virtual {v6, v7}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v6

    const-string v7, " ratio="

    invoke-virtual {v6, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    invoke-virtual {v6, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v6

    const-string v7, " relative="

    invoke-virtual {v6, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    .line 14329
    invoke-virtual {v2}, Ljava/lang/Float;->floatValue()F

    move-result v7

    div-float/2addr v7, v5

    .line 14328
    const/high16 v5, 0x3f800000    # 1.0f

    invoke-static {v5, v7}, Ljava/lang/Math;->max(FF)F

    move-result v5

    invoke-virtual {v6, v5}, Ljava/lang/StringBuilder;->append(F)Ljava/lang/StringBuilder;

    move-result-object v5

    const-string v6, " master=2 sensorModes=[3,-1,2,0,-1,-1,-1,-1]"

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v5

    .line 14324
    invoke-static {v5}, Llocal/mio/os4camerabridge/HookEntry;->-$$Nest$smlog(Ljava/lang/String;)V

    .line 14335
    .end local v2    # "logicalRatio":Ljava/lang/Float;
    .end local v4    # "signature":Ljava/lang/String;
    :cond_0
    sget-object v2, Landroid/hardware/camera2/CaptureRequest;->CONTROL_CAPTURE_INTENT:Landroid/hardware/camera2/CaptureRequest$Key;

    invoke-virtual {v0, v2}, Landroid/hardware/camera2/CaptureRequest$Builder;->get(Landroid/hardware/camera2/CaptureRequest$Key;)Ljava/lang/Object;

    move-result-object v2

    check-cast v2, Ljava/lang/Integer;

    .line 14336
    .local v2, "intent":Ljava/lang/Integer;
    if-eqz v2, :cond_5

    .line 14337
    invoke-virtual {v2}, Ljava/lang/Integer;->intValue()I

    move-result v4

    const/4 v5, 0x2

    if-eq v4, v5, :cond_1

    goto :goto_0

    .line 14340
    :cond_1
    sget-object v4, Landroid/hardware/camera2/CaptureRequest;->NOISE_REDUCTION_MODE:Landroid/hardware/camera2/CaptureRequest$Key;

    .line 14341
    invoke-static {v5}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v6

    .line 14340
    invoke-virtual {v0, v4, v6}, Landroid/hardware/camera2/CaptureRequest$Builder;->set(Landroid/hardware/camera2/CaptureRequest$Key;Ljava/lang/Object;)V

    .line 14342
    sget-object v4, Landroid/hardware/camera2/CaptureRequest;->EDGE_MODE:Landroid/hardware/camera2/CaptureRequest$Key;

    .line 14343
    invoke-static {v5}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v6

    .line 14342
    invoke-virtual {v0, v4, v6}, Landroid/hardware/camera2/CaptureRequest$Builder;->set(Landroid/hardware/camera2/CaptureRequest$Key;Ljava/lang/Object;)V

    .line 14344
    sget-object v4, Landroid/hardware/camera2/CaptureRequest;->COLOR_CORRECTION_ABERRATION_MODE:Landroid/hardware/camera2/CaptureRequest$Key;

    .line 14345
    invoke-static {v5}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v6

    .line 14344
    invoke-virtual {v0, v4, v6}, Landroid/hardware/camera2/CaptureRequest$Builder;->set(Landroid/hardware/camera2/CaptureRequest$Key;Ljava/lang/Object;)V

    .line 14346
    sget-object v4, Landroid/hardware/camera2/CaptureRequest;->SHADING_MODE:Landroid/hardware/camera2/CaptureRequest$Key;

    .line 14347
    invoke-static {v5}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v5

    .line 14346
    invoke-virtual {v0, v4, v5}, Landroid/hardware/camera2/CaptureRequest$Builder;->set(Landroid/hardware/camera2/CaptureRequest$Key;Ljava/lang/Object;)V

    .line 14348
    invoke-static {}, Llocal/mio/os4camerabridge/HookEntry;->-$$Nest$sfgetactiveCameraId()I

    move-result v4

    invoke-static {v4}, Llocal/mio/os4camerabridge/HookEntry;->-$$Nest$smisRearDirectCaptureCamera(I)Z

    move-result v4

    if-eqz v4, :cond_3

    invoke-static {}, Llocal/mio/os4camerabridge/HookEntry;->-$$Nest$sfgetactiveCameraModule()I

    move-result v4

    const/16 v5, 0xa3

    if-eq v4, v5, :cond_2

    invoke-static {}, Llocal/mio/os4camerabridge/HookEntry;->-$$Nest$sfgetactiveCameraModule()I

    move-result v4

    if-eq v4, v3, :cond_2

    invoke-static {}, Llocal/mio/os4camerabridge/HookEntry;->-$$Nest$sfgetactiveCameraModule()I

    move-result v3

    const/16 v4, 0x100

    if-ne v3, v4, :cond_3

    .line 14352
    :cond_2
    sget-object v3, Landroid/hardware/camera2/CaptureRequest;->CONTROL_ENABLE_ZSL:Landroid/hardware/camera2/CaptureRequest$Key;

    const/4 v4, 0x0

    invoke-static {v4}, Ljava/lang/Boolean;->valueOf(Z)Ljava/lang/Boolean;

    move-result-object v4

    invoke-virtual {v0, v3, v4}, Landroid/hardware/camera2/CaptureRequest$Builder;->set(Landroid/hardware/camera2/CaptureRequest$Key;Ljava/lang/Object;)V

    .line 14353
    sget-object v3, Landroid/hardware/camera2/CaptureRequest;->JPEG_QUALITY:Landroid/hardware/camera2/CaptureRequest$Key;

    const/16 v4, 0x64

    invoke-static {v4}, Ljava/lang/Byte;->valueOf(B)Ljava/lang/Byte;

    move-result-object v4

    invoke-virtual {v0, v3, v4}, Landroid/hardware/camera2/CaptureRequest$Builder;->set(Landroid/hardware/camera2/CaptureRequest$Key;Ljava/lang/Object;)V

    .line 14355
    :cond_3
    invoke-static {}, Llocal/mio/os4camerabridge/HookEntry;->-$$Nest$sfgetloggedStillQuality()Z

    move-result v3

    if-nez v3, :cond_4

    .line 14356
    invoke-static {v1}, Llocal/mio/os4camerabridge/HookEntry;->-$$Nest$sfputloggedStillQuality(Z)V

    .line 14357
    const-string v3, "[StillQuality] still request NR/EDGE/CA/SHADING=HQ"

    invoke-static {v3}, Llocal/mio/os4camerabridge/HookEntry;->-$$Nest$smlog(Ljava/lang/String;)V
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 14364
    .end local v2    # "intent":Ljava/lang/Integer;
    :cond_4
    goto :goto_1

    .line 14338
    .restart local v2    # "intent":Ljava/lang/Integer;
    :cond_5
    :goto_0
    return-void

    .line 14359
    .end local v2    # "intent":Ljava/lang/Integer;
    :catchall_0
    move-exception v2

    .line 14360
    .local v2, "throwable":Ljava/lang/Throwable;
    invoke-static {}, Llocal/mio/os4camerabridge/HookEntry;->-$$Nest$sfgetloggedStillQuality()Z

    move-result v3

    if-nez v3, :cond_6

    .line 14361
    invoke-static {v1}, Llocal/mio/os4camerabridge/HookEntry;->-$$Nest$sfputloggedStillQuality(Z)V

    .line 14362
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "[StillQuality] optional HQ hints partially rejected: "

    invoke-virtual {v1, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-static {v1}, Llocal/mio/os4camerabridge/HookEntry;->-$$Nest$smlog(Ljava/lang/String;)V

    .line 14365
    .end local v2    # "throwable":Ljava/lang/Throwable;
    :cond_6
    :goto_1
    return-void
.end method
