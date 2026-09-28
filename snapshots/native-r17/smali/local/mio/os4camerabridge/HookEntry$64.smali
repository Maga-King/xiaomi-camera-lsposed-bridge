.class Llocal/mio/os4camerabridge/HookEntry$64;
.super Lde/robv/android/xposed/XC_MethodHook;
.source "HookEntry.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Llocal/mio/os4camerabridge/HookEntry;->hookUnifiedApsRepeatingRequests(Ljava/lang/ClassLoader;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# direct methods
.method constructor <init>()V
    .locals 0

    .line 9950
    invoke-direct {p0}, Lde/robv/android/xposed/XC_MethodHook;-><init>()V

    return-void
.end method


# virtual methods
.method protected beforeHookedMethod(Lde/robv/android/xposed/XC_MethodHook$MethodHookParam;)V
    .locals 4
    .param p1, "param"    # Lde/robv/android/xposed/XC_MethodHook$MethodHookParam;

    .line 9953
    iget-object v0, p1, Lde/robv/android/xposed/XC_MethodHook$MethodHookParam;->args:[Ljava/lang/Object;

    if-eqz v0, :cond_2

    iget-object v0, p1, Lde/robv/android/xposed/XC_MethodHook$MethodHookParam;->args:[Ljava/lang/Object;

    array-length v0, v0

    const/4 v1, 0x1

    if-lt v0, v1, :cond_2

    iget-object v0, p1, Lde/robv/android/xposed/XC_MethodHook$MethodHookParam;->args:[Ljava/lang/Object;

    const/4 v1, 0x0

    aget-object v0, v0, v1

    instance-of v0, v0, Landroid/hardware/camera2/CaptureRequest;

    if-eqz v0, :cond_2

    .line 9955
    iget-object v0, p1, Lde/robv/android/xposed/XC_MethodHook$MethodHookParam;->args:[Ljava/lang/Object;

    aget-object v0, v0, v1

    check-cast v0, Landroid/hardware/camera2/CaptureRequest;

    .line 9957
    .local v0, "original":Landroid/hardware/camera2/CaptureRequest;
    invoke-static {p1, v0}, Llocal/mio/os4camerabridge/HookEntry;->-$$Nest$smtrySubmitUnifiedApsBurstAtShutter(Lde/robv/android/xposed/XC_MethodHook$MethodHookParam;Landroid/hardware/camera2/CaptureRequest;)Z

    move-result v2

    if-eqz v2, :cond_0

    .line 9959
    return-void

    .line 9961
    :cond_0
    iget-object v2, p1, Lde/robv/android/xposed/XC_MethodHook$MethodHookParam;->thisObject:Ljava/lang/Object;

    .line 9962
    invoke-static {v2, v0}, Llocal/mio/os4camerabridge/HookEntry;->-$$Nest$smrewriteUnifiedApsXiaomiStillRequest(Ljava/lang/Object;Landroid/hardware/camera2/CaptureRequest;)Landroid/hardware/camera2/CaptureRequest;

    move-result-object v2

    .line 9964
    .local v2, "replacement":Landroid/hardware/camera2/CaptureRequest;
    if-ne v2, v0, :cond_1

    .line 9972
    iget-object v3, p1, Lde/robv/android/xposed/XC_MethodHook$MethodHookParam;->thisObject:Ljava/lang/Object;

    .line 9973
    invoke-static {v3, v0}, Llocal/mio/os4camerabridge/HookEntry;->-$$Nest$smaugmentUnifiedApsRepeatingRequest(Ljava/lang/Object;Landroid/hardware/camera2/CaptureRequest;)Landroid/hardware/camera2/CaptureRequest;

    move-result-object v2

    .line 9976
    :cond_1
    iget-object v3, p1, Lde/robv/android/xposed/XC_MethodHook$MethodHookParam;->args:[Ljava/lang/Object;

    aput-object v2, v3, v1

    .line 9978
    .end local v0    # "original":Landroid/hardware/camera2/CaptureRequest;
    .end local v2    # "replacement":Landroid/hardware/camera2/CaptureRequest;
    :cond_2
    return-void
.end method
