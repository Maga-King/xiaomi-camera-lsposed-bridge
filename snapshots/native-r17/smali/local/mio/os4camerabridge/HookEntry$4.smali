.class Llocal/mio/os4camerabridge/HookEntry$4;
.super Lde/robv/android/xposed/XC_MethodHook;
.source "HookEntry.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Llocal/mio/os4camerabridge/HookEntry;->hookOplusCommonPhotoBridge(Ljava/lang/ClassLoader;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# direct methods
.method constructor <init>()V
    .locals 0

    .line 1354
    invoke-direct {p0}, Lde/robv/android/xposed/XC_MethodHook;-><init>()V

    return-void
.end method


# virtual methods
.method protected beforeHookedMethod(Lde/robv/android/xposed/XC_MethodHook$MethodHookParam;)V
    .locals 10
    .param p1, "param"    # Lde/robv/android/xposed/XC_MethodHook$MethodHookParam;

    .line 1357
    invoke-static {}, Llocal/mio/os4camerabridge/HookEntry;->-$$Nest$sfgetcommonApsPhotoSessionActive()Z

    move-result v0

    .line 1358
    .local v0, "previous":Z
    const/4 v1, 0x0

    invoke-static {v1}, Llocal/mio/os4camerabridge/HookEntry;->-$$Nest$sfputcommonApsPhotoSessionActive(Z)V

    .line 1359
    invoke-static {}, Llocal/mio/os4camerabridge/HookEntry;->-$$Nest$sfgetcommonApsDisabled()Z

    move-result v2

    const/4 v3, 0x1

    if-nez v2, :cond_4

    invoke-static {}, Llocal/mio/os4camerabridge/HookEntry;->-$$Nest$sfgetactiveCameraModule()I

    move-result v2

    const/16 v4, 0xa3

    if-ne v2, v4, :cond_4

    iget-object v2, p1, Lde/robv/android/xposed/XC_MethodHook$MethodHookParam;->args:[Ljava/lang/Object;

    if-eqz v2, :cond_4

    iget-object v2, p1, Lde/robv/android/xposed/XC_MethodHook$MethodHookParam;->args:[Ljava/lang/Object;

    array-length v2, v2

    const/4 v4, 0x5

    if-ne v2, v4, :cond_4

    iget-object v2, p1, Lde/robv/android/xposed/XC_MethodHook$MethodHookParam;->args:[Ljava/lang/Object;

    aget-object v2, v2, v3

    instance-of v2, v2, Ljava/util/List;

    if-nez v2, :cond_0

    goto/16 :goto_2

    .line 1368
    :cond_0
    :try_start_0
    iget-object v2, p1, Lde/robv/android/xposed/XC_MethodHook$MethodHookParam;->thisObject:Ljava/lang/Object;

    const-string v4, "c"

    new-array v5, v1, [Ljava/lang/Object;

    .line 1369
    invoke-static {v2, v4, v5}, Lde/robv/android/xposed/XposedHelpers;->callMethod(Ljava/lang/Object;Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v2

    .line 1368
    invoke-static {v2}, Ljava/lang/String;->valueOf(Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v2

    .line 1370
    .local v2, "cameraId":Ljava/lang/String;
    const-string v4, "0"

    invoke-virtual {v4, v2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v4

    if-eqz v4, :cond_2

    iget-object v4, p1, Lde/robv/android/xposed/XC_MethodHook$MethodHookParam;->args:[Ljava/lang/Object;

    .line 1371
    invoke-static {v4}, Llocal/mio/os4camerabridge/HookEntry;->-$$Nest$smisOrdinaryPhotoSession([Ljava/lang/Object;)Z

    move-result v4

    if-eqz v4, :cond_2

    .line 1372
    invoke-static {}, Llocal/mio/os4camerabridge/HookEntry;->-$$Nest$smensureCommonApsInfrastructure()Z

    move-result v4

    if-nez v4, :cond_1

    goto :goto_0

    .line 1379
    :cond_1
    iget-object v4, p1, Lde/robv/android/xposed/XC_MethodHook$MethodHookParam;->args:[Ljava/lang/Object;

    aget-object v4, v4, v3

    check-cast v4, Ljava/util/List;

    .line 1380
    .local v4, "outputs":Ljava/util/List;, "Ljava/util/List<*>;"
    invoke-static {v4}, Llocal/mio/os4camerabridge/HookEntry;->-$$Nest$smoutputFormatSignature(Ljava/util/List;)Ljava/lang/String;

    move-result-object v5

    .line 1381
    .local v5, "sourceSignature":Ljava/lang/String;
    invoke-static {}, Llocal/mio/os4camerabridge/HookEntry;->-$$Nest$sfgetcommonRawMainReader()Landroid/media/ImageReader;

    move-result-object v6

    .line 1382
    invoke-virtual {v6}, Landroid/media/ImageReader;->getSurface()Landroid/view/Surface;

    move-result-object v6

    .line 1381
    invoke-static {v4, v6}, Llocal/mio/os4camerabridge/HookEntry;->-$$Nest$smappendOutputSurface(Ljava/util/List;Landroid/view/Surface;)Z

    move-result v6

    .line 1383
    .local v6, "mainAdded":Z
    invoke-static {}, Llocal/mio/os4camerabridge/HookEntry;->-$$Nest$sfgetcommonRawDolReader()Landroid/media/ImageReader;

    move-result-object v7

    .line 1384
    invoke-virtual {v7}, Landroid/media/ImageReader;->getSurface()Landroid/view/Surface;

    move-result-object v7

    .line 1383
    invoke-static {v4, v7}, Llocal/mio/os4camerabridge/HookEntry;->-$$Nest$smappendOutputSurface(Ljava/util/List;Landroid/view/Surface;)Z

    move-result v7

    .line 1385
    .local v7, "dolAdded":Z
    invoke-static {}, Llocal/mio/os4camerabridge/HookEntry;->-$$Nest$sfgetcommonAuxYuvReader()Landroid/media/ImageReader;

    move-result-object v8

    .line 1386
    invoke-virtual {v8}, Landroid/media/ImageReader;->getSurface()Landroid/view/Surface;

    move-result-object v8

    .line 1385
    invoke-static {v4, v8}, Llocal/mio/os4camerabridge/HookEntry;->-$$Nest$smappendOutputSurface(Ljava/util/List;Landroid/view/Surface;)Z

    move-result v8

    .line 1387
    .local v8, "auxYuvAdded":Z
    invoke-static {v3}, Llocal/mio/os4camerabridge/HookEntry;->-$$Nest$sfputcommonApsPhotoSessionActive(Z)V

    .line 1388
    invoke-static {}, Llocal/mio/os4camerabridge/HookEntry;->-$$Nest$smscheduleCommonApsInitialization()V

    .line 1389
    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    const-string v9, "[CommonAPS] rear Photo session added RAW10 main="

    invoke-virtual {v3, v9}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3, v6}, Ljava/lang/StringBuilder;->append(Z)Ljava/lang/StringBuilder;

    move-result-object v3

    const-string v9, " dol="

    invoke-virtual {v3, v9}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3, v7}, Ljava/lang/StringBuilder;->append(Z)Ljava/lang/StringBuilder;

    move-result-object v3

    const-string v9, " previewYUV="

    invoke-virtual {v3, v9}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3, v8}, Ljava/lang/StringBuilder;->append(Z)Ljava/lang/StringBuilder;

    move-result-object v3

    const-string v9, " source="

    invoke-virtual {v3, v9}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    const-string v9, " finalOutputs="

    invoke-virtual {v3, v9}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    .line 1393
    invoke-interface {v4}, Ljava/util/List;->size()I

    move-result v9

    invoke-virtual {v3, v9}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    .line 1389
    invoke-static {v3}, Llocal/mio/os4camerabridge/HookEntry;->-$$Nest$smlog(Ljava/lang/String;)V

    .line 1398
    .end local v2    # "cameraId":Ljava/lang/String;
    .end local v4    # "outputs":Ljava/util/List;, "Ljava/util/List<*>;"
    .end local v5    # "sourceSignature":Ljava/lang/String;
    .end local v6    # "mainAdded":Z
    .end local v7    # "dolAdded":Z
    .end local v8    # "auxYuvAdded":Z
    goto :goto_1

    .line 1373
    .restart local v2    # "cameraId":Ljava/lang/String;
    :cond_2
    :goto_0
    if-eqz v0, :cond_3

    .line 1374
    const-string v4, "ordinary-session-reconfigured"

    invoke-static {v4, v3}, Llocal/mio/os4camerabridge/HookEntry;->-$$Nest$smabortCommonApsCapture(Ljava/lang/String;Z)V
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 1377
    :cond_3
    return-void

    .line 1394
    .end local v2    # "cameraId":Ljava/lang/String;
    :catchall_0
    move-exception v2

    .line 1395
    .local v2, "throwable":Ljava/lang/Throwable;
    invoke-static {v1}, Llocal/mio/os4camerabridge/HookEntry;->-$$Nest$sfputcommonApsPhotoSessionActive(Z)V

    .line 1396
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "[CommonAPS] session left unchanged after failure: "

    invoke-virtual {v1, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-static {v1}, Llocal/mio/os4camerabridge/HookEntry;->-$$Nest$smlog(Ljava/lang/String;)V

    .line 1399
    .end local v2    # "throwable":Ljava/lang/Throwable;
    :goto_1
    return-void

    .line 1362
    :cond_4
    :goto_2
    if-eqz v0, :cond_5

    .line 1363
    const-string v1, "photo-session-left"

    invoke-static {v1, v3}, Llocal/mio/os4camerabridge/HookEntry;->-$$Nest$smabortCommonApsCapture(Ljava/lang/String;Z)V

    .line 1365
    :cond_5
    return-void
.end method
