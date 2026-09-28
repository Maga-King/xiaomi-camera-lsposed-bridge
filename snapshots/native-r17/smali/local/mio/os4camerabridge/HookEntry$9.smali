.class Llocal/mio/os4camerabridge/HookEntry$9;
.super Landroid/hardware/camera2/CameraCaptureSession$StateCallback;
.source "HookEntry.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Llocal/mio/os4camerabridge/HookEntry;->startFullOplusSessionHandoffProbe(Ljava/lang/Object;[Ljava/lang/Object;Landroid/os/Handler;ZLandroid/hardware/camera2/CaptureRequest;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic val$captureProof:Z

.field final synthetic val$generation:I

.field final synthetic val$handler:Landroid/os/Handler;

.field final synthetic val$sessionParams:Landroid/hardware/camera2/CaptureRequest;

.field final synthetic val$stillSeed:Landroid/hardware/camera2/CaptureRequest;


# direct methods
.method constructor <init>(IZLandroid/hardware/camera2/CaptureRequest;Landroid/hardware/camera2/CaptureRequest;Landroid/os/Handler;)V
    .locals 0

    .line 1743
    iput p1, p0, Llocal/mio/os4camerabridge/HookEntry$9;->val$generation:I

    iput-boolean p2, p0, Llocal/mio/os4camerabridge/HookEntry$9;->val$captureProof:Z

    iput-object p3, p0, Llocal/mio/os4camerabridge/HookEntry$9;->val$sessionParams:Landroid/hardware/camera2/CaptureRequest;

    iput-object p4, p0, Llocal/mio/os4camerabridge/HookEntry$9;->val$stillSeed:Landroid/hardware/camera2/CaptureRequest;

    iput-object p5, p0, Llocal/mio/os4camerabridge/HookEntry$9;->val$handler:Landroid/os/Handler;

    invoke-direct {p0}, Landroid/hardware/camera2/CameraCaptureSession$StateCallback;-><init>()V

    return-void
.end method

.method static synthetic lambda$onConfigured$0(I)V
    .locals 1
    .param p0, "generation"    # I

    .line 1765
    const-string v0, "configure-proof-complete"

    invoke-static {p0, v0}, Llocal/mio/os4camerabridge/HookEntry;->-$$Nest$smrestoreXiaomiSessionAfterHandoff(ILjava/lang/String;)V

    return-void
.end method


# virtual methods
.method public onClosed(Landroid/hardware/camera2/CameraCaptureSession;)V
    .locals 1
    .param p1, "session"    # Landroid/hardware/camera2/CameraCaptureSession;

    .line 1785
    const-string v0, "[HandoffProbe] transient session closed"

    invoke-static {v0}, Llocal/mio/os4camerabridge/HookEntry;->-$$Nest$smlog(Ljava/lang/String;)V

    .line 1786
    return-void
.end method

.method public onConfigureFailed(Landroid/hardware/camera2/CameraCaptureSession;)V
    .locals 2
    .param p1, "session"    # Landroid/hardware/camera2/CameraCaptureSession;

    .line 1775
    invoke-static {p1}, Llocal/mio/os4camerabridge/HookEntry;->-$$Nest$sfputcommonApsHandoffSession(Landroid/hardware/camera2/CameraCaptureSession;)V

    .line 1776
    const-string v0, "[HandoffProbe] third-party graph onConfigureFailed"

    invoke-static {v0}, Llocal/mio/os4camerabridge/HookEntry;->-$$Nest$smlog(Ljava/lang/String;)V

    .line 1778
    iget v0, p0, Llocal/mio/os4camerabridge/HookEntry$9;->val$generation:I

    const-string v1, "configure-failed"

    invoke-static {v0, v1}, Llocal/mio/os4camerabridge/HookEntry;->-$$Nest$smrestoreXiaomiSessionAfterHandoff(ILjava/lang/String;)V

    .line 1780
    return-void
.end method

