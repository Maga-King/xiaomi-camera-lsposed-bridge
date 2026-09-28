.class Llocal/mio/os4camerabridge/HookEntry$76;
.super Lde/robv/android/xposed/XC_MethodHook;
.source "HookEntry.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Llocal/mio/os4camerabridge/HookEntry;->hookNativeJpegWatermark(Ljava/lang/ClassLoader;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic val$bitmapWatermarkAdapter:Ljava/lang/Class;

.field final synthetic val$inputJpeg:Ljava/lang/ThreadLocal;


# direct methods
.method constructor <init>(Ljava/lang/ThreadLocal;Ljava/lang/Class;)V
    .locals 0

    .line 11841
    iput-object p1, p0, Llocal/mio/os4camerabridge/HookEntry$76;->val$inputJpeg:Ljava/lang/ThreadLocal;

    iput-object p2, p0, Llocal/mio/os4camerabridge/HookEntry$76;->val$bitmapWatermarkAdapter:Ljava/lang/Class;

    invoke-direct {p0}, Lde/robv/android/xposed/XC_MethodHook;-><init>()V

    return-void
.end method


# virtual methods
.method protected afterHookedMethod(Lde/robv/android/xposed/XC_MethodHook$MethodHookParam;)V
    .locals 42
    .param p1, "param"    # Lde/robv/android/xposed/XC_MethodHook$MethodHookParam;

    .line 11864
    move-object/from16 v1, p0

    move-object/from16 v2, p1

    const-string v0, "i"

    const-string v3, "e"

    const-string v4, "f"

    const-string v5, "b"

    const-string v6, "g"

    const-string v7, "d"

    const-string v8, "c"

    iget-object v9, v1, Llocal/mio/os4camerabridge/HookEntry$76;->val$inputJpeg:Ljava/lang/ThreadLocal;

    invoke-virtual {v9}, Ljava/lang/ThreadLocal;->get()Ljava/lang/Object;

    move-result-object v9

    check-cast v9, [B

    .line 11865
    .local v9, "jpegBeforeWater":[B
    iget-object v10, v1, Llocal/mio/os4camerabridge/HookEntry$76;->val$inputJpeg:Ljava/lang/ThreadLocal;

    invoke-virtual {v10}, Ljava/lang/ThreadLocal;->remove()V

    .line 11873
    const/4 v12, 0x1

    .line 11878
    :cond_0
    invoke-virtual {v2}, Lde/robv/android/xposed/XC_MethodHook$MethodHookParam;->hasThrowable()Z

    move-result v10

    if-nez v10, :cond_28

    iget-object v10, v2, Lde/robv/android/xposed/XC_MethodHook$MethodHookParam;->args:[Ljava/lang/Object;

    if-eqz v10, :cond_28

    iget-object v10, v2, Lde/robv/android/xposed/XC_MethodHook$MethodHookParam;->args:[Ljava/lang/Object;

    array-length v10, v10

    if-ne v10, v12, :cond_28

    iget-object v10, v2, Lde/robv/android/xposed/XC_MethodHook$MethodHookParam;->args:[Ljava/lang/Object;

    const/4 v11, 0x0

    aget-object v10, v10, v11

    if-eqz v10, :cond_28

    if-nez v9, :cond_1

    move-object/from16 v30, v9

    goto/16 :goto_1c

    .line 11883
    :cond_1
    iget-object v10, v2, Lde/robv/android/xposed/XC_MethodHook$MethodHookParam;->args:[Ljava/lang/Object;

    aget-object v10, v10, v11

    .line 11884
    .local v10, "task":Ljava/lang/Object;
    const/4 v13, 0x0

    .line 11885
    .local v13, "bitmap":Landroid/graphics/Bitmap;
    const/4 v14, 0x0

    .line 11886
    .local v14, "effectData":Ljava/lang/Object;
    const/4 v15, 0x0

    .line 11887
    .local v15, "captureData":Ljava/lang/Object;
    const/4 v11, -0x1

    .line 11888
    .local v11, "originalQuality":I
    const/16 v17, 0x0

    .line 11889
    .local v17, "bridgedCaptureResult":Z
    const/4 v12, 0x0

    .line 11890
    .local v12, "orientationData":Ljava/lang/Object;
    const/4 v2, 0x0

    .line 11891
    .local v2, "originalTaskOrientation":I
    const/16 v19, 0x0

    .line 11892
    .local v19, "normalizedTaskOrientation":Z
    const/16 v20, 0x0

    .line 11893
    .local v20, "watermarkRendered":Z
    invoke-static {}, Landroid/os/SystemClock;->elapsedRealtime()J

    move-result-wide v21

    .line 11895
    .local v21, "started":J
    move-object/from16 v23, v13

    .end local v13    # "bitmap":Landroid/graphics/Bitmap;
    .local v23, "bitmap":Landroid/graphics/Bitmap;
    :try_start_0
    invoke-static {v10, v5}, Lde/robv/android/xposed/XposedHelpers;->getObjectField(Ljava/lang/Object;Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v24

    move-object/from16 v25, v24

    .line 11897
    .local v25, "auxiliaryData":Ljava/lang/Object;
    move-object/from16 v13, v25

    .end local v25    # "auxiliaryData":Ljava/lang/Object;
    .local v13, "auxiliaryData":Ljava/lang/Object;
    invoke-static {v13, v4}, Lde/robv/android/xposed/XposedHelpers;->getIntField(Ljava/lang/Object;Ljava/lang/String;)I

    move-result v25

    move/from16 v26, v25

    .line 11899
    .local v26, "parallelType":I
    move-object/from16 v25, v13

    .end local v13    # "auxiliaryData":Ljava/lang/Object;
    .restart local v25    # "auxiliaryData":Ljava/lang/Object;
    const-string v13, "l"

    invoke-static {v10, v13}, Lde/robv/android/xposed/XposedHelpers;->getObjectField(Ljava/lang/Object;Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v13

    .line 11901
    .local v13, "waterData":Ljava/lang/Object;
    invoke-static {v13, v3}, Lde/robv/android/xposed/XposedHelpers;->getBooleanField(Ljava/lang/Object;Ljava/lang/String;)Z

    move-result v27
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_21

    if-nez v27, :cond_6

    .line 12029
    if-eqz v19, :cond_2

    if-nez v20, :cond_2

    if-eqz v12, :cond_2

    .line 12032
    :try_start_1
    invoke-static {v12, v7, v2}, Lde/robv/android/xposed/XposedHelpers;->setIntField(Ljava/lang/Object;Ljava/lang/String;I)V
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    .line 12036
    goto :goto_0

    .line 12034
    :catchall_0
    move-exception v0

    .line 12038
    :cond_2
    :goto_0
    if-eqz v17, :cond_3

    if-eqz v15, :cond_3

    .line 12040
    const/4 v3, 0x0

    :try_start_2
    invoke-static {v15, v8, v3}, Lde/robv/android/xposed/XposedHelpers;->setObjectField(Ljava/lang/Object;Ljava/lang/String;Ljava/lang/Object;)V
    :try_end_2
    .catchall {:try_start_2 .. :try_end_2} :catchall_1

    .line 12044
    goto :goto_1

    .line 12042
    :catchall_1
    move-exception v0

    .line 12046
    :cond_3
    :goto_1
    if-eqz v14, :cond_4

    if-ltz v11, :cond_4

    .line 12048
    :try_start_3
    invoke-static {v14, v6, v11}, Lde/robv/android/xposed/XposedHelpers;->setIntField(Ljava/lang/Object;Ljava/lang/String;I)V
    :try_end_3
    .catchall {:try_start_3 .. :try_end_3} :catchall_2

    .line 12052
    goto :goto_2

    .line 12050
    :catchall_2
    move-exception v0

    .line 12054
    :cond_4
    :goto_2
    if-eqz v23, :cond_5

    invoke-virtual/range {v23 .. v23}, Landroid/graphics/Bitmap;->isRecycled()Z

    move-result v0

    if-nez v0, :cond_5

    .line 12055
    invoke-virtual/range {v23 .. v23}, Landroid/graphics/Bitmap;->recycle()V

    .line 11903
    :cond_5
    return-void

    .line 11905
    :cond_6
    move-object/from16 v27, v3

    :try_start_4
    const-string v3, "a"

    invoke-static {v10, v3}, Lde/robv/android/xposed/XposedHelpers;->getObjectField(Ljava/lang/Object;Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v3

    .line 11907
    .local v3, "sourceData":Ljava/lang/Object;
    invoke-static {v3, v0}, Lde/robv/android/xposed/XposedHelpers;->getObjectField(Ljava/lang/Object;Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v28

    check-cast v28, [B

    move-object/from16 v29, v28

    .line 11909
    .local v29, "jpeg":[B
    invoke-static/range {v29 .. v29}, Llocal/mio/os4camerabridge/HookEntry;->-$$Nest$smisJpeg([B)Z

    move-result v28
    :try_end_4
    .catchall {:try_start_4 .. :try_end_4} :catchall_21

    if-nez v28, :cond_b

    .line 11910
    :try_start_5
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v4, "[NativeWatermark] skip non-JPEG type="

    invoke-virtual {v0, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    move/from16 v4, v26

    .end local v26    # "parallelType":I
    .local v4, "parallelType":I
    invoke-virtual {v0, v4}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Llocal/mio/os4camerabridge/HookEntry;->-$$Nest$smlog(Ljava/lang/String;)V
    :try_end_5
    .catchall {:try_start_5 .. :try_end_5} :catchall_6

    .line 12029
    if-eqz v19, :cond_7

    if-nez v20, :cond_7

    if-eqz v12, :cond_7

    .line 12032
    :try_start_6
    invoke-static {v12, v7, v2}, Lde/robv/android/xposed/XposedHelpers;->setIntField(Ljava/lang/Object;Ljava/lang/String;I)V
    :try_end_6
    .catchall {:try_start_6 .. :try_end_6} :catchall_3

    .line 12036
    goto :goto_3

    .line 12034
    :catchall_3
    move-exception v0

    .line 12038
    :cond_7
    :goto_3
    if-eqz v17, :cond_8

    if-eqz v15, :cond_8

    .line 12040
    const/4 v5, 0x0

    :try_start_7
    invoke-static {v15, v8, v5}, Lde/robv/android/xposed/XposedHelpers;->setObjectField(Ljava/lang/Object;Ljava/lang/String;Ljava/lang/Object;)V
    :try_end_7
    .catchall {:try_start_7 .. :try_end_7} :catchall_4

    .line 12044
    goto :goto_4

    .line 12042
    :catchall_4
    move-exception v0

    .line 12046
    :cond_8
    :goto_4
    if-eqz v14, :cond_9

    if-ltz v11, :cond_9

    .line 12048
    :try_start_8
    invoke-static {v14, v6, v11}, Lde/robv/android/xposed/XposedHelpers;->setIntField(Ljava/lang/Object;Ljava/lang/String;I)V
    :try_end_8
    .catchall {:try_start_8 .. :try_end_8} :catchall_5

    .line 12052
    goto :goto_5

    .line 12050
    :catchall_5
    move-exception v0

    .line 12054
    :cond_9
    :goto_5
    if-eqz v23, :cond_a

    invoke-virtual/range {v23 .. v23}, Landroid/graphics/Bitmap;->isRecycled()Z

    move-result v0

    if-nez v0, :cond_a

    .line 12055
    invoke-virtual/range {v23 .. v23}, Landroid/graphics/Bitmap;->recycle()V

    .line 11912
    :cond_a
    return-void

    .line 12024
    .end local v3    # "sourceData":Ljava/lang/Object;
    .end local v4    # "parallelType":I
    .end local v13    # "waterData":Ljava/lang/Object;
    .end local v25    # "auxiliaryData":Ljava/lang/Object;
    .end local v29    # "jpeg":[B
    :catchall_6
    move-exception v0

    move-object v1, v6

    move-object v4, v7

    move-object/from16 v30, v9

    move-object/from16 v13, v23

    goto/16 :goto_14

    .line 11917
    .restart local v3    # "sourceData":Ljava/lang/Object;
    .restart local v13    # "waterData":Ljava/lang/Object;
    .restart local v25    # "auxiliaryData":Ljava/lang/Object;
    .restart local v26    # "parallelType":I
    .restart local v29    # "jpeg":[B
    :cond_b
    move/from16 v1, v26

    .end local v26    # "parallelType":I
    .local v1, "parallelType":I
    move-object/from16 v26, v13

    move-object/from16 v13, v29

    .end local v29    # "jpeg":[B
    .local v13, "jpeg":[B
    .local v26, "waterData":Ljava/lang/Object;
    if-eq v13, v9, :cond_10

    .line 11918
    :try_start_9
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v4, "[NativeWatermark] native Water already replaced type="

    invoke-virtual {v0, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Llocal/mio/os4camerabridge/HookEntry;->-$$Nest$smlog(Ljava/lang/String;)V
    :try_end_9
    .catchall {:try_start_9 .. :try_end_9} :catchall_6

    .line 12029
    if-eqz v19, :cond_c

    if-nez v20, :cond_c

    if-eqz v12, :cond_c

    .line 12032
    :try_start_a
    invoke-static {v12, v7, v2}, Lde/robv/android/xposed/XposedHelpers;->setIntField(Ljava/lang/Object;Ljava/lang/String;I)V
    :try_end_a
    .catchall {:try_start_a .. :try_end_a} :catchall_7

    .line 12036
    goto :goto_6

    .line 12034
    :catchall_7
    move-exception v0

    .line 12038
    :cond_c
    :goto_6
    if-eqz v17, :cond_d

    if-eqz v15, :cond_d

    .line 12040
    const/4 v5, 0x0

    :try_start_b
    invoke-static {v15, v8, v5}, Lde/robv/android/xposed/XposedHelpers;->setObjectField(Ljava/lang/Object;Ljava/lang/String;Ljava/lang/Object;)V
    :try_end_b
    .catchall {:try_start_b .. :try_end_b} :catchall_8

    .line 12044
    goto :goto_7

    .line 12042
    :catchall_8
    move-exception v0

    .line 12046
    :cond_d
    :goto_7
    if-eqz v14, :cond_e

    if-ltz v11, :cond_e

    .line 12048
    :try_start_c
    invoke-static {v14, v6, v11}, Lde/robv/android/xposed/XposedHelpers;->setIntField(Ljava/lang/Object;Ljava/lang/String;I)V
    :try_end_c
    .catchall {:try_start_c .. :try_end_c} :catchall_9

    .line 12052
    goto :goto_8

    .line 12050
    :catchall_9
    move-exception v0

    .line 12054
    :cond_e
    :goto_8
    if-eqz v23, :cond_f

    invoke-virtual/range {v23 .. v23}, Landroid/graphics/Bitmap;->isRecycled()Z

    move-result v0

    if-nez v0, :cond_f

    .line 12055
    invoke-virtual/range {v23 .. v23}, Landroid/graphics/Bitmap;->recycle()V

    .line 11920
    :cond_f
    return-void

    .line 11923
    :cond_10
    :try_start_d
    new-instance v28, Landroid/graphics/BitmapFactory$Options;

    invoke-direct/range {v28 .. v28}, Landroid/graphics/BitmapFactory$Options;-><init>()V
    :try_end_d
    .catchall {:try_start_d .. :try_end_d} :catchall_21

    move-object/from16 v29, v28

    .line 11924
    .local v29, "options":Landroid/graphics/BitmapFactory$Options;
    move/from16 v28, v2

    .end local v2    # "originalTaskOrientation":I
    .local v28, "originalTaskOrientation":I
    :try_start_e
    sget-object v2, Landroid/graphics/Bitmap$Config;->ARGB_8888:Landroid/graphics/Bitmap$Config;
    :try_end_e
    .catchall {:try_start_e .. :try_end_e} :catchall_20

    move-object/from16 v30, v9

    move-object/from16 v9, v29

    .end local v29    # "options":Landroid/graphics/BitmapFactory$Options;
    .local v9, "options":Landroid/graphics/BitmapFactory$Options;
    .local v30, "jpegBeforeWater":[B
    :try_start_f
    iput-object v2, v9, Landroid/graphics/BitmapFactory$Options;->inPreferredConfig:Landroid/graphics/Bitmap$Config;

    .line 11925
    const/4 v2, 0x1

    iput-boolean v2, v9, Landroid/graphics/BitmapFactory$Options;->inMutable:Z

    .line 11926
    array-length v2, v13
    :try_end_f
    .catchall {:try_start_f .. :try_end_f} :catchall_1f

    move/from16 v29, v11

    const/4 v11, 0x0

    .end local v11    # "originalQuality":I
    .local v29, "originalQuality":I
    :try_start_10
    invoke-static {v13, v11, v2, v9}, Landroid/graphics/BitmapFactory;->decodeByteArray([BIILandroid/graphics/BitmapFactory$Options;)Landroid/graphics/Bitmap;

    move-result-object v2
    :try_end_10
    .catchall {:try_start_10 .. :try_end_10} :catchall_1e

    .line 11928
    .end local v23    # "bitmap":Landroid/graphics/Bitmap;
    .local v2, "bitmap":Landroid/graphics/Bitmap;
    if-eqz v2, :cond_1f

    .line 11932
    :try_start_11
    invoke-virtual {v2}, Landroid/graphics/Bitmap;->getWidth()I

    move-result v11

    .line 11933
    .local v11, "bitmapWidth":I
    invoke-virtual {v2}, Landroid/graphics/Bitmap;->getHeight()I

    move-result v23

    move/from16 v31, v23

    .line 11935
    .local v31, "bitmapHeight":I
    invoke-static {v3, v8}, Lde/robv/android/xposed/XposedHelpers;->getIntField(Ljava/lang/Object;Ljava/lang/String;)I

    move-result v23

    move/from16 v32, v23

    .line 11937
    .local v32, "taskOrientation":I
    invoke-static {v3, v7}, Lde/robv/android/xposed/XposedHelpers;->getIntField(Ljava/lang/Object;Ljava/lang/String;)I

    move-result v23
    :try_end_11
    .catchall {:try_start_11 .. :try_end_11} :catchall_1c

    move/from16 v28, v23

    .line 11948
    move-object/from16 v33, v9

    .end local v9    # "options":Landroid/graphics/BitmapFactory$Options;
    .local v33, "options":Landroid/graphics/BitmapFactory$Options;
    :try_start_12
    invoke-static {}, Llocal/mio/os4camerabridge/HookEntry;->-$$Nest$sfgetactiveCameraModule()I

    move-result v9
    :try_end_12
    .catchall {:try_start_12 .. :try_end_12} :catchall_1b

    move-object/from16 v34, v12

    .end local v12    # "orientationData":Ljava/lang/Object;
    .local v34, "orientationData":Ljava/lang/Object;
    const/16 v12, 0xa3

    move-object/from16 v35, v14

    .end local v14    # "effectData":Ljava/lang/Object;
    .local v35, "effectData":Ljava/lang/Object;
    const-string v14, "x"

    if-eq v9, v12, :legendary_aps_orientation

    const/16 v12, 0x100

    if-ne v9, v12, :cond_14

    invoke-static {v3}, Llocal/mio/os4camerabridge/LegendaryNativeCaptureBridge;->isPhotoApsSource(Ljava/lang/Object;)Z

    move-result v9

    if-eqz v9, :cond_14

    :legendary_aps_orientation

    move/from16 v9, v31

    .end local v31    # "bitmapHeight":I
    .local v9, "bitmapHeight":I
    if-le v9, v11, :cond_13

    const/16 v12, 0x5a

    move-object/from16 v31, v15

    move/from16 v15, v28

    .end local v28    # "originalTaskOrientation":I
    .local v15, "originalTaskOrientation":I
    .local v31, "captureData":Ljava/lang/Object;
    if-eq v15, v12, :cond_12

    const/16 v12, 0x10e

    if-ne v15, v12, :cond_11

    goto :goto_9

    :cond_11
    move-object/from16 v36, v13

    move/from16 v28, v32

    goto/16 :goto_a

    .line 11952
    :cond_12
    :goto_9
    move-object v12, v3

    .line 11953
    .end local v34    # "orientationData":Ljava/lang/Object;
    .restart local v12    # "orientationData":Ljava/lang/Object;
    move-object/from16 v23, v12

    const/4 v12, 0x0

    .end local v12    # "orientationData":Ljava/lang/Object;
    .local v23, "orientationData":Ljava/lang/Object;
    :try_start_13
    invoke-static {v3, v7, v12}, Lde/robv/android/xposed/XposedHelpers;->setIntField(Ljava/lang/Object;Ljava/lang/String;I)V

    .line 11954
    const/16 v19, 0x1

    .line 11955
    new-instance v12, Ljava/lang/StringBuilder;

    invoke-direct {v12}, Ljava/lang/StringBuilder;-><init>()V

    move-object/from16 v36, v13

    .end local v13    # "jpeg":[B
    .local v36, "jpeg":[B
    const-string v13, "[NativeWatermark] display-oriented APS portrait "

    invoke-virtual {v12, v13}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v12

    invoke-virtual {v12, v11}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v12

    invoke-virtual {v12, v14}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v12

    invoke-virtual {v12, v9}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v12

    const-string v13, " orientation="

    invoke-virtual {v12, v13}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v12

    move/from16 v13, v32

    .end local v32    # "taskOrientation":I
    .local v13, "taskOrientation":I
    invoke-virtual {v12, v13}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v12

    move/from16 v28, v13

    .end local v13    # "taskOrientation":I
    .local v28, "taskOrientation":I
    const-string v13, " jpegRotation="

    invoke-virtual {v12, v13}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v12

    invoke-virtual {v12, v15}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v12

    const-string v13, " -> 0"

    invoke-virtual {v12, v13}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v12

    invoke-virtual {v12}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v12

    invoke-static {v12}, Llocal/mio/os4camerabridge/HookEntry;->-$$Nest$smlog(Ljava/lang/String;)V
    :try_end_13
    .catchall {:try_start_13 .. :try_end_13} :catchall_a

    move-object/from16 v12, v23

    goto :goto_b

    .line 12024
    .end local v1    # "parallelType":I
    .end local v3    # "sourceData":Ljava/lang/Object;
    .end local v9    # "bitmapHeight":I
    .end local v11    # "bitmapWidth":I
    .end local v25    # "auxiliaryData":Ljava/lang/Object;
    .end local v26    # "waterData":Ljava/lang/Object;
    .end local v28    # "taskOrientation":I
    .end local v33    # "options":Landroid/graphics/BitmapFactory$Options;
    .end local v36    # "jpeg":[B
    :catchall_a
    move-exception v0

    move-object v13, v2

    move-object v1, v6

    move-object v4, v7

    move v2, v15

    move-object/from16 v12, v23

    move/from16 v11, v29

    move-object/from16 v15, v31

    move-object/from16 v14, v35

    goto/16 :goto_14

    .line 11948
    .end local v23    # "orientationData":Ljava/lang/Object;
    .end local v31    # "captureData":Ljava/lang/Object;
    .restart local v1    # "parallelType":I
    .restart local v3    # "sourceData":Ljava/lang/Object;
    .restart local v9    # "bitmapHeight":I
    .restart local v11    # "bitmapWidth":I
    .local v13, "jpeg":[B
    .local v15, "captureData":Ljava/lang/Object;
    .restart local v25    # "auxiliaryData":Ljava/lang/Object;
    .restart local v26    # "waterData":Ljava/lang/Object;
    .local v28, "originalTaskOrientation":I
    .restart local v32    # "taskOrientation":I
    .restart local v33    # "options":Landroid/graphics/BitmapFactory$Options;
    .restart local v34    # "orientationData":Ljava/lang/Object;
    :cond_13
    move-object/from16 v36, v13

    move-object/from16 v31, v15

    move/from16 v15, v28

    move/from16 v28, v32

    .end local v13    # "jpeg":[B
    .end local v32    # "taskOrientation":I
    .local v15, "originalTaskOrientation":I
    .local v28, "taskOrientation":I
    .restart local v31    # "captureData":Ljava/lang/Object;
    .restart local v36    # "jpeg":[B
    goto :goto_a

    .end local v9    # "bitmapHeight":I
    .end local v36    # "jpeg":[B
    .restart local v13    # "jpeg":[B
    .local v15, "captureData":Ljava/lang/Object;
    .local v28, "originalTaskOrientation":I
    .local v31, "bitmapHeight":I
    .restart local v32    # "taskOrientation":I
    :cond_14
    move-object/from16 v36, v13

    move/from16 v9, v31

    move-object/from16 v31, v15

    move/from16 v15, v28

    move/from16 v28, v32

    .line 11965
    .end local v13    # "jpeg":[B
    .end local v32    # "taskOrientation":I
    .restart local v9    # "bitmapHeight":I
    .local v15, "originalTaskOrientation":I
    .local v28, "taskOrientation":I
    .local v31, "captureData":Ljava/lang/Object;
    .restart local v36    # "jpeg":[B
    :goto_a
    move-object/from16 v12, v34

    .end local v34    # "orientationData":Ljava/lang/Object;
    .restart local v12    # "orientationData":Ljava/lang/Object;
    :goto_b
    :try_start_14
    invoke-static {v10, v7}, Lde/robv/android/xposed/XposedHelpers;->getObjectField(Ljava/lang/Object;Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v13
    :try_end_14
    .catchall {:try_start_14 .. :try_end_14} :catchall_1a

    .line 11967
    .end local v35    # "effectData":Ljava/lang/Object;
    .local v13, "effectData":Ljava/lang/Object;
    :try_start_15
    invoke-static {v13, v6}, Lde/robv/android/xposed/XposedHelpers;->getIntField(Ljava/lang/Object;Ljava/lang/String;)I

    move-result v23
    :try_end_15
    .catchall {:try_start_15 .. :try_end_15} :catchall_19

    move/from16 v29, v23

    .line 11969
    move-object/from16 v32, v7

    const/16 v7, 0x64

    :try_start_16
    invoke-static {v13, v6, v7}, Lde/robv/android/xposed/XposedHelpers;->setIntField(Ljava/lang/Object;Ljava/lang/String;I)V

    .line 11970
    invoke-static {v10, v4}, Lde/robv/android/xposed/XposedHelpers;->getObjectField(Ljava/lang/Object;Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v7
    :try_end_16
    .catchall {:try_start_16 .. :try_end_16} :catchall_18

    .line 11972
    .end local v31    # "captureData":Ljava/lang/Object;
    .local v7, "captureData":Ljava/lang/Object;
    :try_start_17
    invoke-static {v7, v8}, Lde/robv/android/xposed/XposedHelpers;->getObjectField(Ljava/lang/Object;Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v23

    .line 11974
    .local v23, "captureResult":Ljava/lang/Object;
    invoke-static {v7, v5}, Lde/robv/android/xposed/XposedHelpers;->getObjectField(Ljava/lang/Object;Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v31

    .line 11976
    .local v31, "totalCaptureResult":Ljava/lang/Object;
    invoke-static {v3, v4}, Lde/robv/android/xposed/XposedHelpers;->getLongField(Ljava/lang/Object;Ljava/lang/String;)J

    move-result-wide v34
    :try_end_17
    .catchall {:try_start_17 .. :try_end_17} :catchall_17

    move-wide/from16 v37, v34

    .line 11978
    .local v37, "taskTimestamp":J
    const/4 v4, 0x0

    .line 11979
    .local v4, "joinedByTimestamp":Z
    if-nez v31, :cond_15

    .line 11980
    move/from16 v34, v4

    .end local v4    # "joinedByTimestamp":Z
    .local v34, "joinedByTimestamp":Z
    :try_start_18
    invoke-static {}, Llocal/mio/os4camerabridge/HookEntry;->-$$Nest$sfgetSTILL_CAPTURE_RESULTS()Ljava/util/Map;

    move-result-object v4
    :try_end_18
    .catchall {:try_start_18 .. :try_end_18} :catchall_c

    .line 11981
    move-object/from16 v39, v6

    :try_start_19
    invoke-static/range {v37 .. v38}, Ljava/lang/Long;->valueOf(J)Ljava/lang/Long;

    move-result-object v6

    invoke-interface {v4, v6}, Ljava/util/Map;->remove(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v4

    check-cast v4, Landroid/hardware/camera2/TotalCaptureResult;

    .line 11982
    .local v4, "cached":Landroid/hardware/camera2/TotalCaptureResult;
    if-eqz v4, :cond_16

    .line 11985
    invoke-static {v7, v5, v4}, Lde/robv/android/xposed/XposedHelpers;->setObjectField(Ljava/lang/Object;Ljava/lang/String;Ljava/lang/Object;)V

    .line 11987
    move-object/from16 v31, v4

    .line 11988
    const/4 v5, 0x1

    move v4, v5

    move-object/from16 v5, v31

    .end local v34    # "joinedByTimestamp":Z
    .local v5, "joinedByTimestamp":Z
    goto :goto_d

    .line 12024
    .end local v1    # "parallelType":I
    .end local v3    # "sourceData":Ljava/lang/Object;
    .end local v4    # "cached":Landroid/hardware/camera2/TotalCaptureResult;
    .end local v5    # "joinedByTimestamp":Z
    .end local v9    # "bitmapHeight":I
    .end local v11    # "bitmapWidth":I
    .end local v23    # "captureResult":Ljava/lang/Object;
    .end local v25    # "auxiliaryData":Ljava/lang/Object;
    .end local v26    # "waterData":Ljava/lang/Object;
    .end local v28    # "taskOrientation":I
    .end local v31    # "totalCaptureResult":Ljava/lang/Object;
    .end local v33    # "options":Landroid/graphics/BitmapFactory$Options;
    .end local v36    # "jpeg":[B
    .end local v37    # "taskTimestamp":J
    :catchall_b
    move-exception v0

    goto :goto_c

    :catchall_c
    move-exception v0

    move-object/from16 v39, v6

    :goto_c
    move-object v14, v13

    move/from16 v11, v29

    move-object/from16 v4, v32

    move-object/from16 v1, v39

    move-object v13, v2

    move v2, v15

    move-object v15, v7

    goto/16 :goto_14

    .line 11979
    .restart local v1    # "parallelType":I
    .restart local v3    # "sourceData":Ljava/lang/Object;
    .local v4, "joinedByTimestamp":Z
    .restart local v9    # "bitmapHeight":I
    .restart local v11    # "bitmapWidth":I
    .restart local v23    # "captureResult":Ljava/lang/Object;
    .restart local v25    # "auxiliaryData":Ljava/lang/Object;
    .restart local v26    # "waterData":Ljava/lang/Object;
    .restart local v28    # "taskOrientation":I
    .restart local v31    # "totalCaptureResult":Ljava/lang/Object;
    .restart local v33    # "options":Landroid/graphics/BitmapFactory$Options;
    .restart local v36    # "jpeg":[B
    .restart local v37    # "taskTimestamp":J
    :cond_15
    move/from16 v34, v4

    move-object/from16 v39, v6

    .line 11991
    .end local v4    # "joinedByTimestamp":Z
    .restart local v34    # "joinedByTimestamp":Z
    :cond_16
    move/from16 v4, v34

    move-object/from16 v5, v31

    .end local v31    # "totalCaptureResult":Ljava/lang/Object;
    .end local v34    # "joinedByTimestamp":Z
    .restart local v4    # "joinedByTimestamp":Z
    .local v5, "totalCaptureResult":Ljava/lang/Object;
    :goto_d
    if-nez v23, :cond_17

    if-eqz v5, :cond_17

    .line 11995
    invoke-static {v7, v8, v5}, Lde/robv/android/xposed/XposedHelpers;->setObjectField(Ljava/lang/Object;Ljava/lang/String;Ljava/lang/Object;)V
    :try_end_19
    .catchall {:try_start_19 .. :try_end_19} :catchall_b

    .line 11997
    move-object/from16 v23, v5

    .line 11998
    const/16 v17, 0x1

    move/from16 v6, v17

    goto :goto_e

    .line 12000
    :cond_17
    move/from16 v6, v17

    .end local v17    # "bridgedCaptureResult":Z
    .local v6, "bridgedCaptureResult":Z
    :goto_e
    move-object/from16 v31, v5

    .end local v5    # "totalCaptureResult":Ljava/lang/Object;
    .restart local v31    # "totalCaptureResult":Ljava/lang/Object;
    :try_start_1a
    const-string v5, "w"
    :try_end_1a
    .catchall {:try_start_1a .. :try_end_1a} :catchall_16

    move-object/from16 v34, v13

    move-object/from16 v13, v26

    .end local v26    # "waterData":Ljava/lang/Object;
    .local v13, "waterData":Ljava/lang/Object;
    .local v34, "effectData":Ljava/lang/Object;
    :try_start_1b
    invoke-static {v13, v5}, Lde/robv/android/xposed/XposedHelpers;->getObjectField(Ljava/lang/Object;Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v5

    check-cast v5, Ljava/lang/String;

    .line 12002
    .local v5, "watermarkId":Ljava/lang/String;
    move-object/from16 v26, v13

    .end local v13    # "waterData":Ljava/lang/Object;
    .restart local v26    # "waterData":Ljava/lang/Object;
    new-instance v13, Ljava/lang/StringBuilder;

    invoke-direct {v13}, Ljava/lang/StringBuilder;-><init>()V
    :try_end_1b
    .catchall {:try_start_1b .. :try_end_1b} :catchall_15

    move-object/from16 v35, v7

    .end local v7    # "captureData":Ljava/lang/Object;
    .local v35, "captureData":Ljava/lang/Object;
    :try_start_1c
    const-string v7, "[NativeWatermark] entering Xiaomi Bitmap adapter type="

    invoke-virtual {v13, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v7

    invoke-virtual {v7, v1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v7

    const-string v13, " captureResult="

    invoke-virtual {v7, v13}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v7

    if-eqz v23, :cond_18

    const/4 v13, 0x1

    goto :goto_f

    :cond_18
    const/4 v13, 0x0

    :goto_f
    invoke-virtual {v7, v13}, Ljava/lang/StringBuilder;->append(Z)Ljava/lang/StringBuilder;

    move-result-object v7

    const-string v13, " bridged="

    invoke-virtual {v7, v13}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v7

    invoke-virtual {v7, v6}, Ljava/lang/StringBuilder;->append(Z)Ljava/lang/StringBuilder;

    move-result-object v7

    const-string v13, " joined="

    invoke-virtual {v7, v13}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v7

    invoke-virtual {v7, v4}, Ljava/lang/StringBuilder;->append(Z)Ljava/lang/StringBuilder;

    move-result-object v7

    const-string v13, " taskTs="

    invoke-virtual {v7, v13}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v7
    :try_end_1c
    .catchall {:try_start_1c .. :try_end_1c} :catchall_14

    move-object/from16 v16, v12

    move-wide/from16 v12, v37

    .end local v37    # "taskTimestamp":J
    .local v12, "taskTimestamp":J
    .local v16, "orientationData":Ljava/lang/Object;
    :try_start_1d
    invoke-virtual {v7, v12, v13}, Ljava/lang/StringBuilder;->append(J)Ljava/lang/StringBuilder;

    move-result-object v7

    move/from16 v18, v4

    .end local v4    # "joinedByTimestamp":Z
    .local v18, "joinedByTimestamp":Z
    const-string v4, " id="

    invoke-virtual {v7, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v4

    invoke-static {v4}, Llocal/mio/os4camerabridge/HookEntry;->-$$Nest$smlog(Ljava/lang/String;)V

    .line 12008
    move-object/from16 v4, p0

    iget-object v7, v4, Llocal/mio/os4camerabridge/HookEntry$76;->val$bitmapWatermarkAdapter:Ljava/lang/Class;

    filled-new-array {v10, v2}, [Ljava/lang/Object;

    move-result-object v4
    :try_end_1d
    .catchall {:try_start_1d .. :try_end_1d} :catchall_13

    move-object/from16 v37, v2

    move-object/from16 v2, v27

    .end local v2    # "bitmap":Landroid/graphics/Bitmap;
    .local v37, "bitmap":Landroid/graphics/Bitmap;
    :try_start_1e
    invoke-static {v7, v2, v4}, Lde/robv/android/xposed/XposedHelpers;->callStaticMethod(Ljava/lang/Class;Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/Object;

    .line 12011
    invoke-static {v3, v0}, Lde/robv/android/xposed/XposedHelpers;->getObjectField(Ljava/lang/Object;Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, [B

    .line 12013
    .local v0, "rendered":[B
    invoke-static {v0}, Llocal/mio/os4camerabridge/HookEntry;->-$$Nest$smisJpeg([B)Z

    move-result v2
    :try_end_1e
    .catchall {:try_start_1e .. :try_end_1e} :catchall_12

    if-eqz v2, :cond_1e

    move-object/from16 v2, v36

    .end local v36    # "jpeg":[B
    .local v2, "jpeg":[B
    if-eq v0, v2, :cond_1d

    .line 12017
    const/16 v20, 0x1

    .line 12018
    :try_start_1f
    new-instance v4, Ljava/lang/StringBuilder;

    invoke-direct {v4}, Ljava/lang/StringBuilder;-><init>()V

    const-string v7, "[NativeWatermark] Xiaomi template rendered type="

    invoke-virtual {v4, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4, v1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v4

    const-string v7, " q=100 bytes="

    invoke-virtual {v4, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    array-length v7, v2

    invoke-virtual {v4, v7}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v4

    const-string v7, "->"

    invoke-virtual {v4, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    array-length v7, v0

    invoke-virtual {v4, v7}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v4

    const-string v7, " size="

    invoke-virtual {v4, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4, v11}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4, v14}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4, v9}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v4

    const-string v7, " costMs="

    invoke-virtual {v4, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    .line 12023
    invoke-static {}, Landroid/os/SystemClock;->elapsedRealtime()J

    move-result-wide v40

    move-object v14, v0

    move v7, v1

    .end local v0    # "rendered":[B
    .end local v1    # "parallelType":I
    .local v7, "parallelType":I
    .local v14, "rendered":[B
    sub-long v0, v40, v21

    invoke-virtual {v4, v0, v1}, Ljava/lang/StringBuilder;->append(J)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    .line 12018
    invoke-static {v0}, Llocal/mio/os4camerabridge/HookEntry;->-$$Nest$smlog(Ljava/lang/String;)V
    :try_end_1f
    .catchall {:try_start_1f .. :try_end_1f} :catchall_10

    .line 12029
    .end local v2    # "jpeg":[B
    .end local v3    # "sourceData":Ljava/lang/Object;
    .end local v5    # "watermarkId":Ljava/lang/String;
    .end local v7    # "parallelType":I
    .end local v9    # "bitmapHeight":I
    .end local v11    # "bitmapWidth":I
    .end local v12    # "taskTimestamp":J
    .end local v14    # "rendered":[B
    .end local v18    # "joinedByTimestamp":Z
    .end local v23    # "captureResult":Ljava/lang/Object;
    .end local v25    # "auxiliaryData":Ljava/lang/Object;
    .end local v26    # "waterData":Ljava/lang/Object;
    .end local v28    # "taskOrientation":I
    .end local v31    # "totalCaptureResult":Ljava/lang/Object;
    .end local v33    # "options":Landroid/graphics/BitmapFactory$Options;
    if-eqz v19, :cond_19

    if-nez v20, :cond_19

    if-eqz v16, :cond_19

    .line 12032
    move-object/from16 v1, v16

    move-object/from16 v4, v32

    .end local v16    # "orientationData":Ljava/lang/Object;
    .local v1, "orientationData":Ljava/lang/Object;
    :try_start_20
    invoke-static {v1, v4, v15}, Lde/robv/android/xposed/XposedHelpers;->setIntField(Ljava/lang/Object;Ljava/lang/String;I)V
    :try_end_20
    .catchall {:try_start_20 .. :try_end_20} :catchall_d

    .line 12036
    goto :goto_10

    .line 12034
    :catchall_d
    move-exception v0

    goto :goto_10

    .line 12029
    .end local v1    # "orientationData":Ljava/lang/Object;
    .restart local v16    # "orientationData":Ljava/lang/Object;
    :cond_19
    move-object/from16 v1, v16

    .line 12038
    .end local v16    # "orientationData":Ljava/lang/Object;
    .restart local v1    # "orientationData":Ljava/lang/Object;
    :goto_10
    if-eqz v6, :cond_1a

    if-eqz v35, :cond_1a

    .line 12040
    move-object/from16 v2, v35

    const/4 v5, 0x0

    .end local v35    # "captureData":Ljava/lang/Object;
    .local v2, "captureData":Ljava/lang/Object;
    :try_start_21
    invoke-static {v2, v8, v5}, Lde/robv/android/xposed/XposedHelpers;->setObjectField(Ljava/lang/Object;Ljava/lang/String;Ljava/lang/Object;)V
    :try_end_21
    .catchall {:try_start_21 .. :try_end_21} :catchall_e

    .line 12044
    goto :goto_11

    .line 12042
    :catchall_e
    move-exception v0

    goto :goto_11

    .line 12038
    .end local v2    # "captureData":Ljava/lang/Object;
    .restart local v35    # "captureData":Ljava/lang/Object;
    :cond_1a
    move-object/from16 v2, v35

    .line 12046
    .end local v35    # "captureData":Ljava/lang/Object;
    .restart local v2    # "captureData":Ljava/lang/Object;
    :goto_11
    if-eqz v34, :cond_1b

    if-ltz v29, :cond_1b

    .line 12048
    move/from16 v3, v29

    move-object/from16 v5, v34

    move-object/from16 v7, v39

    .end local v29    # "originalQuality":I
    .end local v34    # "effectData":Ljava/lang/Object;
    .local v3, "originalQuality":I
    .local v5, "effectData":Ljava/lang/Object;
    :try_start_22
    invoke-static {v5, v7, v3}, Lde/robv/android/xposed/XposedHelpers;->setIntField(Ljava/lang/Object;Ljava/lang/String;I)V
    :try_end_22
    .catchall {:try_start_22 .. :try_end_22} :catchall_f

    .line 12052
    goto :goto_12

    .line 12050
    :catchall_f
    move-exception v0

    goto :goto_12

    .line 12046
    .end local v3    # "originalQuality":I
    .end local v5    # "effectData":Ljava/lang/Object;
    .restart local v29    # "originalQuality":I
    .restart local v34    # "effectData":Ljava/lang/Object;
    :cond_1b
    move/from16 v3, v29

    move-object/from16 v5, v34

    .line 12054
    .end local v29    # "originalQuality":I
    .end local v34    # "effectData":Ljava/lang/Object;
    .restart local v3    # "originalQuality":I
    .restart local v5    # "effectData":Ljava/lang/Object;
    :goto_12
    if-eqz v37, :cond_1c

    invoke-virtual/range {v37 .. v37}, Landroid/graphics/Bitmap;->isRecycled()Z

    move-result v0

    if-nez v0, :cond_1c

    .line 12055
    invoke-virtual/range {v37 .. v37}, Landroid/graphics/Bitmap;->recycle()V

    .line 12058
    :cond_1c
    move-object v12, v1

    move-object v7, v2

    move/from16 v29, v3

    move-object v13, v5

    move/from16 v28, v15

    move-object/from16 v2, v37

    goto/16 :goto_18

    .line 12024
    .end local v1    # "orientationData":Ljava/lang/Object;
    .end local v2    # "captureData":Ljava/lang/Object;
    .end local v3    # "originalQuality":I
    .end local v5    # "effectData":Ljava/lang/Object;
    .restart local v16    # "orientationData":Ljava/lang/Object;
    .restart local v29    # "originalQuality":I
    .restart local v34    # "effectData":Ljava/lang/Object;
    .restart local v35    # "captureData":Ljava/lang/Object;
    :catchall_10
    move-exception v0

    move-object/from16 v1, v16

    move/from16 v3, v29

    move-object/from16 v4, v32

    move-object/from16 v5, v34

    move-object/from16 v2, v35

    move-object/from16 v7, v39

    move v11, v15

    move-object v15, v2

    move v2, v11

    move-object v12, v1

    move v11, v3

    move-object v14, v5

    move/from16 v17, v6

    move-object v1, v7

    move-object/from16 v13, v37

    .end local v16    # "orientationData":Ljava/lang/Object;
    .end local v29    # "originalQuality":I
    .end local v34    # "effectData":Ljava/lang/Object;
    .end local v35    # "captureData":Ljava/lang/Object;
    .restart local v1    # "orientationData":Ljava/lang/Object;
    .restart local v2    # "captureData":Ljava/lang/Object;
    .restart local v3    # "originalQuality":I
    .restart local v5    # "effectData":Ljava/lang/Object;
    goto/16 :goto_14

    .line 12013
    .restart local v0    # "rendered":[B
    .local v1, "parallelType":I
    .local v2, "jpeg":[B
    .local v3, "sourceData":Ljava/lang/Object;
    .local v5, "watermarkId":Ljava/lang/String;
    .restart local v9    # "bitmapHeight":I
    .restart local v11    # "bitmapWidth":I
    .restart local v12    # "taskTimestamp":J
    .restart local v16    # "orientationData":Ljava/lang/Object;
    .restart local v18    # "joinedByTimestamp":Z
    .restart local v23    # "captureResult":Ljava/lang/Object;
    .restart local v25    # "auxiliaryData":Ljava/lang/Object;
    .restart local v26    # "waterData":Ljava/lang/Object;
    .restart local v28    # "taskOrientation":I
    .restart local v29    # "originalQuality":I
    .restart local v31    # "totalCaptureResult":Ljava/lang/Object;
    .restart local v33    # "options":Landroid/graphics/BitmapFactory$Options;
    .restart local v34    # "effectData":Ljava/lang/Object;
    .restart local v35    # "captureData":Ljava/lang/Object;
    :cond_1d
    move-object v14, v0

    move v7, v1

    move-object/from16 v27, v16

    move/from16 v16, v29

    move-object/from16 v4, v32

    move-object/from16 v1, v39

    .end local v0    # "rendered":[B
    .end local v1    # "parallelType":I
    .end local v29    # "originalQuality":I
    .restart local v7    # "parallelType":I
    .restart local v14    # "rendered":[B
    .local v16, "originalQuality":I
    .local v27, "orientationData":Ljava/lang/Object;
    goto :goto_13

    .end local v2    # "jpeg":[B
    .end local v7    # "parallelType":I
    .end local v14    # "rendered":[B
    .end local v27    # "orientationData":Ljava/lang/Object;
    .restart local v0    # "rendered":[B
    .restart local v1    # "parallelType":I
    .local v16, "orientationData":Ljava/lang/Object;
    .restart local v29    # "originalQuality":I
    .restart local v36    # "jpeg":[B
    :cond_1e
    move-object v14, v0

    move v7, v1

    move-object/from16 v27, v16

    move/from16 v16, v29

    move-object/from16 v4, v32

    move-object/from16 v2, v36

    move-object/from16 v1, v39

    .line 12014
    .end local v0    # "rendered":[B
    .end local v1    # "parallelType":I
    .end local v29    # "originalQuality":I
    .end local v36    # "jpeg":[B
    .restart local v2    # "jpeg":[B
    .restart local v7    # "parallelType":I
    .restart local v14    # "rendered":[B
    .local v16, "originalQuality":I
    .restart local v27    # "orientationData":Ljava/lang/Object;
    :goto_13
    :try_start_23
    new-instance v0, Ljava/lang/IllegalStateException;

    move-object/from16 v36, v2

    .end local v2    # "jpeg":[B
    .restart local v36    # "jpeg":[B
    const-string v2, "official Bitmap adapter returned original JPEG"

    invoke-direct {v0, v2}, Ljava/lang/IllegalStateException;-><init>(Ljava/lang/String;)V

    .end local v6    # "bridgedCaptureResult":Z
    .end local v10    # "task":Ljava/lang/Object;
    .end local v15    # "originalTaskOrientation":I
    .end local v16    # "originalQuality":I
    .end local v19    # "normalizedTaskOrientation":Z
    .end local v20    # "watermarkRendered":Z
    .end local v21    # "started":J
    .end local v27    # "orientationData":Ljava/lang/Object;
    .end local v30    # "jpegBeforeWater":[B
    .end local v34    # "effectData":Ljava/lang/Object;
    .end local v35    # "captureData":Ljava/lang/Object;
    .end local v37    # "bitmap":Landroid/graphics/Bitmap;
    .end local p0    # "this":Llocal/mio/os4camerabridge/HookEntry$76;
    .end local p1    # "param":Lde/robv/android/xposed/XC_MethodHook$MethodHookParam;
    throw v0
    :try_end_23
    .catchall {:try_start_23 .. :try_end_23} :catchall_11

    .line 12024
    .end local v3    # "sourceData":Ljava/lang/Object;
    .end local v5    # "watermarkId":Ljava/lang/String;
    .end local v7    # "parallelType":I
    .end local v9    # "bitmapHeight":I
    .end local v11    # "bitmapWidth":I
    .end local v12    # "taskTimestamp":J
    .end local v14    # "rendered":[B
    .end local v18    # "joinedByTimestamp":Z
    .end local v23    # "captureResult":Ljava/lang/Object;
    .end local v25    # "auxiliaryData":Ljava/lang/Object;
    .end local v26    # "waterData":Ljava/lang/Object;
    .end local v28    # "taskOrientation":I
    .end local v31    # "totalCaptureResult":Ljava/lang/Object;
    .end local v33    # "options":Landroid/graphics/BitmapFactory$Options;
    .end local v36    # "jpeg":[B
    .restart local v6    # "bridgedCaptureResult":Z
    .restart local v10    # "task":Ljava/lang/Object;
    .restart local v15    # "originalTaskOrientation":I
    .restart local v16    # "originalQuality":I
    .restart local v19    # "normalizedTaskOrientation":Z
    .restart local v20    # "watermarkRendered":Z
    .restart local v21    # "started":J
    .restart local v27    # "orientationData":Ljava/lang/Object;
    .restart local v30    # "jpegBeforeWater":[B
    .restart local v34    # "effectData":Ljava/lang/Object;
    .restart local v35    # "captureData":Ljava/lang/Object;
    .restart local v37    # "bitmap":Landroid/graphics/Bitmap;
    .restart local p0    # "this":Llocal/mio/os4camerabridge/HookEntry$76;
    .restart local p1    # "param":Lde/robv/android/xposed/XC_MethodHook$MethodHookParam;
    :catchall_11
    move-exception v0

    move/from16 v17, v6

    move v2, v15

    move/from16 v11, v16

    move-object/from16 v12, v27

    move-object/from16 v14, v34

    move-object/from16 v15, v35

    move-object/from16 v13, v37

    goto/16 :goto_14

    .end local v27    # "orientationData":Ljava/lang/Object;
    .local v16, "orientationData":Ljava/lang/Object;
    .restart local v29    # "originalQuality":I
    :catchall_12
    move-exception v0

    move-object/from16 v27, v16

    move/from16 v16, v29

    move-object/from16 v4, v32

    move-object/from16 v1, v39

    move/from16 v17, v6

    move v2, v15

    move/from16 v11, v16

    move-object/from16 v12, v27

    move-object/from16 v14, v34

    move-object/from16 v15, v35

    move-object/from16 v13, v37

    .end local v29    # "originalQuality":I
    .local v16, "originalQuality":I
    .restart local v27    # "orientationData":Ljava/lang/Object;
    goto/16 :goto_14

    .end local v27    # "orientationData":Ljava/lang/Object;
    .end local v37    # "bitmap":Landroid/graphics/Bitmap;
    .local v2, "bitmap":Landroid/graphics/Bitmap;
    .local v16, "orientationData":Ljava/lang/Object;
    .restart local v29    # "originalQuality":I
    :catchall_13
    move-exception v0

    move-object/from16 v37, v2

    move-object/from16 v27, v16

    move/from16 v16, v29

    move-object/from16 v4, v32

    move-object/from16 v1, v39

    move/from16 v17, v6

    move v2, v15

    move/from16 v11, v16

    move-object/from16 v12, v27

    move-object/from16 v14, v34

    move-object/from16 v15, v35

    move-object/from16 v13, v37

    .end local v2    # "bitmap":Landroid/graphics/Bitmap;
    .end local v29    # "originalQuality":I
    .local v16, "originalQuality":I
    .restart local v27    # "orientationData":Ljava/lang/Object;
    .restart local v37    # "bitmap":Landroid/graphics/Bitmap;
    goto/16 :goto_14

    .end local v16    # "originalQuality":I
    .end local v27    # "orientationData":Ljava/lang/Object;
    .end local v37    # "bitmap":Landroid/graphics/Bitmap;
    .restart local v2    # "bitmap":Landroid/graphics/Bitmap;
    .local v12, "orientationData":Ljava/lang/Object;
    .restart local v29    # "originalQuality":I
    :catchall_14
    move-exception v0

    move-object/from16 v37, v2

    move-object/from16 v27, v12

    move/from16 v16, v29

    move-object/from16 v4, v32

    move-object/from16 v1, v39

    move/from16 v17, v6

    move v2, v15

    move/from16 v11, v16

    move-object/from16 v14, v34

    move-object/from16 v15, v35

    move-object/from16 v13, v37

    .end local v2    # "bitmap":Landroid/graphics/Bitmap;
    .end local v12    # "orientationData":Ljava/lang/Object;
    .end local v29    # "originalQuality":I
    .restart local v16    # "originalQuality":I
    .restart local v27    # "orientationData":Ljava/lang/Object;
    .restart local v37    # "bitmap":Landroid/graphics/Bitmap;
    goto/16 :goto_14

    .end local v16    # "originalQuality":I
    .end local v27    # "orientationData":Ljava/lang/Object;
    .end local v35    # "captureData":Ljava/lang/Object;
    .end local v37    # "bitmap":Landroid/graphics/Bitmap;
    .restart local v2    # "bitmap":Landroid/graphics/Bitmap;
    .local v7, "captureData":Ljava/lang/Object;
    .restart local v12    # "orientationData":Ljava/lang/Object;
    .restart local v29    # "originalQuality":I
    :catchall_15
    move-exception v0

    move-object/from16 v37, v2

    move-object/from16 v35, v7

    move-object/from16 v27, v12

    move/from16 v16, v29

    move-object/from16 v4, v32

    move-object/from16 v1, v39

    move/from16 v17, v6

    move v2, v15

    move/from16 v11, v16

    move-object/from16 v14, v34

    move-object/from16 v15, v35

    move-object/from16 v13, v37

    .end local v2    # "bitmap":Landroid/graphics/Bitmap;
    .end local v7    # "captureData":Ljava/lang/Object;
    .end local v12    # "orientationData":Ljava/lang/Object;
    .end local v29    # "originalQuality":I
    .restart local v16    # "originalQuality":I
    .restart local v27    # "orientationData":Ljava/lang/Object;
    .restart local v35    # "captureData":Ljava/lang/Object;
    .restart local v37    # "bitmap":Landroid/graphics/Bitmap;
    goto/16 :goto_14

    .end local v16    # "originalQuality":I
    .end local v27    # "orientationData":Ljava/lang/Object;
    .end local v34    # "effectData":Ljava/lang/Object;
    .end local v35    # "captureData":Ljava/lang/Object;
    .end local v37    # "bitmap":Landroid/graphics/Bitmap;
    .restart local v2    # "bitmap":Landroid/graphics/Bitmap;
    .restart local v7    # "captureData":Ljava/lang/Object;
    .restart local v12    # "orientationData":Ljava/lang/Object;
    .local v13, "effectData":Ljava/lang/Object;
    .restart local v29    # "originalQuality":I
    :catchall_16
    move-exception v0

    move-object/from16 v37, v2

    move-object/from16 v35, v7

    move-object/from16 v27, v12

    move-object/from16 v34, v13

    move/from16 v16, v29

    move-object/from16 v4, v32

    move-object/from16 v1, v39

    move/from16 v17, v6

    move v2, v15

    move/from16 v11, v16

    move-object/from16 v14, v34

    move-object/from16 v15, v35

    move-object/from16 v13, v37

    .end local v2    # "bitmap":Landroid/graphics/Bitmap;
    .end local v7    # "captureData":Ljava/lang/Object;
    .end local v12    # "orientationData":Ljava/lang/Object;
    .end local v13    # "effectData":Ljava/lang/Object;
    .end local v29    # "originalQuality":I
    .restart local v16    # "originalQuality":I
    .restart local v27    # "orientationData":Ljava/lang/Object;
    .restart local v34    # "effectData":Ljava/lang/Object;
    .restart local v35    # "captureData":Ljava/lang/Object;
    .restart local v37    # "bitmap":Landroid/graphics/Bitmap;
    goto/16 :goto_14

    .end local v6    # "bridgedCaptureResult":Z
    .end local v16    # "originalQuality":I
    .end local v27    # "orientationData":Ljava/lang/Object;
    .end local v34    # "effectData":Ljava/lang/Object;
    .end local v35    # "captureData":Ljava/lang/Object;
    .end local v37    # "bitmap":Landroid/graphics/Bitmap;
    .restart local v2    # "bitmap":Landroid/graphics/Bitmap;
    .restart local v7    # "captureData":Ljava/lang/Object;
    .restart local v12    # "orientationData":Ljava/lang/Object;
    .restart local v13    # "effectData":Ljava/lang/Object;
    .restart local v17    # "bridgedCaptureResult":Z
    .restart local v29    # "originalQuality":I
    :catchall_17
    move-exception v0

    move-object/from16 v37, v2

    move-object v1, v6

    move-object/from16 v35, v7

    move-object/from16 v27, v12

    move-object/from16 v34, v13

    move/from16 v16, v29

    move-object/from16 v4, v32

    move v2, v15

    move/from16 v11, v16

    move-object/from16 v14, v34

    move-object/from16 v15, v35

    move-object/from16 v13, v37

    .end local v2    # "bitmap":Landroid/graphics/Bitmap;
    .end local v7    # "captureData":Ljava/lang/Object;
    .end local v12    # "orientationData":Ljava/lang/Object;
    .end local v13    # "effectData":Ljava/lang/Object;
    .end local v29    # "originalQuality":I
    .restart local v16    # "originalQuality":I
    .restart local v27    # "orientationData":Ljava/lang/Object;
    .restart local v34    # "effectData":Ljava/lang/Object;
    .restart local v35    # "captureData":Ljava/lang/Object;
    .restart local v37    # "bitmap":Landroid/graphics/Bitmap;
    goto/16 :goto_14

    .end local v16    # "originalQuality":I
    .end local v27    # "orientationData":Ljava/lang/Object;
    .end local v34    # "effectData":Ljava/lang/Object;
    .end local v35    # "captureData":Ljava/lang/Object;
    .end local v37    # "bitmap":Landroid/graphics/Bitmap;
    .restart local v2    # "bitmap":Landroid/graphics/Bitmap;
    .restart local v12    # "orientationData":Ljava/lang/Object;
    .restart local v13    # "effectData":Ljava/lang/Object;
    .restart local v29    # "originalQuality":I
    .local v31, "captureData":Ljava/lang/Object;
    :catchall_18
    move-exception v0

    move-object/from16 v37, v2

    move-object v1, v6

    move-object/from16 v27, v12

    move-object/from16 v34, v13

    move/from16 v16, v29

    move-object/from16 v4, v32

    move v2, v15

    move/from16 v11, v16

    move-object/from16 v15, v31

    move-object/from16 v14, v34

    move-object/from16 v13, v37

    .end local v2    # "bitmap":Landroid/graphics/Bitmap;
    .end local v12    # "orientationData":Ljava/lang/Object;
    .end local v13    # "effectData":Ljava/lang/Object;
    .end local v29    # "originalQuality":I
    .restart local v16    # "originalQuality":I
    .restart local v27    # "orientationData":Ljava/lang/Object;
    .restart local v34    # "effectData":Ljava/lang/Object;
    .restart local v37    # "bitmap":Landroid/graphics/Bitmap;
    goto/16 :goto_14

    .end local v16    # "originalQuality":I
    .end local v27    # "orientationData":Ljava/lang/Object;
    .end local v34    # "effectData":Ljava/lang/Object;
    .end local v37    # "bitmap":Landroid/graphics/Bitmap;
    .restart local v2    # "bitmap":Landroid/graphics/Bitmap;
    .restart local v12    # "orientationData":Ljava/lang/Object;
    .restart local v13    # "effectData":Ljava/lang/Object;
    .restart local v29    # "originalQuality":I
    :catchall_19
    move-exception v0

    move-object/from16 v37, v2

    move-object v1, v6

    move-object v4, v7

    move-object/from16 v27, v12

    move-object/from16 v34, v13

    move v2, v15

    move/from16 v11, v29

    move-object/from16 v15, v31

    move-object/from16 v14, v34

    move-object/from16 v13, v37

    .end local v2    # "bitmap":Landroid/graphics/Bitmap;
    .end local v12    # "orientationData":Ljava/lang/Object;
    .end local v13    # "effectData":Ljava/lang/Object;
    .restart local v27    # "orientationData":Ljava/lang/Object;
    .restart local v34    # "effectData":Ljava/lang/Object;
    .restart local v37    # "bitmap":Landroid/graphics/Bitmap;
    goto/16 :goto_14

    .end local v27    # "orientationData":Ljava/lang/Object;
    .end local v34    # "effectData":Ljava/lang/Object;
    .end local v37    # "bitmap":Landroid/graphics/Bitmap;
    .restart local v2    # "bitmap":Landroid/graphics/Bitmap;
    .restart local v12    # "orientationData":Ljava/lang/Object;
    .local v35, "effectData":Ljava/lang/Object;
    :catchall_1a
    move-exception v0

    move-object/from16 v37, v2

    move-object v1, v6

    move-object v4, v7

    move-object/from16 v27, v12

    move v2, v15

    move/from16 v11, v29

    move-object/from16 v15, v31

    move-object/from16 v14, v35

    move-object/from16 v13, v37

    .end local v2    # "bitmap":Landroid/graphics/Bitmap;
    .end local v12    # "orientationData":Ljava/lang/Object;
    .restart local v27    # "orientationData":Ljava/lang/Object;
    .restart local v37    # "bitmap":Landroid/graphics/Bitmap;
    goto/16 :goto_14

    .end local v27    # "orientationData":Ljava/lang/Object;
    .end local v31    # "captureData":Ljava/lang/Object;
    .end local v35    # "effectData":Ljava/lang/Object;
    .end local v37    # "bitmap":Landroid/graphics/Bitmap;
    .restart local v2    # "bitmap":Landroid/graphics/Bitmap;
    .restart local v12    # "orientationData":Ljava/lang/Object;
    .local v14, "effectData":Ljava/lang/Object;
    .local v15, "captureData":Ljava/lang/Object;
    .local v28, "originalTaskOrientation":I
    :catchall_1b
    move-exception v0

    move-object/from16 v37, v2

    move-object v1, v6

    move-object v4, v7

    move-object/from16 v34, v12

    move-object/from16 v35, v14

    move-object/from16 v31, v15

    move/from16 v15, v28

    move v2, v15

    move/from16 v11, v29

    move-object/from16 v15, v31

    move-object/from16 v13, v37

    .end local v2    # "bitmap":Landroid/graphics/Bitmap;
    .end local v12    # "orientationData":Ljava/lang/Object;
    .end local v14    # "effectData":Ljava/lang/Object;
    .end local v28    # "originalTaskOrientation":I
    .local v15, "originalTaskOrientation":I
    .restart local v31    # "captureData":Ljava/lang/Object;
    .local v34, "orientationData":Ljava/lang/Object;
    .restart local v35    # "effectData":Ljava/lang/Object;
    .restart local v37    # "bitmap":Landroid/graphics/Bitmap;
    goto/16 :goto_14

    .end local v31    # "captureData":Ljava/lang/Object;
    .end local v34    # "orientationData":Ljava/lang/Object;
    .end local v35    # "effectData":Ljava/lang/Object;
    .end local v37    # "bitmap":Landroid/graphics/Bitmap;
    .restart local v2    # "bitmap":Landroid/graphics/Bitmap;
    .restart local v12    # "orientationData":Ljava/lang/Object;
    .restart local v14    # "effectData":Ljava/lang/Object;
    .local v15, "captureData":Ljava/lang/Object;
    .restart local v28    # "originalTaskOrientation":I
    :catchall_1c
    move-exception v0

    move-object/from16 v37, v2

    move-object v1, v6

    move-object v4, v7

    move-object/from16 v34, v12

    move-object/from16 v35, v14

    move-object/from16 v31, v15

    move/from16 v2, v28

    move/from16 v11, v29

    move-object/from16 v13, v37

    .end local v2    # "bitmap":Landroid/graphics/Bitmap;
    .end local v12    # "orientationData":Ljava/lang/Object;
    .end local v14    # "effectData":Ljava/lang/Object;
    .end local v15    # "captureData":Ljava/lang/Object;
    .restart local v31    # "captureData":Ljava/lang/Object;
    .restart local v34    # "orientationData":Ljava/lang/Object;
    .restart local v35    # "effectData":Ljava/lang/Object;
    .restart local v37    # "bitmap":Landroid/graphics/Bitmap;
    goto/16 :goto_14

    .line 11929
    .end local v31    # "captureData":Ljava/lang/Object;
    .end local v34    # "orientationData":Ljava/lang/Object;
    .end local v35    # "effectData":Ljava/lang/Object;
    .end local v37    # "bitmap":Landroid/graphics/Bitmap;
    .restart local v1    # "parallelType":I
    .restart local v2    # "bitmap":Landroid/graphics/Bitmap;
    .restart local v3    # "sourceData":Ljava/lang/Object;
    .local v9, "options":Landroid/graphics/BitmapFactory$Options;
    .restart local v12    # "orientationData":Ljava/lang/Object;
    .local v13, "jpeg":[B
    .restart local v14    # "effectData":Ljava/lang/Object;
    .restart local v15    # "captureData":Ljava/lang/Object;
    .restart local v25    # "auxiliaryData":Ljava/lang/Object;
    .restart local v26    # "waterData":Ljava/lang/Object;
    :cond_1f
    move-object/from16 v37, v2

    move-object v4, v7

    move-object/from16 v33, v9

    move-object/from16 v34, v12

    move-object/from16 v36, v13

    move-object/from16 v35, v14

    move-object/from16 v31, v15

    move v7, v1

    move-object v1, v6

    .end local v1    # "parallelType":I
    .end local v2    # "bitmap":Landroid/graphics/Bitmap;
    .end local v9    # "options":Landroid/graphics/BitmapFactory$Options;
    .end local v12    # "orientationData":Ljava/lang/Object;
    .end local v13    # "jpeg":[B
    .end local v14    # "effectData":Ljava/lang/Object;
    .end local v15    # "captureData":Ljava/lang/Object;
    .local v7, "parallelType":I
    .restart local v31    # "captureData":Ljava/lang/Object;
    .restart local v33    # "options":Landroid/graphics/BitmapFactory$Options;
    .restart local v34    # "orientationData":Ljava/lang/Object;
    .restart local v35    # "effectData":Ljava/lang/Object;
    .restart local v36    # "jpeg":[B
    .restart local v37    # "bitmap":Landroid/graphics/Bitmap;
    :try_start_24
    new-instance v0, Ljava/lang/IllegalStateException;

    const-string v2, "HAL JPEG decode returned null"

    invoke-direct {v0, v2}, Ljava/lang/IllegalStateException;-><init>(Ljava/lang/String;)V

    .end local v10    # "task":Ljava/lang/Object;
    .end local v17    # "bridgedCaptureResult":Z
    .end local v19    # "normalizedTaskOrientation":Z
    .end local v20    # "watermarkRendered":Z
    .end local v21    # "started":J
    .end local v28    # "originalTaskOrientation":I
    .end local v29    # "originalQuality":I
    .end local v30    # "jpegBeforeWater":[B
    .end local v31    # "captureData":Ljava/lang/Object;
    .end local v34    # "orientationData":Ljava/lang/Object;
    .end local v35    # "effectData":Ljava/lang/Object;
    .end local v37    # "bitmap":Landroid/graphics/Bitmap;
    .end local p0    # "this":Llocal/mio/os4camerabridge/HookEntry$76;
    .end local p1    # "param":Lde/robv/android/xposed/XC_MethodHook$MethodHookParam;
    throw v0
    :try_end_24
    .catchall {:try_start_24 .. :try_end_24} :catchall_1d

    .line 12024
    .end local v3    # "sourceData":Ljava/lang/Object;
    .end local v7    # "parallelType":I
    .end local v25    # "auxiliaryData":Ljava/lang/Object;
    .end local v26    # "waterData":Ljava/lang/Object;
    .end local v33    # "options":Landroid/graphics/BitmapFactory$Options;
    .end local v36    # "jpeg":[B
    .restart local v10    # "task":Ljava/lang/Object;
    .restart local v17    # "bridgedCaptureResult":Z
    .restart local v19    # "normalizedTaskOrientation":Z
    .restart local v20    # "watermarkRendered":Z
    .restart local v21    # "started":J
    .restart local v28    # "originalTaskOrientation":I
    .restart local v29    # "originalQuality":I
    .restart local v30    # "jpegBeforeWater":[B
    .restart local v31    # "captureData":Ljava/lang/Object;
    .restart local v34    # "orientationData":Ljava/lang/Object;
    .restart local v35    # "effectData":Ljava/lang/Object;
    .restart local v37    # "bitmap":Landroid/graphics/Bitmap;
    .restart local p0    # "this":Llocal/mio/os4camerabridge/HookEntry$76;
    .restart local p1    # "param":Lde/robv/android/xposed/XC_MethodHook$MethodHookParam;
    :catchall_1d
    move-exception v0

    move/from16 v2, v28

    move/from16 v11, v29

    move-object/from16 v15, v31

    move-object/from16 v12, v34

    move-object/from16 v14, v35

    move-object/from16 v13, v37

    goto :goto_14

    .end local v31    # "captureData":Ljava/lang/Object;
    .end local v34    # "orientationData":Ljava/lang/Object;
    .end local v35    # "effectData":Ljava/lang/Object;
    .end local v37    # "bitmap":Landroid/graphics/Bitmap;
    .restart local v12    # "orientationData":Ljava/lang/Object;
    .restart local v14    # "effectData":Ljava/lang/Object;
    .restart local v15    # "captureData":Ljava/lang/Object;
    .local v23, "bitmap":Landroid/graphics/Bitmap;
    :catchall_1e
    move-exception v0

    move-object v1, v6

    move-object v4, v7

    move-object/from16 v34, v12

    move-object/from16 v35, v14

    move-object/from16 v31, v15

    move-object/from16 v13, v23

    move/from16 v2, v28

    move/from16 v11, v29

    .end local v12    # "orientationData":Ljava/lang/Object;
    .end local v14    # "effectData":Ljava/lang/Object;
    .end local v15    # "captureData":Ljava/lang/Object;
    .restart local v31    # "captureData":Ljava/lang/Object;
    .restart local v34    # "orientationData":Ljava/lang/Object;
    .restart local v35    # "effectData":Ljava/lang/Object;
    goto :goto_14

    .end local v29    # "originalQuality":I
    .end local v31    # "captureData":Ljava/lang/Object;
    .end local v34    # "orientationData":Ljava/lang/Object;
    .end local v35    # "effectData":Ljava/lang/Object;
    .local v11, "originalQuality":I
    .restart local v12    # "orientationData":Ljava/lang/Object;
    .restart local v14    # "effectData":Ljava/lang/Object;
    .restart local v15    # "captureData":Ljava/lang/Object;
    :catchall_1f
    move-exception v0

    move-object v1, v6

    move-object v4, v7

    move/from16 v29, v11

    move-object/from16 v34, v12

    move-object/from16 v35, v14

    move-object/from16 v31, v15

    move-object/from16 v13, v23

    move/from16 v2, v28

    .end local v11    # "originalQuality":I
    .end local v12    # "orientationData":Ljava/lang/Object;
    .end local v14    # "effectData":Ljava/lang/Object;
    .end local v15    # "captureData":Ljava/lang/Object;
    .restart local v29    # "originalQuality":I
    .restart local v31    # "captureData":Ljava/lang/Object;
    .restart local v34    # "orientationData":Ljava/lang/Object;
    .restart local v35    # "effectData":Ljava/lang/Object;
    goto :goto_14

    .end local v29    # "originalQuality":I
    .end local v30    # "jpegBeforeWater":[B
    .end local v31    # "captureData":Ljava/lang/Object;
    .end local v34    # "orientationData":Ljava/lang/Object;
    .end local v35    # "effectData":Ljava/lang/Object;
    .local v9, "jpegBeforeWater":[B
    .restart local v11    # "originalQuality":I
    .restart local v12    # "orientationData":Ljava/lang/Object;
    .restart local v14    # "effectData":Ljava/lang/Object;
    .restart local v15    # "captureData":Ljava/lang/Object;
    :catchall_20
    move-exception v0

    move-object v1, v6

    move-object v4, v7

    move-object/from16 v30, v9

    move/from16 v29, v11

    move-object/from16 v34, v12

    move-object/from16 v35, v14

    move-object/from16 v31, v15

    move-object/from16 v13, v23

    move/from16 v2, v28

    .end local v9    # "jpegBeforeWater":[B
    .end local v11    # "originalQuality":I
    .end local v12    # "orientationData":Ljava/lang/Object;
    .end local v14    # "effectData":Ljava/lang/Object;
    .end local v15    # "captureData":Ljava/lang/Object;
    .restart local v29    # "originalQuality":I
    .restart local v30    # "jpegBeforeWater":[B
    .restart local v31    # "captureData":Ljava/lang/Object;
    .restart local v34    # "orientationData":Ljava/lang/Object;
    .restart local v35    # "effectData":Ljava/lang/Object;
    goto :goto_14

    .end local v28    # "originalTaskOrientation":I
    .end local v29    # "originalQuality":I
    .end local v30    # "jpegBeforeWater":[B
    .end local v31    # "captureData":Ljava/lang/Object;
    .end local v34    # "orientationData":Ljava/lang/Object;
    .end local v35    # "effectData":Ljava/lang/Object;
    .local v2, "originalTaskOrientation":I
    .restart local v9    # "jpegBeforeWater":[B
    .restart local v11    # "originalQuality":I
    .restart local v12    # "orientationData":Ljava/lang/Object;
    .restart local v14    # "effectData":Ljava/lang/Object;
    .restart local v15    # "captureData":Ljava/lang/Object;
    :catchall_21
    move-exception v0

    move/from16 v28, v2

    move-object v1, v6

    move-object v4, v7

    move-object/from16 v30, v9

    move/from16 v29, v11

    move-object/from16 v34, v12

    move-object/from16 v35, v14

    move-object/from16 v31, v15

    move-object/from16 v13, v23

    .line 12027
    .end local v9    # "jpegBeforeWater":[B
    .end local v23    # "bitmap":Landroid/graphics/Bitmap;
    .local v0, "throwable":Ljava/lang/Throwable;
    .local v13, "bitmap":Landroid/graphics/Bitmap;
    .restart local v30    # "jpegBeforeWater":[B
    :goto_14
    :try_start_25
    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    const-string v5, "[NativeWatermark] original retained: "

    invoke-virtual {v3, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    invoke-static {v3}, Llocal/mio/os4camerabridge/HookEntry;->-$$Nest$smlog(Ljava/lang/String;)V
    :try_end_25
    .catchall {:try_start_25 .. :try_end_25} :catchall_25

    .line 12029
    .end local v0    # "throwable":Ljava/lang/Throwable;
    if-eqz v19, :cond_20

    if-nez v20, :cond_20

    if-eqz v12, :cond_20

    .line 12032
    :try_start_26
    invoke-static {v12, v4, v2}, Lde/robv/android/xposed/XposedHelpers;->setIntField(Ljava/lang/Object;Ljava/lang/String;I)V
    :try_end_26
    .catchall {:try_start_26 .. :try_end_26} :catchall_22

    .line 12036
    goto :goto_15

    .line 12034
    :catchall_22
    move-exception v0

    .line 12038
    :cond_20
    :goto_15
    if-eqz v17, :cond_21

    if-eqz v15, :cond_21

    .line 12040
    const/4 v5, 0x0

    :try_start_27
    invoke-static {v15, v8, v5}, Lde/robv/android/xposed/XposedHelpers;->setObjectField(Ljava/lang/Object;Ljava/lang/String;Ljava/lang/Object;)V
    :try_end_27
    .catchall {:try_start_27 .. :try_end_27} :catchall_23

    .line 12044
    goto :goto_16

    .line 12042
    :catchall_23
    move-exception v0

    .line 12046
    :cond_21
    :goto_16
    if-eqz v14, :cond_22

    if-ltz v11, :cond_22

    .line 12048
    :try_start_28
    invoke-static {v14, v1, v11}, Lde/robv/android/xposed/XposedHelpers;->setIntField(Ljava/lang/Object;Ljava/lang/String;I)V
    :try_end_28
    .catchall {:try_start_28 .. :try_end_28} :catchall_24

    .line 12052
    goto :goto_17

    .line 12050
    :catchall_24
    move-exception v0

    .line 12054
    :cond_22
    :goto_17
    if-eqz v13, :cond_23

    invoke-virtual {v13}, Landroid/graphics/Bitmap;->isRecycled()Z

    move-result v0

    if-nez v0, :cond_23

    .line 12055
    invoke-virtual {v13}, Landroid/graphics/Bitmap;->recycle()V

    .line 12058
    :cond_23
    move/from16 v28, v2

    move/from16 v29, v11

    move-object v2, v13

    move-object v13, v14

    move-object v7, v15

    move/from16 v6, v17

    .end local v11    # "originalQuality":I
    .end local v14    # "effectData":Ljava/lang/Object;
    .end local v15    # "captureData":Ljava/lang/Object;
    .end local v17    # "bridgedCaptureResult":Z
    .local v2, "bitmap":Landroid/graphics/Bitmap;
    .restart local v6    # "bridgedCaptureResult":Z
    .local v7, "captureData":Ljava/lang/Object;
    .local v13, "effectData":Ljava/lang/Object;
    .restart local v28    # "originalTaskOrientation":I
    .restart local v29    # "originalQuality":I
    :goto_18
    return-void

    .line 12029
    .end local v6    # "bridgedCaptureResult":Z
    .end local v7    # "captureData":Ljava/lang/Object;
    .end local v28    # "originalTaskOrientation":I
    .end local v29    # "originalQuality":I
    .local v2, "originalTaskOrientation":I
    .restart local v11    # "originalQuality":I
    .local v13, "bitmap":Landroid/graphics/Bitmap;
    .restart local v14    # "effectData":Ljava/lang/Object;
    .restart local v15    # "captureData":Ljava/lang/Object;
    .restart local v17    # "bridgedCaptureResult":Z
    :catchall_25
    move-exception v0

    move-object v3, v0

    if-eqz v19, :cond_24

    if-nez v20, :cond_24

    if-eqz v12, :cond_24

    .line 12032
    :try_start_29
    invoke-static {v12, v4, v2}, Lde/robv/android/xposed/XposedHelpers;->setIntField(Ljava/lang/Object;Ljava/lang/String;I)V
    :try_end_29
    .catchall {:try_start_29 .. :try_end_29} :catchall_26

    .line 12036
    goto :goto_19

    .line 12034
    :catchall_26
    move-exception v0

    .line 12038
    :cond_24
    :goto_19
    if-eqz v17, :cond_25

    if-eqz v15, :cond_25

    .line 12040
    const/4 v5, 0x0

    :try_start_2a
    invoke-static {v15, v8, v5}, Lde/robv/android/xposed/XposedHelpers;->setObjectField(Ljava/lang/Object;Ljava/lang/String;Ljava/lang/Object;)V
    :try_end_2a
    .catchall {:try_start_2a .. :try_end_2a} :catchall_27

    .line 12044
    goto :goto_1a

    .line 12042
    :catchall_27
    move-exception v0

    .line 12046
    :cond_25
    :goto_1a
    if-eqz v14, :cond_26

    if-ltz v11, :cond_26

    .line 12048
    :try_start_2b
    invoke-static {v14, v1, v11}, Lde/robv/android/xposed/XposedHelpers;->setIntField(Ljava/lang/Object;Ljava/lang/String;I)V
    :try_end_2b
    .catchall {:try_start_2b .. :try_end_2b} :catchall_28

    .line 12052
    goto :goto_1b

    .line 12050
    :catchall_28
    move-exception v0

    .line 12054
    :cond_26
    :goto_1b
    if-eqz v13, :cond_27

    invoke-virtual {v13}, Landroid/graphics/Bitmap;->isRecycled()Z

    move-result v0

    if-nez v0, :cond_27

    .line 12055
    invoke-virtual {v13}, Landroid/graphics/Bitmap;->recycle()V

    .line 12057
    :cond_27
    throw v3

    .line 11878
    .end local v2    # "originalTaskOrientation":I
    .end local v10    # "task":Ljava/lang/Object;
    .end local v11    # "originalQuality":I
    .end local v12    # "orientationData":Ljava/lang/Object;
    .end local v13    # "bitmap":Landroid/graphics/Bitmap;
    .end local v14    # "effectData":Ljava/lang/Object;
    .end local v15    # "captureData":Ljava/lang/Object;
    .end local v17    # "bridgedCaptureResult":Z
    .end local v19    # "normalizedTaskOrientation":Z
    .end local v20    # "watermarkRendered":Z
    .end local v21    # "started":J
    .end local v30    # "jpegBeforeWater":[B
    .restart local v9    # "jpegBeforeWater":[B
    :cond_28
    move-object/from16 v30, v9

    .line 11881
    .end local v9    # "jpegBeforeWater":[B
    .restart local v30    # "jpegBeforeWater":[B
    :goto_1c
    return-void
.end method

.method protected beforeHookedMethod(Lde/robv/android/xposed/XC_MethodHook$MethodHookParam;)V
    .locals 3
    .param p1, "param"    # Lde/robv/android/xposed/XC_MethodHook$MethodHookParam;

    .line 11844
    iget-object v0, p0, Llocal/mio/os4camerabridge/HookEntry$76;->val$inputJpeg:Ljava/lang/ThreadLocal;

    invoke-virtual {v0}, Ljava/lang/ThreadLocal;->remove()V

    .line 11846
    :try_start_0
    iget-object v0, p1, Lde/robv/android/xposed/XC_MethodHook$MethodHookParam;->args:[Ljava/lang/Object;

    if-eqz v0, :cond_2

    iget-object v0, p1, Lde/robv/android/xposed/XC_MethodHook$MethodHookParam;->args:[Ljava/lang/Object;

    array-length v0, v0

    const/4 v1, 0x1

    if-ne v0, v1, :cond_2

    iget-object v0, p1, Lde/robv/android/xposed/XC_MethodHook$MethodHookParam;->args:[Ljava/lang/Object;

    const/4 v1, 0x0

    aget-object v0, v0, v1

    if-nez v0, :cond_0

    goto :goto_0

    .line 11850
    :cond_0
    iget-object v0, p1, Lde/robv/android/xposed/XC_MethodHook$MethodHookParam;->args:[Ljava/lang/Object;

    aget-object v0, v0, v1

    const-string v1, "a"

    invoke-static {v0, v1}, Lde/robv/android/xposed/XposedHelpers;->getObjectField(Ljava/lang/Object;Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v0

    .line 11852
    .local v0, "sourceData":Ljava/lang/Object;
    const-string v1, "i"

    invoke-static {v0, v1}, Lde/robv/android/xposed/XposedHelpers;->getObjectField(Ljava/lang/Object;Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v1

    check-cast v1, [B

    .line 11854
    .local v1, "jpeg":[B
    invoke-static {v1}, Llocal/mio/os4camerabridge/HookEntry;->-$$Nest$smisJpeg([B)Z

    move-result v2

    if-eqz v2, :cond_1

    .line 11855
    iget-object v2, p0, Llocal/mio/os4camerabridge/HookEntry$76;->val$inputJpeg:Ljava/lang/ThreadLocal;

    invoke-virtual {v2, v1}, Ljava/lang/ThreadLocal;->set(Ljava/lang/Object;)V
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 11859
    .end local v0    # "sourceData":Ljava/lang/Object;
    .end local v1    # "jpeg":[B
    :cond_1
    goto :goto_1

    .line 11848
    :cond_2
    :goto_0
    return-void

    .line 11857
    :catchall_0
    move-exception v0

    .line 11858
    .local v0, "ignored":Ljava/lang/Throwable;
    iget-object v1, p0, Llocal/mio/os4camerabridge/HookEntry$76;->val$inputJpeg:Ljava/lang/ThreadLocal;

    invoke-virtual {v1}, Ljava/lang/ThreadLocal;->remove()V

    .line 11860
    .end local v0    # "ignored":Ljava/lang/Throwable;
    :goto_1
    return-void
.end method
