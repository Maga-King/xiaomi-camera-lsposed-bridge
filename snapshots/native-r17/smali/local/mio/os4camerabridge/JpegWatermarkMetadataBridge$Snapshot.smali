.class final Llocal/mio/os4camerabridge/JpegWatermarkMetadataBridge$Snapshot;
.super Ljava/lang/Object;
.source "JpegWatermarkMetadataBridge.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Llocal/mio/os4camerabridge/JpegWatermarkMetadataBridge;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x1a
    name = "Snapshot"
.end annotation


# instance fields
.field final jpeg:[B

.field final module:I

.field final task:Ljava/lang/Object;

.field final timestamp:J

.field final values:Ljava/util/Map;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/Map<",
            "Ljava/lang/String;",
            "Ljava/lang/String;",
            ">;"
        }
    .end annotation
.end field


# direct methods
.method constructor <init>(Ljava/lang/Object;J[BLjava/util/Map;I)V
    .locals 0
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/lang/Object;",
            "J[B",
            "Ljava/util/Map<",
            "Ljava/lang/String;",
            "Ljava/lang/String;",
            ">;I)V"
        }
    .end annotation

    .line 178
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 179
    iput-object p1, p0, Llocal/mio/os4camerabridge/JpegWatermarkMetadataBridge$Snapshot;->task:Ljava/lang/Object;

    .line 180
    iput-wide p2, p0, Llocal/mio/os4camerabridge/JpegWatermarkMetadataBridge$Snapshot;->timestamp:J

    .line 181
    iput-object p4, p0, Llocal/mio/os4camerabridge/JpegWatermarkMetadataBridge$Snapshot;->jpeg:[B

    .line 182
    iput-object p5, p0, Llocal/mio/os4camerabridge/JpegWatermarkMetadataBridge$Snapshot;->values:Ljava/util/Map;

    .line 183
    iput p6, p0, Llocal/mio/os4camerabridge/JpegWatermarkMetadataBridge$Snapshot;->module:I

    .line 184
    return-void
.end method
