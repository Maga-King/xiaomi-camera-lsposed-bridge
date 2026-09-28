.class final Llocal/mio/os4camerabridge/LegendaryRawCfaBridge$Frame;
.super Lcom/android/tools/r8/RecordTag;
.source "LegendaryRawCfaBridge.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Llocal/mio/os4camerabridge/LegendaryRawCfaBridge;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x1a
    name = "Frame"
.end annotation


# instance fields
.field private final camera:I

.field private final cfa:I

.field private final timestamp:J


# direct methods
.method private synthetic $record$equals(Ljava/lang/Object;)Z
    .locals 4

    instance-of v0, p1, Llocal/mio/os4camerabridge/LegendaryRawCfaBridge$Frame;

    if-eqz v0, :cond_0

    check-cast p1, Llocal/mio/os4camerabridge/LegendaryRawCfaBridge$Frame;

    iget v0, p0, Llocal/mio/os4camerabridge/LegendaryRawCfaBridge$Frame;->cfa:I

    iget v1, p1, Llocal/mio/os4camerabridge/LegendaryRawCfaBridge$Frame;->cfa:I

    if-ne v0, v1, :cond_0

    iget v0, p0, Llocal/mio/os4camerabridge/LegendaryRawCfaBridge$Frame;->camera:I

    iget v1, p1, Llocal/mio/os4camerabridge/LegendaryRawCfaBridge$Frame;->camera:I

    if-ne v0, v1, :cond_0

    iget-wide v0, p0, Llocal/mio/os4camerabridge/LegendaryRawCfaBridge$Frame;->timestamp:J

    iget-wide v2, p1, Llocal/mio/os4camerabridge/LegendaryRawCfaBridge$Frame;->timestamp:J

    cmp-long p1, v0, v2

    if-nez p1, :cond_0

    const/4 p1, 0x1

    return p1

    :cond_0
    const/4 p1, 0x0

    return p1
.end method

.method private synthetic $record$getFieldsAsObjects()[Ljava/lang/Object;
    .locals 4

    iget v0, p0, Llocal/mio/os4camerabridge/LegendaryRawCfaBridge$Frame;->cfa:I

    invoke-static {v0}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v0

    iget v1, p0, Llocal/mio/os4camerabridge/LegendaryRawCfaBridge$Frame;->camera:I

    invoke-static {v1}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v1

    iget-wide v2, p0, Llocal/mio/os4camerabridge/LegendaryRawCfaBridge$Frame;->timestamp:J

    invoke-static {v2, v3}, Ljava/lang/Long;->valueOf(J)Ljava/lang/Long;

    move-result-object v2

    filled-new-array {v0, v1, v2}, [Ljava/lang/Object;

    move-result-object v0

    return-object v0
.end method

.method static bridge synthetic -$$Nest$fgetcamera(Llocal/mio/os4camerabridge/LegendaryRawCfaBridge$Frame;)I
    .locals 0

    iget p0, p0, Llocal/mio/os4camerabridge/LegendaryRawCfaBridge$Frame;->camera:I

    return p0
.end method

.method static bridge synthetic -$$Nest$fgetcfa(Llocal/mio/os4camerabridge/LegendaryRawCfaBridge$Frame;)I
    .locals 0

    iget p0, p0, Llocal/mio/os4camerabridge/LegendaryRawCfaBridge$Frame;->cfa:I

    return p0
.end method

.method static bridge synthetic -$$Nest$fgettimestamp(Llocal/mio/os4camerabridge/LegendaryRawCfaBridge$Frame;)J
    .locals 2

    iget-wide v0, p0, Llocal/mio/os4camerabridge/LegendaryRawCfaBridge$Frame;->timestamp:J

    return-wide v0
.end method

.method private constructor <init>(IIJ)V
    .locals 0
    .annotation system Ldalvik/annotation/MethodParameters;
        accessFlags = {
            0x0,
            0x0,
            0x0
        }
        names = {
            "cfa",
            "camera",
            "timestamp"
        }
    .end annotation

    .line 16
    invoke-direct {p0}, Lcom/android/tools/r8/RecordTag;-><init>()V

    iput p1, p0, Llocal/mio/os4camerabridge/LegendaryRawCfaBridge$Frame;->cfa:I

    iput p2, p0, Llocal/mio/os4camerabridge/LegendaryRawCfaBridge$Frame;->camera:I

    iput-wide p3, p0, Llocal/mio/os4camerabridge/LegendaryRawCfaBridge$Frame;->timestamp:J

    return-void
.end method

.method synthetic constructor <init>(IIJLlocal/mio/os4camerabridge/LegendaryRawCfaBridge-IA;)V
    .locals 0

    invoke-direct {p0, p1, p2, p3, p4}, Llocal/mio/os4camerabridge/LegendaryRawCfaBridge$Frame;-><init>(IIJ)V

    return-void
.end method


# virtual methods
.method public camera()I
    .locals 1

    .line 16
    iget v0, p0, Llocal/mio/os4camerabridge/LegendaryRawCfaBridge$Frame;->camera:I

    return v0
.end method

.method public cfa()I
    .locals 1

    .line 16
    iget v0, p0, Llocal/mio/os4camerabridge/LegendaryRawCfaBridge$Frame;->cfa:I

    return v0
.end method

.method public final equals(Ljava/lang/Object;)Z
    .locals 0

    .line 16
    invoke-direct {p0, p1}, Llocal/mio/os4camerabridge/LegendaryRawCfaBridge$Frame;->$record$equals(Ljava/lang/Object;)Z

    move-result p1

    return p1
.end method

.method public final hashCode()I
    .locals 4

    .line 16
    iget v0, p0, Llocal/mio/os4camerabridge/LegendaryRawCfaBridge$Frame;->cfa:I

    iget v1, p0, Llocal/mio/os4camerabridge/LegendaryRawCfaBridge$Frame;->camera:I

    iget-wide v2, p0, Llocal/mio/os4camerabridge/LegendaryRawCfaBridge$Frame;->timestamp:J

    invoke-static {v0, v1, v2, v3}, Llocal/mio/os4camerabridge/LegendaryRawCfaBridge$Frame$$ExternalSyntheticRecord0;->m(IIJ)I

    move-result v0

    return v0
.end method

.method public timestamp()J
    .locals 2

    .line 16
    iget-wide v0, p0, Llocal/mio/os4camerabridge/LegendaryRawCfaBridge$Frame;->timestamp:J

    return-wide v0
.end method

.method public final toString()Ljava/lang/String;
    .locals 3

    .line 16
    invoke-direct {p0}, Llocal/mio/os4camerabridge/LegendaryRawCfaBridge$Frame;->$record$getFieldsAsObjects()[Ljava/lang/Object;

    move-result-object v0

    const-class v1, Llocal/mio/os4camerabridge/LegendaryRawCfaBridge$Frame;

    const-string v2, "cfa;camera;timestamp"

    invoke-static {v0, v1, v2}, Llocal/mio/os4camerabridge/LegendaryM9FrameContractBridge$Frame$$ExternalSyntheticRecord0;->m([Ljava/lang/Object;Ljava/lang/Class;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method
