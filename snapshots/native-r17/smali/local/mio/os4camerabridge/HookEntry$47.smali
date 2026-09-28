.class Llocal/mio/os4camerabridge/HookEntry$47;
.super Lde/robv/android/xposed/XC_MethodHook;
.source "HookEntry.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Llocal/mio/os4camerabridge/HookEntry;->hookLegendaryPhysicalLensRestart(Ljava/lang/ClassLoader;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic val$startControl:Ljava/lang/Class;

.field final synthetic val$zoomData:Ljava/lang/Class;


# direct methods
.method constructor <init>(Ljava/lang/Class;Ljava/lang/Class;)V
    .locals 0

    .line 8779
    iput-object p1, p0, Llocal/mio/os4camerabridge/HookEntry$47;->val$zoomData:Ljava/lang/Class;

    iput-object p2, p0, Llocal/mio/os4camerabridge/HookEntry$47;->val$startControl:Ljava/lang/Class;

    invoke-direct {p0}, Lde/robv/android/xposed/XC_MethodHook;-><init>()V

    return-void
.end method


# virtual methods
.method protected beforeHookedMethod(Lde/robv/android/xposed/XC_MethodHook$MethodHookParam;)V
    .locals 19
    .param p1, "param"    # Lde/robv/android/xposed/XC_MethodHook$MethodHookParam;

    .line 8783
    move-object/from16 v1, p0

    move-object/from16 v2, p1

    invoke-static {}, Llocal/mio/os4camerabridge/HookEntry;->-$$Nest$sfgetactiveCameraModule()I

    move-result v0

    const/16 v3, 0x100

    .line 8818
    invoke-static {v3}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v4

    .line 8783
    if-ne v0, v3, :cond_6

    iget-object v0, v2, Lde/robv/android/xposed/XC_MethodHook$MethodHookParam;->args:[Ljava/lang/Object;

    if-eqz v0, :cond_6

    iget-object v0, v2, Lde/robv/android/xposed/XC_MethodHook$MethodHookParam;->args:[Ljava/lang/Object;

    array-length v0, v0

    const/4 v3, 0x1

    if-lt v0, v3, :cond_6

    iget-object v0, v2, Lde/robv/android/xposed/XC_MethodHook$MethodHookParam;->args:[Ljava/lang/Object;

    const/4 v5, 0x0

    aget-object v0, v0, v5

    instance-of v0, v0, Ljava/lang/Integer;

    if-nez v0, :cond_0

    goto/16 :goto_4

    .line 8790
    :cond_0
    :try_start_0
    iget-object v0, v2, Lde/robv/android/xposed/XC_MethodHook$MethodHookParam;->args:[Ljava/lang/Object;

    aget-object v0, v0, v5

    check-cast v0, Ljava/lang/Integer;

    invoke-virtual {v0}, Ljava/lang/Integer;->intValue()I

    move-result v0

    .line 8791
    .local v0, "childIndex":I
    iget-object v8, v2, Lde/robv/android/xposed/XC_MethodHook$MethodHookParam;->thisObject:Ljava/lang/Object;

    const-string v9, "j"

    invoke-static {v8, v9}, Lde/robv/android/xposed/XposedHelpers;->getObjectField(Ljava/lang/Object;Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v8

    .line 8793
    .local v8, "zoomView":Ljava/lang/Object;
    const-string v9, "getChildAt"

    .line 8794
    invoke-static {v0}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v10

    filled-new-array {v10}, [Ljava/lang/Object;

    move-result-object v10

    .line 8793
    invoke-static {v8, v9, v10}, Lde/robv/android/xposed/XposedHelpers;->callMethod(Ljava/lang/Object;Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v9

    .line 8795
    .local v9, "child":Ljava/lang/Object;
    const-string v10, "getZoomRatio"

    new-array v11, v5, [Ljava/lang/Object;

    invoke-static {v9, v10, v11}, Lde/robv/android/xposed/XposedHelpers;->callMethod(Ljava/lang/Object;Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v10

    .line 8797
    .local v10, "value":Ljava/lang/Object;
    instance-of v11, v10, Ljava/lang/Float;

    if-nez v11, :cond_1

    .line 8798
    return-void

    .line 8800
    :cond_1
    move-object v11, v10

    check-cast v11, Ljava/lang/Float;

    invoke-virtual {v11}, Ljava/lang/Float;->floatValue()F

    move-result v11

    .line 8801
    .local v11, "targetZoom":F
    const/high16 v12, 0x3f800000    # 1.0f

    cmpg-float v12, v11, v12

    if-gez v12, :cond_2

    .line 8802
    invoke-static {}, Llocal/mio/os4camerabridge/HookEntry;->-$$Nest$sfgetrearUltraWidePhysicalCameraId()I

    move-result v12

    goto :goto_0

    .line 8803
    :cond_2
    const/high16 v12, 0x40400000    # 3.0f

    cmpl-float v12, v11, v12

    if-ltz v12, :cond_3

    .line 8804
    invoke-static {}, Llocal/mio/os4camerabridge/HookEntry;->-$$Nest$sfgetrearTelePhysicalCameraId()I

    move-result v12

    goto :goto_0

    .line 8805
    :cond_3
    invoke-static {}, Llocal/mio/os4camerabridge/HookEntry;->-$$Nest$sfgetrearMainPhysicalCameraId()I

    move-result v12

    :goto_0
    nop

    .line 8806
    .local v12, "targetCamera":I
    invoke-static {}, Llocal/mio/os4camerabridge/HookEntry;->-$$Nest$sfgetactiveCameraId()I

    move-result v13

    if-ne v13, v12, :cond_4

    .line 8807
    return-void

    .line 8813
    :cond_4
    const/4 v13, 0x0

    invoke-virtual {v2, v13}, Lde/robv/android/xposed/XC_MethodHook$MethodHookParam;->setResult(Ljava/lang/Object;)V

    .line 8814
    invoke-static {v11}, Llocal/mio/os4camerabridge/HookEntry;->-$$Nest$sfputpendingLegendPhysicalZoom(F)V

    .line 8815
    invoke-static {v12}, Llocal/mio/os4camerabridge/HookEntry;->-$$Nest$sfputpendingLegendPhysicalCameraId(I)V

    .line 8816
    iget-object v13, v1, Llocal/mio/os4camerabridge/HookEntry$47;->val$zoomData:Ljava/lang/Class;

    const-string v14, "C0"
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_2

    const/4 v15, 0x2

    const/16 v16, -0x1

    :try_start_1
    new-array v6, v15, [Ljava/lang/Class;

    sget-object v17, Ljava/lang/Float;->TYPE:Ljava/lang/Class;

    aput-object v17, v6, v5

    sget-object v17, Ljava/lang/Integer;->TYPE:Ljava/lang/Class;

    aput-object v17, v6, v3
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_1

    .line 8818
    const/high16 v17, 0x7fc00000    # Float.NaN

    :try_start_2
    invoke-static {v11}, Ljava/lang/Float;->valueOf(F)Ljava/lang/Float;

    move-result-object v7

    filled-new-array {v7, v4}, [Ljava/lang/Object;

    move-result-object v7

    .line 8816
    invoke-static {v13, v14, v6, v7}, Lde/robv/android/xposed/XposedHelpers;->callStaticMethod(Ljava/lang/Class;Ljava/lang/String;[Ljava/lang/Class;[Ljava/lang/Object;)Ljava/lang/Object;

    .line 8820
    iget-object v6, v2, Lde/robv/android/xposed/XC_MethodHook$MethodHookParam;->thisObject:Ljava/lang/Object;

    const-string v7, "getActivity"

    new-array v13, v5, [Ljava/lang/Object;

    invoke-static {v6, v7, v13}, Lde/robv/android/xposed/XposedHelpers;->callMethod(Ljava/lang/Object;Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v6

    .line 8822
    .local v6, "activity":Ljava/lang/Object;
    if-nez v6, :cond_5

    .line 8823
    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    const-string v4, "[LegendLensRestart] no activity; zoom="

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3, v11}, Ljava/lang/StringBuilder;->append(F)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    invoke-static {v3}, Llocal/mio/os4camerabridge/HookEntry;->-$$Nest$smlog(Ljava/lang/String;)V

    .line 8825
    invoke-static/range {v17 .. v17}, Llocal/mio/os4camerabridge/HookEntry;->-$$Nest$sfputpendingLegendPhysicalZoom(F)V

    .line 8826
    invoke-static/range {v16 .. v16}, Llocal/mio/os4camerabridge/HookEntry;->-$$Nest$sfputpendingLegendPhysicalCameraId(I)V

    .line 8827
    return-void

    .line 8829
    :cond_5
    iget-object v7, v1, Llocal/mio/os4camerabridge/HookEntry$47;->val$startControl:Ljava/lang/Class;

    const-string v13, "create"

    new-array v14, v3, [Ljava/lang/Class;

    sget-object v18, Ljava/lang/Integer;->TYPE:Ljava/lang/Class;

    aput-object v18, v14, v5

    .line 8831
    filled-new-array {v4}, [Ljava/lang/Object;

    move-result-object v4

    .line 8829
    invoke-static {v7, v13, v14, v4}, Lde/robv/android/xposed/XposedHelpers;->callStaticMethod(Ljava/lang/Class;Ljava/lang/String;[Ljava/lang/Class;[Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v4

    .line 8832
    .local v4, "control":Ljava/lang/Object;
    const-string v5, "setResetType"

    .line 8833
    const/16 v7, 0x8

    invoke-static {v7}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v7

    filled-new-array {v7}, [Ljava/lang/Object;

    move-result-object v7

    .line 8832
    invoke-static {v4, v5, v7}, Lde/robv/android/xposed/XposedHelpers;->callMethod(Ljava/lang/Object;Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v5

    .line 8834
    .end local v4    # "control":Ljava/lang/Object;
    .local v5, "control":Ljava/lang/Object;
    const-string v4, "setViewConfigType"

    .line 8835
    invoke-static {v15}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v7

    filled-new-array {v7}, [Ljava/lang/Object;

    move-result-object v7

    .line 8834
    invoke-static {v5, v4, v7}, Lde/robv/android/xposed/XposedHelpers;->callMethod(Ljava/lang/Object;Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v4

    .line 8836
    .end local v5    # "control":Ljava/lang/Object;
    .restart local v4    # "control":Ljava/lang/Object;
    const-string v5, "setNeedBlurAnimation"

    .line 8837
    invoke-static {v3}, Ljava/lang/Boolean;->valueOf(Z)Ljava/lang/Boolean;

    move-result-object v3

    filled-new-array {v3}, [Ljava/lang/Object;

    move-result-object v3

    .line 8836
    invoke-static {v4, v5, v3}, Lde/robv/android/xposed/XposedHelpers;->callMethod(Ljava/lang/Object;Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v3

    .line 8838
    .end local v4    # "control":Ljava/lang/Object;
    .local v3, "control":Ljava/lang/Object;
    new-instance v4, Ljava/lang/StringBuilder;

    invoke-direct {v4}, Ljava/lang/StringBuilder;-><init>()V

    const-string v5, "[LegendLensRestart] zoom="

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4, v11}, Ljava/lang/StringBuilder;->append(F)Ljava/lang/StringBuilder;

    move-result-object v4

    const-string v5, " camera="

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-static {}, Llocal/mio/os4camerabridge/HookEntry;->-$$Nest$sfgetactiveCameraId()I

    move-result v5

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v4

    const-string v5, " -> "

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4, v12}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v4

    const-string v5, " reset=8"

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v4

    invoke-static {v4}, Llocal/mio/os4camerabridge/HookEntry;->-$$Nest$smlog(Ljava/lang/String;)V

    .line 8841
    const-string v4, "J7"

    filled-new-array {v3}, [Ljava/lang/Object;

    move-result-object v5

    invoke-static {v6, v4, v5}, Lde/robv/android/xposed/XposedHelpers;->callMethod(Ljava/lang/Object;Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/Object;
    :try_end_2
    .catchall {:try_start_2 .. :try_end_2} :catchall_0

    .line 8848
    nop

    .end local v0    # "childIndex":I
    .end local v3    # "control":Ljava/lang/Object;
    .end local v6    # "activity":Ljava/lang/Object;
    .end local v8    # "zoomView":Ljava/lang/Object;
    .end local v9    # "child":Ljava/lang/Object;
    .end local v10    # "value":Ljava/lang/Object;
    .end local v11    # "targetZoom":F
    .end local v12    # "targetCamera":I
    goto :goto_3

    .line 8842
    :catchall_0
    move-exception v0

    goto :goto_2

    :catchall_1
    move-exception v0

    goto :goto_1

    :catchall_2
    move-exception v0

    const/16 v16, -0x1

    :goto_1
    const/high16 v17, 0x7fc00000    # Float.NaN

    .line 8843
    .local v0, "throwable":Ljava/lang/Throwable;
    :goto_2
    invoke-static/range {v17 .. v17}, Llocal/mio/os4camerabridge/HookEntry;->-$$Nest$sfputpendingLegendPhysicalZoom(F)V

    .line 8844
    invoke-static/range {v16 .. v16}, Llocal/mio/os4camerabridge/HookEntry;->-$$Nest$sfputpendingLegendPhysicalCameraId(I)V

    .line 8847
    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    const-string v4, "[LegendLensRestart] ignored: "

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    invoke-static {v3}, Llocal/mio/os4camerabridge/HookEntry;->-$$Nest$smlog(Ljava/lang/String;)V

    .line 8849
    .end local v0    # "throwable":Ljava/lang/Throwable;
    :goto_3
    return-void

    .line 8787
    :cond_6
    :goto_4
    return-void
.end method
