.class final Llocal/mio/os4camerabridge/HookEntry$CommonApsFrame;
.super Ljava/lang/Object;
.source "HookEntry.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Llocal/mio/os4camerabridge/HookEntry;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x1a
    name = "CommonApsFrame"
.end annotation


# instance fields
.field captureMeta:Landroid/media/Image;

.field dol:Landroid/media/Image;

.field index:I

.field main:Landroid/media/Image;

.field result:Landroid/hardware/camera2/TotalCaptureResult;

.field final timestamp:J


# direct methods
.method constructor <init>(J)V
    .locals 0
    .param p1, "timestamp"    # J

    .line 846
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 847
    iput-wide p1, p0, Llocal/mio/os4camerabridge/HookEntry$CommonApsFrame;->timestamp:J

    .line 848
    return-void
.end method


# virtual methods
.method isComplete()Z
    .locals 3

    .line 851
    iget-object v0, p0, Llocal/mio/os4camerabridge/HookEntry$CommonApsFrame;->main:Landroid/media/Image;

    if-eqz v0, :cond_1

    invoke-static {}, Llocal/mio/os4camerabridge/HookEntry;->-$$Nest$sfgetcommonApsUltraWideCapture()Z

    move-result v0

    if-nez v0, :cond_0

    invoke-static {}, Llocal/mio/os4camerabridge/HookEntry;->-$$Nest$sfgetcommonApsTeleCapture()Z

    move-result v0

    if-nez v0, :cond_0

    iget-object v0, p0, Llocal/mio/os4camerabridge/HookEntry$CommonApsFrame;->dol:Landroid/media/Image;

    if-eqz v0, :cond_1

    :cond_0
    iget-object v0, p0, Llocal/mio/os4camerabridge/HookEntry$CommonApsFrame;->captureMeta:Landroid/media/Image;

    if-eqz v0, :cond_1

    iget-object v0, p0, Llocal/mio/os4camerabridge/HookEntry$CommonApsFrame;->result:Landroid/hardware/camera2/TotalCaptureResult;

    if-eqz v0, :cond_1

    iget v0, p0, Llocal/mio/os4camerabridge/HookEntry$CommonApsFrame;->index:I

    const/4 v1, 0x1

    if-lt v0, v1, :cond_1

    iget v0, p0, Llocal/mio/os4camerabridge/HookEntry$CommonApsFrame;->index:I

    invoke-static {}, Llocal/mio/os4camerabridge/HookEntry;->-$$Nest$sfgetcommonApsExpectedFrameCount()I

    move-result v2

    if-gt v0, v2, :cond_1

    goto :goto_0

    :cond_1
    const/4 v1, 0x0

    :goto_0
    return v1
.end method
