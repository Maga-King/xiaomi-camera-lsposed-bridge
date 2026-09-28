.class public final Llocal/mio/os4camerabridge/VideoLogicalWideZoomBridge;
.super Ljava/lang/Object;
.source "VideoLogicalWideZoomBridge.java"


# static fields
.field private static final LOGS:Ljava/util/concurrent/atomic/AtomicInteger;

.field private static installed:Z


# direct methods
.method static bridge synthetic -$$Nest$sfgetLOGS()Ljava/util/concurrent/atomic/AtomicInteger;
    .locals 1

    sget-object v0, Llocal/mio/os4camerabridge/VideoLogicalWideZoomBridge;->LOGS:Ljava/util/concurrent/atomic/AtomicInteger;

    return-object v0
.end method

.method static constructor <clinit>()V
    .locals 1

    .line 17
    new-instance v0, Ljava/util/concurrent/atomic/AtomicInteger;

    invoke-direct {v0}, Ljava/util/concurrent/atomic/AtomicInteger;-><init>()V

    sput-object v0, Llocal/mio/os4camerabridge/VideoLogicalWideZoomBridge;->LOGS:Ljava/util/concurrent/atomic/AtomicInteger;

    return-void
.end method

.method private constructor <init>()V
    .locals 0

    .line 18
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method public static declared-synchronized install(Ljava/lang/ClassLoader;)V
    .locals 8

    const-class p0, Llocal/mio/os4camerabridge/VideoLogicalWideZoomBridge;

    monitor-enter p0

    .line 21
    :try_start_0
    sget-boolean v0, Llocal/mio/os4camerabridge/VideoLogicalWideZoomBridge;->installed:Z
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_1

    if-eqz v0, :cond_0

    monitor-exit p0

    return-void

    .line 23
    :cond_0
    :try_start_1
    const-string v0, "local.mio.os4camerabridge.HookEntry"

    const-class v1, Llocal/mio/os4camerabridge/VideoLogicalWideZoomBridge;

    .line 24
    invoke-virtual {v1}, Ljava/lang/Class;->getClassLoader()Ljava/lang/ClassLoader;

    move-result-object v1

    .line 23
    const/4 v2, 0x0

    invoke-static {v0, v2, v1}, Ljava/lang/Class;->forName(Ljava/lang/String;ZLjava/lang/ClassLoader;)Ljava/lang/Class;

    move-result-object v0

    .line 25
    const-string v1, "CAMERA_CHARACTERISTICS"

    invoke-virtual {v0, v1}, Ljava/lang/Class;->getDeclaredField(Ljava/lang/String;)Ljava/lang/reflect/Field;

    move-result-object v1

    .line 26
    const/4 v2, 0x1

    invoke-virtual {v1, v2}, Ljava/lang/reflect/Field;->setAccessible(Z)V

    .line 27
    const-string v3, "applyPhysicalRoleZoom"

    const-class v4, Landroid/hardware/camera2/CaptureRequest$Builder;

    sget-object v5, Ljava/lang/Integer;->TYPE:Ljava/lang/Class;

    sget-object v6, Ljava/lang/Float;->TYPE:Ljava/lang/Class;

    sget-object v7, Ljava/lang/Integer;->TYPE:Ljava/lang/Class;

    filled-new-array {v4, v5, v6, v7}, [Ljava/lang/Class;

    move-result-object v4

    invoke-virtual {v0, v3, v4}, Ljava/lang/Class;->getDeclaredMethod(Ljava/lang/String;[Ljava/lang/Class;)Ljava/lang/reflect/Method;

    move-result-object v0

    .line 29
    new-instance v3, Llocal/mio/os4camerabridge/VideoLogicalWideZoomBridge$1;

    invoke-direct {v3, v1}, Llocal/mio/os4camerabridge/VideoLogicalWideZoomBridge$1;-><init>(Ljava/lang/reflect/Field;)V

    invoke-static {v0, v3}, Lde/robv/android/xposed/XposedBridge;->hookMethod(Ljava/lang/reflect/Member;Lde/robv/android/xposed/XC_MethodHook;)Lde/robv/android/xposed/XC_MethodHook$Unhook;

    .line 64
    sput-boolean v2, Llocal/mio/os4camerabridge/VideoLogicalWideZoomBridge;->installed:Z

    .line 65
    const-string v0, "[VideoLogicalWideZoom] installed v2: rear Video162 logical0 continuous0.6..20; no physical-role crop conversion"

    invoke-static {v0}, Lde/robv/android/xposed/XposedBridge;->log(Ljava/lang/String;)V
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    goto :goto_0

    .line 66
    :catchall_0
    move-exception v0

    :try_start_2
    invoke-static {v0}, Ljava/lang/String;->valueOf(Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v0

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "[VideoLogicalWideZoom] install rejected: "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Lde/robv/android/xposed/XposedBridge;->log(Ljava/lang/String;)V
    :try_end_2
    .catchall {:try_start_2 .. :try_end_2} :catchall_1

    :goto_0
    nop

    .line 67
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
