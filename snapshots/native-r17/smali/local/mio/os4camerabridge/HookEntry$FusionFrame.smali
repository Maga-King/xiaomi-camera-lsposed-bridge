.class final Llocal/mio/os4camerabridge/HookEntry$FusionFrame;
.super Ljava/lang/Object;
.source "HookEntry.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Llocal/mio/os4camerabridge/HookEntry;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x1a
    name = "FusionFrame"
.end annotation


# instance fields
.field final timestamp:J

.field final vu:[B

.field final y:[B


# direct methods
.method constructor <init>(J[B[B)V
    .locals 0
    .param p1, "timestamp"    # J
    .param p3, "y"    # [B
    .param p4, "vu"    # [B

    .line 733
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 734
    iput-wide p1, p0, Llocal/mio/os4camerabridge/HookEntry$FusionFrame;->timestamp:J

    .line 735
    iput-object p3, p0, Llocal/mio/os4camerabridge/HookEntry$FusionFrame;->y:[B

    .line 736
    iput-object p4, p0, Llocal/mio/os4camerabridge/HookEntry$FusionFrame;->vu:[B

    .line 737
    return-void
.end method
