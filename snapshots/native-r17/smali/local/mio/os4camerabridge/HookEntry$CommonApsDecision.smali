.class final Llocal/mio/os4camerabridge/HookEntry$CommonApsDecision;
.super Ljava/lang/Object;
.source "HookEntry.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Llocal/mio/os4camerabridge/HookEntry;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x1a
    name = "CommonApsDecision"
.end annotation


# instance fields
.field final aisState:I

.field final bracketMode:I

.field final evList:[I

.field final featureType:I

.field final frameCount:I

.field final source:Ljava/lang/String;

.field final superNightScene:I

.field final teleSingleRaw:Z

.field final turboRawScene:I


# direct methods
.method constructor <init>(IIIIII[ILjava/lang/String;)V
    .locals 10
    .param p1, "frameCount"    # I
    .param p2, "bracketMode"    # I
    .param p3, "superNightScene"    # I
    .param p4, "turboRawScene"    # I
    .param p5, "featureType"    # I
    .param p6, "aisState"    # I
    .param p7, "evList"    # [I
    .param p8, "source"    # Ljava/lang/String;

    .line 766
    const/4 v9, 0x0

    move-object v0, p0

    move v1, p1

    move v2, p2

    move v3, p3

    move v4, p4

    move v5, p5

    move/from16 v6, p6

    move-object/from16 v7, p7

    move-object/from16 v8, p8

    invoke-direct/range {v0 .. v9}, Llocal/mio/os4camerabridge/HookEntry$CommonApsDecision;-><init>(IIIIII[ILjava/lang/String;Z)V

    .line 768
    return-void
.end method

.method constructor <init>(IIIIII[ILjava/lang/String;Z)V
    .locals 1
    .param p1, "frameCount"    # I
    .param p2, "bracketMode"    # I
    .param p3, "superNightScene"    # I
    .param p4, "turboRawScene"    # I
    .param p5, "featureType"    # I
    .param p6, "aisState"    # I
    .param p7, "evList"    # [I
    .param p8, "source"    # Ljava/lang/String;
    .param p9, "teleSingleRaw"    # Z

    .line 773
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 774
    iput p1, p0, Llocal/mio/os4camerabridge/HookEntry$CommonApsDecision;->frameCount:I

    .line 775
    iput p2, p0, Llocal/mio/os4camerabridge/HookEntry$CommonApsDecision;->bracketMode:I

    .line 776
    iput p3, p0, Llocal/mio/os4camerabridge/HookEntry$CommonApsDecision;->superNightScene:I

    .line 777
    iput p4, p0, Llocal/mio/os4camerabridge/HookEntry$CommonApsDecision;->turboRawScene:I

    .line 778
    iput p5, p0, Llocal/mio/os4camerabridge/HookEntry$CommonApsDecision;->featureType:I

    .line 779
    iput p6, p0, Llocal/mio/os4camerabridge/HookEntry$CommonApsDecision;->aisState:I

    .line 780
    const/16 v0, 0x14

    if-nez p7, :cond_0

    new-array v0, v0, [I

    goto :goto_0

    .line 781
    :cond_0
    invoke-static {p7, v0}, Ljava/util/Arrays;->copyOf([II)[I

    move-result-object v0

    :goto_0
    iput-object v0, p0, Llocal/mio/os4camerabridge/HookEntry$CommonApsDecision;->evList:[I

    .line 782
    iput-object p8, p0, Llocal/mio/os4camerabridge/HookEntry$CommonApsDecision;->source:Ljava/lang/String;

    .line 783
    iput-boolean p9, p0, Llocal/mio/os4camerabridge/HookEntry$CommonApsDecision;->teleSingleRaw:Z

    .line 784
    return-void
.end method


# virtual methods
.method evListString()Ljava/lang/String;
    .locals 1

    .line 834
    iget-object v0, p0, Llocal/mio/os4camerabridge/HookEntry$CommonApsDecision;->evList:[I

    invoke-static {v0}, Ljava/util/Arrays;->toString([I)Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method

.method isPortraitDualRaw()Z
    .locals 2

    .line 820
    iget v0, p0, Llocal/mio/os4camerabridge/HookEntry$CommonApsDecision;->frameCount:I

    const/4 v1, 0x7

    if-ne v0, v1, :cond_0

    iget v0, p0, Llocal/mio/os4camerabridge/HookEntry$CommonApsDecision;->bracketMode:I

    const/16 v1, 0x19

    if-ne v0, v1, :cond_0

    iget v0, p0, Llocal/mio/os4camerabridge/HookEntry$CommonApsDecision;->superNightScene:I

    const/4 v1, 0x4

    if-ne v0, v1, :cond_0

    iget v0, p0, Llocal/mio/os4camerabridge/HookEntry$CommonApsDecision;->turboRawScene:I

    if-ne v0, v1, :cond_0

    iget v0, p0, Llocal/mio/os4camerabridge/HookEntry$CommonApsDecision;->featureType:I

    const/16 v1, 0x30

    if-ne v0, v1, :cond_0

    iget v0, p0, Llocal/mio/os4camerabridge/HookEntry$CommonApsDecision;->aisState:I

    if-nez v0, :cond_0

    const/4 v0, 0x1

    goto :goto_0

    :cond_0
    const/4 v0, 0x0

    :goto_0
    return v0
.end method

.method isSingleRaw()Z
    .locals 1

    .line 816
    invoke-virtual {p0}, Llocal/mio/os4camerabridge/HookEntry$CommonApsDecision;->isUltraWideSingleRaw()Z

    move-result v0

    if-nez v0, :cond_1

    invoke-virtual {p0}, Llocal/mio/os4camerabridge/HookEntry$CommonApsDecision;->isTeleSingleRaw()Z

    move-result v0

    if-eqz v0, :cond_0

    goto :goto_0

    :cond_0
    const/4 v0, 0x0

    goto :goto_1

    :cond_1
    :goto_0
    const/4 v0, 0x1

    :goto_1
    return v0
.end method

.method isSupportedCommon2Dol()Z
    .locals 3

    .line 787
    iget v0, p0, Llocal/mio/os4camerabridge/HookEntry$CommonApsDecision;->frameCount:I

    const/4 v1, 0x4

    if-eq v0, v1, :cond_0

    iget v0, p0, Llocal/mio/os4camerabridge/HookEntry$CommonApsDecision;->frameCount:I

    const/4 v2, 0x5

    if-ne v0, v2, :cond_4

    :cond_0
    iget v0, p0, Llocal/mio/os4camerabridge/HookEntry$CommonApsDecision;->bracketMode:I

    if-eqz v0, :cond_1

    iget v0, p0, Llocal/mio/os4camerabridge/HookEntry$CommonApsDecision;->bracketMode:I

    const/16 v2, 0x19

    if-ne v0, v2, :cond_4

    :cond_1
    iget v0, p0, Llocal/mio/os4camerabridge/HookEntry$CommonApsDecision;->superNightScene:I

    const/4 v2, 0x1

    if-eq v0, v2, :cond_2

    iget v0, p0, Llocal/mio/os4camerabridge/HookEntry$CommonApsDecision;->superNightScene:I

    if-ne v0, v1, :cond_4

    :cond_2
    iget v0, p0, Llocal/mio/os4camerabridge/HookEntry$CommonApsDecision;->turboRawScene:I

    if-eq v0, v2, :cond_3

    iget v0, p0, Llocal/mio/os4camerabridge/HookEntry$CommonApsDecision;->turboRawScene:I

    if-ne v0, v1, :cond_4

    :cond_3
    iget v0, p0, Llocal/mio/os4camerabridge/HookEntry$CommonApsDecision;->featureType:I

    const/16 v1, 0x32

    if-ne v0, v1, :cond_4

    goto :goto_0

    :cond_4
    const/4 v2, 0x0

    :goto_0
    return v2
.end method

.method isSupportedCommonCapture()Z
    .locals 1

    .line 829
    invoke-virtual {p0}, Llocal/mio/os4camerabridge/HookEntry$CommonApsDecision;->isSupportedCommon2Dol()Z

    move-result v0

    if-nez v0, :cond_1

    invoke-virtual {p0}, Llocal/mio/os4camerabridge/HookEntry$CommonApsDecision;->isSingleRaw()Z

    move-result v0

    if-nez v0, :cond_1

    .line 830
    invoke-virtual {p0}, Llocal/mio/os4camerabridge/HookEntry$CommonApsDecision;->isPortraitDualRaw()Z

    move-result v0

    if-eqz v0, :cond_0

    goto :goto_0

    :cond_0
    const/4 v0, 0x0

    goto :goto_1

    :cond_1
    :goto_0
    const/4 v0, 0x1

    .line 829
    :goto_1
    return v0
.end method

.method isTeleSingleRaw()Z
    .locals 2

    .line 806
    iget-boolean v0, p0, Llocal/mio/os4camerabridge/HookEntry$CommonApsDecision;->teleSingleRaw:Z

    if-eqz v0, :cond_0

    iget v0, p0, Llocal/mio/os4camerabridge/HookEntry$CommonApsDecision;->frameCount:I

    const/16 v1, 0x8

    if-ne v0, v1, :cond_0

    iget v0, p0, Llocal/mio/os4camerabridge/HookEntry$CommonApsDecision;->bracketMode:I

    const/16 v1, 0x1c

    if-ne v0, v1, :cond_0

    iget v0, p0, Llocal/mio/os4camerabridge/HookEntry$CommonApsDecision;->superNightScene:I

    const/4 v1, 0x3

    if-ne v0, v1, :cond_0

    iget v0, p0, Llocal/mio/os4camerabridge/HookEntry$CommonApsDecision;->turboRawScene:I

    if-ne v0, v1, :cond_0

    iget v0, p0, Llocal/mio/os4camerabridge/HookEntry$CommonApsDecision;->featureType:I

    const/16 v1, 0x30

    if-ne v0, v1, :cond_0

    iget v0, p0, Llocal/mio/os4camerabridge/HookEntry$CommonApsDecision;->aisState:I

    if-nez v0, :cond_0

    const/4 v0, 0x1

    goto :goto_0

    :cond_0
    const/4 v0, 0x0

    :goto_0
    return v0
.end method

.method isUltraWideSingleRaw()Z
    .locals 2

    .line 796
    iget-boolean v0, p0, Llocal/mio/os4camerabridge/HookEntry$CommonApsDecision;->teleSingleRaw:Z

    if-nez v0, :cond_0

    iget v0, p0, Llocal/mio/os4camerabridge/HookEntry$CommonApsDecision;->frameCount:I

    const/16 v1, 0x8

    if-ne v0, v1, :cond_0

    iget v0, p0, Llocal/mio/os4camerabridge/HookEntry$CommonApsDecision;->bracketMode:I

    const/16 v1, 0x1c

    if-ne v0, v1, :cond_0

    iget v0, p0, Llocal/mio/os4camerabridge/HookEntry$CommonApsDecision;->superNightScene:I

    const/4 v1, 0x3

    if-ne v0, v1, :cond_0

    iget v0, p0, Llocal/mio/os4camerabridge/HookEntry$CommonApsDecision;->turboRawScene:I

    if-ne v0, v1, :cond_0

    iget v0, p0, Llocal/mio/os4camerabridge/HookEntry$CommonApsDecision;->featureType:I

    const/16 v1, 0x30

    if-ne v0, v1, :cond_0

    iget v0, p0, Llocal/mio/os4camerabridge/HookEntry$CommonApsDecision;->aisState:I

    if-nez v0, :cond_0

    const/4 v0, 0x1

    goto :goto_0

    :cond_0
    const/4 v0, 0x0

    :goto_0
    return v0
.end method
