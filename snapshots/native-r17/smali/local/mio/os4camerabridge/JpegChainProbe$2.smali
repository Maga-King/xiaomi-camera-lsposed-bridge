.class Llocal/mio/os4camerabridge/JpegChainProbe$2;
.super Lde/robv/android/xposed/XC_MethodHook;
.source "JpegChainProbe.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Llocal/mio/os4camerabridge/JpegChainProbe;->install(Ljava/lang/ClassLoader;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# direct methods
.method constructor <init>(I)V
    .locals 0

    .line 55
    invoke-direct {p0, p1}, Lde/robv/android/xposed/XC_MethodHook;-><init>(I)V

    return-void
.end method


# virtual methods
.method protected afterHookedMethod(Lde/robv/android/xposed/XC_MethodHook$MethodHookParam;)V
    .locals 2

    .line 62
    const-string v0, "local.mio.jpegChainProbe"

    invoke-virtual {p1, v0}, Lde/robv/android/xposed/XC_MethodHook$MethodHookParam;->getObjectExtra(Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v0

    if-eqz v0, :cond_0

    .line 63
    iget-object v0, p1, Lde/robv/android/xposed/XC_MethodHook$MethodHookParam;->args:[Ljava/lang/Object;

    const/4 v1, 0x0

    aget-object v0, v0, v1

    invoke-virtual {p1}, Lde/robv/android/xposed/XC_MethodHook$MethodHookParam;->hasThrowable()Z

    move-result p1

    const-string v1, "water-out"

    invoke-static {v1, v0, p1}, Llocal/mio/os4camerabridge/JpegChainProbe;->-$$Nest$sminspectTask(Ljava/lang/String;Ljava/lang/Object;Z)V

    .line 64
    :cond_0
    return-void
.end method

.method protected beforeHookedMethod(Lde/robv/android/xposed/XC_MethodHook$MethodHookParam;)V
    .locals 2

    .line 57
    invoke-static {}, Llocal/mio/os4camerabridge/JpegChainProbe;->-$$Nest$sfgetWATER_CALLS()Ljava/util/concurrent/atomic/AtomicInteger;

    move-result-object v0

    invoke-virtual {v0}, Ljava/util/concurrent/atomic/AtomicInteger;->incrementAndGet()I

    move-result v0

    const/16 v1, 0x18

    if-le v0, v1, :cond_0

    return-void

    .line 58
    :cond_0
    const-string v0, "local.mio.jpegChainProbe"

    sget-object v1, Ljava/lang/Boolean;->TRUE:Ljava/lang/Boolean;

    invoke-virtual {p1, v0, v1}, Lde/robv/android/xposed/XC_MethodHook$MethodHookParam;->setObjectExtra(Ljava/lang/String;Ljava/lang/Object;)V

    .line 59
    iget-object p1, p1, Lde/robv/android/xposed/XC_MethodHook$MethodHookParam;->args:[Ljava/lang/Object;

    const/4 v0, 0x0

    aget-object p1, p1, v0

    const-string v1, "water-in"

    invoke-static {v1, p1, v0}, Llocal/mio/os4camerabridge/JpegChainProbe;->-$$Nest$sminspectTask(Ljava/lang/String;Ljava/lang/Object;Z)V

    .line 60
    return-void
.end method
