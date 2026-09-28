.class Llocal/mio/os4camerabridge/RearTelePreviewBridge$1;
.super Lde/robv/android/xposed/XC_MethodHook;
.source "RearTelePreviewBridge.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Llocal/mio/os4camerabridge/RearTelePreviewBridge;->install(Ljava/lang/ClassLoader;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic val$camera:Ljava/lang/reflect/Field;

.field final synthetic val$module:Ljava/lang/reflect/Field;

.field final synthetic val$portrait:Ljava/lang/reflect/Field;

.field final synthetic val$unified:Ljava/lang/reflect/Field;


# direct methods
.method constructor <init>(ILjava/lang/reflect/Field;Ljava/lang/reflect/Field;Ljava/lang/reflect/Field;Ljava/lang/reflect/Field;)V
    .locals 0

    .line 31
    iput-object p2, p0, Llocal/mio/os4camerabridge/RearTelePreviewBridge$1;->val$module:Ljava/lang/reflect/Field;

    iput-object p3, p0, Llocal/mio/os4camerabridge/RearTelePreviewBridge$1;->val$camera:Ljava/lang/reflect/Field;

    iput-object p4, p0, Llocal/mio/os4camerabridge/RearTelePreviewBridge$1;->val$unified:Ljava/lang/reflect/Field;

    iput-object p5, p0, Llocal/mio/os4camerabridge/RearTelePreviewBridge$1;->val$portrait:Ljava/lang/reflect/Field;

    invoke-direct {p0, p1}, Lde/robv/android/xposed/XC_MethodHook;-><init>(I)V

    return-void
.end method


