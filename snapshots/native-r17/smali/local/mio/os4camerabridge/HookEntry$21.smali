.class Llocal/mio/os4camerabridge/HookEntry$21;
.super Lde/robv/android/xposed/XC_MethodHook;
.source "HookEntry.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Llocal/mio/os4camerabridge/HookEntry;->hookOplusApsReferenceProbe(Ljava/lang/ClassLoader;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# direct methods
.method constructor <init>()V
    .locals 0

    .line 6063
    invoke-direct {p0}, Lde/robv/android/xposed/XC_MethodHook;-><init>()V

    return-void
.end method


# virtual methods
.method protected afterHookedMethod(Lde/robv/android/xposed/XC_MethodHook$MethodHookParam;)V
    .locals 8
    .param p1, "param"    # Lde/robv/android/xposed/XC_MethodHook$MethodHookParam;

    .line 6066
    invoke-virtual {p1}, Lde/robv/android/xposed/XC_MethodHook$MethodHookParam;->getResult()Ljava/lang/Object;

    move-result-object v0

    instance-of v0, v0, Landroid/hardware/camera2/CaptureRequest;

    if-nez v0, :cond_0

    .line 6067
    return-void

    .line 6069
    :cond_0
    invoke-virtual {p1}, Lde/robv/android/xposed/XC_MethodHook$MethodHookParam;->getResult()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Landroid/hardware/camera2/CaptureRequest;

    .line 6070
    .local v0, "request":Landroid/hardware/camera2/CaptureRequest;
    sget-object v1, Landroid/hardware/camera2/CaptureRequest;->CONTROL_CAPTURE_INTENT:Landroid/hardware/camera2/CaptureRequest$Key;

    invoke-virtual {v0, v1}, Landroid/hardware/camera2/CaptureRequest;->get(Landroid/hardware/camera2/CaptureRequest$Key;)Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Ljava/lang/Integer;

    .line 6072
    .local v1, "intent":Ljava/lang/Integer;
    const/4 v2, 0x2

    invoke-static {v2}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v2

    .line 6074
    invoke-virtual {v2, v1}, Ljava/lang/Integer;->equals(Ljava/lang/Object;)Z

    move-result v2

    const/4 v3, 0x1

    const/4 v4, 0x0

    if-nez v2, :cond_3

    .line 6075
    invoke-static {v0}, Llocal/mio/os4camerabridge/HookEntry;->-$$Nest$smlogOplusVideoZoomContract(Landroid/hardware/camera2/CaptureRequest;)V

    .line 6076
    invoke-static {}, Llocal/mio/os4camerabridge/HookEntry;->-$$Nest$sfgetOPLUS_REFERENCE_PREVIEW_COUNT()Ljava/util/concurrent/atomic/AtomicInteger;

    move-result-object v2

    .line 6077
    invoke-virtual {v2}, Ljava/util/concurrent/atomic/AtomicInteger;->incrementAndGet()I

    move-result v2

    .line 6078
    .local v2, "previewOrdinal":I
    const/16 v5, 0x10

    if-gt v2, v5, :cond_1

    .line 6079
    const-string v5, "PREVIEW_REQUEST"

    invoke-static {v5, v2, v1, v0}, Llocal/mio/os4camerabridge/HookEntry;->-$$Nest$smlogOplusRequestTargets(Ljava/lang/String;ILjava/lang/Integer;Landroid/hardware/camera2/CaptureRequest;)V

    .line 6082
    :cond_1
    invoke-static {v0}, Llocal/mio/os4camerabridge/HookEntry;->-$$Nest$smcaptureRequestHasTargets(Landroid/hardware/camera2/CaptureRequest;)Z

    move-result v5

    if-eqz v5, :cond_2

    invoke-static {}, Llocal/mio/os4camerabridge/HookEntry;->-$$Nest$sfgetOPLUS_REFERENCE_PREVIEW_PARAMS_DUMPED()Ljava/util/concurrent/atomic/AtomicBoolean;

    move-result-object v5

    .line 6084
    invoke-virtual {v5, v4, v3}, Ljava/util/concurrent/atomic/AtomicBoolean;->compareAndSet(ZZ)Z

    move-result v3

    if-eqz v3, :cond_2

    .line 6085
    const-string v3, "[OplusPreviewParam]"

    invoke-static {v3, v0}, Llocal/mio/os4camerabridge/HookEntry;->-$$Nest$smlogCaptureRequestKeyMap(Ljava/lang/String;Landroid/hardware/camera2/CaptureRequest;)V

    .line 6088
    :cond_2
    return-void

    .line 6090
    .end local v2    # "previewOrdinal":I
    :cond_3
    invoke-static {}, Llocal/mio/os4camerabridge/HookEntry;->-$$Nest$sfgetOPLUS_REFERENCE_STILL_COUNT()Ljava/util/concurrent/atomic/AtomicInteger;

    move-result-object v2

    invoke-virtual {v2}, Ljava/util/concurrent/atomic/AtomicInteger;->incrementAndGet()I

    move-result v2

    .line 6091
    .local v2, "ordinal":I
    const/16 v5, 0x8

    if-le v2, v5, :cond_4

    .line 6092
    return-void

    .line 6094
    :cond_4
    const-string v5, "STILL_REQUEST"

    invoke-static {v5, v2, v1, v0}, Llocal/mio/os4camerabridge/HookEntry;->-$$Nest$smlogOplusRequestTargets(Ljava/lang/String;ILjava/lang/Integer;Landroid/hardware/camera2/CaptureRequest;)V

    .line 6096
    invoke-static {}, Llocal/mio/os4camerabridge/HookEntry;->-$$Nest$sfgetOPLUS_REFERENCE_STILL_PARCEL_DUMPED()Ljava/util/concurrent/atomic/AtomicBoolean;

    move-result-object v5

    .line 6097
    invoke-virtual {v5, v4, v3}, Ljava/util/concurrent/atomic/AtomicBoolean;->compareAndSet(ZZ)Z

    move-result v3

    if-eqz v3, :cond_5

    .line 6098
    invoke-static {v0}, Llocal/mio/os4camerabridge/HookEntry;->-$$Nest$smdumpOplusStillRequestParcel(Landroid/hardware/camera2/CaptureRequest;)V

    .line 6100
    :cond_5
    invoke-virtual {v0}, Landroid/hardware/camera2/CaptureRequest;->getKeys()Ljava/util/List;

    move-result-object v3

    invoke-interface {v3}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object v3

    :goto_0
    invoke-interface {v3}, Ljava/util/Iterator;->hasNext()Z

    move-result v4

    if-eqz v4, :cond_7

    invoke-interface {v3}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v4

    check-cast v4, Landroid/hardware/camera2/CaptureRequest$Key;

    .line 6101
    .local v4, "key":Landroid/hardware/camera2/CaptureRequest$Key;, "Landroid/hardware/camera2/CaptureRequest$Key<*>;"
    invoke-virtual {v4}, Landroid/hardware/camera2/CaptureRequest$Key;->getName()Ljava/lang/String;

    move-result-object v5

    .line 6102
    .local v5, "name":Ljava/lang/String;
    invoke-static {v5}, Llocal/mio/os4camerabridge/HookEntry;->-$$Nest$smisOplusReferenceRequestKey(Ljava/lang/String;)Z

    move-result v6

    if-nez v6, :cond_6

    .line 6103
    goto :goto_0

    .line 6106
    :cond_6
    :try_start_0
    new-instance v6, Ljava/lang/StringBuilder;

    invoke-direct {v6}, Ljava/lang/StringBuilder;-><init>()V

    const-string v7, "[OplusReference] REQ #"

    invoke-virtual {v6, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    invoke-virtual {v6, v2}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v6

    const-string v7, " "

    invoke-virtual {v6, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    invoke-virtual {v6, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    const-string v7, "="

    invoke-virtual {v6, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    .line 6108
    invoke-virtual {v0, v4}, Landroid/hardware/camera2/CaptureRequest;->get(Landroid/hardware/camera2/CaptureRequest$Key;)Ljava/lang/Object;

    move-result-object v7

    invoke-static {v7}, Llocal/mio/os4camerabridge/HookEntry;->-$$Nest$smapsValueString(Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v7

    invoke-virtual {v6, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    invoke-virtual {v6}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v6

    .line 6106
    invoke-static {v6}, Llocal/mio/os4camerabridge/HookEntry;->-$$Nest$smlog(Ljava/lang/String;)V
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 6111
    goto :goto_1

    .line 6109
    :catchall_0
    move-exception v6

    .line 6112
    .end local v4    # "key":Landroid/hardware/camera2/CaptureRequest$Key;, "Landroid/hardware/camera2/CaptureRequest$Key<*>;"
    .end local v5    # "name":Ljava/lang/String;
    :goto_1
    goto :goto_0

    .line 6113
    :cond_7
    return-void
.end method
