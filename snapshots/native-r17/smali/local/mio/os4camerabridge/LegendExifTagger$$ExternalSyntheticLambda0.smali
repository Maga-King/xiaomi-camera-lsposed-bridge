.class public final synthetic Llocal/mio/os4camerabridge/LegendExifTagger$$ExternalSyntheticLambda0;
.super Ljava/lang/Object;
.source "D8$$SyntheticClass"

# interfaces
.implements Ljava/util/function/ToIntFunction;


# annotations
.annotation runtime Lcom/android/tools/r8/annotations/LambdaMethod;
    holder = "Llocal/mio/os4camerabridge/LegendExifTagger;"
    method = "lambda$injectIntoExisting$0"
    proto = "(Z[B)I"
.end annotation

.annotation build Lcom/android/tools/r8/annotations/SynthesizedClassV2;
    apiLevel = -0x2
    kind = 0x13
    versionHash = "9aaf5f34c4c84da429ef7f8f6217a1817876f2618cfcf539aba3d7d5a0c703e0"
.end annotation


# instance fields
.field public final synthetic f$0:Z


# direct methods
.method public synthetic constructor <init>(Z)V
    .locals 0

    .line 0
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    iput-boolean p1, p0, Llocal/mio/os4camerabridge/LegendExifTagger$$ExternalSyntheticLambda0;->f$0:Z

    return-void
.end method


# virtual methods
.method public final applyAsInt(Ljava/lang/Object;)I
    .locals 1

    .line 0
    iget-boolean v0, p0, Llocal/mio/os4camerabridge/LegendExifTagger$$ExternalSyntheticLambda0;->f$0:Z

    check-cast p1, [B

    invoke-static {v0, p1}, Llocal/mio/os4camerabridge/LegendExifTagger;->lambda$injectIntoExisting$0(Z[B)I

    move-result p1

    return p1
.end method