# virtual methods
.method protected afterHookedMethod(Lde/robv/android/xposed/XC_MethodHook$MethodHookParam;)V
    .locals 11

    .line 33
    invoke-virtual {p1}, Lde/robv/android/xposed/XC_MethodHook$MethodHookParam;->hasThrowable()Z

    move-result v0

    if-eqz v0, :cond_0

    return-void

    .line 35
    :cond_0
    const/16 v1, 0xc

    :try_start_0
    iget-object v0, p1, Lde/robv/android/xposed/XC_MethodHook$MethodHookParam;->args:[Ljava/lang/Object;

    const/4 v2, 0x0

    aget-object v0, v0, v2

    check-cast v0, Landroid/hardware/camera2/CaptureRequest$Builder;

    .line 36
    sget-object v2, Landroid/hardware/camera2/CaptureRequest;->CONTROL_ZOOM_RATIO:Landroid/hardware/camera2/CaptureRequest$Key;

    invoke-virtual {v0, v2}, Landroid/hardware/camera2/CaptureRequest$Builder;->get(Landroid/hardware/camera2/CaptureRequest$Key;)Ljava/lang/Object;

    move-result-object v2

    check-cast v2, Ljava/lang/Float;

    .line 37
    if-eqz v2, :cond_4

    iget-object v3, p0, Llocal/mio/os4camerabridge/RearTelePreviewBridge$1;->val$module:Ljava/lang/reflect/Field;

    const/4 v4, 0x0

    invoke-virtual {v3, v4}, Ljava/lang/reflect/Field;->getInt(Ljava/lang/Object;)I

    move-result v5

    iget-object v3, p0, Llocal/mio/os4camerabridge/RearTelePreviewBridge$1;->val$camera:Ljava/lang/reflect/Field;

    .line 38
    invoke-virtual {v3, v4}, Ljava/lang/reflect/Field;->getInt(Ljava/lang/Object;)I

    move-result v6

    iget-object v3, p0, Llocal/mio/os4camerabridge/RearTelePreviewBridge$1;->val$unified:Ljava/lang/reflect/Field;

    invoke-virtual {v3, v4}, Ljava/lang/reflect/Field;->getBoolean(Ljava/lang/Object;)Z

    move-result v7

    iget-object v3, p0, Llocal/mio/os4camerabridge/RearTelePreviewBridge$1;->val$portrait:Ljava/lang/reflect/Field;

    .line 39
    invoke-virtual {v3, v4}, Ljava/lang/reflect/Field;->getBoolean(Ljava/lang/Object;)Z

    move-result v8

    iget-object p1, p1, Lde/robv/android/xposed/XC_MethodHook$MethodHookParam;->args:[Ljava/lang/Object;

    const/4 v3, 0x2

    aget-object p1, p1, v3

    check-cast p1, Ljava/lang/Boolean;

    invoke-virtual {p1}, Ljava/lang/Boolean;->booleanValue()Z

    move-result v9

    invoke-virtual {v2}, Ljava/lang/Float;->floatValue()F

    move-result v10

    .line 37
    invoke-static/range {v5 .. v10}, Llocal/mio/os4camerabridge/RearTelePreviewPolicy;->eligible(IIZZZF)Z

    move-result p1

    if-nez p1, :cond_1

    goto :goto_0

    .line 40
    :cond_1
    invoke-static {}, Llocal/mio/os4camerabridge/RearTelePreviewBridge;->-$$Nest$sfgetFALLBACK()Landroid/hardware/camera2/CaptureRequest$Key;

    move-result-object p1

    invoke-virtual {v0, p1}, Landroid/hardware/camera2/CaptureRequest$Builder;->get(Landroid/hardware/camera2/CaptureRequest$Key;)Ljava/lang/Object;

    move-result-object p1

    check-cast p1, [I

    .line 41
    invoke-static {p1}, Llocal/mio/os4camerabridge/RearTelePreviewPolicy;->mask([I)[I

    move-result-object v3

    .line 42
    if-nez v3, :cond_2

    return-void

    .line 43
    :cond_2
    invoke-static {}, Llocal/mio/os4camerabridge/RearTelePreviewBridge;->-$$Nest$sfgetFALLBACK()Landroid/hardware/camera2/CaptureRequest$Key;

    move-result-object v4

    invoke-virtual {v0, v4, v3}, Landroid/hardware/camera2/CaptureRequest$Builder;->set(Landroid/hardware/camera2/CaptureRequest$Key;Ljava/lang/Object;)V

    .line 44
    invoke-static {}, Llocal/mio/os4camerabridge/RearTelePreviewBridge;->-$$Nest$sfgetLOGS()Ljava/util/concurrent/atomic/AtomicInteger;

    move-result-object v3

    invoke-virtual {v3}, Ljava/util/concurrent/atomic/AtomicInteger;->getAndIncrement()I

    move-result v3

    if-ge v3, v1, :cond_3

    .line 46
    invoke-static {p1}, Ljava/util/Arrays;->toString([I)Ljava/lang/String;

    move-result-object p1

    invoke-static {}, Llocal/mio/os4camerabridge/RearTelePreviewBridge;->-$$Nest$sfgetFALLBACK()Landroid/hardware/camera2/CaptureRequest$Key;

    move-result-object v3

    .line 47
    invoke-virtual {v0, v3}, Landroid/hardware/camera2/CaptureRequest$Builder;->get(Landroid/hardware/camera2/CaptureRequest$Key;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, [I

    invoke-static {v0}, Ljava/util/Arrays;->toString([I)Ljava/lang/String;

    move-result-object v0

    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    const-string v4, "[RearTelePreview] experiment-v1 zoom="

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v2

    const-string v3, " fallbackMask="

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p1

    const-string v2, "->"

    invoke-virtual {p1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p1

    invoke-virtual {p1, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p1

    const-string v0, " previewOnly=true; actual lens must be verified in results"

    invoke-virtual {p1, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p1

    invoke-virtual {p1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p1

    .line 44
    invoke-static {p1}, Lde/robv/android/xposed/XposedBridge;->log(Ljava/lang/String;)V
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 52
    :cond_3
    goto :goto_1

    .line 39
    :cond_4
    :goto_0
    return-void

    .line 49
    :catchall_0
    move-exception v0

    move-object p1, v0

    .line 50
    invoke-static {}, Llocal/mio/os4camerabridge/RearTelePreviewBridge;->-$$Nest$sfgetLOGS()Ljava/util/concurrent/atomic/AtomicInteger;

    move-result-object v0

    invoke-virtual {v0}, Ljava/util/concurrent/atomic/AtomicInteger;->getAndIncrement()I

    move-result v0

    if-ge v0, v1, :cond_5

    invoke-static {p1}, Ljava/lang/String;->valueOf(Ljava/lang/Object;)Ljava/lang/String;

    move-result-object p1

    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "[RearTelePreview] request retained: "

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p1

    invoke-virtual {p1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p1

    invoke-static {p1}, Lde/robv/android/xposed/XposedBridge;->log(Ljava/lang/String;)V

    .line 53
    :cond_5
    :goto_1
    return-void
.end method
