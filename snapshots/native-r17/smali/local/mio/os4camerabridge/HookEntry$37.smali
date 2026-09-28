.class Llocal/mio/os4camerabridge/HookEntry$37;
.super Lde/robv/android/xposed/XC_MethodHook;
.source "HookEntry.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Llocal/mio/os4camerabridge/HookEntry;->hookOplusBeautyRequestBridge(Ljava/lang/ClassLoader;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic val$beautyPreferences:Ljava/lang/Class;


# direct methods
.method constructor <init>(Ljava/lang/Class;)V
    .locals 0

    .line 7560
    iput-object p1, p0, Llocal/mio/os4camerabridge/HookEntry$37;->val$beautyPreferences:Ljava/lang/Class;

    invoke-direct {p0}, Lde/robv/android/xposed/XC_MethodHook;-><init>()V

    return-void
.end method


# virtual methods
.method protected afterHookedMethod(Lde/robv/android/xposed/XC_MethodHook$MethodHookParam;)V
    .locals 10
    .param p1, "param"    # Lde/robv/android/xposed/XC_MethodHook$MethodHookParam;

    .line 7563
    const-string v0, ":"

    invoke-static {}, Llocal/mio/os4camerabridge/HookEntry;->-$$Nest$sfgetactiveBeautyModule()I

    move-result v1

    const/16 v2, 0xa3

    const/16 v3, 0xab

    if-eq v1, v2, :cond_0

    invoke-static {}, Llocal/mio/os4camerabridge/HookEntry;->-$$Nest$sfgetactiveBeautyModule()I

    move-result v1

    if-eq v1, v3, :cond_0

    .line 7565
    return-void

    .line 7567
    :cond_0
    iget-object v1, p1, Lde/robv/android/xposed/XC_MethodHook$MethodHookParam;->args:[Ljava/lang/Object;

    if-eqz v1, :cond_7

    iget-object v1, p1, Lde/robv/android/xposed/XC_MethodHook$MethodHookParam;->args:[Ljava/lang/Object;

    array-length v1, v1

    const/4 v2, 0x4

    if-ne v1, v2, :cond_7

    iget-object v1, p1, Lde/robv/android/xposed/XC_MethodHook$MethodHookParam;->args:[Ljava/lang/Object;

    const/4 v2, 0x0

    aget-object v1, v1, v2

    instance-of v1, v1, Landroid/hardware/camera2/CaptureRequest$Builder;

    if-eqz v1, :cond_7

    iget-object v1, p1, Lde/robv/android/xposed/XC_MethodHook$MethodHookParam;->args:[Ljava/lang/Object;

    const/4 v4, 0x3

    aget-object v1, v1, v4

    if-nez v1, :cond_1

    goto/16 :goto_4

    .line 7574
    :cond_1
    :try_start_0
    iget-object v1, p1, Lde/robv/android/xposed/XC_MethodHook$MethodHookParam;->args:[Ljava/lang/Object;

    aget-object v1, v1, v2

    check-cast v1, Landroid/hardware/camera2/CaptureRequest$Builder;

    .line 7576
    .local v1, "builder":Landroid/hardware/camera2/CaptureRequest$Builder;
    iget-object v5, p1, Lde/robv/android/xposed/XC_MethodHook$MethodHookParam;->args:[Ljava/lang/Object;

    aget-object v4, v5, v4

    iget-object v5, p0, Llocal/mio/os4camerabridge/HookEntry$37;->val$beautyPreferences:Ljava/lang/Class;

    invoke-static {v4, v5}, Llocal/mio/os4camerabridge/HookEntry;->-$$Nest$smbuildOplusBeautyUi13(Ljava/lang/Object;Ljava/lang/Class;)[I

    move-result-object v4

    .line 7578
    .local v4, "ui13":[I
    nop

    .line 7579
    invoke-static {v4}, Llocal/mio/os4camerabridge/HookEntry;->-$$Nest$smconvertOplusBeautyUiToPreviewHal([I)[I

    move-result-object v5

    .line 7580
    .local v5, "previewHal14":[I
    const/4 v6, 0x0

    .line 7581
    .local v6, "enabled":Z
    array-length v7, v4

    move v8, v2

    :goto_0
    if-ge v8, v7, :cond_3

    aget v9, v4, v8

    .line 7582
    .local v9, "value":I
    if-eqz v9, :cond_2

    .line 7583
    const/4 v6, 0x1

    .line 7584
    goto :goto_1

    .line 7581
    .end local v9    # "value":I
    :cond_2
    add-int/lit8 v8, v8, 0x1

    goto :goto_0

    .line 7587
    :cond_3
    :goto_1
    if-eqz v6, :cond_4

    const/16 v7, 0x66

    goto :goto_2

    :cond_4
    move v7, v2

    :goto_2
    filled-new-array {v7}, [I

    move-result-object v7

    .line 7588
    .local v7, "level":[I
    invoke-virtual {v4}, [I->clone()Ljava/lang/Object;

    move-result-object v8

    check-cast v8, [I

    invoke-static {v8}, Llocal/mio/os4camerabridge/HookEntry;->-$$Nest$sfputactiveBeautyUi13([I)V

    .line 7589
    invoke-virtual {v5}, [I->clone()Ljava/lang/Object;

    move-result-object v8

    check-cast v8, [I

    invoke-static {v8}, Llocal/mio/os4camerabridge/HookEntry;->-$$Nest$sfputactiveBeautyPreviewHal14([I)V

    .line 7590
    invoke-static {v6}, Llocal/mio/os4camerabridge/HookEntry;->-$$Nest$sfputactiveBeautyEnabled(Z)V

    .line 7591
    invoke-static {}, Llocal/mio/os4camerabridge/HookEntry;->-$$Nest$sfgetOPLUS_FACE_BEAUTY_LEVEL()Landroid/hardware/camera2/CaptureRequest$Key;

    move-result-object v8

    invoke-virtual {v1, v8, v7}, Landroid/hardware/camera2/CaptureRequest$Builder;->set(Landroid/hardware/camera2/CaptureRequest$Key;Ljava/lang/Object;)V

    .line 7595
    invoke-static {}, Llocal/mio/os4camerabridge/HookEntry;->-$$Nest$sfgetOPLUS_FACE_BEAUTY_CUSTOM()Landroid/hardware/camera2/CaptureRequest$Key;

    move-result-object v8

    invoke-virtual {v1, v8, v4}, Landroid/hardware/camera2/CaptureRequest$Builder;->set(Landroid/hardware/camera2/CaptureRequest$Key;Ljava/lang/Object;)V

    .line 7596
    invoke-static {}, Llocal/mio/os4camerabridge/HookEntry;->-$$Nest$sfgetactiveBeautyModule()I

    move-result v8

    if-ne v8, v3, :cond_5

    .line 7597
    invoke-static {}, Llocal/mio/os4camerabridge/HookEntry;->-$$Nest$sfgetOPLUS_CAMERA_MODE()Landroid/hardware/camera2/CaptureRequest$Key;

    move-result-object v3

    const-string v8, "portrait_mode\u0000"

    sget-object v9, Ljava/nio/charset/StandardCharsets;->UTF_8:Ljava/nio/charset/Charset;

    .line 7598
    invoke-virtual {v8, v9}, Ljava/lang/String;->getBytes(Ljava/nio/charset/Charset;)[B

    move-result-object v8

    .line 7597
    invoke-virtual {v1, v3, v8}, Landroid/hardware/camera2/CaptureRequest$Builder;->set(Landroid/hardware/camera2/CaptureRequest$Key;Ljava/lang/Object;)V

    .line 7600
    invoke-static {}, Llocal/mio/os4camerabridge/HookEntry;->-$$Nest$sfgetOPLUS_BOKEH_LEVEL()Landroid/hardware/camera2/CaptureRequest$Key;

    move-result-object v3

    const/4 v8, 0x1

    new-array v8, v8, [F

    const v9, 0x3e8a3d71    # 0.27f

    aput v9, v8, v2

    invoke-virtual {v1, v3, v8}, Landroid/hardware/camera2/CaptureRequest$Builder;->set(Landroid/hardware/camera2/CaptureRequest$Key;Ljava/lang/Object;)V

    .line 7604
    :cond_5
    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    invoke-static {}, Llocal/mio/os4camerabridge/HookEntry;->-$$Nest$sfgetactiveBeautyModule()I

    move-result v3

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    .line 7605
    invoke-static {v7}, Ljava/util/Arrays;->toString([I)Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    .line 7606
    invoke-static {v4}, Ljava/util/Arrays;->toString([I)Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v0, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    .line 7607
    .local v0, "signature":Ljava/lang/String;
    invoke-static {}, Llocal/mio/os4camerabridge/HookEntry;->-$$Nest$sfgetlastBeautyRequestSignature()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v0, v2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v2

    if-nez v2, :cond_6

    .line 7608
    invoke-static {v0}, Llocal/mio/os4camerabridge/HookEntry;->-$$Nest$sfputlastBeautyRequestSignature(Ljava/lang/String;)V

    .line 7609
    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "[BeautyBridge] module="

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-static {}, Llocal/mio/os4camerabridge/HookEntry;->-$$Nest$sfgetactiveBeautyModule()I

    move-result v3

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v2

    const-string v3, " level="

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    .line 7611
    invoke-static {v7}, Ljava/util/Arrays;->toString([I)Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    const-string v3, " ui13="

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    .line 7613
    invoke-static {v4}, Ljava/util/Arrays;->toString([I)Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    const-string v3, " previewHal14="

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    .line 7615
    invoke-static {v5}, Ljava/util/Arrays;->toString([I)Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    .line 7609
    invoke-static {v2}, Llocal/mio/os4camerabridge/HookEntry;->-$$Nest$smlog(Ljava/lang/String;)V
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 7620
    .end local v0    # "signature":Ljava/lang/String;
    .end local v1    # "builder":Landroid/hardware/camera2/CaptureRequest$Builder;
    .end local v4    # "ui13":[I
    .end local v5    # "previewHal14":[I
    .end local v6    # "enabled":Z
    .end local v7    # "level":[I
    :cond_6
    goto :goto_3

    .line 7617
    :catchall_0
    move-exception v0

    .line 7618
    .local v0, "throwable":Ljava/lang/Throwable;
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "[BeautyBridge] request injection failed: "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-static {v1}, Llocal/mio/os4camerabridge/HookEntry;->-$$Nest$smlog(Ljava/lang/String;)V

    .line 7621
    .end local v0    # "throwable":Ljava/lang/Throwable;
    :goto_3
    return-void

    .line 7571
    :cond_7
    :goto_4
    return-void
.end method
