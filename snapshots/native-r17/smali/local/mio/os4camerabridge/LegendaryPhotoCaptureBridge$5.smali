.class Llocal/mio/os4camerabridge/LegendaryPhotoCaptureBridge$5;
.super Lde/robv/android/xposed/XC_MethodHook;
.source "LegendaryPhotoCaptureBridge.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Llocal/mio/os4camerabridge/LegendaryPhotoCaptureBridge;->install(Ljava/lang/ClassLoader;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# direct methods
.method constructor <init>()V
    .locals 0

    .line 78
    invoke-direct {p0}, Lde/robv/android/xposed/XC_MethodHook;-><init>()V

    return-void
.end method


# virtual methods
.method protected beforeHookedMethod(Lde/robv/android/xposed/XC_MethodHook$MethodHookParam;)V
    .locals 2

    .line 80
    invoke-static {}, Llocal/mio/os4camerabridge/LegendaryPhotoCaptureBridge;->-$$Nest$smactive()Z

    move-result p1

    if-nez p1, :cond_0

    return-void

    .line 81
    :cond_0
    :try_start_0
    invoke-static {}, Llocal/mio/os4camerabridge/LegendaryPhotoCaptureBridge;->-$$Nest$smretain()V
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    goto :goto_0

    :catchall_0
    move-exception p1

    invoke-static {p1}, Ljava/lang/String;->valueOf(Ljava/lang/Object;)Ljava/lang/String;

    move-result-object p1

    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "reference rejected; APS JPEG continues "

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p1

    invoke-virtual {p1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p1

    invoke-static {p1}, Llocal/mio/os4camerabridge/LegendaryPhotoCaptureBridge;->-$$Nest$smlog(Ljava/lang/String;)V

    .line 82
    :goto_0
    return-void
.end method
