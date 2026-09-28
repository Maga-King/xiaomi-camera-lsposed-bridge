.class public final Llocal/mio/os4camerabridge/RearSessionParameterBridge;
.super Ljava/lang/Object;
.source "RearSessionParameterBridge.java"


# static fields
.field private static final INSENSOR:Ljava/lang/String; = "org.codeaurora.qcamera3.sessionParameters.EnableInsensorZoom"

.field private static final LOGS:Ljava/util/concurrent/atomic/AtomicInteger;

.field private static final LUX:Ljava/lang/String; = "com.oplus.light.sensor.lux"

.field private static installed:Z

.field private static volatile latestPreview:Landroid/hardware/camera2/CaptureRequest;

.field private static volatile legendaryPhotoEnabled:Z

.field private static volatile previewGeneration:I


# direct methods
.method static bridge synthetic -$$Nest$sfgetLOGS()Ljava/util/concurrent/atomic/AtomicInteger;
    .locals 1

    sget-object v0, Llocal/mio/os4camerabridge/RearSessionParameterBridge;->LOGS:Ljava/util/concurrent/atomic/AtomicInteger;

    return-object v0
.end method

.method static bridge synthetic -$$Nest$sfgetlatestPreview()Landroid/hardware/camera2/CaptureRequest;
    .locals 1

    sget-object v0, Llocal/mio/os4camerabridge/RearSessionParameterBridge;->latestPreview:Landroid/hardware/camera2/CaptureRequest;

    return-object v0
.end method

.method static bridge synthetic -$$Nest$sfgetpreviewGeneration()I
    .locals 1

    sget v0, Llocal/mio/os4camerabridge/RearSessionParameterBridge;->previewGeneration:I

    return v0
.end method

.method static bridge synthetic -$$Nest$sfputlatestPreview(Landroid/hardware/camera2/CaptureRequest;)V
    .locals 0

    sput-object p0, Llocal/mio/os4camerabridge/RearSessionParameterBridge;->latestPreview:Landroid/hardware/camera2/CaptureRequest;

    return-void
.end method

.method static bridge synthetic -$$Nest$sfputpreviewGeneration(I)V
    .locals 0

    sput p0, Llocal/mio/os4camerabridge/RearSessionParameterBridge;->previewGeneration:I

    return-void
.end method

.method static bridge synthetic -$$Nest$smdisplay(Ljava/lang/Object;)Ljava/lang/String;
    .locals 0

    invoke-static {p0}, Llocal/mio/os4camerabridge/RearSessionParameterBridge;->display(Ljava/lang/Object;)Ljava/lang/String;

    move-result-object p0

    return-object p0
.end method

.method static bridge synthetic -$$Nest$smequal(Ljava/lang/Object;Ljava/lang/Object;)Z
    .locals 0

    invoke-static {p0, p1}, Llocal/mio/os4camerabridge/RearSessionParameterBridge;->equal(Ljava/lang/Object;Ljava/lang/Object;)Z

    move-result p0

    return p0
.end method

.method static bridge synthetic -$$Nest$smsupportedModule(I)Z
    .locals 0

    invoke-static {p0}, Llocal/mio/os4camerabridge/RearSessionParameterBridge;->supportedModule(I)Z

    move-result p0

    return p0
.end method

.method static bridge synthetic -$$Nest$smvalid(Ljava/lang/Object;)Z
    .locals 0

    invoke-static {p0}, Llocal/mio/os4camerabridge/RearSessionParameterBridge;->valid(Ljava/lang/Object;)Z

    move-result p0

    return p0
.end method

.method static constructor <clinit>()V
    .locals 1

    .line 15
    new-instance v0, Ljava/util/concurrent/atomic/AtomicInteger;

    invoke-direct {v0}, Ljava/util/concurrent/atomic/AtomicInteger;-><init>()V

    sput-object v0, Llocal/mio/os4camerabridge/RearSessionParameterBridge;->LOGS:Ljava/util/concurrent/atomic/AtomicInteger;

    .line 19
    const/4 v0, -0x1

    sput v0, Llocal/mio/os4camerabridge/RearSessionParameterBridge;->previewGeneration:I

    return-void
.end method

