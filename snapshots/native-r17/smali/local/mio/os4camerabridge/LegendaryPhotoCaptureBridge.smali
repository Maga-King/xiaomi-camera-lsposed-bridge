.class public final Llocal/mio/os4camerabridge/LegendaryPhotoCaptureBridge;
.super Ljava/lang/Object;
.source "LegendaryPhotoCaptureBridge.java"


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Llocal/mio/os4camerabridge/LegendaryPhotoCaptureBridge$Reference;
    }
.end annotation


# static fields
.field private static basename:Ljava/lang/reflect/Method;

.field private static entry:Ljava/lang/Class;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/lang/Class<",
            "*>;"
        }
    .end annotation
.end field

.field private static installed:Z

.field private static metadata:Ljava/lang/reflect/Method;

.field private static final references:Ljava/util/Map;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/Map<",
            "Ljava/lang/Long;",
            "Llocal/mio/os4camerabridge/LegendaryPhotoCaptureBridge$Reference;",
            ">;"
        }
    .end annotation
.end field

.field private static shading:Ljava/lang/reflect/Method;

.field private static wrap:Ljava/lang/reflect/Method;

.field private static zoomData:Ljava/lang/Class;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/lang/Class<",
            "*>;"
        }
    .end annotation
.end field


# direct methods
.method static bridge synthetic -$$Nest$smactive()Z
    .locals 1

    invoke-static {}, Llocal/mio/os4camerabridge/LegendaryPhotoCaptureBridge;->active()Z

    move-result v0

    return v0
.end method

.method static bridge synthetic -$$Nest$smlog(Ljava/lang/String;)V
    .locals 0

    invoke-static {p0}, Llocal/mio/os4camerabridge/LegendaryPhotoCaptureBridge;->log(Ljava/lang/String;)V

    return-void
.end method

.method static bridge synthetic -$$Nest$smmainRatio(F)Z
    .locals 0

    invoke-static {p0}, Llocal/mio/os4camerabridge/LegendaryPhotoCaptureBridge;->mainRatio(F)Z

    move-result p0

    return p0
.end method

.method static bridge synthetic -$$Nest$smmainSelected()Z
    .locals 1

    invoke-static {}, Llocal/mio/os4camerabridge/LegendaryPhotoCaptureBridge;->mainSelected()Z

    move-result v0

    return v0
.end method

.method static bridge synthetic -$$Nest$smretain()V
    .locals 0

    invoke-static {}, Llocal/mio/os4camerabridge/LegendaryPhotoCaptureBridge;->retain()V

    return-void
.end method

.method static bridge synthetic -$$Nest$smsave(Ljava/lang/Object;)Z
    .locals 0

    invoke-static {p0}, Llocal/mio/os4camerabridge/LegendaryPhotoCaptureBridge;->save(Ljava/lang/Object;)Z

    move-result p0

    return p0
.end method

.method static constructor <clinit>()V
    .locals 1

    .line 21
    new-instance v0, Ljava/util/LinkedHashMap;

    invoke-direct {v0}, Ljava/util/LinkedHashMap;-><init>()V

    sput-object v0, Llocal/mio/os4camerabridge/LegendaryPhotoCaptureBridge;->references:Ljava/util/Map;

    return-void
.end method

.method private constructor <init>()V
    .locals 0

    .line 23
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method private static accessible(Ljava/lang/reflect/Method;)Ljava/lang/reflect/Method;
    .locals 1

    .line 197
    const/4 v0, 0x1

    invoke-virtual {p0, v0}, Ljava/lang/reflect/Method;->setAccessible(Z)V

    return-object p0
.end method

