.class Llocal/mio/os4camerabridge/LegendaryWatermarkUpdateBridge$1;
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

    .line 36
    invoke-direct {p0}, Lde/robv/android/xposed/XC_MethodHook;-><init>()V

    return-void
.end method


# virtual methods
.method protected beforeHookedMethod(Lde/robv/android/xposed/XC_MethodHook$MethodHookParam;)V
    .locals 8

    .line 38
    sget-object v0, Ljava/lang/Boolean;->TRUE:Ljava/lang/Boolean;

    iget-object v1, p1, Lde/robv/android/xposed/XC_MethodHook$MethodHookParam;->args:[Ljava/lang/Object;

    const/4 v2, 0x2

    aget-object v1, v1, v2

    invoke-virtual {v0, v1}, Ljava/lang/Boolean;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-nez v0, :cond_0

    return-void

    .line 39
    :cond_0
    iget-object v0, p1, Lde/robv/android/xposed/XC_MethodHook$MethodHookParam;->args:[Ljava/lang/Object;

    const/4 v1, 0x0

    aget-object v0, v0, v1

    check-cast v0, Ljava/lang/ref/WeakReference;

    invoke-virtual {v0}, Ljava/lang/ref/WeakReference;->get()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Landroid/app/Activity;

    .line 40
    if-eqz v0, :cond_3

    invoke-virtual {v0}, Landroid/app/Activity;->isFinishing()Z

    move-result v1

    if-nez v1, :cond_3

    invoke-virtual {v0}, Landroid/app/Activity;->isDestroyed()Z

    move-result v1

    if-eqz v1, :cond_1

    goto :goto_0

    .line 41
    :cond_1
    invoke-static {}, Landroid/os/SystemClock;->elapsedRealtime()J

    move-result-wide v1

    .line 42
    invoke-static {}, Llocal/mio/os4camerabridge/LegendaryWatermarkUpdateBridge;->-$$Nest$sfgetLOCK()Ljava/lang/Object;

    move-result-object v3

    monitor-enter v3

    .line 43
    :try_start_0
    invoke-static {}, Llocal/mio/os4camerabridge/LegendaryWatermarkUpdateBridge;->-$$Nest$sfgetrequestedAt()J

    move-result-wide v4

    const-wide/16 v6, 0x0

    cmp-long v4, v4, v6

    if-eqz v4, :cond_2

    invoke-static {}, Llocal/mio/os4camerabridge/LegendaryWatermarkUpdateBridge;->-$$Nest$sfgetrequestedAt()J

    move-result-wide v4

    sub-long v4, v1, v4

    const-wide/16 v6, 0x7530

    cmp-long v4, v4, v6

    if-gez v4, :cond_2

    .line 44
    const/4 v1, 0x0

    invoke-virtual {p1, v1}, Lde/robv/android/xposed/XC_MethodHook$MethodHookParam;->setResult(Ljava/lang/Object;)V

    const-string p1, "\u6b63\u5728\u68c0\u67e5\u6216\u521a\u521a\u68c0\u67e5\u8fc7\uff0c\u8bf7\u7a0d\u540e\u518d\u8bd5"

    invoke-static {v0, p1}, Llocal/mio/os4camerabridge/LegendaryWatermarkUpdateBridge;->-$$Nest$smmessage(Landroid/app/Activity;Ljava/lang/String;)V

    monitor-exit v3

    return-void

    .line 46
    :cond_2
    invoke-static {v1, v2}, Llocal/mio/os4camerabridge/LegendaryWatermarkUpdateBridge;->-$$Nest$sfputrequestedAt(J)V

    const-wide/16 v4, 0x3a98

    add-long/2addr v1, v4

    invoke-static {v1, v2}, Llocal/mio/os4camerabridge/LegendaryWatermarkUpdateBridge;->-$$Nest$sfputdeadline(J)V

    .line 47
    const/4 v1, 0x1

    invoke-static {v1}, Llocal/mio/os4camerabridge/LegendaryWatermarkUpdateBridge;->-$$Nest$sfputphotoPending(Z)V

    sget-object v1, Ljava/lang/Boolean;->TRUE:Ljava/lang/Boolean;

    iget-object p1, p1, Lde/robv/android/xposed/XC_MethodHook$MethodHookParam;->args:[Ljava/lang/Object;

    const/4 v2, 0x3

    aget-object p1, p1, v2

    invoke-virtual {v1, p1}, Ljava/lang/Boolean;->equals(Ljava/lang/Object;)Z

    move-result p1

    invoke-static {p1}, Llocal/mio/os4camerabridge/LegendaryWatermarkUpdateBridge;->-$$Nest$sfputvideoPending(Z)V

    .line 48
    monitor-exit v3
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 49
    const-string p1, "\u6b63\u5728\u68c0\u67e5\u6c34\u5370\u66f4\u65b0"

    invoke-static {v0, p1}, Llocal/mio/os4camerabridge/LegendaryWatermarkUpdateBridge;->-$$Nest$smmessage(Landroid/app/Activity;Ljava/lang/String;)V

    .line 50
    const-string p1, "manual refresh armed; 30s debounce; no background interval/device-config change"

    invoke-static {p1}, Llocal/mio/os4camerabridge/LegendaryWatermarkUpdateBridge;->-$$Nest$smlog(Ljava/lang/String;)V

    .line 51
    return-void

    .line 48
    :catchall_0
    move-exception p1

    :try_start_1
    monitor-exit v3
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    throw p1

    .line 40
    :cond_3
    :goto_0
    return-void
.end method
