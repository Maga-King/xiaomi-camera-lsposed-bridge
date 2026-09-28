.class final Llocal/mio/os4camerabridge/LegendM9Container$Segment;
.super Ljava/lang/Object;
.source "LegendM9Container.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Llocal/mio/os4camerabridge/LegendM9Container;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x1a
    name = "Segment"
.end annotation


# instance fields
.field final bodyLength:I

.field final bodyOffset:I

.field final markerOffset:I

.field final totalLength:I


# direct methods
.method constructor <init>(IIII)V
    .locals 0
    .param p1, "markerOffset"    # I
    .param p2, "totalLength"    # I
    .param p3, "bodyOffset"    # I
    .param p4, "bodyLength"    # I

    .line 837
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 838
    iput p1, p0, Llocal/mio/os4camerabridge/LegendM9Container$Segment;->markerOffset:I

    .line 839
    iput p2, p0, Llocal/mio/os4camerabridge/LegendM9Container$Segment;->totalLength:I

    .line 840
    iput p3, p0, Llocal/mio/os4camerabridge/LegendM9Container$Segment;->bodyOffset:I

    .line 841
    iput p4, p0, Llocal/mio/os4camerabridge/LegendM9Container$Segment;->bodyLength:I

    .line 842
    return-void
.end method