.method private static active()Z
    .locals 3

    .line 115
    sget-boolean v0, Llocal/mio/os4camerabridge/LegendaryPhotoCaptureBridge;->installed:Z

    if-eqz v0, :cond_1

    sget-object v0, Llocal/mio/os4camerabridge/LegendaryPhotoCaptureBridge;->entry:Ljava/lang/Class;

    const-string v1, "activeCameraModule"

    invoke-static {v0, v1}, Lde/robv/android/xposed/XposedHelpers;->getStaticIntField(Ljava/lang/Class;Ljava/lang/String;)I

    move-result v0

    const/16 v1, 0x100

    if-ne v0, v1, :cond_1

    sget-object v0, Llocal/mio/os4camerabridge/LegendaryPhotoCaptureBridge;->entry:Ljava/lang/Class;

    .line 116
    const-string v1, "activeLegendMode"

    invoke-static {v0, v1}, Lde/robv/android/xposed/XposedHelpers;->getStaticIntField(Ljava/lang/Class;Ljava/lang/String;)I

    move-result v0

    const/4 v2, 0x1

    if-eq v0, v2, :cond_0

    sget-object v0, Llocal/mio/os4camerabridge/LegendaryPhotoCaptureBridge;->entry:Ljava/lang/Class;

    .line 117
    invoke-static {v0, v1}, Lde/robv/android/xposed/XposedHelpers;->getStaticIntField(Ljava/lang/Class;Ljava/lang/String;)I

    move-result v0

    const/4 v1, 0x2

    if-ne v0, v1, :cond_1

    :cond_0
    sget-object v0, Llocal/mio/os4camerabridge/LegendaryPhotoCaptureBridge;->entry:Ljava/lang/Class;

    .line 118
    const-string v1, "activeCameraId"

    invoke-static {v0, v1}, Lde/robv/android/xposed/XposedHelpers;->getStaticIntField(Ljava/lang/Class;Ljava/lang/String;)I

    move-result v0

    if-nez v0, :cond_1

    sget-object v0, Llocal/mio/os4camerabridge/LegendaryPhotoCaptureBridge;->entry:Ljava/lang/Class;

    .line 119
    const-string v1, "commonApsUnifiedSessionActive"

    invoke-static {v0, v1}, Lde/robv/android/xposed/XposedHelpers;->getStaticBooleanField(Ljava/lang/Class;Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_1

    goto :goto_0

    :cond_1
    const/4 v2, 0x0

    .line 115
    :goto_0
    return v2
.end method

.method public static declared-synchronized install(Ljava/lang/ClassLoader;)V
    .locals 16

    move-object/from16 v0, p0

    const-class v1, Llocal/mio/os4camerabridge/LegendaryPhotoCaptureBridge;

    monitor-enter v1

    .line 26
    :try_start_0
    sget-boolean v2, Llocal/mio/os4camerabridge/LegendaryPhotoCaptureBridge;->installed:Z
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_1

    if-eqz v2, :cond_0

    monitor-exit v1

    return-void

    .line 27
    :cond_0
    :try_start_1
    new-instance v2, Ljava/util/ArrayList;

    invoke-direct {v2}, Ljava/util/ArrayList;-><init>()V
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_1

    .line 29
    :try_start_2
    const-class v3, Llocal/mio/os4camerabridge/LegendaryPhotoCaptureBridge;

    invoke-virtual {v3}, Ljava/lang/Class;->getClassLoader()Ljava/lang/ClassLoader;

    move-result-object v3

    .line 30
    const-string v4, "local.mio.os4camerabridge.HookEntry"

    const/4 v5, 0x0

    invoke-static {v4, v5, v3}, Ljava/lang/Class;->forName(Ljava/lang/String;ZLjava/lang/ClassLoader;)Ljava/lang/Class;

    move-result-object v4

    sput-object v4, Llocal/mio/os4camerabridge/LegendaryPhotoCaptureBridge;->entry:Ljava/lang/Class;

    .line 31
    const-string v4, "local.mio.os4camerabridge.LegendM9Container"

    invoke-static {v4, v5, v3}, Ljava/lang/Class;->forName(Ljava/lang/String;ZLjava/lang/ClassLoader;)Ljava/lang/Class;

    move-result-object v4

    .line 32
    const-string v6, "local.mio.os4camerabridge.LegendM9Container$Metadata"

    invoke-static {v6, v5, v3}, Ljava/lang/Class;->forName(Ljava/lang/String;ZLjava/lang/ClassLoader;)Ljava/lang/Class;

    move-result-object v6

    .line 33
    const-string v7, "com.android.camera.data.data.i"

    invoke-static {v7, v0}, Lde/robv/android/xposed/XposedHelpers;->findClass(Ljava/lang/String;Ljava/lang/ClassLoader;)Ljava/lang/Class;

    move-result-object v7

    sput-object v7, Llocal/mio/os4camerabridge/LegendaryPhotoCaptureBridge;->zoomData:Ljava/lang/Class;

    .line 34
    const-string v7, "B2.c"

    invoke-static {v7, v0}, Lde/robv/android/xposed/XposedHelpers;->findClass(Ljava/lang/String;Ljava/lang/ClassLoader;)Ljava/lang/Class;

    move-result-object v0

    const-string v7, "c"

    sget-object v8, Ljava/lang/Integer;->TYPE:Ljava/lang/Class;

    sget-object v9, Ljava/lang/Integer;->TYPE:Ljava/lang/Class;

    sget-object v10, Ljava/lang/Boolean;->TYPE:Ljava/lang/Class;

    filled-new-array {v8, v9, v10}, [Ljava/lang/Class;

    move-result-object v8

    invoke-virtual {v0, v7, v8}, Ljava/lang/Class;->getDeclaredMethod(Ljava/lang/String;[Ljava/lang/Class;)Ljava/lang/reflect/Method;

    move-result-object v0

    .line 35
    invoke-virtual {v0}, Ljava/lang/reflect/Method;->getReturnType()Ljava/lang/Class;

    move-result-object v7

    sget-object v8, Ljava/lang/Integer;->TYPE:Ljava/lang/Class;

    if-ne v7, v8, :cond_1

    .line 36
    sget-object v7, Llocal/mio/os4camerabridge/LegendaryPhotoCaptureBridge;->entry:Ljava/lang/Class;

    const-string v8, "isRearClarityModule"

    sget-object v9, Ljava/lang/Integer;->TYPE:Ljava/lang/Class;

    filled-new-array {v9}, [Ljava/lang/Class;

    move-result-object v9

    invoke-virtual {v7, v8, v9}, Ljava/lang/Class;->getDeclaredMethod(Ljava/lang/String;[Ljava/lang/Class;)Ljava/lang/reflect/Method;

    move-result-object v7

    .line 37
    sget-object v8, Llocal/mio/os4camerabridge/LegendaryPhotoCaptureBridge;->entry:Ljava/lang/Class;

    const-string v9, "supportsLegendRawSensor"

    sget-object v10, Ljava/lang/Integer;->TYPE:Ljava/lang/Class;

    filled-new-array {v10}, [Ljava/lang/Class;

    move-result-object v10

    invoke-virtual {v8, v9, v10}, Ljava/lang/Class;->getDeclaredMethod(Ljava/lang/String;[Ljava/lang/Class;)Ljava/lang/reflect/Method;

    move-result-object v8

    .line 38
    sget-object v9, Llocal/mio/os4camerabridge/LegendaryPhotoCaptureBridge;->entry:Ljava/lang/Class;

    const-string v10, "submitCommonApsFrames"

    new-array v11, v5, [Ljava/lang/Class;

    invoke-virtual {v9, v10, v11}, Ljava/lang/Class;->getDeclaredMethod(Ljava/lang/String;[Ljava/lang/Class;)Ljava/lang/reflect/Method;

    move-result-object v9

    .line 39
    sget-object v10, Llocal/mio/os4camerabridge/LegendaryPhotoCaptureBridge;->entry:Ljava/lang/Class;

    const-string v11, "tagLegendaryStoreTask"

    const-class v12, Ljava/lang/Object;

    sget-object v13, Ljava/lang/Integer;->TYPE:Ljava/lang/Class;

    filled-new-array {v12, v13}, [Ljava/lang/Class;

    move-result-object v12

    invoke-virtual {v10, v11, v12}, Ljava/lang/Class;->getDeclaredMethod(Ljava/lang/String;[Ljava/lang/Class;)Ljava/lang/reflect/Method;

    move-result-object v10

    .line 41
    const-string v11, "local.mio.os4camerabridge.HookEntry$47"

    invoke-static {v11, v5, v3}, Ljava/lang/Class;->forName(Ljava/lang/String;ZLjava/lang/ClassLoader;)Ljava/lang/Class;

    move-result-object v11

    .line 42
    const-string v12, "beforeHookedMethod"

    const-class v13, Lde/robv/android/xposed/XC_MethodHook$MethodHookParam;

    filled-new-array {v13}, [Ljava/lang/Class;

    move-result-object v13

    invoke-virtual {v11, v12, v13}, Ljava/lang/Class;->getDeclaredMethod(Ljava/lang/String;[Ljava/lang/Class;)Ljava/lang/reflect/Method;

    move-result-object v11

    .line 43
    const-string v12, "wrap"

    const-class v13, [B

    const-class v14, [B

    const-class v15, [F

    const-class v5, Ljava/lang/String;

    filled-new-array {v13, v14, v15, v5, v6}, [Ljava/lang/Class;

    move-result-object v5

    invoke-virtual {v4, v12, v5}, Ljava/lang/Class;->getDeclaredMethod(Ljava/lang/String;[Ljava/lang/Class;)Ljava/lang/reflect/Method;

    move-result-object v4

    invoke-static {v4}, Llocal/mio/os4camerabridge/LegendaryPhotoCaptureBridge;->accessible(Ljava/lang/reflect/Method;)Ljava/lang/reflect/Method;

    move-result-object v4

    sput-object v4, Llocal/mio/os4camerabridge/LegendaryPhotoCaptureBridge;->wrap:Ljava/lang/reflect/Method;

    .line 44
    sget-object v4, Llocal/mio/os4camerabridge/LegendaryPhotoCaptureBridge;->entry:Ljava/lang/Class;

    const-string v5, "legendMetadata"

    const-class v6, Landroid/hardware/camera2/CaptureResult;

    const-class v12, Landroid/hardware/camera2/CaptureResult;

    sget-object v13, Ljava/lang/Integer;->TYPE:Ljava/lang/Class;

    sget-object v14, Ljava/lang/Integer;->TYPE:Ljava/lang/Class;

    filled-new-array {v6, v12, v13, v14}, [Ljava/lang/Class;

    move-result-object v6

    invoke-virtual {v4, v5, v6}, Ljava/lang/Class;->getDeclaredMethod(Ljava/lang/String;[Ljava/lang/Class;)Ljava/lang/reflect/Method;

    move-result-object v4

    invoke-static {v4}, Llocal/mio/os4camerabridge/LegendaryPhotoCaptureBridge;->accessible(Ljava/lang/reflect/Method;)Ljava/lang/reflect/Method;

    move-result-object v4

    sput-object v4, Llocal/mio/os4camerabridge/LegendaryPhotoCaptureBridge;->metadata:Ljava/lang/reflect/Method;

    .line 45
    sget-object v4, Llocal/mio/os4camerabridge/LegendaryPhotoCaptureBridge;->entry:Ljava/lang/Class;

    const-string v5, "legendLensShadingMap"

    const-class v6, Landroid/hardware/camera2/CaptureResult;

    const-class v12, Landroid/hardware/camera2/CaptureResult;

    filled-new-array {v6, v12}, [Ljava/lang/Class;

    move-result-object v6

    invoke-virtual {v4, v5, v6}, Ljava/lang/Class;->getDeclaredMethod(Ljava/lang/String;[Ljava/lang/Class;)Ljava/lang/reflect/Method;

    move-result-object v4

    invoke-static {v4}, Llocal/mio/os4camerabridge/LegendaryPhotoCaptureBridge;->accessible(Ljava/lang/reflect/Method;)Ljava/lang/reflect/Method;

    move-result-object v4

    sput-object v4, Llocal/mio/os4camerabridge/LegendaryPhotoCaptureBridge;->shading:Ljava/lang/reflect/Method;

    .line 46
    sget-object v4, Llocal/mio/os4camerabridge/LegendaryPhotoCaptureBridge;->entry:Ljava/lang/Class;

    const-string v5, "legendTaskBasename"

    const-class v6, Ljava/lang/Object;

    filled-new-array {v6}, [Ljava/lang/Class;

    move-result-object v6

    invoke-virtual {v4, v5, v6}, Ljava/lang/Class;->getDeclaredMethod(Ljava/lang/String;[Ljava/lang/Class;)Ljava/lang/reflect/Method;

    move-result-object v4

    invoke-static {v4}, Llocal/mio/os4camerabridge/LegendaryPhotoCaptureBridge;->accessible(Ljava/lang/reflect/Method;)Ljava/lang/reflect/Method;

    move-result-object v4

    sput-object v4, Llocal/mio/os4camerabridge/LegendaryPhotoCaptureBridge;->basename:Ljava/lang/reflect/Method;

    .line 47
    new-instance v4, Llocal/mio/os4camerabridge/LegendaryPhotoCaptureBridge$1;

    const/16 v5, 0x2710

    invoke-direct {v4, v5}, Llocal/mio/os4camerabridge/LegendaryPhotoCaptureBridge$1;-><init>(I)V

    invoke-static {v0, v4}, Lde/robv/android/xposed/XposedBridge;->hookMethod(Ljava/lang/reflect/Member;Lde/robv/android/xposed/XC_MethodHook;)Lde/robv/android/xposed/XC_MethodHook$Unhook;

    move-result-object v0

    invoke-virtual {v2, v0}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    .line 56
    new-instance v0, Llocal/mio/os4camerabridge/LegendaryPhotoCaptureBridge$2;

    invoke-direct {v0}, Llocal/mio/os4camerabridge/LegendaryPhotoCaptureBridge$2;-><init>()V

    invoke-static {v7, v0}, Lde/robv/android/xposed/XposedBridge;->hookMethod(Ljava/lang/reflect/Member;Lde/robv/android/xposed/XC_MethodHook;)Lde/robv/android/xposed/XC_MethodHook$Unhook;

    move-result-object v0

    invoke-virtual {v2, v0}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    .line 61
    new-instance v0, Llocal/mio/os4camerabridge/LegendaryPhotoCaptureBridge$3;

    invoke-direct {v0}, Llocal/mio/os4camerabridge/LegendaryPhotoCaptureBridge$3;-><init>()V

    invoke-static {v8, v0}, Lde/robv/android/xposed/XposedBridge;->hookMethod(Ljava/lang/reflect/Member;Lde/robv/android/xposed/XC_MethodHook;)Lde/robv/android/xposed/XC_MethodHook$Unhook;

    move-result-object v0

    invoke-virtual {v2, v0}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    .line 66
    new-instance v0, Llocal/mio/os4camerabridge/LegendaryPhotoCaptureBridge$4;

    invoke-direct {v0}, Llocal/mio/os4camerabridge/LegendaryPhotoCaptureBridge$4;-><init>()V

    invoke-static {v11, v0}, Lde/robv/android/xposed/XposedBridge;->hookMethod(Ljava/lang/reflect/Member;Lde/robv/android/xposed/XC_MethodHook;)Lde/robv/android/xposed/XC_MethodHook$Unhook;

    move-result-object v0

    invoke-virtual {v2, v0}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    .line 78
    new-instance v0, Llocal/mio/os4camerabridge/LegendaryPhotoCaptureBridge$5;

    invoke-direct {v0}, Llocal/mio/os4camerabridge/LegendaryPhotoCaptureBridge$5;-><init>()V

    invoke-static {v9, v0}, Lde/robv/android/xposed/XposedBridge;->hookMethod(Ljava/lang/reflect/Member;Lde/robv/android/xposed/XC_MethodHook;)Lde/robv/android/xposed/XC_MethodHook$Unhook;

    move-result-object v0

    invoke-virtual {v2, v0}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    .line 84
    new-instance v0, Llocal/mio/os4camerabridge/LegendaryPhotoCaptureBridge$6;

    invoke-direct {v0}, Llocal/mio/os4camerabridge/LegendaryPhotoCaptureBridge$6;-><init>()V

    invoke-static {v10, v0}, Lde/robv/android/xposed/XposedBridge;->hookMethod(Ljava/lang/reflect/Member;Lde/robv/android/xposed/XC_MethodHook;)Lde/robv/android/xposed/XC_MethodHook$Unhook;

    move-result-object v0

    invoke-virtual {v2, v0}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    .line 93
    const-string v0, "local.mio.os4camerabridge.RearSessionParameterBridge"

    const/4 v4, 0x0

    invoke-static {v0, v4, v3}, Ljava/lang/Class;->forName(Ljava/lang/String;ZLjava/lang/ClassLoader;)Ljava/lang/Class;

    move-result-object v0

    const-string v3, "legendaryPhotoEnabled"

    const/4 v4, 0x1

    invoke-static {v0, v3, v4}, Lde/robv/android/xposed/XposedHelpers;->setStaticBooleanField(Ljava/lang/Class;Ljava/lang/String;Z)V

    .line 95
    sput-boolean v4, Llocal/mio/os4camerabridge/LegendaryPhotoCaptureBridge;->installed:Z

    .line 96
    const-string v0, "installed v3 M3+M9-main PhotoAPS=true nativeJpegRotation=true separateRawOrientation=true unfusedReferenceRAW=M9-only editorChanges=false"

    invoke-static {v0}, Llocal/mio/os4camerabridge/LegendaryPhotoCaptureBridge;->log(Ljava/lang/String;)V

    .line 100
    goto :goto_1

    .line 35
    :cond_1
    new-instance v0, Ljava/lang/IllegalStateException;

    const-string v3, "Camera selector signature"

    invoke-direct {v0, v3}, Ljava/lang/IllegalStateException;-><init>(Ljava/lang/String;)V

    throw v0
    :try_end_2
    .catchall {:try_start_2 .. :try_end_2} :catchall_0

    .line 97
    :catchall_0
    move-exception v0

    .line 98
    :try_start_3
    invoke-virtual {v2}, Ljava/util/ArrayList;->iterator()Ljava/util/Iterator;

    move-result-object v2

    :goto_0
    invoke-interface {v2}, Ljava/util/Iterator;->hasNext()Z

    move-result v3

    if-eqz v3, :cond_2

    invoke-interface {v2}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v3

    check-cast v3, Lde/robv/android/xposed/XC_MethodHook$Unhook;

    invoke-virtual {v3}, Lde/robv/android/xposed/XC_MethodHook$Unhook;->unhook()V

    goto :goto_0

    .line 99
    :cond_2
    invoke-static {v0}, Ljava/lang/String;->valueOf(Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v0

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "install rejected, all delegate hooks removed "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Llocal/mio/os4camerabridge/LegendaryPhotoCaptureBridge;->log(Ljava/lang/String;)V
    :try_end_3
    .catchall {:try_start_3 .. :try_end_3} :catchall_1

    .line 101
    :goto_1
    monitor-exit v1

    return-void

    .line 25
    :catchall_1
    move-exception v0

    :try_start_4
    monitor-exit v1
    :try_end_4
    .catchall {:try_start_4 .. :try_end_4} :catchall_1

    throw v0
.end method

.method static synthetic lambda$prune$0(Llocal/mio/os4camerabridge/LegendaryPhotoCaptureBridge$Reference;)Z
    .locals 4

    .line 196
    invoke-static {}, Landroid/os/SystemClock;->elapsedRealtime()J

    move-result-wide v0

    iget-wide v2, p0, Llocal/mio/os4camerabridge/LegendaryPhotoCaptureBridge$Reference;->created:J

    sub-long/2addr v0, v2

    const-wide/16 v2, 0x7530

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

    .line 198
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "[LegendaryPhotoCapture] "

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, p0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p0

    invoke-virtual {p0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p0

    invoke-static {p0}, Lde/robv/android/xposed/XposedBridge;->log(Ljava/lang/String;)V

    return-void
.end method

.method private static mainRatio(F)Z
    .locals 1

    .line 103
    invoke-static {p0}, Ljava/lang/Float;->isFinite(F)Z

    move-result v0

    if-eqz v0, :cond_0

    const/high16 v0, 0x3f800000    # 1.0f

    cmpl-float v0, p0, v0

    if-ltz v0, :cond_0

    const/high16 v0, 0x40400000    # 3.0f

    cmpg-float p0, p0, v0

    if-gez p0, :cond_0

    const/4 p0, 0x1

    goto :goto_0

    :cond_0
    const/4 p0, 0x0

    :goto_0
    return p0
.end method

.method private static mainSelected()Z
    .locals 5

    .line 106
    const/4 v0, 0x0

    :try_start_0
    sget-object v1, Llocal/mio/os4camerabridge/LegendaryPhotoCaptureBridge;->entry:Ljava/lang/Class;

    const-string v2, "activeLegendMode"

    invoke-static {v1, v2}, Lde/robv/android/xposed/XposedHelpers;->getStaticIntField(Ljava/lang/Class;Ljava/lang/String;)I

    move-result v1

    .line 107
    const/4 v2, 0x1

    if-eq v1, v2, :cond_0

    const/4 v2, 0x2

    if-eq v1, v2, :cond_0

    return v0

    .line 108
    :cond_0
    sget-object v1, Llocal/mio/os4camerabridge/LegendaryPhotoCaptureBridge;->entry:Ljava/lang/Class;

    const-string v2, "pendingLegendPhysicalZoom"

    invoke-static {v1, v2}, Lde/robv/android/xposed/XposedHelpers;->getStaticObjectField(Ljava/lang/Class;Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Ljava/lang/Float;

    invoke-virtual {v1}, Ljava/lang/Float;->floatValue()F

    move-result v1

    .line 109
    invoke-static {v1}, Ljava/lang/Float;->isFinite(F)Z

    move-result v2

    if-nez v2, :cond_1

    sget-object v1, Llocal/mio/os4camerabridge/LegendaryPhotoCaptureBridge;->zoomData:Ljava/lang/Class;

    const-string v2, "N"

    sget-object v3, Ljava/lang/Integer;->TYPE:Ljava/lang/Class;

    filled-new-array {v3}, [Ljava/lang/Class;

    move-result-object v3

    const/16 v4, 0x100

    invoke-static {v4}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v4

    filled-new-array {v4}, [Ljava/lang/Object;

    move-result-object v4

    invoke-static {v1, v2, v3, v4}, Lde/robv/android/xposed/XposedHelpers;->callStaticMethod(Ljava/lang/Class;Ljava/lang/String;[Ljava/lang/Class;[Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Ljava/lang/Float;

    invoke-virtual {v1}, Ljava/lang/Float;->floatValue()F

    move-result v1

    .line 110
    :cond_1
    invoke-static {v1}, Llocal/mio/os4camerabridge/LegendaryPhotoCaptureBridge;->mainRatio(F)Z

    move-result v0
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    return v0

    .line 111
    :catchall_0
    move-exception v1

    return v0
.end method

.method private static prune()V
    .locals 2

    .line 196
    sget-object v0, Llocal/mio/os4camerabridge/LegendaryPhotoCaptureBridge;->references:Ljava/util/Map;

    invoke-interface {v0}, Ljava/util/Map;->values()Ljava/util/Collection;

    move-result-object v0

    new-instance v1, Llocal/mio/os4camerabridge/LegendaryPhotoCaptureBridge$$ExternalSyntheticLambda0;

    invoke-direct {v1}, Llocal/mio/os4camerabridge/LegendaryPhotoCaptureBridge$$ExternalSyntheticLambda0;-><init>()V

    invoke-interface {v0, v1}, Ljava/util/Collection;->removeIf(Ljava/util/function/Predicate;)Z

    return-void
.end method

.method private static retain()V
    .locals 21
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/lang/Exception;
        }
    .end annotation

    .line 123
    invoke-static {}, Landroid/os/SystemClock;->elapsedRealtime()J

    move-result-wide v0

    .line 124
    sget-object v2, Llocal/mio/os4camerabridge/LegendaryPhotoCaptureBridge;->entry:Ljava/lang/Class;

    const-string v3, "COMMON_APS_LOCK"

    invoke-static {v2, v3}, Lde/robv/android/xposed/XposedHelpers;->getStaticObjectField(Ljava/lang/Class;Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v2

    .line 125
    nop

    .line 126
    monitor-enter v2

    .line 127
    :try_start_0
    sget-object v3, Llocal/mio/os4camerabridge/LegendaryPhotoCaptureBridge;->entry:Ljava/lang/Class;

    const-string v4, "commonApsIdentity"

    invoke-static {v3, v4}, Lde/robv/android/xposed/XposedHelpers;->getStaticLongField(Ljava/lang/Class;Ljava/lang/String;)J

    move-result-wide v3

    .line 128
    sget-object v5, Llocal/mio/os4camerabridge/LegendaryPhotoCaptureBridge;->entry:Ljava/lang/Class;

    const-string v6, "commonApsShutterTimestamp"

    invoke-static {v5, v6}, Lde/robv/android/xposed/XposedHelpers;->getStaticLongField(Ljava/lang/Class;Ljava/lang/String;)J

    move-result-wide v5

    .line 129
    sget-object v7, Llocal/mio/os4camerabridge/LegendaryPhotoCaptureBridge;->entry:Ljava/lang/Class;

    const-string v8, "activeLegendMode"

    invoke-static {v7, v8}, Lde/robv/android/xposed/XposedHelpers;->getStaticIntField(Ljava/lang/Class;Ljava/lang/String;)I

    move-result v11

    .line 130
    sget-object v7, Llocal/mio/os4camerabridge/LegendaryPhotoCaptureBridge;->entry:Ljava/lang/Class;

    const-string v8, "commonApsZoomRatio"

    invoke-static {v7, v8}, Lde/robv/android/xposed/XposedHelpers;->getStaticObjectField(Ljava/lang/Class;Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v7

    check-cast v7, Ljava/lang/Float;

    invoke-virtual {v7}, Ljava/lang/Float;->floatValue()F

    move-result v7

    .line 131
    sget-object v8, Llocal/mio/os4camerabridge/LegendaryPhotoCaptureBridge;->entry:Ljava/lang/Class;

    const-string v9, "commonApsOrientation"

    invoke-static {v8, v9}, Lde/robv/android/xposed/XposedHelpers;->getStaticIntField(Ljava/lang/Class;Ljava/lang/String;)I

    move-result v14

    .line 132
    const-wide/16 v8, 0x0

    cmp-long v8, v3, v8

    if-lez v8, :cond_a

    cmp-long v3, v3, v5

    if-nez v3, :cond_a

    invoke-static {v7}, Llocal/mio/os4camerabridge/LegendaryPhotoCaptureBridge;->mainRatio(F)Z

    move-result v3

    if-nez v3, :cond_0

    goto/16 :goto_4

    .line 133
    :cond_0
    if-eqz v14, :cond_2

    const/16 v3, 0x5a

    if-eq v14, v3, :cond_2

    const/16 v3, 0xb4

    if-eq v14, v3, :cond_2

    const/16 v3, 0x10e

    if-ne v14, v3, :cond_1

    goto :goto_0

    .line 134
    :cond_1
    new-instance v0, Ljava/lang/IllegalStateException;

    const-string v1, "Invalid capture orientation"

    invoke-direct {v0, v1}, Ljava/lang/IllegalStateException;-><init>(Ljava/lang/String;)V

    throw v0

    .line 135
    :cond_2
    :goto_0
    sget-object v3, Llocal/mio/os4camerabridge/LegendaryPhotoCaptureBridge;->entry:Ljava/lang/Class;

    const-string v4, "COMMON_APS_FRAMES"

    invoke-static {v3, v4}, Lde/robv/android/xposed/XposedHelpers;->getStaticObjectField(Ljava/lang/Class;Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v3

    check-cast v3, Ljava/util/Map;

    .line 136
    invoke-interface {v3}, Ljava/util/Map;->values()Ljava/util/Collection;

    move-result-object v3

    invoke-interface {v3}, Ljava/util/Collection;->iterator()Ljava/util/Iterator;

    move-result-object v3

    :goto_1
    invoke-interface {v3}, Ljava/util/Iterator;->hasNext()Z

    move-result v4

    const/4 v7, 0x2

    const/4 v8, 0x0

    if-eqz v4, :cond_7

    invoke-interface {v3}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v4

    .line 137
    const-string v9, "index"

    invoke-static {v4, v9}, Lde/robv/android/xposed/XposedHelpers;->getIntField(Ljava/lang/Object;Ljava/lang/String;)I

    move-result v9

    const/4 v10, 0x1

    if-eq v9, v10, :cond_3

    goto :goto_1

    .line 138
    :cond_3
    const-string v3, "main"

    invoke-static {v4, v3}, Lde/robv/android/xposed/XposedHelpers;->getObjectField(Ljava/lang/Object;Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v3

    check-cast v3, Landroid/media/Image;

    .line 139
    const-string v9, "result"

    invoke-static {v4, v9}, Lde/robv/android/xposed/XposedHelpers;->getObjectField(Ljava/lang/Object;Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v9

    move-object v15, v9

    check-cast v15, Landroid/hardware/camera2/TotalCaptureResult;

    .line 140
    const-string v9, "timestamp"

    invoke-static {v4, v9}, Lde/robv/android/xposed/XposedHelpers;->getLongField(Ljava/lang/Object;Ljava/lang/String;)J

    move-result-wide v12

    .line 141
    if-eqz v3, :cond_6

    if-eqz v15, :cond_6

    cmp-long v4, v12, v5

    if-nez v4, :cond_6

    invoke-virtual {v3}, Landroid/media/Image;->getTimestamp()J

    move-result-wide v4

    cmp-long v4, v4, v12

    if-nez v4, :cond_6

    .line 142
    invoke-static {v12, v13}, Ljava/lang/Long;->valueOf(J)Ljava/lang/Long;

    move-result-object v4

    sget-object v5, Landroid/hardware/camera2/CaptureResult;->SENSOR_TIMESTAMP:Landroid/hardware/camera2/CaptureResult$Key;

    invoke-virtual {v15, v5}, Landroid/hardware/camera2/TotalCaptureResult;->get(Landroid/hardware/camera2/CaptureResult$Key;)Ljava/lang/Object;

    move-result-object v5

    invoke-virtual {v4, v5}, Ljava/lang/Long;->equals(Ljava/lang/Object;)Z

    move-result v4

    if-eqz v4, :cond_6

    .line 143
    invoke-virtual {v3}, Landroid/media/Image;->getFormat()I

    move-result v4

    const/16 v5, 0x25

    if-ne v4, v5, :cond_6

    invoke-virtual {v3}, Landroid/media/Image;->getWidth()I

    move-result v4

    const/16 v5, 0x1000

    if-ne v4, v5, :cond_6

    invoke-virtual {v3}, Landroid/media/Image;->getHeight()I

    move-result v4

    const/16 v6, 0xc00

    if-ne v4, v6, :cond_6

    const-string v4, "2"

    sget-object v9, Landroid/hardware/camera2/CaptureResult;->LOGICAL_MULTI_CAMERA_ACTIVE_PHYSICAL_ID:Landroid/hardware/camera2/CaptureResult$Key;

    .line 144
    invoke-virtual {v15, v9}, Landroid/hardware/camera2/TotalCaptureResult;->get(Landroid/hardware/camera2/CaptureResult$Key;)Ljava/lang/Object;

    move-result-object v9

    invoke-virtual {v4, v9}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v4

    if-eqz v4, :cond_6

    .line 146
    invoke-virtual {v3}, Landroid/media/Image;->getPlanes()[Landroid/media/Image$Plane;

    move-result-object v3

    .line 147
    array-length v4, v3

    if-ne v4, v10, :cond_5

    .line 148
    sget-object v4, Llocal/mio/os4camerabridge/LegendaryPhotoCaptureBridge;->metadata:Ljava/lang/reflect/Method;

    invoke-static {v14}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v9

    invoke-static {v7}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v10

    filled-new-array {v15, v15, v9, v10}, [Ljava/lang/Object;

    move-result-object v9

    invoke-virtual {v4, v8, v9}, Ljava/lang/reflect/Method;->invoke(Ljava/lang/Object;[Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v4

    .line 149
    const-string v9, "luxIndex"

    .line 150
    invoke-static {v4, v9}, Lde/robv/android/xposed/XposedHelpers;->getIntField(Ljava/lang/Object;Ljava/lang/String;)I

    move-result v9

    const-string v10, "cct"

    .line 151
    invoke-static {v4, v10}, Lde/robv/android/xposed/XposedHelpers;->getIntField(Ljava/lang/Object;Ljava/lang/String;)I

    move-result v4

    .line 149
    move-wide/from16 v19, v12

    move v12, v9

    move-wide/from16 v9, v19

    move v13, v4

    invoke-static/range {v9 .. v14}, Llocal/mio/os4camerabridge/LegendaryNativeCaptureBridge;->remember(JIIII)V

    move/from16 v18, v14

    .line 152
    if-ne v11, v7, :cond_4

    .line 153
    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    const-string v4, "M3 same-shot PhotoAPS reference ts="

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3, v9, v10}, Ljava/lang/StringBuilder;->append(J)Ljava/lang/StringBuilder;

    move-result-object v3

    const-string v4, " physical=2 extraRAW=false"

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    invoke-static {v3}, Llocal/mio/os4camerabridge/LegendaryPhotoCaptureBridge;->log(Ljava/lang/String;)V

    .line 154
    goto :goto_2

    .line 156
    :cond_4
    sget-object v4, Llocal/mio/os4camerabridge/LegendaryPhotoCaptureBridge;->shading:Ljava/lang/reflect/Method;

    filled-new-array {v15, v15}, [Ljava/lang/Object;

    move-result-object v11

    invoke-virtual {v4, v8, v11}, Ljava/lang/reflect/Method;->invoke(Ljava/lang/Object;[Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v4

    move-object/from16 v17, v4

    check-cast v17, [F

    .line 157
    const/4 v4, 0x0

    aget-object v8, v3, v4

    invoke-virtual {v8}, Landroid/media/Image$Plane;->getBuffer()Ljava/nio/ByteBuffer;

    move-result-object v8

    aget-object v3, v3, v4

    invoke-virtual {v3}, Landroid/media/Image$Plane;->getRowStride()I

    move-result v3

    invoke-static {v8, v5, v6, v3}, Llocal/mio/os4camerabridge/PackedRaw10Copy;->copy(Ljava/nio/ByteBuffer;III)[B

    move-result-object v3

    .line 158
    new-instance v12, Llocal/mio/os4camerabridge/LegendaryPhotoCaptureBridge$Reference;

    move-wide v13, v9

    move-object/from16 v16, v15

    move-object v15, v3

    invoke-direct/range {v12 .. v18}, Llocal/mio/os4camerabridge/LegendaryPhotoCaptureBridge$Reference;-><init>(J[BLandroid/hardware/camera2/TotalCaptureResult;[FI)V

    .line 159
    move-object v8, v12

    goto :goto_2

    .line 147
    :cond_5
    new-instance v0, Ljava/lang/IllegalStateException;

    const-string v1, "RAW10 planes"

    invoke-direct {v0, v1}, Ljava/lang/IllegalStateException;-><init>(Ljava/lang/String;)V

    throw v0

    .line 145
    :cond_6
    new-instance v0, Ljava/lang/IllegalStateException;

    const-string v1, "Main reference timestamp/geometry/lens mismatch"

    invoke-direct {v0, v1}, Ljava/lang/IllegalStateException;-><init>(Ljava/lang/String;)V

    throw v0

    .line 161
    :cond_7
    :goto_2
    monitor-exit v2
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_1

    .line 162
    if-nez v8, :cond_8

    return-void

    .line 163
    :cond_8
    sget-object v3, Llocal/mio/os4camerabridge/LegendaryPhotoCaptureBridge;->references:Ljava/util/Map;

    monitor-enter v3

    .line 164
    :try_start_1
    invoke-static {}, Llocal/mio/os4camerabridge/LegendaryPhotoCaptureBridge;->prune()V

    .line 165
    :goto_3
    sget-object v2, Llocal/mio/os4camerabridge/LegendaryPhotoCaptureBridge;->references:Ljava/util/Map;

    invoke-interface {v2}, Ljava/util/Map;->size()I

    move-result v2

    if-lt v2, v7, :cond_9

    sget-object v2, Llocal/mio/os4camerabridge/LegendaryPhotoCaptureBridge;->references:Ljava/util/Map;

    sget-object v4, Llocal/mio/os4camerabridge/LegendaryPhotoCaptureBridge;->references:Ljava/util/Map;

    invoke-interface {v4}, Ljava/util/Map;->keySet()Ljava/util/Set;

    move-result-object v4

    invoke-interface {v4}, Ljava/util/Set;->iterator()Ljava/util/Iterator;

    move-result-object v4

    invoke-interface {v4}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v4

    invoke-interface {v2, v4}, Ljava/util/Map;->remove(Ljava/lang/Object;)Ljava/lang/Object;

    goto :goto_3

    .line 166
    :cond_9
    sget-object v2, Llocal/mio/os4camerabridge/LegendaryPhotoCaptureBridge;->references:Ljava/util/Map;

    iget-wide v4, v8, Llocal/mio/os4camerabridge/LegendaryPhotoCaptureBridge$Reference;->timestamp:J

    invoke-static {v4, v5}, Ljava/lang/Long;->valueOf(J)Ljava/lang/Long;

    move-result-object v4

    invoke-interface {v2, v4, v8}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 167
    monitor-exit v3
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    .line 168
    iget-wide v2, v8, Llocal/mio/os4camerabridge/LegendaryPhotoCaptureBridge$Reference;->timestamp:J

    iget-object v4, v8, Llocal/mio/os4camerabridge/LegendaryPhotoCaptureBridge$Reference;->raw:[B

    array-length v4, v4

    iget-object v5, v8, Llocal/mio/os4camerabridge/LegendaryPhotoCaptureBridge$Reference;->result:Landroid/hardware/camera2/TotalCaptureResult;

    sget-object v6, Landroid/hardware/camera2/CaptureResult;->SENSOR_SENSITIVITY:Landroid/hardware/camera2/CaptureResult$Key;

    .line 169
    invoke-virtual {v5, v6}, Landroid/hardware/camera2/TotalCaptureResult;->get(Landroid/hardware/camera2/CaptureResult$Key;)Ljava/lang/Object;

    move-result-object v5

    invoke-static {v5}, Ljava/lang/String;->valueOf(Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v5

    invoke-static {}, Landroid/os/SystemClock;->elapsedRealtime()J

    move-result-wide v6

    sub-long/2addr v6, v0

    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "retained ts="

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, v2, v3}, Ljava/lang/StringBuilder;->append(J)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, " bytes="

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, v4}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, " iso="

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, " copyMs="

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, v6, v7}, Ljava/lang/StringBuilder;->append(J)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, " sourceIndex=1 fusedRAW=false"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    .line 168
    invoke-static {v0}, Llocal/mio/os4camerabridge/LegendaryPhotoCaptureBridge;->log(Ljava/lang/String;)V

    .line 171
    return-void

    .line 167
    :catchall_0
    move-exception v0

    :try_start_2
    monitor-exit v3
    :try_end_2
    .catchall {:try_start_2 .. :try_end_2} :catchall_0

    throw v0

    .line 132
    :cond_a
    :goto_4
    :try_start_3
    monitor-exit v2

    return-void

    .line 161
    :catchall_1
    move-exception v0

    monitor-exit v2
    :try_end_3
    .catchall {:try_start_3 .. :try_end_3} :catchall_1

    throw v0
.end method

.method private static save(Ljava/lang/Object;)Z
    .locals 11
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/lang/Exception;
        }
    .end annotation

    .line 174
    const-string v0, "a"

    invoke-static {p0, v0}, Lde/robv/android/xposed/XposedHelpers;->getObjectField(Ljava/lang/Object;Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v0

    .line 175
    const-string v1, "f"

    invoke-static {v0, v1}, Lde/robv/android/xposed/XposedHelpers;->getLongField(Ljava/lang/Object;Ljava/lang/String;)J

    move-result-wide v1

    .line 177
    sget-object v3, Llocal/mio/os4camerabridge/LegendaryPhotoCaptureBridge;->references:Ljava/util/Map;

    monitor-enter v3

    :try_start_0
    invoke-static {}, Llocal/mio/os4camerabridge/LegendaryPhotoCaptureBridge;->prune()V

    sget-object v4, Llocal/mio/os4camerabridge/LegendaryPhotoCaptureBridge;->references:Ljava/util/Map;

    invoke-static {v1, v2}, Ljava/lang/Long;->valueOf(J)Ljava/lang/Long;

    move-result-object v5

    invoke-interface {v4, v5}, Ljava/util/Map;->remove(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v4

    check-cast v4, Llocal/mio/os4camerabridge/LegendaryPhotoCaptureBridge$Reference;

    monitor-exit v3
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_1

    .line 178
    if-nez v4, :cond_0

    const/4 p0, 0x0

    return p0

    .line 179
    :cond_0
    const-string v3, "i"

    invoke-static {v0, v3}, Lde/robv/android/xposed/XposedHelpers;->getObjectField(Ljava/lang/Object;Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v3

    check-cast v3, [B

    .line 182
    const-string v5, "c"

    invoke-static {v0, v5}, Lde/robv/android/xposed/XposedHelpers;->getIntField(Ljava/lang/Object;Ljava/lang/String;)I

    move-result v5

    .line 183
    sget-object v6, Llocal/mio/os4camerabridge/LegendaryPhotoCaptureBridge;->metadata:Ljava/lang/reflect/Method;

    iget-object v7, v4, Llocal/mio/os4camerabridge/LegendaryPhotoCaptureBridge$Reference;->result:Landroid/hardware/camera2/TotalCaptureResult;

    iget-object v8, v4, Llocal/mio/os4camerabridge/LegendaryPhotoCaptureBridge$Reference;->result:Landroid/hardware/camera2/TotalCaptureResult;

    iget v9, v4, Llocal/mio/os4camerabridge/LegendaryPhotoCaptureBridge$Reference;->rawOrientation:I

    invoke-static {v9}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v9

    const/4 v10, 0x2

    invoke-static {v10}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v10

    filled-new-array {v7, v8, v9, v10}, [Ljava/lang/Object;

    move-result-object v7

    const/4 v8, 0x0

    invoke-virtual {v6, v8, v7}, Ljava/lang/reflect/Method;->invoke(Ljava/lang/Object;[Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v6

    .line 184
    sget-object v7, Llocal/mio/os4camerabridge/LegendaryPhotoCaptureBridge;->basename:Ljava/lang/reflect/Method;

    filled-new-array {p0}, [Ljava/lang/Object;

    move-result-object p0

    invoke-virtual {v7, v8, p0}, Ljava/lang/reflect/Method;->invoke(Ljava/lang/Object;[Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object p0

    check-cast p0, Ljava/lang/String;

    .line 186
    invoke-static {v1, v2}, Llocal/mio/os4camerabridge/LegendaryNativeCaptureBridge;->beginContainer(J)V

    .line 187
    :try_start_1
    sget-object v7, Llocal/mio/os4camerabridge/LegendaryPhotoCaptureBridge;->wrap:Ljava/lang/reflect/Method;

    iget-object v9, v4, Llocal/mio/os4camerabridge/LegendaryPhotoCaptureBridge$Reference;->raw:[B

    iget-object v10, v4, Llocal/mio/os4camerabridge/LegendaryPhotoCaptureBridge$Reference;->lsc:[F

    filled-new-array {v3, v9, v10, p0, v6}, [Ljava/lang/Object;

    move-result-object v6

    invoke-virtual {v7, v8, v6}, Ljava/lang/reflect/Method;->invoke(Ljava/lang/Object;[Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v6

    check-cast v6, [B
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    .line 188
    invoke-static {}, Llocal/mio/os4camerabridge/LegendaryNativeCaptureBridge;->endContainer()V

    .line 189
    const-string v7, "i"

    invoke-static {v0, v7, v6}, Lde/robv/android/xposed/XposedHelpers;->setObjectField(Ljava/lang/Object;Ljava/lang/String;Ljava/lang/Object;)V

    .line 190
    array-length v0, v3

    array-length v3, v6

    iget v4, v4, Llocal/mio/os4camerabridge/LegendaryPhotoCaptureBridge$Reference;->rawOrientation:I

    new-instance v6, Ljava/lang/StringBuilder;

    invoke-direct {v6}, Ljava/lang/StringBuilder;-><init>()V

    const-string v7, "committed basename="

    invoke-virtual {v6, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    invoke-virtual {v6, p0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p0

    const-string v6, " ts="

    invoke-virtual {p0, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p0

    invoke-virtual {p0, v1, v2}, Ljava/lang/StringBuilder;->append(J)Ljava/lang/StringBuilder;

    move-result-object p0

    const-string v1, " primary="

    invoke-virtual {p0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p0

    invoke-virtual {p0, v0}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object p0

    const-string v0, " total="

    invoke-virtual {p0, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p0

    invoke-virtual {p0, v3}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object p0

    const-string v0, " jpegTaskOrientation="

    invoke-virtual {p0, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p0

    invoke-virtual {p0, v5}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object p0

    const-string v0, " rawOrientation="

    invoke-virtual {p0, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p0

    invoke-virtual {p0, v4}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object p0

    const-string v0, " jpeg=PhotoAPS referenceRAW=unfused sameShot=true"

    invoke-virtual {p0, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p0

    invoke-virtual {p0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p0

    invoke-static {p0}, Llocal/mio/os4camerabridge/LegendaryPhotoCaptureBridge;->log(Ljava/lang/String;)V

    .line 193
    const/4 p0, 0x1

    return p0

    .line 188
    :catchall_0
    move-exception p0

    invoke-static {}, Llocal/mio/os4camerabridge/LegendaryNativeCaptureBridge;->endContainer()V

    throw p0

    .line 177
    :catchall_1
    move-exception p0

    :try_start_2
    monitor-exit v3
    :try_end_2
    .catchall {:try_start_2 .. :try_end_2} :catchall_1

    throw p0
.end method
