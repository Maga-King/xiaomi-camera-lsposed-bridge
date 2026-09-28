.class Llocal/mio/os4camerabridge/GenericVideoSessionBridge$1;
.super Lde/robv/android/xposed/XC_MethodHook;
.source "GenericVideoSessionBridge.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Llocal/mio/os4camerabridge/GenericVideoSessionBridge;->install(Ljava/lang/ClassLoader;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# direct methods
.method constructor <init>()V
    .locals 0

    .line 35
    invoke-direct {p0}, Lde/robv/android/xposed/XC_MethodHook;-><init>()V

    return-void
.end method


# virtual methods
.method protected afterHookedMethod(Lde/robv/android/xposed/XC_MethodHook$MethodHookParam;)V
    .locals 5

    .line 37
    invoke-virtual {p1}, Lde/robv/android/xposed/XC_MethodHook$MethodHookParam;->hasThrowable()Z

    move-result v0

    if-eqz v0, :cond_0

    return-void

    .line 39
    :cond_0
    const/4 v0, 0x0

    :try_start_0
    iget-object v1, p1, Lde/robv/android/xposed/XC_MethodHook$MethodHookParam;->thisObject:Ljava/lang/Object;

    iget-object v2, p1, Lde/robv/android/xposed/XC_MethodHook$MethodHookParam;->args:[Ljava/lang/Object;

    const/4 v3, 0x1

    aget-object v2, v2, v3

    check-cast v2, Ljava/lang/Integer;

    invoke-virtual {v2}, Ljava/lang/Integer;->intValue()I

    move-result v2

    iget-object v3, p1, Lde/robv/android/xposed/XC_MethodHook$MethodHookParam;->args:[Ljava/lang/Object;

    const/4 v4, 0x2

    aget-object v3, v3, v4

    invoke-static {v1, v2, v3}, Llocal/mio/os4camerabridge/GenericVideoSessionBridge;->-$$Nest$smverifyProfile(Ljava/lang/Object;ILjava/lang/Object;)Z

    move-result v1

    .line 40
    invoke-static {v1}, Llocal/mio/os4camerabridge/GenericVideoSessionBridge;->-$$Nest$sfputprofileVerified(Z)V

    .line 41
    if-nez v1, :cond_1

    return-void

    .line 42
    :cond_1
    invoke-static {v0}, Ljava/lang/Boolean;->valueOf(Z)Ljava/lang/Boolean;

    move-result-object v1

    invoke-virtual {p1, v1}, Lde/robv/android/xposed/XC_MethodHook$MethodHookParam;->setResult(Ljava/lang/Object;)V

    .line 43
    invoke-static {}, Llocal/mio/os4camerabridge/GenericVideoSessionBridge;->-$$Nest$sfgetdecisionLogs()I

    move-result p1

    add-int/lit8 v1, p1, 0x1

    invoke-static {v1}, Llocal/mio/os4camerabridge/GenericVideoSessionBridge;->-$$Nest$sfputdecisionLogs(I)V

    const/16 v1, 0xc

    if-ge p1, v1, :cond_2

    const-string p1, "[GenericVideo] upstream settings EIS off before graph selection; live camera0 1080p30"

    invoke-static {p1}, Lde/robv/android/xposed/XposedBridge;->log(Ljava/lang/String;)V
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 48
    :cond_2
    goto :goto_0

    .line 45
    :catchall_0
    move-exception p1

    .line 46
    invoke-static {v0}, Llocal/mio/os4camerabridge/GenericVideoSessionBridge;->-$$Nest$sfputprofileVerified(Z)V

    .line 47
    invoke-static {p1}, Ljava/lang/String;->valueOf(Ljava/lang/Object;)Ljava/lang/String;

    move-result-object p1

    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "[GenericVideo] upstream profile unavailable: "

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p1

    invoke-virtual {p1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p1

    invoke-static {p1}, Lde/robv/android/xposed/XposedBridge;->log(Ljava/lang/String;)V

    .line 49
    :goto_0
    return-void
.end method
