.class Llocal/mio/os4camerabridge/RearSessionParameterBridge$2;
.super Lde/robv/android/xposed/XC_MethodHook;
.source "RearSessionParameterBridge.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Llocal/mio/os4camerabridge/RearSessionParameterBridge;->install(Ljava/lang/ClassLoader;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic val$active:Ljava/lang/reflect/Field;

.field final synthetic val$camera:Ljava/lang/reflect/Field;

.field final synthetic val$generation:Ljava/lang/reflect/Field;

.field final synthetic val$lock:Ljava/lang/Object;

.field final synthetic val$module:Ljava/lang/reflect/Field;

.field final synthetic val$parameters:Ljava/lang/reflect/Field;

.field final synthetic val$portrait:Ljava/lang/reflect/Field;


# direct methods
.method constructor <init>(Ljava/lang/Object;Ljava/lang/reflect/Field;Ljava/lang/reflect/Field;Ljava/lang/reflect/Field;Ljava/lang/reflect/Field;Ljava/lang/reflect/Field;Ljava/lang/reflect/Field;)V
    .locals 0

    .line 50
    iput-object p1, p0, Llocal/mio/os4camerabridge/RearSessionParameterBridge$2;->val$lock:Ljava/lang/Object;

    iput-object p2, p0, Llocal/mio/os4camerabridge/RearSessionParameterBridge$2;->val$active:Ljava/lang/reflect/Field;

    iput-object p3, p0, Llocal/mio/os4camerabridge/RearSessionParameterBridge$2;->val$module:Ljava/lang/reflect/Field;

    iput-object p4, p0, Llocal/mio/os4camerabridge/RearSessionParameterBridge$2;->val$camera:Ljava/lang/reflect/Field;

    iput-object p5, p0, Llocal/mio/os4camerabridge/RearSessionParameterBridge$2;->val$portrait:Ljava/lang/reflect/Field;

    iput-object p6, p0, Llocal/mio/os4camerabridge/RearSessionParameterBridge$2;->val$parameters:Ljava/lang/reflect/Field;

    iput-object p7, p0, Llocal/mio/os4camerabridge/RearSessionParameterBridge$2;->val$generation:Ljava/lang/reflect/Field;

    invoke-direct {p0}, Lde/robv/android/xposed/XC_MethodHook;-><init>()V

    return-void
.end method


