.class Llocal/mio/os4camerabridge/HookEntry$69;
.super Lde/robv/android/xposed/XC_MethodHook;
.source "HookEntry.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Llocal/mio/os4camerabridge/HookEntry;->hookFusedJpegReplacement(Ljava/lang/ClassLoader;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# direct methods
.method constructor <init>()V
    .locals 0

    .line 11254
    invoke-direct {p0}, Lde/robv/android/xposed/XC_MethodHook;-><init>()V

    return-void
.end method


# virtual methods
.method protected beforeHookedMethod(Lde/robv/android/xposed/XC_MethodHook$MethodHookParam;)V
    .locals 11
    .param p1, "param"    # Lde/robv/android/xposed/XC_MethodHook$MethodHookParam;

    .line 11257
    invoke-static {p1}, Llocal/mio/os4camerabridge/HookEntry;->-$$Nest$smreplaceFinalJpegWithCommonAps(Lde/robv/android/xposed/XC_MethodHook$MethodHookParam;)Z

    move-result v0

    if-eqz v0, :cond_0

    .line 11258
    return-void

    .line 11260
    :cond_0
    iget-object v0, p1, Lde/robv/android/xposed/XC_MethodHook$MethodHookParam;->args:[Ljava/lang/Object;

    if-eqz v0, :cond_8

    iget-object v0, p1, Lde/robv/android/xposed/XC_MethodHook$MethodHookParam;->args:[Ljava/lang/Object;

    array-length v0, v0

    const/4 v1, 0x2

    if-ne v0, v1, :cond_8

    iget-object v0, p1, Lde/robv/android/xposed/XC_MethodHook$MethodHookParam;->args:[Ljava/lang/Object;

    const/4 v1, 0x0

    aget-object v0, v0, v1

    instance-of v0, v0, Ljava/lang/Integer;

    if-eqz v0, :cond_8

    iget-object v0, p1, Lde/robv/android/xposed/XC_MethodHook$MethodHookParam;->args:[Ljava/lang/Object;

    aget-object v0, v0, v1

    check-cast v0, Ljava/lang/Integer;

    .line 11262
    invoke-virtual {v0}, Ljava/lang/Integer;->intValue()I

    move-result v0

    if-nez v0, :cond_8

    iget-object v0, p1, Lde/robv/android/xposed/XC_MethodHook$MethodHookParam;->args:[Ljava/lang/Object;

    const/4 v2, 0x1

    aget-object v0, v0, v2

    instance-of v0, v0, [B

    if-eqz v0, :cond_8

    invoke-static {}, Llocal/mio/os4camerabridge/HookEntry;->-$$Nest$sfgetfusionCapturePending()Z

    move-result v0

    if-nez v0, :cond_1

    goto/16 :goto_5

    .line 11267
    :cond_1
    iget-object v0, p1, Lde/robv/android/xposed/XC_MethodHook$MethodHookParam;->args:[Ljava/lang/Object;

    aget-object v0, v0, v2

    check-cast v0, [B

    .line 11268
    .local v0, "original":[B
    const/4 v3, 0x0

    .line 11270
    .local v3, "fused":[B
    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v4

    const-wide/16 v6, 0x2710

    add-long/2addr v4, v6

    .line 11271
    .local v4, "deadline":J
    invoke-static {}, Llocal/mio/os4camerabridge/HookEntry;->-$$Nest$sfgetFUSION_LOCK()Ljava/lang/Object;

    move-result-object v6

    monitor-enter v6

    .line 11272
    :goto_0
    :try_start_0
    invoke-static {}, Llocal/mio/os4camerabridge/HookEntry;->-$$Nest$sfgetfusionCapturePending()Z

    move-result v7

    if-eqz v7, :cond_3

    invoke-static {}, Llocal/mio/os4camerabridge/HookEntry;->-$$Nest$sfgetpendingFusedJpeg()[B

    move-result-object v7

    if-nez v7, :cond_3

    invoke-static {}, Llocal/mio/os4camerabridge/HookEntry;->-$$Nest$sfgetfusionFailure()Ljava/lang/String;

    move-result-object v7

    if-nez v7, :cond_3

    .line 11275
    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v7

    sub-long v7, v4, v7

    .line 11276
    .local v7, "remaining":J
    const-wide/16 v9, 0x0

    cmp-long v9, v7, v9

    if-gtz v9, :cond_2

    .line 11277
    const-string v9, "fusion timeout"

    invoke-static {v9}, Llocal/mio/os4camerabridge/HookEntry;->-$$Nest$sfputfusionFailure(Ljava/lang/String;)V
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_5

    .line 11278
    goto :goto_1

    .line 11281
    :cond_2
    :try_start_1
    invoke-static {}, Llocal/mio/os4camerabridge/HookEntry;->-$$Nest$sfgetFUSION_LOCK()Ljava/lang/Object;

    move-result-object v9

    invoke-virtual {v9, v7, v8}, Ljava/lang/Object;->wait(J)V
    :try_end_1
    .catch Ljava/lang/InterruptedException; {:try_start_1 .. :try_end_1} :catch_0
    .catchall {:try_start_1 .. :try_end_1} :catchall_5

    .line 11286
    nop

    .line 11287
    .end local v7    # "remaining":J
    goto :goto_0

    .line 11282
    .restart local v7    # "remaining":J
    :catch_0
    move-exception v9

    .line 11283
    .local v9, "exception":Ljava/lang/InterruptedException;
    :try_start_2
    invoke-static {}, Ljava/lang/Thread;->currentThread()Ljava/lang/Thread;

    move-result-object v10

    invoke-virtual {v10}, Ljava/lang/Thread;->interrupt()V

    .line 11284
    const-string v10, "wait interrupted"

    invoke-static {v10}, Llocal/mio/os4camerabridge/HookEntry;->-$$Nest$sfputfusionFailure(Ljava/lang/String;)V

    .line 11285
    nop

    .line 11288
    .end local v7    # "remaining":J
    .end local v9    # "exception":Ljava/lang/InterruptedException;
    :cond_3
    :goto_1
    invoke-static {}, Llocal/mio/os4camerabridge/HookEntry;->-$$Nest$sfgetpendingFusedJpeg()[B

    move-result-object v7

    move-object v3, v7

    .line 11289
    invoke-static {}, Llocal/mio/os4camerabridge/HookEntry;->-$$Nest$sfgetfusionFailure()Ljava/lang/String;

    move-result-object v7

    .line 11290
    .local v7, "failure":Ljava/lang/String;
    monitor-exit v6
    :try_end_2
    .catchall {:try_start_2 .. :try_end_2} :catchall_5

    .line 11292
    const/4 v6, 0x0

    :try_start_3
    invoke-static {v3}, Llocal/mio/os4camerabridge/HookEntry;->-$$Nest$smisJpeg([B)Z

    move-result v8

    if-eqz v8, :cond_5

    .line 11293
    invoke-static {v0, v3}, Llocal/mio/os4camerabridge/HookEntry;->-$$Nest$smtransplantAppMetadata([B[B)[B

    move-result-object v8

    .line 11295
    .local v8, "replacement":[B
    invoke-static {v8}, Llocal/mio/os4camerabridge/HookEntry;->-$$Nest$smisJpeg([B)Z

    move-result v9

    if-eqz v9, :cond_4

    .line 11296
    iget-object v9, p1, Lde/robv/android/xposed/XC_MethodHook$MethodHookParam;->args:[Ljava/lang/Object;

    aput-object v8, v9, v2

    .line 11297
    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v9, "[YuvFusion] replaced final JPEG original="

    invoke-virtual {v2, v9}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    array-length v9, v0

    invoke-virtual {v2, v9}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v2

    const-string v9, " fused="

    invoke-virtual {v2, v9}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    array-length v9, v8

    invoke-virtual {v2, v9}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v2

    const-string v9, " EXIF/ICC transplanted"

    invoke-virtual {v2, v9}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-static {v2}, Llocal/mio/os4camerabridge/HookEntry;->-$$Nest$smlog(Ljava/lang/String;)V

    .line 11302
    .end local v8    # "replacement":[B
    :cond_4
    goto :goto_2

    .line 11303
    :cond_5
    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v8, "[YuvFusion] fallback to original JPEG reason="

    invoke-virtual {v2, v8}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-static {v2}, Llocal/mio/os4camerabridge/HookEntry;->-$$Nest$smlog(Ljava/lang/String;)V
    :try_end_3
    .catchall {:try_start_3 .. :try_end_3} :catchall_1

    .line 11310
    :goto_2
    invoke-static {}, Llocal/mio/os4camerabridge/HookEntry;->-$$Nest$sfgetFUSION_LOCK()Ljava/lang/Object;

    move-result-object v2

    monitor-enter v2

    .line 11311
    :try_start_4
    invoke-static {v1}, Llocal/mio/os4camerabridge/HookEntry;->-$$Nest$sfputfusionCapturePending(Z)V

    .line 11312
    invoke-static {v6}, Llocal/mio/os4camerabridge/HookEntry;->-$$Nest$sfputpendingFusedJpeg([B)V

    .line 11313
    invoke-static {v6}, Llocal/mio/os4camerabridge/HookEntry;->-$$Nest$sfputfusionFailure(Ljava/lang/String;)V

    .line 11314
    invoke-static {}, Llocal/mio/os4camerabridge/HookEntry;->-$$Nest$sfgetFUSION_FRAMES()Ljava/util/ArrayList;

    move-result-object v1

    invoke-virtual {v1}, Ljava/util/ArrayList;->clear()V

    .line 11315
    invoke-static {}, Llocal/mio/os4camerabridge/HookEntry;->-$$Nest$sfgetFUSION_LOCK()Ljava/lang/Object;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/Object;->notifyAll()V

    .line 11316
    monitor-exit v2
    :try_end_4
    .catchall {:try_start_4 .. :try_end_4} :catchall_0

    .line 11317
    new-instance v1, Ljava/io/File;

    const-string v2, "/data/user/0/com.android.camera/files/os4_yuv_probe/enable_fusion"

    invoke-direct {v1, v2}, Ljava/io/File;-><init>(Ljava/lang/String;)V

    .line 11318
    .local v1, "oneShot":Ljava/io/File;
    invoke-virtual {v1}, Ljava/io/File;->isFile()Z

    move-result v2

    if-eqz v2, :cond_6

    .line 11319
    invoke-virtual {v1}, Ljava/io/File;->delete()Z

    move-result v2

    .line 11320
    .local v2, "removed":Z
    new-instance v6, Ljava/lang/StringBuilder;

    invoke-direct {v6}, Ljava/lang/StringBuilder;-><init>()V

    :goto_3
    const-string v8, "[YuvFusion] one-shot marker removed="

    invoke-virtual {v6, v8}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    invoke-virtual {v6, v2}, Ljava/lang/StringBuilder;->append(Z)Ljava/lang/StringBuilder;

    move-result-object v6

    invoke-virtual {v6}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v6

    invoke-static {v6}, Llocal/mio/os4camerabridge/HookEntry;->-$$Nest$smlog(Ljava/lang/String;)V

    .line 11322
    .end local v1    # "oneShot":Ljava/io/File;
    .end local v2    # "removed":Z
    :cond_6
    goto :goto_4

    .line 11316
    :catchall_0
    move-exception v1

    :try_start_5
    monitor-exit v2
    :try_end_5
    .catchall {:try_start_5 .. :try_end_5} :catchall_0

    throw v1

    .line 11306
    :catchall_1
    move-exception v2

    .line 11307
    .local v2, "throwable":Ljava/lang/Throwable;
    :try_start_6
    new-instance v8, Ljava/lang/StringBuilder;

    invoke-direct {v8}, Ljava/lang/StringBuilder;-><init>()V

    const-string v9, "[YuvFusion] replacement rejected; original retained: "

    invoke-virtual {v8, v9}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v8

    invoke-virtual {v8, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v8

    invoke-virtual {v8}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v8

    invoke-static {v8}, Llocal/mio/os4camerabridge/HookEntry;->-$$Nest$smlog(Ljava/lang/String;)V
    :try_end_6
    .catchall {:try_start_6 .. :try_end_6} :catchall_3

    .line 11310
    .end local v2    # "throwable":Ljava/lang/Throwable;
    invoke-static {}, Llocal/mio/os4camerabridge/HookEntry;->-$$Nest$sfgetFUSION_LOCK()Ljava/lang/Object;

    move-result-object v2

    monitor-enter v2

    .line 11311
    :try_start_7
    invoke-static {v1}, Llocal/mio/os4camerabridge/HookEntry;->-$$Nest$sfputfusionCapturePending(Z)V

    .line 11312
    invoke-static {v6}, Llocal/mio/os4camerabridge/HookEntry;->-$$Nest$sfputpendingFusedJpeg([B)V

    .line 11313
    invoke-static {v6}, Llocal/mio/os4camerabridge/HookEntry;->-$$Nest$sfputfusionFailure(Ljava/lang/String;)V

    .line 11314
    invoke-static {}, Llocal/mio/os4camerabridge/HookEntry;->-$$Nest$sfgetFUSION_FRAMES()Ljava/util/ArrayList;

    move-result-object v1

    invoke-virtual {v1}, Ljava/util/ArrayList;->clear()V

    .line 11315
    invoke-static {}, Llocal/mio/os4camerabridge/HookEntry;->-$$Nest$sfgetFUSION_LOCK()Ljava/lang/Object;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/Object;->notifyAll()V

    .line 11316
    monitor-exit v2
    :try_end_7
    .catchall {:try_start_7 .. :try_end_7} :catchall_2

    .line 11317
    new-instance v1, Ljava/io/File;

    const-string v2, "/data/user/0/com.android.camera/files/os4_yuv_probe/enable_fusion"

    invoke-direct {v1, v2}, Ljava/io/File;-><init>(Ljava/lang/String;)V

    .line 11318
    .restart local v1    # "oneShot":Ljava/io/File;
    invoke-virtual {v1}, Ljava/io/File;->isFile()Z

    move-result v2

    if-eqz v2, :cond_6

    .line 11319
    invoke-virtual {v1}, Ljava/io/File;->delete()Z

    move-result v2

    .line 11320
    .local v2, "removed":Z
    new-instance v6, Ljava/lang/StringBuilder;

    invoke-direct {v6}, Ljava/lang/StringBuilder;-><init>()V

    goto :goto_3

    .line 11323
    .end local v1    # "oneShot":Ljava/io/File;
    .end local v2    # "removed":Z
    :goto_4
    return-void

    .line 11316
    :catchall_2
    move-exception v1

    :try_start_8
    monitor-exit v2
    :try_end_8
    .catchall {:try_start_8 .. :try_end_8} :catchall_2

    throw v1

    .line 11310
    :catchall_3
    move-exception v2

    invoke-static {}, Llocal/mio/os4camerabridge/HookEntry;->-$$Nest$sfgetFUSION_LOCK()Ljava/lang/Object;

    move-result-object v8

    monitor-enter v8

    .line 11311
    :try_start_9
    invoke-static {v1}, Llocal/mio/os4camerabridge/HookEntry;->-$$Nest$sfputfusionCapturePending(Z)V

    .line 11312
    invoke-static {v6}, Llocal/mio/os4camerabridge/HookEntry;->-$$Nest$sfputpendingFusedJpeg([B)V

    .line 11313
    invoke-static {v6}, Llocal/mio/os4camerabridge/HookEntry;->-$$Nest$sfputfusionFailure(Ljava/lang/String;)V

    .line 11314
    invoke-static {}, Llocal/mio/os4camerabridge/HookEntry;->-$$Nest$sfgetFUSION_FRAMES()Ljava/util/ArrayList;

    move-result-object v1

    invoke-virtual {v1}, Ljava/util/ArrayList;->clear()V

    .line 11315
    invoke-static {}, Llocal/mio/os4camerabridge/HookEntry;->-$$Nest$sfgetFUSION_LOCK()Ljava/lang/Object;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/Object;->notifyAll()V

    .line 11316
    monitor-exit v8
    :try_end_9
    .catchall {:try_start_9 .. :try_end_9} :catchall_4

    .line 11317
    new-instance v1, Ljava/io/File;

    const-string v6, "/data/user/0/com.android.camera/files/os4_yuv_probe/enable_fusion"

    invoke-direct {v1, v6}, Ljava/io/File;-><init>(Ljava/lang/String;)V

    .line 11318
    .restart local v1    # "oneShot":Ljava/io/File;
    invoke-virtual {v1}, Ljava/io/File;->isFile()Z

    move-result v6

    if-eqz v6, :cond_7

    .line 11319
    invoke-virtual {v1}, Ljava/io/File;->delete()Z

    move-result v6

    .line 11320
    .local v6, "removed":Z
    new-instance v8, Ljava/lang/StringBuilder;

    invoke-direct {v8}, Ljava/lang/StringBuilder;-><init>()V

    const-string v9, "[YuvFusion] one-shot marker removed="

    invoke-virtual {v8, v9}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v8

    invoke-virtual {v8, v6}, Ljava/lang/StringBuilder;->append(Z)Ljava/lang/StringBuilder;

    move-result-object v8

    invoke-virtual {v8}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v8

    invoke-static {v8}, Llocal/mio/os4camerabridge/HookEntry;->-$$Nest$smlog(Ljava/lang/String;)V

    .line 11322
    .end local v1    # "oneShot":Ljava/io/File;
    .end local v6    # "removed":Z
    :cond_7
    throw v2

    .line 11316
    :catchall_4
    move-exception v1

    :try_start_a
    monitor-exit v8
    :try_end_a
    .catchall {:try_start_a .. :try_end_a} :catchall_4

    throw v1

    .line 11290
    .end local v7    # "failure":Ljava/lang/String;
    :catchall_5
    move-exception v1

    :try_start_b
    monitor-exit v6
    :try_end_b
    .catchall {:try_start_b .. :try_end_b} :catchall_5

    throw v1

    .line 11265
    .end local v0    # "original":[B
    .end local v3    # "fused":[B
    .end local v4    # "deadline":J
    :cond_8
    :goto_5
    return-void
.end method
