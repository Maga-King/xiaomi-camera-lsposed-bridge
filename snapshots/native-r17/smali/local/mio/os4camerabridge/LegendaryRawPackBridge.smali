.class public final Llocal/mio/os4camerabridge/LegendaryRawPackBridge;
.super Ljava/lang/Object;
.source "LegendaryRawPackBridge.java"


# static fields
.field private static final LOCK:Ljava/lang/Object;

.field private static disabled:Z

.field private static loaded:Z


# direct methods
.method static bridge synthetic -$$Nest$sfgetLOCK()Ljava/lang/Object;
    .locals 1

    sget-object v0, Llocal/mio/os4camerabridge/LegendaryRawPackBridge;->LOCK:Ljava/lang/Object;

    return-object v0
.end method

.method static bridge synthetic -$$Nest$sfgetdisabled()Z
    .locals 1

    sget-boolean v0, Llocal/mio/os4camerabridge/LegendaryRawPackBridge;->disabled:Z

    return v0
.end method

.method static bridge synthetic -$$Nest$sfputdisabled(Z)V
    .locals 0

    sput-boolean p0, Llocal/mio/os4camerabridge/LegendaryRawPackBridge;->disabled:Z

    return-void
.end method

.method static bridge synthetic -$$Nest$smload()V
    .locals 0

    invoke-static {}, Llocal/mio/os4camerabridge/LegendaryRawPackBridge;->load()V

    return-void
.end method

.method static bridge synthetic -$$Nest$smlog(Ljava/lang/String;)V
    .locals 0

    invoke-static {p0}, Llocal/mio/os4camerabridge/LegendaryRawPackBridge;->log(Ljava/lang/String;)V

    return-void
.end method

