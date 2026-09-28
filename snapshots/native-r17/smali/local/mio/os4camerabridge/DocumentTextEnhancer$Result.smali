.class final Llocal/mio/os4camerabridge/DocumentTextEnhancer$Result;
.super Ljava/lang/Object;
.source "DocumentTextEnhancer.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Llocal/mio/os4camerabridge/DocumentTextEnhancer;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x18
    name = "Result"
.end annotation


# instance fields
.field final changedPixels:I

.field final inferenceMs:J

.field final jpeg:[B

.field final maxAbsDelta:I

.field final meanAbsDelta:D

.field final totalMs:J


# direct methods
.method constructor <init>([BJJDII)V
    .locals 0
    .param p1, "jpeg"    # [B
    .param p2, "inferenceMs"    # J
    .param p4, "totalMs"    # J
    .param p6, "meanAbsDelta"    # D
    .param p8, "maxAbsDelta"    # I
    .param p9, "changedPixels"    # I

    .line 37
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 38
    iput-object p1, p0, Llocal/mio/os4camerabridge/DocumentTextEnhancer$Result;->jpeg:[B

    .line 39
    iput-wide p2, p0, Llocal/mio/os4camerabridge/DocumentTextEnhancer$Result;->inferenceMs:J

    .line 40
    iput-wide p4, p0, Llocal/mio/os4camerabridge/DocumentTextEnhancer$Result;->totalMs:J

    .line 41
    iput-wide p6, p0, Llocal/mio/os4camerabridge/DocumentTextEnhancer$Result;->meanAbsDelta:D

    .line 42
    iput p8, p0, Llocal/mio/os4camerabridge/DocumentTextEnhancer$Result;->maxAbsDelta:I

    .line 43
    iput p9, p0, Llocal/mio/os4camerabridge/DocumentTextEnhancer$Result;->changedPixels:I

    .line 44
    return-void
.end method
