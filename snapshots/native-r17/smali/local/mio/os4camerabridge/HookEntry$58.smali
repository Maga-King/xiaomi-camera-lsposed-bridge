.class Llocal/mio/os4camerabridge/HookEntry$58;
.super Lde/robv/android/xposed/XC_MethodHook;
.source "HookEntry.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Llocal/mio/os4camerabridge/HookEntry;->hookDynamicPhotoPreviewCompletion(Ljava/lang/ClassLoader;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic val$cameraGlobal:Ljava/lang/Class;

.field final synthetic val$databaseUtility:Ljava/lang/Class;

.field final synthetic val$parallelDatabase:Ljava/lang/Class;


# direct methods
.method constructor <init>(Ljava/lang/Class;Ljava/lang/Class;Ljava/lang/Class;)V
    .locals 0

    .line 9153
    iput-object p1, p0, Llocal/mio/os4camerabridge/HookEntry$58;->val$parallelDatabase:Ljava/lang/Class;

    iput-object p2, p0, Llocal/mio/os4camerabridge/HookEntry$58;->val$cameraGlobal:Ljava/lang/Class;

    iput-object p3, p0, Llocal/mio/os4camerabridge/HookEntry$58;->val$databaseUtility:Ljava/lang/Class;

    invoke-direct {p0}, Lde/robv/android/xposed/XC_MethodHook;-><init>()V

    return-void
.end method


