.class public final Llocal/mio/os4camerabridge/JpegWatermarkMetadataBridge;
.super Ljava/lang/Object;
.source "JpegWatermarkMetadataBridge.java"


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Llocal/mio/os4camerabridge/JpegWatermarkMetadataBridge$Pending;,
        Llocal/mio/os4camerabridge/JpegWatermarkMetadataBridge$Snapshot;
    }
.end annotation


# static fields
.field private static final EXTRA:Ljava/lang/String; = "local.mio.watermarkShootingMetadata"

.field private static final PENDING:Ljava/util/Map;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/Map<",
            "Ljava/lang/Object;",
            "Llocal/mio/os4camerabridge/JpegWatermarkMetadataBridge$Pending;",
            ">;"
        }
    .end annotation
.end field

.field private static installed:Z


# direct methods
.method static bridge synthetic -$$Nest$sfgetPENDING()Ljava/util/Map;
    .locals 1

    sget-object v0, Llocal/mio/os4camerabridge/JpegWatermarkMetadataBridge;->PENDING:Ljava/util/Map;

    return-object v0
.end method

.method static bridge synthetic -$$Nest$smfield(Ljava/lang/Object;Ljava/lang/String;)Ljava/lang/Object;
    .locals 0

    invoke-static {p0, p1}, Llocal/mio/os4camerabridge/JpegWatermarkMetadataBridge;->field(Ljava/lang/Object;Ljava/lang/String;)Ljava/lang/Object;

    move-result-object p0

    return-object p0
.end method

.method static bridge synthetic -$$Nest$smreport(Ljava/lang/String;Ljava/lang/Throwable;)V
    .locals 0

    invoke-static {p0, p1}, Llocal/mio/os4camerabridge/JpegWatermarkMetadataBridge;->report(Ljava/lang/String;Ljava/lang/Throwable;)V

    return-void
.end method

.method static constructor <clinit>()V
    .locals 1

    .line 22
    new-instance v0, Ljava/util/WeakHashMap;

    invoke-direct {v0}, Ljava/util/WeakHashMap;-><init>()V

    sput-object v0, Llocal/mio/os4camerabridge/JpegWatermarkMetadataBridge;->PENDING:Ljava/util/Map;

    return-void
.end method

.method private constructor <init>()V
    .locals 0

    .line 25
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method private static field(Ljava/lang/Object;Ljava/lang/String;)Ljava/lang/Object;
    .locals 0

    .line 165
    invoke-static {p0, p1}, Lde/robv/android/xposed/XposedHelpers;->getObjectField(Ljava/lang/Object;Ljava/lang/String;)Ljava/lang/Object;

    move-result-object p0

    return-object p0
.end method

