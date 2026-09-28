.class public final Llocal/mio/os4camerabridge/LegendaryM9FrameContractBridge;
.super Ljava/lang/Object;
.source "LegendaryM9FrameContractBridge.java"


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Llocal/mio/os4camerabridge/LegendaryM9FrameContractBridge$Frame;
    }
.end annotation


# static fields
.field private static final FRAMES:Ljava/util/Map;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/Map<",
            "Ljava/lang/Object;",
            "Llocal/mio/os4camerabridge/LegendaryM9FrameContractBridge$Frame;",
            ">;"
        }
    .end annotation
.end field


# direct methods
.method static bridge synthetic -$$Nest$sfgetFRAMES()Ljava/util/Map;
    .locals 1

    sget-object v0, Llocal/mio/os4camerabridge/LegendaryM9FrameContractBridge;->FRAMES:Ljava/util/Map;

    return-object v0
.end method

.method static bridge synthetic -$$Nest$smlog(Ljava/lang/String;)V
    .locals 0

    invoke-static {p0}, Llocal/mio/os4camerabridge/LegendaryM9FrameContractBridge;->log(Ljava/lang/String;)V

    return-void
.end method

.method static constructor <clinit>()V
    .locals 1

    .line 16
    new-instance v0, Ljava/util/WeakHashMap;

    invoke-direct {v0}, Ljava/util/WeakHashMap;-><init>()V

    invoke-static {v0}, Ljava/util/Collections;->synchronizedMap(Ljava/util/Map;)Ljava/util/Map;

    move-result-object v0

    sput-object v0, Llocal/mio/os4camerabridge/LegendaryM9FrameContractBridge;->FRAMES:Ljava/util/Map;

    return-void
.end method

.method private constructor <init>()V
    .locals 0

    .line 17
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method public static install()V
    .locals 5

    .line 20
    :try_start_0
    const-class v0, Llocal/mio/os4camerabridge/LegendaryM9FrameContractBridge;

    invoke-virtual {v0}, Ljava/lang/Class;->getClassLoader()Ljava/lang/ClassLoader;

    move-result-object v0

    .line 21
    const-string v1, "local.mio.os4camerabridge.HookEntry"

    const/4 v2, 0x0

    invoke-static {v1, v2, v0}, Ljava/lang/Class;->forName(Ljava/lang/String;ZLjava/lang/ClassLoader;)Ljava/lang/Class;

    move-result-object v1

    .line 22
    const-string v3, "rearMainPhysicalCameraId"

    invoke-virtual {v1, v3}, Ljava/lang/Class;->getDeclaredField(Ljava/lang/String;)Ljava/lang/reflect/Field;

    move-result-object v3

    .line 23
    const/4 v4, 0x1

    invoke-virtual {v3, v4}, Ljava/lang/reflect/Field;->setAccessible(Z)V

    .line 24
    const-string v4, "local.mio.os4camerabridge.LegendM9Container"

    invoke-static {v4, v2, v0}, Ljava/lang/Class;->forName(Ljava/lang/String;ZLjava/lang/ClassLoader;)Ljava/lang/Class;

    move-result-object v0

    .line 25
    const-string v2, "legendMetadata"

    new-instance v4, Llocal/mio/os4camerabridge/LegendaryM9FrameContractBridge$1;

    invoke-direct {v4, v3}, Llocal/mio/os4camerabridge/LegendaryM9FrameContractBridge$1;-><init>(Ljava/lang/reflect/Field;)V

    invoke-static {v1, v2, v4}, Lde/robv/android/xposed/XposedBridge;->hookAllMethods(Ljava/lang/Class;Ljava/lang/String;Lde/robv/android/xposed/XC_MethodHook;)Ljava/util/Set;

    .line 52
    const-string v1, "buildMessage"

    new-instance v2, Llocal/mio/os4camerabridge/LegendaryM9FrameContractBridge$2;

    invoke-direct {v2}, Llocal/mio/os4camerabridge/LegendaryM9FrameContractBridge$2;-><init>()V

    invoke-static {v0, v1, v2}, Lde/robv/android/xposed/XposedBridge;->hookAllMethods(Ljava/lang/Class;Ljava/lang/String;Lde/robv/android/xposed/XC_MethodHook;)Ljava/util/Set;

    .line 67
    const-string v0, "same-frame main1x metadata experiment bound; no JPEG/RAW manipulation"

    invoke-static {v0}, Llocal/mio/os4camerabridge/LegendaryM9FrameContractBridge;->log(Ljava/lang/String;)V
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 68
    goto :goto_0

    :catchall_0
    move-exception v0

    invoke-static {v0}, Ljava/lang/String;->valueOf(Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v0

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "binding refused: "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Llocal/mio/os4camerabridge/LegendaryM9FrameContractBridge;->log(Ljava/lang/String;)V

    .line 69
    :goto_0
    return-void
.end method

.method private static log(Ljava/lang/String;)V
    .locals 2

    .line 70
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "[LegendaryFrameContract] "

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, p0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p0

    invoke-virtual {p0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p0

    invoke-static {p0}, Lde/robv/android/xposed/XposedBridge;->log(Ljava/lang/String;)V

    return-void
.end method
