.class Llocal/mio/os4camerabridge/RearDeferredPreviewBridge$1;
.super Lde/robv/android/xposed/XC_MethodHook;
.source "RearDeferredPreviewBridge.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Llocal/mio/os4camerabridge/RearDeferredPreviewBridge;->install(Ljava/lang/ClassLoader;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# direct methods
.method constructor <init>()V
    .locals 0

    .line 38
    invoke-direct {p0}, Lde/robv/android/xposed/XC_MethodHook;-><init>()V

    return-void
.end method


# virtual methods
.method protected afterHookedMethod(Lde/robv/android/xposed/XC_MethodHook$MethodHookParam;)V
    .locals 6
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/lang/Throwable;
        }
    .end annotation

    .line 40
    invoke-static {}, Llocal/mio/os4camerabridge/RearDeferredPreviewBridge;->-$$Nest$sfgetsessionLock()Ljava/lang/Object;

    move-result-object v0

    monitor-enter v0

    .line 41
    :try_start_0
    invoke-static {}, Llocal/mio/os4camerabridge/RearDeferredPreviewBridge;->-$$Nest$sfgetpendingOutput()Landroid/hardware/camera2/params/OutputConfiguration;

    move-result-object v1

    if-eqz v1, :cond_7

    invoke-static {}, Llocal/mio/os4camerabridge/RearDeferredPreviewBridge;->-$$Nest$sfgetpendingGeneration()I

    move-result v1

    invoke-static {}, Llocal/mio/os4camerabridge/RearDeferredPreviewBridge;->-$$Nest$sfgetgenerationField()Ljava/lang/reflect/Field;

    move-result-object v2

    const/4 v3, 0x0

    invoke-virtual {v2, v3}, Ljava/lang/reflect/Field;->getInt(Ljava/lang/Object;)I

    move-result v2

    if-ne v1, v2, :cond_7

    iget-object v1, p1, Lde/robv/android/xposed/XC_MethodHook$MethodHookParam;->thisObject:Ljava/lang/Object;

    invoke-static {}, Llocal/mio/os4camerabridge/RearDeferredPreviewBridge;->-$$Nest$sfgetsessionField()Ljava/lang/reflect/Field;

    move-result-object v2

    .line 42
    invoke-virtual {v2, v3}, Ljava/lang/reflect/Field;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v2

    if-ne v1, v2, :cond_7

    invoke-static {}, Llocal/mio/os4camerabridge/RearDeferredPreviewBridge;->-$$Nest$sfgetactiveField()Ljava/lang/reflect/Field;

    move-result-object v1

    invoke-virtual {v1, v3}, Ljava/lang/reflect/Field;->getBoolean(Ljava/lang/Object;)Z

    move-result v1

    if-nez v1, :cond_0

    goto/16 :goto_2

    .line 43
    :cond_0
    nop

    .line 44
    iget-object v1, p1, Lde/robv/android/xposed/XC_MethodHook$MethodHookParam;->args:[Ljava/lang/Object;

    const/4 v2, 0x0

    aget-object v1, v1, v2

    check-cast v1, Ljava/util/List;

    invoke-interface {v1}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object v1

    :cond_1
    :goto_0
    invoke-interface {v1}, Ljava/util/Iterator;->hasNext()Z

    move-result v4

    if-eqz v4, :cond_2

    invoke-interface {v1}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v4

    invoke-static {}, Llocal/mio/os4camerabridge/RearDeferredPreviewBridge;->-$$Nest$sfgetpendingOutput()Landroid/hardware/camera2/params/OutputConfiguration;

    move-result-object v5

    if-ne v4, v5, :cond_1

    const/4 v2, 0x1

    goto :goto_0

    .line 45
    :cond_2
    if-nez v2, :cond_3

    monitor-exit v0

    return-void

    .line 46
    :cond_3
    invoke-virtual {p1}, Lde/robv/android/xposed/XC_MethodHook$MethodHookParam;->hasThrowable()Z

    move-result v1

    if-eqz v1, :cond_4

    .line 47
    invoke-virtual {p1}, Lde/robv/android/xposed/XC_MethodHook$MethodHookParam;->getThrowable()Ljava/lang/Throwable;

    move-result-object p1

    invoke-static {p1}, Ljava/lang/String;->valueOf(Ljava/lang/Object;)Ljava/lang/String;

    move-result-object p1

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "[RearDeferredPreview] framework finalize failed; not bound: "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p1

    invoke-virtual {p1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p1

    invoke-static {p1}, Lde/robv/android/xposed/XposedBridge;->log(Ljava/lang/String;)V

    .line 48
    monitor-exit v0

    return-void

    .line 50
    :cond_4
    invoke-static {}, Llocal/mio/os4camerabridge/RearDeferredPreviewBridge;->-$$Nest$sfgetpendingOutput()Landroid/hardware/camera2/params/OutputConfiguration;

    move-result-object p1

    invoke-virtual {p1}, Landroid/hardware/camera2/params/OutputConfiguration;->getSurface()Landroid/view/Surface;

    move-result-object p1

    .line 51
    if-eqz p1, :cond_6

    invoke-virtual {p1}, Landroid/view/Surface;->isValid()Z

    move-result v1

    if-nez v1, :cond_5

    goto :goto_1

    .line 55
    :cond_5
    invoke-static {}, Llocal/mio/os4camerabridge/RearDeferredPreviewBridge;->-$$Nest$sfgetpreviewField()Ljava/lang/reflect/Field;

    move-result-object v1

    invoke-virtual {v1, v3, p1}, Ljava/lang/reflect/Field;->set(Ljava/lang/Object;Ljava/lang/Object;)V

    .line 56
    invoke-static {}, Llocal/mio/os4camerabridge/RearDeferredPreviewBridge;->-$$Nest$sfgetpendingGeneration()I

    move-result p1

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "[RearDeferredPreview] finalized real Xiaomi Surface generation="

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, p1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object p1

    invoke-virtual {p1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p1

    invoke-static {p1}, Lde/robv/android/xposed/XposedBridge;->log(Ljava/lang/String;)V

    .line 57
    invoke-static {v3}, Llocal/mio/os4camerabridge/RearDeferredPreviewBridge;->-$$Nest$sfputpendingOutput(Landroid/hardware/camera2/params/OutputConfiguration;)V

    .line 58
    const/4 p1, -0x1

    invoke-static {p1}, Llocal/mio/os4camerabridge/RearDeferredPreviewBridge;->-$$Nest$sfputpendingGeneration(I)V

    .line 59
    monitor-exit v0

    .line 60
    return-void

    .line 52
    :cond_6
    :goto_1
    const-string p1, "[RearDeferredPreview] finalize returned without a valid preview; not bound"

    invoke-static {p1}, Lde/robv/android/xposed/XposedBridge;->log(Ljava/lang/String;)V

    .line 53
    monitor-exit v0

    return-void

    .line 42
    :cond_7
    :goto_2
    monitor-exit v0

    return-void

    .line 59
    :catchall_0
    move-exception p1

    monitor-exit v0
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    throw p1
.end method
