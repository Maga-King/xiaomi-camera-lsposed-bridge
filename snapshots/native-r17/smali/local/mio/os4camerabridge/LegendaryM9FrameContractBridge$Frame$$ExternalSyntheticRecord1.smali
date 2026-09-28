.class public final synthetic Llocal/mio/os4camerabridge/LegendaryM9FrameContractBridge$Frame$$ExternalSyntheticRecord1;
.super Ljava/lang/Object;
.source "D8$$SyntheticClass"


# direct methods
.method public static synthetic m(JFFLjava/lang/Object;)I
    .locals 0

    .line 0
    invoke-static {p0, p1}, Ljava/lang/Long;->hashCode(J)I

    move-result p0

    mul-int/lit8 p0, p0, 0x1f

    invoke-static {p2}, Ljava/lang/Float;->hashCode(F)I

    move-result p1

    add-int/2addr p0, p1

    mul-int/lit8 p0, p0, 0x1f

    invoke-static {p3}, Ljava/lang/Float;->hashCode(F)I

    move-result p1

    add-int/2addr p0, p1

    mul-int/lit8 p0, p0, 0x1f

    invoke-static {p4}, Ljava/util/Objects;->hashCode(Ljava/lang/Object;)I

    move-result p1

    add-int/2addr p0, p1

    return p0
.end method
