.class Llocal/mio/os4camerabridge/HookEntry$25;
.super Lde/robv/android/xposed/XC_MethodHook;
.source "HookEntry.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Llocal/mio/os4camerabridge/HookEntry;->hookLegendaryRawPipeline(Ljava/lang/ClassLoader;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# direct methods
.method constructor <init>()V
    .locals 0

    .line 6591
    invoke-direct {p0}, Lde/robv/android/xposed/XC_MethodHook;-><init>()V

    return-void
.end method


# virtual methods
.method protected beforeHookedMethod(Lde/robv/android/xposed/XC_MethodHook$MethodHookParam;)V
    .locals 7
    .param p1, "param"    # Lde/robv/android/xposed/XC_MethodHook$MethodHookParam;

    .line 6594
    const/4 v0, 0x0

    invoke-static {v0}, Llocal/mio/os4camerabridge/HookEntry;->-$$Nest$sfputlegendRawSessionActive(Z)V

    .line 6595
    invoke-static {}, Llocal/mio/os4camerabridge/HookEntry;->-$$Nest$sfgetactiveCameraModule()I

    move-result v1

    const/16 v2, 0x100

    if-ne v1, v2, :cond_4

    invoke-static {}, Llocal/mio/os4camerabridge/HookEntry;->-$$Nest$sfgetactiveLegendMode()I

    move-result v1

    const/4 v2, 0x1

    if-ne v1, v2, :cond_4

    iget-object v1, p1, Lde/robv/android/xposed/XC_MethodHook$MethodHookParam;->args:[Ljava/lang/Object;

    if-eqz v1, :cond_4

    iget-object v1, p1, Lde/robv/android/xposed/XC_MethodHook$MethodHookParam;->args:[Ljava/lang/Object;

    array-length v1, v1

    const/4 v3, 0x5

    if-ne v1, v3, :cond_4

    iget-object v1, p1, Lde/robv/android/xposed/XC_MethodHook$MethodHookParam;->args:[Ljava/lang/Object;

    aget-object v1, v1, v2

    instance-of v1, v1, Ljava/util/List;

    if-nez v1, :cond_0

    goto/16 :goto_3

    .line 6601
    :cond_0
    :try_start_0
    iget-object v1, p1, Lde/robv/android/xposed/XC_MethodHook$MethodHookParam;->thisObject:Ljava/lang/Object;

    const-string v3, "c"

    new-array v4, v0, [Ljava/lang/Object;

    .line 6602
    invoke-static {v1, v3, v4}, Lde/robv/android/xposed/XposedHelpers;->callMethod(Ljava/lang/Object;Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v1

    .line 6601
    invoke-static {v1}, Ljava/lang/String;->valueOf(Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v1

    .line 6603
    .local v1, "cameraId":Ljava/lang/String;
    invoke-static {v1}, Ljava/lang/Integer;->parseInt(Ljava/lang/String;)I

    move-result v3

    .line 6604
    .local v3, "numericCameraId":I
    invoke-static {v3}, Llocal/mio/os4camerabridge/HookEntry;->-$$Nest$smisRearDirectCaptureCamera(I)Z

    move-result v4

    if-eqz v4, :cond_3

    .line 6605
    invoke-static {v3}, Llocal/mio/os4camerabridge/HookEntry;->-$$Nest$smsupportsLegendRawSensor(I)Z

    move-result v4

    if-eqz v4, :cond_3

    .line 6606
    invoke-static {}, Llocal/mio/os4camerabridge/HookEntry;->-$$Nest$smensureLegendRawReader()Z

    move-result v4

    if-nez v4, :cond_1

    goto :goto_1

    .line 6609
    :cond_1
    invoke-static {v3}, Llocal/mio/os4camerabridge/HookEntry;->-$$Nest$sfputlegendRawCameraId(I)V

    .line 6610
    iget-object v4, p1, Lde/robv/android/xposed/XC_MethodHook$MethodHookParam;->args:[Ljava/lang/Object;

    aget-object v4, v4, v2

    check-cast v4, Ljava/util/List;

    invoke-static {}, Llocal/mio/os4camerabridge/HookEntry;->-$$Nest$sfgetlegendRawReader()Landroid/media/ImageReader;

    move-result-object v5

    .line 6612
    invoke-virtual {v5}, Landroid/media/ImageReader;->getSurface()Landroid/view/Surface;

    move-result-object v5

    .line 6610
    invoke-static {v4, v5}, Llocal/mio/os4camerabridge/HookEntry;->-$$Nest$smappendOutputSurface(Ljava/util/List;Landroid/view/Surface;)Z

    move-result v4

    .line 6613
    .local v4, "added":Z
    invoke-static {v2}, Llocal/mio/os4camerabridge/HookEntry;->-$$Nest$sfputlegendRawSessionActive(Z)V

    .line 6614
    invoke-static {}, Llocal/mio/os4camerabridge/HookEntry;->-$$Nest$sfgetLEGEND_RAW_LOCK()Ljava/lang/Object;

    move-result-object v5

    monitor-enter v5
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_1

    .line 6615
    :try_start_1
    invoke-static {}, Llocal/mio/os4camerabridge/HookEntry;->-$$Nest$sfgetLEGEND_RAW_FRAMES()Ljava/util/Map;

    move-result-object v6

    invoke-interface {v6}, Ljava/util/Map;->clear()V

    .line 6616
    monitor-exit v5
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    .line 6617
    :try_start_2
    new-instance v5, Ljava/lang/StringBuilder;

    invoke-direct {v5}, Ljava/lang/StringBuilder;-><init>()V

    const-string v6, "[LegendM9] RAW_SENSOR session output "

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    .line 6618
    if-eqz v4, :cond_2

    const-string v6, "added"

    goto :goto_0

    :cond_2
    const-string v6, "already present"

    :goto_0
    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    const-string v6, " camera="

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5, v3}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v5

    const-string v6, " size=4096x3072 outputs="

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    iget-object v6, p1, Lde/robv/android/xposed/XC_MethodHook$MethodHookParam;->args:[Ljava/lang/Object;

    aget-object v2, v6, v2

    check-cast v2, Ljava/util/List;

    .line 6621
    invoke-interface {v2}, Ljava/util/List;->size()I

    move-result v2

    invoke-virtual {v5, v2}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    .line 6617
    invoke-static {v2}, Llocal/mio/os4camerabridge/HookEntry;->-$$Nest$smlog(Ljava/lang/String;)V
    :try_end_2
    .catchall {:try_start_2 .. :try_end_2} :catchall_1

    .line 6626
    .end local v1    # "cameraId":Ljava/lang/String;
    .end local v3    # "numericCameraId":I
    .end local v4    # "added":Z
    goto :goto_2

    .line 6616
    .restart local v1    # "cameraId":Ljava/lang/String;
    .restart local v3    # "numericCameraId":I
    .restart local v4    # "added":Z
    :catchall_0
    move-exception v2

    :try_start_3
    monitor-exit v5
    :try_end_3
    .catchall {:try_start_3 .. :try_end_3} :catchall_0

    .end local p0    # "this":Llocal/mio/os4camerabridge/HookEntry$25;
    .end local p1    # "param":Lde/robv/android/xposed/XC_MethodHook$MethodHookParam;
    :try_start_4
    throw v2
    :try_end_4
    .catchall {:try_start_4 .. :try_end_4} :catchall_1

    .line 6607
    .end local v4    # "added":Z
    .restart local p0    # "this":Llocal/mio/os4camerabridge/HookEntry$25;
    .restart local p1    # "param":Lde/robv/android/xposed/XC_MethodHook$MethodHookParam;
    :cond_3
    :goto_1
    return-void

    .line 6622
    .end local v1    # "cameraId":Ljava/lang/String;
    .end local v3    # "numericCameraId":I
    :catchall_1
    move-exception v1

    .line 6623
    .local v1, "throwable":Ljava/lang/Throwable;
    invoke-static {v0}, Llocal/mio/os4camerabridge/HookEntry;->-$$Nest$sfputlegendRawSessionActive(Z)V

    .line 6624
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "[LegendM9] RAW_SENSOR session rejected; stock JPEG path: "

    invoke-virtual {v0, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Llocal/mio/os4camerabridge/HookEntry;->-$$Nest$smlog(Ljava/lang/String;)V

    .line 6627
    .end local v1    # "throwable":Ljava/lang/Throwable;
    :goto_2
    return-void

    .line 6598
    :cond_4
    :goto_3
    return-void
.end method
