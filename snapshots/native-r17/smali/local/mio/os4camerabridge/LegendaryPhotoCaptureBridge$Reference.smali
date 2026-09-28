.class final Llocal/mio/os4camerabridge/LegendaryPhotoCaptureBridge$Reference;
.super Ljava/lang/Object;
.source "LegendaryPhotoCaptureBridge.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Llocal/mio/os4camerabridge/LegendaryPhotoCaptureBridge;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x1a
    name = "Reference"
.end annotation


# instance fields
.field final created:J

.field final lsc:[F

.field final raw:[B

.field final rawOrientation:I

.field final result:Landroid/hardware/camera2/TotalCaptureResult;

.field final timestamp:J


# direct methods
.method constructor <init>(J[BLandroid/hardware/camera2/TotalCaptureResult;[FI)V
    .locals 2

    .line 205
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 200
    invoke-static {}, Landroid/os/SystemClock;->elapsedRealtime()J

    move-result-wide v0

    iput-wide v0, p0, Llocal/mio/os4camerabridge/LegendaryPhotoCaptureBridge$Reference;->created:J

    .line 206
    iput-wide p1, p0, Llocal/mio/os4camerabridge/LegendaryPhotoCaptureBridge$Reference;->timestamp:J

    iput-object p3, p0, Llocal/mio/os4camerabridge/LegendaryPhotoCaptureBridge$Reference;->raw:[B

    iput-object p4, p0, Llocal/mio/os4camerabridge/LegendaryPhotoCaptureBridge$Reference;->result:Landroid/hardware/camera2/TotalCaptureResult;

    iput-object p5, p0, Llocal/mio/os4camerabridge/LegendaryPhotoCaptureBridge$Reference;->lsc:[F

    iput p6, p0, Llocal/mio/os4camerabridge/LegendaryPhotoCaptureBridge$Reference;->rawOrientation:I

    .line 207
    return-void
.end method
