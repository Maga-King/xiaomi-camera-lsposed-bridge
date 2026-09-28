.class Llocal/mio/os4camerabridge/RearLivePhotoBridge$4;
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


# direct methods
.method constructor <init>(Ljava/lang/reflect/Field;Ljava/lang/reflect/Field;Ljava/lang/reflect/Field;Ljava/lang/reflect/Field;)V
    .locals 0

    .line 154
    iput-object p1, p0, Llocal/mio/os4camerabridge/RearLivePhotoBridge$4;->val$active:Ljava/lang/reflect/Field;

    iput-object p2, p0, Llocal/mio/os4camerabridge/RearLivePhotoBridge$4;->val$module:Ljava/lang/reflect/Field;

    iput-object p3, p0, Llocal/mio/os4camerabridge/RearLivePhotoBridge$4;->val$camera:Ljava/lang/reflect/Field;

    iput-object p4, p0, Llocal/mio/os4camerabridge/RearLivePhotoBridge$4;->val$generation:Ljava/lang/reflect/Field;

    invoke-direct {p0}, Lde/robv/android/xposed/XC_MethodHook;-><init>()V

    return-void
.end method


# virtual methods
.method protected afterHookedMethod(Lde/robv/android/xposed/XC_MethodHook$MethodHookParam;)V
    .locals 8

    .line 156
    invoke-static {}, Llocal/mio/os4camerabridge/RearLivePhotoBridge;->-$$Nest$sfgetPENDING_PATH()Ljava/lang/ThreadLocal;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/ThreadLocal;->remove()V

    .line 158
    :try_start_0
    invoke-virtual {p1}, Lde/robv/android/xposed/XC_MethodHook$MethodHookParam;->hasThrowable()Z

    move-result v0

    if-nez v0, :cond_2

    iget-object v0, p0, Llocal/mio/os4camerabridge/RearLivePhotoBridge$4;->val$active:Ljava/lang/reflect/Field;

    iget-object v1, p0, Llocal/mio/os4camerabridge/RearLivePhotoBridge$4;->val$module:Ljava/lang/reflect/Field;

    iget-object v2, p0, Llocal/mio/os4camerabridge/RearLivePhotoBridge$4;->val$camera:Ljava/lang/reflect/Field;

    invoke-static {v0, v1, v2}, Llocal/mio/os4camerabridge/RearLivePhotoBridge;->-$$Nest$smeligible(Ljava/lang/reflect/Field;Ljava/lang/reflect/Field;Ljava/lang/reflect/Field;)Z

    move-result v0

    if-nez v0, :cond_0

    goto :goto_0

    .line 159
    :cond_0
    iget-object p1, p1, Lde/robv/android/xposed/XC_MethodHook$MethodHookParam;->args:[Ljava/lang/Object;

    const/4 v0, 0x0

    aget-object p1, p1, v0

    move-object v1, p1

    check-cast v1, Ljava/lang/String;

    .line 160
    invoke-static {v1}, Llocal/mio/os4camerabridge/LivePhotoCapturePathPolicy;->isNativeLivePath(Ljava/lang/String;)Z

    move-result p1

    if-eqz p1, :cond_1

    .line 161
    invoke-static {}, Llocal/mio/os4camerabridge/RearLivePhotoBridge;->-$$Nest$sfgetPENDING_PATH()Ljava/lang/ThreadLocal;

    move-result-object p1

    new-instance v0, Llocal/mio/os4camerabridge/RearLivePhotoBridge$PendingPath;

    invoke-static {}, Landroid/os/SystemClock;->elapsedRealtimeNanos()J

    move-result-wide v2

    .line 162
    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v4

    iget-object v6, p0, Llocal/mio/os4camerabridge/RearLivePhotoBridge$4;->val$generation:Ljava/lang/reflect/Field;

    const/4 v7, 0x0

    invoke-virtual {v6, v7}, Ljava/lang/reflect/Field;->getInt(Ljava/lang/Object;)I

    move-result v6

    invoke-direct/range {v0 .. v6}, Llocal/mio/os4camerabridge/RearLivePhotoBridge$PendingPath;-><init>(Ljava/lang/String;JJI)V

    .line 161
    invoke-virtual {p1, v0}, Ljava/lang/ThreadLocal;->set(Ljava/lang/Object;)V
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 164
    :cond_1
    goto :goto_1

    .line 158
    :cond_2
    :goto_0
    return-void

    .line 164
    :catchall_0
    move-exception v0

    move-object p1, v0

    invoke-static {p1}, Ljava/lang/String;->valueOf(Ljava/lang/Object;)Ljava/lang/String;

    move-result-object p1

    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "path observation rejected: "

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p1

    invoke-virtual {p1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p1

    invoke-static {p1}, Llocal/mio/os4camerabridge/RearLivePhotoBridge;->-$$Nest$smlog(Ljava/lang/String;)V

    .line 165
    :goto_1
    return-void
.end method
