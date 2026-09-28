.class public final Llocal/mio/os4camerabridge/LegendaryRawCfaBridge;
.super Ljava/lang/Object;
.source "LegendaryRawCfaBridge.java"


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Llocal/mio/os4camerabridge/LegendaryRawCfaBridge$Frame;
    }
.end annotation


# static fields
.field private static final FRAMES:Ljava/util/Map;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/Map<",
            "Ljava/lang/Object;",
            "Llocal/mio/os4camerabridge/LegendaryRawCfaBridge$Frame;",
            ">;"
        }
    .end annotation
.end field

.field private static installed:Z


# direct methods
.method static bridge synthetic -$$Nest$sfgetFRAMES()Ljava/util/Map;
    .locals 1

    sget-object v0, Llocal/mio/os4camerabridge/LegendaryRawCfaBridge;->FRAMES:Ljava/util/Map;

    return-object v0
.end method

.method static bridge synthetic -$$Nest$smlog(Ljava/lang/String;)V
    .locals 0

    invoke-static {p0}, Llocal/mio/os4camerabridge/LegendaryRawCfaBridge;->log(Ljava/lang/String;)V

    return-void
.end method

.method static constructor <clinit>()V
    .locals 1

    .line 17
    new-instance v0, Ljava/util/WeakHashMap;

    invoke-direct {v0}, Ljava/util/WeakHashMap;-><init>()V

    invoke-static {v0}, Ljava/util/Collections;->synchronizedMap(Ljava/util/Map;)Ljava/util/Map;

    move-result-object v0

    sput-object v0, Llocal/mio/os4camerabridge/LegendaryRawCfaBridge;->FRAMES:Ljava/util/Map;

    return-void
.end method

