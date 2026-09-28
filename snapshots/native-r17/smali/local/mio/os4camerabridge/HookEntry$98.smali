.class Llocal/mio/os4camerabridge/HookEntry$98;
.super Lde/robv/android/xposed/XC_MethodHook;
.source "HookEntry.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Llocal/mio/os4camerabridge/HookEntry;->hookOplusFocus(Ljava/lang/ClassLoader;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# direct methods
.method constructor <init>()V
    .locals 0

    .line 14135
    invoke-direct {p0}, Lde/robv/android/xposed/XC_MethodHook;-><init>()V

    return-void
.end method


# virtual methods
.method protected afterHookedMethod(Lde/robv/android/xposed/XC_MethodHook$MethodHookParam;)V
    .locals 4
    .param p1, "param"    # Lde/robv/android/xposed/XC_MethodHook$MethodHookParam;

    .line 14190
    invoke-static {}, Llocal/mio/os4camerabridge/HookEntry;->-$$Nest$sfgetactiveCameraId()I

    move-result v0

    if-nez v0, :cond_2

    invoke-static {}, Llocal/mio/os4camerabridge/HookEntry;->-$$Nest$sfgetactiveCameraModule()I

    move-result v0

    const/16 v1, 0xa3

    if-ne v0, v1, :cond_2

    .line 14192
    invoke-virtual {p1}, Lde/robv/android/xposed/XC_MethodHook$MethodHookParam;->getResult()Ljava/lang/Object;

    move-result-object v0

    instance-of v0, v0, Landroid/hardware/camera2/CaptureRequest;

    if-nez v0, :cond_0

    goto :goto_0

    .line 14195
    :cond_0
    invoke-virtual {p1}, Lde/robv/android/xposed/XC_MethodHook$MethodHookParam;->getResult()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Landroid/hardware/camera2/CaptureRequest;

    .line 14196
    .local v0, "request":Landroid/hardware/camera2/CaptureRequest;
    sget-object v1, Landroid/hardware/camera2/CaptureRequest;->CONTROL_ZOOM_RATIO:Landroid/hardware/camera2/CaptureRequest$Key;

    invoke-virtual {v0, v1}, Landroid/hardware/camera2/CaptureRequest;->get(Landroid/hardware/camera2/CaptureRequest$Key;)Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Ljava/lang/Float;

    .line 14197
    .local v1, "ratio":Ljava/lang/Float;
    if-eqz v1, :cond_1

    invoke-virtual {v1}, Ljava/lang/Float;->floatValue()F

    move-result v2

    invoke-static {v2}, Ljava/lang/Float;->isFinite(F)Z

    move-result v2

    if-eqz v2, :cond_1

    .line 14198
    invoke-virtual {v1}, Ljava/lang/Float;->floatValue()F

    move-result v2

    const/high16 v3, 0x40400000    # 3.0f

    cmpl-float v2, v2, v3

    if-ltz v2, :cond_1

    .line 14204
    invoke-static {v0}, Llocal/mio/os4camerabridge/HookEntry;->-$$Nest$smlogTelePreviewContractDiffOnce(Landroid/hardware/camera2/CaptureRequest;)V

    .line 14206
    :cond_1
    return-void

    .line 14193
    .end local v0    # "request":Landroid/hardware/camera2/CaptureRequest;
    .end local v1    # "ratio":Ljava/lang/Float;
    :cond_2
    :goto_0
    return-void
.end method

