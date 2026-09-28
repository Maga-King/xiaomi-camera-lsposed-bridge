.class Llocal/mio/os4camerabridge/HookEntry$74;
.super Lde/robv/android/xposed/XC_MethodHook;
.source "HookEntry.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Llocal/mio/os4camerabridge/HookEntry;->hookDocumentSavePipeline(Ljava/lang/ClassLoader;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic val$interceptorContext:Ljava/lang/Class;

.field final synthetic val$interceptorData:Ljava/lang/Class;

.field final synthetic val$parallelTaskData:Ljava/lang/Class;


# direct methods
.method constructor <init>(Ljava/lang/Class;Ljava/lang/Class;Ljava/lang/Class;)V
    .locals 0

    .line 11640
    iput-object p1, p0, Llocal/mio/os4camerabridge/HookEntry$74;->val$parallelTaskData:Ljava/lang/Class;

    iput-object p2, p0, Llocal/mio/os4camerabridge/HookEntry$74;->val$interceptorContext:Ljava/lang/Class;

    iput-object p3, p0, Llocal/mio/os4camerabridge/HookEntry$74;->val$interceptorData:Ljava/lang/Class;

    invoke-direct {p0}, Lde/robv/android/xposed/XC_MethodHook;-><init>()V

    return-void
.end method


# virtual methods
.method protected beforeHookedMethod(Lde/robv/android/xposed/XC_MethodHook$MethodHookParam;)V
    .locals 6
    .param p1, "param"    # Lde/robv/android/xposed/XC_MethodHook$MethodHookParam;

    .line 11643
    invoke-static {}, Llocal/mio/os4camerabridge/HookEntry;->-$$Nest$sfgetactiveCameraModule()I

    move-result v0

    const/16 v1, 0xba

    if-ne v0, v1, :cond_2

    iget-object v0, p1, Lde/robv/android/xposed/XC_MethodHook$MethodHookParam;->args:[Ljava/lang/Object;

    if-eqz v0, :cond_2

    iget-object v0, p1, Lde/robv/android/xposed/XC_MethodHook$MethodHookParam;->args:[Ljava/lang/Object;

    array-length v0, v0

    const/4 v1, 0x1

    if-ne v0, v1, :cond_2

    iget-object v0, p0, Llocal/mio/os4camerabridge/HookEntry$74;->val$parallelTaskData:Ljava/lang/Class;

    iget-object v1, p1, Lde/robv/android/xposed/XC_MethodHook$MethodHookParam;->args:[Ljava/lang/Object;

    const/4 v2, 0x0

    aget-object v1, v1, v2

    .line 11646
    invoke-virtual {v0, v1}, Ljava/lang/Class;->isInstance(Ljava/lang/Object;)Z

    move-result v0

    if-nez v0, :cond_0

    goto :goto_1

    .line 11649
    :cond_0
    iget-object v0, p1, Lde/robv/android/xposed/XC_MethodHook$MethodHookParam;->args:[Ljava/lang/Object;

    aget-object v0, v0, v2

    .line 11650
    .local v0, "task":Ljava/lang/Object;
    invoke-static {}, Llocal/mio/os4camerabridge/HookEntry;->-$$Nest$sfgetDOCUMENT_TASKS_PROCESSED()Ljava/util/Map;

    move-result-object v1

    monitor-enter v1

    .line 11651
    :try_start_0
    invoke-static {}, Llocal/mio/os4camerabridge/HookEntry;->-$$Nest$sfgetDOCUMENT_TASKS_PROCESSED()Ljava/util/Map;

    move-result-object v2

    invoke-interface {v2, v0}, Ljava/util/Map;->containsKey(Ljava/lang/Object;)Z

    move-result v2

    if-eqz v2, :cond_1

    .line 11652
    monitor-exit v1

    return-void

    .line 11654
    :cond_1
    invoke-static {}, Llocal/mio/os4camerabridge/HookEntry;->-$$Nest$sfgetDOCUMENT_TASKS_PROCESSED()Ljava/util/Map;

    move-result-object v2

    sget-object v3, Ljava/lang/Boolean;->TRUE:Ljava/lang/Boolean;

    invoke-interface {v2, v0, v3}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 11655
    monitor-exit v1
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_1

    .line 11656
    invoke-static {}, Landroid/os/SystemClock;->elapsedRealtime()J

    move-result-wide v1

    .line 11658
    .local v1, "started":J
    :try_start_1
    iget-object v3, p0, Llocal/mio/os4camerabridge/HookEntry$74;->val$interceptorContext:Ljava/lang/Class;

    iget-object v4, p0, Llocal/mio/os4camerabridge/HookEntry$74;->val$interceptorData:Ljava/lang/Class;

    invoke-static {v0, v3, v4}, Llocal/mio/os4camerabridge/HookEntry;->-$$Nest$smrunDocumentInterceptor(Ljava/lang/Object;Ljava/lang/Class;Ljava/lang/Class;)V

    .line 11660
    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    const-string v4, "[DocumentBridge] native Doc completed before Exif costMs="

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    .line 11662
    invoke-static {}, Landroid/os/SystemClock;->elapsedRealtime()J

    move-result-wide v4

    sub-long/2addr v4, v1

    invoke-virtual {v3, v4, v5}, Ljava/lang/StringBuilder;->append(J)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    .line 11660
    invoke-static {v3}, Llocal/mio/os4camerabridge/HookEntry;->-$$Nest$smlog(Ljava/lang/String;)V
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    .line 11666
    goto :goto_0

    .line 11663
    :catchall_0
    move-exception v3

    .line 11664
    .local v3, "throwable":Ljava/lang/Throwable;
    new-instance v4, Ljava/lang/StringBuilder;

    invoke-direct {v4}, Ljava/lang/StringBuilder;-><init>()V

    const-string v5, "[DocumentBridge] native Doc failed before Exif: "

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v4

    invoke-static {v4}, Llocal/mio/os4camerabridge/HookEntry;->-$$Nest$smlog(Ljava/lang/String;)V

    .line 11667
    .end local v3    # "throwable":Ljava/lang/Throwable;
    :goto_0
    return-void

    .line 11655
    .end local v1    # "started":J
    :catchall_1
    move-exception v2

    :try_start_2
    monitor-exit v1
    :try_end_2
    .catchall {:try_start_2 .. :try_end_2} :catchall_1

    throw v2

    .line 11647
    .end local v0    # "task":Ljava/lang/Object;
    :cond_2
    :goto_1
    return-void
.end method
