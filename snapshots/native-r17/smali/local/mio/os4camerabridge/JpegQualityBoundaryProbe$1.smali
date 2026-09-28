.class Llocal/mio/os4camerabridge/JpegQualityBoundaryProbe$1;
.super Lde/robv/android/xposed/XC_MethodHook;
.source "JpegQualityBoundaryProbe.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Llocal/mio/os4camerabridge/JpegQualityBoundaryProbe;->install(Ljava/lang/ClassLoader;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# direct methods
.method constructor <init>(I)V
    .locals 0

    .line 46
    invoke-direct {p0, p1}, Lde/robv/android/xposed/XC_MethodHook;-><init>(I)V

    return-void
.end method


# virtual methods
.method protected afterHookedMethod(Lde/robv/android/xposed/XC_MethodHook$MethodHookParam;)V
    .locals 7

    .line 65
    const-string v0, "local.mio.jpegQualitySample"

    invoke-virtual {p1, v0}, Lde/robv/android/xposed/XC_MethodHook$MethodHookParam;->getObjectExtra(Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v0

    .line 66
    instance-of v1, v0, Llocal/mio/os4camerabridge/JpegQualityBoundaryProbe$Sample;

    if-nez v1, :cond_0

    return-void

    .line 68
    :cond_0
    const/4 v1, 0x0

    :try_start_0
    iget-object v2, p1, Lde/robv/android/xposed/XC_MethodHook$MethodHookParam;->thisObject:Ljava/lang/Object;

    const-string v3, "a"

    invoke-static {v2, v3}, Lde/robv/android/xposed/XposedHelpers;->getObjectField(Ljava/lang/Object;Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v2

    .line 69
    const-string v3, "i"

    invoke-static {v2, v3}, Lde/robv/android/xposed/XposedHelpers;->getObjectField(Ljava/lang/Object;Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v2

    .line 70
    invoke-static {v2}, Llocal/mio/os4camerabridge/JpegQualityBoundaryProbe;->-$$Nest$smjpeg(Ljava/lang/Object;)Z

    move-result v3

    if-eqz v3, :cond_1

    check-cast v2, [B

    invoke-virtual {v2}, [B->clone()Ljava/lang/Object;

    move-result-object v2

    check-cast v2, [B

    goto :goto_0

    :cond_1
    move-object v2, v1

    .line 71
    :goto_0
    move-object v3, v0

    check-cast v3, Llocal/mio/os4camerabridge/JpegQualityBoundaryProbe$Sample;

    .line 72
    invoke-virtual {p1}, Lde/robv/android/xposed/XC_MethodHook$MethodHookParam;->hasThrowable()Z

    move-result v4

    iget-object p1, p1, Lde/robv/android/xposed/XC_MethodHook$MethodHookParam;->thisObject:Ljava/lang/Object;

    invoke-static {p1}, Llocal/mio/os4camerabridge/JpegQualityBoundaryProbe;->-$$Nest$smtaskInfo(Ljava/lang/Object;)Ljava/lang/String;

    move-result-object p1

    new-instance v5, Ljava/lang/StringBuilder;

    invoke-direct {v5}, Ljava/lang/StringBuilder;-><init>()V

    const-string v6, "failed="

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5, v4}, Ljava/lang/StringBuilder;->append(Z)Ljava/lang/StringBuilder;

    move-result-object v4

    const-string v5, " "

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p1

    invoke-virtual {p1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p1

    .line 71
    invoke-static {v3, v2, p1}, Llocal/mio/os4camerabridge/JpegQualityBoundaryProbe;->-$$Nest$smsubmit(Llocal/mio/os4camerabridge/JpegQualityBoundaryProbe$Sample;[BLjava/lang/String;)V
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 75
    goto :goto_1

    .line 73
    :catchall_0
    move-exception p1

    .line 74
    check-cast v0, Llocal/mio/os4camerabridge/JpegQualityBoundaryProbe$Sample;

    invoke-static {p1}, Ljava/lang/String;->valueOf(Ljava/lang/Object;)Ljava/lang/String;

    move-result-object p1

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "after-unavailable="

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p1

    invoke-virtual {p1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p1

    invoke-static {v0, v1, p1}, Llocal/mio/os4camerabridge/JpegQualityBoundaryProbe;->-$$Nest$smsubmit(Llocal/mio/os4camerabridge/JpegQualityBoundaryProbe$Sample;[BLjava/lang/String;)V

    .line 76
    :goto_1
    return-void
.end method

.method protected beforeHookedMethod(Lde/robv/android/xposed/XC_MethodHook$MethodHookParam;)V
    .locals 7

    .line 49
    const/4 v0, 0x0

    :try_start_0
    invoke-static {v0}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v1

    iget-object v2, p1, Lde/robv/android/xposed/XC_MethodHook$MethodHookParam;->args:[Ljava/lang/Object;

    aget-object v2, v2, v0

    invoke-virtual {v1, v2}, Ljava/lang/Integer;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-eqz v1, :cond_5

    iget-object v1, p1, Lde/robv/android/xposed/XC_MethodHook$MethodHookParam;->args:[Ljava/lang/Object;

    const/4 v2, 0x1

    aget-object v1, v1, v2

    invoke-static {v1}, Llocal/mio/os4camerabridge/JpegQualityBoundaryProbe;->-$$Nest$smjpeg(Ljava/lang/Object;)Z

    move-result v1

    if-nez v1, :cond_0

    goto/16 :goto_2

    .line 50
    :cond_0
    invoke-static {}, Llocal/mio/os4camerabridge/JpegQualityBoundaryProbe;->-$$Nest$sfgetentry()Ljava/lang/Class;

    move-result-object v1

    const-string v3, "activeCameraModule"

    invoke-static {v1, v3}, Lde/robv/android/xposed/XposedHelpers;->getStaticIntField(Ljava/lang/Class;Ljava/lang/String;)I

    move-result v1

    .line 51
    const/16 v3, 0xa7

    const/16 v4, 0x100

    if-eq v1, v3, :cond_1

    if-eq v1, v4, :cond_1

    const/16 v3, 0xa3

    if-eq v1, v3, :cond_1

    return-void

    .line 52
    :cond_1
    invoke-static {}, Llocal/mio/os4camerabridge/JpegQualityBoundaryProbe;->-$$Nest$sfgetentry()Ljava/lang/Class;

    move-result-object v3

    const-string v5, "activeCameraId"

    invoke-static {v3, v5}, Lde/robv/android/xposed/XposedHelpers;->getStaticIntField(Ljava/lang/Class;Ljava/lang/String;)I

    move-result v3

    .line 53
    if-ne v1, v4, :cond_2

    .line 54
    invoke-static {}, Llocal/mio/os4camerabridge/JpegQualityBoundaryProbe;->-$$Nest$sfgetentry()Ljava/lang/Class;

    move-result-object v0

    const-string v4, "activeLegendMode"

    invoke-static {v0, v4}, Lde/robv/android/xposed/XposedHelpers;->getStaticIntField(Ljava/lang/Class;Ljava/lang/String;)I

    move-result v0

    goto :goto_0

    :cond_2
    nop

    .line 55
    :goto_0
    new-instance v4, Ljava/lang/StringBuilder;

    invoke-direct {v4}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v4, v1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v4, "_"

    invoke-virtual {v1, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, v3}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v3, "_"

    invoke-virtual {v1, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, v0}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    .line 56
    invoke-static {}, Llocal/mio/os4camerabridge/JpegQualityBoundaryProbe;->-$$Nest$sfgetCLAIMED()Ljava/util/Set;

    move-result-object v1

    monitor-enter v1
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_1

    .line 57
    :try_start_1
    invoke-static {}, Llocal/mio/os4camerabridge/JpegQualityBoundaryProbe;->-$$Nest$sfgetCLAIMED()Ljava/util/Set;

    move-result-object v3

    invoke-interface {v3}, Ljava/util/Set;->size()I

    move-result v3

    const/4 v4, 0x6

    if-ge v3, v4, :cond_4

    invoke-static {}, Llocal/mio/os4camerabridge/JpegQualityBoundaryProbe;->-$$Nest$sfgetCLAIMED()Ljava/util/Set;

    move-result-object v3

    invoke-interface {v3, v0}, Ljava/util/Set;->add(Ljava/lang/Object;)Z

    move-result v3

    if-nez v3, :cond_3

    goto :goto_1

    .line 58
    :cond_3
    monitor-exit v1
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    .line 59
    :try_start_2
    iget-object v1, p1, Lde/robv/android/xposed/XC_MethodHook$MethodHookParam;->args:[Ljava/lang/Object;

    aget-object v1, v1, v2

    check-cast v1, [B

    invoke-virtual {v1}, [B->clone()Ljava/lang/Object;

    move-result-object v1

    check-cast v1, [B

    .line 60
    const-string v2, "local.mio.jpegQualitySample"

    new-instance v3, Llocal/mio/os4camerabridge/JpegQualityBoundaryProbe$Sample;

    invoke-static {}, Landroid/os/SystemClock;->elapsedRealtime()J

    move-result-wide v4

    new-instance v6, Ljava/lang/StringBuilder;

    invoke-direct {v6}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v6, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v6, "_"

    invoke-virtual {v0, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, v4, v5}, Ljava/lang/StringBuilder;->append(J)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    iget-object v4, p1, Lde/robv/android/xposed/XC_MethodHook$MethodHookParam;->thisObject:Ljava/lang/Object;

    .line 61
    invoke-static {v4}, Llocal/mio/os4camerabridge/JpegQualityBoundaryProbe;->-$$Nest$smtaskInfo(Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v4

    invoke-direct {v3, v0, v1, v4}, Llocal/mio/os4camerabridge/JpegQualityBoundaryProbe$Sample;-><init>(Ljava/lang/String;[BLjava/lang/String;)V

    .line 60
    invoke-virtual {p1, v2, v3}, Lde/robv/android/xposed/XC_MethodHook$MethodHookParam;->setObjectExtra(Ljava/lang/String;Ljava/lang/Object;)V
    :try_end_2
    .catchall {:try_start_2 .. :try_end_2} :catchall_1

    .line 62
    goto :goto_3

    .line 57
    :cond_4
    :goto_1
    :try_start_3
    monitor-exit v1

    return-void

    .line 58
    :catchall_0
    move-exception p1

    monitor-exit v1
    :try_end_3
    .catchall {:try_start_3 .. :try_end_3} :catchall_0

    :try_start_4
    throw p1
    :try_end_4
    .catchall {:try_start_4 .. :try_end_4} :catchall_1

    .line 49
    :cond_5
    :goto_2
    return-void

    .line 62
    :catchall_1
    move-exception p1

    invoke-static {p1}, Ljava/lang/String;->valueOf(Ljava/lang/Object;)Ljava/lang/String;

    move-result-object p1

    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "reader-before skipped "

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p1

    invoke-virtual {p1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p1

    invoke-static {p1}, Llocal/mio/os4camerabridge/JpegQualityBoundaryProbe;->-$$Nest$smlog(Ljava/lang/String;)V

    .line 63
    :goto_3
    return-void
.end method
