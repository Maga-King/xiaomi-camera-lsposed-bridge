.class public final Llocal/mio/os4camerabridge/RearTelePreviewBridge;
.super Ljava/lang/Object;
.source "RearTelePreviewBridge.java"


# static fields
.field private static final FALLBACK:Landroid/hardware/camera2/CaptureRequest$Key;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Landroid/hardware/camera2/CaptureRequest$Key<",
            "[I>;"
        }
    .end annotation
.end field

.field private static final LOGS:Ljava/util/concurrent/atomic/AtomicInteger;

.field private static installed:Z


# direct methods
.method static bridge synthetic -$$Nest$sfgetFALLBACK()Landroid/hardware/camera2/CaptureRequest$Key;
    .locals 1

    sget-object v0, Llocal/mio/os4camerabridge/RearTelePreviewBridge;->FALLBACK:Landroid/hardware/camera2/CaptureRequest$Key;

    return-object v0
.end method

.method static bridge synthetic -$$Nest$sfgetLOGS()Ljava/util/concurrent/atomic/AtomicInteger;
    .locals 1

    sget-object v0, Llocal/mio/os4camerabridge/RearTelePreviewBridge;->LOGS:Ljava/util/concurrent/atomic/AtomicInteger;

    return-object v0
.end method

.method static constructor <clinit>()V
    .locals 3

    .line 13
    new-instance v0, Landroid/hardware/camera2/CaptureRequest$Key;

    const-string v1, "com.oplus.fallback.disableMask"

    const-class v2, [I

    invoke-direct {v0, v1, v2}, Landroid/hardware/camera2/CaptureRequest$Key;-><init>(Ljava/lang/String;Ljava/lang/Class;)V

    sput-object v0, Llocal/mio/os4camerabridge/RearTelePreviewBridge;->FALLBACK:Landroid/hardware/camera2/CaptureRequest$Key;

    .line 15
    new-instance v0, Ljava/util/concurrent/atomic/AtomicInteger;

    invoke-direct {v0}, Ljava/util/concurrent/atomic/AtomicInteger;-><init>()V

    sput-object v0, Llocal/mio/os4camerabridge/RearTelePreviewBridge;->LOGS:Ljava/util/concurrent/atomic/AtomicInteger;

    return-void
.end method

.method private constructor <init>()V
    .locals 0

    .line 18
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

    .line 63
    invoke-virtual {p0, p1}, Ljava/lang/Class;->getDeclaredField(Ljava/lang/String;)Ljava/lang/reflect/Field;

    move-result-object p0

    .line 64
    invoke-virtual {p0}, Ljava/lang/reflect/Field;->getType()Ljava/lang/Class;

    move-result-object v0

    if-ne v0, p2, :cond_0

    .line 65
    const/4 p1, 0x1

    invoke-virtual {p0, p1}, Ljava/lang/reflect/Field;->setAccessible(Z)V

    .line 66
    return-object p0

    .line 64
    :cond_0
    new-instance p0, Ljava/lang/IllegalStateException;

    new-instance p2, Ljava/lang/StringBuilder;

    invoke-direct {p2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v0, "Unexpected "

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
    .locals 10

    const-class p0, Llocal/mio/os4camerabridge/RearTelePreviewBridge;

    monitor-enter p0

    .line 21
    :try_start_0
    sget-boolean v0, Llocal/mio/os4camerabridge/RearTelePreviewBridge;->installed:Z
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_1

    if-eqz v0, :cond_0

    monitor-exit p0

    return-void

    .line 23
    :cond_0
    :try_start_1
    const-string v0, "local.mio.os4camerabridge.HookEntry"

    const-class v1, Llocal/mio/os4camerabridge/RearTelePreviewBridge;

    .line 24
    invoke-virtual {v1}, Ljava/lang/Class;->getClassLoader()Ljava/lang/ClassLoader;

    move-result-object v1

    .line 23
    const/4 v2, 0x0

    invoke-static {v0, v2, v1}, Ljava/lang/Class;->forName(Ljava/lang/String;ZLjava/lang/ClassLoader;)Ljava/lang/Class;

    move-result-object v0

    .line 25
    const-string v1, "applyUnifiedOplusLensRoute"

    const-class v2, Landroid/hardware/camera2/CaptureRequest$Builder;

    const-class v3, Landroid/hardware/camera2/CaptureRequest;

    sget-object v4, Ljava/lang/Boolean;->TYPE:Ljava/lang/Class;

    filled-new-array {v2, v3, v4}, [Ljava/lang/Class;

    move-result-object v2

    invoke-virtual {v0, v1, v2}, Ljava/lang/Class;->getDeclaredMethod(Ljava/lang/String;[Ljava/lang/Class;)Ljava/lang/reflect/Method;

    move-result-object v1

    .line 27
    const-string v2, "activeCameraModule"

    sget-object v3, Ljava/lang/Integer;->TYPE:Ljava/lang/Class;

    invoke-static {v0, v2, v3}, Llocal/mio/os4camerabridge/RearTelePreviewBridge;->field(Ljava/lang/Class;Ljava/lang/String;Ljava/lang/Class;)Ljava/lang/reflect/Field;

    move-result-object v6

    .line 28
    const-string v2, "activeCameraId"

    sget-object v3, Ljava/lang/Integer;->TYPE:Ljava/lang/Class;

    invoke-static {v0, v2, v3}, Llocal/mio/os4camerabridge/RearTelePreviewBridge;->field(Ljava/lang/Class;Ljava/lang/String;Ljava/lang/Class;)Ljava/lang/reflect/Field;

    move-result-object v7

    .line 29
    const-string v2, "commonApsUnifiedSessionActive"

    sget-object v3, Ljava/lang/Boolean;->TYPE:Ljava/lang/Class;

    invoke-static {v0, v2, v3}, Llocal/mio/os4camerabridge/RearTelePreviewBridge;->field(Ljava/lang/Class;Ljava/lang/String;Ljava/lang/Class;)Ljava/lang/reflect/Field;

    move-result-object v8

    .line 30
    const-string v2, "commonApsUnifiedPortraitSession"

    sget-object v3, Ljava/lang/Boolean;->TYPE:Ljava/lang/Class;

    invoke-static {v0, v2, v3}, Llocal/mio/os4camerabridge/RearTelePreviewBridge;->field(Ljava/lang/Class;Ljava/lang/String;Ljava/lang/Class;)Ljava/lang/reflect/Field;

    move-result-object v9

    .line 31
    new-instance v4, Llocal/mio/os4camerabridge/RearTelePreviewBridge$1;

    const/16 v5, 0x2328

    invoke-direct/range {v4 .. v9}, Llocal/mio/os4camerabridge/RearTelePreviewBridge$1;-><init>(ILjava/lang/reflect/Field;Ljava/lang/reflect/Field;Ljava/lang/reflect/Field;Ljava/lang/reflect/Field;)V

    invoke-static {v1, v4}, Lde/robv/android/xposed/XposedBridge;->hookMethod(Ljava/lang/reflect/Member;Lde/robv/android/xposed/XC_MethodHook;)Lde/robv/android/xposed/XC_MethodHook$Unhook;

    .line 55
    const/4 v0, 0x1

    sput-boolean v0, Llocal/mio/os4camerabridge/RearTelePreviewBridge;->installed:Z

    .line 56
    const-string v0, "[RearTelePreview] installed experiment-v1; stock fallback bit2; rear163 logical0 repeating only"

    invoke-static {v0}, Lde/robv/android/xposed/XposedBridge;->log(Ljava/lang/String;)V
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    .line 59
    goto :goto_0

    .line 57
    :catchall_0
    move-exception v0

    .line 58
    :try_start_2
    invoke-static {v0}, Ljava/lang/String;->valueOf(Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v0

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "[RearTelePreview] install rejected: "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Lde/robv/android/xposed/XposedBridge;->log(Ljava/lang/String;)V
    :try_end_2
    .catchall {:try_start_2 .. :try_end_2} :catchall_1

    .line 60
    :goto_0
    monitor-exit p0

    return-void

    .line 20
    :catchall_1
    move-exception v0

    :try_start_3
    monitor-exit p0
    :try_end_3
    .catchall {:try_start_3 .. :try_end_3} :catchall_1

    throw v0
.end method
