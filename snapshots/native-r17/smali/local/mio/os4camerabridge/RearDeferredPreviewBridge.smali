.class public final Llocal/mio/os4camerabridge/RearDeferredPreviewBridge;
.super Ljava/lang/Object;
.source "RearDeferredPreviewBridge.java"


# static fields
.field private static activeField:Ljava/lang/reflect/Field;

.field private static generationField:Ljava/lang/reflect/Field;

.field private static volatile installed:Z

.field private static isDeferred:Ljava/lang/reflect/Method;

.field private static moduleField:Ljava/lang/reflect/Field;

.field private static pendingGeneration:I

.field private static pendingOutput:Landroid/hardware/camera2/params/OutputConfiguration;

.field private static previewField:Ljava/lang/reflect/Field;

.field private static sessionField:Ljava/lang/reflect/Field;

.field private static sessionLock:Ljava/lang/Object;


# direct methods
.method static bridge synthetic -$$Nest$sfgetactiveField()Ljava/lang/reflect/Field;
    .locals 1

    sget-object v0, Llocal/mio/os4camerabridge/RearDeferredPreviewBridge;->activeField:Ljava/lang/reflect/Field;

    return-object v0
.end method

.method static bridge synthetic -$$Nest$sfgetgenerationField()Ljava/lang/reflect/Field;
    .locals 1

    sget-object v0, Llocal/mio/os4camerabridge/RearDeferredPreviewBridge;->generationField:Ljava/lang/reflect/Field;

    return-object v0
.end method

.method static bridge synthetic -$$Nest$sfgetpendingGeneration()I
    .locals 1

    sget v0, Llocal/mio/os4camerabridge/RearDeferredPreviewBridge;->pendingGeneration:I

    return v0
.end method

.method static bridge synthetic -$$Nest$sfgetpendingOutput()Landroid/hardware/camera2/params/OutputConfiguration;
    .locals 1

    sget-object v0, Llocal/mio/os4camerabridge/RearDeferredPreviewBridge;->pendingOutput:Landroid/hardware/camera2/params/OutputConfiguration;

    return-object v0
.end method

.method static bridge synthetic -$$Nest$sfgetpreviewField()Ljava/lang/reflect/Field;
    .locals 1

    sget-object v0, Llocal/mio/os4camerabridge/RearDeferredPreviewBridge;->previewField:Ljava/lang/reflect/Field;

    return-object v0
.end method

.method static bridge synthetic -$$Nest$sfgetsessionField()Ljava/lang/reflect/Field;
    .locals 1

    sget-object v0, Llocal/mio/os4camerabridge/RearDeferredPreviewBridge;->sessionField:Ljava/lang/reflect/Field;

    return-object v0
.end method

.method static bridge synthetic -$$Nest$sfgetsessionLock()Ljava/lang/Object;
    .locals 1

    sget-object v0, Llocal/mio/os4camerabridge/RearDeferredPreviewBridge;->sessionLock:Ljava/lang/Object;

    return-object v0
.end method

.method static bridge synthetic -$$Nest$sfputpendingGeneration(I)V
    .locals 0

    sput p0, Llocal/mio/os4camerabridge/RearDeferredPreviewBridge;->pendingGeneration:I

    return-void
.end method

.method static bridge synthetic -$$Nest$sfputpendingOutput(Landroid/hardware/camera2/params/OutputConfiguration;)V
    .locals 0

    sput-object p0, Llocal/mio/os4camerabridge/RearDeferredPreviewBridge;->pendingOutput:Landroid/hardware/camera2/params/OutputConfiguration;

    return-void
.end method

.method static constructor <clinit>()V
    .locals 1

    .line 19
    const/4 v0, -0x1

    sput v0, Llocal/mio/os4camerabridge/RearDeferredPreviewBridge;->pendingGeneration:I

    return-void
.end method

