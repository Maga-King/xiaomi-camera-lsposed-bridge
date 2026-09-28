.class final Llocal/mio/os4camerabridge/LegendM9Container$Metadata;
.super Ljava/lang/Object;
.source "LegendM9Container.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Llocal/mio/os4camerabridge/LegendM9Container;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x18
    name = "Metadata"
.end annotation


# instance fields
.field final adrcGain:F

.field final awbB:F

.field final awbG:F

.field final awbR:F

.field final blackLevel:I

.field final cct:I

.field final exposureMs:F

.field final ispGain:F

.field final luxIndex:I

.field final orientation:I

.field final sensitivityIso:I

.field final sensorMode:I

.field final sensorType:I

.field final whiteLevel:I


# direct methods
.method constructor <init>(IFFFFFFIIIIIII)V
    .locals 0
    .param p1, "sensitivityIso"    # I
    .param p2, "awbR"    # F
    .param p3, "awbG"    # F
    .param p4, "awbB"    # F
    .param p5, "adrcGain"    # F
    .param p6, "ispGain"    # F
    .param p7, "exposureMs"    # F
    .param p8, "orientation"    # I
    .param p9, "cct"    # I
    .param p10, "luxIndex"    # I
    .param p11, "blackLevel"    # I
    .param p12, "whiteLevel"    # I
    .param p13, "sensorMode"    # I
    .param p14, "sensorType"    # I

    .line 48
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 49
    iput p1, p0, Llocal/mio/os4camerabridge/LegendM9Container$Metadata;->sensitivityIso:I

    .line 50
    iput p2, p0, Llocal/mio/os4camerabridge/LegendM9Container$Metadata;->awbR:F

    .line 51
    iput p3, p0, Llocal/mio/os4camerabridge/LegendM9Container$Metadata;->awbG:F

    .line 52
    iput p4, p0, Llocal/mio/os4camerabridge/LegendM9Container$Metadata;->awbB:F

    .line 53
    iput p5, p0, Llocal/mio/os4camerabridge/LegendM9Container$Metadata;->adrcGain:F

    .line 54
    iput p6, p0, Llocal/mio/os4camerabridge/LegendM9Container$Metadata;->ispGain:F

    .line 55
    iput p7, p0, Llocal/mio/os4camerabridge/LegendM9Container$Metadata;->exposureMs:F

    .line 56
    iput p8, p0, Llocal/mio/os4camerabridge/LegendM9Container$Metadata;->orientation:I

    .line 57
    iput p9, p0, Llocal/mio/os4camerabridge/LegendM9Container$Metadata;->cct:I

    .line 58
    iput p10, p0, Llocal/mio/os4camerabridge/LegendM9Container$Metadata;->luxIndex:I

    .line 59
    iput p11, p0, Llocal/mio/os4camerabridge/LegendM9Container$Metadata;->blackLevel:I

    .line 60
    iput p12, p0, Llocal/mio/os4camerabridge/LegendM9Container$Metadata;->whiteLevel:I

    .line 61
    iput p13, p0, Llocal/mio/os4camerabridge/LegendM9Container$Metadata;->sensorMode:I

    .line 62
    iput p14, p0, Llocal/mio/os4camerabridge/LegendM9Container$Metadata;->sensorType:I

    .line 63
    return-void
.end method


