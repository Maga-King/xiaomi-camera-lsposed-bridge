.class public final Llocal/mio/os4camerabridge/LegendaryNativeCaptureBridge;
.super Ljava/lang/Object;
.source "LegendaryNativeCaptureBridge.java"


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Llocal/mio/os4camerabridge/LegendaryNativeCaptureBridge$Capture;
    }
.end annotation


# static fields
.field private static final CAPTURES:Ljava/util/Map;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/Map<",
            "Ljava/lang/Long;",
            "Llocal/mio/os4camerabridge/LegendaryNativeCaptureBridge$Capture;",
            ">;"
        }
    .end annotation
.end field

.field private static final CONTAINER_CAPTURE:Ljava/lang/ThreadLocal;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/lang/ThreadLocal<",
            "Llocal/mio/os4camerabridge/LegendaryNativeCaptureBridge$Capture;",
            ">;"
        }
    .end annotation
.end field

.field private static entry:Ljava/lang/Class;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/lang/Class<",
            "*>;"
        }
    .end annotation
.end field

.field private static installed:Z

.field private static transplant:Ljava/lang/reflect/Method;


# direct methods
.method static bridge synthetic -$$Nest$sfgetCAPTURES()Ljava/util/Map;
    .locals 1

    sget-object v0, Llocal/mio/os4camerabridge/LegendaryNativeCaptureBridge;->CAPTURES:Ljava/util/Map;

    return-object v0
.end method

.method static bridge synthetic -$$Nest$smlog(Ljava/lang/String;)V
    .locals 0

    invoke-static {p0}, Llocal/mio/os4camerabridge/LegendaryNativeCaptureBridge;->log(Ljava/lang/String;)V

    return-void
.end method

.method static bridge synthetic -$$Nest$smprune()V
    .locals 0

    invoke-static {}, Llocal/mio/os4camerabridge/LegendaryNativeCaptureBridge;->prune()V

    return-void
.end method

