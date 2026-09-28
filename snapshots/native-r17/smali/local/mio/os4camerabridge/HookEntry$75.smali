.class Llocal/mio/os4camerabridge/HookEntry$75;
.super Lde/robv/android/xposed/XC_MethodHook;
.source "HookEntry.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Llocal/mio/os4camerabridge/HookEntry;->hookFinalJpegEffects(Ljava/lang/ClassLoader;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic val$candySdk:Ljava/lang/Class;

.field final synthetic val$renderTag:Ljava/lang/Class;


# direct methods
.method constructor <init>(Ljava/lang/Class;Ljava/lang/Class;)V
    .locals 0

    .line 11787
    iput-object p1, p0, Llocal/mio/os4camerabridge/HookEntry$75;->val$renderTag:Ljava/lang/Class;

    iput-object p2, p0, Llocal/mio/os4camerabridge/HookEntry$75;->val$candySdk:Ljava/lang/Class;

    invoke-direct {p0}, Lde/robv/android/xposed/XC_MethodHook;-><init>()V

    return-void
.end method


# virtual methods
.method protected beforeHookedMethod(Lde/robv/android/xposed/XC_MethodHook$MethodHookParam;)V
    .locals 8
    .param p1, "param"    # Lde/robv/android/xposed/XC_MethodHook$MethodHookParam;

    .line 11790
    iget-object v0, p1, Lde/robv/android/xposed/XC_MethodHook$MethodHookParam;->args:[Ljava/lang/Object;

    if-eqz v0, :cond_3

    iget-object v0, p1, Lde/robv/android/xposed/XC_MethodHook$MethodHookParam;->args:[Ljava/lang/Object;

    array-length v0, v0

    const/4 v1, 0x2

    if-ne v0, v1, :cond_3

    iget-object v0, p1, Lde/robv/android/xposed/XC_MethodHook$MethodHookParam;->args:[Ljava/lang/Object;

    const/4 v1, 0x0

    aget-object v0, v0, v1

    instance-of v0, v0, Ljava/lang/Integer;

    if-eqz v0, :cond_3

    iget-object v0, p1, Lde/robv/android/xposed/XC_MethodHook$MethodHookParam;->args:[Ljava/lang/Object;

    aget-object v0, v0, v1

    check-cast v0, Ljava/lang/Integer;

    .line 11792
    invoke-virtual {v0}, Ljava/lang/Integer;->intValue()I

    move-result v0

    if-nez v0, :cond_3

    iget-object v0, p1, Lde/robv/android/xposed/XC_MethodHook$MethodHookParam;->args:[Ljava/lang/Object;

    const/4 v1, 0x1

    aget-object v0, v0, v1

    instance-of v0, v0, [B

    if-eqz v0, :cond_3

    invoke-static {}, Llocal/mio/os4camerabridge/HookEntry;->-$$Nest$sfgetactiveBeautyModule()I

    move-result v0

    const/16 v2, 0xa3

    if-eq v0, v2, :cond_0

    goto :goto_1

    .line 11797
    :cond_0
    iget-object v0, p1, Lde/robv/android/xposed/XC_MethodHook$MethodHookParam;->args:[Ljava/lang/Object;

    aget-object v0, v0, v1

    check-cast v0, [B

    .line 11798
    .local v0, "original":[B
    invoke-static {v0}, Llocal/mio/os4camerabridge/HookEntry;->-$$Nest$smisJpeg([B)Z

    move-result v2

    if-nez v2, :cond_1

    .line 11799
    return-void

    .line 11801
    :cond_1
    invoke-static {}, Landroid/os/SystemClock;->elapsedRealtime()J

    move-result-wide v2

    .line 11803
    .local v2, "started":J
    :try_start_0
    invoke-static {}, Llocal/mio/os4camerabridge/HookEntry;->-$$Nest$sfgetJPEG_POST_LOCK()Ljava/lang/Object;

    move-result-object v4

    monitor-enter v4
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_1

    .line 11804
    :try_start_1
    iget-object v5, p0, Llocal/mio/os4camerabridge/HookEntry$75;->val$renderTag:Ljava/lang/Class;

    iget-object v6, p0, Llocal/mio/os4camerabridge/HookEntry$75;->val$candySdk:Ljava/lang/Class;

    invoke-static {v0, v5, v6}, Llocal/mio/os4camerabridge/HookEntry;->-$$Nest$smrenderFinalJpegEffects([BLjava/lang/Class;Ljava/lang/Class;)[B

    move-result-object v5

    .line 11806
    .local v5, "processed":[B
    invoke-static {v5}, Llocal/mio/os4camerabridge/HookEntry;->-$$Nest$smisJpeg([B)Z

    move-result v6

    if-eqz v6, :cond_2

    .line 11807
    iget-object v6, p1, Lde/robv/android/xposed/XC_MethodHook$MethodHookParam;->args:[Ljava/lang/Object;

    aput-object v5, v6, v1

    .line 11808
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v6, "[JpegEffects] final JPEG replaced bytes="

    invoke-virtual {v1, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    array-length v6, v0

    invoke-virtual {v1, v6}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v6, "->"

    invoke-virtual {v1, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    array-length v6, v5

    invoke-virtual {v1, v6}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v6, " costMs="

    invoke-virtual {v1, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    .line 11811
    invoke-static {}, Landroid/os/SystemClock;->elapsedRealtime()J

    move-result-wide v6

    sub-long/2addr v6, v2

    invoke-virtual {v1, v6, v7}, Ljava/lang/StringBuilder;->append(J)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    .line 11808
    invoke-static {v1}, Llocal/mio/os4camerabridge/HookEntry;->-$$Nest$smlog(Ljava/lang/String;)V

    .line 11813
    .end local v5    # "processed":[B
    :cond_2
    monitor-exit v4

    .line 11816
    goto :goto_0

    .line 11813
    :catchall_0
    move-exception v1

    monitor-exit v4
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    .end local v0    # "original":[B
    .end local v2    # "started":J
    .end local p0    # "this":Llocal/mio/os4camerabridge/HookEntry$75;
    .end local p1    # "param":Lde/robv/android/xposed/XC_MethodHook$MethodHookParam;
    :try_start_2
    throw v1
    :try_end_2
    .catchall {:try_start_2 .. :try_end_2} :catchall_1

    .line 11814
    .restart local v0    # "original":[B
    .restart local v2    # "started":J
    .restart local p0    # "this":Llocal/mio/os4camerabridge/HookEntry$75;
    .restart local p1    # "param":Lde/robv/android/xposed/XC_MethodHook$MethodHookParam;
    :catchall_1
    move-exception v1

    .line 11815
    .local v1, "throwable":Ljava/lang/Throwable;
    new-instance v4, Ljava/lang/StringBuilder;

    invoke-direct {v4}, Ljava/lang/StringBuilder;-><init>()V

    const-string v5, "[JpegEffects] original retained: "

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v4

    invoke-static {v4}, Llocal/mio/os4camerabridge/HookEntry;->-$$Nest$smlog(Ljava/lang/String;)V

    .line 11817
    .end local v1    # "throwable":Ljava/lang/Throwable;
    :goto_0
    return-void

    .line 11795
    .end local v0    # "original":[B
    .end local v2    # "started":J
    :cond_3
    :goto_1
    return-void
.end method
