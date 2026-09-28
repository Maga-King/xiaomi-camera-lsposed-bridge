.class Llocal/mio/os4camerabridge/HookEntry$66;
.super Lde/robv/android/xposed/XC_MethodHook;
.source "HookEntry.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Llocal/mio/os4camerabridge/HookEntry;->hookFullYuvProbe(Ljava/lang/ClassLoader;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# direct methods
.method constructor <init>()V
    .locals 0

    .line 10487
    invoke-direct {p0}, Lde/robv/android/xposed/XC_MethodHook;-><init>()V

    return-void
.end method


# virtual methods
.method protected beforeHookedMethod(Lde/robv/android/xposed/XC_MethodHook$MethodHookParam;)V
    .locals 9
    .param p1, "param"    # Lde/robv/android/xposed/XC_MethodHook$MethodHookParam;

    .line 10490
    const/4 v0, 0x0

    invoke-static {v0}, Llocal/mio/os4camerabridge/HookEntry;->-$$Nest$sfputfullYuvSessionActive(Z)V

    .line 10491
    invoke-static {}, Llocal/mio/os4camerabridge/HookEntry;->-$$Nest$smisYuvProbeEnabled()Z

    move-result v1

    if-eqz v1, :cond_6

    iget-object v1, p1, Lde/robv/android/xposed/XC_MethodHook$MethodHookParam;->args:[Ljava/lang/Object;

    if-eqz v1, :cond_6

    iget-object v1, p1, Lde/robv/android/xposed/XC_MethodHook$MethodHookParam;->args:[Ljava/lang/Object;

    array-length v1, v1

    const/4 v2, 0x5

    if-ne v1, v2, :cond_6

    iget-object v1, p1, Lde/robv/android/xposed/XC_MethodHook$MethodHookParam;->args:[Ljava/lang/Object;

    const/4 v2, 0x1

    aget-object v1, v1, v2

    instance-of v1, v1, Ljava/util/List;

    if-nez v1, :cond_0

    goto/16 :goto_2

    .line 10498
    :cond_0
    :try_start_0
    iget-object v1, p1, Lde/robv/android/xposed/XC_MethodHook$MethodHookParam;->thisObject:Ljava/lang/Object;

    const-string v3, "c"

    new-array v4, v0, [Ljava/lang/Object;

    .line 10499
    invoke-static {v1, v3, v4}, Lde/robv/android/xposed/XposedHelpers;->callMethod(Ljava/lang/Object;Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v1

    .line 10498
    invoke-static {v1}, Ljava/lang/String;->valueOf(Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v1

    .line 10500
    .local v1, "cameraId":Ljava/lang/String;
    const-string v3, "0"

    invoke-virtual {v3, v1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v3

    if-nez v3, :cond_1

    .line 10501
    return-void

    .line 10503
    :cond_1
    invoke-static {}, Llocal/mio/os4camerabridge/HookEntry;->-$$Nest$smisExplicitYuvProbeEnabled()Z

    move-result v3

    .line 10504
    .local v3, "explicitProbe":Z
    iget-object v4, p1, Lde/robv/android/xposed/XC_MethodHook$MethodHookParam;->args:[Ljava/lang/Object;

    invoke-static {v4}, Llocal/mio/os4camerabridge/HookEntry;->-$$Nest$smisOrdinaryPhotoSession([Ljava/lang/Object;)Z

    move-result v4

    .line 10505
    .local v4, "ordinaryPhoto":Z
    if-nez v3, :cond_3

    .line 10506
    invoke-static {}, Llocal/mio/os4camerabridge/HookEntry;->-$$Nest$smisProductionFusionEnabled()Z

    move-result v5

    if-eqz v5, :cond_2

    if-nez v4, :cond_3

    .line 10508
    :cond_2
    new-instance v5, Ljava/lang/StringBuilder;

    invoke-direct {v5}, Ljava/lang/StringBuilder;-><init>()V

    const-string v6, "[YuvFusion] session skipped camera=0 signature="

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    iget-object v6, p1, Lde/robv/android/xposed/XC_MethodHook$MethodHookParam;->args:[Ljava/lang/Object;

    aget-object v2, v6, v2

    check-cast v2, Ljava/util/List;

    .line 10509
    invoke-static {v2}, Llocal/mio/os4camerabridge/HookEntry;->-$$Nest$smoutputFormatSignature(Ljava/util/List;)Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v5, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    const-string v5, " mode="

    invoke-virtual {v2, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    iget-object v5, p1, Lde/robv/android/xposed/XC_MethodHook$MethodHookParam;->args:[Ljava/lang/Object;

    aget-object v5, v5, v0

    invoke-virtual {v2, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    .line 10508
    invoke-static {v2}, Llocal/mio/os4camerabridge/HookEntry;->-$$Nest$smlog(Ljava/lang/String;)V

    .line 10511
    return-void

    .line 10513
    :cond_3
    invoke-static {}, Llocal/mio/os4camerabridge/HookEntry;->-$$Nest$smensureFullYuvReader()Z

    move-result v5

    if-nez v5, :cond_4

    .line 10514
    return-void

    .line 10516
    :cond_4
    iget-object v5, p1, Lde/robv/android/xposed/XC_MethodHook$MethodHookParam;->args:[Ljava/lang/Object;

    aget-object v5, v5, v2

    check-cast v5, Ljava/util/List;

    .line 10517
    .local v5, "outputs":Ljava/util/List;, "Ljava/util/List<*>;"
    invoke-static {v5}, Llocal/mio/os4camerabridge/HookEntry;->-$$Nest$smoutputFormatSignature(Ljava/util/List;)Ljava/lang/String;

    move-result-object v6

    .line 10518
    .local v6, "sourceSignature":Ljava/lang/String;
    invoke-static {}, Llocal/mio/os4camerabridge/HookEntry;->-$$Nest$sfgetfullYuvReader()Landroid/media/ImageReader;

    move-result-object v7

    .line 10519
    invoke-virtual {v7}, Landroid/media/ImageReader;->getSurface()Landroid/view/Surface;

    move-result-object v7

    .line 10518
    invoke-static {v5, v7}, Llocal/mio/os4camerabridge/HookEntry;->-$$Nest$smappendOutputSurface(Ljava/util/List;Landroid/view/Surface;)Z

    move-result v7

    .line 10520
    .local v7, "added":Z
    invoke-static {v2}, Llocal/mio/os4camerabridge/HookEntry;->-$$Nest$sfputfullYuvSessionActive(Z)V

    .line 10521
    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v8, "[YuvProbe] session output "

    invoke-virtual {v2, v8}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    .line 10522
    if-eqz v7, :cond_5

    const-string v8, "added"

    goto :goto_0

    :cond_5
    const-string v8, "already present"

    :goto_0
    invoke-virtual {v2, v8}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    const-string v8, " camera=0 size=4096x3072 outputs="

    invoke-virtual {v2, v8}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    .line 10524
    invoke-interface {v5}, Ljava/util/List;->size()I

    move-result v8

    invoke-virtual {v2, v8}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v2

    const-string v8, " sourceSignature="

    invoke-virtual {v2, v8}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    const-string v8, " ordinaryPhoto="

    invoke-virtual {v2, v8}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, v4}, Ljava/lang/StringBuilder;->append(Z)Ljava/lang/StringBuilder;

    move-result-object v2

    const-string v8, " explicit="

    invoke-virtual {v2, v8}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Z)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    .line 10521
    invoke-static {v2}, Llocal/mio/os4camerabridge/HookEntry;->-$$Nest$smlog(Ljava/lang/String;)V
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 10532
    .end local v1    # "cameraId":Ljava/lang/String;
    .end local v3    # "explicitProbe":Z
    .end local v4    # "ordinaryPhoto":Z
    .end local v5    # "outputs":Ljava/util/List;, "Ljava/util/List<*>;"
    .end local v6    # "sourceSignature":Ljava/lang/String;
    .end local v7    # "added":Z
    goto :goto_1

    .line 10529
    :catchall_0
    move-exception v1

    .line 10530
    .local v1, "throwable":Ljava/lang/Throwable;
    invoke-static {v0}, Llocal/mio/os4camerabridge/HookEntry;->-$$Nest$sfputfullYuvSessionActive(Z)V

    .line 10531
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "[YuvProbe] session output unchanged: "

    invoke-virtual {v0, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Llocal/mio/os4camerabridge/HookEntry;->-$$Nest$smlog(Ljava/lang/String;)V

    .line 10533
    .end local v1    # "throwable":Ljava/lang/Throwable;
    :goto_1
    return-void

    .line 10495
    :cond_6
    :goto_2
    return-void
.end method
