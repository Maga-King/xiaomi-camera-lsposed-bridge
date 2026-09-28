.class public final Llocal/mio/os4camerabridge/LegendaryJpegColorMetadata;
.super Ljava/lang/Object;
.source "LegendaryJpegColorMetadata.java"


# static fields
.field private static final ICC:[B


# direct methods
.method static constructor <clinit>()V
    .locals 2

    .line 8
    const-string v0, "ICC_PROFILE\u0000"

    sget-object v1, Ljava/nio/charset/StandardCharsets;->US_ASCII:Ljava/nio/charset/Charset;

    invoke-virtual {v0, v1}, Ljava/lang/String;->getBytes(Ljava/nio/charset/Charset;)[B

    move-result-object v0

    sput-object v0, Llocal/mio/os4camerabridge/LegendaryJpegColorMetadata;->ICC:[B

    return-void
.end method

.method private constructor <init>()V
    .locals 0

    .line 10
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method public static withoutSourceIcc([B)[B
    .locals 13

    .line 13
    if-eqz p0, :cond_e

    array-length v0, p0

    const/4 v1, 0x4

    if-lt v0, v1, :cond_e

    const/4 v0, 0x0

    aget-byte v1, p0, v0

    const/16 v2, 0xff

    and-int/2addr v1, v2

    if-ne v1, v2, :cond_e

    const/4 v1, 0x1

    aget-byte v3, p0, v1

    and-int/2addr v3, v2

    const/16 v4, 0xd8

    if-ne v3, v4, :cond_e

    .line 15
    new-instance v3, Ljava/io/ByteArrayOutputStream;

    array-length v5, p0

    invoke-direct {v3, v5}, Ljava/io/ByteArrayOutputStream;-><init>(I)V

    .line 16
    const/4 v5, 0x2

    invoke-virtual {v3, p0, v0, v5}, Ljava/io/ByteArrayOutputStream;->write([BII)V

    .line 17
    move v6, v5

    .line 18
    :goto_0
    array-length v7, p0

    if-ge v6, v7, :cond_d

    .line 19
    nop

    .line 20
    add-int/lit8 v7, v6, 0x1

    aget-byte v8, p0, v6

    and-int/2addr v8, v2

    if-ne v8, v2, :cond_c

    .line 21
    :goto_1
    array-length v8, p0

    if-ge v7, v8, :cond_0

    aget-byte v8, p0, v7

    and-int/2addr v8, v2

    if-ne v8, v2, :cond_0

    add-int/lit8 v7, v7, 0x1

    goto :goto_1

    .line 22
    :cond_0
    array-length v8, p0

    if-ge v7, v8, :cond_b

    .line 23
    add-int/lit8 v8, v7, 0x1

    aget-byte v7, p0, v7

    and-int/2addr v7, v2

    .line 24
    const/16 v9, 0xda

    if-eq v7, v9, :cond_a

    const/16 v9, 0xd9

    if-ne v7, v9, :cond_1

    goto/16 :goto_6

    .line 28
    :cond_1
    if-eq v7, v1, :cond_9

    const/16 v9, 0xd0

    if-lt v7, v9, :cond_2

    const/16 v9, 0xd7

    if-gt v7, v9, :cond_2

    goto :goto_5

    .line 32
    :cond_2
    if-eqz v7, :cond_8

    if-eq v7, v4, :cond_8

    add-int/lit8 v9, v8, 0x2

    array-length v10, p0

    if-gt v9, v10, :cond_8

    .line 34
    aget-byte v10, p0, v8

    and-int/2addr v10, v2

    shl-int/lit8 v10, v10, 0x8

    add-int/lit8 v11, v8, 0x1

    aget-byte v11, p0, v11

    and-int/2addr v11, v2

    or-int/2addr v10, v11

    .line 35
    if-lt v10, v5, :cond_7

    array-length v11, p0

    sub-int/2addr v11, v8

    if-gt v10, v11, :cond_7

    .line 37
    const/16 v11, 0xe2

    if-ne v7, v11, :cond_3

    sget-object v7, Llocal/mio/os4camerabridge/LegendaryJpegColorMetadata;->ICC:[B

    array-length v7, v7

    add-int/2addr v7, v5

    if-lt v10, v7, :cond_3

    move v7, v1

    goto :goto_2

    :cond_3
    move v7, v0

    .line 38
    :goto_2
    move v11, v0

    :goto_3
    if-eqz v7, :cond_5

    sget-object v12, Llocal/mio/os4camerabridge/LegendaryJpegColorMetadata;->ICC:[B

    array-length v12, v12

    if-ge v11, v12, :cond_5

    add-int v7, v9, v11

    aget-byte v7, p0, v7

    sget-object v12, Llocal/mio/os4camerabridge/LegendaryJpegColorMetadata;->ICC:[B

    aget-byte v12, v12, v11

    if-ne v7, v12, :cond_4

    move v7, v1

    goto :goto_4

    :cond_4
    move v7, v0

    :goto_4
    add-int/lit8 v11, v11, 0x1

    goto :goto_3

    .line 39
    :cond_5
    add-int/2addr v8, v10

    .line 40
    if-nez v7, :cond_6

    sub-int v7, v8, v6

    invoke-virtual {v3, p0, v6, v7}, Ljava/io/ByteArrayOutputStream;->write([BII)V

    .line 41
    :cond_6
    nop

    .line 42
    move v6, v8

    goto :goto_0

    .line 36
    :cond_7
    new-instance p0, Ljava/lang/IllegalArgumentException;

    const-string v0, "Truncated segment"

    invoke-direct {p0, v0}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw p0

    .line 33
    :cond_8
    new-instance p0, Ljava/lang/IllegalArgumentException;

    const-string v0, "Invalid segment"

    invoke-direct {p0, v0}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw p0

    .line 29
    :cond_9
    :goto_5
    sub-int v7, v8, v6

    invoke-virtual {v3, p0, v6, v7}, Ljava/io/ByteArrayOutputStream;->write([BII)V

    .line 30
    move v6, v8

    goto/16 :goto_0

    .line 25
    :cond_a
    :goto_6
    array-length v0, p0

    sub-int/2addr v0, v6

    invoke-virtual {v3, p0, v6, v0}, Ljava/io/ByteArrayOutputStream;->write([BII)V

    .line 26
    invoke-virtual {v3}, Ljava/io/ByteArrayOutputStream;->toByteArray()[B

    move-result-object p0

    return-object p0

    .line 22
    :cond_b
    new-instance p0, Ljava/lang/IllegalArgumentException;

    const-string v0, "Truncated marker"

    invoke-direct {p0, v0}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw p0

    .line 20
    :cond_c
    new-instance p0, Ljava/lang/IllegalArgumentException;

    const-string v0, "Invalid marker"

    invoke-direct {p0, v0}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw p0

    .line 43
    :cond_d
    new-instance p0, Ljava/lang/IllegalArgumentException;

    const-string v0, "Missing scan/end marker"

    invoke-direct {p0, v0}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw p0

    .line 14
    :cond_e
    new-instance p0, Ljava/lang/IllegalArgumentException;

    const-string v0, "Not JPEG"

    invoke-direct {p0, v0}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw p0
.end method
