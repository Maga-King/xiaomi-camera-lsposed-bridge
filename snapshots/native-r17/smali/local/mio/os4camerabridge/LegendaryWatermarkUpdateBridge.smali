.class public final Llocal/mio/os4camerabridge/LegendaryWatermarkUpdateBridge;
.super Ljava/lang/Object;
.source "LegendaryWatermarkUpdateBridge.java"


# static fields
.field private static final FILTER_OWNER:Ljava/lang/ThreadLocal;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/lang/ThreadLocal<",
            "Ljava/lang/Object;",
            ">;"
        }
    .end annotation
.end field

.field private static final LOCK:Ljava/lang/Object;

.field private static final MANUAL_CHANNEL:Ljava/lang/ThreadLocal;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/lang/ThreadLocal<",
            "Ljava/lang/String;",
            ">;"
        }
    .end annotation
.end field

.field private static deadline:J

.field private static photoPending:Z

.field private static requestedAt:J

.field private static videoPending:Z


# direct methods
.method static bridge synthetic -$$Nest$sfgetFILTER_OWNER()Ljava/lang/ThreadLocal;
    .locals 1

    sget-object v0, Llocal/mio/os4camerabridge/LegendaryWatermarkUpdateBridge;->FILTER_OWNER:Ljava/lang/ThreadLocal;

    return-object v0
.end method

.method static bridge synthetic -$$Nest$sfgetLOCK()Ljava/lang/Object;
    .locals 1

    sget-object v0, Llocal/mio/os4camerabridge/LegendaryWatermarkUpdateBridge;->LOCK:Ljava/lang/Object;

    return-object v0
.end method

.method static bridge synthetic -$$Nest$sfgetMANUAL_CHANNEL()Ljava/lang/ThreadLocal;
    .locals 1

    sget-object v0, Llocal/mio/os4camerabridge/LegendaryWatermarkUpdateBridge;->MANUAL_CHANNEL:Ljava/lang/ThreadLocal;

    return-object v0
.end method

.method static bridge synthetic -$$Nest$sfgetdeadline()J
    .locals 2

    sget-wide v0, Llocal/mio/os4camerabridge/LegendaryWatermarkUpdateBridge;->deadline:J

    return-wide v0
.end method

.method static bridge synthetic -$$Nest$sfgetphotoPending()Z
    .locals 1

    sget-boolean v0, Llocal/mio/os4camerabridge/LegendaryWatermarkUpdateBridge;->photoPending:Z

    return v0
.end method

.method static bridge synthetic -$$Nest$sfgetrequestedAt()J
    .locals 2

    sget-wide v0, Llocal/mio/os4camerabridge/LegendaryWatermarkUpdateBridge;->requestedAt:J

    return-wide v0
.end method

.method static bridge synthetic -$$Nest$sfgetvideoPending()Z
    .locals 1

    sget-boolean v0, Llocal/mio/os4camerabridge/LegendaryWatermarkUpdateBridge;->videoPending:Z

    return v0
.end method

.method static bridge synthetic -$$Nest$sfputdeadline(J)V
    .locals 0

    sput-wide p0, Llocal/mio/os4camerabridge/LegendaryWatermarkUpdateBridge;->deadline:J

    return-void
.end method

.method static bridge synthetic -$$Nest$sfputphotoPending(Z)V
    .locals 0

    sput-boolean p0, Llocal/mio/os4camerabridge/LegendaryWatermarkUpdateBridge;->photoPending:Z

    return-void
.end method

.method static bridge synthetic -$$Nest$sfputrequestedAt(J)V
    .locals 0

    sput-wide p0, Llocal/mio/os4camerabridge/LegendaryWatermarkUpdateBridge;->requestedAt:J

    return-void
.end method

.method static bridge synthetic -$$Nest$sfputvideoPending(Z)V
    .locals 0

    sput-boolean p0, Llocal/mio/os4camerabridge/LegendaryWatermarkUpdateBridge;->videoPending:Z

    return-void
.end method

.method static bridge synthetic -$$Nest$smlog(Ljava/lang/String;)V
    .locals 0

    invoke-static {p0}, Llocal/mio/os4camerabridge/LegendaryWatermarkUpdateBridge;->log(Ljava/lang/String;)V

    return-void
.end method

.method static bridge synthetic -$$Nest$smmessage(Landroid/app/Activity;Ljava/lang/String;)V
    .locals 0

    invoke-static {p0, p1}, Llocal/mio/os4camerabridge/LegendaryWatermarkUpdateBridge;->message(Landroid/app/Activity;Ljava/lang/String;)V

    return-void
.end method

