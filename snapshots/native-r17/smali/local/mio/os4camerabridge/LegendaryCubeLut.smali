.class public final Llocal/mio/os4camerabridge/LegendaryCubeLut;
.super Ljava/lang/Object;
.source "LegendaryCubeLut.java"


# instance fields
.field private final fraction:[[F

.field private final lower:[[I

.field private final size:I

.field private final values:[F


# direct methods
.method private constructor <init>(I[F[F[F)V
    .locals 8

    .line 14
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 11
    const/4 v0, 0x2

    new-array v1, v0, [I

    const/4 v2, 0x1

    const/16 v3, 0x100

    aput v3, v1, v2

    const/4 v4, 0x0

    const/4 v5, 0x3

    aput v5, v1, v4

    sget-object v6, Ljava/lang/Integer;->TYPE:Ljava/lang/Class;

    invoke-static {v6, v1}, Ljava/lang/reflect/Array;->newInstance(Ljava/lang/Class;[I)Ljava/lang/Object;

    move-result-object v1

    check-cast v1, [[I

    iput-object v1, p0, Llocal/mio/os4camerabridge/LegendaryCubeLut;->lower:[[I

    .line 12
    new-array v1, v0, [I

    aput v3, v1, v2

    aput v5, v1, v4

    sget-object v2, Ljava/lang/Float;->TYPE:Ljava/lang/Class;

    invoke-static {v2, v1}, Ljava/lang/reflect/Array;->newInstance(Ljava/lang/Class;[I)Ljava/lang/Object;

    move-result-object v1

    check-cast v1, [[F

    iput-object v1, p0, Llocal/mio/os4camerabridge/LegendaryCubeLut;->fraction:[[F

    .line 15
    iput p1, p0, Llocal/mio/os4camerabridge/LegendaryCubeLut;->size:I

    .line 16
    iput-object p2, p0, Llocal/mio/os4camerabridge/LegendaryCubeLut;->values:[F

    .line 17
    move p2, v4

    :goto_0
    if-ge p2, v5, :cond_1

    .line 18
    move v1, v4

    :goto_1
    if-ge v1, v3, :cond_0

    .line 19
    int-to-float v2, v1

    const/high16 v6, 0x437f0000    # 255.0f

    div-float/2addr v2, v6

    aget v6, p3, p2

    sub-float/2addr v2, v6

    aget v6, p4, p2

    aget v7, p3, p2

    sub-float/2addr v6, v7

    div-float/2addr v2, v6

    const/high16 v6, 0x3f800000    # 1.0f

    invoke-static {v6, v2}, Ljava/lang/Math;->min(FF)F

    move-result v2

    const/4 v6, 0x0

    invoke-static {v6, v2}, Ljava/lang/Math;->max(FF)F

    move-result v2

    add-int/lit8 v6, p1, -0x1

    int-to-float v6, v6

    mul-float/2addr v2, v6

    .line 21
    add-int/lit8 v6, p1, -0x2

    float-to-int v7, v2

    invoke-static {v6, v7}, Ljava/lang/Math;->min(II)I

    move-result v6

    .line 22
    iget-object v7, p0, Llocal/mio/os4camerabridge/LegendaryCubeLut;->lower:[[I

    aget-object v7, v7, p2

    aput v6, v7, v1

    .line 23
    iget-object v7, p0, Llocal/mio/os4camerabridge/LegendaryCubeLut;->fraction:[[F

    aget-object v7, v7, p2

    int-to-float v6, v6

    sub-float/2addr v2, v6

    aput v2, v7, v1

    .line 18
    add-int/lit8 v1, v1, 0x1

    goto :goto_1

    .line 17
    :cond_0
    add-int/lit8 p2, p2, 0x1

    goto :goto_0

    .line 26
    :cond_1
    return-void
.end method

.method private static finite(Ljava/lang/String;)F
    .locals 2

    .line 81
    invoke-static {p0}, Ljava/lang/Float;->parseFloat(Ljava/lang/String;)F

    move-result p0

    .line 82
    invoke-static {p0}, Ljava/lang/Float;->isFinite(F)Z

    move-result v0

    if-eqz v0, :cond_0

    invoke-static {p0}, Ljava/lang/Math;->abs(F)F

    move-result v0

    const v1, 0x477fe000    # 65504.0f

    cmpl-float v0, v0, v1

    if-gtz v0, :cond_0

    .line 84
    return p0

    .line 83
    :cond_0
    new-instance p0, Ljava/lang/IllegalArgumentException;

    const-string v0, "Nonfinite or unbounded value"

    invoke-direct {p0, v0}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw p0
.end method

.method private static mix(FFF)F
    .locals 0

    .line 113
    sub-float/2addr p1, p0

    mul-float/2addr p1, p2

    add-float/2addr p0, p1

    return p0
.end method

.method public static read(Ljava/io/Reader;)Llocal/mio/os4camerabridge/LegendaryCubeLut;
    .locals 19
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .line 29
    const-string v0, "DOMAIN_MIN"

    new-instance v1, Ljava/io/BufferedReader;

    move-object/from16 v2, p0

    invoke-direct {v1, v2}, Ljava/io/BufferedReader;-><init>(Ljava/io/Reader;)V

    .line 30
    const/4 v2, 0x3

    new-array v3, v2, [F

    const/4 v4, 0x0

    const/4 v5, 0x0

    aput v5, v3, v4

    const/4 v6, 0x1

    aput v5, v3, v6

    const/4 v7, 0x2

    aput v5, v3, v7

    new-array v5, v2, [F

    const/high16 v8, 0x3f800000    # 1.0f

    aput v8, v5, v4

    aput v8, v5, v6

    aput v8, v5, v7

    .line 31
    nop

    .line 32
    const/4 v8, 0x0

    move v9, v4

    move v10, v9

    move v11, v10

    move v12, v11

    move v13, v12

    move v14, v13

    .line 34
    :goto_0
    invoke-virtual {v1}, Ljava/io/BufferedReader;->readLine()Ljava/lang/String;

    move-result-object v15

    if-eqz v15, :cond_12

    .line 35
    add-int/2addr v9, v6

    .line 36
    if-ne v9, v6, :cond_0

    move/from16 p0, v2

    const-string v2, "\ufeff"

    invoke-virtual {v15, v2}, Ljava/lang/String;->startsWith(Ljava/lang/String;)Z

    move-result v2

    if-eqz v2, :cond_1

    invoke-virtual {v15, v6}, Ljava/lang/String;->substring(I)Ljava/lang/String;

    move-result-object v15

    goto :goto_1

    :cond_0
    move/from16 p0, v2

    .line 37
    :cond_1
    :goto_1
    const/16 v2, 0x23

    invoke-virtual {v15, v2}, Ljava/lang/String;->indexOf(I)I

    move-result v2

    .line 38
    if-ltz v2, :cond_2

    invoke-virtual {v15, v4, v2}, Ljava/lang/String;->substring(II)Ljava/lang/String;

    move-result-object v15

    .line 39
    :cond_2
    invoke-virtual {v15}, Ljava/lang/String;->trim()Ljava/lang/String;

    move-result-object v2

    .line 40
    invoke-virtual {v2}, Ljava/lang/String;->isEmpty()Z

    move-result v15

    if-eqz v15, :cond_3

    move/from16 v16, v4

    goto :goto_2

    .line 41
    :cond_3
    const-string v15, "\\s+"

    invoke-virtual {v2, v15}, Ljava/lang/String;->split(Ljava/lang/String;)[Ljava/lang/String;

    move-result-object v2

    .line 43
    :try_start_0
    aget-object v15, v2, v4

    move/from16 v16, v4

    const-string v4, "TITLE"

    invoke-virtual {v15, v4}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v4

    if-eqz v4, :cond_5

    .line 44
    if-nez v12, :cond_4

    .line 45
    nop

    .line 34
    :goto_2
    move/from16 v2, p0

    move/from16 v4, v16

    goto :goto_0

    .line 44
    :cond_4
    new-instance v0, Ljava/lang/IllegalArgumentException;

    const-string v1, "Late TITLE"

    invoke-direct {v0, v1}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw v0

    .line 47
    :cond_5
    aget-object v4, v2, v16

    const-string v15, "LUT_3D_SIZE"

    invoke-virtual {v4, v15}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v4

    if-eqz v4, :cond_8

    .line 48
    array-length v4, v2

    if-ne v4, v7, :cond_7

    if-nez v11, :cond_7

    if-nez v12, :cond_7

    .line 50
    aget-object v2, v2, v6

    invoke-static {v2}, Ljava/lang/Integer;->parseInt(Ljava/lang/String;)I

    move-result v11

    .line 51
    if-lt v11, v7, :cond_6

    const/16 v2, 0x41

    if-gt v11, v2, :cond_6

    .line 52
    mul-int v2, v11, v11

    mul-int/2addr v2, v11

    mul-int/lit8 v2, v2, 0x3

    new-array v8, v2, [F

    .line 53
    move/from16 v2, p0

    move/from16 v4, v16

    goto :goto_0

    .line 51
    :cond_6
    new-instance v0, Ljava/lang/IllegalArgumentException;

    const-string v1, "Unsupported grid size"

    invoke-direct {v0, v1}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw v0

    .line 49
    :cond_7
    new-instance v0, Ljava/lang/IllegalArgumentException;

    const-string v1, "Duplicate/invalid size"

    invoke-direct {v0, v1}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw v0

    .line 55
    :cond_8
    aget-object v4, v2, v16

    invoke-virtual {v4, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v4

    if-nez v4, :cond_c

    aget-object v4, v2, v16

    const-string v15, "DOMAIN_MAX"

    invoke-virtual {v4, v15}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v4

    if-eqz v4, :cond_9

    goto :goto_4

    .line 64
    :cond_9
    if-eqz v8, :cond_b

    array-length v4, v2

    move/from16 v12, p0

    if-ne v4, v12, :cond_b

    add-int/lit8 v4, v10, 0x3

    array-length v12, v8

    if-gt v4, v12, :cond_b

    .line 66
    array-length v4, v2

    move/from16 v12, v16

    :goto_3
    if-ge v12, v4, :cond_a

    aget-object v15, v2, v12

    add-int/lit8 v17, v10, 0x1

    invoke-static {v15}, Llocal/mio/os4camerabridge/LegendaryCubeLut;->finite(Ljava/lang/String;)F

    move-result v15

    aput v15, v8, v10

    add-int/lit8 v12, v12, 0x1

    move/from16 v10, v17

    goto :goto_3

    .line 67
    :cond_a
    nop

    .line 70
    nop

    .line 71
    move v12, v6

    move/from16 v4, v16

    const/4 v2, 0x3

    goto/16 :goto_0

    .line 65
    :cond_b
    new-instance v0, Ljava/lang/IllegalArgumentException;

    const-string v1, "Invalid or excess data"

    invoke-direct {v0, v1}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw v0

    .line 56
    :cond_c
    :goto_4
    aget-object v4, v2, v16

    invoke-virtual {v4, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v4

    .line 57
    array-length v15, v2

    const/4 v6, 0x4

    if-ne v15, v6, :cond_11

    if-nez v12, :cond_11

    if-eqz v4, :cond_d

    if-nez v14, :cond_11

    goto :goto_5

    :cond_d
    if-nez v13, :cond_11

    .line 59
    :goto_5
    if-eqz v4, :cond_e

    move-object v6, v3

    goto :goto_6

    :cond_e
    move-object v6, v5

    .line 60
    :goto_6
    move/from16 v15, v16

    :goto_7
    const/4 v7, 0x3

    if-ge v15, v7, :cond_f

    add-int/lit8 v7, v15, 0x1

    aget-object v18, v2, v7

    invoke-static/range {v18 .. v18}, Llocal/mio/os4camerabridge/LegendaryCubeLut;->finite(Ljava/lang/String;)F

    move-result v18

    aput v18, v6, v15

    move v15, v7

    const/4 v7, 0x2

    goto :goto_7

    .line 61
    :cond_f
    if-eqz v4, :cond_10

    const/4 v14, 0x1

    goto :goto_8

    :cond_10
    const/4 v13, 0x1

    .line 62
    :goto_8
    move/from16 v4, v16

    const/4 v2, 0x3

    const/4 v6, 0x1

    const/4 v7, 0x2

    goto/16 :goto_0

    .line 58
    :cond_11
    new-instance v0, Ljava/lang/IllegalArgumentException;

    const-string v1, "Duplicate/late/invalid domain"

    invoke-direct {v0, v1}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw v0
    :try_end_0
    .catch Ljava/lang/IllegalArgumentException; {:try_start_0 .. :try_end_0} :catch_0

    .line 68
    :catch_0
    move-exception v0

    .line 69
    new-instance v1, Ljava/io/IOException;

    invoke-virtual {v0}, Ljava/lang/IllegalArgumentException;->getMessage()Ljava/lang/String;

    move-result-object v2

    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    const-string v4, "Invalid cube line "

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3, v9}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v3

    const-string v4, ": "

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-direct {v1, v2, v0}, Ljava/io/IOException;-><init>(Ljava/lang/String;Ljava/lang/Throwable;)V

    throw v1

    .line 72
    :cond_12
    move/from16 v16, v4

    if-eqz v8, :cond_15

    array-length v0, v8

    if-ne v10, v0, :cond_15

    .line 73
    move/from16 v4, v16

    :goto_9
    const/4 v7, 0x3

    if-ge v4, v7, :cond_14

    .line 74
    aget v0, v5, v4

    aget v1, v3, v4

    cmpl-float v0, v0, v1

    if-lez v0, :cond_13

    aget v0, v5, v4

    aget v1, v3, v4

    sub-float/2addr v0, v1

    invoke-static {v0}, Ljava/lang/Float;->isFinite(F)Z

    move-result v0

    if-eqz v0, :cond_13

    .line 73
    add-int/lit8 v4, v4, 0x1

    goto :goto_9

    .line 75
    :cond_13
    new-instance v0, Ljava/io/IOException;

    const-string v1, "Invalid domain span"

    invoke-direct {v0, v1}, Ljava/io/IOException;-><init>(Ljava/lang/String;)V

    throw v0

    .line 77
    :cond_14
    new-instance v0, Llocal/mio/os4camerabridge/LegendaryCubeLut;

    invoke-direct {v0, v11, v8, v3, v5}, Llocal/mio/os4camerabridge/LegendaryCubeLut;-><init>(I[F[F[F)V

    return-object v0

    .line 72
    :cond_15
    new-instance v0, Ljava/io/IOException;

    const-string v1, "Incomplete LUT"

    invoke-direct {v0, v1}, Ljava/io/IOException;-><init>(Ljava/lang/String;)V

    throw v0
.end method


# virtual methods
.method public gridSize()I
    .locals 1

    .line 87
    iget v0, p0, Llocal/mio/os4camerabridge/LegendaryCubeLut;->size:I

    return v0
.end method

.method public mapArgb(I)I
    .locals 13

    .line 90
    ushr-int/lit8 v0, p1, 0x10

    and-int/lit16 v0, v0, 0xff

    ushr-int/lit8 v1, p1, 0x8

    and-int/lit16 v1, v1, 0xff

    and-int/lit16 v2, p1, 0xff

    .line 91
    iget-object v3, p0, Llocal/mio/os4camerabridge/LegendaryCubeLut;->lower:[[I

    const/4 v4, 0x0

    aget-object v3, v3, v4

    aget v3, v3, v0

    iget v5, p0, Llocal/mio/os4camerabridge/LegendaryCubeLut;->size:I

    iget-object v6, p0, Llocal/mio/os4camerabridge/LegendaryCubeLut;->lower:[[I

    const/4 v7, 0x1

    aget-object v6, v6, v7

    aget v6, v6, v1

    iget v8, p0, Llocal/mio/os4camerabridge/LegendaryCubeLut;->size:I

    iget-object v9, p0, Llocal/mio/os4camerabridge/LegendaryCubeLut;->lower:[[I

    const/4 v10, 0x2

    aget-object v9, v9, v10

    aget v9, v9, v2

    mul-int/2addr v8, v9

    add-int/2addr v6, v8

    mul-int/2addr v5, v6

    add-int/2addr v3, v5

    const/4 v5, 0x3

    mul-int/2addr v3, v5

    .line 92
    iget-object v6, p0, Llocal/mio/os4camerabridge/LegendaryCubeLut;->fraction:[[F

    aget-object v6, v6, v4

    aget v0, v6, v0

    iget-object v6, p0, Llocal/mio/os4camerabridge/LegendaryCubeLut;->fraction:[[F

    aget-object v6, v6, v7

    aget v1, v6, v1

    iget-object v6, p0, Llocal/mio/os4camerabridge/LegendaryCubeLut;->fraction:[[F

    aget-object v6, v6, v10

    aget v2, v6, v2

    .line 93
    const/high16 v6, -0x1000000

    and-int/2addr p1, v6

    .line 94
    nop

    :goto_0
    if-ge v4, v5, :cond_0

    .line 95
    add-int v6, v3, v4

    .line 96
    iget v7, p0, Llocal/mio/os4camerabridge/LegendaryCubeLut;->size:I

    mul-int/2addr v7, v5

    iget v8, p0, Llocal/mio/os4camerabridge/LegendaryCubeLut;->size:I

    iget v9, p0, Llocal/mio/os4camerabridge/LegendaryCubeLut;->size:I

    mul-int/2addr v8, v9

    mul-int/2addr v8, v5

    .line 97
    iget-object v9, p0, Llocal/mio/os4camerabridge/LegendaryCubeLut;->values:[F

    aget v9, v9, v6

    iget-object v10, p0, Llocal/mio/os4camerabridge/LegendaryCubeLut;->values:[F

    add-int/lit8 v11, v6, 0x3

    aget v10, v10, v11

    invoke-static {v9, v10, v0}, Llocal/mio/os4camerabridge/LegendaryCubeLut;->mix(FFF)F

    move-result v9

    iget-object v10, p0, Llocal/mio/os4camerabridge/LegendaryCubeLut;->values:[F

    add-int v11, v6, v7

    aget v10, v10, v11

    iget-object v12, p0, Llocal/mio/os4camerabridge/LegendaryCubeLut;->values:[F

    add-int/2addr v11, v5

    aget v11, v12, v11

    .line 98
    invoke-static {v10, v11, v0}, Llocal/mio/os4camerabridge/LegendaryCubeLut;->mix(FFF)F

    move-result v10

    .line 97
    invoke-static {v9, v10, v1}, Llocal/mio/os4camerabridge/LegendaryCubeLut;->mix(FFF)F

    move-result v9

    .line 99
    iget-object v10, p0, Llocal/mio/os4camerabridge/LegendaryCubeLut;->values:[F

    add-int/2addr v6, v8

    aget v8, v10, v6

    iget-object v10, p0, Llocal/mio/os4camerabridge/LegendaryCubeLut;->values:[F

    add-int/lit8 v11, v6, 0x3

    aget v10, v10, v11

    invoke-static {v8, v10, v0}, Llocal/mio/os4camerabridge/LegendaryCubeLut;->mix(FFF)F

    move-result v8

    iget-object v10, p0, Llocal/mio/os4camerabridge/LegendaryCubeLut;->values:[F

    add-int/2addr v6, v7

    aget v7, v10, v6

    iget-object v10, p0, Llocal/mio/os4camerabridge/LegendaryCubeLut;->values:[F

    add-int/2addr v6, v5

    aget v6, v10, v6

    .line 100
    invoke-static {v7, v6, v0}, Llocal/mio/os4camerabridge/LegendaryCubeLut;->mix(FFF)F

    move-result v6

    .line 99
    invoke-static {v8, v6, v1}, Llocal/mio/os4camerabridge/LegendaryCubeLut;->mix(FFF)F

    move-result v6

    .line 101
    const/high16 v7, 0x3f800000    # 1.0f

    invoke-static {v9, v6, v2}, Llocal/mio/os4camerabridge/LegendaryCubeLut;->mix(FFF)F

    move-result v6

    invoke-static {v7, v6}, Ljava/lang/Math;->min(FF)F

    move-result v6

    const/4 v7, 0x0

    invoke-static {v7, v6}, Ljava/lang/Math;->max(FF)F

    move-result v6

    const/high16 v7, 0x437f0000    # 255.0f

    mul-float/2addr v6, v7

    invoke-static {v6}, Ljava/lang/Math;->round(F)I

    move-result v6

    .line 102
    mul-int/lit8 v7, v4, 0x8

    rsub-int/lit8 v7, v7, 0x10

    shl-int/2addr v6, v7

    or-int/2addr p1, v6

    .line 94
    add-int/lit8 v4, v4, 0x1

    goto :goto_0

    .line 104
    :cond_0
    return p1
.end method

.method public mapArgb([III)V
    .locals 2

    .line 108
    if-eqz p1, :cond_1

    if-ltz p2, :cond_1

    if-ltz p3, :cond_1

    array-length v0, p1

    sub-int/2addr v0, p3

    if-gt p2, v0, :cond_1

    .line 110
    move v0, p2

    :goto_0
    add-int v1, p2, p3

    if-ge v0, v1, :cond_0

    aget v1, p1, v0

    invoke-virtual {p0, v1}, Llocal/mio/os4camerabridge/LegendaryCubeLut;->mapArgb(I)I

    move-result v1

    aput v1, p1, v0

    add-int/lit8 v0, v0, 0x1

    goto :goto_0

    .line 111
    :cond_0
    return-void

    .line 109
    :cond_1
    new-instance p1, Ljava/lang/IllegalArgumentException;

    const-string p2, "Invalid pixel range"

    invoke-direct {p1, p2}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw p1
.end method
