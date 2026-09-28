.class public final synthetic Llocal/mio/os4camerabridge/JpegQualityBoundaryProbe$$ExternalSyntheticLambda0;
.super Ljava/lang/Object;
.source "D8$$SyntheticClass"

# interfaces
.implements Ljava/lang/Runnable;


# instance fields
.field public final synthetic f$0:Llocal/mio/os4camerabridge/JpegQualityBoundaryProbe$Sample;

.field public final synthetic f$1:[B

.field public final synthetic f$2:Ljava/lang/String;


# direct methods
.method public synthetic constructor <init>(Llocal/mio/os4camerabridge/JpegQualityBoundaryProbe$Sample;[BLjava/lang/String;)V
    .locals 0

    .line 0
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    iput-object p1, p0, Llocal/mio/os4camerabridge/JpegQualityBoundaryProbe$$ExternalSyntheticLambda0;->f$0:Llocal/mio/os4camerabridge/JpegQualityBoundaryProbe$Sample;

    iput-object p2, p0, Llocal/mio/os4camerabridge/JpegQualityBoundaryProbe$$ExternalSyntheticLambda0;->f$1:[B

    iput-object p3, p0, Llocal/mio/os4camerabridge/JpegQualityBoundaryProbe$$ExternalSyntheticLambda0;->f$2:Ljava/lang/String;

    return-void
.end method


# virtual methods
.method public final run()V
    .locals 3

    .line 0
    iget-object v0, p0, Llocal/mio/os4camerabridge/JpegQualityBoundaryProbe$$ExternalSyntheticLambda0;->f$0:Llocal/mio/os4camerabridge/JpegQualityBoundaryProbe$Sample;

    iget-object v1, p0, Llocal/mio/os4camerabridge/JpegQualityBoundaryProbe$$ExternalSyntheticLambda0;->f$1:[B

    iget-object v2, p0, Llocal/mio/os4camerabridge/JpegQualityBoundaryProbe$$ExternalSyntheticLambda0;->f$2:Ljava/lang/String;

    invoke-static {v0, v1, v2}, Llocal/mio/os4camerabridge/JpegQualityBoundaryProbe;->lambda$submit$1(Llocal/mio/os4camerabridge/JpegQualityBoundaryProbe$Sample;[BLjava/lang/String;)V

    return-void
.end method
