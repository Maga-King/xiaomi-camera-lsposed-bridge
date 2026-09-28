.class Llocal/mio/os4camerabridge/JpegChainProbe$3;
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

    .line 66
    invoke-direct {p0, p1}, Lde/robv/android/xposed/XC_MethodHook;-><init>(I)V

    return-void
.end method


# virtual methods
.method protected afterHookedMethod(Lde/robv/android/xposed/XC_MethodHook$MethodHookParam;)V
    .locals 4

    .line 75
    const-string v0, "local.mio.jpegChainProbe"

    invoke-virtual {p1, v0}, Lde/robv/android/xposed/XC_MethodHook$MethodHookParam;->getObjectExtra(Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v0

    .line 76
    instance-of v1, v0, [Ljava/lang/Object;

    if-nez v1, :cond_0

    return-void

    .line 78
    :cond_0
    const/4 v1, 0x0

    :try_start_0
    const-string v2, "exif-out"

    iget-object v3, p1, Lde/robv/android/xposed/XC_MethodHook$MethodHookParam;->args:[Ljava/lang/Object;

    aget-object v3, v3, v1

    invoke-virtual {p1}, Lde/robv/android/xposed/XC_MethodHook$MethodHookParam;->hasThrowable()Z

    move-result p1

    invoke-static {v2, v3, p1}, Llocal/mio/os4camerabridge/JpegChainProbe;->-$$Nest$sminspectTask(Ljava/lang/String;Ljava/lang/Object;Z)V
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 80
    check-cast v0, [Ljava/lang/Object;

    aget-object p1, v0, v1

    .line 81
    if-nez p1, :cond_1

    invoke-static {}, Llocal/mio/os4camerabridge/JpegChainProbe;->-$$Nest$sfgetEXIF_TASK()Ljava/lang/ThreadLocal;

    move-result-object p1

    invoke-virtual {p1}, Ljava/lang/ThreadLocal;->remove()V

    goto :goto_0

    :cond_1
    invoke-static {}, Llocal/mio/os4camerabridge/JpegChainProbe;->-$$Nest$sfgetEXIF_TASK()Ljava/lang/ThreadLocal;

    move-result-object v0

    invoke-virtual {v0, p1}, Ljava/lang/ThreadLocal;->set(Ljava/lang/Object;)V

    .line 82
    :goto_0
    nop

    .line 83
    return-void

    .line 80
    :catchall_0
    move-exception p1

    check-cast v0, [Ljava/lang/Object;

    aget-object v0, v0, v1

    .line 81
    if-nez v0, :cond_2

    invoke-static {}, Llocal/mio/os4camerabridge/JpegChainProbe;->-$$Nest$sfgetEXIF_TASK()Ljava/lang/ThreadLocal;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/ThreadLocal;->remove()V

    goto :goto_1

    :cond_2
    invoke-static {}, Llocal/mio/os4camerabridge/JpegChainProbe;->-$$Nest$sfgetEXIF_TASK()Ljava/lang/ThreadLocal;

    move-result-object v1

    invoke-virtual {v1, v0}, Ljava/lang/ThreadLocal;->set(Ljava/lang/Object;)V

    .line 82
    :goto_1
    throw p1
.end method

.method protected beforeHookedMethod(Lde/robv/android/xposed/XC_MethodHook$MethodHookParam;)V
    .locals 3

    .line 68
    invoke-static {}, Llocal/mio/os4camerabridge/JpegChainProbe;->-$$Nest$sfgetEXIF_CALLS()Ljava/util/concurrent/atomic/AtomicInteger;

    move-result-object v0

    invoke-virtual {v0}, Ljava/util/concurrent/atomic/AtomicInteger;->incrementAndGet()I

    move-result v0

    const/16 v1, 0x18

    if-le v0, v1, :cond_0

    return-void

    .line 70
    :cond_0
    invoke-static {}, Llocal/mio/os4camerabridge/JpegChainProbe;->-$$Nest$sfgetEXIF_TASK()Ljava/lang/ThreadLocal;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/ThreadLocal;->get()Ljava/lang/Object;

    move-result-object v0

    filled-new-array {v0}, [Ljava/lang/Object;

    move-result-object v0

    const-string v1, "local.mio.jpegChainProbe"

    invoke-virtual {p1, v1, v0}, Lde/robv/android/xposed/XC_MethodHook$MethodHookParam;->setObjectExtra(Ljava/lang/String;Ljava/lang/Object;)V

    .line 71
    invoke-static {}, Llocal/mio/os4camerabridge/JpegChainProbe;->-$$Nest$sfgetEXIF_TASK()Ljava/lang/ThreadLocal;

    move-result-object v0

    iget-object v1, p1, Lde/robv/android/xposed/XC_MethodHook$MethodHookParam;->args:[Ljava/lang/Object;

    const/4 v2, 0x0

    aget-object v1, v1, v2

    invoke-virtual {v0, v1}, Ljava/lang/ThreadLocal;->set(Ljava/lang/Object;)V

    .line 72
    iget-object p1, p1, Lde/robv/android/xposed/XC_MethodHook$MethodHookParam;->args:[Ljava/lang/Object;

    aget-object p1, p1, v2

    const-string v0, "exif-in"

    invoke-static {v0, p1, v2}, Llocal/mio/os4camerabridge/JpegChainProbe;->-$$Nest$sminspectTask(Ljava/lang/String;Ljava/lang/Object;Z)V

    .line 73
    return-void
.end method
