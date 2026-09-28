.class public final Llocal/mio/os4camerabridge/LegendaryRawPackValidation;
.super Ljava/lang/Object;
.source "LegendaryRawPackValidation.java"


# direct methods
.method private constructor <init>()V
    .locals 0

    .line 5
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method public static check([B[B[I)V
    .locals 10

    .line 8
    if-eqz p0, :cond_3

    if-eqz p1, :cond_3

    array-length v0, p0

    const/high16 v1, 0xf00000

    if-ne v0, v1, :cond_3

    array-length v0, p1

    if-ne v0, v1, :cond_3

    if-eqz p2, :cond_3

    array-length v0, p2

    const/16 v1, 0x400

    if-ne v0, v1, :cond_3

    .line 11
    const/4 v0, 0x0

    move v2, v0

    :goto_0
    if-ge v2, v1, :cond_2

    .line 12
    int-to-long v3, v2

    const-wide/32 v5, 0x17ffff

    mul-long/2addr v3, v5

    const-wide/16 v5, 0x3ff

    div-long/2addr v3, v5

    long-to-int v3, v3

    .line 13
    div-int/lit16 v4, v3, 0x400

    mul-int/lit16 v4, v4, 0x1400

    mul-int/lit8 v4, v4, 0x2

    rem-int/lit16 v5, v3, 0x400

    mul-int/lit8 v5, v5, 0x5

    add-int/2addr v4, v5

    .line 14
    add-int/lit16 v5, v4, 0x1400

    .line 15
    move v6, v0

    :goto_1
    const/4 v7, 0x4

    if-ge v6, v7, :cond_1

    .line 16
    invoke-static {p1, v4, v6}, Llocal/mio/os4camerabridge/LegendaryRawPackValidation;->sample([BII)I

    move-result v7

    xor-int/lit8 v8, v6, 0x1

    invoke-static {p0, v5, v8}, Llocal/mio/os4camerabridge/LegendaryRawPackValidation;->sample([BII)I

    move-result v9

    aget v9, p2, v9

    if-ne v7, v9, :cond_0

    .line 17
    invoke-static {p1, v5, v6}, Llocal/mio/os4camerabridge/LegendaryRawPackValidation;->sample([BII)I

    move-result v7

    invoke-static {p0, v4, v8}, Llocal/mio/os4camerabridge/LegendaryRawPackValidation;->sample([BII)I

    move-result v8

    aget v8, p2, v8

    if-ne v7, v8, :cond_0

    .line 15
    add-int/lit8 v6, v6, 0x1

    goto :goto_1

    .line 18
    :cond_0
    new-instance p0, Ljava/lang/IllegalArgumentException;

    new-instance p1, Ljava/lang/StringBuilder;

    invoke-direct {p1}, Ljava/lang/StringBuilder;-><init>()V

    const-string p2, "RAW sample mismatch pair="

    invoke-virtual {p1, p2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p1

    invoke-virtual {p1, v3}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object p1

    const-string p2, " lane="

    invoke-virtual {p1, p2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p1

    invoke-virtual {p1, v6}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object p1

    invoke-virtual {p1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p1

    invoke-direct {p0, p1}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw p0

    .line 11
    :cond_1
    add-int/lit8 v2, v2, 0x1

    goto :goto_0

    .line 21
    :cond_2
    return-void

    .line 9
    :cond_3
    new-instance p0, Ljava/lang/IllegalArgumentException;

    const-string p1, "RAW packing geometry"

    invoke-direct {p0, p1}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw p0
.end method

.method private static sample([BII)I
    .locals 1

    .line 23
    add-int v0, p1, p2

    aget-byte v0, p0, v0

    and-int/lit16 v0, v0, 0xff

    shl-int/lit8 v0, v0, 0x2

    add-int/lit8 p1, p1, 0x4

    aget-byte p0, p0, p1

    mul-int/lit8 p2, p2, 0x2

    ushr-int/2addr p0, p2

    and-int/lit8 p0, p0, 0x3

    or-int/2addr p0, v0

    return p0
.end method