.method private constructor <init>()V
    .locals 0

    .line 19
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method public static declared-synchronized install(Ljava/lang/ClassLoader;)V
    .locals 10

    const-class p0, Llocal/mio/os4camerabridge/LegendaryRawCfaBridge;

    monitor-enter p0

    .line 21
    :try_start_0
    sget-boolean v0, Llocal/mio/os4camerabridge/LegendaryRawCfaBridge;->installed:Z
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_1

    if-eqz v0, :cond_0

    monitor-exit p0

    return-void

    .line 22
    :cond_0
    :try_start_1
    new-instance v0, Ljava/util/ArrayList;

    invoke-direct {v0}, Ljava/util/ArrayList;-><init>()V
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_1

    .line 24
    :try_start_2
    const-class v1, Llocal/mio/os4camerabridge/LegendaryRawCfaBridge;

    invoke-virtual {v1}, Ljava/lang/Class;->getClassLoader()Ljava/lang/ClassLoader;

    move-result-object v1

    .line 25
    const-string v2, "local.mio.os4camerabridge.HookEntry"

    const/4 v3, 0x0

    invoke-static {v2, v3, v1}, Ljava/lang/Class;->forName(Ljava/lang/String;ZLjava/lang/ClassLoader;)Ljava/lang/Class;

    move-result-object v2

    .line 26
    const-string v4, "local.mio.os4camerabridge.LegendM9Container"

    invoke-static {v4, v3, v1}, Ljava/lang/Class;->forName(Ljava/lang/String;ZLjava/lang/ClassLoader;)Ljava/lang/Class;

    move-result-object v4

    .line 27
    const-string v5, "local.mio.os4camerabridge.LegendM9Container$Metadata"

    invoke-static {v5, v3, v1}, Ljava/lang/Class;->forName(Ljava/lang/String;ZLjava/lang/ClassLoader;)Ljava/lang/Class;

    move-result-object v1

    .line 29
    const-string v3, "packRggbToCloudBggr"

    const-class v5, [B

    sget-object v6, Ljava/lang/Integer;->TYPE:Ljava/lang/Class;

    sget-object v7, Ljava/lang/Integer;->TYPE:Ljava/lang/Class;

    const-class v8, Ljava/lang/String;

    filled-new-array {v5, v6, v7, v8}, [Ljava/lang/Class;

    move-result-object v5

    invoke-virtual {v4, v3, v5}, Ljava/lang/Class;->getDeclaredMethod(Ljava/lang/String;[Ljava/lang/Class;)Ljava/lang/reflect/Method;

    .line 30
    const-string v3, "legendMetadata"

    const-class v5, Landroid/hardware/camera2/CaptureResult;

    const-class v6, Landroid/hardware/camera2/CaptureResult;

    sget-object v7, Ljava/lang/Integer;->TYPE:Ljava/lang/Class;

    sget-object v8, Ljava/lang/Integer;->TYPE:Ljava/lang/Class;

    filled-new-array {v5, v6, v7, v8}, [Ljava/lang/Class;

    move-result-object v5

    invoke-virtual {v2, v3, v5}, Ljava/lang/Class;->getDeclaredMethod(Ljava/lang/String;[Ljava/lang/Class;)Ljava/lang/reflect/Method;

    move-result-object v3

    .line 31
    const-string v5, "wrap"

    const-class v6, [B

    const-class v7, [B

    const-class v8, [F

    const-class v9, Ljava/lang/String;

    filled-new-array {v6, v7, v8, v9, v1}, [Ljava/lang/Class;

    move-result-object v1

    invoke-virtual {v4, v5, v1}, Ljava/lang/Class;->getDeclaredMethod(Ljava/lang/String;[Ljava/lang/Class;)Ljava/lang/reflect/Method;

    move-result-object v1

    .line 32
    new-instance v4, Llocal/mio/os4camerabridge/LegendaryRawCfaBridge$1;

    invoke-direct {v4, v2}, Llocal/mio/os4camerabridge/LegendaryRawCfaBridge$1;-><init>(Ljava/lang/Class;)V

    invoke-static {v3, v4}, Lde/robv/android/xposed/XposedBridge;->hookMethod(Ljava/lang/reflect/Member;Lde/robv/android/xposed/XC_MethodHook;)Lde/robv/android/xposed/XC_MethodHook$Unhook;

    move-result-object v2

    invoke-virtual {v0, v2}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    .line 58
    new-instance v2, Llocal/mio/os4camerabridge/LegendaryRawCfaBridge$2;

    const/16 v3, 0x2328

    invoke-direct {v2, v3}, Llocal/mio/os4camerabridge/LegendaryRawCfaBridge$2;-><init>(I)V

    invoke-static {v1, v2}, Lde/robv/android/xposed/XposedBridge;->hookMethod(Ljava/lang/reflect/Member;Lde/robv/android/xposed/XC_MethodHook;)Lde/robv/android/xposed/XC_MethodHook$Unhook;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    .line 71
    const/4 v1, 0x1

    sput-boolean v1, Llocal/mio/os4camerabridge/LegendaryRawCfaBridge;->installed:Z

    .line 72
    const-string v1, "installed per-frame physical CFA; main bytes unchanged; no color calibration guessed"

    invoke-static {v1}, Llocal/mio/os4camerabridge/LegendaryRawCfaBridge;->log(Ljava/lang/String;)V
    :try_end_2
    .catchall {:try_start_2 .. :try_end_2} :catchall_0

    goto :goto_1

    .line 73
    :catchall_0
    move-exception v1

    :try_start_3
    invoke-virtual {v0}, Ljava/util/ArrayList;->iterator()Ljava/util/Iterator;

    move-result-object v0

    :goto_0
    invoke-interface {v0}, Ljava/util/Iterator;->hasNext()Z

    move-result v2

    if-eqz v2, :cond_1

    invoke-interface {v0}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v2

    check-cast v2, Lde/robv/android/xposed/XC_MethodHook$Unhook;

    invoke-virtual {v2}, Lde/robv/android/xposed/XC_MethodHook$Unhook;->unhook()V

    goto :goto_0

    :cond_1
    invoke-static {v1}, Ljava/lang/String;->valueOf(Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v0

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "install rejected "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Llocal/mio/os4camerabridge/LegendaryRawCfaBridge;->log(Ljava/lang/String;)V
    :try_end_3
    .catchall {:try_start_3 .. :try_end_3} :catchall_1

    :goto_1
    nop

    .line 74
    monitor-exit p0

    return-void

    .line 20
    :catchall_1
    move-exception v0

    :try_start_4
    monitor-exit p0
    :try_end_4
    .catchall {:try_start_4 .. :try_end_4} :catchall_1

    throw v0
.end method

.method private static log(Ljava/lang/String;)V
    .locals 2

    .line 75
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "[LegendaryRawCfa] "

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, p0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p0

    invoke-virtual {p0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p0

    invoke-static {p0}, Lde/robv/android/xposed/XposedBridge;->log(Ljava/lang/String;)V

    return-void
.end method
