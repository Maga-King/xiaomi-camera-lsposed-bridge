.class Llocal/mio/os4camerabridge/HookEntry$65;
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

    .line 9981
    invoke-direct {p0}, Lde/robv/android/xposed/XC_MethodHook;-><init>()V

    return-void
.end method


# virtual methods
.method protected beforeHookedMethod(Lde/robv/android/xposed/XC_MethodHook$MethodHookParam;)V
    .locals 9
    .param p1, "param"    # Lde/robv/android/xposed/XC_MethodHook$MethodHookParam;

    .line 9984
    invoke-static {}, Llocal/mio/os4camerabridge/HookEntry;->-$$Nest$sfgetcommonApsUnifiedSessionActive()Z

    move-result v0

    if-eqz v0, :cond_5

    iget-object v0, p1, Lde/robv/android/xposed/XC_MethodHook$MethodHookParam;->thisObject:Ljava/lang/Object;

    invoke-static {}, Llocal/mio/os4camerabridge/HookEntry;->-$$Nest$sfgetcommonApsUnifiedSession()Landroid/hardware/camera2/CameraCaptureSession;

    move-result-object v1

    if-ne v0, v1, :cond_5

    iget-object v0, p1, Lde/robv/android/xposed/XC_MethodHook$MethodHookParam;->args:[Ljava/lang/Object;

    if-eqz v0, :cond_5

    iget-object v0, p1, Lde/robv/android/xposed/XC_MethodHook$MethodHookParam;->args:[Ljava/lang/Object;

    array-length v0, v0

    const/4 v1, 0x1

    if-lt v0, v1, :cond_5

    iget-object v0, p1, Lde/robv/android/xposed/XC_MethodHook$MethodHookParam;->args:[Ljava/lang/Object;

    const/4 v2, 0x0

    aget-object v0, v0, v2

    instance-of v0, v0, Ljava/util/List;

    if-nez v0, :cond_0

    goto :goto_2

    .line 9992
    :cond_0
    new-instance v0, Ljava/util/ArrayList;

    invoke-direct {v0}, Ljava/util/ArrayList;-><init>()V

    .line 9994
    .local v0, "rewritten":Ljava/util/ArrayList;, "Ljava/util/ArrayList<Landroid/hardware/camera2/CaptureRequest;>;"
    const/4 v3, 0x0

    .line 9995
    .local v3, "changed":Z
    iget-object v4, p1, Lde/robv/android/xposed/XC_MethodHook$MethodHookParam;->args:[Ljava/lang/Object;

    aget-object v4, v4, v2

    check-cast v4, Ljava/util/List;

    invoke-interface {v4}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object v4

    :goto_0
    invoke-interface {v4}, Ljava/util/Iterator;->hasNext()Z

    move-result v5

    if-eqz v5, :cond_3

    invoke-interface {v4}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v5

    .line 9996
    .local v5, "item":Ljava/lang/Object;
    instance-of v6, v5, Landroid/hardware/camera2/CaptureRequest;

    if-nez v6, :cond_1

    .line 9997
    return-void

    .line 9999
    :cond_1
    move-object v6, v5

    check-cast v6, Landroid/hardware/camera2/CaptureRequest;

    .line 10000
    .local v6, "source":Landroid/hardware/camera2/CaptureRequest;
    iget-object v7, p1, Lde/robv/android/xposed/XC_MethodHook$MethodHookParam;->thisObject:Ljava/lang/Object;

    .line 10001
    invoke-static {v7, v6}, Llocal/mio/os4camerabridge/HookEntry;->-$$Nest$smrewriteUnifiedApsXiaomiStillRequest(Ljava/lang/Object;Landroid/hardware/camera2/CaptureRequest;)Landroid/hardware/camera2/CaptureRequest;

    move-result-object v7

    .line 10003
    .local v7, "replacement":Landroid/hardware/camera2/CaptureRequest;
    invoke-virtual {v0, v7}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    .line 10004
    if-eq v7, v6, :cond_2

    move v8, v1

    goto :goto_1

    :cond_2
    move v8, v2

    :goto_1
    or-int/2addr v3, v8

    .line 10005
    .end local v5    # "item":Ljava/lang/Object;
    .end local v6    # "source":Landroid/hardware/camera2/CaptureRequest;
    .end local v7    # "replacement":Landroid/hardware/camera2/CaptureRequest;
    goto :goto_0

    .line 10006
    :cond_3
    if-eqz v3, :cond_4

    .line 10007
    iget-object v1, p1, Lde/robv/android/xposed/XC_MethodHook$MethodHookParam;->args:[Ljava/lang/Object;

    aput-object v0, v1, v2

    .line 10009
    :cond_4
    return-void

    .line 9990
    .end local v0    # "rewritten":Ljava/util/ArrayList;, "Ljava/util/ArrayList<Landroid/hardware/camera2/CaptureRequest;>;"
    .end local v3    # "changed":Z
    :cond_5
    :goto_2
    return-void
.end method
