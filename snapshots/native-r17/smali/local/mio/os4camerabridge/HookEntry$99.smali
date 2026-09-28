.class Llocal/mio/os4camerabridge/HookEntry$99;
.super Lde/robv/android/xposed/XC_MethodHook;
.source "HookEntry.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Llocal/mio/os4camerabridge/HookEntry;->hookXiaomiFocusRegionWriter(Ljava/lang/Class;Ljava/lang/String;Z)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic val$autofocus:Z


# direct methods
.method constructor <init>(Z)V
    .locals 0

    .line 14214
    iput-boolean p1, p0, Llocal/mio/os4camerabridge/HookEntry$99;->val$autofocus:Z

    invoke-direct {p0}, Lde/robv/android/xposed/XC_MethodHook;-><init>()V

    return-void
.end method


# virtual methods
.method protected afterHookedMethod(Lde/robv/android/xposed/XC_MethodHook$MethodHookParam;)V
    .locals 12
    .param p1, "param"    # Lde/robv/android/xposed/XC_MethodHook$MethodHookParam;

    .line 14217
    const-string v0, "AF"

    const-string v1, "AE"

    iget-object v2, p1, Lde/robv/android/xposed/XC_MethodHook$MethodHookParam;->args:[Ljava/lang/Object;

    if-eqz v2, :cond_c

    iget-object v2, p1, Lde/robv/android/xposed/XC_MethodHook$MethodHookParam;->args:[Ljava/lang/Object;

    array-length v2, v2

    const/4 v3, 0x2

    if-ne v2, v3, :cond_c

    iget-object v2, p1, Lde/robv/android/xposed/XC_MethodHook$MethodHookParam;->args:[Ljava/lang/Object;

    const/4 v3, 0x0

    aget-object v2, v2, v3

    instance-of v2, v2, Landroid/hardware/camera2/CaptureRequest$Builder;

    if-eqz v2, :cond_c

    iget-object v2, p1, Lde/robv/android/xposed/XC_MethodHook$MethodHookParam;->args:[Ljava/lang/Object;

    const/4 v4, 0x1

    aget-object v2, v2, v4

    if-nez v2, :cond_0

    goto/16 :goto_7

    .line 14224
    :cond_0
    :try_start_0
    iget-object v2, p1, Lde/robv/android/xposed/XC_MethodHook$MethodHookParam;->args:[Ljava/lang/Object;

    aget-object v2, v2, v3

    check-cast v2, Landroid/hardware/camera2/CaptureRequest$Builder;

    .line 14226
    .local v2, "builder":Landroid/hardware/camera2/CaptureRequest$Builder;
    iget-object v5, p1, Lde/robv/android/xposed/XC_MethodHook$MethodHookParam;->args:[Ljava/lang/Object;

    aget-object v5, v5, v4

    .line 14227
    iget-boolean v6, p0, Llocal/mio/os4camerabridge/HookEntry$99;->val$autofocus:Z

    if-eqz v6, :cond_1

    const-string v6, "c"

    goto :goto_0

    :cond_1
    const-string v6, "b"

    .line 14226
    :goto_0
    invoke-static {v5, v6}, Lde/robv/android/xposed/XposedHelpers;->getObjectField(Ljava/lang/Object;Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v5

    .line 14228
    .local v5, "rawRegions":Ljava/lang/Object;
    instance-of v6, v5, [Landroid/hardware/camera2/params/MeteringRectangle;

    if-nez v6, :cond_2

    .line 14229
    return-void

    .line 14231
    :cond_2
    move-object v6, v5

    check-cast v6, [Landroid/hardware/camera2/params/MeteringRectangle;

    .line 14233
    .local v6, "regions":[Landroid/hardware/camera2/params/MeteringRectangle;
    array-length v7, v6

    if-eqz v7, :cond_a

    aget-object v7, v6, v3

    if-nez v7, :cond_3

    goto/16 :goto_4

    .line 14236
    :cond_3
    iget-object v7, p1, Lde/robv/android/xposed/XC_MethodHook$MethodHookParam;->args:[Ljava/lang/Object;

    aget-object v7, v7, v4

    const-string v8, "c0"

    invoke-static {v7, v8}, Lde/robv/android/xposed/XposedHelpers;->getFloatField(Ljava/lang/Object;Ljava/lang/String;)F

    move-result v7

    .line 14238
    .local v7, "ratio":F
    invoke-static {v7}, Ljava/lang/Float;->isFinite(F)Z

    move-result v8

    if-eqz v8, :cond_4

    const/4 v8, 0x0

    cmpg-float v8, v7, v8

    if-gtz v8, :cond_5

    .line 14239
    :cond_4
    const/high16 v7, 0x3f800000    # 1.0f

    .line 14241
    :cond_5
    aget-object v8, v6, v3

    .line 14242
    .local v8, "original":Landroid/hardware/camera2/params/MeteringRectangle;
    iget-boolean v9, p0, Llocal/mio/os4camerabridge/HookEntry$99;->val$autofocus:Z

    if-eqz v9, :cond_6

    .line 14243
    invoke-static {}, Llocal/mio/os4camerabridge/HookEntry;->-$$Nest$sfgetOPLUS_AF_REGION()Landroid/hardware/camera2/CaptureRequest$Key;

    move-result-object v9

    goto :goto_1

    :cond_6
    invoke-static {}, Llocal/mio/os4camerabridge/HookEntry;->-$$Nest$sfgetOPLUS_AE_REGION()Landroid/hardware/camera2/CaptureRequest$Key;

    move-result-object v9

    .line 14244
    .local v9, "vendorKey":Landroid/hardware/camera2/CaptureRequest$Key;, "Landroid/hardware/camera2/CaptureRequest$Key<[I>;"
    :goto_1
    invoke-static {v8}, Llocal/mio/os4camerabridge/HookEntry;->-$$Nest$smoplusRegion(Landroid/hardware/camera2/params/MeteringRectangle;)[I

    move-result-object v10

    invoke-virtual {v2, v9, v10}, Landroid/hardware/camera2/CaptureRequest$Builder;->set(Landroid/hardware/camera2/CaptureRequest$Key;Ljava/lang/Object;)V

    .line 14246
    const v10, 0x3f7fbe77    # 0.999f

    cmpg-float v10, v7, v10

    if-gez v10, :cond_9

    .line 14247
    invoke-virtual {v8}, Landroid/hardware/camera2/params/MeteringRectangle;->getWidth()I

    move-result v10

    if-lez v10, :cond_9

    .line 14248
    invoke-virtual {v8}, Landroid/hardware/camera2/params/MeteringRectangle;->getHeight()I

    move-result v10

    if-lez v10, :cond_9

    .line 14249
    invoke-virtual {v8}, Landroid/hardware/camera2/params/MeteringRectangle;->getMeteringWeight()I

    move-result v10

    if-lez v10, :cond_9

    .line 14250
    nop

    .line 14253
    invoke-static {}, Llocal/mio/os4camerabridge/HookEntry;->-$$Nest$smfullRearActiveArray()Landroid/graphics/Rect;

    move-result-object v10

    .line 14251
    invoke-static {v8, v7, v10}, Llocal/mio/os4camerabridge/HookEntry;->-$$Nest$smmapExpandedFocusRegionToActive(Landroid/hardware/camera2/params/MeteringRectangle;FLandroid/graphics/Rect;)Landroid/hardware/camera2/params/MeteringRectangle;

    move-result-object v10

    .line 14254
    .local v10, "standard":Landroid/hardware/camera2/params/MeteringRectangle;
    iget-boolean v11, p0, Llocal/mio/os4camerabridge/HookEntry$99;->val$autofocus:Z

    if-eqz v11, :cond_7

    .line 14255
    sget-object v11, Landroid/hardware/camera2/CaptureRequest;->CONTROL_AF_REGIONS:Landroid/hardware/camera2/CaptureRequest$Key;

    goto :goto_2

    .line 14256
    :cond_7
    sget-object v11, Landroid/hardware/camera2/CaptureRequest;->CONTROL_AE_REGIONS:Landroid/hardware/camera2/CaptureRequest$Key;

    :goto_2
    new-array v4, v4, [Landroid/hardware/camera2/params/MeteringRectangle;

    aput-object v10, v4, v3

    .line 14254
    invoke-virtual {v2, v11, v4}, Landroid/hardware/camera2/CaptureRequest$Builder;->set(Landroid/hardware/camera2/CaptureRequest$Key;Ljava/lang/Object;)V

    .line 14258
    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    const-string v4, "[FocusBridge] "

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    .line 14259
    iget-boolean v4, p0, Llocal/mio/os4camerabridge/HookEntry$99;->val$autofocus:Z

    if-eqz v4, :cond_8

    move-object v4, v0

    goto :goto_3

    :cond_8
    move-object v4, v1

    :goto_3
    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    const-string v4, " ratio="

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3, v7}, Ljava/lang/StringBuilder;->append(F)Ljava/lang/StringBuilder;

    move-result-object v3

    const-string v4, " private="

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    .line 14262
    invoke-static {v8}, Llocal/mio/os4camerabridge/HookEntry;->-$$Nest$smoplusRegion(Landroid/hardware/camera2/params/MeteringRectangle;)[I

    move-result-object v4

    .line 14261
    invoke-static {v4}, Ljava/util/Arrays;->toString([I)Ljava/lang/String;

    move-result-object v4

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    const-string v4, " standard="

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3, v10}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    .line 14258
    invoke-static {v3}, Llocal/mio/os4camerabridge/HookEntry;->-$$Nest$smlog(Ljava/lang/String;)V
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 14269
    .end local v2    # "builder":Landroid/hardware/camera2/CaptureRequest$Builder;
    .end local v5    # "rawRegions":Ljava/lang/Object;
    .end local v6    # "regions":[Landroid/hardware/camera2/params/MeteringRectangle;
    .end local v7    # "ratio":F
    .end local v8    # "original":Landroid/hardware/camera2/params/MeteringRectangle;
    .end local v9    # "vendorKey":Landroid/hardware/camera2/CaptureRequest$Key;, "Landroid/hardware/camera2/CaptureRequest$Key<[I>;"
    .end local v10    # "standard":Landroid/hardware/camera2/params/MeteringRectangle;
    :cond_9
    goto :goto_6

    .line 14234
    .restart local v2    # "builder":Landroid/hardware/camera2/CaptureRequest$Builder;
    .restart local v5    # "rawRegions":Ljava/lang/Object;
    .restart local v6    # "regions":[Landroid/hardware/camera2/params/MeteringRectangle;
    :cond_a
    :goto_4
    return-void

    .line 14265
    .end local v2    # "builder":Landroid/hardware/camera2/CaptureRequest$Builder;
    .end local v5    # "rawRegions":Ljava/lang/Object;
    .end local v6    # "regions":[Landroid/hardware/camera2/params/MeteringRectangle;
    :catchall_0
    move-exception v2

    .line 14266
    .local v2, "throwable":Ljava/lang/Throwable;
    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    const-string v4, "[FocusBridge] Xiaomi "

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    .line 14267
    iget-boolean v4, p0, Llocal/mio/os4camerabridge/HookEntry$99;->val$autofocus:Z

    if-eqz v4, :cond_b

    goto :goto_5

    :cond_b
    move-object v0, v1

    :goto_5
    invoke-virtual {v3, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, " writer unchanged: "

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    .line 14266
    invoke-static {v0}, Llocal/mio/os4camerabridge/HookEntry;->-$$Nest$smlog(Ljava/lang/String;)V

    .line 14270
    .end local v2    # "throwable":Ljava/lang/Throwable;
    :goto_6
    return-void

    .line 14221
    :cond_c
    :goto_7
    return-void
.end method
