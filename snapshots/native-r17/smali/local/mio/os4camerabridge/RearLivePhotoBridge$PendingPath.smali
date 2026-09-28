.class final Llocal/mio/os4camerabridge/RearLivePhotoBridge$PendingPath;
.super Ljava/lang/Object;
.source "RearLivePhotoBridge.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Llocal/mio/os4camerabridge/RearLivePhotoBridge;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x1a
    name = "PendingPath"
.end annotation


# instance fields
.field final generation:I

.field final nanos:J

.field final path:Ljava/lang/String;

.field final wallMillis:J


# direct methods
.method constructor <init>(Ljava/lang/String;JJI)V
    .locals 0

    .line 204
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 205
    iput-object p1, p0, Llocal/mio/os4camerabridge/RearLivePhotoBridge$PendingPath;->path:Ljava/lang/String;

    iput-wide p2, p0, Llocal/mio/os4camerabridge/RearLivePhotoBridge$PendingPath;->nanos:J

    iput-wide p4, p0, Llocal/mio/os4camerabridge/RearLivePhotoBridge$PendingPath;->wallMillis:J

    iput p6, p0, Llocal/mio/os4camerabridge/RearLivePhotoBridge$PendingPath;->generation:I

    .line 206
    return-void
.end method
