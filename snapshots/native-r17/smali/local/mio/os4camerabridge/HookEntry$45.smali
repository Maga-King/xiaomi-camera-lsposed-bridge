.class Llocal/mio/os4camerabridge/HookEntry$45;
.super Lde/robv/android/xposed/XC_MethodHook;
.source "HookEntry.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Llocal/mio/os4camerabridge/HookEntry;->hookLogicalCameraSelection(Ljava/lang/ClassLoader;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic val$roleFacade:Ljava/lang/Class;

.field final synthetic val$zoomData:Ljava/lang/Class;


# direct methods
.method constructor <init>(Ljava/lang/Class;Ljava/lang/Class;)V
    .locals 0

    .line 8637
    iput-object p1, p0, Llocal/mio/os4camerabridge/HookEntry$45;->val$zoomData:Ljava/lang/Class;

    iput-object p2, p0, Llocal/mio/os4camerabridge/HookEntry$45;->val$roleFacade:Ljava/lang/Class;

    invoke-direct {p0}, Lde/robv/android/xposed/XC_MethodHook;-><init>()V

    return-void
.end method


# virtual methods
.method protected afterHookedMethod(Lde/robv/android/xposed/XC_MethodHook$MethodHookParam;)V
    .locals 10
    .param p1, "param"    # Lde/robv/android/xposed/XC_MethodHook$MethodHookParam;

    .line 8640
    invoke-virtual {p1}, Lde/robv/android/xposed/XC_MethodHook$MethodHookParam;->hasThrowable()Z

    move-result v0

    if-nez v0, :cond_e

    .line 8641
    invoke-virtual {p1}, Lde/robv/android/xposed/XC_MethodHook$MethodHookParam;->getResult()Ljava/lang/Object;

    move-result-object v0

    instance-of v0, v0, Ljava/lang/Integer;

    if-eqz v0, :cond_e

    iget-object v0, p1, Lde/robv/android/xposed/XC_MethodHook$MethodHookParam;->args:[Ljava/lang/Object;

    const/4 v1, 0x0

    aget-object v0, v0, v1

    instance-of v0, v0, Ljava/lang/Integer;

    if-eqz v0, :cond_e

    iget-object v0, p1, Lde/robv/android/xposed/XC_MethodHook$MethodHookParam;->args:[Ljava/lang/Object;

    const/4 v2, 0x1

    aget-object v0, v0, v2

    instance-of v0, v0, Ljava/lang/Integer;

    if-nez v0, :cond_0

    goto/16 :goto_3

    .line 8646
    :cond_0
    iget-object v0, p1, Lde/robv/android/xposed/XC_MethodHook$MethodHookParam;->args:[Ljava/lang/Object;

    aget-object v0, v0, v1

    check-cast v0, Ljava/lang/Integer;

    invoke-virtual {v0}, Ljava/lang/Integer;->intValue()I

    move-result v0

    .line 8647
    .local v0, "facing":I
    if-eqz v0, :cond_1

    if-eq v0, v2, :cond_1

    .line 8648
    return-void

    .line 8650
    :cond_1
    iget-object v3, p1, Lde/robv/android/xposed/XC_MethodHook$MethodHookParam;->args:[Ljava/lang/Object;

    aget-object v3, v3, v2

    check-cast v3, Ljava/lang/Integer;

    invoke-virtual {v3}, Ljava/lang/Integer;->intValue()I

    move-result v3

    .line 8651
    .local v3, "moduleIndex":I
    if-nez v0, :cond_2

    const/16 v4, 0xac

    if-ne v3, v4, :cond_2

    const-string v4, "[SlowMotionCompat] retain original physical-role camera; bypass logical catch-all"

    invoke-static {v4}, Llocal/mio/os4camerabridge/HookEntry;->log(Ljava/lang/String;)V

    return-void

    :cond_2
    const-string v4, ":"

    if-nez v0, :cond_a

    const/16 v5, 0xa2

    const/16 v6, 0x100

    if-eq v3, v5, :cond_3

    const/16 v5, 0xa7

    if-eq v3, v5, :cond_3

    if-ne v3, v6, :cond_a

    .line 8662
    :cond_3
    invoke-virtual {p1}, Lde/robv/android/xposed/XC_MethodHook$MethodHookParam;->getResult()Ljava/lang/Object;

    move-result-object v5

    check-cast v5, Ljava/lang/Integer;

    invoke-virtual {v5}, Ljava/lang/Integer;->intValue()I

    move-result v5

    .line 8663
    .local v5, "selected":I
    const/high16 v7, 0x7fc00000    # Float.NaN

    .line 8664
    .local v7, "legendZoom":F
    if-ne v3, v6, :cond_7

    .line 8674
    iget-object v8, p0, Llocal/mio/os4camerabridge/HookEntry$45;->val$zoomData:Ljava/lang/Class;

    new-array v2, v2, [Ljava/lang/Class;

    sget-object v9, Ljava/lang/Integer;->TYPE:Ljava/lang/Class;

    aput-object v9, v2, v1

    .line 8677
    invoke-static {v3}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v1

    filled-new-array {v1}, [Ljava/lang/Object;

    move-result-object v1

    .line 8674
    const-string v9, "N"

    invoke-static {v8, v9, v2, v1}, Lde/robv/android/xposed/XposedHelpers;->callStaticMethod(Ljava/lang/Class;Ljava/lang/String;[Ljava/lang/Class;[Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v1

    .line 8678
    .local v1, "zoom":Ljava/lang/Object;
    instance-of v2, v1, Ljava/lang/Float;

    if-eqz v2, :cond_4

    .line 8679
    move-object v2, v1

    check-cast v2, Ljava/lang/Float;

    invoke-virtual {v2}, Ljava/lang/Float;->floatValue()F

    move-result v7

    .line 8681
    :cond_4
    const/high16 v2, 0x3f800000    # 1.0f

    cmpg-float v2, v7, v2

    if-gez v2, :cond_5

    .line 8682
    invoke-static {}, Llocal/mio/os4camerabridge/HookEntry;->-$$Nest$sfgetrearUltraWidePhysicalCameraId()I

    move-result v2

    goto :goto_0

    .line 8683
    :cond_5
    const/high16 v2, 0x40400000    # 3.0f

    cmpl-float v2, v7, v2

    if-ltz v2, :cond_6

    .line 8684
    invoke-static {}, Llocal/mio/os4camerabridge/HookEntry;->-$$Nest$sfgetrearTelePhysicalCameraId()I

    move-result v2

    goto :goto_0

    .line 8685
    :cond_6
    invoke-static {}, Llocal/mio/os4camerabridge/HookEntry;->-$$Nest$sfgetrearMainPhysicalCameraId()I

    move-result v2

    :goto_0
    nop

    .line 8686
    .local v2, "desired":I
    if-eq v5, v2, :cond_7

    .line 8687
    move v5, v2

    .line 8688
    invoke-static {v5}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v8

    invoke-virtual {p1, v8}, Lde/robv/android/xposed/XC_MethodHook$MethodHookParam;->setResult(Ljava/lang/Object;)V

    .line 8691
    .end local v1    # "zoom":Ljava/lang/Object;
    .end local v2    # "desired":I
    :cond_7
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "physical-role:"

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, v3}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, v5}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    const/high16 v2, 0x42c80000    # 100.0f

    mul-float/2addr v2, v7

    .line 8693
    invoke-static {v2}, Ljava/lang/Math;->round(F)I

    move-result v2

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    .line 8694
    .local v1, "signature":Ljava/lang/String;
    invoke-static {}, Llocal/mio/os4camerabridge/HookEntry;->-$$Nest$sfgetLOGICAL_CAMERA_CONTRACT_LOGGED()Ljava/util/Set;

    move-result-object v2

    invoke-interface {v2, v1}, Ljava/util/Set;->add(Ljava/lang/Object;)Z

    move-result v2

    if-eqz v2, :cond_9

    .line 8695
    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v4, "[PhysicalZoomRoute] module="

    invoke-virtual {v2, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v2

    const-string v4, " retained role-selected camera="

    invoke-virtual {v2, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, v5}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v2

    .line 8698
    if-ne v3, v6, :cond_8

    .line 8699
    new-instance v4, Ljava/lang/StringBuilder;

    invoke-direct {v4}, Ljava/lang/StringBuilder;-><init>()V

    const-string v6, " zoom="

    invoke-virtual {v4, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4, v7}, Ljava/lang/StringBuilder;->append(F)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v4

    goto :goto_1

    :cond_8
    const-string v4, ""

    :goto_1
    invoke-virtual {v2, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    .line 8695
    invoke-static {v2}, Llocal/mio/os4camerabridge/HookEntry;->-$$Nest$smlog(Ljava/lang/String;)V

    .line 8701
    :cond_9
    return-void

    .line 8704
    .end local v1    # "signature":Ljava/lang/String;
    .end local v5    # "selected":I
    .end local v7    # "legendZoom":F
    :cond_a
    :try_start_0
    iget-object v2, p0, Llocal/mio/os4camerabridge/HookEntry$45;->val$roleFacade:Ljava/lang/Class;

    const-string v5, "T"

    new-array v6, v1, [Ljava/lang/Object;

    invoke-static {v2, v5, v6}, Lde/robv/android/xposed/XposedHelpers;->callStaticMethod(Ljava/lang/Class;Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v2

    .line 8706
    .local v2, "roles":Ljava/lang/Object;
    const-string v5, "isInitialized"

    new-array v1, v1, [Ljava/lang/Object;

    invoke-static {v2, v5, v1}, Lde/robv/android/xposed/XposedHelpers;->callMethod(Ljava/lang/Object;Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v1

    .line 8708
    .local v1, "initialized":Ljava/lang/Object;
    instance-of v5, v1, Ljava/lang/Boolean;

    if-eqz v5, :cond_d

    move-object v5, v1

    check-cast v5, Ljava/lang/Boolean;

    .line 8709
    invoke-virtual {v5}, Ljava/lang/Boolean;->booleanValue()Z

    move-result v5
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    if-nez v5, :cond_b

    goto :goto_2

    .line 8716
    .end local v1    # "initialized":Ljava/lang/Object;
    .end local v2    # "roles":Ljava/lang/Object;
    :cond_b
    nop

    .line 8717
    invoke-virtual {p1}, Lde/robv/android/xposed/XC_MethodHook$MethodHookParam;->getResult()Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Ljava/lang/Integer;

    invoke-virtual {v1}, Ljava/lang/Integer;->intValue()I

    move-result v1

    .line 8718
    .local v1, "selected":I
    if-eq v1, v0, :cond_c

    .line 8719
    invoke-static {v0}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v2

    invoke-virtual {p1, v2}, Lde/robv/android/xposed/XC_MethodHook$MethodHookParam;->setResult(Ljava/lang/Object;)V

    .line 8720
    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v2, v0}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, v1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    .line 8722
    .local v2, "signature":Ljava/lang/String;
    invoke-static {}, Llocal/mio/os4camerabridge/HookEntry;->-$$Nest$sfgetLOGICAL_CAMERA_CONTRACT_LOGGED()Ljava/util/Set;

    move-result-object v4

    invoke-interface {v4, v2}, Ljava/util/Set;->add(Ljava/lang/Object;)Z

    move-result v4

    if-eqz v4, :cond_c

    .line 8723
    new-instance v4, Ljava/lang/StringBuilder;

    invoke-direct {v4}, Ljava/lang/StringBuilder;-><init>()V

    const-string v5, "[LogicalCameraContract] mode=0x"

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    .line 8724
    invoke-static {v3}, Ljava/lang/Integer;->toHexString(I)Ljava/lang/String;

    move-result-object v5

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    const-string v5, " facing="

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4, v0}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v4

    const-string v5, " physical="

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4, v1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v4

    const-string v5, " -> logical="

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4, v0}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v4

    .line 8723
    invoke-static {v4}, Llocal/mio/os4camerabridge/HookEntry;->-$$Nest$smlog(Ljava/lang/String;)V

    .line 8731
    .end local v2    # "signature":Ljava/lang/String;
    :cond_c
    return-void

    .line 8710
    .local v1, "initialized":Ljava/lang/Object;
    .local v2, "roles":Ljava/lang/Object;
    :cond_d
    :goto_2
    return-void

    .line 8712
    .end local v1    # "initialized":Ljava/lang/Object;
    .end local v2    # "roles":Ljava/lang/Object;
    :catchall_0
    move-exception v1

    .line 8715
    .local v1, "ignored":Ljava/lang/Throwable;
    return-void

    .line 8644
    .end local v0    # "facing":I
    .end local v1    # "ignored":Ljava/lang/Throwable;
    .end local v3    # "moduleIndex":I
    :cond_e
    :goto_3
    return-void
.end method