.method static bridge synthetic -$$Nest$smpackPixels([B[I)[B
    .locals 0

    invoke-static {p0, p1}, Llocal/mio/os4camerabridge/LegendaryRawPackBridge;->packPixels([B[I)[B

    move-result-object p0

    return-object p0
.end method

.method static constructor <clinit>()V
    .locals 1

    .line 15
    new-instance v0, Ljava/lang/Object;

    invoke-direct {v0}, Ljava/lang/Object;-><init>()V

    sput-object v0, Llocal/mio/os4camerabridge/LegendaryRawPackBridge;->LOCK:Ljava/lang/Object;

    return-void
.end method

.method private constructor <init>()V
    .locals 0

    .line 16
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method static install()V
    .locals 5
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/lang/Exception;
        }
    .end annotation

    .line 19
    const-class v0, Llocal/mio/os4camerabridge/LegendaryRawPackBridge;

    invoke-virtual {v0}, Ljava/lang/Class;->getClassLoader()Ljava/lang/ClassLoader;

    move-result-object v0

    const-string v1, "local.mio.os4camerabridge.LegendM9Container"

    const/4 v2, 0x0

    invoke-static {v1, v2, v0}, Ljava/lang/Class;->forName(Ljava/lang/String;ZLjava/lang/ClassLoader;)Ljava/lang/Class;

    move-result-object v0

    .line 20
    sget-object v1, Ljava/lang/Integer;->TYPE:Ljava/lang/Class;

    sget-object v2, Ljava/lang/Integer;->TYPE:Ljava/lang/Class;

    const-class v3, Ljava/lang/String;

    const-class v4, [B

    filled-new-array {v4, v1, v2, v3}, [Ljava/lang/Class;

    move-result-object v1

    const-string v2, "packRggbToCloudBggr"

    invoke-virtual {v0, v2, v1}, Ljava/lang/Class;->getDeclaredMethod(Ljava/lang/String;[Ljava/lang/Class;)Ljava/lang/reflect/Method;

    move-result-object v1

    .line 21
    sget-object v2, Ljava/lang/Integer;->TYPE:Ljava/lang/Class;

    sget-object v3, Ljava/lang/Integer;->TYPE:Ljava/lang/Class;

    filled-new-array {v2, v3}, [Ljava/lang/Class;

    move-result-object v2

    const-string v3, "buildTransferLut"

    invoke-virtual {v0, v3, v2}, Ljava/lang/Class;->getDeclaredMethod(Ljava/lang/String;[Ljava/lang/Class;)Ljava/lang/reflect/Method;

    move-result-object v2

    .line 22
    const-class v3, Ljava/lang/String;

    filled-new-array {v4, v3}, [Ljava/lang/Class;

    move-result-object v3

    const-string v4, "rc4XorInPlace"

    invoke-virtual {v0, v4, v3}, Ljava/lang/Class;->getDeclaredMethod(Ljava/lang/String;[Ljava/lang/Class;)Ljava/lang/reflect/Method;

    move-result-object v0

    .line 23
    const/4 v3, 0x1

    invoke-virtual {v2, v3}, Ljava/lang/reflect/Method;->setAccessible(Z)V

    invoke-virtual {v0, v3}, Ljava/lang/reflect/Method;->setAccessible(Z)V

    .line 25
    new-instance v3, Llocal/mio/os4camerabridge/LegendaryRawPackBridge$1;

    const/16 v4, -0x2710

    invoke-direct {v3, v4, v2, v0}, Llocal/mio/os4camerabridge/LegendaryRawPackBridge$1;-><init>(ILjava/lang/reflect/Method;Ljava/lang/reflect/Method;)V

    invoke-static {v1, v3}, Lde/robv/android/xposed/XposedBridge;->hookMethod(Ljava/lang/reflect/Member;Lde/robv/android/xposed/XC_MethodHook;)Lde/robv/android/xposed/XC_MethodHook$Unhook;

    .line 47
    return-void
.end method

.method private static load()V
    .locals 3
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/lang/Exception;
        }
    .end annotation

    .line 49
    sget-boolean v0, Llocal/mio/os4camerabridge/LegendaryRawPackBridge;->loaded:Z

    if-eqz v0, :cond_0

    return-void

    .line 50
    :cond_0
    const-string v0, "android.app.ActivityThread"

    invoke-static {v0}, Ljava/lang/Class;->forName(Ljava/lang/String;)Ljava/lang/Class;

    move-result-object v0

    const/4 v1, 0x0

    new-array v1, v1, [Ljava/lang/Object;

    const-string v2, "currentApplication"

    invoke-static {v0, v2, v1}, Lde/robv/android/xposed/XposedHelpers;->callStaticMethod(Ljava/lang/Class;Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Landroid/app/Application;

    .line 51
    if-eqz v0, :cond_1

    .line 52
    const-string v1, "local.mio.os4camerabridge"

    const/4 v2, 0x2

    invoke-virtual {v0, v1, v2}, Landroid/app/Application;->createPackageContext(Ljava/lang/String;I)Landroid/content/Context;

    move-result-object v0

    .line 53
    new-instance v1, Ljava/io/File;

    invoke-virtual {v0}, Landroid/content/Context;->getApplicationInfo()Landroid/content/pm/ApplicationInfo;

    move-result-object v0

    iget-object v0, v0, Landroid/content/pm/ApplicationInfo;->nativeLibraryDir:Ljava/lang/String;

    const-string v2, "liblegend_raw_pack.so"

    invoke-direct {v1, v0, v2}, Ljava/io/File;-><init>(Ljava/lang/String;Ljava/lang/String;)V

    invoke-virtual {v1}, Ljava/io/File;->getPath()Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Ljava/lang/System;->load(Ljava/lang/String;)V

    .line 54
    const/4 v0, 0x1

    sput-boolean v0, Llocal/mio/os4camerabridge/LegendaryRawPackBridge;->loaded:Z

    .line 55
    return-void

    .line 51
    :cond_1
    new-instance v0, Ljava/lang/IllegalStateException;

    const-string v1, "Application absent"

    invoke-direct {v0, v1}, Ljava/lang/IllegalStateException;-><init>(Ljava/lang/String;)V

    throw v0
.end method

.method private static log(Ljava/lang/String;)V
    .locals 2

    .line 56
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "[LegendaryRawPack] "

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, p0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p0

    invoke-virtual {p0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p0

    invoke-static {p0}, Lde/robv/android/xposed/XposedBridge;->log(Ljava/lang/String;)V

    return-void
.end method

.method private static native packPixels([B[I)[B
.end method
