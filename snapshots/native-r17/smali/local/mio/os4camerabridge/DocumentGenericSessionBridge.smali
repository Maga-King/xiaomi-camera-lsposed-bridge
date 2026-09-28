.class public final Llocal/mio/os4camerabridge/DocumentGenericSessionBridge;
.super Ljava/lang/Object;
.source "DocumentGenericSessionBridge.java"


# static fields
.field private static final decoded:Ljava/util/concurrent/atomic/AtomicInteger;

.field private static final frames:Ljava/util/concurrent/atomic/AtomicInteger;


# direct methods
.method static bridge synthetic -$$Nest$sfgetdecoded()Ljava/util/concurrent/atomic/AtomicInteger;
    .locals 1

    sget-object v0, Llocal/mio/os4camerabridge/DocumentGenericSessionBridge;->decoded:Ljava/util/concurrent/atomic/AtomicInteger;

    return-object v0
.end method

.method static bridge synthetic -$$Nest$sfgetframes()Ljava/util/concurrent/atomic/AtomicInteger;
    .locals 1

    sget-object v0, Llocal/mio/os4camerabridge/DocumentGenericSessionBridge;->frames:Ljava/util/concurrent/atomic/AtomicInteger;

    return-object v0
.end method

.method static bridge synthetic -$$Nest$smisDocument(Ljava/lang/Class;)Z
    .locals 0

    invoke-static {p0}, Llocal/mio/os4camerabridge/DocumentGenericSessionBridge;->isDocument(Ljava/lang/Class;)Z

    move-result p0

    return p0
.end method

.method static constructor <clinit>()V
    .locals 1

    .line 13
    new-instance v0, Ljava/util/concurrent/atomic/AtomicInteger;

    invoke-direct {v0}, Ljava/util/concurrent/atomic/AtomicInteger;-><init>()V

    sput-object v0, Llocal/mio/os4camerabridge/DocumentGenericSessionBridge;->frames:Ljava/util/concurrent/atomic/AtomicInteger;

    .line 14
    new-instance v0, Ljava/util/concurrent/atomic/AtomicInteger;

    invoke-direct {v0}, Ljava/util/concurrent/atomic/AtomicInteger;-><init>()V

    sput-object v0, Llocal/mio/os4camerabridge/DocumentGenericSessionBridge;->decoded:Ljava/util/concurrent/atomic/AtomicInteger;

    return-void
.end method