# virtual methods
.method protected afterHookedMethod(Lde/robv/android/xposed/XC_MethodHook$MethodHookParam;)V
    .locals 6
    .param p1, "param"    # Lde/robv/android/xposed/XC_MethodHook$MethodHookParam;

    .line 9183
    invoke-static {}, Llocal/mio/os4camerabridge/HookEntry;->-$$Nest$sfgetDYNAMIC_PHOTO_SAVE_RECORD()Ljava/lang/ThreadLocal;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/ThreadLocal;->get()Ljava/lang/Object;

    move-result-object v0

    .line 9184
    .local v0, "record":Ljava/lang/Object;
    sget-object v1, Ljava/lang/Boolean;->TRUE:Ljava/lang/Boolean;

    invoke-static {}, Llocal/mio/os4camerabridge/HookEntry;->-$$Nest$sfgetDYNAMIC_PHOTO_MARK_FINISHED()Ljava/lang/ThreadLocal;

    move-result-object v2

    .line 9185
    invoke-virtual {v2}, Ljava/lang/ThreadLocal;->get()Ljava/lang/Object;

    move-result-object v2

    .line 9184
    invoke-virtual {v1, v2}, Ljava/lang/Boolean;->equals(Ljava/lang/Object;)Z

    move-result v1

    .line 9187
    .local v1, "alreadyFinished":Z
    :try_start_0
    invoke-virtual {p1}, Lde/robv/android/xposed/XC_MethodHook$MethodHookParam;->hasThrowable()Z

    move-result v2

    if-nez v2, :cond_0

    if-eqz v0, :cond_0

    if-nez v1, :cond_0

    .line 9189
    iget-object v2, p0, Llocal/mio/os4camerabridge/HookEntry$58;->val$cameraGlobal:Ljava/lang/Class;

    const-string v3, "getApplication"

    const/4 v4, 0x0

    new-array v4, v4, [Ljava/lang/Object;

    .line 9190
    invoke-static {v2, v3, v4}, Lde/robv/android/xposed/XposedHelpers;->callStaticMethod(Ljava/lang/Class;Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v2

    .line 9192
    .local v2, "application":Ljava/lang/Object;
    iget-object v3, p0, Llocal/mio/os4camerabridge/HookEntry$58;->val$databaseUtility:Ljava/lang/Class;

    const-string v4, "c"

    filled-new-array {v2, v0}, [Ljava/lang/Object;

    move-result-object v5

    invoke-static {v3, v4, v5}, Lde/robv/android/xposed/XposedHelpers;->callStaticMethod(Ljava/lang/Class;Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/Object;

    .line 9194
    const-string v3, "[DynamicPhotoCompletion] preview HEIC marked finished"

    invoke-static {v3}, Llocal/mio/os4camerabridge/HookEntry;->-$$Nest$smlog(Ljava/lang/String;)V
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 9201
    .end local v2    # "application":Ljava/lang/Object;
    :cond_0
    :goto_0
    invoke-static {}, Llocal/mio/os4camerabridge/HookEntry;->-$$Nest$sfgetDYNAMIC_PHOTO_SAVE_RECORD()Ljava/lang/ThreadLocal;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/ThreadLocal;->remove()V

    .line 9202
    invoke-static {}, Llocal/mio/os4camerabridge/HookEntry;->-$$Nest$sfgetDYNAMIC_PHOTO_MARK_FINISHED()Ljava/lang/ThreadLocal;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/ThreadLocal;->remove()V

    .line 9203
    goto :goto_1

    .line 9197
    :catchall_0
    move-exception v2

    .line 9198
    .local v2, "throwable":Ljava/lang/Throwable;
    :try_start_1
    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    const-string v4, "[DynamicPhotoCompletion] finish failed: "

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    invoke-static {v3}, Llocal/mio/os4camerabridge/HookEntry;->-$$Nest$smlog(Ljava/lang/String;)V
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_1

    .end local v2    # "throwable":Ljava/lang/Throwable;
    goto :goto_0

    .line 9204
    :goto_1
    return-void

    .line 9201
    :catchall_1
    move-exception v2

    invoke-static {}, Llocal/mio/os4camerabridge/HookEntry;->-$$Nest$sfgetDYNAMIC_PHOTO_SAVE_RECORD()Ljava/lang/ThreadLocal;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/ThreadLocal;->remove()V

    .line 9202
    invoke-static {}, Llocal/mio/os4camerabridge/HookEntry;->-$$Nest$sfgetDYNAMIC_PHOTO_MARK_FINISHED()Ljava/lang/ThreadLocal;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/ThreadLocal;->remove()V

    .line 9203
    throw v2
.end method

.method protected beforeHookedMethod(Lde/robv/android/xposed/XC_MethodHook$MethodHookParam;)V
    .locals 6
    .param p1, "param"    # Lde/robv/android/xposed/XC_MethodHook$MethodHookParam;

    .line 9156
    invoke-static {}, Llocal/mio/os4camerabridge/HookEntry;->-$$Nest$sfgetDYNAMIC_PHOTO_SAVE_RECORD()Ljava/lang/ThreadLocal;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/ThreadLocal;->remove()V

    .line 9157
    invoke-static {}, Llocal/mio/os4camerabridge/HookEntry;->-$$Nest$sfgetDYNAMIC_PHOTO_MARK_FINISHED()Ljava/lang/ThreadLocal;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/ThreadLocal;->remove()V

    .line 9159
    :try_start_0
    iget-object v0, p1, Lde/robv/android/xposed/XC_MethodHook$MethodHookParam;->thisObject:Ljava/lang/Object;

    const-string v1, "b"

    invoke-static {v0, v1}, Lde/robv/android/xposed/XposedHelpers;->getObjectField(Ljava/lang/Object;Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v0

    .line 9161
    .local v0, "parallelTask":Ljava/lang/Object;
    const-string v1, "k"

    invoke-static {v0, v1}, Lde/robv/android/xposed/XposedHelpers;->getObjectField(Ljava/lang/Object;Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v1

    .line 9163
    .local v1, "storageData":Ljava/lang/Object;
    const-string v2, "g"

    .line 9164
    invoke-static {v1, v2}, Lde/robv/android/xposed/XposedHelpers;->getObjectField(Ljava/lang/Object;Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v2

    check-cast v2, Ljava/lang/String;

    .line 9165
    .local v2, "savePath":Ljava/lang/String;
    if-eqz v2, :cond_2

    invoke-virtual {v2}, Ljava/lang/String;->isEmpty()Z

    move-result v3

    if-eqz v3, :cond_0

    goto :goto_0

    .line 9168
    :cond_0
    iget-object v3, p0, Llocal/mio/os4camerabridge/HookEntry$58;->val$parallelDatabase:Ljava/lang/Class;

    const-string v4, "y"

    const/4 v5, 0x0

    new-array v5, v5, [Ljava/lang/Object;

    invoke-static {v3, v4, v5}, Lde/robv/android/xposed/XposedHelpers;->callStaticMethod(Ljava/lang/Class;Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v3

    .line 9170
    .local v3, "database":Ljava/lang/Object;
    const-string v4, "f"

    filled-new-array {v2}, [Ljava/lang/Object;

    move-result-object v5

    invoke-static {v3, v4, v5}, Lde/robv/android/xposed/XposedHelpers;->callMethod(Ljava/lang/Object;Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v4

    .line 9172
    .local v4, "record":Ljava/lang/Object;
    if-eqz v4, :cond_1

    .line 9173
    invoke-static {}, Llocal/mio/os4camerabridge/HookEntry;->-$$Nest$sfgetDYNAMIC_PHOTO_SAVE_RECORD()Ljava/lang/ThreadLocal;

    move-result-object v5

    invoke-virtual {v5, v4}, Ljava/lang/ThreadLocal;->set(Ljava/lang/Object;)V
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 9178
    .end local v0    # "parallelTask":Ljava/lang/Object;
    .end local v1    # "storageData":Ljava/lang/Object;
    .end local v2    # "savePath":Ljava/lang/String;
    .end local v3    # "database":Ljava/lang/Object;
    .end local v4    # "record":Ljava/lang/Object;
    :cond_1
    goto :goto_1

    .line 9166
    .restart local v0    # "parallelTask":Ljava/lang/Object;
    .restart local v1    # "storageData":Ljava/lang/Object;
    .restart local v2    # "savePath":Ljava/lang/String;
    :cond_2
    :goto_0
    return-void

    .line 9175
    .end local v0    # "parallelTask":Ljava/lang/Object;
    .end local v1    # "storageData":Ljava/lang/Object;
    .end local v2    # "savePath":Ljava/lang/String;
    :catchall_0
    move-exception v0

    .line 9176
    .local v0, "throwable":Ljava/lang/Throwable;
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "[DynamicPhotoCompletion] record lookup failed: "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-static {v1}, Llocal/mio/os4camerabridge/HookEntry;->-$$Nest$smlog(Ljava/lang/String;)V

    .line 9179
    .end local v0    # "throwable":Ljava/lang/Throwable;
    :goto_1
    return-void
.end method
