.class final Llocal/mio/os4camerabridge/HookEntry$LegendRawFrame;
.super Ljava/lang/Object;
.source "HookEntry.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Llocal/mio/os4camerabridge/HookEntry;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x1a
    name = "LegendRawFrame"
.end annotation


# instance fields
.field final raw10:[B

.field final rowStride:I

.field final timestamp:J


# direct methods
.method constructor <init>(J[BI)V
    .locals 0
    .param p1, "timestamp"    # J
    .param p3, "raw10"    # [B
    .param p4, "rowStride"    # I

    .line 745
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 746
    iput-wide p1, p0, Llocal/mio/os4camerabridge/HookEntry$LegendRawFrame;->timestamp:J

    .line 747
    iput-object p3, p0, Llocal/mio/os4camerabridge/HookEntry$LegendRawFrame;->raw10:[B

    .line 748
    iput p4, p0, Llocal/mio/os4camerabridge/HookEntry$LegendRawFrame;->rowStride:I

    .line 749
    return-void
.end method