.method static constructor <clinit>()V
    .locals 1

    .line 17
    new-instance v0, Ljava/lang/Object;

    invoke-direct {v0}, Ljava/lang/Object;-><init>()V

    sput-object v0, Llocal/mio/os4camerabridge/LegendaryWatermarkUpdateBridge;->LOCK:Ljava/lang/Object;

    .line 20
    new-instance v0, Ljava/lang/ThreadLocal;

    invoke-direct {v0}, Ljava/lang/ThreadLocal;-><init>()V

    sput-object v0, Llocal/mio/os4camerabridge/LegendaryWatermarkUpdateBridge;->MANUAL_CHANNEL:Ljava/lang/ThreadLocal;

    .line 21
    new-instance v0, Ljava/lang/ThreadLocal;

    invoke-direct {v0}, Ljava/lang/ThreadLocal;-><init>()V

    sput-object v0, Llocal/mio/os4camerabridge/LegendaryWatermarkUpdateBridge;->FILTER_OWNER:Ljava/lang/ThreadLocal;

    return-void
.end method

.method private constructor <init>()V
    .locals 0

    .line 22
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method static install(Ljava/lang/ClassLoader;)V
    .locals 13
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/lang/Exception;
        }
    .end annotation

    .line 25
    const-string v0, "Kh.i"

    invoke-static {v0, p0}, Lde/robv/android/xposed/XposedHelpers;->findClass(Ljava/lang/String;Ljava/lang/ClassLoader;)Ljava/lang/Class;

    move-result-object v0

    .line 26
    const-string v1, "Gh.q"

    invoke-static {v1, p0}, Lde/robv/android/xposed/XposedHelpers;->findClass(Ljava/lang/String;Ljava/lang/ClassLoader;)Ljava/lang/Class;

    move-result-object v1

    .line 27
    const-string v2, "Te.g"

    invoke-static {v2, p0}, Lde/robv/android/xposed/XposedHelpers;->findClass(Ljava/lang/String;Ljava/lang/ClassLoader;)Ljava/lang/Class;

    move-result-object v2

    .line 28
    const-string v3, "Kh.f"

    invoke-static {v3, p0}, Lde/robv/android/xposed/XposedHelpers;->findClass(Ljava/lang/String;Ljava/lang/ClassLoader;)Ljava/lang/Class;

    move-result-object v3

    .line 29
    const-class v4, Ljava/lang/ref/WeakReference;

    const-class v5, Ljava/lang/Float;

    sget-object v6, Ljava/lang/Boolean;->TYPE:Ljava/lang/Class;

    sget-object v7, Ljava/lang/Boolean;->TYPE:Ljava/lang/Class;

    filled-new-array {v4, v5, v6, v7}, [Ljava/lang/Class;

    move-result-object v4

    const-string v5, "a"

    invoke-virtual {v0, v5, v4}, Ljava/lang/Class;->getDeclaredMethod(Ljava/lang/String;[Ljava/lang/Class;)Ljava/lang/reflect/Method;

    move-result-object v0

    .line 30
    const-class v4, Ljava/lang/String;

    filled-new-array {v1, v4}, [Ljava/lang/Class;

    move-result-object v4

    invoke-virtual {v1, v5, v4}, Ljava/lang/Class;->getDeclaredMethod(Ljava/lang/String;[Ljava/lang/Class;)Ljava/lang/reflect/Method;

    move-result-object v1

    .line 31
    const-class v4, Ljava/lang/String;

    sget-object v6, Ljava/lang/Boolean;->TYPE:Ljava/lang/Class;

    sget-object v7, Ljava/lang/Boolean;->TYPE:Ljava/lang/Class;

    filled-new-array {v4, v6, v7}, [Ljava/lang/Class;

    move-result-object v4

    const-string v6, "d"

    invoke-virtual {v2, v6, v4}, Ljava/lang/Class;->getDeclaredMethod(Ljava/lang/String;[Ljava/lang/Class;)Ljava/lang/reflect/Method;

    move-result-object v2

    .line 32
    const-class v4, Ljava/lang/Object;

    filled-new-array {v4}, [Ljava/lang/Class;

    move-result-object v4

    const-string v6, "invoke"

    invoke-virtual {v3, v6, v4}, Ljava/lang/Class;->getDeclaredMethod(Ljava/lang/String;[Ljava/lang/Class;)Ljava/lang/reflect/Method;

    move-result-object v3

    .line 33
    invoke-virtual {v0}, Ljava/lang/reflect/Method;->getReturnType()Ljava/lang/Class;

    move-result-object v4

    sget-object v6, Ljava/lang/Void;->TYPE:Ljava/lang/Class;

    if-ne v4, v6, :cond_0

    invoke-virtual {v1}, Ljava/lang/reflect/Method;->getReturnType()Ljava/lang/Class;

    move-result-object v4

    const-class v6, Ljava/lang/String;

    if-ne v4, v6, :cond_0

    .line 34
    invoke-virtual {v2}, Ljava/lang/reflect/Method;->getReturnType()Ljava/lang/Class;

    move-result-object v4

    invoke-virtual {v4}, Ljava/lang/Class;->getName()Ljava/lang/String;

    move-result-object v4

    const-string v6, "Qe.j"

    invoke-virtual {v4, v6}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v4

    if-eqz v4, :cond_0

    .line 36
    new-instance v4, Llocal/mio/os4camerabridge/LegendaryWatermarkUpdateBridge$1;

    invoke-direct {v4}, Llocal/mio/os4camerabridge/LegendaryWatermarkUpdateBridge$1;-><init>()V

    invoke-static {v0, v4}, Lde/robv/android/xposed/XposedBridge;->hookMethod(Ljava/lang/reflect/Member;Lde/robv/android/xposed/XC_MethodHook;)Lde/robv/android/xposed/XC_MethodHook$Unhook;

    .line 53
    new-instance v0, Llocal/mio/os4camerabridge/LegendaryWatermarkUpdateBridge$2;

    invoke-direct {v0}, Llocal/mio/os4camerabridge/LegendaryWatermarkUpdateBridge$2;-><init>()V

    invoke-static {v1, v0}, Lde/robv/android/xposed/XposedBridge;->hookMethod(Ljava/lang/reflect/Member;Lde/robv/android/xposed/XC_MethodHook;)Lde/robv/android/xposed/XC_MethodHook$Unhook;

    .line 68
    new-instance v0, Llocal/mio/os4camerabridge/LegendaryWatermarkUpdateBridge$3;

    invoke-direct {v0}, Llocal/mio/os4camerabridge/LegendaryWatermarkUpdateBridge$3;-><init>()V

    invoke-static {v2, v0}, Lde/robv/android/xposed/XposedBridge;->hookMethod(Ljava/lang/reflect/Member;Lde/robv/android/xposed/XC_MethodHook;)Lde/robv/android/xposed/XC_MethodHook$Unhook;

    .line 84
    new-instance v0, Llocal/mio/os4camerabridge/LegendaryWatermarkUpdateBridge$4;

    invoke-direct {v0}, Llocal/mio/os4camerabridge/LegendaryWatermarkUpdateBridge$4;-><init>()V

    invoke-static {v3, v0}, Lde/robv/android/xposed/XposedBridge;->hookMethod(Ljava/lang/reflect/Member;Lde/robv/android/xposed/XC_MethodHook;)Lde/robv/android/xposed/XC_MethodHook$Unhook;

    .line 95
    invoke-static {p0}, Llocal/mio/os4camerabridge/LegendaryWatermarkUpdateBridge;->preserveLocalTemplate(Ljava/lang/ClassLoader;)V

    .line 96
    const-string v0, "com.xiaomi.camera.cloudwatermark.nativebridge.WmNativeFilter"

    invoke-static {v0, p0}, Lde/robv/android/xposed/XposedHelpers;->findClass(Ljava/lang/String;Ljava/lang/ClassLoader;)Ljava/lang/Class;

    move-result-object p0

    .line 97
    const-class v6, Ljava/lang/String;

    const-class v7, Ljava/lang/String;

    sget-object v8, Ljava/lang/Boolean;->TYPE:Ljava/lang/Class;

    sget-object v9, Ljava/lang/Boolean;->TYPE:Ljava/lang/Class;

    sget-object v10, Ljava/lang/Float;->TYPE:Ljava/lang/Class;

    sget-object v11, Ljava/lang/Long;->TYPE:Ljava/lang/Class;

    sget-object v12, Ljava/lang/Integer;->TYPE:Ljava/lang/Class;

    filled-new-array/range {v6 .. v12}, [Ljava/lang/Class;

    move-result-object v0

    invoke-virtual {p0, v5, v0}, Ljava/lang/Class;->getDeclaredMethod(Ljava/lang/String;[Ljava/lang/Class;)Ljava/lang/reflect/Method;

    move-result-object p0

    new-instance v0, Llocal/mio/os4camerabridge/LegendaryWatermarkUpdateBridge$5;

    invoke-direct {v0}, Llocal/mio/os4camerabridge/LegendaryWatermarkUpdateBridge$5;-><init>()V

    invoke-static {p0, v0}, Lde/robv/android/xposed/XposedBridge;->hookMethod(Ljava/lang/reflect/Member;Lde/robv/android/xposed/XC_MethodHook;)Lde/robv/android/xposed/XC_MethodHook$Unhook;

    .line 105
    const-string p0, "installed manual-only refresh and explicit no-result feedback; native server filtering retained"

    invoke-static {p0}, Llocal/mio/os4camerabridge/LegendaryWatermarkUpdateBridge;->log(Ljava/lang/String;)V

    .line 106
    return-void

    .line 34
    :cond_0
    new-instance p0, Ljava/lang/IllegalStateException;

    const-string v0, "native refresh contract changed"

    invoke-direct {p0, v0}, Ljava/lang/IllegalStateException;-><init>(Ljava/lang/String;)V

    throw p0
.end method

.method static synthetic lambda$message$0(Landroid/app/Activity;Ljava/lang/String;)V
    .locals 1

    .line 129
    const/4 v0, 0x0

    invoke-static {p0, p1, v0}, Landroid/widget/Toast;->makeText(Landroid/content/Context;Ljava/lang/CharSequence;I)Landroid/widget/Toast;

    move-result-object p0

    invoke-virtual {p0}, Landroid/widget/Toast;->show()V

    return-void
.end method

.method private static log(Ljava/lang/String;)V
    .locals 2

    .line 131
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "[WatermarkUpdate] "

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, p0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p0

    invoke-virtual {p0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p0

    invoke-static {p0}, Lde/robv/android/xposed/XposedBridge;->log(Ljava/lang/String;)V

    return-void
.end method

.method private static message(Landroid/app/Activity;Ljava/lang/String;)V
    .locals 1

    .line 128
    if-eqz p0, :cond_1

    invoke-virtual {p0}, Landroid/app/Activity;->isFinishing()Z

    move-result v0

    if-nez v0, :cond_1

    invoke-virtual {p0}, Landroid/app/Activity;->isDestroyed()Z

    move-result v0

    if-eqz v0, :cond_0

    goto :goto_0

    .line 129
    :cond_0
    new-instance v0, Llocal/mio/os4camerabridge/LegendaryWatermarkUpdateBridge$$ExternalSyntheticLambda0;

    invoke-direct {v0, p0, p1}, Llocal/mio/os4camerabridge/LegendaryWatermarkUpdateBridge$$ExternalSyntheticLambda0;-><init>(Landroid/app/Activity;Ljava/lang/String;)V

    invoke-virtual {p0, v0}, Landroid/app/Activity;->runOnUiThread(Ljava/lang/Runnable;)V

    .line 130
    return-void

    .line 128
    :cond_1
    :goto_0
    return-void
.end method

.method private static preserveLocalTemplate(Ljava/lang/ClassLoader;)V
    .locals 2
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/lang/Exception;
        }
    .end annotation

    .line 109
    const-string v0, "Gg.P"

    invoke-static {v0, p0}, Lde/robv/android/xposed/XposedHelpers;->findClass(Ljava/lang/String;Ljava/lang/ClassLoader;)Ljava/lang/Class;

    move-result-object p0

    .line 110
    sget-object v0, Ljava/lang/Boolean;->TYPE:Ljava/lang/Class;

    filled-new-array {v0}, [Ljava/lang/Class;

    move-result-object v0

    const-string v1, "d"

    invoke-virtual {p0, v1, v0}, Ljava/lang/Class;->getDeclaredMethod(Ljava/lang/String;[Ljava/lang/Class;)Ljava/lang/reflect/Method;

    move-result-object v0

    new-instance v1, Llocal/mio/os4camerabridge/LegendaryWatermarkUpdateBridge$6;

    invoke-direct {v1}, Llocal/mio/os4camerabridge/LegendaryWatermarkUpdateBridge$6;-><init>()V

    invoke-static {v0, v1}, Lde/robv/android/xposed/XposedBridge;->hookMethod(Ljava/lang/reflect/Member;Lde/robv/android/xposed/XC_MethodHook;)Lde/robv/android/xposed/XC_MethodHook$Unhook;

    .line 118
    const/4 v0, 0x0

    new-array v0, v0, [Ljava/lang/Class;

    const-string v1, "f"

    invoke-virtual {p0, v1, v0}, Ljava/lang/Class;->getDeclaredMethod(Ljava/lang/String;[Ljava/lang/Class;)Ljava/lang/reflect/Method;

    move-result-object p0

    new-instance v0, Llocal/mio/os4camerabridge/LegendaryWatermarkUpdateBridge$7;

    invoke-direct {v0}, Llocal/mio/os4camerabridge/LegendaryWatermarkUpdateBridge$7;-><init>()V

    invoke-static {p0, v0}, Lde/robv/android/xposed/XposedBridge;->hookMethod(Ljava/lang/reflect/Member;Lde/robv/android/xposed/XC_MethodHook;)Lde/robv/android/xposed/XC_MethodHook$Unhook;

    .line 126
    return-void
.end method
