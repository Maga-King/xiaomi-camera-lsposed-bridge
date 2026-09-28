.class final Llocal/mio/os4camerabridge/JpegWatermarkMetadataBridge$Pending;
.super Ljava/lang/Object;
.source "JpegWatermarkMetadataBridge.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Llocal/mio/os4camerabridge/JpegWatermarkMetadataBridge;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x1a
    name = "Pending"
.end annotation


# instance fields
.field final module:I

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
.method constructor <init>(JLjava/util/Map;I)V
    .locals 0
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(J",
            "Ljava/util/Map<",
            "Ljava/lang/String;",
            "Ljava/lang/String;",
            ">;I)V"
        }
    .end annotation

    .line 191
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 192
    iput-wide p1, p0, Llocal/mio/os4camerabridge/JpegWatermarkMetadataBridge$Pending;->timestamp:J

    .line 193
    iput-object p3, p0, Llocal/mio/os4camerabridge/JpegWatermarkMetadataBridge$Pending;->values:Ljava/util/Map;

    .line 194
    iput p4, p0, Llocal/mio/os4camerabridge/JpegWatermarkMetadataBridge$Pending;->module:I

    .line 195
    return-void
.end method
