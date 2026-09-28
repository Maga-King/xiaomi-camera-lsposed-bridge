.class public final Llocal/mio/os4camerabridge/RearJpegMetadataPolicy;
.super Ljava/lang/Object;
.source "RearJpegMetadataPolicy.java"


# direct methods
.method private constructor <init>()V
    .locals 0

    .line 10
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method private static headers([B)Ljava/util/List;
    .locals 10
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "([B)",
            "Ljava/util/List<",
            "[I>;"
        }
    .end annotation

    .line 66
    if-eqz p0, :cond_d

    array-length v0, p0

    const/4 v1, 0x4

    if-lt v0, v1, :cond_d

    const/4 v0, 0x0

    aget-byte v0, p0, v0

    const/16 v1, 0xff

    and-int/2addr v0, v1

    if-ne v0, v1, :cond_d

    const/4 v0, 0x1

    aget-byte v2, p0, v0

    and-int/2addr v2, v1

    const/16 v3, 0xd8

    if-ne v2, v3, :cond_d

    .line 68
    new-instance v2, Ljava/util/ArrayList;

    invoke-direct {v2}, Ljava/util/ArrayList;-><init>()V

    .line 69
    const/4 v3, 0x2

    move v4, v3

    .line 70
    :goto_0
    array-length v5, p0

    if-ge v4, v5, :cond_c

    invoke-virtual {v2}, Ljava/util/ArrayList;->size()I

    move-result v5

    const/16 v6, 0x400

    if-ge v5, v6, :cond_c

    .line 71
    nop

    .line 72
    add-int/lit8 v5, v4, 0x1

    aget-byte v6, p0, v4

    and-int/2addr v6, v1

    if-ne v6, v1, :cond_b

    .line 73
    :goto_1
    array-length v6, p0

    if-ge v5, v6, :cond_0

    aget-byte v6, p0, v5

    and-int/2addr v6, v1

    if-ne v6, v1, :cond_0

    add-int/lit8 v5, v5, 0x1

    goto :goto_1

    .line 74
    :cond_0
    array-length v6, p0

    if-ge v5, v6, :cond_a

    .line 75
    add-int/lit8 v6, v5, 0x1

    aget-byte v5, p0, v5

    and-int/2addr v5, v1

    .line 76
    const/16 v7, 0xd9

    if-ne v5, v7, :cond_1

    return-object v2

    .line 77
    :cond_1
    const/16 v7, 0xda

    if-ne v5, v7, :cond_4

    .line 78
    add-int/lit8 v0, v6, 0x2

    array-length v4, p0

    if-gt v0, v4, :cond_3

    .line 79
    aget-byte v0, p0, v6

    and-int/2addr v0, v1

    shl-int/lit8 v0, v0, 0x8

    add-int/lit8 v4, v6, 0x1

    aget-byte v4, p0, v4

    and-int/2addr v1, v4

    or-int/2addr v0, v1

    .line 80
    if-lt v0, v3, :cond_2

    array-length p0, p0

    sub-int/2addr p0, v6

    if-gt v0, p0, :cond_2

    .line 81
    return-object v2

    .line 80
    :cond_2
    new-instance p0, Ljava/lang/IllegalArgumentException;

    const-string v0, "SOS \u957f\u5ea6\u65e0\u6548"

    invoke-direct {p0, v0}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw p0

    .line 78
    :cond_3
    new-instance p0, Ljava/lang/IllegalArgumentException;

    const-string v0, "SOS \u622a\u65ad"

    invoke-direct {p0, v0}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw p0

    .line 83
    :cond_4
    if-eq v5, v0, :cond_9

    const/16 v7, 0xd0

    if-lt v5, v7, :cond_5

    const/16 v7, 0xd7

    if-gt v5, v7, :cond_5

    goto :goto_2

    .line 84
    :cond_5
    add-int/lit8 v7, v6, 0x2

    array-length v8, p0

    if-gt v7, v8, :cond_8

    .line 85
    aget-byte v7, p0, v6

    and-int/2addr v7, v1

    shl-int/lit8 v7, v7, 0x8

    add-int/lit8 v8, v6, 0x1

    aget-byte v8, p0, v8

    and-int/2addr v8, v1

    or-int/2addr v7, v8

    .line 86
    if-lt v7, v3, :cond_7

    array-length v8, p0

    sub-int/2addr v8, v6

    if-gt v7, v8, :cond_7

    .line 88
    add-int/lit8 v8, v6, -0x2

    add-int/lit8 v9, v7, 0x2

    filled-new-array {v8, v9, v5}, [I

    move-result-object v5

    invoke-virtual {v2, v5}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    .line 89
    add-int/2addr v6, v7

    .line 90
    if-le v6, v4, :cond_6

    .line 91
    move v4, v6

    goto/16 :goto_0

    .line 90
    :cond_6
    new-instance p0, Ljava/lang/IllegalArgumentException;

    const-string v0, "JPEG \u89e3\u6790\u672a\u524d\u8fdb"

    invoke-direct {p0, v0}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw p0

    .line 86
    :cond_7
    new-instance p0, Ljava/lang/IllegalArgumentException;

    const-string v0, "JPEG \u6bb5\u8d8a\u754c"

    invoke-direct {p0, v0}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw p0

    .line 84
    :cond_8
    new-instance p0, Ljava/lang/IllegalArgumentException;

    const-string v0, "JPEG \u6bb5\u5934\u622a\u65ad"

    invoke-direct {p0, v0}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw p0

    .line 70
    :cond_9
    :goto_2
    move v4, v6

    goto/16 :goto_0

    .line 74
    :cond_a
    new-instance p0, Ljava/lang/IllegalArgumentException;

    const-string v0, "JPEG \u6807\u8bb0\u622a\u65ad"

    invoke-direct {p0, v0}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw p0

    .line 72
    :cond_b
    new-instance p0, Ljava/lang/IllegalArgumentException;

    const-string v0, "JPEG \u6807\u8bb0\u65e0\u6548"

    invoke-direct {p0, v0}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw p0

    .line 92
    :cond_c
    new-instance p0, Ljava/lang/IllegalArgumentException;

    const-string v0, "JPEG \u7f3a\u5c11\u626b\u63cf\u6bb5\u6216\u6bb5\u6570\u8d85\u9650"

    invoke-direct {p0, v0}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw p0

    .line 67
    :cond_d
    new-instance p0, Ljava/lang/IllegalArgumentException;

    const-string v0, "\u7f3a\u5c11 JPEG SOI"

    invoke-direct {p0, v0}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw p0
.end method

.method private static isExif([B[I)Z
    .locals 4

    .line 53
    const/4 v0, 0x0

    aget v1, p1, v0

    add-int/lit8 v1, v1, 0x4

    .line 54
    const/4 v2, 0x2

    aget v2, p1, v2

    const/16 v3, 0xe1

    if-ne v2, v3, :cond_0

    const/4 v2, 0x1

    aget p1, p1, v2

    const/16 v3, 0xa

    if-lt p1, v3, :cond_0

    aget-byte p1, p0, v1

    const/16 v3, 0x45

    if-ne p1, v3, :cond_0

    add-int/lit8 p1, v1, 0x1

    aget-byte p1, p0, p1

    const/16 v3, 0x78

    if-ne p1, v3, :cond_0

    add-int/lit8 p1, v1, 0x2

    aget-byte p1, p0, p1

    const/16 v3, 0x69

    if-ne p1, v3, :cond_0

    add-int/lit8 p1, v1, 0x3

    aget-byte p1, p0, p1

    const/16 v3, 0x66

    if-ne p1, v3, :cond_0

    add-int/lit8 p1, v1, 0x4

    aget-byte p1, p0, p1

    if-nez p1, :cond_0

    add-int/lit8 v1, v1, 0x5

    aget-byte p0, p0, v1

    if-nez p0, :cond_0

    move v0, v2

    :cond_0
    return v0
.end method

.method private static same([B[I[B[I)Z
    .locals 5

    .line 60
    const/4 v0, 0x1

    aget v1, p1, v0

    aget v2, p3, v0

    const/4 v3, 0x0

    if-eq v1, v2, :cond_0

    return v3

    .line 61
    :cond_0
    move v1, v3

    :goto_0
    aget v2, p1, v0

    if-ge v1, v2, :cond_2

    aget v2, p1, v3

    add-int/2addr v2, v1

    aget-byte v2, p0, v2

    aget v4, p3, v3

    add-int/2addr v4, v1

    aget-byte v4, p2, v4

    if-eq v2, v4, :cond_1

    return v3

    :cond_1
    add-int/lit8 v1, v1, 0x1

    goto :goto_0

    .line 62
    :cond_2
    return v0
.end method

.method public static transfer([B[B)[B
    .locals 13

    .line 13
    invoke-static {p0}, Llocal/mio/os4camerabridge/RearJpegMetadataPolicy;->headers([B)Ljava/util/List;

    move-result-object v0

    .line 14
    invoke-static {p1}, Llocal/mio/os4camerabridge/RearJpegMetadataPolicy;->headers([B)Ljava/util/List;

    move-result-object v1

    .line 15
    invoke-static {p0, p1}, Ljava/util/Arrays;->equals([B[B)Z

    move-result v2

    if-eqz v2, :cond_0

    return-object p1

    .line 16
    :cond_0
    new-instance v2, Ljava/io/ByteArrayOutputStream;

    invoke-direct {v2}, Ljava/io/ByteArrayOutputStream;-><init>()V

    .line 17
    new-instance v3, Ljava/util/ArrayList;

    invoke-direct {v3}, Ljava/util/ArrayList;-><init>()V

    .line 18
    invoke-interface {v0}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object v0

    :goto_0
    invoke-interface {v0}, Ljava/util/Iterator;->hasNext()Z

    move-result v4

    const/4 v5, 0x0

    const/4 v6, 0x2

    if-eqz v4, :cond_a

    invoke-interface {v0}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v4

    check-cast v4, [I

    .line 19
    aget v7, v4, v6

    .line 21
    const/16 v8, 0xe1

    if-eq v7, v8, :cond_1

    const/16 v8, 0xed

    if-eq v7, v8, :cond_1

    goto :goto_0

    .line 22
    :cond_1
    nop

    .line 23
    invoke-interface {v1}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object v8

    :goto_1
    invoke-interface {v8}, Ljava/util/Iterator;->hasNext()Z

    move-result v9

    const/4 v10, 0x1

    if-eqz v9, :cond_5

    invoke-interface {v8}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v9

    check-cast v9, [I

    .line 24
    aget v11, v9, v6

    if-eq v7, v11, :cond_2

    goto :goto_1

    .line 25
    :cond_2
    invoke-static {p0, v4, p1, v9}, Llocal/mio/os4camerabridge/RearJpegMetadataPolicy;->same([B[I[B[I)Z

    move-result v11

    if-nez v11, :cond_4

    .line 26
    invoke-static {p0, v4}, Llocal/mio/os4camerabridge/RearJpegMetadataPolicy;->isExif([B[I)Z

    move-result v11

    if-eqz v11, :cond_3

    invoke-static {p1, v9}, Llocal/mio/os4camerabridge/RearJpegMetadataPolicy;->isExif([B[I)Z

    move-result v9

    if-eqz v9, :cond_3

    goto :goto_2

    .line 30
    :cond_3
    goto :goto_1

    .line 27
    :cond_4
    :goto_2
    nop

    .line 28
    move v8, v10

    goto :goto_3

    .line 23
    :cond_5
    move v8, v5

    .line 31
    :goto_3
    invoke-interface {v3}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object v9

    :goto_4
    invoke-interface {v9}, Ljava/util/Iterator;->hasNext()Z

    move-result v11

    if-eqz v11, :cond_8

    invoke-interface {v9}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v11

    check-cast v11, [I

    .line 32
    aget v12, v11, v6

    if-ne v7, v12, :cond_7

    invoke-static {p0, v4, p0, v11}, Llocal/mio/os4camerabridge/RearJpegMetadataPolicy;->same([B[I[B[I)Z

    move-result v12

    if-nez v12, :cond_6

    .line 33
    invoke-static {p0, v4}, Llocal/mio/os4camerabridge/RearJpegMetadataPolicy;->isExif([B[I)Z

    move-result v12

    if-eqz v12, :cond_7

    invoke-static {p0, v11}, Llocal/mio/os4camerabridge/RearJpegMetadataPolicy;->isExif([B[I)Z

    move-result v11

    if-eqz v11, :cond_7

    .line 34
    :cond_6
    nop

    .line 35
    move v8, v10

    goto :goto_5

    .line 37
    :cond_7
    goto :goto_4

    .line 38
    :cond_8
    :goto_5
    if-nez v8, :cond_9

    .line 39
    aget v5, v4, v5

    aget v6, v4, v10

    invoke-virtual {v2, p0, v5, v6}, Ljava/io/ByteArrayOutputStream;->write([BII)V

    .line 40
    invoke-interface {v3, v4}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    .line 42
    :cond_9
    goto :goto_0

    .line 43
    :cond_a
    invoke-virtual {v2}, Ljava/io/ByteArrayOutputStream;->size()I

    move-result p0

    if-nez p0, :cond_b

    return-object p1

    .line 44
    :cond_b
    new-instance p0, Ljava/io/ByteArrayOutputStream;

    array-length v0, p1

    invoke-virtual {v2}, Ljava/io/ByteArrayOutputStream;->size()I

    move-result v1

    add-int/2addr v0, v1

    invoke-direct {p0, v0}, Ljava/io/ByteArrayOutputStream;-><init>(I)V

    .line 45
    invoke-virtual {p0, p1, v5, v6}, Ljava/io/ByteArrayOutputStream;->write([BII)V

    .line 46
    invoke-virtual {v2}, Ljava/io/ByteArrayOutputStream;->toByteArray()[B

    move-result-object v0

    .line 47
    array-length v1, v0

    invoke-virtual {p0, v0, v5, v1}, Ljava/io/ByteArrayOutputStream;->write([BII)V

    .line 48
    array-length v0, p1

    sub-int/2addr v0, v6

    invoke-virtual {p0, p1, v6, v0}, Ljava/io/ByteArrayOutputStream;->write([BII)V

    .line 49
    invoke-virtual {p0}, Ljava/io/ByteArrayOutputStream;->toByteArray()[B

    move-result-object p0

    return-object p0
.end method
