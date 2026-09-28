.class public final Llocal/mio/os4camerabridge/GenericVideoSessionBridge;
.super Ljava/lang/Object;
.source "GenericVideoSessionBridge.java"


# static fields
.field private static decisionLogs:I

.field private static volatile profileVerified:Z


# direct methods
.method static bridge synthetic -$$Nest$sfgetdecisionLogs()I
    .locals 1

    sget v0, Llocal/mio/os4camerabridge/GenericVideoSessionBridge;->decisionLogs:I

    return v0
.end method

.method static bridge synthetic -$$Nest$sfgetprofileVerified()Z
    .locals 1

    sget-boolean v0, Llocal/mio/os4camerabridge/GenericVideoSessionBridge;->profileVerified:Z

    return v0
.end method

.method static bridge synthetic -$$Nest$sfputdecisionLogs(I)V
    .locals 0

    sput p0, Llocal/mio/os4camerabridge/GenericVideoSessionBridge;->decisionLogs:I

    return-void
.end method

.method static bridge synthetic -$$Nest$sfputprofileVerified(Z)V
    .locals 0

    sput-boolean p0, Llocal/mio/os4camerabridge/GenericVideoSessionBridge;->profileVerified:Z

    return-void
.end method

.method static bridge synthetic -$$Nest$smverifyProfile(Ljava/lang/Object;ILjava/lang/Object;)Z
    .locals 0

    invoke-static {p0, p1, p2}, Llocal/mio/os4camerabridge/GenericVideoSessionBridge;->verifyProfile(Ljava/lang/Object;ILjava/lang/Object;)Z

    move-result p0

    return p0
.end method

.method private constructor <init>()V
    .locals 0

    .line 15
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method public static install(Ljava/lang/ClassLoader;)V
    .locals 5

    .line 27
    nop

    .line 28
    const-class v0, Llocal/mio/os4camerabridge/GenericVideoSessionBridge;

    invoke-virtual {v0}, Ljava/lang/Class;->getClassLoader()Ljava/lang/ClassLoader;

    move-result-object v0

    .line 27
    const-string v1, "local.mio.os4camerabridge.HookEntry"

    invoke-static {v1, v0}, Lde/robv/android/xposed/XposedHelpers;->findClass(Ljava/lang/String;Ljava/lang/ClassLoader;)Ljava/lang/Class;

    move-result-object v0

    .line 33
    nop

    .line 34
    const-string v1, "j9.e"

    invoke-static {v1, p0}, Lde/robv/android/xposed/XposedHelpers;->findClass(Ljava/lang/String;Ljava/lang/ClassLoader;)Ljava/lang/Class;

    move-result-object v1

    sget-object v2, Ljava/lang/Integer;->TYPE:Ljava/lang/Class;

    .line 35
    const-string v3, "j6.k"

    invoke-static {v3, p0}, Lde/robv/android/xposed/XposedHelpers;->findClass(Ljava/lang/String;Ljava/lang/ClassLoader;)Ljava/lang/Class;

    move-result-object v3

    new-instance v4, Llocal/mio/os4camerabridge/GenericVideoSessionBridge$1;

    invoke-direct {v4}, Llocal/mio/os4camerabridge/GenericVideoSessionBridge$1;-><init>()V

    filled-new-array {v1, v2, v3, v4}, [Ljava/lang/Object;

    move-result-object v1

    .line 33
    const-string v2, "com.android.camera.module.video.G"

    const-string v3, "k"

    invoke-static {v2, p0, v3, v1}, Lde/robv/android/xposed/XposedHelpers;->findAndHookMethod(Ljava/lang/String;Ljava/lang/ClassLoader;Ljava/lang/String;[Ljava/lang/Object;)Lde/robv/android/xposed/XC_MethodHook$Unhook;

    .line 51
    const-string v1, "com.android.camera.module.VideoModule"

    invoke-static {v1, p0}, Lde/robv/android/xposed/XposedHelpers;->findClass(Ljava/lang/String;Ljava/lang/ClassLoader;)Ljava/lang/Class;

    move-result-object v1

    new-instance v2, Llocal/mio/os4camerabridge/GenericVideoSessionBridge$2;

    invoke-direct {v2}, Llocal/mio/os4camerabridge/GenericVideoSessionBridge$2;-><init>()V

    const-string v3, "isEisOn"

    invoke-static {v1, v3, v2}, Lde/robv/android/xposed/XposedBridge;->hookAllMethods(Ljava/lang/Class;Ljava/lang/String;Lde/robv/android/xposed/XC_MethodHook;)Ljava/util/Set;

    .line 73
    const-string v1, "sh.b"

    invoke-static {v1, p0}, Lde/robv/android/xposed/XposedHelpers;->findClass(Ljava/lang/String;Ljava/lang/ClassLoader;)Ljava/lang/Class;

    move-result-object p0

    new-instance v1, Llocal/mio/os4camerabridge/GenericVideoSessionBridge$3;

    const/16 v2, -0x2710

    invoke-direct {v1, v2, v0}, Llocal/mio/os4camerabridge/GenericVideoSessionBridge$3;-><init>(ILjava/lang/Class;)V

    const-string v0, "b"

    invoke-static {p0, v0, v1}, Lde/robv/android/xposed/XposedBridge;->hookAllMethods(Ljava/lang/Class;Ljava/lang/String;Lde/robv/android/xposed/XC_MethodHook;)Ljava/util/Set;

    .line 93
    const-string p0, "[GenericVideo] verified1080p30 fallback installed, no temporary property required"

    invoke-static {p0}, Lde/robv/android/xposed/XposedBridge;->log(Ljava/lang/String;)V

    .line 94
    return-void
.end method

.method private static verifyProfile(Ljava/lang/Object;ILjava/lang/Object;)Z
    .locals 4

    .line 18
    const/4 v0, 0x0

    const/4 v1, 0x0

    if-nez p2, :cond_0

    move-object p2, v0

    goto :goto_0

    :cond_0
    const-string v2, "V"

    new-array v3, v1, [Ljava/lang/Object;

    invoke-static {p2, v2, v3}, Lde/robv/android/xposed/XposedHelpers;->callMethod(Ljava/lang/Object;Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object p2

    .line 19
    :goto_0
    if-nez p2, :cond_1

    const/4 p2, -0x1

    goto :goto_1

    :cond_1
    const-string v2, "a"

    invoke-static {p2, v2}, Lde/robv/android/xposed/XposedHelpers;->getIntField(Ljava/lang/Object;Ljava/lang/String;)I

    move-result p2

    .line 20
    :goto_1
    if-nez p0, :cond_2

    goto :goto_2

    .line 21
    :cond_2
    const-string v0, "j"

    invoke-static {p0, v0}, Lde/robv/android/xposed/XposedHelpers;->getObjectField(Ljava/lang/Object;Ljava/lang/String;)Ljava/lang/Object;

    move-result-object p0

    move-object v0, p0

    check-cast v0, Landroid/media/CamcorderProfile;

    .line 22
    :goto_2
    if-eqz v0, :cond_3

    iget p0, v0, Landroid/media/CamcorderProfile;->videoFrameWidth:I

    iget v2, v0, Landroid/media/CamcorderProfile;->videoFrameHeight:I

    iget v0, v0, Landroid/media/CamcorderProfile;->videoFrameRate:I

    invoke-static {p1, p2, p0, v2, v0}, Llocal/mio/os4camerabridge/GenericVideoPolicy;->supportsProfile(IIIII)Z

    move-result p0

    if-eqz p0, :cond_3

    const/4 v1, 0x1

    :cond_3
    return v1
.end method