.method static bridge synthetic -$$Nest$smrender([BLlocal/mio/os4camerabridge/LegendaryNativeCaptureBridge$Capture;)[B
    .locals 0

    invoke-static {p0, p1}, Llocal/mio/os4camerabridge/LegendaryNativeCaptureBridge;->render([BLlocal/mio/os4camerabridge/LegendaryNativeCaptureBridge$Capture;)[B

    move-result-object p0

    return-object p0
.end method

.method static constructor <clinit>()V
    .locals 1

    .line 19
    new-instance v0, Ljava/util/LinkedHashMap;

    invoke-direct {v0}, Ljava/util/LinkedHashMap;-><init>()V

    sput-object v0, Llocal/mio/os4camerabridge/LegendaryNativeCaptureBridge;->CAPTURES:Ljava/util/Map;

    .line 20
    new-instance v0, Ljava/lang/ThreadLocal;

    invoke-direct {v0}, Ljava/lang/ThreadLocal;-><init>()V

    sput-object v0, Llocal/mio/os4camerabridge/LegendaryNativeCaptureBridge;->CONTAINER_CAPTURE:Ljava/lang/ThreadLocal;

    return-void
.end method

.method private constructor <init>()V
    .locals 0

    .line 24
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method private static application()Landroid/app/Application;
    .locals 2

    .line 99
    sget-object v0, Llocal/mio/os4camerabridge/LegendaryNativeCaptureBridge;->entry:Ljava/lang/Class;

    const-string v1, "xiaomiCameraApplication"

    invoke-static {v0, v1}, Lde/robv/android/xposed/XposedHelpers;->getStaticObjectField(Ljava/lang/Class;Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Landroid/app/Application;

    .line 100
    if-eqz v0, :cond_0

    .line 101
    return-object v0

    .line 100
    :cond_0
    new-instance v0, Ljava/lang/IllegalStateException;

    const-string v1, "Camera application missing"

    invoke-direct {v0, v1}, Ljava/lang/IllegalStateException;-><init>(Ljava/lang/String;)V

    throw v0
.end method

.method static beginContainer(J)V
    .locals 3

    .line 85
    sget-object v0, Llocal/mio/os4camerabridge/LegendaryNativeCaptureBridge;->CAPTURES:Ljava/util/Map;

    monitor-enter v0

    :try_start_0
    sget-object v1, Llocal/mio/os4camerabridge/LegendaryNativeCaptureBridge;->CONTAINER_CAPTURE:Ljava/lang/ThreadLocal;

    sget-object v2, Llocal/mio/os4camerabridge/LegendaryNativeCaptureBridge;->CAPTURES:Ljava/util/Map;

    invoke-static {p0, p1}, Ljava/lang/Long;->valueOf(J)Ljava/lang/Long;

    move-result-object p0

    invoke-interface {v2, p0}, Ljava/util/Map;->remove(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object p0

    check-cast p0, Llocal/mio/os4camerabridge/LegendaryNativeCaptureBridge$Capture;

    invoke-virtual {v1, p0}, Ljava/lang/ThreadLocal;->set(Ljava/lang/Object;)V

    monitor-exit v0

    .line 86
    return-void

    .line 85
    :catchall_0
    move-exception p0

    monitor-exit v0
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    throw p0
.end method

.method static endContainer()V
    .locals 1

    .line 87
    sget-object v0, Llocal/mio/os4camerabridge/LegendaryNativeCaptureBridge;->CONTAINER_CAPTURE:Ljava/lang/ThreadLocal;

    invoke-virtual {v0}, Ljava/lang/ThreadLocal;->remove()V

    return-void
.end method

.method public static declared-synchronized install(Ljava/lang/ClassLoader;)V
    .locals 5

    const-class v0, Llocal/mio/os4camerabridge/LegendaryNativeCaptureBridge;

    monitor-enter v0

    .line 27
    :try_start_0
    sget-boolean v1, Llocal/mio/os4camerabridge/LegendaryNativeCaptureBridge;->installed:Z
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_3

    if-eqz v1, :cond_0

    monitor-exit v0

    return-void

    .line 28
    :cond_0
    :try_start_1
    invoke-static {p0}, Llocal/mio/os4camerabridge/LegendaryWatermarkBridge;->install(Ljava/lang/ClassLoader;)V
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_3

    .line 30
    :try_start_2
    const-class v1, Llocal/mio/os4camerabridge/LegendaryNativeCaptureBridge;

    invoke-virtual {v1}, Ljava/lang/Class;->getClassLoader()Ljava/lang/ClassLoader;

    move-result-object v1

    .line 31
    const-string v2, "local.mio.os4camerabridge.HookEntry"

    const/4 v3, 0x0

    invoke-static {v2, v3, v1}, Ljava/lang/Class;->forName(Ljava/lang/String;ZLjava/lang/ClassLoader;)Ljava/lang/Class;

    move-result-object v1

    sput-object v1, Llocal/mio/os4camerabridge/LegendaryNativeCaptureBridge;->entry:Ljava/lang/Class;

    .line 32
    sget-object v1, Llocal/mio/os4camerabridge/LegendaryNativeCaptureBridge;->entry:Ljava/lang/Class;

    const-string v2, "transplantAppMetadata"

    const-class v3, [B

    const-class v4, [B

    filled-new-array {v3, v4}, [Ljava/lang/Class;

    move-result-object v3

    invoke-virtual {v1, v2, v3}, Ljava/lang/Class;->getDeclaredMethod(Ljava/lang/String;[Ljava/lang/Class;)Ljava/lang/reflect/Method;

    move-result-object v1

    sput-object v1, Llocal/mio/os4camerabridge/LegendaryNativeCaptureBridge;->transplant:Ljava/lang/reflect/Method;

    .line 33
    sget-object v1, Llocal/mio/os4camerabridge/LegendaryNativeCaptureBridge;->transplant:Ljava/lang/reflect/Method;

    const/4 v2, 0x1

    invoke-virtual {v1, v2}, Ljava/lang/reflect/Method;->setAccessible(Z)V

    .line 34
    const-string v1, "Rh.r"

    invoke-static {v1, p0}, Lde/robv/android/xposed/XposedHelpers;->findClass(Ljava/lang/String;Ljava/lang/ClassLoader;)Ljava/lang/Class;

    move-result-object p0

    const-string v1, "a"

    sget-object v3, Ljava/lang/Integer;->TYPE:Ljava/lang/Class;

    const-class v4, [B

    filled-new-array {v3, v4}, [Ljava/lang/Class;

    move-result-object v3

    invoke-virtual {p0, v1, v3}, Ljava/lang/Class;->getDeclaredMethod(Ljava/lang/String;[Ljava/lang/Class;)Ljava/lang/reflect/Method;

    move-result-object p0

    .line 37
    new-instance v1, Llocal/mio/os4camerabridge/LegendaryNativeCaptureBridge$1;

    const/16 v3, -0x2710

    invoke-direct {v1, v3}, Llocal/mio/os4camerabridge/LegendaryNativeCaptureBridge$1;-><init>(I)V

    invoke-static {p0, v1}, Lde/robv/android/xposed/XposedBridge;->hookMethod(Ljava/lang/reflect/Member;Lde/robv/android/xposed/XC_MethodHook;)Lde/robv/android/xposed/XC_MethodHook$Unhook;
    :try_end_2
    .catchall {:try_start_2 .. :try_end_2} :catchall_2

    .line 59
    :try_start_3
    invoke-static {}, Llocal/mio/os4camerabridge/LegendaryCalibrationBridge;->install()V
    :try_end_3
    .catchall {:try_start_3 .. :try_end_3} :catchall_0

    .line 60
    :goto_0
    goto :goto_1

    :catchall_0
    move-exception p0

    :try_start_4
    invoke-static {p0}, Ljava/lang/String;->valueOf(Ljava/lang/Object;)Ljava/lang/String;

    move-result-object p0

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "optional matrix binding rejected; native rendering stays independent "

    invoke-virtual {v1, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, p0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p0

    invoke-virtual {p0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p0

    invoke-static {p0}, Llocal/mio/os4camerabridge/LegendaryNativeCaptureBridge;->log(Ljava/lang/String;)V
    :try_end_4
    .catchall {:try_start_4 .. :try_end_4} :catchall_2

    goto :goto_0

    .line 61
    :goto_1
    :try_start_5
    invoke-static {}, Llocal/mio/os4camerabridge/LegendaryRawPackBridge;->install()V
    :try_end_5
    .catchall {:try_start_5 .. :try_end_5} :catchall_1

    .line 62
    :goto_2
    goto :goto_3

    :catchall_1
    move-exception p0

    :try_start_6
    invoke-static {p0}, Ljava/lang/String;->valueOf(Ljava/lang/Object;)Ljava/lang/String;

    move-result-object p0

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "RAW loop acceleration unavailable; original packing retained "

    invoke-virtual {v1, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, p0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p0

    invoke-virtual {p0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p0

    invoke-static {p0}, Llocal/mio/os4camerabridge/LegendaryNativeCaptureBridge;->log(Ljava/lang/String;)V

    goto :goto_2

    .line 63
    :goto_3
    sput-boolean v2, Llocal/mio/os4camerabridge/LegendaryNativeCaptureBridge;->installed:Z

    .line 64
    const-string p0, "installed native capture bridge; old capture-side user LUT removed; same-shot main APS only"

    invoke-static {p0}, Llocal/mio/os4camerabridge/LegendaryNativeCaptureBridge;->log(Ljava/lang/String;)V
    :try_end_6
    .catchall {:try_start_6 .. :try_end_6} :catchall_2

    goto :goto_4

    .line 65
    :catchall_2
    move-exception p0

    :try_start_7
    invoke-static {p0}, Ljava/lang/String;->valueOf(Ljava/lang/Object;)Ljava/lang/String;

    move-result-object p0

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "install failed "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, p0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p0

    invoke-virtual {p0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p0

    invoke-static {p0}, Llocal/mio/os4camerabridge/LegendaryNativeCaptureBridge;->log(Ljava/lang/String;)V
    :try_end_7
    .catchall {:try_start_7 .. :try_end_7} :catchall_3

    :goto_4
    nop

    .line 66
    monitor-exit v0

    return-void

    .line 26
    :catchall_3
    move-exception p0

    :try_start_8
    monitor-exit v0
    :try_end_8
    .catchall {:try_start_8 .. :try_end_8} :catchall_3

    throw p0
.end method

.method public static isPhotoApsSource(Ljava/lang/Object;)Z
    .locals 3

    .line 90
    :try_start_0
    const-string v0, "f"

    invoke-static {p0, v0}, Lde/robv/android/xposed/XposedHelpers;->getLongField(Ljava/lang/Object;Ljava/lang/String;)J

    move-result-wide v0

    .line 91
    sget-object p0, Llocal/mio/os4camerabridge/LegendaryNativeCaptureBridge;->CAPTURES:Ljava/util/Map;

    monitor-enter p0
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_1

    :try_start_1
    sget-object v2, Llocal/mio/os4camerabridge/LegendaryNativeCaptureBridge;->CAPTURES:Ljava/util/Map;

    invoke-static {v0, v1}, Ljava/lang/Long;->valueOf(J)Ljava/lang/Long;

    move-result-object v0

    invoke-interface {v2, v0}, Ljava/util/Map;->containsKey(Ljava/lang/Object;)Z

    move-result v0

    monitor-exit p0

    return v0

    :catchall_0
    move-exception v0

    monitor-exit p0
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    :try_start_2
    throw v0
    :try_end_2
    .catchall {:try_start_2 .. :try_end_2} :catchall_1

    .line 92
    :catchall_1
    move-exception p0

    const/4 p0, 0x0

    return p0
.end method

.method static synthetic lambda$prune$0(Llocal/mio/os4camerabridge/LegendaryNativeCaptureBridge$Capture;)Z
    .locals 4

    .line 129
    invoke-static {}, Landroid/os/SystemClock;->elapsedRealtime()J

    move-result-wide v0

    iget-wide v2, p0, Llocal/mio/os4camerabridge/LegendaryNativeCaptureBridge$Capture;->created:J

    sub-long/2addr v0, v2

    const-wide/32 v2, 0xafc8

    cmp-long p0, v0, v2

    if-lez p0, :cond_0

    const/4 p0, 0x1

    goto :goto_0

    :cond_0
    const/4 p0, 0x0

    :goto_0
    return p0
.end method

.method private static log(Ljava/lang/String;)V
    .locals 2

    .line 130
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "[LegendaryNativeCapture] "

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, p0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p0

    invoke-virtual {p0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p0

    invoke-static {p0}, Lde/robv/android/xposed/XposedBridge;->log(Ljava/lang/String;)V

    return-void
.end method

.method static matrixEnabledForContainer()Z
    .locals 3

    .line 95
    sget-object v0, Llocal/mio/os4camerabridge/LegendaryNativeCaptureBridge;->CONTAINER_CAPTURE:Ljava/lang/ThreadLocal;

    invoke-virtual {v0}, Ljava/lang/ThreadLocal;->get()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Llocal/mio/os4camerabridge/LegendaryNativeCaptureBridge$Capture;

    .line 96
    if-eqz v0, :cond_0

    iget v1, v0, Llocal/mio/os4camerabridge/LegendaryNativeCaptureBridge$Capture;->mode:I

    const/4 v2, 0x1

    if-ne v1, v2, :cond_0

    iget-boolean v0, v0, Llocal/mio/os4camerabridge/LegendaryNativeCaptureBridge$Capture;->matrix:Z

    if-eqz v0, :cond_0

    goto :goto_0

    :cond_0
    const/4 v2, 0x0

    :goto_0
    return v2
.end method

.method private static prune()V
    .locals 2

    .line 129
    sget-object v0, Llocal/mio/os4camerabridge/LegendaryNativeCaptureBridge;->CAPTURES:Ljava/util/Map;

    invoke-interface {v0}, Ljava/util/Map;->values()Ljava/util/Collection;

    move-result-object v0

    new-instance v1, Llocal/mio/os4camerabridge/LegendaryNativeCaptureBridge$$ExternalSyntheticLambda0;

    invoke-direct {v1}, Llocal/mio/os4camerabridge/LegendaryNativeCaptureBridge$$ExternalSyntheticLambda0;-><init>()V

    invoke-interface {v0, v1}, Ljava/util/Collection;->removeIf(Ljava/util/function/Predicate;)Z

    return-void
.end method

.method static remember(JIIII)V
    .locals 10

    .line 69
    nop

    .line 71
    const/4 v1, 0x0

    :try_start_0
    invoke-static {}, Llocal/mio/os4camerabridge/LegendaryNativeCaptureBridge;->application()Landroid/app/Application;

    move-result-object v0

    invoke-virtual {v0}, Landroid/app/Application;->getContentResolver()Landroid/content/ContentResolver;

    move-result-object v0

    sget-object v2, Llocal/mio/os4camerabridge/LegendaryProcessingProvider;->URI:Landroid/net/Uri;

    const/4 v3, 0x1

    invoke-virtual {v0, v2, v3}, Landroid/content/ContentResolver;->takePersistableUriPermission(Landroid/net/Uri;I)V
    :try_end_0
    .catch Ljava/lang/SecurityException; {:try_start_0 .. :try_end_0} :catch_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    goto :goto_0

    .line 77
    :catchall_0
    move-exception v0

    move v2, v1

    goto :goto_1

    .line 72
    :catch_0
    move-exception v0

    :goto_0
    nop

    .line 73
    :try_start_1
    invoke-static {}, Llocal/mio/os4camerabridge/LegendaryNativeCaptureBridge;->application()Landroid/app/Application;

    move-result-object v0

    invoke-virtual {v0}, Landroid/app/Application;->getContentResolver()Landroid/content/ContentResolver;

    move-result-object v0

    sget-object v2, Llocal/mio/os4camerabridge/LegendaryProcessingProvider;->URI:Landroid/net/Uri;

    const-string v3, "settings"

    const/4 v4, 0x0

    invoke-virtual {v0, v2, v3, v4, v4}, Landroid/content/ContentResolver;->call(Landroid/net/Uri;Ljava/lang/String;Ljava/lang/String;Landroid/os/Bundle;)Landroid/os/Bundle;

    move-result-object v0

    .line 74
    if-eqz v0, :cond_0

    .line 75
    const-string v2, "optional_aisp_gamma"

    invoke-virtual {v0, v2, v1}, Landroid/os/Bundle;->getBoolean(Ljava/lang/String;Z)Z

    move-result v2
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    .line 76
    :try_start_2
    const-string v3, "optional_sensor_matrix"

    invoke-virtual {v0, v3, v1}, Landroid/os/Bundle;->getBoolean(Ljava/lang/String;Z)Z

    move-result v1
    :try_end_2
    .catchall {:try_start_2 .. :try_end_2} :catchall_1

    .line 77
    goto :goto_2

    :catchall_1
    move-exception v0

    goto :goto_1

    .line 74
    :cond_0
    :try_start_3
    new-instance v0, Ljava/io/IOException;

    const-string v2, "settings provider unavailable"

    invoke-direct {v0, v2}, Ljava/io/IOException;-><init>(Ljava/lang/String;)V

    throw v0
    :try_end_3
    .catchall {:try_start_3 .. :try_end_3} :catchall_0

    .line 77
    :goto_1
    invoke-static {v0}, Ljava/lang/String;->valueOf(Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v0

    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    const-string v4, "optional settings unavailable; both donor adaptations off "

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Llocal/mio/os4camerabridge/LegendaryNativeCaptureBridge;->log(Ljava/lang/String;)V

    :goto_2
    move v9, v1

    move v8, v2

    .line 78
    sget-object v1, Llocal/mio/os4camerabridge/LegendaryNativeCaptureBridge;->CAPTURES:Ljava/util/Map;

    monitor-enter v1

    .line 79
    :try_start_4
    invoke-static {}, Llocal/mio/os4camerabridge/LegendaryNativeCaptureBridge;->prune()V

    .line 80
    :goto_3
    sget-object v0, Llocal/mio/os4camerabridge/LegendaryNativeCaptureBridge;->CAPTURES:Ljava/util/Map;

    invoke-interface {v0}, Ljava/util/Map;->size()I

    move-result v0

    const/4 v2, 0x4

    if-lt v0, v2, :cond_1

    sget-object v0, Llocal/mio/os4camerabridge/LegendaryNativeCaptureBridge;->CAPTURES:Ljava/util/Map;

    sget-object v2, Llocal/mio/os4camerabridge/LegendaryNativeCaptureBridge;->CAPTURES:Ljava/util/Map;

    invoke-interface {v2}, Ljava/util/Map;->keySet()Ljava/util/Set;

    move-result-object v2

    invoke-interface {v2}, Ljava/util/Set;->iterator()Ljava/util/Iterator;

    move-result-object v2

    invoke-interface {v2}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v2

    invoke-interface {v0, v2}, Ljava/util/Map;->remove(Ljava/lang/Object;)Ljava/lang/Object;

    goto :goto_3

    .line 81
    :cond_1
    sget-object v0, Llocal/mio/os4camerabridge/LegendaryNativeCaptureBridge;->CAPTURES:Ljava/util/Map;

    invoke-static {p0, p1}, Ljava/lang/Long;->valueOf(J)Ljava/lang/Long;

    move-result-object p0

    new-instance v3, Llocal/mio/os4camerabridge/LegendaryNativeCaptureBridge$Capture;

    move v4, p2

    move v5, p3

    move v6, p4

    move v7, p5

    invoke-direct/range {v3 .. v9}, Llocal/mio/os4camerabridge/LegendaryNativeCaptureBridge$Capture;-><init>(IIIIZZ)V

    invoke-interface {v0, p0, v3}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 82
    monitor-exit v1

    .line 83
    return-void

    .line 82
    :catchall_2
    move-exception v0

    move-object p0, v0

    monitor-exit v1
    :try_end_4
    .catchall {:try_start_4 .. :try_end_4} :catchall_2

    throw p0
.end method

.method private static render([BLlocal/mio/os4camerabridge/LegendaryNativeCaptureBridge$Capture;)[B
    .locals 13
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/lang/Exception;
        }
    .end annotation

    .line 104
    invoke-static {}, Landroid/os/SystemClock;->elapsedRealtime()J

    move-result-wide v0

    .line 105
    array-length v2, p0

    const/4 v3, 0x4

    if-lt v2, v3, :cond_8

    array-length v2, p0

    const/high16 v3, 0x2000000

    if-gt v2, v3, :cond_8

    .line 106
    invoke-static {}, Llocal/mio/os4camerabridge/LegendaryNativeCaptureBridge;->application()Landroid/app/Application;

    move-result-object v2

    .line 107
    const-string v3, "legend_source_"

    invoke-virtual {v2}, Landroid/app/Application;->getCacheDir()Ljava/io/File;

    move-result-object v4

    const-string v5, ".jpg"

    invoke-static {v3, v5, v4}, Ljava/io/File;->createTempFile(Ljava/lang/String;Ljava/lang/String;Ljava/io/File;)Ljava/io/File;

    move-result-object v3

    .line 108
    const-string v4, "legend_rendered_"

    invoke-virtual {v2}, Landroid/app/Application;->getCacheDir()Ljava/io/File;

    move-result-object v6

    invoke-static {v4, v5, v6}, Ljava/io/File;->createTempFile(Ljava/lang/String;Ljava/lang/String;Ljava/io/File;)Ljava/io/File;

    move-result-object v4

    .line 110
    :try_start_0
    new-instance v5, Ljava/io/FileOutputStream;

    invoke-direct {v5, v3}, Ljava/io/FileOutputStream;-><init>(Ljava/io/File;)V
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_6

    :try_start_1
    invoke-virtual {v5, p0}, Ljava/io/FileOutputStream;->write([B)V
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_4

    :try_start_2
    invoke-virtual {v5}, Ljava/io/FileOutputStream;->close()V

    .line 111
    const/high16 v5, 0x10000000

    invoke-static {v3, v5}, Landroid/os/ParcelFileDescriptor;->open(Ljava/io/File;I)Landroid/os/ParcelFileDescriptor;

    move-result-object v5
    :try_end_2
    .catchall {:try_start_2 .. :try_end_2} :catchall_6

    .line 112
    const/high16 v6, 0x34000000

    :try_start_3
    invoke-static {v4, v6}, Landroid/os/ParcelFileDescriptor;->open(Ljava/io/File;I)Landroid/os/ParcelFileDescriptor;

    move-result-object v6
    :try_end_3
    .catchall {:try_start_3 .. :try_end_3} :catchall_2

    .line 113
    :try_start_4
    new-instance v7, Landroid/os/Bundle;

    invoke-direct {v7}, Landroid/os/Bundle;-><init>()V

    .line 114
    const-string v8, "input"

    invoke-virtual {v7, v8, v5}, Landroid/os/Bundle;->putParcelable(Ljava/lang/String;Landroid/os/Parcelable;)V

    const-string v8, "output"

    invoke-virtual {v7, v8, v6}, Landroid/os/Bundle;->putParcelable(Ljava/lang/String;Landroid/os/Parcelable;)V

    .line 115
    const-string v8, "mode"

    iget v9, p1, Llocal/mio/os4camerabridge/LegendaryNativeCaptureBridge$Capture;->mode:I

    invoke-virtual {v7, v8, v9}, Landroid/os/Bundle;->putInt(Ljava/lang/String;I)V

    const-string v8, "lux"

    iget v9, p1, Llocal/mio/os4camerabridge/LegendaryNativeCaptureBridge$Capture;->lux:I

    invoke-virtual {v7, v8, v9}, Landroid/os/Bundle;->putInt(Ljava/lang/String;I)V

    const-string v8, "cct"

    iget v9, p1, Llocal/mio/os4camerabridge/LegendaryNativeCaptureBridge$Capture;->cct:I

    invoke-virtual {v7, v8, v9}, Landroid/os/Bundle;->putInt(Ljava/lang/String;I)V

    .line 116
    invoke-virtual {v2}, Landroid/app/Application;->getContentResolver()Landroid/content/ContentResolver;

    move-result-object v2

    sget-object v8, Llocal/mio/os4camerabridge/LegendaryProcessingProvider;->URI:Landroid/net/Uri;

    const-string v9, "render"

    const/4 v10, 0x0

    invoke-virtual {v2, v8, v9, v10, v7}, Landroid/content/ContentResolver;->call(Landroid/net/Uri;Ljava/lang/String;Ljava/lang/String;Landroid/os/Bundle;)Landroid/os/Bundle;

    move-result-object v2

    .line 117
    if-eqz v2, :cond_4

    const-string v7, "ok"

    invoke-virtual {v2, v7}, Landroid/os/Bundle;->getBoolean(Ljava/lang/String;)Z

    move-result v7

    if-nez v7, :cond_0

    goto/16 :goto_0

    .line 119
    :cond_0
    invoke-virtual {v4}, Ljava/io/File;->length()J

    move-result-wide v7

    const-string v9, "bytes"

    invoke-virtual {v2, v9}, Landroid/os/Bundle;->getLong(Ljava/lang/String;)J

    move-result-wide v11

    cmp-long v7, v7, v11

    if-nez v7, :cond_3

    invoke-virtual {v4}, Ljava/io/File;->length()J

    move-result-wide v7

    const-wide/16 v11, 0x4

    cmp-long v7, v7, v11

    if-ltz v7, :cond_3

    invoke-virtual {v4}, Ljava/io/File;->length()J

    move-result-wide v7

    const-wide/32 v11, 0x2000000

    cmp-long v7, v7, v11

    if-gtz v7, :cond_3

    .line 121
    invoke-virtual {v4}, Ljava/io/File;->toPath()Ljava/nio/file/Path;

    move-result-object v7

    invoke-static {v7}, Ljava/nio/file/Files;->readAllBytes(Ljava/nio/file/Path;)[B

    move-result-object v7

    .line 122
    sget-object v8, Llocal/mio/os4camerabridge/LegendaryNativeCaptureBridge;->transplant:Ljava/lang/reflect/Method;

    invoke-static {p0}, Llocal/mio/os4camerabridge/LegendaryJpegColorMetadata;->withoutSourceIcc([B)[B

    move-result-object p0

    filled-new-array {p0, v7}, [Ljava/lang/Object;

    move-result-object p0

    invoke-virtual {v8, v10, p0}, Ljava/lang/reflect/Method;->invoke(Ljava/lang/Object;[Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object p0

    check-cast p0, [B

    .line 123
    iget p1, p1, Llocal/mio/os4camerabridge/LegendaryNativeCaptureBridge$Capture;->mode:I

    const-string v7, "timing"

    invoke-virtual {v2, v7}, Landroid/os/Bundle;->getString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v2

    .line 124
    invoke-static {}, Landroid/os/SystemClock;->elapsedRealtime()J

    move-result-wide v7

    sub-long/2addr v7, v0

    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "timing mode="

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, p1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object p1

    const-string v0, " nativeProvider={"

    invoke-virtual {p1, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p1

    invoke-virtual {p1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p1

    const-string v0, "} callerTotal="

    invoke-virtual {p1, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p1

    invoke-virtual {p1, v7, v8}, Ljava/lang/StringBuilder;->append(J)Ljava/lang/StringBuilder;

    move-result-object p1

    const-string v0, " ms"

    invoke-virtual {p1, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p1

    invoke-virtual {p1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p1

    .line 123
    invoke-static {p1}, Llocal/mio/os4camerabridge/LegendaryNativeCaptureBridge;->log(Ljava/lang/String;)V
    :try_end_4
    .catchall {:try_start_4 .. :try_end_4} :catchall_0

    .line 125
    nop

    .line 126
    if-eqz v6, :cond_1

    :try_start_5
    invoke-virtual {v6}, Landroid/os/ParcelFileDescriptor;->close()V
    :try_end_5
    .catchall {:try_start_5 .. :try_end_5} :catchall_2

    :cond_1
    if-eqz v5, :cond_2

    :try_start_6
    invoke-virtual {v5}, Landroid/os/ParcelFileDescriptor;->close()V
    :try_end_6
    .catchall {:try_start_6 .. :try_end_6} :catchall_6

    .line 127
    :cond_2
    invoke-virtual {v3}, Ljava/io/File;->delete()Z

    invoke-virtual {v4}, Ljava/io/File;->delete()Z

    .line 125
    return-object p0

    .line 120
    :cond_3
    :try_start_7
    new-instance p0, Ljava/io/IOException;

    const-string p1, "Incomplete native output"

    invoke-direct {p0, p1}, Ljava/io/IOException;-><init>(Ljava/lang/String;)V

    throw p0

    .line 118
    :cond_4
    :goto_0
    new-instance p0, Ljava/io/IOException;

    if-nez v2, :cond_5

    const-string p1, "No render reply"

    goto :goto_1

    :cond_5
    const-string p1, "error"

    invoke-virtual {v2, p1}, Landroid/os/Bundle;->getString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object p1

    :goto_1
    invoke-direct {p0, p1}, Ljava/io/IOException;-><init>(Ljava/lang/String;)V

    throw p0
    :try_end_7
    .catchall {:try_start_7 .. :try_end_7} :catchall_0

    .line 111
    :catchall_0
    move-exception p0

    if-eqz v6, :cond_6

    :try_start_8
    invoke-virtual {v6}, Landroid/os/ParcelFileDescriptor;->close()V
    :try_end_8
    .catchall {:try_start_8 .. :try_end_8} :catchall_1

    goto :goto_2

    :catchall_1
    move-exception p1

    :try_start_9
    invoke-virtual {p0, p1}, Ljava/lang/Throwable;->addSuppressed(Ljava/lang/Throwable;)V

    :cond_6
    :goto_2
    throw p0
    :try_end_9
    .catchall {:try_start_9 .. :try_end_9} :catchall_2

    :catchall_2
    move-exception p0

    if-eqz v5, :cond_7

    :try_start_a
    invoke-virtual {v5}, Landroid/os/ParcelFileDescriptor;->close()V
    :try_end_a
    .catchall {:try_start_a .. :try_end_a} :catchall_3

    goto :goto_3

    :catchall_3
    move-exception p1

    :try_start_b
    invoke-virtual {p0, p1}, Ljava/lang/Throwable;->addSuppressed(Ljava/lang/Throwable;)V

    :cond_7
    :goto_3
    throw p0
    :try_end_b
    .catchall {:try_start_b .. :try_end_b} :catchall_6

    .line 110
    :catchall_4
    move-exception p0

    :try_start_c
    invoke-virtual {v5}, Ljava/io/FileOutputStream;->close()V
    :try_end_c
    .catchall {:try_start_c .. :try_end_c} :catchall_5

    goto :goto_4

    :catchall_5
    move-exception p1

    :try_start_d
    invoke-virtual {p0, p1}, Ljava/lang/Throwable;->addSuppressed(Ljava/lang/Throwable;)V

    :goto_4
    throw p0
    :try_end_d
    .catchall {:try_start_d .. :try_end_d} :catchall_6

    .line 127
    :catchall_6
    move-exception p0

    invoke-virtual {v3}, Ljava/io/File;->delete()Z

    invoke-virtual {v4}, Ljava/io/File;->delete()Z

    throw p0

    .line 105
    :cond_8
    new-instance p0, Ljava/io/IOException;

    const-string p1, "Primary size rejected"

    invoke-direct {p0, p1}, Ljava/io/IOException;-><init>(Ljava/lang/String;)V

    throw p0
.end method
