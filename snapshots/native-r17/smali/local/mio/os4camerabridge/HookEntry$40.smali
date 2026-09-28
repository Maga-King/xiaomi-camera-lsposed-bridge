.class Llocal/mio/os4camerabridge/HookEntry$40;
.super Lde/robv/android/xposed/XC_MethodHook;
.source "HookEntry.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Llocal/mio/os4camerabridge/HookEntry;->hookOplusPreviewMetadata()V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# direct methods
.method constructor <init>()V
    .locals 0

    .line 7727
    invoke-direct {p0}, Lde/robv/android/xposed/XC_MethodHook;-><init>()V

    return-void
.end method


# virtual methods
.method protected afterHookedMethod(Lde/robv/android/xposed/XC_MethodHook$MethodHookParam;)V
    .locals 17
    .param p1, "param"    # Lde/robv/android/xposed/XC_MethodHook$MethodHookParam;

    .line 7730
    move-object/from16 v1, p1

    iget-object v0, v1, Lde/robv/android/xposed/XC_MethodHook$MethodHookParam;->thisObject:Ljava/lang/Object;

    instance-of v0, v0, Landroid/hardware/camera2/TotalCaptureResult;

    if-eqz v0, :cond_d

    invoke-static {}, Llocal/mio/os4camerabridge/HookEntry;->-$$Nest$sfgetactiveCameraId()I

    move-result v0

    const/4 v2, 0x1

    if-ne v0, v2, :cond_d

    invoke-static {}, Llocal/mio/os4camerabridge/HookEntry;->-$$Nest$sfgetactiveBeautyModule()I

    move-result v0

    const/16 v3, 0xa3

    if-eq v0, v3, :cond_0

    invoke-static {}, Llocal/mio/os4camerabridge/HookEntry;->-$$Nest$sfgetactiveBeautyModule()I

    move-result v0

    const/16 v3, 0xab

    if-eq v0, v3, :cond_0

    goto/16 :goto_7

    .line 7736
    :cond_0
    iget-object v0, v1, Lde/robv/android/xposed/XC_MethodHook$MethodHookParam;->thisObject:Ljava/lang/Object;

    move-object v3, v0

    check-cast v3, Landroid/hardware/camera2/TotalCaptureResult;

    .line 7739
    .local v3, "result":Landroid/hardware/camera2/TotalCaptureResult;
    :try_start_0
    invoke-static {}, Llocal/mio/os4camerabridge/HookEntry;->-$$Nest$sfgetOPLUS_SENSOR_NAME_RESULT()Landroid/hardware/camera2/CaptureResult$Key;

    move-result-object v0

    invoke-virtual {v3, v0}, Landroid/hardware/camera2/TotalCaptureResult;->get(Landroid/hardware/camera2/CaptureResult$Key;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, [B

    .line 7741
    .local v0, "sensor":[B
    if-eqz v0, :cond_1

    array-length v4, v0

    if-lez v4, :cond_1

    .line 7742
    invoke-virtual {v0}, [B->clone()Ljava/lang/Object;

    move-result-object v4

    check-cast v4, [B

    invoke-static {v4}, Llocal/mio/os4camerabridge/HookEntry;->-$$Nest$sfputlatestFrontSensorName([B)V

    .line 7743
    invoke-static {}, Llocal/mio/os4camerabridge/HookEntry;->-$$Nest$sfgetloggedFrontSensorName()Z

    move-result v4

    if-nez v4, :cond_1

    .line 7744
    invoke-static {v2}, Llocal/mio/os4camerabridge/HookEntry;->-$$Nest$sfputloggedFrontSensorName(Z)V

    .line 7745
    new-instance v4, Ljava/lang/StringBuilder;

    invoke-direct {v4}, Ljava/lang/StringBuilder;-><init>()V

    const-string v5, "[BeautyMeta] front sensor="

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    .line 7746
    invoke-static {v0}, Llocal/mio/os4camerabridge/HookEntry;->-$$Nest$smprintableSensorName([B)Ljava/lang/String;

    move-result-object v5

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    const-string v5, " bytes="

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    array-length v5, v0

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v4

    .line 7745
    invoke-static {v4}, Llocal/mio/os4camerabridge/HookEntry;->-$$Nest$smlog(Ljava/lang/String;)V
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 7752
    .end local v0    # "sensor":[B
    :cond_1
    goto :goto_0

    .line 7750
    :catchall_0
    move-exception v0

    .line 7754
    :goto_0
    :try_start_1
    sget-object v0, Landroid/hardware/camera2/CaptureResult;->SENSOR_TIMESTAMP:Landroid/hardware/camera2/CaptureResult$Key;

    invoke-virtual {v3, v0}, Landroid/hardware/camera2/TotalCaptureResult;->get(Landroid/hardware/camera2/CaptureResult$Key;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/lang/Long;

    .line 7756
    .local v0, "timestamp":Ljava/lang/Long;
    invoke-static {}, Llocal/mio/os4camerabridge/HookEntry;->-$$Nest$sfgetOPLUS_FB_FACE_INFO_RESULT()Landroid/hardware/camera2/CaptureResult$Key;

    move-result-object v4

    invoke-virtual {v3, v4}, Landroid/hardware/camera2/TotalCaptureResult;->get(Landroid/hardware/camera2/CaptureResult$Key;)Ljava/lang/Object;

    move-result-object v4

    check-cast v4, [I

    .line 7758
    .local v4, "faceInfo":[I
    invoke-static {}, Llocal/mio/os4camerabridge/HookEntry;->-$$Nest$sfgetOPLUS_PREVIEW_FFD_RESULT()Landroid/hardware/camera2/CaptureResult$Key;

    move-result-object v5

    invoke-virtual {v3, v5}, Landroid/hardware/camera2/TotalCaptureResult;->get(Landroid/hardware/camera2/CaptureResult$Key;)Ljava/lang/Object;

    move-result-object v5

    check-cast v5, [I

    .line 7760
    .local v5, "ffd":[I
    if-eqz v0, :cond_8

    invoke-virtual {v0}, Ljava/lang/Long;->longValue()J

    move-result-wide v6

    const-wide/16 v8, 0x0

    cmp-long v6, v6, v8

    if-lez v6, :cond_8

    if-nez v4, :cond_2

    goto/16 :goto_3

    .line 7773
    :cond_2
    new-instance v7, Llocal/mio/os4camerabridge/HookEntry$OplusBeautyMetadataFrame;

    .line 7775
    invoke-virtual {v0}, Ljava/lang/Long;->longValue()J

    move-result-wide v8

    .line 7777
    invoke-virtual {v0}, Ljava/lang/Long;->longValue()J

    move-result-wide v10

    .line 7776
    invoke-static {v10, v11, v4}, Llocal/mio/os4camerabridge/HookEntry;->-$$Nest$smpackOplusBeautyMetadata(J[I)[B

    move-result-object v10

    .line 7778
    if-nez v5, :cond_3

    const/4 v6, 0x0

    move-object v11, v6

    goto :goto_1

    .line 7779
    :cond_3
    nop

    .line 7780
    invoke-virtual {v0}, Ljava/lang/Long;->longValue()J

    move-result-wide v11

    .line 7779
    invoke-static {v11, v12, v5}, Llocal/mio/os4camerabridge/HookEntry;->-$$Nest$smpackOplusBeautyMetadata(J[I)[B

    move-result-object v6

    move-object v11, v6

    :goto_1
    array-length v12, v4

    .line 7782
    const/4 v6, -0x1

    if-nez v5, :cond_4

    move v13, v6

    goto :goto_2

    :cond_4
    array-length v13, v5

    .line 7783
    :goto_2
    array-length v14, v4

    if-le v14, v2, :cond_5

    aget v6, v4, v2

    :cond_5
    move v14, v6

    .line 7784
    invoke-static {}, Landroid/os/SystemClock;->elapsedRealtime()J

    move-result-wide v15

    invoke-direct/range {v7 .. v16}, Llocal/mio/os4camerabridge/HookEntry$OplusBeautyMetadataFrame;-><init>(J[B[BIIIJ)V

    .line 7785
    .local v7, "frame":Llocal/mio/os4camerabridge/HookEntry$OplusBeautyMetadataFrame;
    invoke-static {v7}, Llocal/mio/os4camerabridge/HookEntry;->-$$Nest$sfputlatestBeautyMetadata(Llocal/mio/os4camerabridge/HookEntry$OplusBeautyMetadataFrame;)V

    .line 7786
    invoke-static {}, Llocal/mio/os4camerabridge/HookEntry;->-$$Nest$sfgetloggedBeautyMetadataActive()Z

    move-result v6
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_1

    const-string v8, " ints="

    if-nez v6, :cond_6

    .line 7787
    :try_start_2
    invoke-static {v2}, Llocal/mio/os4camerabridge/HookEntry;->-$$Nest$sfputloggedBeautyMetadataActive(Z)V

    .line 7788
    new-instance v6, Ljava/lang/StringBuilder;

    invoke-direct {v6}, Ljava/lang/StringBuilder;-><init>()V

    const-string v9, "[BeautyMeta] face info active ts="

    invoke-virtual {v6, v9}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    invoke-virtual {v6, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v6

    invoke-virtual {v6, v8}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    iget v9, v7, Llocal/mio/os4camerabridge/HookEntry$OplusBeautyMetadataFrame;->faceIntCount:I

    invoke-virtual {v6, v9}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v6

    const-string v9, " faces="

    invoke-virtual {v6, v9}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    iget v9, v7, Llocal/mio/os4camerabridge/HookEntry$OplusBeautyMetadataFrame;->faceCount:I

    invoke-virtual {v6, v9}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v6

    invoke-virtual {v6}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v6

    invoke-static {v6}, Llocal/mio/os4camerabridge/HookEntry;->-$$Nest$smlog(Ljava/lang/String;)V

    .line 7793
    :cond_6
    iget-object v6, v7, Llocal/mio/os4camerabridge/HookEntry$OplusBeautyMetadataFrame;->ffdPayload:[B

    if-eqz v6, :cond_7

    invoke-static {}, Llocal/mio/os4camerabridge/HookEntry;->-$$Nest$sfgetloggedBeautyFfdActive()Z

    move-result v6

    if-nez v6, :cond_7

    .line 7795
    invoke-static {v2}, Llocal/mio/os4camerabridge/HookEntry;->-$$Nest$sfputloggedBeautyFfdActive(Z)V

    .line 7796
    new-instance v6, Ljava/lang/StringBuilder;

    invoke-direct {v6}, Ljava/lang/StringBuilder;-><init>()V

    const-string v9, "[BeautyMeta] ffd active ts="

    invoke-virtual {v6, v9}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    invoke-virtual {v6, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v6

    invoke-virtual {v6, v8}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    iget v8, v7, Llocal/mio/os4camerabridge/HookEntry$OplusBeautyMetadataFrame;->ffdIntCount:I

    invoke-virtual {v6, v8}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v6

    invoke-virtual {v6}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v6

    invoke-static {v6}, Llocal/mio/os4camerabridge/HookEntry;->-$$Nest$smlog(Ljava/lang/String;)V

    .line 7806
    .end local v0    # "timestamp":Ljava/lang/Long;
    .end local v4    # "faceInfo":[I
    .end local v5    # "ffd":[I
    .end local v7    # "frame":Llocal/mio/os4camerabridge/HookEntry$OplusBeautyMetadataFrame;
    :cond_7
    goto :goto_6

    .line 7762
    .restart local v0    # "timestamp":Ljava/lang/Long;
    .restart local v4    # "faceInfo":[I
    .restart local v5    # "ffd":[I
    :cond_8
    :goto_3
    invoke-static {}, Llocal/mio/os4camerabridge/HookEntry;->-$$Nest$sfgetloggedBeautyMetadataWaiting()Z

    move-result v6

    if-nez v6, :cond_b

    .line 7763
    invoke-static {v2}, Llocal/mio/os4camerabridge/HookEntry;->-$$Nest$sfputloggedBeautyMetadataWaiting(Z)V

    .line 7764
    new-instance v6, Ljava/lang/StringBuilder;

    invoke-direct {v6}, Ljava/lang/StringBuilder;-><init>()V

    const-string v7, "[BeautyMeta] waiting sensorTs="

    invoke-virtual {v6, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    invoke-virtual {v6, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v6

    const-string v7, " faceInfo="

    invoke-virtual {v6, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6
    :try_end_2
    .catchall {:try_start_2 .. :try_end_2} :catchall_1

    .line 7766
    const-string v7, "null"

    if-nez v4, :cond_9

    move-object v8, v7

    goto :goto_4

    .line 7767
    :cond_9
    :try_start_3
    array-length v8, v4

    invoke-static {v8}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v8

    :goto_4
    invoke-virtual {v6, v8}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v6

    const-string v8, " ffd="

    invoke-virtual {v6, v8}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    .line 7768
    if-nez v5, :cond_a

    goto :goto_5

    .line 7769
    :cond_a
    array-length v7, v5

    invoke-static {v7}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v7

    :goto_5
    invoke-virtual {v6, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v6

    invoke-virtual {v6}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v6

    .line 7764
    invoke-static {v6}, Llocal/mio/os4camerabridge/HookEntry;->-$$Nest$smlog(Ljava/lang/String;)V
    :try_end_3
    .catchall {:try_start_3 .. :try_end_3} :catchall_1

    .line 7771
    :cond_b
    return-void

    .line 7800
    .end local v0    # "timestamp":Ljava/lang/Long;
    .end local v4    # "faceInfo":[I
    .end local v5    # "ffd":[I
    :catchall_1
    move-exception v0

    .line 7801
    .local v0, "throwable":Ljava/lang/Throwable;
    invoke-static {}, Llocal/mio/os4camerabridge/HookEntry;->-$$Nest$sfgetloggedBeautyMetadataWaiting()Z

    move-result v4

    if-nez v4, :cond_c

    .line 7802
    invoke-static {v2}, Llocal/mio/os4camerabridge/HookEntry;->-$$Nest$sfputloggedBeautyMetadataWaiting(Z)V

    .line 7803
    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v4, "[BeautyMeta] result read failed: "

    invoke-virtual {v2, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-static {v2}, Llocal/mio/os4camerabridge/HookEntry;->-$$Nest$smlog(Ljava/lang/String;)V

    .line 7807
    .end local v0    # "throwable":Ljava/lang/Throwable;
    :cond_c
    :goto_6
    return-void

    .line 7734
    .end local v3    # "result":Landroid/hardware/camera2/TotalCaptureResult;
    :cond_d
    :goto_7
    return-void
.end method
