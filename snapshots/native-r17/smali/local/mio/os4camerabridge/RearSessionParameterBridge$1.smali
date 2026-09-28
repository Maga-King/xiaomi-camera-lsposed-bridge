.class Llocal/mio/os4camerabridge/RearSessionParameterBridge$1;
.super Lde/robv/android/xposed/XC_MethodHook;
.source "RearSessionParameterBridge.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Llocal/mio/os4camerabridge/RearSessionParameterBridge;->install(Ljava/lang/ClassLoader;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic val$active:Ljava/lang/reflect/Field;

.field final synthetic val$camera:Ljava/lang/reflect/Field;

.field final synthetic val$currentSession:Ljava/lang/reflect/Field;

.field final synthetic val$generation:Ljava/lang/reflect/Field;

.field final synthetic val$lock:Ljava/lang/Object;

.field final synthetic val$module:Ljava/lang/reflect/Field;

.field final synthetic val$portrait:Ljava/lang/reflect/Field;


# direct methods
.method constructor <init>(Ljava/lang/Object;Ljava/lang/reflect/Field;Ljava/lang/reflect/Field;Ljava/lang/reflect/Field;Ljava/lang/reflect/Field;Ljava/lang/reflect/Field;Ljava/lang/reflect/Field;)V
    .locals 0

    .line 37
    iput-object p1, p0, Llocal/mio/os4camerabridge/RearSessionParameterBridge$1;->val$lock:Ljava/lang/Object;

    iput-object p2, p0, Llocal/mio/os4camerabridge/RearSessionParameterBridge$1;->val$active:Ljava/lang/reflect/Field;

    iput-object p3, p0, Llocal/mio/os4camerabridge/RearSessionParameterBridge$1;->val$module:Ljava/lang/reflect/Field;

    iput-object p4, p0, Llocal/mio/os4camerabridge/RearSessionParameterBridge$1;->val$camera:Ljava/lang/reflect/Field;

    iput-object p5, p0, Llocal/mio/os4camerabridge/RearSessionParameterBridge$1;->val$portrait:Ljava/lang/reflect/Field;

    iput-object p6, p0, Llocal/mio/os4camerabridge/RearSessionParameterBridge$1;->val$currentSession:Ljava/lang/reflect/Field;

    iput-object p7, p0, Llocal/mio/os4camerabridge/RearSessionParameterBridge$1;->val$generation:Ljava/lang/reflect/Field;

    invoke-direct {p0}, Lde/robv/android/xposed/XC_MethodHook;-><init>()V

    return-void
.end method


# virtual methods
.method protected afterHookedMethod(Lde/robv/android/xposed/XC_MethodHook$MethodHookParam;)V
    .locals 4
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/lang/Throwable;
        }
    .end annotation

    .line 39
    invoke-virtual {p1}, Lde/robv/android/xposed/XC_MethodHook$MethodHookParam;->hasThrowable()Z

    move-result v0

    if-nez v0, :cond_3

    invoke-virtual {p1}, Lde/robv/android/xposed/XC_MethodHook$MethodHookParam;->getResult()Ljava/lang/Object;

    move-result-object v0

    instance-of v0, v0, Landroid/hardware/camera2/CaptureRequest;

    if-nez v0, :cond_0

    goto :goto_1

    .line 40
    :cond_0
    iget-object v0, p0, Llocal/mio/os4camerabridge/RearSessionParameterBridge$1;->val$lock:Ljava/lang/Object;

    monitor-enter v0

    .line 41
    :try_start_0
    iget-object v1, p0, Llocal/mio/os4camerabridge/RearSessionParameterBridge$1;->val$active:Ljava/lang/reflect/Field;

    const/4 v2, 0x0

    invoke-virtual {v1, v2}, Ljava/lang/reflect/Field;->getBoolean(Ljava/lang/Object;)Z

    move-result v1

    if-eqz v1, :cond_2

    iget-object v1, p0, Llocal/mio/os4camerabridge/RearSessionParameterBridge$1;->val$module:Ljava/lang/reflect/Field;

    invoke-virtual {v1, v2}, Ljava/lang/reflect/Field;->getInt(Ljava/lang/Object;)I

    move-result v1

    invoke-static {v1}, Llocal/mio/os4camerabridge/RearSessionParameterBridge;->-$$Nest$smsupportedModule(I)Z

    move-result v1

    if-eqz v1, :cond_2

    iget-object v1, p0, Llocal/mio/os4camerabridge/RearSessionParameterBridge$1;->val$camera:Ljava/lang/reflect/Field;

    invoke-virtual {v1, v2}, Ljava/lang/reflect/Field;->getInt(Ljava/lang/Object;)I

    move-result v1

    if-nez v1, :cond_2

    iget-object v1, p0, Llocal/mio/os4camerabridge/RearSessionParameterBridge$1;->val$portrait:Ljava/lang/reflect/Field;

    .line 42
    invoke-virtual {v1, v2}, Ljava/lang/reflect/Field;->getBoolean(Ljava/lang/Object;)Z

    move-result v1

    if-nez v1, :cond_2

    iget-object v1, p1, Lde/robv/android/xposed/XC_MethodHook$MethodHookParam;->args:[Ljava/lang/Object;

    const/4 v3, 0x0

    aget-object v1, v1, v3

    iget-object v3, p0, Llocal/mio/os4camerabridge/RearSessionParameterBridge$1;->val$currentSession:Ljava/lang/reflect/Field;

    invoke-virtual {v3, v2}, Ljava/lang/reflect/Field;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v3

    if-eq v1, v3, :cond_1

    goto :goto_0

    .line 43
    :cond_1
    invoke-virtual {p1}, Lde/robv/android/xposed/XC_MethodHook$MethodHookParam;->getResult()Ljava/lang/Object;

    move-result-object p1

    check-cast p1, Landroid/hardware/camera2/CaptureRequest;

    invoke-static {p1}, Llocal/mio/os4camerabridge/RearSessionParameterBridge;->-$$Nest$sfputlatestPreview(Landroid/hardware/camera2/CaptureRequest;)V

    .line 44
    iget-object p1, p0, Llocal/mio/os4camerabridge/RearSessionParameterBridge$1;->val$generation:Ljava/lang/reflect/Field;

    invoke-virtual {p1, v2}, Ljava/lang/reflect/Field;->getInt(Ljava/lang/Object;)I

    move-result p1

    invoke-static {p1}, Llocal/mio/os4camerabridge/RearSessionParameterBridge;->-$$Nest$sfputpreviewGeneration(I)V

    .line 45
    monitor-exit v0

    .line 46
    return-void

    .line 42
    :cond_2
    :goto_0
    monitor-exit v0

    return-void

    .line 45
    :catchall_0
    move-exception p1

    monitor-exit v0
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    throw p1

    .line 39
    :cond_3
    :goto_1
    return-void
.end method
