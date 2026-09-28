.class Llocal/mio/os4camerabridge/LegendaryM9FrameContractBridge$1;
.super Lde/robv/android/xposed/XC_MethodHook;
.source "LegendaryM9FrameContractBridge.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Llocal/mio/os4camerabridge/LegendaryM9FrameContractBridge;->install()V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic val$mainId:Ljava/lang/reflect/Field;


# direct methods
.method constructor <init>(Ljava/lang/reflect/Field;)V
    .locals 0

    .line 25
    iput-object p1, p0, Llocal/mio/os4camerabridge/LegendaryM9FrameContractBridge$1;->val$mainId:Ljava/lang/reflect/Field;

    invoke-direct {p0}, Lde/robv/android/xposed/XC_MethodHook;-><init>()V

    return-void
.end method


# virtual methods
.method protected afterHookedMethod(Lde/robv/android/xposed/XC_MethodHook$MethodHookParam;)V
    .locals 13

    .line 27
    invoke-virtual {p1}, Lde/robv/android/xposed/XC_MethodHook$MethodHookParam;->hasThrowable()Z

    move-result v0

    if-nez v0, :cond_c

    invoke-virtual {p1}, Lde/robv/android/xposed/XC_MethodHook$MethodHookParam;->getResult()Ljava/lang/Object;

    move-result-object v0

    if-nez v0, :cond_0

    goto/16 :goto_6

    .line 29
    :cond_0
    :try_start_0
    iget-object v0, p1, Lde/robv/android/xposed/XC_MethodHook$MethodHookParam;->args:[Ljava/lang/Object;

    const/4 v1, 0x3

    aget-object v0, v0, v1

    check-cast v0, Ljava/lang/Integer;

    invoke-virtual {v0}, Ljava/lang/Integer;->intValue()I

    move-result v0

    iget-object v2, p0, Llocal/mio/os4camerabridge/LegendaryM9FrameContractBridge$1;->val$mainId:Ljava/lang/reflect/Field;

    const/4 v3, 0x0

    invoke-virtual {v2, v3}, Ljava/lang/reflect/Field;->getInt(Ljava/lang/Object;)I

    move-result v2

    if-eq v0, v2, :cond_1

    return-void

    .line 30
    :cond_1
    iget-object v0, p1, Lde/robv/android/xposed/XC_MethodHook$MethodHookParam;->args:[Ljava/lang/Object;

    const/4 v2, 0x0

    aget-object v0, v0, v2

    check-cast v0, Landroid/hardware/camera2/CaptureResult;

    .line 32
    iget-object v3, p1, Lde/robv/android/xposed/XC_MethodHook$MethodHookParam;->args:[Ljava/lang/Object;

    const/4 v4, 0x1

    aget-object v3, v3, v4

    if-eq v0, v3, :cond_2

    return-void

    .line 33
    :cond_2
    sget-object v3, Landroid/hardware/camera2/CaptureResult;->CONTROL_ZOOM_RATIO:Landroid/hardware/camera2/CaptureResult$Key;

    invoke-virtual {v0, v3}, Landroid/hardware/camera2/CaptureResult;->get(Landroid/hardware/camera2/CaptureResult$Key;)Ljava/lang/Object;

    move-result-object v3

    check-cast v3, Ljava/lang/Float;

    .line 34
    sget-object v4, Landroid/hardware/camera2/CaptureResult;->SENSOR_TIMESTAMP:Landroid/hardware/camera2/CaptureResult$Key;

    invoke-virtual {v0, v4}, Landroid/hardware/camera2/CaptureResult;->get(Landroid/hardware/camera2/CaptureResult$Key;)Ljava/lang/Object;

    move-result-object v4

    check-cast v4, Ljava/lang/Long;

    .line 35
    sget-object v5, Landroid/hardware/camera2/CaptureResult;->COLOR_CORRECTION_TRANSFORM:Landroid/hardware/camera2/CaptureResult$Key;

    invoke-virtual {v0, v5}, Landroid/hardware/camera2/CaptureResult;->get(Landroid/hardware/camera2/CaptureResult$Key;)Ljava/lang/Object;

    move-result-object v5

    check-cast v5, Landroid/hardware/camera2/params/ColorSpaceTransform;

    .line 36
    if-eqz v3, :cond_b

    invoke-virtual {v3}, Ljava/lang/Float;->floatValue()F

    move-result v6

    const/high16 v7, 0x3f800000    # 1.0f

    sub-float/2addr v6, v7

    invoke-static {v6}, Ljava/lang/Math;->abs(F)F

    move-result v6

    const v7, 0x38d1b717    # 1.0E-4f

    cmpl-float v6, v6, v7

    if-gtz v6, :cond_b

    if-eqz v4, :cond_b

    if-nez v5, :cond_3

    goto/16 :goto_4

    .line 37
    :cond_3
    nop

    .line 38
    invoke-virtual {v0}, Landroid/hardware/camera2/CaptureResult;->getKeys()Ljava/util/List;

    move-result-object v6

    invoke-interface {v6}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object v6

    :cond_4
    invoke-interface {v6}, Ljava/util/Iterator;->hasNext()Z

    move-result v7

    if-eqz v7, :cond_6

    invoke-interface {v6}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v7

    check-cast v7, Landroid/hardware/camera2/CaptureResult$Key;

    const-string v8, "com.qti.sensorbps.gain"

    invoke-virtual {v7}, Landroid/hardware/camera2/CaptureResult$Key;->getName()Ljava/lang/String;

    move-result-object v9

    invoke-virtual {v8, v9}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v8

    if-eqz v8, :cond_4

    .line 39
    invoke-virtual {v0, v7}, Landroid/hardware/camera2/CaptureResult;->get(Landroid/hardware/camera2/CaptureResult$Key;)Ljava/lang/Object;

    move-result-object v0

    .line 40
    if-eqz v0, :cond_5

    invoke-virtual {v0}, Ljava/lang/Object;->getClass()Ljava/lang/Class;

    move-result-object v6

    invoke-virtual {v6}, Ljava/lang/Class;->isArray()Z

    move-result v6

    if-eqz v6, :cond_5

    invoke-static {v0}, Ljava/lang/reflect/Array;->getLength(Ljava/lang/Object;)I

    move-result v6

    if-lez v6, :cond_5

    invoke-static {v0, v2}, Ljava/lang/reflect/Array;->get(Ljava/lang/Object;I)Ljava/lang/Object;

    move-result-object v0

    .line 41
    :cond_5
    instance-of v6, v0, Ljava/lang/Number;

    if-eqz v6, :cond_6

    check-cast v0, Ljava/lang/Number;

    invoke-virtual {v0}, Ljava/lang/Number;->floatValue()F

    move-result v0

    move v8, v0

    goto :goto_0

    .line 44
    :cond_6
    const/high16 v0, 0x7fc00000    # Float.NaN

    move v8, v0

    :goto_0
    invoke-static {v8}, Ljava/lang/Float;->isFinite(F)Z

    move-result v0

    if-eqz v0, :cond_a

    const/4 v0, 0x0

    cmpg-float v0, v8, v0

    if-gtz v0, :cond_7

    goto :goto_3

    .line 45
    :cond_7
    const/16 v0, 0x9

    new-array v9, v0, [F

    .line 46
    move v0, v2

    :goto_1
    if-ge v0, v1, :cond_9

    move v6, v2

    :goto_2
    if-ge v6, v1, :cond_8

    .line 47
    mul-int/lit8 v7, v0, 0x3

    add-int/2addr v7, v6

    invoke-virtual {v5, v6, v0}, Landroid/hardware/camera2/params/ColorSpaceTransform;->getElement(II)Landroid/util/Rational;

    move-result-object v10

    invoke-virtual {v10}, Landroid/util/Rational;->floatValue()F

    move-result v10

    aput v10, v9, v7

    .line 46
    add-int/lit8 v6, v6, 0x1

    goto :goto_2

    :cond_8
    add-int/lit8 v0, v0, 0x1

    goto :goto_1

    .line 48
    :cond_9
    invoke-static {}, Llocal/mio/os4camerabridge/LegendaryM9FrameContractBridge;->-$$Nest$sfgetFRAMES()Ljava/util/Map;

    move-result-object v0

    invoke-virtual {p1}, Lde/robv/android/xposed/XC_MethodHook$MethodHookParam;->getResult()Ljava/lang/Object;

    move-result-object p1

    new-instance v6, Llocal/mio/os4camerabridge/LegendaryM9FrameContractBridge$Frame;

    invoke-virtual {v3}, Ljava/lang/Float;->floatValue()F

    move-result v7

    invoke-virtual {v4}, Ljava/lang/Long;->longValue()J

    move-result-wide v10

    const/4 v12, 0x0

    invoke-direct/range {v6 .. v12}, Llocal/mio/os4camerabridge/LegendaryM9FrameContractBridge$Frame;-><init>(FF[FJLlocal/mio/os4camerabridge/LegendaryM9FrameContractBridge-IA;)V

    invoke-interface {v0, p1, v6}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 49
    goto :goto_5

    .line 44
    :cond_a
    :goto_3
    return-void

    .line 36
    :cond_b
    :goto_4
    return-void

    .line 49
    :catchall_0
    move-exception v0

    move-object p1, v0

    invoke-static {p1}, Ljava/lang/String;->valueOf(Ljava/lang/Object;)Ljava/lang/String;

    move-result-object p1

    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "capture contract rejected: "

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p1

    invoke-virtual {p1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p1

    invoke-static {p1}, Llocal/mio/os4camerabridge/LegendaryM9FrameContractBridge;->-$$Nest$smlog(Ljava/lang/String;)V

    .line 50
    :goto_5
    return-void

    .line 27
    :cond_c
    :goto_6
    return-void
.end method
