.class final Llocal/mio/os4camerabridge/LegendaryContainerIntegrity$Edit;
.super Ljava/lang/Object;
.source "LegendaryContainerIntegrity.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Llocal/mio/os4camerabridge/LegendaryContainerIntegrity;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x1a
    name = "Edit"
.end annotation


# instance fields
.field final bytes:[B

.field final end:I

.field final start:I


# direct methods
.method constructor <init>(II[B)V
    .locals 0

    .line 72
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    iput p1, p0, Llocal/mio/os4camerabridge/LegendaryContainerIntegrity$Edit;->start:I

    iput p2, p0, Llocal/mio/os4camerabridge/LegendaryContainerIntegrity$Edit;->end:I

    iput-object p3, p0, Llocal/mio/os4camerabridge/LegendaryContainerIntegrity$Edit;->bytes:[B

    return-void
.end method
