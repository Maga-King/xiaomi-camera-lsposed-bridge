.class Llocal/mio/os4camerabridge/HookEntry$13;
.super Lde/robv/android/xposed/XC_MethodHook;
.source "HookEntry.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Llocal/mio/os4camerabridge/HookEntry;->hookOplusFrameworkSessionProbe()V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# direct methods
.method constructor <init>()V
    .locals 0

    .line 5550
    invoke-direct {p0}, Lde/robv/android/xposed/XC_MethodHook;-><init>()V

    return-void
.end method


# virtual methods
.method protected beforeHookedMethod(Lde/robv/android/xposed/XC_MethodHook$MethodHookParam;)V
    .locals 10
    .param p1, "param"    # Lde/robv/android/xposed/XC_MethodHook$MethodHookParam;

    .line 5553
    invoke-static {}, Llocal/mio/os4camerabridge/HookEntry;->-$$Nest$sfgetOPLUS_REFERENCE_SESSION_COUNT()Ljava/util/concurrent/atomic/AtomicInteger;

    move-result-object v0

    .line 5554
    invoke-virtual {v0}, Ljava/util/concurrent/atomic/AtomicInteger;->incrementAndGet()I

    move-result v0

    .line 5555
    .local v0, "ordinal":I
    const/16 v1, 0x18

    if-le v0, v1, :cond_0

    .line 5556
    return-void

    .line 5558
    :cond_0
    iget-object v1, p1, Lde/robv/android/xposed/XC_MethodHook$MethodHookParam;->method:Ljava/lang/reflect/Member;

    if-nez v1, :cond_1

    const-string v1, "unknown"

    goto :goto_0

    .line 5559
    :cond_1
    iget-object v1, p1, Lde/robv/android/xposed/XC_MethodHook$MethodHookParam;->method:Ljava/lang/reflect/Member;

    invoke-interface {v1}, Ljava/lang/reflect/Member;->getName()Ljava/lang/String;

    move-result-object v1

    :goto_0
    nop

    .line 5564
    .local v1, "method":Ljava/lang/String;
    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "[OplusSessionSpec] #"

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, v0}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v2

    const-string v4, " method="

    invoke-virtual {v2, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    const-string v4, " argc="

    invoke-virtual {v2, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    .line 5566
    iget-object v4, p1, Lde/robv/android/xposed/XC_MethodHook$MethodHookParam;->args:[Ljava/lang/Object;

    const/4 v5, 0x0

    if-nez v4, :cond_2

    move v4, v5

    goto :goto_1

    :cond_2
    iget-object v4, p1, Lde/robv/android/xposed/XC_MethodHook$MethodHookParam;->args:[Ljava/lang/Object;

    array-length v4, v4

    :goto_1
    invoke-virtual {v2, v4}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    .line 5564
    invoke-static {v2}, Llocal/mio/os4camerabridge/HookEntry;->-$$Nest$smlog(Ljava/lang/String;)V

    .line 5567
    iget-object v2, p1, Lde/robv/android/xposed/XC_MethodHook$MethodHookParam;->args:[Ljava/lang/Object;

    if-nez v2, :cond_3

    .line 5568
    return-void

    .line 5570
    :cond_3
    const/4 v2, 0x0

    .local v2, "index":I
    :goto_2
    iget-object v4, p1, Lde/robv/android/xposed/XC_MethodHook$MethodHookParam;->args:[Ljava/lang/Object;

    array-length v4, v4

    if-ge v2, v4, :cond_9

    .line 5571
    iget-object v4, p1, Lde/robv/android/xposed/XC_MethodHook$MethodHookParam;->args:[Ljava/lang/Object;

    aget-object v4, v4, v2

    .line 5572
    .local v4, "argument":Ljava/lang/Object;
    instance-of v6, v4, Ljava/util/List;

    const-string v7, " arg"

    if-eqz v6, :cond_4

    move-object v6, v4

    check-cast v6, Ljava/util/List;

    .line 5573
    invoke-static {v6}, Llocal/mio/os4camerabridge/HookEntry;->-$$Nest$smcontainsOutputConfiguration(Ljava/util/List;)Z

    move-result v6

    if-eqz v6, :cond_4

    .line 5575
    new-instance v6, Ljava/lang/StringBuilder;

    invoke-direct {v6}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v6, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    invoke-virtual {v6, v0}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v6

    invoke-virtual {v6, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    invoke-virtual {v6, v2}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v6

    invoke-virtual {v6}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v6

    move-object v7, v4

    check-cast v7, Ljava/util/List;

    invoke-static {v6, v7}, Llocal/mio/os4camerabridge/HookEntry;->-$$Nest$smlogConfiguredOutputs(Ljava/lang/String;Ljava/util/List;)V

    .line 5578
    goto/16 :goto_3

    .line 5580
    :cond_4
    if-eqz v4, :cond_6

    invoke-virtual {v4}, Ljava/lang/Object;->getClass()Ljava/lang/Class;

    move-result-object v6

    invoke-virtual {v6}, Ljava/lang/Class;->getName()Ljava/lang/String;

    move-result-object v6

    .line 5581
    const-string v8, "android.hardware.camera2.params.SessionConfiguration"

    invoke-virtual {v6, v8}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v6

    if-eqz v6, :cond_6

    .line 5584
    :try_start_0
    const-string v6, "getOutputConfigurations"

    new-array v8, v5, [Ljava/lang/Object;

    invoke-static {v4, v6, v8}, Lde/robv/android/xposed/XposedHelpers;->callMethod(Ljava/lang/Object;Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v6

    .line 5586
    .local v6, "outputs":Ljava/lang/Object;
    const-string v8, "getSessionType"

    new-array v9, v5, [Ljava/lang/Object;

    invoke-static {v4, v8, v9}, Lde/robv/android/xposed/XposedHelpers;->callMethod(Ljava/lang/Object;Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v8

    .line 5588
    .local v8, "sessionType":Ljava/lang/Object;
    new-instance v9, Ljava/lang/StringBuilder;

    invoke-direct {v9}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v9, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v9

    invoke-virtual {v9, v0}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v9

    invoke-virtual {v9, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v7

    invoke-virtual {v7, v2}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v7

    const-string v9, " sessionType="

    invoke-virtual {v7, v9}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v7

    invoke-virtual {v7, v8}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v7

    invoke-virtual {v7}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v7

    invoke-static {v7}, Llocal/mio/os4camerabridge/HookEntry;->-$$Nest$smlog(Ljava/lang/String;)V

    .line 5591
    instance-of v7, v6, Ljava/util/List;

    if-eqz v7, :cond_5

    .line 5592
    new-instance v7, Ljava/lang/StringBuilder;

    invoke-direct {v7}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v7, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v7

    invoke-virtual {v7, v0}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v7

    const-string v9, " sessionConfig"

    invoke-virtual {v7, v9}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v7

    invoke-virtual {v7}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v7

    move-object v9, v6

    check-cast v9, Ljava/util/List;

    invoke-static {v7, v9}, Llocal/mio/os4camerabridge/HookEntry;->-$$Nest$smlogConfiguredOutputs(Ljava/lang/String;Ljava/util/List;)V
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 5600
    .end local v6    # "outputs":Ljava/lang/Object;
    .end local v8    # "sessionType":Ljava/lang/Object;
    :cond_5
    goto/16 :goto_3

    .line 5597
    :catchall_0
    move-exception v6

    .line 5598
    .local v6, "throwable":Ljava/lang/Throwable;
    new-instance v7, Ljava/lang/StringBuilder;

    invoke-direct {v7}, Ljava/lang/StringBuilder;-><init>()V

    const-string v8, "[OplusSessionSpec] SessionConfiguration inspect failed: "

    invoke-virtual {v7, v8}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v7

    invoke-virtual {v7, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v7

    invoke-virtual {v7}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v7

    invoke-static {v7}, Llocal/mio/os4camerabridge/HookEntry;->-$$Nest$smlog(Ljava/lang/String;)V

    .line 5601
    .end local v6    # "throwable":Ljava/lang/Throwable;
    goto/16 :goto_3

    .line 5603
    :cond_6
    instance-of v6, v4, Ljava/lang/Integer;

    if-nez v6, :cond_7

    instance-of v6, v4, Ljava/lang/Long;

    if-nez v6, :cond_7

    instance-of v6, v4, Ljava/lang/String;

    if-nez v6, :cond_7

    instance-of v6, v4, Landroid/hardware/camera2/CaptureRequest;

    if-nez v6, :cond_7

    if-eqz v4, :cond_8

    .line 5607
    invoke-virtual {v4}, Ljava/lang/Object;->getClass()Ljava/lang/Class;

    move-result-object v6

    .line 5608
    invoke-virtual {v6}, Ljava/lang/Class;->getName()Ljava/lang/String;

    move-result-object v6

    const-string v8, "InputConfiguration"

    invoke-virtual {v6, v8}, Ljava/lang/String;->contains(Ljava/lang/CharSequence;)Z

    move-result v6

    if-eqz v6, :cond_8

    .line 5609
    :cond_7
    new-instance v6, Ljava/lang/StringBuilder;

    invoke-direct {v6}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v6, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    invoke-virtual {v6, v0}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v6

    invoke-virtual {v6, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    invoke-virtual {v6, v2}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v6

    const-string v7, "="

    invoke-virtual {v6, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    invoke-virtual {v6, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v6

    const-string v7, " class="

    invoke-virtual {v6, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    .line 5611
    invoke-virtual {v4}, Ljava/lang/Object;->getClass()Ljava/lang/Class;

    move-result-object v7

    invoke-virtual {v7}, Ljava/lang/Class;->getName()Ljava/lang/String;

    move-result-object v7

    invoke-virtual {v6, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    invoke-virtual {v6}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v6

    .line 5609
    invoke-static {v6}, Llocal/mio/os4camerabridge/HookEntry;->-$$Nest$smlog(Ljava/lang/String;)V

    .line 5612
    instance-of v6, v4, Landroid/hardware/camera2/CaptureRequest;

    if-eqz v6, :cond_8

    invoke-static {}, Llocal/mio/os4camerabridge/HookEntry;->-$$Nest$sfgetOPLUS_REFERENCE_SESSION_PARAMS_DUMPED()Ljava/util/concurrent/atomic/AtomicBoolean;

    move-result-object v6

    .line 5614
    const/4 v7, 0x1

    invoke-virtual {v6, v5, v7}, Ljava/util/concurrent/atomic/AtomicBoolean;->compareAndSet(ZZ)Z

    move-result v6

    if-eqz v6, :cond_8

    .line 5615
    move-object v6, v4

    check-cast v6, Landroid/hardware/camera2/CaptureRequest;

    invoke-static {v6}, Llocal/mio/os4camerabridge/HookEntry;->-$$Nest$smdumpOplusSessionRequestParcel(Landroid/hardware/camera2/CaptureRequest;)V

    .line 5617
    const-string v6, "[OplusSessionParam]"

    move-object v7, v4

    check-cast v7, Landroid/hardware/camera2/CaptureRequest;

    invoke-static {v6, v7}, Llocal/mio/os4camerabridge/HookEntry;->-$$Nest$smlogCaptureRequestKeyMap(Ljava/lang/String;Landroid/hardware/camera2/CaptureRequest;)V

    .line 5570
    .end local v4    # "argument":Ljava/lang/Object;
    :cond_8
    :goto_3
    add-int/lit8 v2, v2, 0x1

    goto/16 :goto_2

    .line 5623
    .end local v2    # "index":I
    :cond_9
    return-void
.end method