.method private constructor <init>()V
    .locals 0

    .line 21
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method private static field(Ljava/lang/Class;Ljava/lang/String;Ljava/lang/Class;)Ljava/lang/reflect/Field;
    .locals 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/lang/Class<",
            "*>;",
            "Ljava/lang/String;",
            "Ljava/lang/Class<",
            "*>;)",
            "Ljava/lang/reflect/Field;"
        }
    .end annotation

    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/lang/Exception;
        }
    .end annotation

    .line 90
    invoke-virtual {p0, p1}, Ljava/lang/Class;->getDeclaredField(Ljava/lang/String;)Ljava/lang/reflect/Field;

    move-result-object p0

    .line 91
    invoke-virtual {p0}, Ljava/lang/reflect/Field;->getType()Ljava/lang/Class;

    move-result-object v0

    if-ne v0, p2, :cond_0

    .line 92
    const/4 p1, 0x1

    invoke-virtual {p0, p1}, Ljava/lang/reflect/Field;->setAccessible(Z)V

    .line 93
    return-object p0

    .line 91
    :cond_0
    new-instance p0, Ljava/lang/IllegalStateException;

    new-instance p2, Ljava/lang/StringBuilder;

    invoke-direct {p2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v0, "Unexpected field type: "

    invoke-virtual {p2, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p2

    invoke-virtual {p2, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p1

    invoke-virtual {p1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p1

    invoke-direct {p0, p1}, Ljava/lang/IllegalStateException;-><init>(Ljava/lang/String;)V

    throw p0
.end method

.method public static declared-synchronized install(Ljava/lang/ClassLoader;)V
    .locals 4

    const-class p0, Llocal/mio/os4camerabridge/RearDeferredPreviewBridge;

    monitor-enter p0

    .line 24
    :try_start_0
    sget-boolean v0, Llocal/mio/os4camerabridge/RearDeferredPreviewBridge;->installed:Z
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_1

    if-eqz v0, :cond_0

    monitor-exit p0

    return-void

    .line 26
    :cond_0
    :try_start_1
    const-string v0, "local.mio.os4camerabridge.HookEntry"

    const-class v1, Llocal/mio/os4camerabridge/RearDeferredPreviewBridge;

    .line 27
    invoke-virtual {v1}, Ljava/lang/Class;->getClassLoader()Ljava/lang/ClassLoader;

    move-result-object v1

    .line 26
    const/4 v2, 0x0

    invoke-static {v0, v2, v1}, Ljava/lang/Class;->forName(Ljava/lang/String;ZLjava/lang/ClassLoader;)Ljava/lang/Class;

    move-result-object v0

    .line 28
    const-string v1, "commonApsUnifiedSessionGeneration"

    sget-object v3, Ljava/lang/Integer;->TYPE:Ljava/lang/Class;

    invoke-static {v0, v1, v3}, Llocal/mio/os4camerabridge/RearDeferredPreviewBridge;->field(Ljava/lang/Class;Ljava/lang/String;Ljava/lang/Class;)Ljava/lang/reflect/Field;

    move-result-object v1

    sput-object v1, Llocal/mio/os4camerabridge/RearDeferredPreviewBridge;->generationField:Ljava/lang/reflect/Field;

    .line 29
    const-string v1, "activeCameraModule"

    sget-object v3, Ljava/lang/Integer;->TYPE:Ljava/lang/Class;

    invoke-static {v0, v1, v3}, Llocal/mio/os4camerabridge/RearDeferredPreviewBridge;->field(Ljava/lang/Class;Ljava/lang/String;Ljava/lang/Class;)Ljava/lang/reflect/Field;

    move-result-object v1

    sput-object v1, Llocal/mio/os4camerabridge/RearDeferredPreviewBridge;->moduleField:Ljava/lang/reflect/Field;

    .line 30
    const-string v1, "commonApsUnifiedSession"

    const-class v3, Landroid/hardware/camera2/CameraCaptureSession;

    invoke-static {v0, v1, v3}, Llocal/mio/os4camerabridge/RearDeferredPreviewBridge;->field(Ljava/lang/Class;Ljava/lang/String;Ljava/lang/Class;)Ljava/lang/reflect/Field;

    move-result-object v1

    sput-object v1, Llocal/mio/os4camerabridge/RearDeferredPreviewBridge;->sessionField:Ljava/lang/reflect/Field;

    .line 31
    const-string v1, "commonApsUnifiedSessionActive"

    sget-object v3, Ljava/lang/Boolean;->TYPE:Ljava/lang/Class;

    invoke-static {v0, v1, v3}, Llocal/mio/os4camerabridge/RearDeferredPreviewBridge;->field(Ljava/lang/Class;Ljava/lang/String;Ljava/lang/Class;)Ljava/lang/reflect/Field;

    move-result-object v1

    sput-object v1, Llocal/mio/os4camerabridge/RearDeferredPreviewBridge;->activeField:Ljava/lang/reflect/Field;

    .line 32
    const-string v1, "commonApsUnifiedXiaomiPreviewSurface"

    const-class v3, Landroid/view/Surface;

    invoke-static {v0, v1, v3}, Llocal/mio/os4camerabridge/RearDeferredPreviewBridge;->field(Ljava/lang/Class;Ljava/lang/String;Ljava/lang/Class;)Ljava/lang/reflect/Field;

    move-result-object v1

    sput-object v1, Llocal/mio/os4camerabridge/RearDeferredPreviewBridge;->previewField:Ljava/lang/reflect/Field;

    .line 33
    const-string v1, "COMMON_APS_UNIFIED_SESSION_LOCK"

    const-class v3, Ljava/lang/Object;

    invoke-static {v0, v1, v3}, Llocal/mio/os4camerabridge/RearDeferredPreviewBridge;->field(Ljava/lang/Class;Ljava/lang/String;Ljava/lang/Class;)Ljava/lang/reflect/Field;

    move-result-object v0

    const/4 v1, 0x0

    invoke-virtual {v0, v1}, Ljava/lang/reflect/Field;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0

    sput-object v0, Llocal/mio/os4camerabridge/RearDeferredPreviewBridge;->sessionLock:Ljava/lang/Object;

    .line 34
    const-class v0, Landroid/hardware/camera2/params/OutputConfiguration;

    const-string v1, "isDeferredConfiguration"

    new-array v2, v2, [Ljava/lang/Class;

    invoke-virtual {v0, v1, v2}, Ljava/lang/Class;->getDeclaredMethod(Ljava/lang/String;[Ljava/lang/Class;)Ljava/lang/reflect/Method;

    move-result-object v0

    sput-object v0, Llocal/mio/os4camerabridge/RearDeferredPreviewBridge;->isDeferred:Ljava/lang/reflect/Method;

    .line 35
    sget-object v0, Llocal/mio/os4camerabridge/RearDeferredPreviewBridge;->isDeferred:Ljava/lang/reflect/Method;

    const/4 v1, 0x1

    invoke-virtual {v0, v1}, Ljava/lang/reflect/Method;->setAccessible(Z)V

    .line 36
    const-string v0, "android.hardware.camera2.impl.CameraCaptureSessionImpl"

    invoke-static {v0}, Ljava/lang/Class;->forName(Ljava/lang/String;)Ljava/lang/Class;

    move-result-object v0

    .line 37
    const-string v2, "finalizeOutputConfigurations"

    const-class v3, Ljava/util/List;

    filled-new-array {v3}, [Ljava/lang/Class;

    move-result-object v3

    invoke-virtual {v0, v2, v3}, Ljava/lang/Class;->getDeclaredMethod(Ljava/lang/String;[Ljava/lang/Class;)Ljava/lang/reflect/Method;

    move-result-object v0

    .line 38
    new-instance v2, Llocal/mio/os4camerabridge/RearDeferredPreviewBridge$1;

    invoke-direct {v2}, Llocal/mio/os4camerabridge/RearDeferredPreviewBridge$1;-><init>()V

    invoke-static {v0, v2}, Lde/robv/android/xposed/XposedBridge;->hookMethod(Ljava/lang/reflect/Member;Lde/robv/android/xposed/XC_MethodHook;)Lde/robv/android/xposed/XC_MethodHook$Unhook;

    .line 62
    sput-boolean v1, Llocal/mio/os4camerabridge/RearDeferredPreviewBridge;->installed:Z

    .line 63
    const-string v0, "[RearDeferredPreview] installed v1; same output identity, generation and session required"

    invoke-static {v0}, Lde/robv/android/xposed/XposedBridge;->log(Ljava/lang/String;)V
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    .line 66
    goto :goto_0

    .line 64
    :catchall_0
    move-exception v0

    .line 65
    :try_start_2
    invoke-static {v0}, Ljava/lang/String;->valueOf(Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v0

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "[RearDeferredPreview] install rejected: "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Lde/robv/android/xposed/XposedBridge;->log(Ljava/lang/String;)V
    :try_end_2
    .catchall {:try_start_2 .. :try_end_2} :catchall_1

    .line 67
    :goto_0
    monitor-exit p0

    return-void

    .line 23
    :catchall_1
    move-exception v0

    :try_start_3
    monitor-exit p0
    :try_end_3
    .catchall {:try_start_3 .. :try_end_3} :catchall_1

    throw v0
.end method

.method public static prepare(Landroid/hardware/camera2/params/OutputConfiguration;I)Landroid/view/Surface;
    .locals 5
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/lang/Exception;
        }
    .end annotation

    .line 70
    invoke-virtual {p0}, Landroid/hardware/camera2/params/OutputConfiguration;->getSurface()Landroid/view/Surface;

    move-result-object v0

    .line 71
    sget-boolean v1, Llocal/mio/os4camerabridge/RearDeferredPreviewBridge;->installed:Z

    if-nez v1, :cond_1

    .line 72
    if-eqz v0, :cond_0

    .line 73
    return-object v0

    .line 72
    :cond_0
    new-instance p0, Ljava/lang/IllegalStateException;

    const-string p1, "Deferred preview bridge unavailable"

    invoke-direct {p0, p1}, Ljava/lang/IllegalStateException;-><init>(Ljava/lang/String;)V

    throw p0

    .line 75
    :cond_1
    sget-object v1, Llocal/mio/os4camerabridge/RearDeferredPreviewBridge;->sessionLock:Ljava/lang/Object;

    monitor-enter v1

    .line 76
    :try_start_0
    sget-object v2, Llocal/mio/os4camerabridge/RearDeferredPreviewBridge;->generationField:Ljava/lang/reflect/Field;

    const/4 v3, 0x0

    invoke-virtual {v2, v3}, Ljava/lang/reflect/Field;->getInt(Ljava/lang/Object;)I

    move-result v2

    if-ne p1, v2, :cond_4

    .line 77
    sput-object v3, Llocal/mio/os4camerabridge/RearDeferredPreviewBridge;->pendingOutput:Landroid/hardware/camera2/params/OutputConfiguration;

    .line 78
    const/4 v2, -0x1

    sput v2, Llocal/mio/os4camerabridge/RearDeferredPreviewBridge;->pendingGeneration:I

    .line 79
    if-eqz v0, :cond_2

    monitor-exit v1

    return-object v0

    .line 80
    :cond_2
    sget-object v0, Llocal/mio/os4camerabridge/RearDeferredPreviewBridge;->moduleField:Ljava/lang/reflect/Field;

    invoke-virtual {v0, v3}, Ljava/lang/reflect/Field;->getInt(Ljava/lang/Object;)I

    move-result v0

    const/16 v2, 0xa3

    if-ne v0, v2, :cond_3

    sget-object v0, Ljava/lang/Boolean;->TRUE:Ljava/lang/Boolean;

    sget-object v2, Llocal/mio/os4camerabridge/RearDeferredPreviewBridge;->isDeferred:Ljava/lang/reflect/Method;

    const/4 v4, 0x0

    new-array v4, v4, [Ljava/lang/Object;

    invoke-virtual {v2, p0, v4}, Ljava/lang/reflect/Method;->invoke(Ljava/lang/Object;[Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v2

    invoke-virtual {v0, v2}, Ljava/lang/Boolean;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_3

    .line 82
    sput-object p0, Llocal/mio/os4camerabridge/RearDeferredPreviewBridge;->pendingOutput:Landroid/hardware/camera2/params/OutputConfiguration;

    .line 83
    sput p1, Llocal/mio/os4camerabridge/RearDeferredPreviewBridge;->pendingGeneration:I

    .line 84
    new-instance p0, Ljava/lang/StringBuilder;

    invoke-direct {p0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v0, "[RearDeferredPreview] retaining Xiaomi deferred output generation="

    invoke-virtual {p0, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p0

    invoke-virtual {p0, p1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object p0

    invoke-virtual {p0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p0

    invoke-static {p0}, Lde/robv/android/xposed/XposedBridge;->log(Ljava/lang/String;)V

    .line 85
    monitor-exit v1

    return-object v3

    .line 81
    :cond_3
    new-instance p0, Ljava/lang/IllegalStateException;

    const-string p1, "Missing preview is not ordinary Photo deferred output"

    invoke-direct {p0, p1}, Ljava/lang/IllegalStateException;-><init>(Ljava/lang/String;)V

    throw p0

    .line 76
    :cond_4
    new-instance p0, Ljava/lang/IllegalStateException;

    const-string p1, "Stale preview generation"

    invoke-direct {p0, p1}, Ljava/lang/IllegalStateException;-><init>(Ljava/lang/String;)V

    throw p0

    .line 86
    :catchall_0
    move-exception p0

    monitor-exit v1
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    throw p0
.end method