.method public static declared-synchronized install(Ljava/lang/ClassLoader;)V
    .locals 14

    const-class v1, Llocal/mio/os4camerabridge/JpegWatermarkMetadataBridge;

    monitor-enter v1

    .line 28
    :try_start_0
    sget-boolean v0, Llocal/mio/os4camerabridge/JpegWatermarkMetadataBridge;->installed:Z
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_2

    if-eqz v0, :cond_0

    monitor-exit v1

    return-void

    .line 29
    :cond_0
    :try_start_1
    new-instance v2, Ljava/util/ArrayList;

    invoke-direct {v2}, Ljava/util/ArrayList;-><init>()V
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_2

    .line 31
    :try_start_2
    const-string v0, "Rh.r"

    invoke-static {v0, p0}, Lde/robv/android/xposed/XposedHelpers;->findClass(Ljava/lang/String;Ljava/lang/ClassLoader;)Ljava/lang/Class;

    move-result-object v0

    .line 32
    const-string v3, "p7.g"

    invoke-static {v3, p0}, Lde/robv/android/xposed/XposedHelpers;->findClass(Ljava/lang/String;Ljava/lang/ClassLoader;)Ljava/lang/Class;

    move-result-object v3

    .line 33
    const-string v4, "rf.b"

    invoke-static {v4, p0}, Lde/robv/android/xposed/XposedHelpers;->findClass(Ljava/lang/String;Ljava/lang/ClassLoader;)Ljava/lang/Class;

    move-result-object v4

    .line 34
    const-string v5, "p7.c"

    invoke-static {v5, p0}, Lde/robv/android/xposed/XposedHelpers;->findClass(Ljava/lang/String;Ljava/lang/ClassLoader;)Ljava/lang/Class;

    move-result-object p0

    .line 35
    const-string v5, "a"

    filled-new-array {v0}, [Ljava/lang/Class;

    move-result-object v6

    invoke-virtual {v3, v5, v6}, Ljava/lang/Class;->getDeclaredMethod(Ljava/lang/String;[Ljava/lang/Class;)Ljava/lang/reflect/Method;

    move-result-object v3

    .line 36
    const-string v5, "a"

    filled-new-array {v0}, [Ljava/lang/Class;

    move-result-object v6

    invoke-virtual {p0, v5, v6}, Ljava/lang/Class;->getDeclaredMethod(Ljava/lang/String;[Ljava/lang/Class;)Ljava/lang/reflect/Method;

    move-result-object p0

    .line 37
    const-string v5, "e"

    const-class v6, [B

    filled-new-array {v6}, [Ljava/lang/Class;

    move-result-object v6

    invoke-virtual {v0, v5, v6}, Ljava/lang/Class;->getDeclaredMethod(Ljava/lang/String;[Ljava/lang/Class;)Ljava/lang/reflect/Method;

    move-result-object v9

    .line 38
    const-string v0, "e"

    const-class v5, Ljava/lang/String;

    filled-new-array {v5}, [Ljava/lang/Class;

    move-result-object v5

    invoke-virtual {v4, v0, v5}, Ljava/lang/Class;->getDeclaredMethod(Ljava/lang/String;[Ljava/lang/Class;)Ljava/lang/reflect/Method;

    move-result-object v10

    .line 39
    const-string v0, "i"

    const-class v5, Ljava/lang/String;

    filled-new-array {v5}, [Ljava/lang/Class;

    move-result-object v5

    invoke-virtual {v4, v0, v5}, Ljava/lang/Class;->getDeclaredMethod(Ljava/lang/String;[Ljava/lang/Class;)Ljava/lang/reflect/Method;

    move-result-object v12

    .line 40
    invoke-virtual {v12}, Ljava/lang/reflect/Method;->getReturnType()Ljava/lang/Class;

    move-result-object v0

    const-string v5, "l"

    const-class v6, Ljava/nio/ByteOrder;

    filled-new-array {v6}, [Ljava/lang/Class;

    move-result-object v6

    invoke-virtual {v0, v5, v6}, Ljava/lang/Class;->getDeclaredMethod(Ljava/lang/String;[Ljava/lang/Class;)Ljava/lang/reflect/Method;

    move-result-object v13

    .line 41
    const-string v0, "R"

    const-class v5, Ljava/lang/String;

    const-class v6, Ljava/lang/String;

    filled-new-array {v5, v6}, [Ljava/lang/Class;

    move-result-object v5

    invoke-virtual {v4, v0, v5}, Ljava/lang/Class;->getDeclaredMethod(Ljava/lang/String;[Ljava/lang/Class;)Ljava/lang/reflect/Method;

    move-result-object v11

    .line 42
    const-class v0, Ljava/io/InputStream;

    filled-new-array {v0}, [Ljava/lang/Class;

    move-result-object v0

    invoke-virtual {v4, v0}, Ljava/lang/Class;->getConstructor([Ljava/lang/Class;)Ljava/lang/reflect/Constructor;

    move-result-object v0

    .line 43
    invoke-virtual {v9}, Ljava/lang/reflect/Method;->getReturnType()Ljava/lang/Class;

    move-result-object v5

    if-ne v5, v4, :cond_1

    invoke-virtual {v10}, Ljava/lang/reflect/Method;->getReturnType()Ljava/lang/Class;

    move-result-object v4

    const-class v5, Ljava/lang/String;

    if-ne v4, v5, :cond_1

    .line 44
    invoke-virtual {v11}, Ljava/lang/reflect/Method;->getReturnType()Ljava/lang/Class;

    move-result-object v4

    sget-object v5, Ljava/lang/Void;->TYPE:Ljava/lang/Class;

    if-ne v4, v5, :cond_1

    .line 46
    new-instance v4, Llocal/mio/os4camerabridge/JpegWatermarkMetadataBridge$1;

    const/16 v5, 0x2328

    invoke-direct {v4, v5, v0, v12, v13}, Llocal/mio/os4camerabridge/JpegWatermarkMetadataBridge$1;-><init>(ILjava/lang/reflect/Constructor;Ljava/lang/reflect/Method;Ljava/lang/reflect/Method;)V

    invoke-static {v3, v4}, Lde/robv/android/xposed/XposedBridge;->hookMethod(Ljava/lang/reflect/Member;Lde/robv/android/xposed/XC_MethodHook;)Lde/robv/android/xposed/XC_MethodHook$Unhook;

    move-result-object v0

    invoke-interface {v2, v0}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    .line 108
    new-instance v7, Llocal/mio/os4camerabridge/JpegWatermarkMetadataBridge$2;

    const/16 v8, 0x2328

    invoke-direct/range {v7 .. v13}, Llocal/mio/os4camerabridge/JpegWatermarkMetadataBridge$2;-><init>(ILjava/lang/reflect/Method;Ljava/lang/reflect/Method;Ljava/lang/reflect/Method;Ljava/lang/reflect/Method;Ljava/lang/reflect/Method;)V

    invoke-static {p0, v7}, Lde/robv/android/xposed/XposedBridge;->hookMethod(Ljava/lang/reflect/Member;Lde/robv/android/xposed/XC_MethodHook;)Lde/robv/android/xposed/XC_MethodHook$Unhook;

    move-result-object p0

    invoke-interface {v2, p0}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    .line 154
    const/4 p0, 0x1

    sput-boolean p0, Llocal/mio/os4camerabridge/JpegWatermarkMetadataBridge;->installed:Z

    .line 155
    const-string p0, "[WatermarkMetadata] installed182 metadata-v5; exact source rationals after Effect; rear Photo/Pro legacy JPEG only"

    invoke-static {p0}, Lde/robv/android/xposed/XposedBridge;->log(Ljava/lang/String;)V

    .line 161
    goto :goto_2

    .line 45
    :cond_1
    new-instance p0, Ljava/lang/IllegalStateException;

    const-string v0, "Unexpected Xiaomi EXIF contract"

    invoke-direct {p0, v0}, Ljava/lang/IllegalStateException;-><init>(Ljava/lang/String;)V

    throw p0
    :try_end_2
    .catchall {:try_start_2 .. :try_end_2} :catchall_0

    .line 156
    :catchall_0
    move-exception v0

    move-object p0, v0

    .line 157
    :try_start_3
    invoke-interface {v2}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object v2

    :goto_0
    invoke-interface {v2}, Ljava/util/Iterator;->hasNext()Z

    move-result v0

    if-eqz v0, :cond_2

    invoke-interface {v2}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lde/robv/android/xposed/XC_MethodHook$Unhook;
    :try_end_3
    .catchall {:try_start_3 .. :try_end_3} :catchall_2

    .line 158
    :try_start_4
    invoke-virtual {v0}, Lde/robv/android/xposed/XC_MethodHook$Unhook;->unhook()V
    :try_end_4
    .catchall {:try_start_4 .. :try_end_4} :catchall_1

    goto :goto_1

    :catchall_1
    move-exception v0

    .line 159
    :goto_1
    goto :goto_0

    .line 160
    :cond_2
    :try_start_5
    const-string v0, "install rejected"

    invoke-static {v0, p0}, Llocal/mio/os4camerabridge/JpegWatermarkMetadataBridge;->report(Ljava/lang/String;Ljava/lang/Throwable;)V
    :try_end_5
    .catchall {:try_start_5 .. :try_end_5} :catchall_2

    .line 162
    :goto_2
    monitor-exit v1

    return-void

    .line 27
    :catchall_2
    move-exception v0

    move-object p0, v0

    :try_start_6
    monitor-exit v1
    :try_end_6
    .catchall {:try_start_6 .. :try_end_6} :catchall_2

    throw p0
.end method

.method private static report(Ljava/lang/String;Ljava/lang/Throwable;)V
    .locals 2

    .line 169
    invoke-static {p1}, Ljava/lang/String;->valueOf(Ljava/lang/Object;)Ljava/lang/String;

    move-result-object p1

    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "[WatermarkMetadata] "

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, p0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p0

    const-string v0, ": "

    invoke-virtual {p0, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p0

    invoke-virtual {p0, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p0

    invoke-virtual {p0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p0

    invoke-static {p0}, Lde/robv/android/xposed/XposedBridge;->log(Ljava/lang/String;)V

    .line 170
    return-void
.end method
