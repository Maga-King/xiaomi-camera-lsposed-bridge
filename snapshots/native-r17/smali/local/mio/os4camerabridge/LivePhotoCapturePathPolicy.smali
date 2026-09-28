.class public final Llocal/mio/os4camerabridge/LivePhotoCapturePathPolicy;
.super Ljava/lang/Object;
.source "LivePhotoCapturePathPolicy.java"


# direct methods
.method private constructor <init>()V
    .locals 0

    .line 5
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method public static dateTakenMillis(Ljava/lang/String;)J
    .locals 6

    .line 12
    const-wide/16 v0, -0x1

    if-nez p0, :cond_0

    return-wide v0

    .line 13
    :cond_0
    nop

    .line 14
    const-string v2, ",mDateTakenTime="

    invoke-virtual {p0, v2}, Ljava/lang/String;->indexOf(Ljava/lang/String;)I

    move-result v3

    .line 15
    if-gez v3, :cond_1

    return-wide v0

    .line 16
    :cond_1
    invoke-virtual {v2}, Ljava/lang/String;->length()I

    move-result v2

    add-int/2addr v3, v2

    .line 17
    const/16 v2, 0x2c

    invoke-virtual {p0, v2, v3}, Ljava/lang/String;->indexOf(II)I

    move-result v2

    .line 18
    if-le v2, v3, :cond_3

    sub-int v4, v2, v3

    const/16 v5, 0x10

    if-le v4, v5, :cond_2

    goto :goto_0

    .line 19
    :cond_2
    :try_start_0
    invoke-virtual {p0, v3, v2}, Ljava/lang/String;->substring(II)Ljava/lang/String;

    move-result-object p0

    invoke-static {p0}, Ljava/lang/Long;->parseLong(Ljava/lang/String;)J

    move-result-wide v0
    :try_end_0
    .catch Ljava/lang/NumberFormatException; {:try_start_0 .. :try_end_0} :catch_0

    return-wide v0

    .line 20
    :catch_0
    move-exception p0

    return-wide v0

    .line 18
    :cond_3
    :goto_0
    return-wide v0
.end method

.method public static isNativeLivePath(Ljava/lang/String;)Z
    .locals 1

    .line 8
    if-eqz p0, :cond_0

    const-string v0, "/storage/emulated/0/DCIM/Camera/MVIMG_[0-9]{8}_[0-9]{6}(?:_[0-9]+)?\\.jpg"

    invoke-virtual {p0, v0}, Ljava/lang/String;->matches(Ljava/lang/String;)Z

    move-result p0

    if-eqz p0, :cond_0

    const/4 p0, 0x1

    goto :goto_0

    :cond_0
    const/4 p0, 0x0

    :goto_0
    return p0
.end method

.method public static mayTransfer(Ljava/lang/String;JJJII)Z
    .locals 4

    .line 25
    invoke-static {p0}, Llocal/mio/os4camerabridge/LivePhotoCapturePathPolicy;->isNativeLivePath(Ljava/lang/String;)Z

    move-result p0

    if-eqz p0, :cond_0

    const-wide/16 v0, 0x0

    cmp-long p0, p1, v0

    if-ltz p0, :cond_0

    const-wide/32 v2, 0x3b9aca00

    cmp-long p0, p1, v2

    if-gtz p0, :cond_0

    cmp-long p0, p3, v0

    if-lez p0, :cond_0

    cmp-long p0, p5, v0

    if-lez p0, :cond_0

    const-wide/16 p0, 0x64

    sub-long p0, p3, p0

    cmp-long p0, p5, p0

    if-ltz p0, :cond_0

    const-wide/16 p0, 0x3e8

    add-long/2addr p3, p0

    cmp-long p0, p5, p3

    if-gtz p0, :cond_0

    if-ne p7, p8, :cond_0

    const/4 p0, 0x1

    goto :goto_0

    :cond_0
    const/4 p0, 0x0

    :goto_0
    return p0
.end method
