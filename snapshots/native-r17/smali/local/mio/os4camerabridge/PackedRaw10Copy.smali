.class public final Llocal/mio/os4camerabridge/PackedRaw10Copy;
.super Ljava/lang/Object;
.source "PackedRaw10Copy.java"


# direct methods
.method private constructor <init>()V
    .locals 0

    .line 7
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method public static copy(Ljava/nio/ByteBuffer;III)[B
    .locals 8

    .line 10
    if-eqz p0, :cond_2

    if-lez p1, :cond_2

    if-lez p2, :cond_2

    rem-int/lit8 v0, p1, 0x4

    if-nez v0, :cond_2

    const/16 v0, 0x2000

    if-gt p1, v0, :cond_2

    if-gt p2, v0, :cond_2

    .line 12
    div-int/lit8 p1, p1, 0x4

    mul-int/lit8 p1, p1, 0x5

    .line 13
    int-to-long v0, p1

    int-to-long v2, p2

    mul-long/2addr v2, v0

    .line 14
    int-to-long v4, p3

    add-int/lit8 v6, p2, -0x1

    int-to-long v6, v6

    mul-long/2addr v4, v6

    add-long/2addr v4, v0

    .line 15
    if-lt p3, p1, :cond_1

    const-wide/32 v0, 0x4000000

    cmp-long v0, v2, v0

    if-gtz v0, :cond_1

    invoke-virtual {p0}, Ljava/nio/ByteBuffer;->remaining()I

    move-result v0

    int-to-long v0, v0

    cmp-long v0, v4, v0

    if-gtz v0, :cond_1

    .line 17
    invoke-virtual {p0}, Ljava/nio/ByteBuffer;->duplicate()Ljava/nio/ByteBuffer;

    move-result-object p0

    .line 18
    invoke-virtual {p0}, Ljava/nio/ByteBuffer;->position()I

    move-result v0

    .line 19
    long-to-int v1, v2

    new-array v1, v1, [B

    .line 20
    const/4 v2, 0x0

    :goto_0
    if-ge v2, p2, :cond_0

    .line 21
    mul-int v3, v2, p3

    add-int/2addr v3, v0

    invoke-virtual {p0, v3}, Ljava/nio/ByteBuffer;->position(I)Ljava/nio/ByteBuffer;

    .line 22
    mul-int v3, v2, p1

    invoke-virtual {p0, v1, v3, p1}, Ljava/nio/ByteBuffer;->get([BII)Ljava/nio/ByteBuffer;

    .line 20
    add-int/lit8 v2, v2, 0x1

    goto :goto_0

    .line 24
    :cond_0
    return-object v1

    .line 16
    :cond_1
    new-instance p0, Ljava/lang/IllegalArgumentException;

    const-string p1, "Invalid RAW10 stride/capacity"

    invoke-direct {p0, p1}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw p0

    .line 11
    :cond_2
    new-instance p0, Ljava/lang/IllegalArgumentException;

    const-string p1, "Invalid RAW10 geometry"

    invoke-direct {p0, p1}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw p0
.end method
