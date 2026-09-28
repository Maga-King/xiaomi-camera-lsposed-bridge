.class Llocal/mio/os4camerabridge/RearLivePhotoBridge$5;
.super Lde/robv/android/xposed/XC_MethodHook;
.source "RearLivePhotoBridge.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Llocal/mio/os4camerabridge/RearLivePhotoBridge;->bindCapturePath(Lorg/luckypray/dexkit/DexKitBridge;Ljava/lang/ClassLoader;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic val$active:Ljava/lang/reflect/Field;

.field final synthetic val$camera:Ljava/lang/reflect/Field;

.field final synthetic val$generation:Ljava/lang/reflect/Field;

.field final synthetic val$module:Ljava/lang/reflect/Field;

.field final synthetic val$path:Ljava/lang/reflect/Field;

.field final synthetic val$storage:Ljava/lang/reflect/Field;


# direct methods
.method constructor <init>(Ljava/lang/reflect/Field;Ljava/lang/reflect/Field;Ljava/lang/reflect/Field;Ljava/lang/reflect/Field;Ljava/lang/reflect/Field;Ljava/lang/reflect/Field;)V
    .locals 0

    .line 167
    iput-object p1, p0, Llocal/mio/os4camerabridge/RearLivePhotoBridge$5;->val$active:Ljava/lang/reflect/Field;

    iput-object p2, p0, Llocal/mio/os4camerabridge/RearLivePhotoBridge$5;->val$module:Ljava/lang/reflect/Field;

    iput-object p3, p0, Llocal/mio/os4camerabridge/RearLivePhotoBridge$5;->val$camera:Ljava/lang/reflect/Field;

    iput-object p4, p0, Llocal/mio/os4camerabridge/RearLivePhotoBridge$5;->val$storage:Ljava/lang/reflect/Field;

    iput-object p5, p0, Llocal/mio/os4camerabridge/RearLivePhotoBridge$5;->val$path:Ljava/lang/reflect/Field;

    iput-object p6, p0, Llocal/mio/os4camerabridge/RearLivePhotoBridge$5;->val$generation:Ljava/lang/reflect/Field;

    invoke-direct {p0}, Lde/robv/android/xposed/XC_MethodHook;-><init>()V

    return-void
.end method


