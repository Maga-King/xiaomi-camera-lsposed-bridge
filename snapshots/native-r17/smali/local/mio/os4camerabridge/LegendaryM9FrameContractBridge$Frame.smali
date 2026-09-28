.class final Llocal/mio/os4camerabridge/LegendaryM9FrameContractBridge$Frame;
.super Lcom/android/tools/r8/RecordTag;
.source "LegendaryM9FrameContractBridge.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Llocal/mio/os4camerabridge/LegendaryM9FrameContractBridge;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x1a
    name = "Frame"
.end annotation


# instance fields
.field private final ccm:[F

.field private final gain:F

.field private final timestamp:J

.field private final zoom:F


# direct methods
.method private synthetic $record$equals(Ljava/lang/Object;)Z
    .locals 4

    instance-of v0, p1, Llocal/mio/os4camerabridge/LegendaryM9FrameContractBridge$Frame;

    if-eqz v0, :cond_0

    check-cast p1, Llocal/mio/os4camerabridge/LegendaryM9FrameContractBridge$Frame;

    iget-wide v0, p0, Llocal/mio/os4camerabridge/LegendaryM9FrameContractBridge$Frame;->timestamp:J

    iget-wide v2, p1, Llocal/mio/os4camerabridge/LegendaryM9FrameContractBridge$Frame;->timestamp:J

    cmp-long v0, v0, v2

    if-nez v0, :cond_0

    iget v0, p0, Llocal/mio/os4camerabridge/LegendaryM9FrameContractBridge$Frame;->zoom:F

    iget v1, p1, Llocal/mio/os4camerabridge/LegendaryM9FrameContractBridge$Frame;->zoom:F

    cmpl-float v0, v0, v1

    if-nez v0, :cond_0

    iget v0, p0, Llocal/mio/os4camerabridge/LegendaryM9FrameContractBridge$Frame;->gain:F

    iget v1, p1, Llocal/mio/os4camerabridge/LegendaryM9FrameContractBridge$Frame;->gain:F

    cmpl-float v0, v0, v1

    if-nez v0, :cond_0

    iget-object v0, p0, Llocal/mio/os4camerabridge/LegendaryM9FrameContractBridge$Frame;->ccm:[F

    iget-object p1, p1, Llocal/mio/os4camerabridge/LegendaryM9FrameContractBridge$Frame;->ccm:[F

    invoke-static {v0, p1}, Ljava/util/Objects;->equals(Ljava/lang/Object;Ljava/lang/Object;)Z

    move-result p1

    if-eqz p1, :cond_0

    const/4 p1, 0x1

    return p1

    :cond_0
    const/4 p1, 0x0

    return p1
.end method

.method private synthetic $record$getFieldsAsObjects()[Ljava/lang/Object;
    .locals 5

    iget v0, p0, Llocal/mio/os4camerabridge/LegendaryM9FrameContractBridge$Frame;->zoom:F

    invoke-static {v0}, Ljava/lang/Float;->valueOf(F)Ljava/lang/Float;

    move-result-object v0

    iget v1, p0, Llocal/mio/os4camerabridge/LegendaryM9FrameContractBridge$Frame;->gain:F

    invoke-static {v1}, Ljava/lang/Float;->valueOf(F)Ljava/lang/Float;

    move-result-object v1

    iget-object v2, p0, Llocal/mio/os4camerabridge/LegendaryM9FrameContractBridge$Frame;->ccm:[F

    iget-wide v3, p0, Llocal/mio/os4camerabridge/LegendaryM9FrameContractBridge$Frame;->timestamp:J

    invoke-static {v3, v4}, Ljava/lang/Long;->valueOf(J)Ljava/lang/Long;

    move-result-object v3

    filled-new-array {v0, v1, v2, v3}, [Ljava/lang/Object;

    move-result-object v0

    return-object v0
.end method

.method static bridge synthetic -$$Nest$fgetccm(Llocal/mio/os4camerabridge/LegendaryM9FrameContractBridge$Frame;)[F
    .locals 0

    iget-object p0, p0, Llocal/mio/os4camerabridge/LegendaryM9FrameContractBridge$Frame;->ccm:[F

    return-object p0
.end method

.method static bridge synthetic -$$Nest$fgetgain(Llocal/mio/os4camerabridge/LegendaryM9FrameContractBridge$Frame;)F
    .locals 0

    iget p0, p0, Llocal/mio/os4camerabridge/LegendaryM9FrameContractBridge$Frame;->gain:F

    return p0
.end method

.method static bridge synthetic -$$Nest$fgettimestamp(Llocal/mio/os4camerabridge/LegendaryM9FrameContractBridge$Frame;)J
    .locals 2

    iget-wide v0, p0, Llocal/mio/os4camerabridge/LegendaryM9FrameContractBridge$Frame;->timestamp:J

    return-wide v0
.end method

.method static bridge synthetic -$$Nest$fgetzoom(Llocal/mio/os4camerabridge/LegendaryM9FrameContractBridge$Frame;)F
    .locals 0

    iget p0, p0, Llocal/mio/os4camerabridge/LegendaryM9FrameContractBridge$Frame;->zoom:F

    return p0
.end method

.method private constructor <init>(FF[FJ)V
    .locals 0
    .annotation system Ldalvik/annotation/MethodParameters;
        accessFlags = {
            0x0,
            0x0,
            0x0,
            0x0
        }
        names = {
            "zoom",
            "gain",
            "ccm",
            "timestamp"
        }
    .end annotation

    .line 15
    invoke-direct {p0}, Lcom/android/tools/r8/RecordTag;-><init>()V

    iput p1, p0, Llocal/mio/os4camerabridge/LegendaryM9FrameContractBridge$Frame;->zoom:F

    iput p2, p0, Llocal/mio/os4camerabridge/LegendaryM9FrameContractBridge$Frame;->gain:F

    iput-object p3, p0, Llocal/mio/os4camerabridge/LegendaryM9FrameContractBridge$Frame;->ccm:[F

    iput-wide p4, p0, Llocal/mio/os4camerabridge/LegendaryM9FrameContractBridge$Frame;->timestamp:J

    return-void
.end method

.method synthetic constructor <init>(FF[FJLlocal/mio/os4camerabridge/LegendaryM9FrameContractBridge-IA;)V
    .locals 0

    invoke-direct/range {p0 .. p5}, Llocal/mio/os4camerabridge/LegendaryM9FrameContractBridge$Frame;-><init>(FF[FJ)V

    return-void
.end method


# virtual methods
.method public ccm()[F
    .locals 1

    .line 15
    iget-object v0, p0, Llocal/mio/os4camerabridge/LegendaryM9FrameContractBridge$Frame;->ccm:[F

    return-object v0
.end method

.method public final equals(Ljava/lang/Object;)Z
    .locals 0

    .line 15
    invoke-direct {p0, p1}, Llocal/mio/os4camerabridge/LegendaryM9FrameContractBridge$Frame;->$record$equals(Ljava/lang/Object;)Z

    move-result p1

    return p1
.end method

.method public gain()F
    .locals 1

    .line 15
    iget v0, p0, Llocal/mio/os4camerabridge/LegendaryM9FrameContractBridge$Frame;->gain:F

    return v0
.end method

.method public final hashCode()I
    .locals 5

    .line 15
    iget-wide v0, p0, Llocal/mio/os4camerabridge/LegendaryM9FrameContractBridge$Frame;->timestamp:J

    iget v2, p0, Llocal/mio/os4camerabridge/LegendaryM9FrameContractBridge$Frame;->zoom:F

    iget v3, p0, Llocal/mio/os4camerabridge/LegendaryM9FrameContractBridge$Frame;->gain:F

    iget-object v4, p0, Llocal/mio/os4camerabridge/LegendaryM9FrameContractBridge$Frame;->ccm:[F

    invoke-static {v0, v1, v2, v3, v4}, Llocal/mio/os4camerabridge/LegendaryM9FrameContractBridge$Frame$$ExternalSyntheticRecord1;->m(JFFLjava/lang/Object;)I

    move-result v0

    return v0
.end method

.method public timestamp()J
    .locals 2

    .line 15
    iget-wide v0, p0, Llocal/mio/os4camerabridge/LegendaryM9FrameContractBridge$Frame;->timestamp:J

    return-wide v0
.end method

.method public final toString()Ljava/lang/String;
    .locals 3

    .line 15
    invoke-direct {p0}, Llocal/mio/os4camerabridge/LegendaryM9FrameContractBridge$Frame;->$record$getFieldsAsObjects()[Ljava/lang/Object;

    move-result-object v0

    const-class v1, Llocal/mio/os4camerabridge/LegendaryM9FrameContractBridge$Frame;

    const-string v2, "zoom;gain;ccm;timestamp"

    invoke-static {v0, v1, v2}, Llocal/mio/os4camerabridge/LegendaryM9FrameContractBridge$Frame$$ExternalSyntheticRecord0;->m([Ljava/lang/Object;Ljava/lang/Class;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method

.method public zoom()F
    .locals 1

    .line 15
    iget v0, p0, Llocal/mio/os4camerabridge/LegendaryM9FrameContractBridge$Frame;->zoom:F

    return v0
.end method