.method protected beforeHookedMethod(Lde/robv/android/xposed/XC_MethodHook$MethodHookParam;)V
    .locals 10
    .param p1, "param"    # Lde/robv/android/xposed/XC_MethodHook$MethodHookParam;

    .line 14138
    iget-object v0, p1, Lde/robv/android/xposed/XC_MethodHook$MethodHookParam;->thisObject:Ljava/lang/Object;

    check-cast v0, Landroid/hardware/camera2/CaptureRequest$Builder;

    .line 14140
    .local v0, "builder":Landroid/hardware/camera2/CaptureRequest$Builder;
    :try_start_0
    sget-object v1, Landroid/hardware/camera2/CaptureRequest;->CONTROL_AF_TRIGGER:Landroid/hardware/camera2/CaptureRequest$Key;

    invoke-virtual {v0, v1}, Landroid/hardware/camera2/CaptureRequest$Builder;->get(Landroid/hardware/camera2/CaptureRequest$Key;)Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Ljava/lang/Integer;

    .line 14141
    .local v1, "trigger":Ljava/lang/Integer;
    if-eqz v1, :cond_5

    invoke-virtual {v1}, Ljava/lang/Integer;->intValue()I

    move-result v2

    const/4 v3, 0x1

    if-eq v2, v3, :cond_0

    goto/16 :goto_2

    .line 14144
    :cond_0
    sget-object v2, Landroid/hardware/camera2/CaptureRequest;->CONTROL_ZOOM_RATIO:Landroid/hardware/camera2/CaptureRequest$Key;

    invoke-virtual {v0, v2}, Landroid/hardware/camera2/CaptureRequest$Builder;->get(Landroid/hardware/camera2/CaptureRequest$Key;)Ljava/lang/Object;

    move-result-object v2

    check-cast v2, Ljava/lang/Float;

    .line 14145
    .local v2, "ratio":Ljava/lang/Float;
    if-eqz v2, :cond_1

    invoke-virtual {v2}, Ljava/lang/Float;->floatValue()F

    move-result v4

    invoke-static {v4}, Ljava/lang/Float;->isFinite(F)Z

    move-result v4

    if-eqz v4, :cond_1

    .line 14146
    invoke-virtual {v2}, Ljava/lang/Float;->floatValue()F

    move-result v4

    const v5, 0x3f7fbe77    # 0.999f

    cmpg-float v4, v4, v5

    if-gez v4, :cond_1

    .line 14151
    return-void

    .line 14153
    :cond_1
    sget-object v4, Landroid/hardware/camera2/CaptureRequest;->CONTROL_AF_MODE:Landroid/hardware/camera2/CaptureRequest$Key;

    invoke-virtual {v0, v4}, Landroid/hardware/camera2/CaptureRequest$Builder;->get(Landroid/hardware/camera2/CaptureRequest$Key;)Ljava/lang/Object;

    move-result-object v4

    check-cast v4, Ljava/lang/Integer;
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_2

    .line 14154
    .local v4, "mode":Ljava/lang/Integer;
    const/4 v5, 0x0

    .line 14155
    .local v5, "af":[Landroid/hardware/camera2/params/MeteringRectangle;
    const/4 v6, 0x0

    .line 14157
    .local v6, "ae":[Landroid/hardware/camera2/params/MeteringRectangle;
    const/4 v7, 0x0

    :try_start_1
    sget-object v8, Landroid/hardware/camera2/CaptureRequest;->CONTROL_AF_REGIONS:Landroid/hardware/camera2/CaptureRequest$Key;

    invoke-virtual {v0, v8}, Landroid/hardware/camera2/CaptureRequest$Builder;->get(Landroid/hardware/camera2/CaptureRequest$Key;)Ljava/lang/Object;

    move-result-object v8

    check-cast v8, [Landroid/hardware/camera2/params/MeteringRectangle;

    move-object v5, v8

    .line 14158
    if-eqz v5, :cond_3

    array-length v8, v5

    if-lez v8, :cond_3

    .line 14159
    if-eqz v4, :cond_2

    .line 14160
    invoke-virtual {v4}, Ljava/lang/Integer;->intValue()I

    move-result v8

    if-eqz v8, :cond_2

    .line 14161
    sget-object v8, Landroid/hardware/camera2/CaptureRequest;->CONTROL_AF_MODE:Landroid/hardware/camera2/CaptureRequest$Key;

    .line 14162
    invoke-static {v3}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v3

    .line 14161
    invoke-virtual {v0, v8, v3}, Landroid/hardware/camera2/CaptureRequest$Builder;->set(Landroid/hardware/camera2/CaptureRequest$Key;Ljava/lang/Object;)V

    .line 14164
    :cond_2
    invoke-static {}, Llocal/mio/os4camerabridge/HookEntry;->-$$Nest$sfgetOPLUS_AF_REGION()Landroid/hardware/camera2/CaptureRequest$Key;

    move-result-object v3

    aget-object v8, v5, v7

    invoke-static {v8}, Llocal/mio/os4camerabridge/HookEntry;->-$$Nest$smoplusRegion(Landroid/hardware/camera2/params/MeteringRectangle;)[I

    move-result-object v8

    invoke-virtual {v0, v3, v8}, Landroid/hardware/camera2/CaptureRequest$Builder;->set(Landroid/hardware/camera2/CaptureRequest$Key;Ljava/lang/Object;)V
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    .line 14169
    :cond_3
    goto :goto_0

    .line 14166
    :catchall_0
    move-exception v3

    .line 14167
    .local v3, "throwable":Ljava/lang/Throwable;
    :try_start_2
    new-instance v8, Ljava/lang/StringBuilder;

    invoke-direct {v8}, Ljava/lang/StringBuilder;-><init>()V

    const-string v9, "[FocusBridge] standard AF unavailable: "

    invoke-virtual {v8, v9}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v8

    invoke-virtual {v8, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v8

    invoke-virtual {v8}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v8

    invoke-static {v8}, Llocal/mio/os4camerabridge/HookEntry;->-$$Nest$smlog(Ljava/lang/String;)V
    :try_end_2
    .catchall {:try_start_2 .. :try_end_2} :catchall_2

    .line 14171
    .end local v3    # "throwable":Ljava/lang/Throwable;
    :goto_0
    :try_start_3
    sget-object v3, Landroid/hardware/camera2/CaptureRequest;->CONTROL_AE_REGIONS:Landroid/hardware/camera2/CaptureRequest$Key;

    invoke-virtual {v0, v3}, Landroid/hardware/camera2/CaptureRequest$Builder;->get(Landroid/hardware/camera2/CaptureRequest$Key;)Ljava/lang/Object;

    move-result-object v3

    check-cast v3, [Landroid/hardware/camera2/params/MeteringRectangle;

    move-object v6, v3

    .line 14172
    if-eqz v6, :cond_4

    array-length v3, v6

    if-lez v3, :cond_4

    .line 14173
    invoke-static {}, Llocal/mio/os4camerabridge/HookEntry;->-$$Nest$sfgetOPLUS_AE_REGION()Landroid/hardware/camera2/CaptureRequest$Key;

    move-result-object v3

    aget-object v7, v6, v7

    .line 14174
    invoke-static {v7}, Llocal/mio/os4camerabridge/HookEntry;->-$$Nest$smoplusRegion(Landroid/hardware/camera2/params/MeteringRectangle;)[I

    move-result-object v7

    .line 14173
    invoke-virtual {v0, v3, v7}, Landroid/hardware/camera2/CaptureRequest$Builder;->set(Landroid/hardware/camera2/CaptureRequest$Key;Ljava/lang/Object;)V
    :try_end_3
    .catchall {:try_start_3 .. :try_end_3} :catchall_1

    .line 14179
    :cond_4
    goto :goto_1

    .line 14176
    :catchall_1
    move-exception v3

    .line 14177
    .restart local v3    # "throwable":Ljava/lang/Throwable;
    :try_start_4
    new-instance v7, Ljava/lang/StringBuilder;

    invoke-direct {v7}, Ljava/lang/StringBuilder;-><init>()V

    const-string v8, "[FocusBridge] standard AE unavailable: "

    invoke-virtual {v7, v8}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v7

    invoke-virtual {v7, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v7

    invoke-virtual {v7}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v7

    invoke-static {v7}, Llocal/mio/os4camerabridge/HookEntry;->-$$Nest$smlog(Ljava/lang/String;)V

    .line 14180
    .end local v3    # "throwable":Ljava/lang/Throwable;
    :goto_1
    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    const-string v7, "[FocusBridge] afMode="

    invoke-virtual {v3, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v3

    const-string v7, " af="

    invoke-virtual {v3, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    .line 14181
    invoke-static {v5}, Ljava/util/Arrays;->toString([Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v7

    invoke-virtual {v3, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    const-string v7, " ae="

    invoke-virtual {v3, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    .line 14182
    invoke-static {v6}, Ljava/util/Arrays;->toString([Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v7

    invoke-virtual {v3, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    .line 14180
    invoke-static {v3}, Llocal/mio/os4camerabridge/HookEntry;->-$$Nest$smlog(Ljava/lang/String;)V
    :try_end_4
    .catchall {:try_start_4 .. :try_end_4} :catchall_2

    .line 14185
    .end local v1    # "trigger":Ljava/lang/Integer;
    .end local v2    # "ratio":Ljava/lang/Float;
    .end local v4    # "mode":Ljava/lang/Integer;
    .end local v5    # "af":[Landroid/hardware/camera2/params/MeteringRectangle;
    .end local v6    # "ae":[Landroid/hardware/camera2/params/MeteringRectangle;
    goto :goto_3

    .line 14142
    .restart local v1    # "trigger":Ljava/lang/Integer;
    :cond_5
    :goto_2
    return-void

    .line 14183
    .end local v1    # "trigger":Ljava/lang/Integer;
    :catchall_2
    move-exception v1

    .line 14184
    .local v1, "throwable":Ljava/lang/Throwable;
    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "[FocusBridge] request unchanged: "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-static {v2}, Llocal/mio/os4camerabridge/HookEntry;->-$$Nest$smlog(Ljava/lang/String;)V

    .line 14186
    .end local v1    # "throwable":Ljava/lang/Throwable;
    :goto_3
    return-void
.end method
