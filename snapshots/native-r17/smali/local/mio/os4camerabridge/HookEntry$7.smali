.class Llocal/mio/os4camerabridge/HookEntry$7;
.super Lde/robv/android/xposed/XC_MethodHook;
.source "HookEntry.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Llocal/mio/os4camerabridge/HookEntry;->hookFullOplusSessionHandoffProbe(Ljava/lang/ClassLoader;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic val$automaticProof:Z

.field final synthetic val$captureProof:Z


# direct methods
.method constructor <init>(ZZ)V
    .locals 0

    .line 1537
    iput-boolean p1, p0, Llocal/mio/os4camerabridge/HookEntry$7;->val$automaticProof:Z

    iput-boolean p2, p0, Llocal/mio/os4camerabridge/HookEntry$7;->val$captureProof:Z

    invoke-direct {p0}, Lde/robv/android/xposed/XC_MethodHook;-><init>()V

    return-void
.end method

.method static synthetic lambda$afterHookedMethod$0()V
    .locals 3

    .line 1599
    invoke-static {}, Llocal/mio/os4camerabridge/HookEntry;->-$$Nest$smprepareCommonApsClient()Z

    move-result v0

    .line 1600
    .local v0, "ready":Z
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "[ApsShutter] prewarm ready="

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, v0}, Ljava/lang/StringBuilder;->append(Z)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, " owner="

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-static {}, Llocal/mio/os4camerabridge/HookEntry;->-$$Nest$sfgetcommonApsHandoffOwner()Ljava/lang/Object;

    move-result-object v2

    if-eqz v2, :cond_0

    const/4 v2, 0x1

    goto :goto_0

    :cond_0
    const/4 v2, 0x0

    :goto_0
    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Z)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, " previewArgs="

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    .line 1604
    invoke-static {}, Llocal/mio/os4camerabridge/HookEntry;->-$$Nest$sfgetcommonApsHandoffPreviewArgs()[Ljava/lang/Object;

    move-result-object v2

    if-nez v2, :cond_1

    .line 1605
    const/4 v2, -0x1

    goto :goto_1

    .line 1606
    :cond_1
    invoke-static {}, Llocal/mio/os4camerabridge/HookEntry;->-$$Nest$sfgetcommonApsHandoffPreviewArgs()[Ljava/lang/Object;

    move-result-object v2

    array-length v2, v2

    :goto_1
    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    .line 1600
    invoke-static {v1}, Llocal/mio/os4camerabridge/HookEntry;->-$$Nest$smlog(Ljava/lang/String;)V

    .line 1607
    invoke-static {}, Llocal/mio/os4camerabridge/HookEntry;->-$$Nest$sfgetCOMMON_APS_SHUTTER_LOCK()Ljava/lang/Object;

    move-result-object v1

    monitor-enter v1

    .line 1608
    :try_start_0
    invoke-static {}, Llocal/mio/os4camerabridge/HookEntry;->-$$Nest$sfgetCOMMON_APS_SHUTTER_LOCK()Ljava/lang/Object;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/Object;->notifyAll()V

    .line 1609
    monitor-exit v1

    .line 1610
    return-void

    .line 1609
    :catchall_0
    move-exception v2

    monitor-exit v1
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    throw v2
.end method

.method static synthetic lambda$afterHookedMethod$1(Lde/robv/android/xposed/XC_MethodHook$MethodHookParam;[Ljava/lang/Object;Landroid/os/Handler;)V
    .locals 3
    .param p0, "param"    # Lde/robv/android/xposed/XC_MethodHook$MethodHookParam;
    .param p1, "previewArgs"    # [Ljava/lang/Object;
    .param p2, "handler"    # Landroid/os/Handler;

    .line 1644
    iget-object v0, p0, Lde/robv/android/xposed/XC_MethodHook$MethodHookParam;->thisObject:Ljava/lang/Object;

    const/4 v1, 0x1

    const/4 v2, 0x0

    invoke-static {v0, p1, p2, v1, v2}, Llocal/mio/os4camerabridge/HookEntry;->-$$Nest$smstartFullOplusSessionHandoffProbe(Ljava/lang/Object;[Ljava/lang/Object;Landroid/os/Handler;ZLandroid/hardware/camera2/CaptureRequest;)V

    return-void
.end method

.method static synthetic lambda$afterHookedMethod$2(Landroid/os/Handler;Lde/robv/android/xposed/XC_MethodHook$MethodHookParam;[Ljava/lang/Object;)V
    .locals 4
    .param p0, "handler"    # Landroid/os/Handler;
    .param p1, "param"    # Lde/robv/android/xposed/XC_MethodHook$MethodHookParam;
    .param p2, "previewArgs"    # [Ljava/lang/Object;

    .line 1636
    invoke-static {}, Llocal/mio/os4camerabridge/HookEntry;->-$$Nest$smprepareCommonApsClient()Z

    move-result v0

    .line 1637
    .local v0, "ready":Z
    if-nez v0, :cond_0

    .line 1638
    const-string v1, "[HandoffProbe] APS capture proof stopped before session switch: client init failed"

    invoke-static {v1}, Llocal/mio/os4camerabridge/HookEntry;->-$$Nest$smlog(Ljava/lang/String;)V

    .line 1641
    return-void

    .line 1643
    :cond_0
    new-instance v1, Llocal/mio/os4camerabridge/HookEntry$7$$ExternalSyntheticLambda3;

    invoke-direct {v1, p1, p2, p0}, Llocal/mio/os4camerabridge/HookEntry$7$$ExternalSyntheticLambda3;-><init>(Lde/robv/android/xposed/XC_MethodHook$MethodHookParam;[Ljava/lang/Object;Landroid/os/Handler;)V

    const-wide/16 v2, 0x15e

    invoke-virtual {p0, v1, v2, v3}, Landroid/os/Handler;->postDelayed(Ljava/lang/Runnable;J)Z

    .line 1647
    return-void
.end method

.method static synthetic lambda$afterHookedMethod$3(Lde/robv/android/xposed/XC_MethodHook$MethodHookParam;[Ljava/lang/Object;Landroid/os/Handler;)V
    .locals 3
    .param p0, "param"    # Lde/robv/android/xposed/XC_MethodHook$MethodHookParam;
    .param p1, "previewArgs"    # [Ljava/lang/Object;
    .param p2, "handler"    # Landroid/os/Handler;

    .line 1652
    iget-object v0, p0, Lde/robv/android/xposed/XC_MethodHook$MethodHookParam;->thisObject:Ljava/lang/Object;

    const/4 v1, 0x0

    const/4 v2, 0x0

    invoke-static {v0, p1, p2, v1, v2}, Llocal/mio/os4camerabridge/HookEntry;->-$$Nest$smstartFullOplusSessionHandoffProbe(Ljava/lang/Object;[Ljava/lang/Object;Landroid/os/Handler;ZLandroid/hardware/camera2/CaptureRequest;)V

    return-void
.end method


# virtual methods
.method protected afterHookedMethod(Lde/robv/android/xposed/XC_MethodHook$MethodHookParam;)V
    .locals 9
    .param p1, "param"    # Lde/robv/android/xposed/XC_MethodHook$MethodHookParam;

    .line 1540
    invoke-static {}, Llocal/mio/os4camerabridge/HookEntry;->-$$Nest$sfgetCOMMON_APS_HANDOFF_T2_OBSERVED()Ljava/util/concurrent/atomic/AtomicBoolean;

    move-result-object v0

    .line 1541
    const/4 v1, 0x0

    const/4 v2, 0x1

    invoke-virtual {v0, v1, v2}, Ljava/util/concurrent/atomic/AtomicBoolean;->compareAndSet(ZZ)Z

    move-result v0

    const/4 v3, 0x5

    if-eqz v0, :cond_2

    .line 1542
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v4, "[HandoffProbe] T2 observed argc="

    invoke-virtual {v0, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    .line 1543
    iget-object v4, p1, Lde/robv/android/xposed/XC_MethodHook$MethodHookParam;->args:[Ljava/lang/Object;

    if-nez v4, :cond_0

    const/4 v4, -0x1

    goto :goto_0

    .line 1544
    :cond_0
    iget-object v4, p1, Lde/robv/android/xposed/XC_MethodHook$MethodHookParam;->args:[Ljava/lang/Object;

    array-length v4, v4

    :goto_0
    invoke-virtual {v0, v4}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v4, " activeModule="

    invoke-virtual {v0, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-static {}, Llocal/mio/os4camerabridge/HookEntry;->-$$Nest$sfgetactiveCameraModule()I

    move-result v4

    invoke-virtual {v0, v4}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v4, " opMode="

    invoke-virtual {v0, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    .line 1548
    iget-object v4, p1, Lde/robv/android/xposed/XC_MethodHook$MethodHookParam;->args:[Ljava/lang/Object;

    if-eqz v4, :cond_1

    iget-object v4, p1, Lde/robv/android/xposed/XC_MethodHook$MethodHookParam;->args:[Ljava/lang/Object;

    array-length v4, v4

    if-le v4, v3, :cond_1

    .line 1549
    iget-object v4, p1, Lde/robv/android/xposed/XC_MethodHook$MethodHookParam;->args:[Ljava/lang/Object;

    aget-object v4, v4, v3

    goto :goto_1

    :cond_1
    const-string v4, "?"

    :goto_1
    invoke-virtual {v0, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    .line 1542
    invoke-static {v0}, Llocal/mio/os4camerabridge/HookEntry;->-$$Nest$smlog(Ljava/lang/String;)V

    .line 1551
    :cond_2
    invoke-virtual {p1}, Lde/robv/android/xposed/XC_MethodHook$MethodHookParam;->getThrowable()Ljava/lang/Throwable;

    move-result-object v0

    if-nez v0, :cond_f

    iget-object v0, p1, Lde/robv/android/xposed/XC_MethodHook$MethodHookParam;->args:[Ljava/lang/Object;

    if-eqz v0, :cond_f

    iget-object v0, p1, Lde/robv/android/xposed/XC_MethodHook$MethodHookParam;->args:[Ljava/lang/Object;

    array-length v0, v0

    const/16 v4, 0x9

    if-ne v0, v4, :cond_f

    invoke-static {}, Llocal/mio/os4camerabridge/HookEntry;->-$$Nest$sfgetactiveCameraModule()I

    move-result v0

    const/16 v4, 0xa3

    if-ne v0, v4, :cond_f

    iget-object v0, p1, Lde/robv/android/xposed/XC_MethodHook$MethodHookParam;->args:[Ljava/lang/Object;

    aget-object v0, v0, v3

    instance-of v0, v0, Ljava/lang/Integer;

    if-eqz v0, :cond_f

    iget-object v0, p1, Lde/robv/android/xposed/XC_MethodHook$MethodHookParam;->args:[Ljava/lang/Object;

    aget-object v0, v0, v3

    check-cast v0, Ljava/lang/Integer;

    .line 1556
    invoke-virtual {v0}, Ljava/lang/Integer;->intValue()I

    move-result v0

    if-eqz v0, :cond_3

    iget-object v0, p1, Lde/robv/android/xposed/XC_MethodHook$MethodHookParam;->args:[Ljava/lang/Object;

    aget-object v0, v0, v3

    check-cast v0, Ljava/lang/Integer;

    .line 1557
    invoke-virtual {v0}, Ljava/lang/Integer;->intValue()I

    move-result v0

    const v3, 0x9002

    if-eq v0, v3, :cond_3

    goto/16 :goto_6

    .line 1561
    :cond_3
    :try_start_0
    iget-object v0, p1, Lde/robv/android/xposed/XC_MethodHook$MethodHookParam;->thisObject:Ljava/lang/Object;

    const-string v3, "v"

    invoke-static {v0, v3}, Lde/robv/android/xposed/XposedHelpers;->getObjectField(Ljava/lang/Object;Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v0

    .line 1563
    .local v0, "wrapper":Ljava/lang/Object;
    const-string v3, "c"

    new-array v4, v1, [Ljava/lang/Object;

    .line 1564
    invoke-static {v0, v3, v4}, Lde/robv/android/xposed/XposedHelpers;->callMethod(Ljava/lang/Object;Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v3

    .line 1563
    invoke-static {v3}, Ljava/lang/String;->valueOf(Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v3

    .line 1565
    .local v3, "cameraId":Ljava/lang/String;
    const-string v4, "0"

    invoke-virtual {v4, v3}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v4

    if-nez v4, :cond_4

    .line 1566
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "[HandoffProbe] refused non-rear camera="

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-static {v1}, Llocal/mio/os4camerabridge/HookEntry;->-$$Nest$smlog(Ljava/lang/String;)V

    .line 1568
    return-void

    .line 1570
    :cond_4
    iget-object v4, p1, Lde/robv/android/xposed/XC_MethodHook$MethodHookParam;->thisObject:Ljava/lang/Object;

    const-string v5, "s"

    .line 1571
    invoke-static {v4, v5}, Lde/robv/android/xposed/XposedHelpers;->getObjectField(Ljava/lang/Object;Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v4

    check-cast v4, Landroid/os/Handler;

    .line 1573
    .local v4, "handler":Landroid/os/Handler;
    iget-object v5, p1, Lde/robv/android/xposed/XC_MethodHook$MethodHookParam;->args:[Ljava/lang/Object;

    invoke-virtual {v5}, [Ljava/lang/Object;->clone()Ljava/lang/Object;

    move-result-object v5

    check-cast v5, [Ljava/lang/Object;

    .line 1574
    .local v5, "previewArgs":[Ljava/lang/Object;
    iget-object v6, p1, Lde/robv/android/xposed/XC_MethodHook$MethodHookParam;->thisObject:Ljava/lang/Object;

    invoke-static {v6}, Llocal/mio/os4camerabridge/HookEntry;->-$$Nest$sfputcommonApsHandoffOwner(Ljava/lang/Object;)V

    .line 1575
    invoke-static {v5}, Llocal/mio/os4camerabridge/HookEntry;->-$$Nest$sfputcommonApsHandoffPreviewArgs([Ljava/lang/Object;)V

    .line 1579
    new-instance v6, Ljava/io/File;

    const-string v7, "/sdcard/Download/os4_enable_common_aps_shutter"

    invoke-direct {v6, v7}, Ljava/io/File;-><init>(Ljava/lang/String;)V

    .line 1581
    invoke-virtual {v6}, Ljava/io/File;->isFile()Z

    move-result v6

    if-eqz v6, :cond_8

    invoke-static {}, Llocal/mio/os4camerabridge/HookEntry;->-$$Nest$sfgetCOMMON_APS_SHUTTER_PREP_SCHEDULED()Ljava/util/concurrent/atomic/AtomicBoolean;

    move-result-object v6

    .line 1583
    invoke-virtual {v6, v1, v2}, Ljava/util/concurrent/atomic/AtomicBoolean;->compareAndSet(ZZ)Z

    move-result v6

    if-eqz v6, :cond_8

    .line 1585
    invoke-static {}, Llocal/mio/os4camerabridge/HookEntry;->-$$Nest$smresolveCurrentCameraApplication()Landroid/app/Application;

    move-result-object v6

    .line 1586
    .local v6, "application":Landroid/app/Application;
    if-eqz v6, :cond_5

    .line 1587
    invoke-static {v6}, Llocal/mio/os4camerabridge/HookEntry;->-$$Nest$sfputxiaomiCameraApplication(Landroid/app/Application;)V

    .line 1589
    :cond_5
    invoke-static {}, Llocal/mio/os4camerabridge/HookEntry;->-$$Nest$smensureCommonApsInfrastructure()Z

    move-result v7

    if-eqz v7, :cond_7

    .line 1593
    invoke-static {}, Llocal/mio/os4camerabridge/HookEntry;->-$$Nest$sfgetcommonApsHandler()Landroid/os/Handler;

    move-result-object v7

    .line 1594
    .local v7, "apsHandler":Landroid/os/Handler;
    if-eqz v7, :cond_6

    .line 1598
    new-instance v8, Llocal/mio/os4camerabridge/HookEntry$7$$ExternalSyntheticLambda0;

    invoke-direct {v8}, Llocal/mio/os4camerabridge/HookEntry$7$$ExternalSyntheticLambda0;-><init>()V

    invoke-virtual {v7, v8}, Landroid/os/Handler;->post(Ljava/lang/Runnable;)Z

    .line 1611
    const-string v8, "[ApsShutter] APS prewarm scheduled while Xiaomi preview remains live daily=false"

    invoke-static {v8}, Llocal/mio/os4camerabridge/HookEntry;->-$$Nest$smlog(Ljava/lang/String;)V

    goto :goto_2

    .line 1595
    :cond_6
    new-instance v1, Ljava/lang/IllegalStateException;

    const-string v2, "APS shutter worker unavailable"

    invoke-direct {v1, v2}, Ljava/lang/IllegalStateException;-><init>(Ljava/lang/String;)V

    .end local p0    # "this":Llocal/mio/os4camerabridge/HookEntry$7;
    .end local p1    # "param":Lde/robv/android/xposed/XC_MethodHook$MethodHookParam;
    throw v1

    .line 1590
    .end local v7    # "apsHandler":Landroid/os/Handler;
    .restart local p0    # "this":Llocal/mio/os4camerabridge/HookEntry$7;
    .restart local p1    # "param":Lde/robv/android/xposed/XC_MethodHook$MethodHookParam;
    :cond_7
    new-instance v1, Ljava/lang/IllegalStateException;

    const-string v2, "APS shutter reader infrastructure unavailable"

    invoke-direct {v1, v2}, Ljava/lang/IllegalStateException;-><init>(Ljava/lang/String;)V

    .end local p0    # "this":Llocal/mio/os4camerabridge/HookEntry$7;
    .end local p1    # "param":Lde/robv/android/xposed/XC_MethodHook$MethodHookParam;
    throw v1

    .line 1615
    .end local v6    # "application":Landroid/app/Application;
    .restart local p0    # "this":Llocal/mio/os4camerabridge/HookEntry$7;
    .restart local p1    # "param":Lde/robv/android/xposed/XC_MethodHook$MethodHookParam;
    :cond_8
    :goto_2
    iget-boolean v6, p0, Llocal/mio/os4camerabridge/HookEntry$7;->val$automaticProof:Z

    if-eqz v6, :cond_e

    invoke-static {}, Llocal/mio/os4camerabridge/HookEntry;->-$$Nest$sfgetCOMMON_APS_HANDOFF_SCHEDULED()Ljava/util/concurrent/atomic/AtomicBoolean;

    move-result-object v6

    .line 1617
    invoke-virtual {v6, v1, v2}, Ljava/util/concurrent/atomic/AtomicBoolean;->compareAndSet(ZZ)Z

    move-result v1

    if-nez v1, :cond_9

    goto :goto_4

    .line 1620
    :cond_9
    iget-boolean v1, p0, Llocal/mio/os4camerabridge/HookEntry$7;->val$captureProof:Z

    if-eqz v1, :cond_d

    .line 1622
    invoke-static {}, Llocal/mio/os4camerabridge/HookEntry;->-$$Nest$smresolveCurrentCameraApplication()Landroid/app/Application;

    move-result-object v1

    .line 1623
    .local v1, "application":Landroid/app/Application;
    if-eqz v1, :cond_a

    .line 1624
    invoke-static {v1}, Llocal/mio/os4camerabridge/HookEntry;->-$$Nest$sfputxiaomiCameraApplication(Landroid/app/Application;)V

    .line 1626
    :cond_a
    invoke-static {}, Llocal/mio/os4camerabridge/HookEntry;->-$$Nest$smensureCommonApsInfrastructure()Z

    move-result v2

    if-eqz v2, :cond_c

    .line 1630
    invoke-static {}, Llocal/mio/os4camerabridge/HookEntry;->-$$Nest$sfgetcommonApsHandler()Landroid/os/Handler;

    move-result-object v2

    .line 1631
    .local v2, "apsHandler":Landroid/os/Handler;
    if-eqz v2, :cond_b

    .line 1635
    new-instance v6, Llocal/mio/os4camerabridge/HookEntry$7$$ExternalSyntheticLambda1;

    invoke-direct {v6, v4, p1, v5}, Llocal/mio/os4camerabridge/HookEntry$7$$ExternalSyntheticLambda1;-><init>(Landroid/os/Handler;Lde/robv/android/xposed/XC_MethodHook$MethodHookParam;[Ljava/lang/Object;)V

    invoke-virtual {v2, v6}, Landroid/os/Handler;->post(Ljava/lang/Runnable;)Z

    .line 1648
    const-string v6, "[HandoffProbe] APS init scheduled before one-shot capture handoff"

    invoke-static {v6}, Llocal/mio/os4camerabridge/HookEntry;->-$$Nest$smlog(Ljava/lang/String;)V

    .line 1650
    .end local v1    # "application":Landroid/app/Application;
    .end local v2    # "apsHandler":Landroid/os/Handler;
    goto :goto_3

    .line 1632
    .restart local v1    # "application":Landroid/app/Application;
    .restart local v2    # "apsHandler":Landroid/os/Handler;
    :cond_b
    new-instance v6, Ljava/lang/IllegalStateException;

    const-string v7, "APS worker unavailable"

    invoke-direct {v6, v7}, Ljava/lang/IllegalStateException;-><init>(Ljava/lang/String;)V

    .end local p0    # "this":Llocal/mio/os4camerabridge/HookEntry$7;
    .end local p1    # "param":Lde/robv/android/xposed/XC_MethodHook$MethodHookParam;
    throw v6

    .line 1627
    .end local v2    # "apsHandler":Landroid/os/Handler;
    .restart local p0    # "this":Llocal/mio/os4camerabridge/HookEntry$7;
    .restart local p1    # "param":Lde/robv/android/xposed/XC_MethodHook$MethodHookParam;
    :cond_c
    new-instance v2, Ljava/lang/IllegalStateException;

    const-string v6, "APS reader infrastructure unavailable"

    invoke-direct {v2, v6}, Ljava/lang/IllegalStateException;-><init>(Ljava/lang/String;)V

    .end local p0    # "this":Llocal/mio/os4camerabridge/HookEntry$7;
    .end local p1    # "param":Lde/robv/android/xposed/XC_MethodHook$MethodHookParam;
    throw v2

    .line 1651
    .end local v1    # "application":Landroid/app/Application;
    .restart local p0    # "this":Llocal/mio/os4camerabridge/HookEntry$7;
    .restart local p1    # "param":Lde/robv/android/xposed/XC_MethodHook$MethodHookParam;
    :cond_d
    new-instance v1, Llocal/mio/os4camerabridge/HookEntry$7$$ExternalSyntheticLambda2;

    invoke-direct {v1, p1, v5, v4}, Llocal/mio/os4camerabridge/HookEntry$7$$ExternalSyntheticLambda2;-><init>(Lde/robv/android/xposed/XC_MethodHook$MethodHookParam;[Ljava/lang/Object;Landroid/os/Handler;)V

    const-wide/16 v6, 0x708

    invoke-virtual {v4, v1, v6, v7}, Landroid/os/Handler;->postDelayed(Ljava/lang/Runnable;J)Z

    .line 1655
    const-string v1, "[HandoffProbe] third-party 0x8001/7-output configure proof scheduled after stable Xiaomi preview"

    invoke-static {v1}, Llocal/mio/os4camerabridge/HookEntry;->-$$Nest$smlog(Ljava/lang/String;)V
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 1663
    .end local v0    # "wrapper":Ljava/lang/Object;
    .end local v3    # "cameraId":Ljava/lang/String;
    .end local v4    # "handler":Landroid/os/Handler;
    .end local v5    # "previewArgs":[Ljava/lang/Object;
    :goto_3
    goto :goto_5

    .line 1618
    .restart local v0    # "wrapper":Ljava/lang/Object;
    .restart local v3    # "cameraId":Ljava/lang/String;
    .restart local v4    # "handler":Landroid/os/Handler;
    .restart local v5    # "previewArgs":[Ljava/lang/Object;
    :cond_e
    :goto_4
    return-void

    .line 1659
    .end local v0    # "wrapper":Ljava/lang/Object;
    .end local v3    # "cameraId":Ljava/lang/String;
    .end local v4    # "handler":Landroid/os/Handler;
    .end local v5    # "previewArgs":[Ljava/lang/Object;
    :catchall_0
    move-exception v0

    .line 1660
    .local v0, "throwable":Ljava/lang/Throwable;
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "[HandoffProbe] scheduling failed without touching Xiaomi session: "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-static {v1}, Llocal/mio/os4camerabridge/HookEntry;->-$$Nest$smlog(Ljava/lang/String;)V

    .line 1662
    invoke-static {v0}, Lde/robv/android/xposed/XposedBridge;->log(Ljava/lang/Throwable;)V

    .line 1664
    .end local v0    # "throwable":Ljava/lang/Throwable;
    :goto_5
    return-void

    .line 1558
    :cond_f
    :goto_6
    return-void
.end method
