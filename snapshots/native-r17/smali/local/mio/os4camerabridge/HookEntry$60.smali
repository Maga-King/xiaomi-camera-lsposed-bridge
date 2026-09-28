.class Llocal/mio/os4camerabridge/HookEntry$60;
.super Lde/robv/android/xposed/XC_MethodHook;
.source "HookEntry.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Llocal/mio/os4camerabridge/HookEntry;->hookPreviewSession(Ljava/lang/ClassLoader;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# direct methods
.method constructor <init>()V
    .locals 0

    .line 9258
    invoke-direct {p0}, Lde/robv/android/xposed/XC_MethodHook;-><init>()V

    return-void
.end method


# virtual methods
.method protected beforeHookedMethod(Lde/robv/android/xposed/XC_MethodHook$MethodHookParam;)V
    .locals 11
    .param p1, "param"    # Lde/robv/android/xposed/XC_MethodHook$MethodHookParam;

    .line 9261
    iget-object v0, p1, Lde/robv/android/xposed/XC_MethodHook$MethodHookParam;->args:[Ljava/lang/Object;

    const/4 v1, 0x0

    .line 9359
    invoke-static {v1}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v2

    .line 9261
    aget-object v0, v0, v1

    instance-of v0, v0, Ljava/lang/Integer;

    if-nez v0, :cond_0

    .line 9262
    return-void

    .line 9264
    :cond_0
    iget-object v0, p1, Lde/robv/android/xposed/XC_MethodHook$MethodHookParam;->thisObject:Ljava/lang/Object;

    const-string v3, "c"

    new-array v4, v1, [Ljava/lang/Object;

    invoke-static {v0, v3, v4}, Lde/robv/android/xposed/XposedHelpers;->callMethod(Ljava/lang/Object;Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0

    invoke-static {v0}, Ljava/lang/String;->valueOf(Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v0

    .line 9266
    .local v0, "cameraId":Ljava/lang/String;
    const/4 v3, -0x1

    :try_start_0
    invoke-static {v0}, Ljava/lang/Integer;->parseInt(Ljava/lang/String;)I

    move-result v4

    invoke-static {v4}, Llocal/mio/os4camerabridge/HookEntry;->-$$Nest$sfputactiveCameraId(I)V
    :try_end_0
    .catch Ljava/lang/NumberFormatException; {:try_start_0 .. :try_end_0} :catch_0

    .line 9269
    goto :goto_0

    .line 9267
    :catch_0
    move-exception v4

    .line 9268
    .local v4, "ignored":Ljava/lang/NumberFormatException;
    invoke-static {v3}, Llocal/mio/os4camerabridge/HookEntry;->-$$Nest$sfputactiveCameraId(I)V

    .line 9270
    .end local v4    # "ignored":Ljava/lang/NumberFormatException;
    :goto_0
    iget-object v4, p1, Lde/robv/android/xposed/XC_MethodHook$MethodHookParam;->args:[Ljava/lang/Object;

    aget-object v4, v4, v1

    check-cast v4, Ljava/lang/Integer;

    invoke-virtual {v4}, Ljava/lang/Integer;->intValue()I

    move-result v4

    .line 9271
    .local v4, "operationMode":I
    iget-object v5, p1, Lde/robv/android/xposed/XC_MethodHook$MethodHookParam;->args:[Ljava/lang/Object;

    const/4 v6, 0x1

    aget-object v5, v5, v6

    instance-of v5, v5, Ljava/util/List;

    if-eqz v5, :cond_1

    .line 9272
    iget-object v5, p1, Lde/robv/android/xposed/XC_MethodHook$MethodHookParam;->args:[Ljava/lang/Object;

    aget-object v5, v5, v6

    check-cast v5, Ljava/util/List;

    invoke-interface {v5}, Ljava/util/List;->size()I

    move-result v5

    goto :goto_1

    :cond_1
    move v5, v3

    .line 9273
    .local v5, "outputCount":I
    :goto_1
    new-instance v7, Ljava/lang/StringBuilder;

    invoke-direct {v7}, Ljava/lang/StringBuilder;-><init>()V

    const-string v8, "[SessionProbe] camera="

    invoke-virtual {v7, v8}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v7

    invoke-virtual {v7, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v7

    const-string v8, " mode=0x"

    invoke-virtual {v7, v8}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v7

    .line 9274
    invoke-static {v4}, Ljava/lang/Integer;->toHexString(I)Ljava/lang/String;

    move-result-object v9

    invoke-virtual {v7, v9}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v7

    const-string v9, " outputs="

    invoke-virtual {v7, v9}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v7

    invoke-virtual {v7, v5}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v7

    invoke-virtual {v7}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v7

    .line 9273
    invoke-static {v7}, Llocal/mio/os4camerabridge/HookEntry;->-$$Nest$smlog(Ljava/lang/String;)V

    .line 9276
    iget-object v7, p1, Lde/robv/android/xposed/XC_MethodHook$MethodHookParam;->args:[Ljava/lang/Object;

    aget-object v7, v7, v6

    instance-of v7, v7, Ljava/util/List;

    if-eqz v7, :cond_2

    .line 9277
    invoke-static {}, Llocal/mio/os4camerabridge/HookEntry;->-$$Nest$sfgetXIAOMI_SESSION_SPEC_COUNT()Ljava/util/concurrent/atomic/AtomicInteger;

    move-result-object v7

    .line 9278
    invoke-virtual {v7}, Ljava/util/concurrent/atomic/AtomicInteger;->incrementAndGet()I

    move-result v7

    .line 9279
    .local v7, "specOrdinal":I
    const/16 v9, 0x18

    if-gt v7, v9, :cond_2

    .line 9280
    new-instance v9, Ljava/lang/StringBuilder;

    invoke-direct {v9}, Ljava/lang/StringBuilder;-><init>()V

    const-string v10, "[XiaomiSessionSpec] #"

    invoke-virtual {v9, v10}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v9

    invoke-virtual {v9, v7}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v9

    const-string v10, " camera="

    invoke-virtual {v9, v10}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v9

    invoke-virtual {v9, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v9

    invoke-virtual {v9, v8}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v8

    .line 9284
    invoke-static {v4}, Ljava/lang/Integer;->toHexString(I)Ljava/lang/String;

    move-result-object v9

    invoke-virtual {v8, v9}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v8

    invoke-virtual {v8}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v8

    iget-object v9, p1, Lde/robv/android/xposed/XC_MethodHook$MethodHookParam;->args:[Ljava/lang/Object;

    aget-object v9, v9, v6

    check-cast v9, Ljava/util/List;

    .line 9280
    invoke-static {v8, v9}, Llocal/mio/os4camerabridge/HookEntry;->-$$Nest$smlogConfiguredOutputs(Ljava/lang/String;Ljava/util/List;)V

    .line 9289
    .end local v7    # "specOrdinal":I
    :cond_2
    nop

    .line 9290
    invoke-static {v0, v4}, Llocal/mio/os4camerabridge/HookEntry;->-$$Nest$smbeginUnifiedApsSessionEpoch(Ljava/lang/String;I)I

    move-result v7

    .line 9292
    .local v7, "unifiedSessionGeneration":I
    invoke-static {p1, v0, v4, v7}, Llocal/mio/os4camerabridge/HookEntry;->-$$Nest$smtryEnableUnifiedPortraitApsSession(Lde/robv/android/xposed/XC_MethodHook$MethodHookParam;Ljava/lang/String;II)Z

    move-result v8

    if-eqz v8, :cond_3

    .line 9295
    return-void

    .line 9297
    :cond_3
    invoke-static {p1, v0, v4, v7}, Llocal/mio/os4camerabridge/HookEntry;->-$$Nest$smtryEnableUnifiedApsSession(Lde/robv/android/xposed/XC_MethodHook$MethodHookParam;Ljava/lang/String;II)Z

    move-result v8

    if-eqz v8, :cond_4

    .line 9300
    return-void

    .line 9302
    :cond_4
    invoke-static {}, Llocal/mio/os4camerabridge/HookEntry;->-$$Nest$sfgetactiveCameraModule()I

    move-result v8

    const/16 v9, 0x100

    if-ne v8, v9, :cond_6

    invoke-static {}, Llocal/mio/os4camerabridge/HookEntry;->-$$Nest$sfgetactiveLegendMode()I

    move-result v8

    if-ne v8, v6, :cond_6

    if-nez v4, :cond_6

    invoke-static {}, Llocal/mio/os4camerabridge/HookEntry;->-$$Nest$sfgetactiveCameraId()I

    move-result v8

    if-eqz v8, :cond_6

    invoke-static {}, Llocal/mio/os4camerabridge/HookEntry;->-$$Nest$sfgetactiveCameraId()I

    move-result v8

    .line 9306
    invoke-static {v8}, Llocal/mio/os4camerabridge/HookEntry;->-$$Nest$smisRearDirectCaptureCamera(I)Z

    move-result v8

    if-eqz v8, :cond_6

    iget-object v8, p1, Lde/robv/android/xposed/XC_MethodHook$MethodHookParam;->args:[Ljava/lang/Object;

    aget-object v8, v8, v6

    instance-of v8, v8, Ljava/util/List;

    if-eqz v8, :cond_6

    iget-object v8, p1, Lde/robv/android/xposed/XC_MethodHook$MethodHookParam;->args:[Ljava/lang/Object;

    aget-object v8, v8, v6

    check-cast v8, Ljava/util/List;

    .line 9308
    invoke-static {v8}, Llocal/mio/os4camerabridge/HookEntry;->-$$Nest$smisLegendProCaptureOutputs(Ljava/util/List;)Z

    move-result v8

    if-eqz v8, :cond_6

    .line 9315
    iget-object v2, p1, Lde/robv/android/xposed/XC_MethodHook$MethodHookParam;->args:[Ljava/lang/Object;

    const v6, 0x8003

    invoke-static {v6}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v6

    aput-object v6, v2, v1

    .line 9316
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "[LegendProCapture] camera="

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, " mode=0 -> 0x8003 outputs="

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, v5}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-static {v1}, Llocal/mio/os4camerabridge/HookEntry;->-$$Nest$smlog(Ljava/lang/String;)V

    .line 9319
    invoke-static {}, Llocal/mio/os4camerabridge/HookEntry;->-$$Nest$sfgetactiveCameraId()I

    move-result v1

    invoke-static {}, Llocal/mio/os4camerabridge/HookEntry;->-$$Nest$sfgetpendingLegendPhysicalCameraId()I

    move-result v2

    if-ne v1, v2, :cond_5

    invoke-static {}, Llocal/mio/os4camerabridge/HookEntry;->-$$Nest$sfgetpendingLegendPhysicalZoom()F

    move-result v1

    .line 9321
    invoke-static {v1}, Ljava/lang/Float;->isFinite(F)Z

    move-result v1

    if-eqz v1, :cond_5

    .line 9323
    invoke-static {}, Llocal/mio/os4camerabridge/HookEntry;->-$$Nest$sfgetpendingLegendPhysicalZoom()F

    move-result v1

    .line 9325
    .local v1, "completedZoom":F
    const/high16 v2, 0x7fc00000    # Float.NaN

    invoke-static {v2}, Llocal/mio/os4camerabridge/HookEntry;->-$$Nest$sfputpendingLegendPhysicalZoom(F)V

    .line 9326
    invoke-static {v3}, Llocal/mio/os4camerabridge/HookEntry;->-$$Nest$sfputpendingLegendPhysicalCameraId(I)V

    .line 9327
    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "[LegendLensRestart] target session ready camera="

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-static {}, Llocal/mio/os4camerabridge/HookEntry;->-$$Nest$sfgetactiveCameraId()I

    move-result v3

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v2

    const-string v3, " zoom="

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, v1}, Ljava/lang/StringBuilder;->append(F)Ljava/lang/StringBuilder;

    move-result-object v2

    const-string v3, "; transient lock released"

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-static {v2}, Llocal/mio/os4camerabridge/HookEntry;->-$$Nest$smlog(Ljava/lang/String;)V

    .line 9332
    .end local v1    # "completedZoom":F
    :cond_5
    return-void

    .line 9334
    :cond_6
    const v3, 0x8031

    if-ne v4, v3, :cond_7

    .line 9335
    iget-object v2, p1, Lde/robv/android/xposed/XC_MethodHook$MethodHookParam;->args:[Ljava/lang/Object;

    const v3, 0x80a2

    invoke-static {v3}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v3

    aput-object v3, v2, v1

    .line 9336
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "[VideoNightCompat] camera="

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, " mode=0x8031 -> 0x80a2; outputs="

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, v5}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-static {v1}, Llocal/mio/os4camerabridge/HookEntry;->-$$Nest$smlog(Ljava/lang/String;)V

    .line 9339
    return-void

    .line 9341
    :cond_7
    const v3, 0x80f3

    const-string v8, "0"

    if-ne v4, v3, :cond_8

    .line 9342
    invoke-virtual {v8, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v3

    if-eqz v3, :cond_8

    .line 9343
    iget-object v2, p1, Lde/robv/android/xposed/XC_MethodHook$MethodHookParam;->args:[Ljava/lang/Object;

    const v3, 0x8001

    invoke-static {v3}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v3

    aput-object v3, v2, v1

    .line 9344
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "[HighPixelContract] camera=0 mode=0x80f3 -> stock ColorOS mode=0x8001; outputs="

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, v5}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-static {v1}, Llocal/mio/os4camerabridge/HookEntry;->-$$Nest$smlog(Ljava/lang/String;)V

    .line 9347
    return-void

    .line 9349
    :cond_8
    const v3, 0x8002

    if-ne v4, v3, :cond_9

    iget-object v3, p1, Lde/robv/android/xposed/XC_MethodHook$MethodHookParam;->args:[Ljava/lang/Object;

    aget-object v3, v3, v6

    instance-of v3, v3, Ljava/util/List;

    if-eqz v3, :cond_9

    .line 9351
    iget-object v3, p1, Lde/robv/android/xposed/XC_MethodHook$MethodHookParam;->args:[Ljava/lang/Object;

    const/4 v8, 0x2

    aget-object v3, v3, v8

    invoke-static {v3}, Llocal/mio/os4camerabridge/HookEntry;->-$$Nest$smgetPortraitSessionZoom(Ljava/lang/Object;)F

    move-result v3

    .line 9359
    .local v3, "zoom":F
    iget-object v8, p1, Lde/robv/android/xposed/XC_MethodHook$MethodHookParam;->args:[Ljava/lang/Object;

    aput-object v2, v8, v1

    .line 9360
    iget-object v1, p1, Lde/robv/android/xposed/XC_MethodHook$MethodHookParam;->args:[Ljava/lang/Object;

    aget-object v1, v1, v6

    check-cast v1, Ljava/util/List;

    invoke-static {v1}, Llocal/mio/os4camerabridge/HookEntry;->-$$Nest$smlogPortraitOutputGraph(Ljava/util/List;)V

    .line 9361
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "[PortraitContract] camera="

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, " Xiaomi mode=0x8002 -> compatible mode=0 zoom="

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, v3}, Ljava/lang/StringBuilder;->append(F)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, " complete graph retained outputs="

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, v5}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-static {v1}, Llocal/mio/os4camerabridge/HookEntry;->-$$Nest$smlog(Ljava/lang/String;)V

    .line 9366
    return-void

    .line 9368
    .end local v3    # "zoom":F
    :cond_9
    const v3, 0x9002

    if-eq v4, v3, :cond_a

    .line 9369
    return-void

    .line 9371
    :cond_a
    invoke-virtual {v8, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v3

    if-nez v3, :cond_b

    .line 9372
    return-void

    .line 9374
    :cond_b
    iget-object v3, p1, Lde/robv/android/xposed/XC_MethodHook$MethodHookParam;->args:[Ljava/lang/Object;

    aput-object v2, v3, v1

    .line 9375
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "[SessionCompat] camera=0 mode=0x9002 -> regular(0), outputs="

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, v5}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-static {v1}, Llocal/mio/os4camerabridge/HookEntry;->-$$Nest$smlog(Ljava/lang/String;)V

    .line 9376
    return-void
.end method
