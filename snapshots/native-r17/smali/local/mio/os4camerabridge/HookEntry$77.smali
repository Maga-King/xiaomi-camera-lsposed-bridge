.class Llocal/mio/os4camerabridge/HookEntry$77;
.super Lde/robv/android/xposed/XC_MethodHook;
.source "HookEntry.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Llocal/mio/os4camerabridge/HookEntry;->hookWatermarkFocalLength(Ljava/lang/ClassLoader;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# direct methods
.method constructor <init>()V
    .locals 0

    .line 12073
    invoke-direct {p0}, Lde/robv/android/xposed/XC_MethodHook;-><init>()V

    return-void
.end method


# virtual methods
.method protected afterHookedMethod(Lde/robv/android/xposed/XC_MethodHook$MethodHookParam;)V
    .locals 8
    .param p1, "param"    # Lde/robv/android/xposed/XC_MethodHook$MethodHookParam;

    .line 12076
    invoke-virtual {p1}, Lde/robv/android/xposed/XC_MethodHook$MethodHookParam;->hasThrowable()Z

    move-result v0

    if-nez v0, :cond_5

    iget-object v0, p1, Lde/robv/android/xposed/XC_MethodHook$MethodHookParam;->args:[Ljava/lang/Object;

    if-eqz v0, :cond_5

    iget-object v0, p1, Lde/robv/android/xposed/XC_MethodHook$MethodHookParam;->args:[Ljava/lang/Object;

    array-length v0, v0

    const/4 v1, 0x1

    if-ne v0, v1, :cond_5

    iget-object v0, p1, Lde/robv/android/xposed/XC_MethodHook$MethodHookParam;->args:[Ljava/lang/Object;

    const/4 v1, 0x0

    aget-object v0, v0, v1

    instance-of v0, v0, Landroid/hardware/camera2/CaptureResult;

    if-nez v0, :cond_0

    goto/16 :goto_2

    .line 12081
    :cond_0
    invoke-virtual {p1}, Lde/robv/android/xposed/XC_MethodHook$MethodHookParam;->getResult()Ljava/lang/Object;

    move-result-object v0

    .line 12082
    .local v0, "original":Ljava/lang/Object;
    instance-of v2, v0, Ljava/lang/Number;

    const/4 v3, 0x0

    if-eqz v2, :cond_1

    move-object v2, v0

    check-cast v2, Ljava/lang/Number;

    .line 12083
    invoke-virtual {v2}, Ljava/lang/Number;->floatValue()F

    move-result v2

    cmpl-float v2, v2, v3

    if-lez v2, :cond_1

    .line 12084
    return-void

    .line 12086
    :cond_1
    iget-object v2, p1, Lde/robv/android/xposed/XC_MethodHook$MethodHookParam;->args:[Ljava/lang/Object;

    aget-object v1, v2, v1

    check-cast v1, Landroid/hardware/camera2/CaptureResult;

    .line 12087
    .local v1, "result":Landroid/hardware/camera2/CaptureResult;
    sget-object v2, Landroid/hardware/camera2/CaptureResult;->LENS_FOCAL_LENGTH:Landroid/hardware/camera2/CaptureResult$Key;

    invoke-static {v1, v2}, Llocal/mio/os4camerabridge/HookEntry;->-$$Nest$smsafeResultValue(Landroid/hardware/camera2/CaptureResult;Landroid/hardware/camera2/CaptureResult$Key;)Ljava/lang/Object;

    move-result-object v2

    check-cast v2, Ljava/lang/Float;

    .line 12089
    .local v2, "physicalFocal":Ljava/lang/Float;
    sget-object v4, Landroid/hardware/camera2/CaptureResult;->CONTROL_ZOOM_RATIO:Landroid/hardware/camera2/CaptureResult$Key;

    invoke-static {v1, v4}, Llocal/mio/os4camerabridge/HookEntry;->-$$Nest$smsafeResultValue(Landroid/hardware/camera2/CaptureResult;Landroid/hardware/camera2/CaptureResult$Key;)Ljava/lang/Object;

    move-result-object v4

    check-cast v4, Ljava/lang/Float;

    .line 12091
    .local v4, "zoom":Ljava/lang/Float;
    if-eqz v2, :cond_4

    invoke-virtual {v2}, Ljava/lang/Float;->floatValue()F

    move-result v5

    cmpg-float v5, v5, v3

    if-gtz v5, :cond_2

    goto :goto_1

    .line 12095
    :cond_2
    const/high16 v5, 0x3f800000    # 1.0f

    if-eqz v4, :cond_3

    .line 12094
    invoke-virtual {v4}, Ljava/lang/Float;->floatValue()F

    move-result v6

    invoke-static {v6}, Ljava/lang/Float;->isFinite(F)Z

    move-result v6

    if-eqz v6, :cond_3

    .line 12095
    invoke-virtual {v4}, Ljava/lang/Float;->floatValue()F

    move-result v6

    cmpl-float v3, v6, v3

    if-lez v3, :cond_3

    invoke-virtual {v4}, Ljava/lang/Float;->floatValue()F

    move-result v3

    goto :goto_0

    :cond_3
    move v3, v5

    .line 12096
    .local v3, "logicalZoom":F
    :goto_0
    const/high16 v6, 0x41b80000    # 23.0f

    mul-float/2addr v6, v3

    .line 12097
    invoke-static {v6}, Ljava/lang/Math;->round(F)I

    move-result v6

    int-to-float v6, v6

    .line 12096
    invoke-static {v5, v6}, Ljava/lang/Math;->max(FF)F

    move-result v5

    .line 12098
    .local v5, "equivalent35mm":F
    invoke-static {v5}, Ljava/lang/Float;->valueOf(F)Ljava/lang/Float;

    move-result-object v6

    invoke-virtual {p1, v6}, Lde/robv/android/xposed/XC_MethodHook$MethodHookParam;->setResult(Ljava/lang/Object;)V

    .line 12099
    new-instance v6, Ljava/lang/StringBuilder;

    invoke-direct {v6}, Ljava/lang/StringBuilder;-><init>()V

    const-string v7, "[NativeWatermark] focal35 fallback physical="

    invoke-virtual {v6, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    invoke-virtual {v6, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v6

    const-string v7, " zoom="

    invoke-virtual {v6, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    invoke-virtual {v6, v3}, Ljava/lang/StringBuilder;->append(F)Ljava/lang/StringBuilder;

    move-result-object v6

    const-string v7, " equivalent="

    invoke-virtual {v6, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    invoke-virtual {v6, v5}, Ljava/lang/StringBuilder;->append(F)Ljava/lang/StringBuilder;

    move-result-object v6

    invoke-virtual {v6}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v6

    invoke-static {v6}, Llocal/mio/os4camerabridge/HookEntry;->-$$Nest$smlog(Ljava/lang/String;)V

    .line 12102
    return-void

    .line 12092
    .end local v3    # "logicalZoom":F
    .end local v5    # "equivalent35mm":F
    :cond_4
    :goto_1
    return-void

    .line 12079
    .end local v0    # "original":Ljava/lang/Object;
    .end local v1    # "result":Landroid/hardware/camera2/CaptureResult;
    .end local v2    # "physicalFocal":Ljava/lang/Float;
    .end local v4    # "zoom":Ljava/lang/Float;
    :cond_5
    :goto_2
    return-void
.end method
