.class final Llocal/mio/os4camerabridge/LegendaryContainerIntegrity$Segment;
.super Ljava/lang/Object;
.source "LegendaryContainerIntegrity.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Llocal/mio/os4camerabridge/LegendaryContainerIntegrity;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x1a
    name = "Segment"
.end annotation


# instance fields
.field final end:I

.field final marker:I

.field final start:I


# direct methods
.method constructor <init>(III)V
    .locals 0

    .line 67
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    iput p1, p0, Llocal/mio/os4camerabridge/LegendaryContainerIntegrity$Segment;->marker:I

    iput p2, p0, Llocal/mio/os4camerabridge/LegendaryContainerIntegrity$Segment;->start:I

    iput p3, p0, Llocal/mio/os4camerabridge/LegendaryContainerIntegrity$Segment;->end:I

    return-void
.end method
