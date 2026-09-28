.class public final Llocal/mio/os4camerabridge/LegendaryCalibrationBridge;
.super Ljava/lang/Object;
.source "LegendaryCalibrationBridge.java"


# static fields
.field private static final CCT:Ljava/lang/ThreadLocal;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/lang/ThreadLocal<",
            "Ljava/lang/Integer;",
            ">;"
        }
    .end annotation
.end field

.field private static installed:Z


# direct methods
.method static bridge synthetic -$$Nest$sfgetCCT()Ljava/lang/ThreadLocal;
    .locals 1

    sget-object v0, Llocal/mio/os4camerabridge/LegendaryCalibrationBridge;->CCT:Ljava/lang/ThreadLocal;

    return-object v0
.end method

.method static constructor <clinit>()V
    .locals 1

    .line 10
    new-instance v0, Ljava/lang/ThreadLocal;

    invoke-direct {v0}, Ljava/lang/ThreadLocal;-><init>()V

    sput-object v0, Llocal/mio/os4camerabridge/LegendaryCalibrationBridge;->CCT:Ljava/lang/ThreadLocal;

    return-void
.end method

.method private constructor <init>()V
    .locals 0

    .line 12
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method static declared-synchronized install()V
    .locals 9
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/lang/Exception;
        }
    .end annotation

    const-class v0, Llocal/mio/os4camerabridge/LegendaryCalibrationBridge;

    monitor-enter v0

    .line 14
    :try_start_0
    sget-boolean v1, Llocal/mio/os4camerabridge/LegendaryCalibrationBridge;->installed:Z
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    if-eqz v1, :cond_0

    monitor-exit v0

    return-void

    .line 15
    :cond_0
    :try_start_1
    const-class v1, Llocal/mio/os4camerabridge/LegendaryCalibrationBridge;

    invoke-virtual {v1}, Ljava/lang/Class;->getClassLoader()Ljava/lang/ClassLoader;

    move-result-object v1

    .line 16
    const-string v2, "local.mio.os4camerabridge.LegendM9Container"

    const/4 v3, 0x0

    invoke-static {v2, v3, v1}, Ljava/lang/Class;->forName(Ljava/lang/String;ZLjava/lang/ClassLoader;)Ljava/lang/Class;

    move-result-object v2

    .line 17
    const-string v4, "local.mio.os4camerabridge.LegendM9Container$Metadata"

    invoke-static {v4, v3, v1}, Ljava/lang/Class;->forName(Ljava/lang/String;ZLjava/lang/ClassLoader;)Ljava/lang/Class;

    move-result-object v1

    .line 18
    const-string v3, "wrap"

    const-class v4, [B

    const-class v5, [B

    const-class v6, [F

    const-class v7, Ljava/lang/String;

    filled-new-array {v4, v5, v6, v7, v1}, [Ljava/lang/Class;

    move-result-object v1

    invoke-virtual {v2, v3, v1}, Ljava/lang/Class;->getDeclaredMethod(Ljava/lang/String;[Ljava/lang/Class;)Ljava/lang/reflect/Method;

    move-result-object v1
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    .line 20
    :try_start_2
    const-string v3, "packToCloudBggr"

    const-class v4, [B

    sget-object v5, Ljava/lang/Integer;->TYPE:Ljava/lang/Class;

    sget-object v6, Ljava/lang/Integer;->TYPE:Ljava/lang/Class;

    const-class v7, Ljava/lang/String;

    sget-object v8, Ljava/lang/Integer;->TYPE:Ljava/lang/Class;

    filled-new-array {v4, v5, v6, v7, v8}, [Ljava/lang/Class;

    move-result-object v4

    invoke-virtual {v2, v3, v4}, Ljava/lang/Class;->getDeclaredMethod(Ljava/lang/String;[Ljava/lang/Class;)Ljava/lang/reflect/Method;

    move-result-object v3
    :try_end_2
    .catch Ljava/lang/NoSuchMethodException; {:try_start_2 .. :try_end_2} :catch_0
    .catchall {:try_start_2 .. :try_end_2} :catchall_0

    .line 24
    goto :goto_0

    .line 21
    :catch_0
    move-exception v3

    .line 23
    :try_start_3
    const-string v3, "packRggbToCloudBggr"

    const-class v4, [B

    sget-object v5, Ljava/lang/Integer;->TYPE:Ljava/lang/Class;

    sget-object v6, Ljava/lang/Integer;->TYPE:Ljava/lang/Class;

    const-class v7, Ljava/lang/String;

    filled-new-array {v4, v5, v6, v7}, [Ljava/lang/Class;

    move-result-object v4

    invoke-virtual {v2, v3, v4}, Ljava/lang/Class;->getDeclaredMethod(Ljava/lang/String;[Ljava/lang/Class;)Ljava/lang/reflect/Method;

    move-result-object v3

    .line 25
    :goto_0
    const-string v4, "rc4XorInPlace"

    const-class v5, [B

    const-class v6, Ljava/lang/String;

    filled-new-array {v5, v6}, [Ljava/lang/Class;

    move-result-object v5

    invoke-virtual {v2, v4, v5}, Ljava/lang/Class;->getDeclaredMethod(Ljava/lang/String;[Ljava/lang/Class;)Ljava/lang/reflect/Method;

    move-result-object v2

    .line 26
    const/4 v4, 0x1

    invoke-virtual {v2, v4}, Ljava/lang/reflect/Method;->setAccessible(Z)V

    .line 27
    new-instance v5, Llocal/mio/os4camerabridge/LegendaryCalibrationBridge$1;

    invoke-direct {v5}, Llocal/mio/os4camerabridge/LegendaryCalibrationBridge$1;-><init>()V

    invoke-static {v1, v5}, Lde/robv/android/xposed/XposedBridge;->hookMethod(Ljava/lang/reflect/Member;Lde/robv/android/xposed/XC_MethodHook;)Lde/robv/android/xposed/XC_MethodHook$Unhook;

    .line 35
    new-instance v1, Llocal/mio/os4camerabridge/LegendaryCalibrationBridge$2;

    invoke-direct {v1, v2}, Llocal/mio/os4camerabridge/LegendaryCalibrationBridge$2;-><init>(Ljava/lang/reflect/Method;)V

    invoke-static {v3, v1}, Lde/robv/android/xposed/XposedBridge;->hookMethod(Ljava/lang/reflect/Member;Lde/robv/android/xposed/XC_MethodHook;)Lde/robv/android/xposed/XC_MethodHook$Unhook;

    .line 56
    sput-boolean v4, Llocal/mio/os4camerabridge/LegendaryCalibrationBridge;->installed:Z
    :try_end_3
    .catchall {:try_start_3 .. :try_end_3} :catchall_0

    .line 57
    monitor-exit v0

    return-void

    .line 13
    :catchall_0
    move-exception v1

    :try_start_4
    monitor-exit v0
    :try_end_4
    .catchall {:try_start_4 .. :try_end_4} :catchall_0

    throw v1
.end method
