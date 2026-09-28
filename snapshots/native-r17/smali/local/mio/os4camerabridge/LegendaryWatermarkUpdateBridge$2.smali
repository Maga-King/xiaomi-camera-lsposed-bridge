.class Llocal/mio/os4camerabridge/LegendaryWatermarkUpdateBridge$2;
.super Lde/robv/android/xposed/XC_MethodHook;
.source "LegendaryWatermarkUpdateBridge.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Llocal/mio/os4camerabridge/LegendaryWatermarkUpdateBridge;->install(Ljava/lang/ClassLoader;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# direct methods
.method constructor <init>()V
    .locals 0

    .line 53
    invoke-direct {p0}, Lde/robv/android/xposed/XC_MethodHook;-><init>()V

    return-void
.end method


# virtual methods
.method protected afterHookedMethod(Lde/robv/android/xposed/XC_MethodHook$MethodHookParam;)V
    .locals 2

    .line 65
    sget-object v0, Ljava/lang/Boolean;->TRUE:Ljava/lang/Boolean;

    const-string v1, "manual"

    invoke-virtual {p1, v1}, Lde/robv/android/xposed/XC_MethodHook$MethodHookParam;->getObjectExtra(Ljava/lang/String;)Ljava/lang/Object;

    move-result-object p1

    invoke-virtual {v0, p1}, Ljava/lang/Boolean;->equals(Ljava/lang/Object;)Z

    move-result p1

    if-eqz p1, :cond_0

    invoke-static {}, Llocal/mio/os4camerabridge/LegendaryWatermarkUpdateBridge;->-$$Nest$sfgetMANUAL_CHANNEL()Ljava/lang/ThreadLocal;

    move-result-object p1

    invoke-virtual {p1}, Ljava/lang/ThreadLocal;->remove()V

    .line 66
    :cond_0
    return-void
.end method

.method protected beforeHookedMethod(Lde/robv/android/xposed/XC_MethodHook$MethodHookParam;)V
    .locals 7

    .line 55
    invoke-static {}, Landroid/os/Looper;->myLooper()Landroid/os/Looper;

    move-result-object v0

    invoke-static {}, Landroid/os/Looper;->getMainLooper()Landroid/os/Looper;

    move-result-object v1

    if-ne v0, v1, :cond_0

    return-void

    .line 56
    :cond_0
    iget-object v0, p1, Lde/robv/android/xposed/XC_MethodHook$MethodHookParam;->args:[Ljava/lang/Object;

    const/4 v1, 0x1

    aget-object v0, v0, v1

    check-cast v0, Ljava/lang/String;

    .line 57
    invoke-static {}, Llocal/mio/os4camerabridge/LegendaryWatermarkUpdateBridge;->-$$Nest$sfgetLOCK()Ljava/lang/Object;

    move-result-object v2

    monitor-enter v2

    .line 58
    :try_start_0
    invoke-static {}, Landroid/os/SystemClock;->elapsedRealtime()J

    move-result-wide v3

    invoke-static {}, Llocal/mio/os4camerabridge/LegendaryWatermarkUpdateBridge;->-$$Nest$sfgetdeadline()J

    move-result-wide v5

    cmp-long v3, v3, v5

    if-lez v3, :cond_1

    monitor-exit v2

    return-void

    .line 59
    :cond_1
    invoke-static {}, Llocal/mio/os4camerabridge/LegendaryWatermarkUpdateBridge;->-$$Nest$sfgetphotoPending()Z

    move-result v3

    const/4 v4, 0x0

    if-eqz v3, :cond_2

    const-string v3, "watermark_config"

    invoke-virtual {v3, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v3

    if-eqz v3, :cond_2

    invoke-static {v4}, Llocal/mio/os4camerabridge/LegendaryWatermarkUpdateBridge;->-$$Nest$sfputphotoPending(Z)V

    move v3, v1

    goto :goto_0

    .line 60
    :cond_2
    move v3, v4

    :goto_0
    invoke-static {}, Llocal/mio/os4camerabridge/LegendaryWatermarkUpdateBridge;->-$$Nest$sfgetvideoPending()Z

    move-result v5

    if-eqz v5, :cond_3

    const-string v5, "video_watermark_config"

    invoke-virtual {v5, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v5

    if-eqz v5, :cond_3

    invoke-static {v4}, Llocal/mio/os4camerabridge/LegendaryWatermarkUpdateBridge;->-$$Nest$sfputvideoPending(Z)V

    move v3, v1

    .line 61
    :cond_3
    monitor-exit v2
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 62
    if-eqz v3, :cond_4

    const-string v2, "manual"

    invoke-static {v1}, Ljava/lang/Boolean;->valueOf(Z)Ljava/lang/Boolean;

    move-result-object v1

    invoke-virtual {p1, v2, v1}, Lde/robv/android/xposed/XC_MethodHook$MethodHookParam;->setObjectExtra(Ljava/lang/String;Ljava/lang/Object;)V

    invoke-static {}, Llocal/mio/os4camerabridge/LegendaryWatermarkUpdateBridge;->-$$Nest$sfgetMANUAL_CHANNEL()Ljava/lang/ThreadLocal;

    move-result-object p1

    invoke-virtual {p1, v0}, Ljava/lang/ThreadLocal;->set(Ljava/lang/Object;)V

    .line 63
    :cond_4
    return-void

    .line 61
    :catchall_0
    move-exception p1

    :try_start_1
    monitor-exit v2
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    throw p1
.end method
