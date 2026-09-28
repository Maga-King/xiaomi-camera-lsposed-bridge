.class Llocal/mio/os4camerabridge/LegendaryRawPackBridge$1;
.super Lde/robv/android/xposed/XC_MethodHook;
.source "LegendaryRawPackBridge.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Llocal/mio/os4camerabridge/LegendaryRawPackBridge;->install()V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic val$cipher:Ljava/lang/reflect/Method;

.field final synthetic val$transfer:Ljava/lang/reflect/Method;


# direct methods
.method constructor <init>(ILjava/lang/reflect/Method;Ljava/lang/reflect/Method;)V
    .locals 0

    .line 25
    iput-object p2, p0, Llocal/mio/os4camerabridge/LegendaryRawPackBridge$1;->val$transfer:Ljava/lang/reflect/Method;

    iput-object p3, p0, Llocal/mio/os4camerabridge/LegendaryRawPackBridge$1;->val$cipher:Ljava/lang/reflect/Method;

    invoke-direct {p0, p1}, Lde/robv/android/xposed/XC_MethodHook;-><init>(I)V

    return-void
.end method


# virtual methods
.method protected beforeHookedMethod(Lde/robv/android/xposed/XC_MethodHook$MethodHookParam;)V
    .locals 10

    .line 27
    invoke-static {}, Llocal/mio/os4camerabridge/LegendaryRawPackBridge;->-$$Nest$sfgetLOCK()Ljava/lang/Object;

    move-result-object v0

    monitor-enter v0

    .line 28
    :try_start_0
    invoke-static {}, Llocal/mio/os4camerabridge/LegendaryRawPackBridge;->-$$Nest$sfgetdisabled()Z

    move-result v1

    if-eqz v1, :cond_0

    monitor-exit v0
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_1

    return-void

    .line 30
    :cond_0
    const/4 v1, 0x1

    :try_start_1
    invoke-static {}, Landroid/os/SystemClock;->elapsedRealtime()J

    move-result-wide v2

    invoke-static {}, Llocal/mio/os4camerabridge/LegendaryRawPackBridge;->-$$Nest$smload()V

    .line 31
    iget-object v4, p1, Lde/robv/android/xposed/XC_MethodHook$MethodHookParam;->args:[Ljava/lang/Object;

    const/4 v5, 0x0

    aget-object v4, v4, v5

    check-cast v4, [B

    .line 32
    iget-object v5, p0, Llocal/mio/os4camerabridge/LegendaryRawPackBridge$1;->val$transfer:Ljava/lang/reflect/Method;

    iget-object v6, p1, Lde/robv/android/xposed/XC_MethodHook$MethodHookParam;->args:[Ljava/lang/Object;

    aget-object v6, v6, v1

    iget-object v7, p1, Lde/robv/android/xposed/XC_MethodHook$MethodHookParam;->args:[Ljava/lang/Object;

    const/4 v8, 0x2

    aget-object v7, v7, v8

    filled-new-array {v6, v7}, [Ljava/lang/Object;

    move-result-object v6

    const/4 v7, 0x0

    invoke-virtual {v5, v7, v6}, Ljava/lang/reflect/Method;->invoke(Ljava/lang/Object;[Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v5

    check-cast v5, [I

    .line 33
    invoke-static {v4, v5}, Llocal/mio/os4camerabridge/LegendaryRawPackBridge;->-$$Nest$smpackPixels([B[I)[B

    move-result-object v6

    .line 34
    if-eqz v6, :cond_1

    array-length v8, v6

    array-length v9, v4

    if-ne v8, v9, :cond_1

    .line 38
    invoke-static {v4, v6, v5}, Llocal/mio/os4camerabridge/LegendaryRawPackValidation;->check([B[B[I)V

    .line 39
    iget-object v4, p0, Llocal/mio/os4camerabridge/LegendaryRawPackBridge$1;->val$cipher:Ljava/lang/reflect/Method;

    iget-object v5, p1, Lde/robv/android/xposed/XC_MethodHook$MethodHookParam;->args:[Ljava/lang/Object;

    const/4 v8, 0x3

    aget-object v5, v5, v8

    filled-new-array {v6, v5}, [Ljava/lang/Object;

    move-result-object v5

    invoke-virtual {v4, v7, v5}, Ljava/lang/reflect/Method;->invoke(Ljava/lang/Object;[Ljava/lang/Object;)Ljava/lang/Object;

    .line 40
    invoke-static {}, Landroid/os/SystemClock;->elapsedRealtime()J

    move-result-wide v4

    sub-long/2addr v4, v2

    .line 41
    invoke-virtual {p1, v6}, Lde/robv/android/xposed/XC_MethodHook$MethodHookParam;->setResult(Ljava/lang/Object;)V

    .line 42
    array-length p1, v6

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "native pixel loop+original cipher ms="

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, v4, v5}, Ljava/lang/StringBuilder;->append(J)Ljava/lang/StringBuilder;

    move-result-object v2

    const-string v3, " bytes="

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, p1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object p1

    const-string v2, " checkedSamples=8192 originalTransfer=true subsequentCalibration=true"

    invoke-virtual {p1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p1

    invoke-virtual {p1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p1

    invoke-static {p1}, Llocal/mio/os4camerabridge/LegendaryRawPackBridge;->-$$Nest$smlog(Ljava/lang/String;)V

    goto :goto_0

    .line 34
    :cond_1
    new-instance p1, Ljava/lang/IllegalStateException;

    const-string v2, "native RAW length"

    invoke-direct {p1, v2}, Ljava/lang/IllegalStateException;-><init>(Ljava/lang/String;)V

    throw p1
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    .line 43
    :catchall_0
    move-exception p1

    :try_start_2
    invoke-static {v1}, Llocal/mio/os4camerabridge/LegendaryRawPackBridge;->-$$Nest$sfputdisabled(Z)V

    invoke-static {p1}, Ljava/lang/String;->valueOf(Ljava/lang/Object;)Ljava/lang/String;

    move-result-object p1

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "legacy packer retained: "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p1

    invoke-virtual {p1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p1

    invoke-static {p1}, Llocal/mio/os4camerabridge/LegendaryRawPackBridge;->-$$Nest$smlog(Ljava/lang/String;)V

    :goto_0
    nop

    .line 44
    monitor-exit v0

    .line 45
    return-void

    .line 44
    :catchall_1
    move-exception p1

    monitor-exit v0
    :try_end_2
    .catchall {:try_start_2 .. :try_end_2} :catchall_1

    throw p1
.end method