.method public onConfigured(Landroid/hardware/camera2/CameraCaptureSession;)V
    .locals 5
    .param p1, "session"    # Landroid/hardware/camera2/CameraCaptureSession;

    .line 1747
    iget v0, p0, Llocal/mio/os4camerabridge/HookEntry$9;->val$generation:I

    invoke-static {}, Llocal/mio/os4camerabridge/HookEntry;->-$$Nest$sfgetcommonApsHandoffGeneration()I

    move-result v1

    if-ne v0, v1, :cond_3

    invoke-static {}, Llocal/mio/os4camerabridge/HookEntry;->-$$Nest$sfgetCOMMON_APS_HANDOFF_IN_FLIGHT()Ljava/util/concurrent/atomic/AtomicBoolean;

    move-result-object v0

    .line 1749
    invoke-virtual {v0}, Ljava/util/concurrent/atomic/AtomicBoolean;->get()Z

    move-result v0

    if-nez v0, :cond_0

    goto :goto_2

    .line 1753
    :cond_0
    invoke-static {p1}, Llocal/mio/os4camerabridge/HookEntry;->-$$Nest$sfputcommonApsHandoffSession(Landroid/hardware/camera2/CameraCaptureSession;)V

    .line 1754
    const-string v0, "[HandoffProbe] SUCCESS third-party 0x8001 seven-output session configured"

    invoke-static {v0}, Llocal/mio/os4camerabridge/HookEntry;->-$$Nest$smlog(Ljava/lang/String;)V

    .line 1756
    iget-boolean v0, p0, Llocal/mio/os4camerabridge/HookEntry$9;->val$captureProof:Z

    if-eqz v0, :cond_2

    .line 1757
    iget-object v0, p0, Llocal/mio/os4camerabridge/HookEntry$9;->val$sessionParams:Landroid/hardware/camera2/CaptureRequest;

    .line 1759
    iget-object v1, p0, Llocal/mio/os4camerabridge/HookEntry$9;->val$stillSeed:Landroid/hardware/camera2/CaptureRequest;

    if-nez v1, :cond_1

    .line 1760
    iget-object v1, p0, Llocal/mio/os4camerabridge/HookEntry$9;->val$sessionParams:Landroid/hardware/camera2/CaptureRequest;

    goto :goto_0

    :cond_1
    iget-object v1, p0, Llocal/mio/os4camerabridge/HookEntry$9;->val$stillSeed:Landroid/hardware/camera2/CaptureRequest;

    :goto_0
    iget-object v2, p0, Llocal/mio/os4camerabridge/HookEntry$9;->val$handler:Landroid/os/Handler;

    iget v3, p0, Llocal/mio/os4camerabridge/HookEntry$9;->val$generation:I

    .line 1757
    invoke-static {p1, v0, v1, v2, v3}, Llocal/mio/os4camerabridge/HookEntry;->-$$Nest$smstartCommonApsHandoffCapture(Landroid/hardware/camera2/CameraCaptureSession;Landroid/hardware/camera2/CaptureRequest;Landroid/hardware/camera2/CaptureRequest;Landroid/os/Handler;I)V

    goto :goto_1

    .line 1764
    :cond_2
    iget-object v0, p0, Llocal/mio/os4camerabridge/HookEntry$9;->val$handler:Landroid/os/Handler;

    iget v1, p0, Llocal/mio/os4camerabridge/HookEntry$9;->val$generation:I

    new-instance v2, Llocal/mio/os4camerabridge/HookEntry$9$$ExternalSyntheticLambda0;

    invoke-direct {v2, v1}, Llocal/mio/os4camerabridge/HookEntry$9$$ExternalSyntheticLambda0;-><init>(I)V

    const-wide/16 v3, 0x15e

    invoke-virtual {v0, v2, v3, v4}, Landroid/os/Handler;->postDelayed(Ljava/lang/Runnable;J)Z

    .line 1770
    :goto_1
    return-void

    .line 1750
    :cond_3
    :goto_2
    invoke-virtual {p1}, Landroid/hardware/camera2/CameraCaptureSession;->close()V

    .line 1751
    return-void
.end method
