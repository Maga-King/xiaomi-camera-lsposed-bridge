.class final Llocal/mio/os4camerabridge/JpegQualityBoundaryProbe$Sample;
.super Ljava/lang/Object;
.source "JpegQualityBoundaryProbe.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Llocal/mio/os4camerabridge/JpegQualityBoundaryProbe;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x1a
    name = "Sample"
.end annotation


# instance fields
.field final before:[B

.field final details:Ljava/lang/String;

.field final id:Ljava/lang/String;


# direct methods
.method constructor <init>(Ljava/lang/String;[BLjava/lang/String;)V
    .locals 0

    .line 145
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 146
    iput-object p1, p0, Llocal/mio/os4camerabridge/JpegQualityBoundaryProbe$Sample;->id:Ljava/lang/String;

    .line 147
    iput-object p2, p0, Llocal/mio/os4camerabridge/JpegQualityBoundaryProbe$Sample;->before:[B

    .line 148
    iput-object p3, p0, Llocal/mio/os4camerabridge/JpegQualityBoundaryProbe$Sample;->details:Ljava/lang/String;

    .line 149
    return-void
.end method