# virtual methods
.method protected afterHookedMethod(Lde/robv/android/xposed/XC_MethodHook$MethodHookParam;)V
    .locals 13

    .line 53
    invoke-virtual {p1}, Lde/robv/android/xposed/XC_MethodHook$MethodHookParam;->hasThrowable()Z

    move-result v0

    if-nez v0, :cond_f

    sget-object v0, Ljava/lang/Boolean;->TRUE:Ljava/lang/Boolean;

    invoke-virtual {p1}, Lde/robv/android/xposed/XC_MethodHook$MethodHookParam;->getResult()Ljava/lang/Object;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/Boolean;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-nez v0, :cond_0

    goto/16 :goto_8

    .line 55
    :cond_0
    :try_start_0
    iget-object v0, p0, Llocal/mio/os4camerabridge/RearSessionParameterBridge$2;->val$lock:Ljava/lang/Object;

    monitor-enter v0
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_1

    .line 56
    :try_start_1
    iget-object v1, p0, Llocal/mio/os4camerabridge/RearSessionParameterBridge$2;->val$active:Ljava/lang/reflect/Field;

    const/4 v2, 0x0

    invoke-virtual {v1, v2}, Ljava/lang/reflect/Field;->getBoolean(Ljava/lang/Object;)Z

    move-result v1

    if-eqz v1, :cond_e

    iget-object v1, p0, Llocal/mio/os4camerabridge/RearSessionParameterBridge$2;->val$module:Ljava/lang/reflect/Field;

    invoke-virtual {v1, v2}, Ljava/lang/reflect/Field;->getInt(Ljava/lang/Object;)I

    move-result v1

    invoke-static {v1}, Llocal/mio/os4camerabridge/RearSessionParameterBridge;->-$$Nest$smsupportedModule(I)Z

    move-result v1

    if-eqz v1, :cond_e

    iget-object v1, p0, Llocal/mio/os4camerabridge/RearSessionParameterBridge$2;->val$camera:Ljava/lang/reflect/Field;

    .line 57
    invoke-virtual {v1, v2}, Ljava/lang/reflect/Field;->getInt(Ljava/lang/Object;)I

    move-result v1

    if-nez v1, :cond_e

    iget-object v1, p0, Llocal/mio/os4camerabridge/RearSessionParameterBridge$2;->val$portrait:Ljava/lang/reflect/Field;

    invoke-virtual {v1, v2}, Ljava/lang/reflect/Field;->getBoolean(Ljava/lang/Object;)Z

    move-result v1

    if-eqz v1, :cond_1

    goto/16 :goto_6

    .line 58
    :cond_1
    iget-object v1, p0, Llocal/mio/os4camerabridge/RearSessionParameterBridge$2;->val$parameters:Ljava/lang/reflect/Field;

    invoke-virtual {v1, v2}, Ljava/lang/reflect/Field;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Landroid/hardware/camera2/CaptureRequest;

    .line 59
    if-eqz v1, :cond_d

    .line 60
    iget-object v3, p1, Lde/robv/android/xposed/XC_MethodHook$MethodHookParam;->args:[Ljava/lang/Object;

    const/4 v4, 0x0

    aget-object v3, v3, v4

    check-cast v3, Landroid/hardware/camera2/CaptureRequest$Builder;

    .line 61
    const-string v5, "com.oplus.light.sensor.lux"

    const-string v6, "org.codeaurora.qcamera3.sessionParameters.EnableInsensorZoom"

    filled-new-array {v5, v6}, [Ljava/lang/String;

    move-result-object v5

    :goto_0
    const/4 v6, 0x2

    if-ge v4, v6, :cond_c

    aget-object v6, v5, v4

    .line 62
    nop

    .line 63
    const-string v7, "org.codeaurora.qcamera3.sessionParameters.EnableInsensorZoom"

    invoke-virtual {v7, v6}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v7

    if-eqz v7, :cond_2

    invoke-static {}, Llocal/mio/os4camerabridge/RearSessionParameterBridge;->-$$Nest$sfgetlatestPreview()Landroid/hardware/camera2/CaptureRequest;

    move-result-object v7

    if-eqz v7, :cond_2

    invoke-static {}, Llocal/mio/os4camerabridge/RearSessionParameterBridge;->-$$Nest$sfgetpreviewGeneration()I

    move-result v7

    iget-object v8, p0, Llocal/mio/os4camerabridge/RearSessionParameterBridge$2;->val$generation:Ljava/lang/reflect/Field;

    .line 64
    invoke-virtual {v8, v2}, Ljava/lang/reflect/Field;->getInt(Ljava/lang/Object;)I

    move-result v8

    if-ne v7, v8, :cond_2

    invoke-static {}, Llocal/mio/os4camerabridge/RearSessionParameterBridge;->-$$Nest$sfgetlatestPreview()Landroid/hardware/camera2/CaptureRequest;

    move-result-object v7

    goto :goto_1

    .line 65
    :cond_2
    move-object v7, v1

    :goto_1
    nop

    .line 66
    invoke-virtual {v7}, Landroid/hardware/camera2/CaptureRequest;->getKeys()Ljava/util/List;

    move-result-object v8

    invoke-interface {v8}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object v8

    :cond_3
    invoke-interface {v8}, Ljava/util/Iterator;->hasNext()Z

    move-result v9

    if-eqz v9, :cond_4

    invoke-interface {v8}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v9

    check-cast v9, Landroid/hardware/camera2/CaptureRequest$Key;

    .line 67
    invoke-virtual {v9}, Landroid/hardware/camera2/CaptureRequest$Key;->getName()Ljava/lang/String;

    move-result-object v10

    invoke-virtual {v6, v10}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v10

    if-eqz v10, :cond_3

    goto :goto_2

    .line 66
    :cond_4
    move-object v9, v2

    .line 68
    :goto_2
    if-eqz v9, :cond_b

    .line 69
    invoke-virtual {v7, v9}, Landroid/hardware/camera2/CaptureRequest;->get(Landroid/hardware/camera2/CaptureRequest$Key;)Ljava/lang/Object;

    move-result-object v8

    .line 70
    invoke-static {v8}, Llocal/mio/os4camerabridge/RearSessionParameterBridge;->-$$Nest$smvalid(Ljava/lang/Object;)Z

    move-result v10

    if-eqz v10, :cond_a

    .line 71
    invoke-virtual {v3, v9}, Landroid/hardware/camera2/CaptureRequest$Builder;->get(Landroid/hardware/camera2/CaptureRequest$Key;)Ljava/lang/Object;

    move-result-object v10

    .line 72
    invoke-static {v10, v8}, Llocal/mio/os4camerabridge/RearSessionParameterBridge;->-$$Nest$smequal(Ljava/lang/Object;Ljava/lang/Object;)Z

    move-result v11

    if-nez v11, :cond_9

    .line 73
    instance-of v11, v8, [F

    if-eqz v11, :cond_5

    move-object v11, v8

    check-cast v11, [F

    invoke-virtual {v11}, [F->clone()Ljava/lang/Object;

    move-result-object v11

    goto :goto_3

    .line 74
    :cond_5
    instance-of v11, v8, [I

    if-eqz v11, :cond_6

    move-object v11, v8

    check-cast v11, [I

    invoke-virtual {v11}, [I->clone()Ljava/lang/Object;

    move-result-object v11

    goto :goto_3

    :cond_6
    move-object v11, v8

    .line 75
    :goto_3
    invoke-virtual {v3, v9, v11}, Landroid/hardware/camera2/CaptureRequest$Builder;->set(Landroid/hardware/camera2/CaptureRequest$Key;Ljava/lang/Object;)V

    .line 76
    invoke-virtual {v3, v9}, Landroid/hardware/camera2/CaptureRequest$Builder;->get(Landroid/hardware/camera2/CaptureRequest$Key;)Ljava/lang/Object;

    move-result-object v9

    invoke-static {v9, v8}, Llocal/mio/os4camerabridge/RearSessionParameterBridge;->-$$Nest$smequal(Ljava/lang/Object;Ljava/lang/Object;)Z

    move-result v9

    if-eqz v9, :cond_8

    .line 77
    invoke-static {}, Llocal/mio/os4camerabridge/RearSessionParameterBridge;->-$$Nest$sfgetLOGS()Ljava/util/concurrent/atomic/AtomicInteger;

    move-result-object v9

    invoke-virtual {v9}, Ljava/util/concurrent/atomic/AtomicInteger;->getAndIncrement()I

    move-result v9

    const/16 v11, 0x30

    if-ge v9, v11, :cond_9

    iget-object v9, p1, Lde/robv/android/xposed/XC_MethodHook$MethodHookParam;->args:[Ljava/lang/Object;

    const/4 v11, 0x1

    aget-object v9, v9, v11

    invoke-static {v9}, Ljava/lang/String;->valueOf(Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v9

    .line 78
    invoke-static {v10}, Llocal/mio/os4camerabridge/RearSessionParameterBridge;->-$$Nest$smdisplay(Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v10

    invoke-static {v8}, Llocal/mio/os4camerabridge/RearSessionParameterBridge;->-$$Nest$smdisplay(Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v8

    .line 79
    if-ne v7, v1, :cond_7

    const-string v7, "session"

    goto :goto_4

    :cond_7
    const-string v7, "live-preview"

    :goto_4
    new-instance v11, Ljava/lang/StringBuilder;

    invoke-direct {v11}, Ljava/lang/StringBuilder;-><init>()V

    const-string v12, "[RearSessionParameter] frame="

    invoke-virtual {v11, v12}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v11

    invoke-virtual {v11, v9}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v9

    const-string v11, " "

    invoke-virtual {v9, v11}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v9

    invoke-virtual {v9, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    const-string v9, " "

    invoke-virtual {v6, v9}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    invoke-virtual {v6, v10}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    const-string v9, " -> "

    invoke-virtual {v6, v9}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    invoke-virtual {v6, v8}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    const-string v8, "; reference="

    invoke-virtual {v6, v8}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    invoke-virtual {v6, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    invoke-virtual {v6}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v6

    .line 77
    invoke-static {v6}, Lde/robv/android/xposed/XposedBridge;->log(Ljava/lang/String;)V

    goto :goto_5

    .line 76
    :cond_8
    new-instance p1, Ljava/lang/IllegalStateException;

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "Write did not stick: "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-direct {p1, v1}, Ljava/lang/IllegalStateException;-><init>(Ljava/lang/String;)V

    throw p1

    .line 61
    :cond_9
    :goto_5
    add-int/lit8 v4, v4, 0x1

    goto/16 :goto_0

    .line 70
    :cond_a
    new-instance p1, Ljava/lang/IllegalStateException;

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "Invalid value: "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-direct {p1, v1}, Ljava/lang/IllegalStateException;-><init>(Ljava/lang/String;)V

    throw p1

    .line 68
    :cond_b
    new-instance p1, Ljava/lang/IllegalStateException;

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "Reference has no key: "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-direct {p1, v1}, Ljava/lang/IllegalStateException;-><init>(Ljava/lang/String;)V

    throw p1

    .line 82
    :cond_c
    monitor-exit v0

    .line 85
    goto :goto_7

    .line 59
    :cond_d
    new-instance p1, Ljava/lang/IllegalStateException;

    const-string v1, "Session parameters missing"

    invoke-direct {p1, v1}, Ljava/lang/IllegalStateException;-><init>(Ljava/lang/String;)V

    throw p1

    .line 57
    :cond_e
    :goto_6
    monitor-exit v0

    return-void

    .line 82
    :catchall_0
    move-exception p1

    monitor-exit v0
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    :try_start_2
    throw p1
    :try_end_2
    .catchall {:try_start_2 .. :try_end_2} :catchall_1

    .line 83
    :catchall_1
    move-exception p1

    .line 84
    invoke-static {p1}, Ljava/lang/String;->valueOf(Ljava/lang/Object;)Ljava/lang/String;

    move-result-object p1

    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "[RearSessionParameter] alignment failed: "

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p1

    invoke-virtual {p1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p1

    invoke-static {p1}, Lde/robv/android/xposed/XposedBridge;->log(Ljava/lang/String;)V

    .line 86
    :goto_7
    return-void

    .line 53
    :cond_f
    :goto_8
    return-void
.end method
