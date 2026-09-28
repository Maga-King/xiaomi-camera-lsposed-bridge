.class public final Llocal/mio/os4camerabridge/LegendaryM9MessagePolicy;
.super Ljava/lang/Object;
.source "LegendaryM9MessagePolicy.java"


# direct methods
.method private constructor <init>()V
    .locals 0

    .line 8
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method public static correct([BFF[F)[B
    .locals 16

    .line 10
    move-object/from16 v0, p0

    move-object/from16 v1, p3

    invoke-static/range {p1 .. p1}, Llocal/mio/os4camerabridge/LegendaryM9MessagePolicy;->positive(F)Z

    move-result v2

    if-eqz v2, :cond_11

    invoke-static/range {p2 .. p2}, Llocal/mio/os4camerabridge/LegendaryM9MessagePolicy;->positive(F)Z

    move-result v2

    if-eqz v2, :cond_11

    if-eqz v1, :cond_11

    array-length v2, v1

    const/16 v3, 0x9

    if-ne v2, v3, :cond_11

    .line 12
    array-length v2, v1

    const/4 v4, 0x0

    move v5, v4

    :goto_0
    if-ge v5, v2, :cond_1

    aget v6, v1, v5

    invoke-static {v6}, Ljava/lang/Float;->isFinite(F)Z

    move-result v7

    if-eqz v7, :cond_0

    invoke-static {v6}, Ljava/lang/Math;->abs(F)F

    move-result v6

    const/high16 v7, 0x41800000    # 16.0f

    cmpl-float v6, v6, v7

    if-gtz v6, :cond_0

    add-int/lit8 v5, v5, 0x1

    goto :goto_0

    .line 13
    :cond_0
    new-instance v0, Ljava/lang/IllegalArgumentException;

    const-string v1, "invalid color transform"

    invoke-direct {v0, v1}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw v0

    .line 14
    :cond_1
    new-instance v2, Ljava/util/HashMap;

    invoke-direct {v2}, Ljava/util/HashMap;-><init>()V

    .line 15
    const/4 v5, 0x1

    new-array v6, v5, [I

    aput v4, v6, v4

    .line 16
    :goto_1
    aget v7, v6, v4

    array-length v8, v0

    const/4 v9, 0x3

    const/16 v10, 0x12

    const/4 v11, 0x5

    if-ge v7, v8, :cond_e

    .line 17
    invoke-static {v0, v6}, Llocal/mio/os4camerabridge/LegendaryM9MessagePolicy;->varint([B[I)J

    move-result-wide v7

    .line 18
    ushr-long v12, v7, v9

    long-to-int v9, v12

    const-wide/16 v12, 0x7

    and-long/2addr v7, v12

    long-to-int v7, v7

    .line 19
    if-lez v9, :cond_d

    .line 20
    aget v8, v6, v4

    .line 21
    if-nez v7, :cond_2

    invoke-static {v0, v6}, Llocal/mio/os4camerabridge/LegendaryM9MessagePolicy;->varint([B[I)J

    goto :goto_1

    .line 22
    :cond_2
    const/4 v12, 0x2

    if-ne v7, v5, :cond_3

    const/16 v13, 0x8

    move v15, v4

    goto :goto_2

    .line 23
    :cond_3
    if-ne v7, v11, :cond_4

    const/4 v13, 0x4

    move v15, v4

    goto :goto_2

    .line 24
    :cond_4
    if-ne v7, v12, :cond_c

    .line 25
    invoke-static {v0, v6}, Llocal/mio/os4camerabridge/LegendaryM9MessagePolicy;->varint([B[I)J

    move-result-wide v13

    .line 26
    array-length v8, v0

    move v15, v4

    int-to-long v4, v8

    cmp-long v4, v13, v4

    if-gtz v4, :cond_b

    .line 27
    long-to-int v13, v13

    aget v8, v6, v15

    .line 28
    nop

    .line 29
    :goto_2
    if-ltz v13, :cond_a

    array-length v4, v0

    sub-int/2addr v4, v13

    if-gt v8, v4, :cond_a

    .line 30
    if-eq v9, v11, :cond_5

    if-eq v9, v3, :cond_5

    if-ne v9, v10, :cond_7

    .line 31
    :cond_5
    invoke-static {v9}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v4

    invoke-static {v8}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v5

    invoke-interface {v2, v4, v5}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v4

    if-nez v4, :cond_9

    .line 32
    if-ne v9, v10, :cond_6

    if-ne v7, v12, :cond_8

    const/16 v4, 0x24

    if-ne v13, v4, :cond_8

    goto :goto_3

    :cond_6
    if-ne v7, v11, :cond_8

    .line 35
    :cond_7
    :goto_3
    add-int/2addr v8, v13

    aput v8, v6, v15

    .line 36
    move v4, v15

    const/4 v5, 0x1

    goto :goto_1

    .line 33
    :cond_8
    new-instance v0, Ljava/lang/IllegalArgumentException;

    const-string v1, "contract wire mismatch"

    invoke-direct {v0, v1}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw v0

    .line 31
    :cond_9
    new-instance v0, Ljava/lang/IllegalArgumentException;

    const-string v1, "duplicate contract field"

    invoke-direct {v0, v1}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw v0

    .line 29
    :cond_a
    new-instance v0, Ljava/lang/IllegalArgumentException;

    const-string v1, "truncated packet"

    invoke-direct {v0, v1}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw v0

    .line 26
    :cond_b
    new-instance v0, Ljava/lang/IllegalArgumentException;

    const-string v1, "invalid length"

    invoke-direct {v0, v1}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw v0

    .line 28
    :cond_c
    new-instance v0, Ljava/lang/IllegalArgumentException;

    const-string v1, "unsupported wire type"

    invoke-direct {v0, v1}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw v0

    .line 19
    :cond_d
    new-instance v0, Ljava/lang/IllegalArgumentException;

    const-string v1, "invalid field"

    invoke-direct {v0, v1}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw v0

    .line 37
    :cond_e
    move v15, v4

    invoke-interface {v2}, Ljava/util/Map;->size()I

    move-result v4

    if-ne v4, v9, :cond_10

    .line 38
    invoke-virtual {v0}, [B->clone()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, [B

    .line 39
    invoke-static {v11}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v4

    invoke-interface {v2, v4}, Ljava/util/Map;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v4

    check-cast v4, Ljava/lang/Integer;

    invoke-virtual {v4}, Ljava/lang/Integer;->intValue()I

    move-result v4

    move/from16 v5, p2

    invoke-static {v0, v4, v5}, Llocal/mio/os4camerabridge/LegendaryM9MessagePolicy;->put([BIF)V

    .line 40
    invoke-static {v3}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v4

    invoke-interface {v2, v4}, Ljava/util/Map;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v4

    check-cast v4, Ljava/lang/Integer;

    invoke-virtual {v4}, Ljava/lang/Integer;->intValue()I

    move-result v4

    move/from16 v5, p1

    invoke-static {v0, v4, v5}, Llocal/mio/os4camerabridge/LegendaryM9MessagePolicy;->put([BIF)V

    .line 41
    move v4, v15

    :goto_4
    if-ge v4, v3, :cond_f

    invoke-static {v10}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v5

    invoke-interface {v2, v5}, Ljava/util/Map;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v5

    check-cast v5, Ljava/lang/Integer;

    invoke-virtual {v5}, Ljava/lang/Integer;->intValue()I

    move-result v5

    mul-int/lit8 v6, v4, 0x4

    add-int/2addr v5, v6

    aget v6, v1, v4

    invoke-static {v0, v5, v6}, Llocal/mio/os4camerabridge/LegendaryM9MessagePolicy;->put([BIF)V

    add-int/lit8 v4, v4, 0x1

    goto :goto_4

    .line 42
    :cond_f
    return-object v0

    .line 37
    :cond_10
    new-instance v0, Ljava/lang/IllegalArgumentException;

    const-string v1, "contract fields absent"

    invoke-direct {v0, v1}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw v0

    .line 11
    :cond_11
    new-instance v0, Ljava/lang/IllegalArgumentException;

    const-string v1, "missing capture contract"

    invoke-direct {v0, v1}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw v0
.end method

.method private static positive(F)Z
    .locals 1

    .line 57
    invoke-static {p0}, Ljava/lang/Float;->isFinite(F)Z

    move-result v0

    if-eqz v0, :cond_0

    const/4 v0, 0x0

    cmpl-float p0, p0, v0

    if-lez p0, :cond_0

    const/4 p0, 0x1

    goto :goto_0

    :cond_0
    const/4 p0, 0x0

    :goto_0
    return p0
.end method

.method private static put([BIF)V
    .locals 3

    .line 54
    invoke-static {p2}, Ljava/lang/Float;->floatToRawIntBits(F)I

    move-result p2

    .line 55
    const/4 v0, 0x0

    :goto_0
    const/4 v1, 0x4

    if-ge v0, v1, :cond_0

    add-int v1, p1, v0

    mul-int/lit8 v2, v0, 0x8

    ushr-int v2, p2, v2

    int-to-byte v2, v2

    aput-byte v2, p0, v1

    add-int/lit8 v0, v0, 0x1

    goto :goto_0

    .line 56
    :cond_0
    return-void
.end method

.method private static varint([B[I)J
    .locals 7

    .line 45
    nop

    .line 46
    const-wide/16 v0, 0x0

    const/4 v2, 0x0

    move v3, v2

    :goto_0
    const/16 v4, 0x40

    if-ge v3, v4, :cond_1

    aget v4, p1, v2

    array-length v5, p0

    if-ge v4, v5, :cond_1

    .line 47
    aget v4, p1, v2

    add-int/lit8 v5, v4, 0x1

    aput v5, p1, v2

    aget-byte v4, p0, v4

    and-int/lit16 v4, v4, 0xff

    .line 48
    and-int/lit8 v5, v4, 0x7f

    int-to-long v5, v5

    shl-long/2addr v5, v3

    or-long/2addr v0, v5

    .line 49
    and-int/lit16 v4, v4, 0x80

    if-nez v4, :cond_0

    return-wide v0

    .line 46
    :cond_0
    add-int/lit8 v3, v3, 0x7

    goto :goto_0

    .line 51
    :cond_1
    new-instance p0, Ljava/lang/IllegalArgumentException;

    const-string p1, "invalid varint"

    invoke-direct {p0, p1}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw p0
.end method
