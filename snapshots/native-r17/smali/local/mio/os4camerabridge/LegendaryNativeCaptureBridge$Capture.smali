.class final Llocal/mio/os4camerabridge/LegendaryNativeCaptureBridge$Capture;
.super Ljava/lang/Object;
.source "LegendaryNativeCaptureBridge.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Llocal/mio/os4camerabridge/LegendaryNativeCaptureBridge;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x1a
    name = "Capture"
.end annotation


# instance fields
.field final cct:I

.field final created:J

.field final gamma:Z

.field final lux:I

.field final matrix:Z

.field final mode:I

.field final orientation:I

.field volatile rendered:Z


# direct methods
.method constructor <init>(IIIIZZ)V
    .locals 2

    .line 136
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 134
    invoke-static {}, Landroid/os/SystemClock;->elapsedRealtime()J

    move-result-wide v0

    iput-wide v0, p0, Llocal/mio/os4camerabridge/LegendaryNativeCaptureBridge$Capture;->created:J

    .line 137
    iput p1, p0, Llocal/mio/os4camerabridge/LegendaryNativeCaptureBridge$Capture;->mode:I

    iput p2, p0, Llocal/mio/os4camerabridge/LegendaryNativeCaptureBridge$Capture;->lux:I

    iput p3, p0, Llocal/mio/os4camerabridge/LegendaryNativeCaptureBridge$Capture;->cct:I

    iput p4, p0, Llocal/mio/os4camerabridge/LegendaryNativeCaptureBridge$Capture;->orientation:I

    iput-boolean p5, p0, Llocal/mio/os4camerabridge/LegendaryNativeCaptureBridge$Capture;->gamma:Z

    iput-boolean p6, p0, Llocal/mio/os4camerabridge/LegendaryNativeCaptureBridge$Capture;->matrix:Z

    .line 138
    return-void
.end method