.method private constructor <init>()V
    .locals 0

    .line 15
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method public static install(Ljava/lang/ClassLoader;)V
    .locals 5

    .line 18
    nop

    .line 19
    const-class v0, Llocal/mio/os4camerabridge/DocumentGenericSessionBridge;

    invoke-virtual {v0}, Ljava/lang/Class;->getClassLoader()Ljava/lang/ClassLoader;

    move-result-object v0

    .line 18
    const-string v1, "local.mio.os4camerabridge.HookEntry"

    invoke-static {v1, v0}, Lde/robv/android/xposed/XposedHelpers;->findClass(Ljava/lang/String;Ljava/lang/ClassLoader;)Ljava/lang/Class;

    move-result-object v0

    .line 20
    sget-object v1, Ljava/lang/Integer;->TYPE:Ljava/lang/Class;

    new-instance v2, Llocal/mio/os4camerabridge/DocumentGenericSessionBridge$1;

    invoke-direct {v2}, Llocal/mio/os4camerabridge/DocumentGenericSessionBridge$1;-><init>()V

    filled-new-array {v1, v2}, [Ljava/lang/Object;

    move-result-object v1

    const-string v2, "isRearClarityModule"

    invoke-static {v0, v2, v1}, Lde/robv/android/xposed/XposedHelpers;->findAndHookMethod(Ljava/lang/Class;Ljava/lang/String;[Ljava/lang/Object;)Lde/robv/android/xposed/XC_MethodHook$Unhook;

    .line 25
    const-string v1, "sh.b"

    invoke-static {v1, p0}, Lde/robv/android/xposed/XposedHelpers;->findClass(Ljava/lang/String;Ljava/lang/ClassLoader;)Ljava/lang/Class;

    move-result-object v1

    new-instance v2, Llocal/mio/os4camerabridge/DocumentGenericSessionBridge$2;

    const/16 v3, -0x2710

    invoke-direct {v2, v3, v0}, Llocal/mio/os4camerabridge/DocumentGenericSessionBridge$2;-><init>(ILjava/lang/Class;)V

    const-string v3, "b"

    invoke-static {v1, v3, v2}, Lde/robv/android/xposed/XposedBridge;->hookAllMethods(Ljava/lang/Class;Ljava/lang/String;Lde/robv/android/xposed/XC_MethodHook;)Ljava/util/Set;

    .line 51
    const-string v1, "com.android.camera.features.mode.doc.DocModule"

    invoke-static {v1, p0}, Lde/robv/android/xposed/XposedHelpers;->findClass(Ljava/lang/String;Ljava/lang/ClassLoader;)Ljava/lang/Class;

    move-result-object v1

    .line 52
    new-instance v2, Llocal/mio/os4camerabridge/DocumentGenericSessionBridge$3;

    invoke-direct {v2}, Llocal/mio/os4camerabridge/DocumentGenericSessionBridge$3;-><init>()V

    const-string v4, "appendPreviewDecoder"

    invoke-static {v1, v4, v2}, Lde/robv/android/xposed/XposedBridge;->hookAllMethods(Ljava/lang/Class;Ljava/lang/String;Lde/robv/android/xposed/XC_MethodHook;)Ljava/util/Set;

    .line 62
    const-class v2, Landroid/media/Image;

    new-instance v4, Llocal/mio/os4camerabridge/DocumentGenericSessionBridge$4;

    invoke-direct {v4, v0}, Llocal/mio/os4camerabridge/DocumentGenericSessionBridge$4;-><init>(Ljava/lang/Class;)V

    filled-new-array {v2, v4}, [Ljava/lang/Object;

    move-result-object v0

    const-string v2, "gi.f"

    invoke-static {v2, p0, v3, v0}, Lde/robv/android/xposed/XposedHelpers;->findAndHookMethod(Ljava/lang/String;Ljava/lang/ClassLoader;Ljava/lang/String;[Ljava/lang/Object;)Lde/robv/android/xposed/XC_MethodHook$Unhook;

    .line 74
    new-instance p0, Llocal/mio/os4camerabridge/DocumentGenericSessionBridge$5;

    invoke-direct {p0}, Llocal/mio/os4camerabridge/DocumentGenericSessionBridge$5;-><init>()V

    const-string v0, "onDocDecodeDataReceived"

    invoke-static {v1, v0, p0}, Lde/robv/android/xposed/XposedBridge;->hookAllMethods(Ljava/lang/Class;Ljava/lang/String;Lde/robv/android/xposed/XC_MethodHook;)Ljava/util/Set;

    .line 84
    new-instance p0, Llocal/mio/os4camerabridge/DocumentGenericSessionBridge$6;

    invoke-direct {p0}, Llocal/mio/os4camerabridge/DocumentGenericSessionBridge$6;-><init>()V

    const-string v0, "prepareNormalCapture"

    invoke-static {v1, v0, p0}, Lde/robv/android/xposed/XposedBridge;->hookAllMethods(Ljava/lang/Class;Ljava/lang/String;Lde/robv/android/xposed/XC_MethodHook;)Ljava/util/Set;

    .line 93
    const-string p0, "[DocumentGeneric] module186 APS replacement bypassed; original preview/JPEG/YUV and saver retained"

    invoke-static {p0}, Lde/robv/android/xposed/XposedBridge;->log(Ljava/lang/String;)V

    .line 94
    return-void
.end method

.method private static isDocument(Ljava/lang/Class;)Z
    .locals 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/lang/Class<",
            "*>;)Z"
        }
    .end annotation

    .line 97
    const-string v0, "activeCameraModule"

    invoke-static {p0, v0}, Lde/robv/android/xposed/XposedHelpers;->getStaticIntField(Ljava/lang/Class;Ljava/lang/String;)I

    move-result p0

    const/16 v0, 0xba

    if-ne p0, v0, :cond_0

    const/4 p0, 0x1

    goto :goto_0

    :cond_0
    const/4 p0, 0x0

    :goto_0
    return p0
.end method