# virtual methods
.method protected beforeHookedMethod(Lde/robv/android/xposed/XC_MethodHook$MethodHookParam;)V
    .locals 11

    .line 169
    invoke-static {}, Llocal/mio/os4camerabridge/RearLivePhotoBridge;->-$$Nest$sfgetPENDING_PATH()Ljava/lang/ThreadLocal;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/ThreadLocal;->get()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Llocal/mio/os4camerabridge/RearLivePhotoBridge$PendingPath;

    .line 170
    invoke-static {}, Llocal/mio/os4camerabridge/RearLivePhotoBridge;->-$$Nest$sfgetPENDING_PATH()Ljava/lang/ThreadLocal;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/ThreadLocal;->remove()V

    .line 171
    if-eqz v0, :cond_5

    iget-object v1, p1, Lde/robv/android/xposed/XC_MethodHook$MethodHookParam;->args:[Ljava/lang/Object;

    const/4 v2, 0x0

    aget-object v1, v1, v2

    if-nez v1, :cond_0

    goto/16 :goto_1

    .line 173
    :cond_0
    :try_start_0
    iget-object v1, p0, Llocal/mio/os4camerabridge/RearLivePhotoBridge$5;->val$active:Ljava/lang/reflect/Field;

    iget-object v3, p0, Llocal/mio/os4camerabridge/RearLivePhotoBridge$5;->val$module:Ljava/lang/reflect/Field;

    iget-object v4, p0, Llocal/mio/os4camerabridge/RearLivePhotoBridge$5;->val$camera:Ljava/lang/reflect/Field;

    invoke-static {v1, v3, v4}, Llocal/mio/os4camerabridge/RearLivePhotoBridge;->-$$Nest$smeligible(Ljava/lang/reflect/Field;Ljava/lang/reflect/Field;Ljava/lang/reflect/Field;)Z

    move-result v1

    if-nez v1, :cond_1

    return-void

    .line 174
    :cond_1
    iget-object v1, p0, Llocal/mio/os4camerabridge/RearLivePhotoBridge$5;->val$storage:Ljava/lang/reflect/Field;

    iget-object v3, p1, Lde/robv/android/xposed/XC_MethodHook$MethodHookParam;->args:[Ljava/lang/Object;

    aget-object v3, v3, v2

    invoke-virtual {v1, v3}, Ljava/lang/reflect/Field;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v1

    .line 175
    if-nez v1, :cond_2

    return-void

    .line 176
    :cond_2
    iget-object v3, p0, Llocal/mio/os4camerabridge/RearLivePhotoBridge$5;->val$path:Ljava/lang/reflect/Field;

    invoke-virtual {v3, v1}, Ljava/lang/reflect/Field;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v3

    .line 177
    instance-of v4, v3, Ljava/lang/String;

    if-eqz v4, :cond_3

    check-cast v3, Ljava/lang/String;

    invoke-virtual {v3}, Ljava/lang/String;->isEmpty()Z

    move-result v3

    if-nez v3, :cond_3

    return-void

    .line 178
    :cond_3
    iget-object p1, p1, Lde/robv/android/xposed/XC_MethodHook$MethodHookParam;->args:[Ljava/lang/Object;

    aget-object p1, p1, v2

    invoke-virtual {p1}, Ljava/lang/Object;->toString()Ljava/lang/String;

    move-result-object p1

    invoke-static {p1}, Llocal/mio/os4camerabridge/LivePhotoCapturePathPolicy;->dateTakenMillis(Ljava/lang/String;)J

    move-result-wide v7

    .line 179
    invoke-static {}, Landroid/os/SystemClock;->elapsedRealtimeNanos()J

    move-result-wide v2

    iget-wide v4, v0, Llocal/mio/os4camerabridge/RearLivePhotoBridge$PendingPath;->nanos:J

    sub-long v3, v2, v4

    .line 180
    iget-object v2, v0, Llocal/mio/os4camerabridge/RearLivePhotoBridge$PendingPath;->path:Ljava/lang/String;

    iget-wide v5, v0, Llocal/mio/os4camerabridge/RearLivePhotoBridge$PendingPath;->wallMillis:J

    iget v9, v0, Llocal/mio/os4camerabridge/RearLivePhotoBridge$PendingPath;->generation:I

    iget-object p1, p0, Llocal/mio/os4camerabridge/RearLivePhotoBridge$5;->val$generation:Ljava/lang/reflect/Field;

    .line 181
    const/4 v10, 0x0

    invoke-virtual {p1, v10}, Ljava/lang/reflect/Field;->getInt(Ljava/lang/Object;)I

    move-result v10

    .line 180
    invoke-static/range {v2 .. v10}, Llocal/mio/os4camerabridge/LivePhotoCapturePathPolicy;->mayTransfer(Ljava/lang/String;JJJII)Z

    move-result p1

    if-nez p1, :cond_4

    .line 182
    iget-wide v0, v0, Llocal/mio/os4camerabridge/RearLivePhotoBridge$PendingPath;->wallMillis:J

    sub-long/2addr v7, v0

    new-instance p1, Ljava/lang/StringBuilder;

    invoke-direct {p1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v0, "path transfer rejected: ageNs="

    invoke-virtual {p1, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p1

    invoke-virtual {p1, v3, v4}, Ljava/lang/StringBuilder;->append(J)Ljava/lang/StringBuilder;

    move-result-object p1

    const-string v0, " shotDelta="

    invoke-virtual {p1, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p1

    invoke-virtual {p1, v7, v8}, Ljava/lang/StringBuilder;->append(J)Ljava/lang/StringBuilder;

    move-result-object p1

    invoke-virtual {p1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p1

    invoke-static {p1}, Llocal/mio/os4camerabridge/RearLivePhotoBridge;->-$$Nest$smlog(Ljava/lang/String;)V

    .line 183
    return-void

    .line 185
    :cond_4
    iget-object p1, p0, Llocal/mio/os4camerabridge/RearLivePhotoBridge$5;->val$path:Ljava/lang/reflect/Field;

    iget-object v2, v0, Llocal/mio/os4camerabridge/RearLivePhotoBridge$PendingPath;->path:Ljava/lang/String;

    invoke-virtual {p1, v1, v2}, Ljava/lang/reflect/Field;->set(Ljava/lang/Object;Ljava/lang/Object;)V

    .line 186
    iget-object p1, v0, Llocal/mio/os4camerabridge/RearLivePhotoBridge$PendingPath;->path:Ljava/lang/String;

    iget v0, v0, Llocal/mio/os4camerabridge/RearLivePhotoBridge$PendingPath;->generation:I

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "same-task Xiaomi path restored: "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p1

    const-string v1, " ageNs="

    invoke-virtual {p1, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p1

    invoke-virtual {p1, v3, v4}, Ljava/lang/StringBuilder;->append(J)Ljava/lang/StringBuilder;

    move-result-object p1

    const-string v1, " generation="

    invoke-virtual {p1, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p1

    invoke-virtual {p1, v0}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object p1

    invoke-virtual {p1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p1

    invoke-static {p1}, Llocal/mio/os4camerabridge/RearLivePhotoBridge;->-$$Nest$smlog(Ljava/lang/String;)V
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 188
    goto :goto_0

    :catchall_0
    move-exception v0

    move-object p1, v0

    invoke-static {p1}, Ljava/lang/String;->valueOf(Ljava/lang/Object;)Ljava/lang/String;

    move-result-object p1

    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "path transfer rejected: "

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p1

    invoke-virtual {p1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p1

    invoke-static {p1}, Llocal/mio/os4camerabridge/RearLivePhotoBridge;->-$$Nest$smlog(Ljava/lang/String;)V

    .line 189
    :goto_0
    return-void

    .line 171
    :cond_5
    :goto_1
    return-void
.end method
