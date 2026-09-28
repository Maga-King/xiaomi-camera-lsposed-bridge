.class Llocal/mio/os4camerabridge/HookEntry$26;
.super Lde/robv/android/xposed/XC_MethodHook;
.source "HookEntry.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Llocal/mio/os4camerabridge/HookEntry;->hookLegendaryRawPipeline(Ljava/lang/ClassLoader;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# direct methods
.method constructor <init>()V
    .locals 0

    .line 6630
    invoke-direct {p0}, Lde/robv/android/xposed/XC_MethodHook;-><init>()V

    return-void
.end method


# virtual methods
.method protected afterHookedMethod(Lde/robv/android/xposed/XC_MethodHook$MethodHookParam;)V
    .locals 3
    .param p1, "param"    # Lde/robv/android/xposed/XC_MethodHook$MethodHookParam;

    .line 6633
    invoke-static {}, Llocal/mio/os4camerabridge/HookEntry;->-$$Nest$sfgetlegendRawSessionActive()Z

    move-result v0

    if-eqz v0, :cond_1

    invoke-static {}, Llocal/mio/os4camerabridge/HookEntry;->-$$Nest$sfgetactiveCameraModule()I

    move-result v0

    const/16 v1, 0x100

    if-ne v0, v1, :cond_1

    invoke-static {}, Llocal/mio/os4camerabridge/HookEntry;->-$$Nest$sfgetactiveLegendMode()I

    move-result v0

    const/4 v1, 0x1

    if-ne v0, v1, :cond_1

    invoke-static {}, Llocal/mio/os4camerabridge/HookEntry;->-$$Nest$sfgetlegendRawReader()Landroid/media/ImageReader;

    move-result-object v0

    if-eqz v0, :cond_1

    iget-object v0, p1, Lde/robv/android/xposed/XC_MethodHook$MethodHookParam;->args:[Ljava/lang/Object;

    if-eqz v0, :cond_1

    iget-object v0, p1, Lde/robv/android/xposed/XC_MethodHook$MethodHookParam;->args:[Ljava/lang/Object;

    array-length v0, v0

    const/4 v2, 0x2

    if-ne v0, v2, :cond_1

    iget-object v0, p1, Lde/robv/android/xposed/XC_MethodHook$MethodHookParam;->args:[Ljava/lang/Object;

    const/4 v2, 0x0

    aget-object v0, v0, v2

    .line 6636
    invoke-static {v0}, Ljava/lang/String;->valueOf(Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v0

    const-string v2, "SHOT"

    invoke-virtual {v2, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_1

    .line 6637
    invoke-virtual {p1}, Lde/robv/android/xposed/XC_MethodHook$MethodHookParam;->getResult()Ljava/lang/Object;

    move-result-object v0

    instance-of v0, v0, Landroid/hardware/camera2/CaptureRequest$Builder;

    if-nez v0, :cond_0

    goto :goto_1

    .line 6642
    :cond_0
    nop

    .line 6643
    :try_start_0
    invoke-virtual {p1}, Lde/robv/android/xposed/XC_MethodHook$MethodHookParam;->getResult()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Landroid/hardware/camera2/CaptureRequest$Builder;

    .line 6644
    .local v0, "builder":Landroid/hardware/camera2/CaptureRequest$Builder;
    invoke-static {}, Llocal/mio/os4camerabridge/HookEntry;->-$$Nest$sfgetlegendRawReader()Landroid/media/ImageReader;

    move-result-object v2

    invoke-virtual {v2}, Landroid/media/ImageReader;->getSurface()Landroid/view/Surface;

    move-result-object v2

    invoke-virtual {v0, v2}, Landroid/hardware/camera2/CaptureRequest$Builder;->addTarget(Landroid/view/Surface;)V

    .line 6645
    sget-object v2, Landroid/hardware/camera2/CaptureRequest;->STATISTICS_LENS_SHADING_MAP_MODE:Landroid/hardware/camera2/CaptureRequest$Key;

    .line 6646
    invoke-static {v1}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v1

    .line 6645
    invoke-virtual {v0, v2, v1}, Landroid/hardware/camera2/CaptureRequest$Builder;->set(Landroid/hardware/camera2/CaptureRequest$Key;Ljava/lang/Object;)V

    .line 6648
    const-string v1, "[LegendM9] RAW_SENSOR+LSC attached to SHOT request"

    invoke-static {v1}, Llocal/mio/os4camerabridge/HookEntry;->-$$Nest$smlog(Ljava/lang/String;)V
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 6652
    .end local v0    # "builder":Landroid/hardware/camera2/CaptureRequest$Builder;
    goto :goto_0

    .line 6649
    :catchall_0
    move-exception v0

    .line 6650
    .local v0, "throwable":Ljava/lang/Throwable;
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "[LegendM9] SHOT RAW target rejected; stock JPEG path: "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-static {v1}, Llocal/mio/os4camerabridge/HookEntry;->-$$Nest$smlog(Ljava/lang/String;)V

    .line 6653
    .end local v0    # "throwable":Ljava/lang/Throwable;
    :goto_0
    return-void

    .line 6639
    :cond_1
    :goto_1
    return-void
.end method
