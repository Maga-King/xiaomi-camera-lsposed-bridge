.class public final synthetic Llocal/mio/os4camerabridge/HookEntry$10$$ExternalSyntheticLambda0;
.super Ljava/lang/Object;
.source "D8$$SyntheticClass"

# interfaces
.implements Ljava/lang/Runnable;


# annotations
.annotation runtime Lcom/android/tools/r8/annotations/LambdaMethod;
    holder = "Llocal/mio/os4camerabridge/HookEntry$10;"
    method = "lambda$onCaptureCompleted$0"
    proto = "(ILandroid/hardware/camera2/CameraCaptureSession;Landroid/hardware/camera2/CaptureRequest;Landroid/os/Handler;)V"
.end annotation

.annotation build Lcom/android/tools/r8/annotations/SynthesizedClassV2;
    apiLevel = -0x2
    kind = 0x13
    versionHash = "9aaf5f34c4c84da429ef7f8f6217a1817876f2618cfcf539aba3d7d5a0c703e0"
.end annotation


# instance fields
.field public final synthetic f$0:I

.field public final synthetic f$1:Landroid/hardware/camera2/CameraCaptureSession;

.field public final synthetic f$2:Landroid/hardware/camera2/CaptureRequest;

.field public final synthetic f$3:Landroid/os/Handler;


# direct methods
.method public synthetic constructor <init>(ILandroid/hardware/camera2/CameraCaptureSession;Landroid/hardware/camera2/CaptureRequest;Landroid/os/Handler;)V
    .locals 0

    .line 0
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    iput p1, p0, Llocal/mio/os4camerabridge/HookEntry$10$$ExternalSyntheticLambda0;->f$0:I

    iput-object p2, p0, Llocal/mio/os4camerabridge/HookEntry$10$$ExternalSyntheticLambda0;->f$1:Landroid/hardware/camera2/CameraCaptureSession;

    iput-object p3, p0, Llocal/mio/os4camerabridge/HookEntry$10$$ExternalSyntheticLambda0;->f$2:Landroid/hardware/camera2/CaptureRequest;

    iput-object p4, p0, Llocal/mio/os4camerabridge/HookEntry$10$$ExternalSyntheticLambda0;->f$3:Landroid/os/Handler;

    return-void
.end method


# virtual methods
.method public final run()V
    .locals 4

    .line 0
    iget v0, p0, Llocal/mio/os4camerabridge/HookEntry$10$$ExternalSyntheticLambda0;->f$0:I

    iget-object v1, p0, Llocal/mio/os4camerabridge/HookEntry$10$$ExternalSyntheticLambda0;->f$1:Landroid/hardware/camera2/CameraCaptureSession;

    iget-object v2, p0, Llocal/mio/os4camerabridge/HookEntry$10$$ExternalSyntheticLambda0;->f$2:Landroid/hardware/camera2/CaptureRequest;

    iget-object v3, p0, Llocal/mio/os4camerabridge/HookEntry$10$$ExternalSyntheticLambda0;->f$3:Landroid/os/Handler;

    invoke-static {v0, v1, v2, v3}, Llocal/mio/os4camerabridge/HookEntry$10;->lambda$onCaptureCompleted$0(ILandroid/hardware/camera2/CameraCaptureSession;Landroid/hardware/camera2/CaptureRequest;Landroid/os/Handler;)V

    return-void
.end method