# virtual methods
.method validate()V
    .locals 5

    .line 66
    iget v0, p0, Llocal/mio/os4camerabridge/LegendM9Container$Metadata;->sensitivityIso:I

    const/4 v1, 0x1

    const/4 v2, 0x0

    if-lez v0, :cond_0

    move v0, v1

    goto :goto_0

    :cond_0
    move v0, v2

    :goto_0
    const-string v3, "ISO absent"

    invoke-static {v0, v3}, Llocal/mio/os4camerabridge/LegendM9Container;->-$$Nest$smrequire(ZLjava/lang/String;)V

    .line 67
    iget v0, p0, Llocal/mio/os4camerabridge/LegendM9Container$Metadata;->awbR:F

    invoke-static {v0}, Llocal/mio/os4camerabridge/LegendM9Container;->-$$Nest$smpositive(F)Z

    move-result v0

    if-eqz v0, :cond_1

    iget v0, p0, Llocal/mio/os4camerabridge/LegendM9Container$Metadata;->awbG:F

    invoke-static {v0}, Llocal/mio/os4camerabridge/LegendM9Container;->-$$Nest$smpositive(F)Z

    move-result v0

    if-eqz v0, :cond_1

    iget v0, p0, Llocal/mio/os4camerabridge/LegendM9Container$Metadata;->awbB:F

    invoke-static {v0}, Llocal/mio/os4camerabridge/LegendM9Container;->-$$Nest$smpositive(F)Z

    move-result v0

    if-eqz v0, :cond_1

    move v0, v1

    goto :goto_1

    :cond_1
    move v0, v2

    :goto_1
    const-string v3, "AWB gains absent"

    invoke-static {v0, v3}, Llocal/mio/os4camerabridge/LegendM9Container;->-$$Nest$smrequire(ZLjava/lang/String;)V

    .line 69
    iget v0, p0, Llocal/mio/os4camerabridge/LegendM9Container$Metadata;->adrcGain:F

    invoke-static {v0}, Llocal/mio/os4camerabridge/LegendM9Container;->-$$Nest$smpositive(F)Z

    move-result v0

    const-string v3, "ADRC gain absent"

    invoke-static {v0, v3}, Llocal/mio/os4camerabridge/LegendM9Container;->-$$Nest$smrequire(ZLjava/lang/String;)V

    .line 70
    iget v0, p0, Llocal/mio/os4camerabridge/LegendM9Container$Metadata;->ispGain:F

    invoke-static {v0}, Llocal/mio/os4camerabridge/LegendM9Container;->-$$Nest$smpositive(F)Z

    move-result v0

    const-string v3, "ISP gain absent"

    invoke-static {v0, v3}, Llocal/mio/os4camerabridge/LegendM9Container;->-$$Nest$smrequire(ZLjava/lang/String;)V

    .line 71
    iget v0, p0, Llocal/mio/os4camerabridge/LegendM9Container$Metadata;->exposureMs:F

    invoke-static {v0}, Llocal/mio/os4camerabridge/LegendM9Container;->-$$Nest$smpositive(F)Z

    move-result v0

    const-string v3, "exposure absent"

    invoke-static {v0, v3}, Llocal/mio/os4camerabridge/LegendM9Container;->-$$Nest$smrequire(ZLjava/lang/String;)V

    .line 72
    iget v0, p0, Llocal/mio/os4camerabridge/LegendM9Container$Metadata;->orientation:I

    if-eqz v0, :cond_3

    iget v0, p0, Llocal/mio/os4camerabridge/LegendM9Container$Metadata;->orientation:I

    const/16 v3, 0x5a

    if-eq v0, v3, :cond_3

    iget v0, p0, Llocal/mio/os4camerabridge/LegendM9Container$Metadata;->orientation:I

    const/16 v3, 0xb4

    if-eq v0, v3, :cond_3

    iget v0, p0, Llocal/mio/os4camerabridge/LegendM9Container$Metadata;->orientation:I

    const/16 v3, 0x10e

    if-ne v0, v3, :cond_2

    goto :goto_2

    :cond_2
    move v0, v2

    goto :goto_3

    :cond_3
    :goto_2
    move v0, v1

    :goto_3
    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    const-string v4, "invalid orientation "

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    iget v4, p0, Llocal/mio/os4camerabridge/LegendM9Container$Metadata;->orientation:I

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    invoke-static {v0, v3}, Llocal/mio/os4camerabridge/LegendM9Container;->-$$Nest$smrequire(ZLjava/lang/String;)V

    .line 75
    iget v0, p0, Llocal/mio/os4camerabridge/LegendM9Container$Metadata;->cct:I

    if-lez v0, :cond_4

    move v0, v1

    goto :goto_4

    :cond_4
    move v0, v2

    :goto_4
    const-string v3, "CCT absent"

    invoke-static {v0, v3}, Llocal/mio/os4camerabridge/LegendM9Container;->-$$Nest$smrequire(ZLjava/lang/String;)V

    .line 76
    iget v0, p0, Llocal/mio/os4camerabridge/LegendM9Container$Metadata;->luxIndex:I

    if-ltz v0, :cond_5

    move v0, v1

    goto :goto_5

    :cond_5
    move v0, v2

    :goto_5
    const-string v3, "lux index absent"

    invoke-static {v0, v3}, Llocal/mio/os4camerabridge/LegendM9Container;->-$$Nest$smrequire(ZLjava/lang/String;)V

    .line 77
    iget v0, p0, Llocal/mio/os4camerabridge/LegendM9Container$Metadata;->blackLevel:I

    if-ltz v0, :cond_6

    iget v0, p0, Llocal/mio/os4camerabridge/LegendM9Container$Metadata;->blackLevel:I

    iget v3, p0, Llocal/mio/os4camerabridge/LegendM9Container$Metadata;->whiteLevel:I

    if-ge v0, v3, :cond_6

    iget v0, p0, Llocal/mio/os4camerabridge/LegendM9Container$Metadata;->whiteLevel:I

    const/16 v3, 0x400

    if-gt v0, v3, :cond_6

    move v0, v1

    goto :goto_6

    :cond_6
    move v0, v2

    :goto_6
    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    const-string v4, "invalid RAW10 levels "

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    iget v4, p0, Llocal/mio/os4camerabridge/LegendM9Container$Metadata;->blackLevel:I

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v3

    const-string v4, "/"

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    iget v4, p0, Llocal/mio/os4camerabridge/LegendM9Container$Metadata;->whiteLevel:I

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    invoke-static {v0, v3}, Llocal/mio/os4camerabridge/LegendM9Container;->-$$Nest$smrequire(ZLjava/lang/String;)V

    .line 81
    iget v0, p0, Llocal/mio/os4camerabridge/LegendM9Container$Metadata;->sensorType:I

    if-lez v0, :cond_7

    goto :goto_7

    :cond_7
    move v1, v2

    :goto_7
    const-string v0, "sensor type absent"

    invoke-static {v1, v0}, Llocal/mio/os4camerabridge/LegendM9Container;->-$$Nest$smrequire(ZLjava/lang/String;)V

    .line 82
    return-void
.end method