.method private constructor <init>()V
    .locals 0

    .line 20
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method private static display(Ljava/lang/Object;)Ljava/lang/String;
    .locals 1

    .line 105
    instance-of v0, p0, [F

    if-eqz v0, :cond_0

    check-cast p0, [F

    invoke-static {p0}, Ljava/util/Arrays;->toString([F)Ljava/lang/String;

    move-result-object p0

    goto :goto_0

    .line 106
    :cond_0
    instance-of v0, p0, [I

    if-eqz v0, :cond_1

    check-cast p0, [I

    invoke-static {p0}, Ljava/util/Arrays;->toString([I)Ljava/lang/String;

    move-result-object p0

    goto :goto_0

    :cond_1
    invoke-static {p0}, Ljava/lang/String;->valueOf(Ljava/lang/Object;)Ljava/lang/String;

    move-result-object p0

    .line 105
    :goto_0
    return-object p0
.end method

.method private static equal(Ljava/lang/Object;Ljava/lang/Object;)Z
    .locals 1

    .line 101
    instance-of v0, p0, [F

    if-eqz v0, :cond_0

    instance-of v0, p1, [F

    if-eqz v0, :cond_0

    check-cast p0, [F

    check-cast p1, [F

    invoke-static {p0, p1}, Ljava/util/Arrays;->equals([F[F)Z

    move-result p0

    return p0

    .line 102
    :cond_0
    instance-of v0, p0, [I

    if-eqz v0, :cond_1

    instance-of v0, p1, [I

    if-eqz v0, :cond_1

    check-cast p0, [I

    check-cast p1, [I

    invoke-static {p0, p1}, Ljava/util/Arrays;->equals([I[I)Z

    move-result p0

    return p0

    .line 103
    :cond_1
    if-eqz p0, :cond_2

    invoke-virtual {p0, p1}, Ljava/lang/Object;->equals(Ljava/lang/Object;)Z

    move-result p0

    if-eqz p0, :cond_2

    const/4 p0, 0x1

    goto :goto_0

    :cond_2
    const/4 p0, 0x0

    :goto_0
    return p0
.end method

.method private static field(Ljava/lang/Class;Ljava/lang/String;Ljava/lang/Class;)Ljava/lang/reflect/Field;
    .locals 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/lang/Class<",
            "*>;",
            "Ljava/lang/String;",
            "Ljava/lang/Class<",
            "*>;)",
            "Ljava/lang/reflect/Field;"
        }
    .end annotation

    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/lang/Exception;
        }
    .end annotation

    .line 108
    invoke-virtual {p0, p1}, Ljava/lang/Class;->getDeclaredField(Ljava/lang/String;)Ljava/lang/reflect/Field;

    move-result-object p0

    .line 109
    invoke-virtual {p0}, Ljava/lang/reflect/Field;->getType()Ljava/lang/Class;

    move-result-object v0

    if-ne v0, p2, :cond_0

    .line 110
    const/4 p1, 0x1

    invoke-virtual {p0, p1}, Ljava/lang/reflect/Field;->setAccessible(Z)V

    .line 111
    return-object p0

    .line 109
    :cond_0
    new-instance p0, Ljava/lang/IllegalStateException;

    new-instance p2, Ljava/lang/StringBuilder;

    invoke-direct {p2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v0, "Unexpected field type: "

    invoke-virtual {p2, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p2

    invoke-virtual {p2, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p1

    invoke-virtual {p1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p1

    invoke-direct {p0, p1}, Ljava/lang/IllegalStateException;-><init>(Ljava/lang/String;)V

    throw p0
.end method

.method public static declared-synchronized install(Ljava/lang/ClassLoader;)V
    .locals 13

    const-class p0, Llocal/mio/os4camerabridge/RearSessionParameterBridge;

    monitor-enter p0

    .line 23
    :try_start_0
    sget-boolean v0, Llocal/mio/os4camerabridge/RearSessionParameterBridge;->installed:Z
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_1

    if-eqz v0, :cond_0

    monitor-exit p0

    return-void

    .line 25
    :cond_0
    :try_start_1
    const-class v0, Llocal/mio/os4camerabridge/RearSessionParameterBridge;

    invoke-virtual {v0}, Ljava/lang/Class;->getClassLoader()Ljava/lang/ClassLoader;

    move-result-object v0

    .line 26
    const-string v1, "local.mio.os4camerabridge.HookEntry"

    const/4 v2, 0x0

    invoke-static {v1, v2, v0}, Ljava/lang/Class;->forName(Ljava/lang/String;ZLjava/lang/ClassLoader;)Ljava/lang/Class;

    move-result-object v1

    .line 27
    const-string v3, "local.mio.os4camerabridge.HookEntry$CommonApsDecision"

    invoke-static {v3, v2, v0}, Ljava/lang/Class;->forName(Ljava/lang/String;ZLjava/lang/ClassLoader;)Ljava/lang/Class;

    move-result-object v0

    .line 28
    const-string v2, "commonApsUnifiedSessionActive"

    sget-object v3, Ljava/lang/Boolean;->TYPE:Ljava/lang/Class;

    invoke-static {v1, v2, v3}, Llocal/mio/os4camerabridge/RearSessionParameterBridge;->field(Ljava/lang/Class;Ljava/lang/String;Ljava/lang/Class;)Ljava/lang/reflect/Field;

    move-result-object v6

    .line 29
    const-string v2, "activeCameraModule"

    sget-object v3, Ljava/lang/Integer;->TYPE:Ljava/lang/Class;

    invoke-static {v1, v2, v3}, Llocal/mio/os4camerabridge/RearSessionParameterBridge;->field(Ljava/lang/Class;Ljava/lang/String;Ljava/lang/Class;)Ljava/lang/reflect/Field;

    move-result-object v7

    .line 30
    const-string v2, "activeCameraId"

    sget-object v3, Ljava/lang/Integer;->TYPE:Ljava/lang/Class;

    invoke-static {v1, v2, v3}, Llocal/mio/os4camerabridge/RearSessionParameterBridge;->field(Ljava/lang/Class;Ljava/lang/String;Ljava/lang/Class;)Ljava/lang/reflect/Field;

    move-result-object v8

    .line 31
    const-string v2, "commonApsUnifiedPortraitSession"

    sget-object v3, Ljava/lang/Boolean;->TYPE:Ljava/lang/Class;

    invoke-static {v1, v2, v3}, Llocal/mio/os4camerabridge/RearSessionParameterBridge;->field(Ljava/lang/Class;Ljava/lang/String;Ljava/lang/Class;)Ljava/lang/reflect/Field;

    move-result-object v9

    .line 32
    const-string v2, "commonApsUnifiedSessionParameters"

    const-class v3, Landroid/hardware/camera2/CaptureRequest;

    invoke-static {v1, v2, v3}, Llocal/mio/os4camerabridge/RearSessionParameterBridge;->field(Ljava/lang/Class;Ljava/lang/String;Ljava/lang/Class;)Ljava/lang/reflect/Field;

    move-result-object v2

    .line 33
    const-string v3, "commonApsUnifiedSessionGeneration"

    sget-object v4, Ljava/lang/Integer;->TYPE:Ljava/lang/Class;

    invoke-static {v1, v3, v4}, Llocal/mio/os4camerabridge/RearSessionParameterBridge;->field(Ljava/lang/Class;Ljava/lang/String;Ljava/lang/Class;)Ljava/lang/reflect/Field;

    move-result-object v11

    .line 34
    const-string v3, "commonApsUnifiedSession"

    const-class v4, Landroid/hardware/camera2/CameraCaptureSession;

    invoke-static {v1, v3, v4}, Llocal/mio/os4camerabridge/RearSessionParameterBridge;->field(Ljava/lang/Class;Ljava/lang/String;Ljava/lang/Class;)Ljava/lang/reflect/Field;

    move-result-object v10

    .line 35
    const-string v3, "COMMON_APS_UNIFIED_SESSION_LOCK"

    const-class v4, Ljava/lang/Object;

    invoke-static {v1, v3, v4}, Llocal/mio/os4camerabridge/RearSessionParameterBridge;->field(Ljava/lang/Class;Ljava/lang/String;Ljava/lang/Class;)Ljava/lang/reflect/Field;

    move-result-object v3

    const/4 v4, 0x0

    invoke-virtual {v3, v4}, Ljava/lang/reflect/Field;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v5

    .line 36
    const-string v3, "augmentUnifiedApsRepeatingRequest"

    const-class v4, Ljava/lang/Object;

    const-class v12, Landroid/hardware/camera2/CaptureRequest;

    filled-new-array {v4, v12}, [Ljava/lang/Class;

    move-result-object v4

    invoke-virtual {v1, v3, v4}, Ljava/lang/Class;->getDeclaredMethod(Ljava/lang/String;[Ljava/lang/Class;)Ljava/lang/reflect/Method;

    move-result-object v3

    .line 37
    new-instance v4, Llocal/mio/os4camerabridge/RearSessionParameterBridge$1;

    invoke-direct/range {v4 .. v11}, Llocal/mio/os4camerabridge/RearSessionParameterBridge$1;-><init>(Ljava/lang/Object;Ljava/lang/reflect/Field;Ljava/lang/reflect/Field;Ljava/lang/reflect/Field;Ljava/lang/reflect/Field;Ljava/lang/reflect/Field;Ljava/lang/reflect/Field;)V

    invoke-static {v3, v4}, Lde/robv/android/xposed/XposedBridge;->hookMethod(Ljava/lang/reflect/Member;Lde/robv/android/xposed/XC_MethodHook;)Lde/robv/android/xposed/XC_MethodHook$Unhook;

    .line 48
    const-string v3, "applyCommonApsRequestTags"

    const-class v4, Landroid/hardware/camera2/CaptureRequest$Builder;

    sget-object v10, Ljava/lang/Integer;->TYPE:Ljava/lang/Class;

    filled-new-array {v4, v10, v0}, [Ljava/lang/Class;

    move-result-object v0

    invoke-virtual {v1, v3, v0}, Ljava/lang/Class;->getDeclaredMethod(Ljava/lang/String;[Ljava/lang/Class;)Ljava/lang/reflect/Method;

    move-result-object v0

    .line 49
    invoke-virtual {v0}, Ljava/lang/reflect/Method;->getReturnType()Ljava/lang/Class;

    move-result-object v1

    sget-object v3, Ljava/lang/Boolean;->TYPE:Ljava/lang/Class;

    if-ne v1, v3, :cond_1

    .line 50
    new-instance v4, Llocal/mio/os4camerabridge/RearSessionParameterBridge$2;

    move-object v10, v2

    invoke-direct/range {v4 .. v11}, Llocal/mio/os4camerabridge/RearSessionParameterBridge$2;-><init>(Ljava/lang/Object;Ljava/lang/reflect/Field;Ljava/lang/reflect/Field;Ljava/lang/reflect/Field;Ljava/lang/reflect/Field;Ljava/lang/reflect/Field;Ljava/lang/reflect/Field;)V

    invoke-static {v0, v4}, Lde/robv/android/xposed/XposedBridge;->hookMethod(Ljava/lang/reflect/Member;Lde/robv/android/xposed/XC_MethodHook;)Lde/robv/android/xposed/XC_MethodHook$Unhook;

    .line 88
    const/4 v0, 0x1

    sput-boolean v0, Llocal/mio/os4camerabridge/RearSessionParameterBridge;->installed:Z

    .line 89
    const-string v0, "[RearSessionParameter] installed v2; lux/session and insensor/live-preview retained, no forced zoom value"

    invoke-static {v0}, Lde/robv/android/xposed/XposedBridge;->log(Ljava/lang/String;)V

    goto :goto_0

    .line 49
    :cond_1
    new-instance v0, Ljava/lang/IllegalStateException;

    const-string v1, "Wrong tag-writer signature"

    invoke-direct {v0, v1}, Ljava/lang/IllegalStateException;-><init>(Ljava/lang/String;)V

    throw v0
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    .line 90
    :catchall_0
    move-exception v0

    :try_start_2
    invoke-static {v0}, Ljava/lang/String;->valueOf(Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v0

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "[RearSessionParameter] install rejected: "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Lde/robv/android/xposed/XposedBridge;->log(Ljava/lang/String;)V
    :try_end_2
    .catchall {:try_start_2 .. :try_end_2} :catchall_1

    :goto_0
    nop

    .line 91
    monitor-exit p0

    return-void

    .line 22
    :catchall_1
    move-exception v0

    :try_start_3
    monitor-exit p0
    :try_end_3
    .catchall {:try_start_3 .. :try_end_3} :catchall_1

    throw v0
.end method

.method private static supportedModule(I)Z
    .locals 1

    .line 93
    const/16 v0, 0xa3

    if-eq p0, v0, :cond_1

    sget-boolean v0, Llocal/mio/os4camerabridge/RearSessionParameterBridge;->legendaryPhotoEnabled:Z

    if-eqz v0, :cond_0

    const/16 v0, 0x100

    if-ne p0, v0, :cond_0

    goto :goto_0

    :cond_0
    const/4 p0, 0x0

    goto :goto_1

    :cond_1
    :goto_0
    const/4 p0, 0x1

    :goto_1
    return p0
.end method

.method private static valid(Ljava/lang/Object;)Z
    .locals 4

    .line 96
    instance-of v0, p0, Ljava/lang/Float;

    const/4 v1, 0x1

    if-eqz v0, :cond_0

    move-object v0, p0

    check-cast v0, Ljava/lang/Float;

    invoke-virtual {v0}, Ljava/lang/Float;->floatValue()F

    move-result v0

    invoke-static {v0}, Ljava/lang/Float;->isFinite(F)Z

    move-result v0

    if-nez v0, :cond_3

    :cond_0
    instance-of v0, p0, [F

    const/4 v2, 0x0

    if-eqz v0, :cond_1

    move-object v0, p0

    check-cast v0, [F

    array-length v3, v0

    if-ne v3, v1, :cond_1

    aget v0, v0, v2

    .line 97
    invoke-static {v0}, Ljava/lang/Float;->isFinite(F)Z

    move-result v0

    if-nez v0, :cond_3

    :cond_1
    instance-of v0, p0, Ljava/lang/Integer;

    if-nez v0, :cond_3

    instance-of v0, p0, [I

    if-eqz v0, :cond_2

    check-cast p0, [I

    array-length p0, p0

    if-ne p0, v1, :cond_2

    goto :goto_0

    :cond_2
    move v1, v2

    goto :goto_1

    :cond_3
    :goto_0
    nop

    .line 96
    :goto_1
    return v1
.end method
