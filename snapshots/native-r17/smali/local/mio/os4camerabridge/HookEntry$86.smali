.class Llocal/mio/os4camerabridge/HookEntry$86;
.super Lde/robv/android/xposed/XC_MethodHook;
.source "HookEntry.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Llocal/mio/os4camerabridge/HookEntry;->hookOplusLogicalZoom(Ljava/lang/ClassLoader;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic val$capabilityUtils:Ljava/lang/Class;


# direct methods
.method constructor <init>(Ljava/lang/Class;)V
    .locals 0

    .line 13466
    iput-object p1, p0, Llocal/mio/os4camerabridge/HookEntry$86;->val$capabilityUtils:Ljava/lang/Class;

    invoke-direct {p0}, Lde/robv/android/xposed/XC_MethodHook;-><init>()V

    return-void
.end method


# virtual methods
.method protected afterHookedMethod(Lde/robv/android/xposed/XC_MethodHook$MethodHookParam;)V
    .locals 9
    .param p1, "param"    # Lde/robv/android/xposed/XC_MethodHook$MethodHookParam;

    .line 13469
    iget-object v0, p1, Lde/robv/android/xposed/XC_MethodHook$MethodHookParam;->args:[Ljava/lang/Object;

    if-eqz v0, :cond_8

    iget-object v0, p1, Lde/robv/android/xposed/XC_MethodHook$MethodHookParam;->args:[Ljava/lang/Object;

    array-length v0, v0

    const/4 v1, 0x3

    if-lt v0, v1, :cond_8

    iget-object v0, p1, Lde/robv/android/xposed/XC_MethodHook$MethodHookParam;->args:[Ljava/lang/Object;

    const/4 v1, 0x0

    aget-object v0, v0, v1

    instance-of v0, v0, Landroid/hardware/camera2/CaptureRequest$Builder;

    if-eqz v0, :cond_8

    iget-object v0, p1, Lde/robv/android/xposed/XC_MethodHook$MethodHookParam;->args:[Ljava/lang/Object;

    const/4 v2, 0x1

    aget-object v0, v0, v2

    if-eqz v0, :cond_8

    iget-object v0, p1, Lde/robv/android/xposed/XC_MethodHook$MethodHookParam;->args:[Ljava/lang/Object;

    const/4 v3, 0x2

    aget-object v0, v0, v3

    if-nez v0, :cond_0

    goto/16 :goto_3

    .line 13475
    :cond_0
    :try_start_0
    iget-object v0, p0, Llocal/mio/os4camerabridge/HookEntry$86;->val$capabilityUtils:Ljava/lang/Class;

    const-string v4, "k"

    iget-object v5, p1, Lde/robv/android/xposed/XC_MethodHook$MethodHookParam;->args:[Ljava/lang/Object;

    aget-object v2, v5, v2

    filled-new-array {v2}, [Ljava/lang/Object;

    move-result-object v2

    invoke-static {v0, v4, v2}, Lde/robv/android/xposed/XposedHelpers;->callStaticMethod(Ljava/lang/Class;Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0

    .line 13477
    .local v0, "cameraIdValue":Ljava/lang/Object;
    instance-of v2, v0, Ljava/lang/Integer;

    if-nez v2, :cond_1

    .line 13478
    return-void

    .line 13480
    :cond_1
    move-object v2, v0

    check-cast v2, Ljava/lang/Integer;

    invoke-virtual {v2}, Ljava/lang/Integer;->intValue()I

    move-result v2

    .line 13481
    .local v2, "requestCameraId":I
    iget-object v4, p1, Lde/robv/android/xposed/XC_MethodHook$MethodHookParam;->args:[Ljava/lang/Object;

    aget-object v3, v4, v3

    const-string v4, "c0"

    invoke-static {v3, v4}, Lde/robv/android/xposed/XposedHelpers;->getFloatField(Ljava/lang/Object;Ljava/lang/String;)F

    move-result v3

    .line 13482
    .local v3, "uiRatio":F
    const/high16 v4, 0x41a00000    # 20.0f

    invoke-static {v4, v3}, Ljava/lang/Math;->min(FF)F

    move-result v4

    const v5, 0x3f19999a    # 0.6f

    invoke-static {v5, v4}, Ljava/lang/Math;->max(FF)F

    move-result v4

    .line 13483
    .local v4, "ratio":F
    iget-object v5, p1, Lde/robv/android/xposed/XC_MethodHook$MethodHookParam;->args:[Ljava/lang/Object;

    aget-object v1, v5, v1

    check-cast v1, Landroid/hardware/camera2/CaptureRequest$Builder;

    .line 13485
    .local v1, "builder":Landroid/hardware/camera2/CaptureRequest$Builder;
    invoke-static {}, Llocal/mio/os4camerabridge/HookEntry;->-$$Nest$sfgetactiveCameraModule()I

    move-result v5

    const/16 v6, 0xa2

    if-eq v5, v6, :cond_7

    invoke-static {}, Llocal/mio/os4camerabridge/HookEntry;->-$$Nest$sfgetactiveCameraModule()I

    move-result v5

    const/16 v6, 0xa7

    if-eq v5, v6, :cond_7

    invoke-static {}, Llocal/mio/os4camerabridge/HookEntry;->-$$Nest$sfgetactiveCameraModule()I

    move-result v5

    const/16 v6, 0x100

    if-ne v5, v6, :cond_2

    goto/16 :goto_1

    .line 13492
    :cond_2
    if-eqz v2, :cond_3

    .line 13493
    return-void

    .line 13495
    :cond_3
    sget-object v5, Landroid/hardware/camera2/CaptureRequest;->SCALER_CROP_REGION:Landroid/hardware/camera2/CaptureRequest$Key;

    invoke-virtual {v1, v5}, Landroid/hardware/camera2/CaptureRequest$Builder;->get(Landroid/hardware/camera2/CaptureRequest$Key;)Ljava/lang/Object;

    move-result-object v5

    .line 13496
    .local v5, "oldCrop":Ljava/lang/Object;
    invoke-static {}, Llocal/mio/os4camerabridge/HookEntry;->-$$Nest$smfullRearActiveArray()Landroid/graphics/Rect;

    move-result-object v6

    .line 13497
    .local v6, "fullActiveArray":Landroid/graphics/Rect;
    sget-object v7, Landroid/hardware/camera2/CaptureRequest;->CONTROL_ZOOM_RATIO:Landroid/hardware/camera2/CaptureRequest$Key;

    invoke-static {v4}, Ljava/lang/Float;->valueOf(F)Ljava/lang/Float;

    move-result-object v8

    invoke-virtual {v1, v7, v8}, Landroid/hardware/camera2/CaptureRequest$Builder;->set(Landroid/hardware/camera2/CaptureRequest$Key;Ljava/lang/Object;)V

    .line 13503
    sget-object v7, Landroid/hardware/camera2/CaptureRequest;->SCALER_CROP_REGION:Landroid/hardware/camera2/CaptureRequest$Key;

    invoke-virtual {v1, v7, v6}, Landroid/hardware/camera2/CaptureRequest$Builder;->set(Landroid/hardware/camera2/CaptureRequest$Key;Ljava/lang/Object;)V

    .line 13505
    const/high16 v7, 0x40400000    # 3.0f

    cmpl-float v7, v4, v7

    if-ltz v7, :cond_4

    .line 13506
    invoke-static {v1, v4}, Llocal/mio/os4camerabridge/HookEntry;->-$$Nest$smapplyLogicalOplusTeleRoute(Landroid/hardware/camera2/CaptureRequest$Builder;F)V

    goto :goto_0

    .line 13508
    :cond_4
    invoke-static {v1}, Llocal/mio/os4camerabridge/HookEntry;->-$$Nest$smclearLogicalOplusTeleRoute(Landroid/hardware/camera2/CaptureRequest$Builder;)V

    .line 13510
    :goto_0
    invoke-static {}, Llocal/mio/os4camerabridge/HookEntry;->-$$Nest$sfgetlastLoggedZoomRatio()F

    move-result v7

    invoke-static {v7}, Ljava/lang/Float;->isNaN(F)Z

    move-result v7

    if-nez v7, :cond_5

    invoke-static {}, Llocal/mio/os4camerabridge/HookEntry;->-$$Nest$sfgetlastLoggedZoomRatio()F

    move-result v7

    sub-float/2addr v7, v4

    .line 13511
    invoke-static {v7}, Ljava/lang/Math;->abs(F)F

    move-result v7

    const v8, 0x3c23d70a    # 0.01f

    cmpl-float v7, v7, v8

    if-ltz v7, :cond_6

    .line 13512
    :cond_5
    invoke-static {v4}, Llocal/mio/os4camerabridge/HookEntry;->-$$Nest$sfputlastLoggedZoomRatio(F)V

    .line 13513
    new-instance v7, Ljava/lang/StringBuilder;

    invoke-direct {v7}, Ljava/lang/StringBuilder;-><init>()V

    const-string v8, "[LogicalZoom] camera=0 ui="

    invoke-virtual {v7, v8}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v7

    invoke-virtual {v7, v3}, Ljava/lang/StringBuilder;->append(F)Ljava/lang/StringBuilder;

    move-result-object v7

    const-string v8, " request="

    invoke-virtual {v7, v8}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v7

    invoke-virtual {v7, v4}, Ljava/lang/StringBuilder;->append(F)Ljava/lang/StringBuilder;

    move-result-object v7

    const-string v8, " crop="

    invoke-virtual {v7, v8}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v7

    invoke-virtual {v7, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v7

    const-string v8, " replacedCrop="

    invoke-virtual {v7, v8}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v7

    invoke-virtual {v7, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v7

    invoke-virtual {v7}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v7

    invoke-static {v7}, Llocal/mio/os4camerabridge/HookEntry;->-$$Nest$smlog(Ljava/lang/String;)V

    .line 13520
    .end local v0    # "cameraIdValue":Ljava/lang/Object;
    .end local v1    # "builder":Landroid/hardware/camera2/CaptureRequest$Builder;
    .end local v2    # "requestCameraId":I
    .end local v3    # "uiRatio":F
    .end local v4    # "ratio":F
    .end local v5    # "oldCrop":Ljava/lang/Object;
    .end local v6    # "fullActiveArray":Landroid/graphics/Rect;
    :cond_6
    goto :goto_2

    .line 13488
    .restart local v0    # "cameraIdValue":Ljava/lang/Object;
    .restart local v1    # "builder":Landroid/hardware/camera2/CaptureRequest$Builder;
    .restart local v2    # "requestCameraId":I
    .restart local v3    # "uiRatio":F
    .restart local v4    # "ratio":F
    :cond_7
    :goto_1
    invoke-static {}, Llocal/mio/os4camerabridge/HookEntry;->-$$Nest$sfgetactiveCameraModule()I

    move-result v5

    invoke-static {v1, v2, v4, v5}, Llocal/mio/os4camerabridge/HookEntry;->-$$Nest$smapplyPhysicalRoleZoom(Landroid/hardware/camera2/CaptureRequest$Builder;IFI)V
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 13490
    return-void

    .line 13518
    .end local v0    # "cameraIdValue":Ljava/lang/Object;
    .end local v1    # "builder":Landroid/hardware/camera2/CaptureRequest$Builder;
    .end local v2    # "requestCameraId":I
    .end local v3    # "uiRatio":F
    .end local v4    # "ratio":F
    :catchall_0
    move-exception v0

    .line 13519
    .local v0, "throwable":Ljava/lang/Throwable;
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "[LogicalZoom] request unchanged: "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-static {v1}, Llocal/mio/os4camerabridge/HookEntry;->-$$Nest$smlog(Ljava/lang/String;)V

    .line 13521
    .end local v0    # "throwable":Ljava/lang/Throwable;
    :goto_2
    return-void

    .line 13472
    :cond_8
    :goto_3
    return-void
.end method
