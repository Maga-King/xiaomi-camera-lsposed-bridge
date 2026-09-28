.class Llocal/mio/os4camerabridge/HookEntry$70;
.super Lde/robv/android/xposed/XC_MethodHook;
.source "HookEntry.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Llocal/mio/os4camerabridge/HookEntry;->hookLeicaCaptureMetadata()V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# direct methods
.method constructor <init>()V
    .locals 0

    .line 11330
    invoke-direct {p0}, Lde/robv/android/xposed/XC_MethodHook;-><init>()V

    return-void
.end method


# virtual methods
.method protected afterHookedMethod(Lde/robv/android/xposed/XC_MethodHook$MethodHookParam;)V
    .locals 21
    .param p1, "param"    # Lde/robv/android/xposed/XC_MethodHook$MethodHookParam;

    .line 11333
    move-object/from16 v1, p1

    const-string v0, ":"

    iget-object v2, v1, Lde/robv/android/xposed/XC_MethodHook$MethodHookParam;->thisObject:Ljava/lang/Object;

    instance-of v2, v2, Landroid/hardware/camera2/TotalCaptureResult;

    if-eqz v2, :cond_10

    invoke-static {}, Llocal/mio/os4camerabridge/HookEntry;->-$$Nest$sfgetactiveBeautyModule()I

    move-result v2

    const/16 v3, 0xa3

    if-eq v2, v3, :cond_0

    goto/16 :goto_d

    .line 11337
    :cond_0
    iget-object v2, v1, Lde/robv/android/xposed/XC_MethodHook$MethodHookParam;->thisObject:Ljava/lang/Object;

    check-cast v2, Landroid/hardware/camera2/TotalCaptureResult;

    .line 11339
    .local v2, "result":Landroid/hardware/camera2/TotalCaptureResult;
    invoke-static {v2}, Llocal/mio/os4camerabridge/HookEntry;->-$$Nest$sfputcommonApsDecisionMetadata(Landroid/hardware/camera2/TotalCaptureResult;)V

    .line 11341
    invoke-static {}, Landroid/os/SystemClock;->elapsedRealtimeNanos()J

    move-result-wide v3

    invoke-static {v3, v4}, Llocal/mio/os4camerabridge/HookEntry;->-$$Nest$sfputcommonApsDecisionMetadataNanos(J)V

    .line 11342
    const/4 v3, 0x3

    new-array v4, v3, [Landroid/hardware/camera2/CaptureResult$Key;

    invoke-static {}, Llocal/mio/os4camerabridge/HookEntry;->-$$Nest$sfgetQTI_AEC_LUX_INDEX()Landroid/hardware/camera2/CaptureResult$Key;

    move-result-object v5

    const/4 v6, 0x0

    aput-object v5, v4, v6

    invoke-static {}, Llocal/mio/os4camerabridge/HookEntry;->-$$Nest$sfgetQTI_CHI_AEC_LUX()Landroid/hardware/camera2/CaptureResult$Key;

    move-result-object v5

    const/4 v7, 0x1

    aput-object v5, v4, v7

    invoke-static {}, Llocal/mio/os4camerabridge/HookEntry;->-$$Nest$sfgetOPLUS_RAW_HDR_LUX_INDEX()Landroid/hardware/camera2/CaptureResult$Key;

    move-result-object v5

    const/4 v8, 0x2

    aput-object v5, v4, v8

    invoke-static {v2, v4}, Llocal/mio/os4camerabridge/HookEntry;->-$$Nest$smfirstResultValue(Landroid/hardware/camera2/CaptureResult;[Landroid/hardware/camera2/CaptureResult$Key;)Ljava/lang/Object;

    move-result-object v4

    check-cast v4, Ljava/lang/Float;

    .line 11346
    .local v4, "lux":Ljava/lang/Float;
    new-array v3, v3, [Landroid/hardware/camera2/CaptureResult$Key;

    invoke-static {}, Llocal/mio/os4camerabridge/HookEntry;->-$$Nest$sfgetQTI_AWB_FRAME_CCT()Landroid/hardware/camera2/CaptureResult$Key;

    move-result-object v5

    aput-object v5, v3, v6

    invoke-static {}, Llocal/mio/os4camerabridge/HookEntry;->-$$Nest$sfgetQTI_AWB_CCT()Landroid/hardware/camera2/CaptureResult$Key;

    move-result-object v5

    aput-object v5, v3, v7

    invoke-static {}, Llocal/mio/os4camerabridge/HookEntry;->-$$Nest$sfgetOPLUS_AWB_SENSOR_CCT()Landroid/hardware/camera2/CaptureResult$Key;

    move-result-object v5

    aput-object v5, v3, v8

    invoke-static {v2, v3}, Llocal/mio/os4camerabridge/HookEntry;->-$$Nest$smfirstResultValue(Landroid/hardware/camera2/CaptureResult;[Landroid/hardware/camera2/CaptureResult$Key;)Ljava/lang/Object;

    move-result-object v3

    check-cast v3, Ljava/lang/Number;

    .line 11350
    .local v3, "cct":Ljava/lang/Number;
    sget-object v5, Landroid/hardware/camera2/CaptureResult;->CONTROL_ZOOM_RATIO:Landroid/hardware/camera2/CaptureResult$Key;

    invoke-static {v2, v5}, Llocal/mio/os4camerabridge/HookEntry;->-$$Nest$smsafeResultValue(Landroid/hardware/camera2/CaptureResult;Landroid/hardware/camera2/CaptureResult$Key;)Ljava/lang/Object;

    move-result-object v5

    check-cast v5, Ljava/lang/Float;

    .line 11352
    .local v5, "zoom":Ljava/lang/Float;
    const/4 v9, 0x0

    if-eqz v4, :cond_1

    invoke-virtual {v4}, Ljava/lang/Float;->floatValue()F

    move-result v10

    invoke-static {v10}, Ljava/lang/Float;->isFinite(F)Z

    move-result v10

    if-eqz v10, :cond_1

    .line 11353
    invoke-virtual {v4}, Ljava/lang/Float;->floatValue()F

    move-result v10

    cmpl-float v10, v10, v9

    if-ltz v10, :cond_1

    .line 11354
    nop

    .line 11355
    invoke-virtual {v4}, Ljava/lang/Float;->floatValue()F

    move-result v10

    invoke-static {v10}, Ljava/lang/Math;->round(F)I

    move-result v10

    const/16 v11, 0x3e7

    invoke-static {v11, v10}, Ljava/lang/Math;->min(II)I

    move-result v10

    .line 11354
    invoke-static {v6, v10}, Ljava/lang/Math;->max(II)I

    move-result v6

    invoke-static {v6}, Llocal/mio/os4camerabridge/HookEntry;->-$$Nest$sfputlatestLeicaLux(I)V

    .line 11357
    :cond_1
    if-eqz v3, :cond_2

    .line 11358
    invoke-virtual {v3}, Ljava/lang/Number;->floatValue()F

    move-result v6

    invoke-static {v6}, Ljava/lang/Math;->round(F)I

    move-result v6

    .line 11359
    .local v6, "value":I
    if-lez v6, :cond_2

    .line 11360
    nop

    .line 11361
    const/16 v10, 0x2710

    invoke-static {v10, v6}, Ljava/lang/Math;->min(II)I

    move-result v10

    .line 11360
    invoke-static {v7, v10}, Ljava/lang/Math;->max(II)I

    move-result v10

    invoke-static {v10}, Llocal/mio/os4camerabridge/HookEntry;->-$$Nest$sfputlatestLeicaCct(I)V

    .line 11364
    .end local v6    # "value":I
    :cond_2
    if-eqz v5, :cond_3

    invoke-virtual {v5}, Ljava/lang/Float;->floatValue()F

    move-result v6

    invoke-static {v6}, Ljava/lang/Float;->isFinite(F)Z

    move-result v6

    if-eqz v6, :cond_3

    .line 11365
    invoke-virtual {v5}, Ljava/lang/Float;->floatValue()F

    move-result v6

    cmpl-float v6, v6, v9

    if-lez v6, :cond_3

    .line 11366
    invoke-virtual {v5}, Ljava/lang/Float;->floatValue()F

    move-result v6

    invoke-static {v6}, Llocal/mio/os4camerabridge/HookEntry;->-$$Nest$sfputlatestLeicaZoom(F)V

    .line 11369
    :cond_3
    :try_start_0
    invoke-virtual {v2}, Landroid/hardware/camera2/TotalCaptureResult;->getRequest()Landroid/hardware/camera2/CaptureRequest;

    move-result-object v6

    .line 11370
    .local v6, "routeRequest":Landroid/hardware/camera2/CaptureRequest;
    if-nez v6, :cond_4

    .line 11371
    const/4 v10, 0x0

    goto :goto_0

    :cond_4
    sget-object v10, Landroid/hardware/camera2/CaptureRequest;->CONTROL_AE_TARGET_FPS_RANGE:Landroid/hardware/camera2/CaptureRequest$Key;

    invoke-virtual {v6, v10}, Landroid/hardware/camera2/CaptureRequest;->get(Landroid/hardware/camera2/CaptureRequest$Key;)Ljava/lang/Object;

    move-result-object v10

    .line 11373
    .local v10, "requestFps":Ljava/lang/Object;
    :goto_0
    sget-object v11, Landroid/hardware/camera2/CaptureResult;->CONTROL_AE_TARGET_FPS_RANGE:Landroid/hardware/camera2/CaptureResult$Key;

    invoke-static {v2, v11}, Llocal/mio/os4camerabridge/HookEntry;->-$$Nest$smsafeResultValue(Landroid/hardware/camera2/CaptureResult;Landroid/hardware/camera2/CaptureResult$Key;)Ljava/lang/Object;

    move-result-object v11

    .line 11376
    .local v11, "resultFps":Ljava/lang/Object;
    sget-object v12, Landroid/hardware/camera2/CaptureResult;->SENSOR_FRAME_DURATION:Landroid/hardware/camera2/CaptureResult$Key;

    invoke-static {v2, v12}, Llocal/mio/os4camerabridge/HookEntry;->-$$Nest$smsafeResultValue(Landroid/hardware/camera2/CaptureResult;Landroid/hardware/camera2/CaptureResult$Key;)Ljava/lang/Object;

    move-result-object v12

    check-cast v12, Ljava/lang/Long;

    .line 11378
    .local v12, "frameDuration":Ljava/lang/Long;
    new-instance v13, Ljava/lang/StringBuilder;

    invoke-direct {v13}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v13, v10}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v13

    invoke-virtual {v13, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v13

    invoke-virtual {v13, v11}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v13

    invoke-virtual {v13, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v13

    invoke-virtual {v13, v12}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v13

    invoke-virtual {v13}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v13

    .line 11380
    .local v13, "fpsSignature":Ljava/lang/String;
    invoke-static {}, Llocal/mio/os4camerabridge/HookEntry;->-$$Nest$sfgetlastPhotoFpsSignature()Ljava/lang/String;

    move-result-object v14

    invoke-virtual {v13, v14}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v14
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_5

    if-nez v14, :cond_7

    .line 11381
    :try_start_1
    invoke-static {v13}, Llocal/mio/os4camerabridge/HookEntry;->-$$Nest$sfputlastPhotoFpsSignature(Ljava/lang/String;)V
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_2

    .line 11383
    if-eqz v12, :cond_6

    :try_start_2
    invoke-virtual {v12}, Ljava/lang/Long;->longValue()J

    move-result-wide v14

    const-wide/16 v16, 0x0

    cmp-long v14, v14, v16

    if-gtz v14, :cond_5

    goto :goto_1

    .line 11385
    :cond_5
    invoke-virtual {v12}, Ljava/lang/Long;->longValue()J

    move-result-wide v14
    :try_end_2
    .catchall {:try_start_2 .. :try_end_2} :catchall_0

    long-to-double v14, v14

    const-wide v16, 0x41cdcd6500000000L    # 1.0E9

    div-double v16, v16, v14

    goto :goto_2

    .line 11439
    .end local v6    # "routeRequest":Landroid/hardware/camera2/CaptureRequest;
    .end local v10    # "requestFps":Ljava/lang/Object;
    .end local v11    # "resultFps":Ljava/lang/Object;
    .end local v12    # "frameDuration":Ljava/lang/Long;
    .end local v13    # "fpsSignature":Ljava/lang/String;
    :catchall_0
    move-exception v0

    move-object/from16 v19, v2

    move/from16 v18, v7

    goto/16 :goto_b

    .line 11384
    .restart local v6    # "routeRequest":Landroid/hardware/camera2/CaptureRequest;
    .restart local v10    # "requestFps":Ljava/lang/Object;
    .restart local v11    # "resultFps":Ljava/lang/Object;
    .restart local v12    # "frameDuration":Ljava/lang/Long;
    .restart local v13    # "fpsSignature":Ljava/lang/String;
    :cond_6
    :goto_1
    const-wide/16 v16, 0x0

    .line 11385
    :goto_2
    nop

    .line 11386
    .local v16, "measuredLimit":D
    :try_start_3
    new-instance v14, Ljava/lang/StringBuilder;

    invoke-direct {v14}, Ljava/lang/StringBuilder;-><init>()V

    const-string v15, "[PhotoFps] request="

    invoke-virtual {v14, v15}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v14

    invoke-virtual {v14, v10}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v14

    const-string v15, " result="

    invoke-virtual {v14, v15}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v14

    invoke-virtual {v14, v11}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v14

    const-string v15, " frameDurationNs="

    invoke-virtual {v14, v15}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v14

    invoke-virtual {v14, v12}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v14

    const-string v15, " maxByDuration="

    invoke-virtual {v14, v15}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v14

    sget-object v15, Ljava/util/Locale;->US:Ljava/util/Locale;
    :try_end_3
    .catchall {:try_start_3 .. :try_end_3} :catchall_2

    move/from16 v18, v7

    :try_start_4
    const-string v7, "%.1f"

    .line 11391
    invoke-static/range {v16 .. v17}, Ljava/lang/Double;->valueOf(D)Ljava/lang/Double;

    move-result-object v19

    move/from16 v20, v8

    filled-new-array/range {v19 .. v19}, [Ljava/lang/Object;

    move-result-object v8

    .line 11390
    invoke-static {v15, v7, v8}, Ljava/lang/String;->format(Ljava/util/Locale;Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v7

    invoke-virtual {v14, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v7

    invoke-virtual {v7}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v7

    .line 11386
    invoke-static {v7}, Llocal/mio/os4camerabridge/HookEntry;->-$$Nest$smlog(Ljava/lang/String;)V
    :try_end_4
    .catchall {:try_start_4 .. :try_end_4} :catchall_1

    goto :goto_4

    .line 11439
    .end local v6    # "routeRequest":Landroid/hardware/camera2/CaptureRequest;
    .end local v10    # "requestFps":Ljava/lang/Object;
    .end local v11    # "resultFps":Ljava/lang/Object;
    .end local v12    # "frameDuration":Ljava/lang/Long;
    .end local v13    # "fpsSignature":Ljava/lang/String;
    .end local v16    # "measuredLimit":D
    :catchall_1
    move-exception v0

    goto :goto_3

    :catchall_2
    move-exception v0

    move/from16 v18, v7

    :goto_3
    move-object/from16 v19, v2

    goto/16 :goto_b

    .line 11380
    .restart local v6    # "routeRequest":Landroid/hardware/camera2/CaptureRequest;
    .restart local v10    # "requestFps":Ljava/lang/Object;
    .restart local v11    # "resultFps":Ljava/lang/Object;
    .restart local v12    # "frameDuration":Ljava/lang/Long;
    .restart local v13    # "fpsSignature":Ljava/lang/String;
    :cond_7
    move/from16 v18, v7

    move/from16 v20, v8

    .line 11393
    :goto_4
    if-nez v6, :cond_8

    .line 11394
    const/4 v7, 0x0

    goto :goto_5

    :cond_8
    :try_start_5
    sget-object v7, Landroid/hardware/camera2/CaptureRequest;->CONTROL_CAPTURE_INTENT:Landroid/hardware/camera2/CaptureRequest$Key;

    invoke-virtual {v6, v7}, Landroid/hardware/camera2/CaptureRequest;->get(Landroid/hardware/camera2/CaptureRequest$Key;)Ljava/lang/Object;

    move-result-object v7

    check-cast v7, Ljava/lang/Integer;

    .line 11396
    .local v7, "routeIntent":Ljava/lang/Integer;
    :goto_5
    if-nez v6, :cond_9

    .line 11397
    const/4 v8, 0x0

    goto :goto_6

    :cond_9
    sget-object v8, Landroid/hardware/camera2/CaptureRequest;->CONTROL_ZOOM_RATIO:Landroid/hardware/camera2/CaptureRequest$Key;

    invoke-virtual {v6, v8}, Landroid/hardware/camera2/CaptureRequest;->get(Landroid/hardware/camera2/CaptureRequest$Key;)Ljava/lang/Object;

    move-result-object v8

    check-cast v8, Ljava/lang/Float;

    .line 11399
    .local v8, "requestZoom":Ljava/lang/Float;
    :goto_6
    sget-object v14, Landroid/hardware/camera2/CaptureResult;->LOGICAL_MULTI_CAMERA_ACTIVE_PHYSICAL_ID:Landroid/hardware/camera2/CaptureResult$Key;

    invoke-static {v2, v14}, Llocal/mio/os4camerabridge/HookEntry;->-$$Nest$smsafeResultValue(Landroid/hardware/camera2/CaptureResult;Landroid/hardware/camera2/CaptureResult$Key;)Ljava/lang/Object;

    move-result-object v14

    check-cast v14, Ljava/lang/String;

    .line 11402
    .local v14, "activePhysical":Ljava/lang/String;
    sget-object v15, Landroid/hardware/camera2/CaptureResult;->LENS_FOCAL_LENGTH:Landroid/hardware/camera2/CaptureResult$Key;

    invoke-static {v2, v15}, Llocal/mio/os4camerabridge/HookEntry;->-$$Nest$smsafeResultValue(Landroid/hardware/camera2/CaptureResult;Landroid/hardware/camera2/CaptureResult$Key;)Ljava/lang/Object;

    move-result-object v15

    check-cast v15, Ljava/lang/Float;

    .line 11404
    .local v15, "focal":Ljava/lang/Float;
    if-nez v6, :cond_a

    .line 11405
    const/4 v9, 0x0

    goto :goto_7

    :cond_a
    invoke-static {}, Llocal/mio/os4camerabridge/HookEntry;->-$$Nest$sfgetOPLUS_ORIGINAL_ZOOM()Landroid/hardware/camera2/CaptureRequest$Key;

    move-result-object v9

    invoke-virtual {v6, v9}, Landroid/hardware/camera2/CaptureRequest;->get(Landroid/hardware/camera2/CaptureRequest$Key;)Ljava/lang/Object;

    move-result-object v9

    check-cast v9, [F

    .line 11407
    .local v9, "originalZoom":[F
    :goto_7
    if-nez v6, :cond_b

    .line 11408
    const/4 v1, 0x0

    goto :goto_8

    :cond_b
    invoke-static {}, Llocal/mio/os4camerabridge/HookEntry;->-$$Nest$sfgetOPLUS_ZOOM_TARGET()Landroid/hardware/camera2/CaptureRequest$Key;

    move-result-object v1

    invoke-virtual {v6, v1}, Landroid/hardware/camera2/CaptureRequest;->get(Landroid/hardware/camera2/CaptureRequest$Key;)Ljava/lang/Object;

    move-result-object v1

    check-cast v1, [F

    .line 11410
    .local v1, "targetZoom":[F
    :goto_8
    if-nez v6, :cond_c

    .line 11411
    move-object/from16 v16, v1

    const/4 v1, 0x0

    goto :goto_9

    :cond_c
    move-object/from16 v16, v1

    .end local v1    # "targetZoom":[F
    .local v16, "targetZoom":[F
    invoke-static {}, Llocal/mio/os4camerabridge/HookEntry;->-$$Nest$sfgetCOMMON_APS_SAT_MASTER_CAMERA()Landroid/hardware/camera2/CaptureRequest$Key;

    move-result-object v1

    invoke-virtual {v6, v1}, Landroid/hardware/camera2/CaptureRequest;->get(Landroid/hardware/camera2/CaptureRequest$Key;)Ljava/lang/Object;

    move-result-object v1

    check-cast v1, [I

    .line 11413
    .local v1, "satMaster":[I
    :goto_9
    move-object/from16 v17, v1

    .end local v1    # "satMaster":[I
    .local v17, "satMaster":[I
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v1, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, v8}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, v14}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, v15}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1
    :try_end_5
    .catchall {:try_start_5 .. :try_end_5} :catchall_4

    .line 11416
    move-object/from16 v19, v2

    .end local v2    # "result":Landroid/hardware/camera2/TotalCaptureResult;
    .local v19, "result":Landroid/hardware/camera2/TotalCaptureResult;
    :try_start_6
    invoke-static {v9}, Ljava/util/Arrays;->toString([F)Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    .line 11417
    invoke-static/range {v16 .. v16}, Ljava/util/Arrays;->toString([F)Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    .line 11418
    invoke-static/range {v17 .. v17}, Ljava/util/Arrays;->toString([I)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    .line 11419
    .local v0, "routeSignature":Ljava/lang/String;
    invoke-static {}, Llocal/mio/os4camerabridge/HookEntry;->-$$Nest$sfgetlastUnifiedPreviewRouteSignature()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-nez v1, :cond_e

    .line 11421
    invoke-static {v0}, Llocal/mio/os4camerabridge/HookEntry;->-$$Nest$sfputlastUnifiedPreviewRouteSignature(Ljava/lang/String;)V

    .line 11423
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "[UnifiedRoute] phase="

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    .line 11426
    nop

    .line 11424
    invoke-static/range {v20 .. v20}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v2

    .line 11426
    invoke-virtual {v2, v7}, Ljava/lang/Integer;->equals(Ljava/lang/Object;)Z

    move-result v2

    if-eqz v2, :cond_d

    .line 11427
    const-string v2, "still"

    goto :goto_a

    :cond_d
    const-string v2, "preview"

    :goto_a
    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, " requestZoom="

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, v8}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, " resultZoom="

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, " active="

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, v14}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, " focal="

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, v15}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, " original="

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    .line 11433
    invoke-static {v9}, Ljava/util/Arrays;->toString([F)Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, " target="

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    .line 11435
    invoke-static/range {v16 .. v16}, Ljava/util/Arrays;->toString([F)Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, " master="

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    .line 11437
    invoke-static/range {v17 .. v17}, Ljava/util/Arrays;->toString([I)Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    .line 11423
    invoke-static {v1}, Llocal/mio/os4camerabridge/HookEntry;->-$$Nest$smlog(Ljava/lang/String;)V
    :try_end_6
    .catchall {:try_start_6 .. :try_end_6} :catchall_3

    .line 11442
    .end local v0    # "routeSignature":Ljava/lang/String;
    .end local v6    # "routeRequest":Landroid/hardware/camera2/CaptureRequest;
    .end local v7    # "routeIntent":Ljava/lang/Integer;
    .end local v8    # "requestZoom":Ljava/lang/Float;
    .end local v9    # "originalZoom":[F
    .end local v10    # "requestFps":Ljava/lang/Object;
    .end local v11    # "resultFps":Ljava/lang/Object;
    .end local v12    # "frameDuration":Ljava/lang/Long;
    .end local v13    # "fpsSignature":Ljava/lang/String;
    .end local v14    # "activePhysical":Ljava/lang/String;
    .end local v15    # "focal":Ljava/lang/Float;
    .end local v16    # "targetZoom":[F
    .end local v17    # "satMaster":[I
    :cond_e
    goto :goto_c

    .line 11439
    :catchall_3
    move-exception v0

    goto :goto_b

    .end local v19    # "result":Landroid/hardware/camera2/TotalCaptureResult;
    .restart local v2    # "result":Landroid/hardware/camera2/TotalCaptureResult;
    :catchall_4
    move-exception v0

    move-object/from16 v19, v2

    goto :goto_b

    :catchall_5
    move-exception v0

    move-object/from16 v19, v2

    move/from16 v18, v7

    .line 11440
    .end local v2    # "result":Landroid/hardware/camera2/TotalCaptureResult;
    .local v0, "routeReadFailure":Ljava/lang/Throwable;
    .restart local v19    # "result":Landroid/hardware/camera2/TotalCaptureResult;
    :goto_b
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "[UnifiedRoute] result read failed: "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-static {v1}, Llocal/mio/os4camerabridge/HookEntry;->-$$Nest$smlog(Ljava/lang/String;)V

    .line 11443
    .end local v0    # "routeReadFailure":Ljava/lang/Throwable;
    :goto_c
    invoke-static {}, Llocal/mio/os4camerabridge/HookEntry;->-$$Nest$sfgetloggedLeicaMetadata()Z

    move-result v0

    if-nez v0, :cond_f

    if-eqz v4, :cond_f

    if-eqz v3, :cond_f

    .line 11445
    invoke-static/range {v18 .. v18}, Llocal/mio/os4camerabridge/HookEntry;->-$$Nest$sfputloggedLeicaMetadata(Z)V

    .line 11446
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "[LeicaMeta] live lux="

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-static {}, Llocal/mio/os4camerabridge/HookEntry;->-$$Nest$sfgetlatestLeicaLux()I

    move-result v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, " cct="

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-static {}, Llocal/mio/os4camerabridge/HookEntry;->-$$Nest$sfgetlatestLeicaCct()I

    move-result v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, " zoom="

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-static {}, Llocal/mio/os4camerabridge/HookEntry;->-$$Nest$sfgetlatestLeicaZoom()F

    move-result v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(F)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Llocal/mio/os4camerabridge/HookEntry;->-$$Nest$smlog(Ljava/lang/String;)V

    .line 11450
    :cond_f
    return-void

    .line 11335
    .end local v3    # "cct":Ljava/lang/Number;
    .end local v4    # "lux":Ljava/lang/Float;
    .end local v5    # "zoom":Ljava/lang/Float;
    .end local v19    # "result":Landroid/hardware/camera2/TotalCaptureResult;
    :cond_10
    :goto_d
    return-void
.end method
