.class public final Llocal/mio/os4camerabridge/LegendarySensorCalibration;
.super Ljava/lang/Object;
.source "LegendarySensorCalibration.java"


# static fields
.field private static final DAY:[F

.field private static final WARM:[F


# direct methods
.method static constructor <clinit>()V
    .locals 2

    .line 5
    const/16 v0, 0x9

    new-array v1, v0, [F

    fill-array-data v1, :array_0

    sput-object v1, Llocal/mio/os4camerabridge/LegendarySensorCalibration;->DAY:[F

    .line 6
    new-array v0, v0, [F

    fill-array-data v0, :array_1

    sput-object v0, Llocal/mio/os4camerabridge/LegendarySensorCalibration;->WARM:[F

    return-void

    nop

    :array_0
    .array-data 4
        0x3f947fc8
        0x3c18a41b
        0x3c220bc4
        -0x42dc28f6    # -0.04f
        0x3f87cb64
        0x3d10f645
        -0x42f60dce
        0x3cf8490d
        0x3f8fbde7
    .end array-data

    :array_1
    .array-data 4
        0x3f970f24
        -0x45ccd15e
        -0x471a5e31
        -0x42ba6c9b
        0x3f830120
        0x3d335d1a
        -0x433f203c
        0x3d242b05
        0x3f8c61f1
    .end array-data
.end method

.method private constructor <init>()V
    .locals 0

    .line 7
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method private static cell(IIII[F[I)V
    .locals 9

    .line 42
    invoke-static {p3}, Llocal/mio/os4camerabridge/LegendarySensorCalibration;->linear(I)F

    move-result p3

    invoke-static {p1}, Llocal/mio/os4camerabridge/LegendarySensorCalibration;->linear(I)F

    move-result p1

    invoke-static {p2}, Llocal/mio/os4camerabridge/LegendarySensorCalibration;->linear(I)F

    move-result p2

    add-float v0, p1, p2

    const/high16 v1, 0x3f000000    # 0.5f

    mul-float/2addr v0, v1

    invoke-static {p0}, Llocal/mio/os4camerabridge/LegendarySensorCalibration;->linear(I)F

    move-result p0

    .line 43
    const/4 v1, 0x0

    aget v2, p4, v1

    mul-float/2addr v2, p3

    const/4 v3, 0x1

    aget v4, p4, v3

    mul-float/2addr v4, v0

    add-float/2addr v2, v4

    const/4 v4, 0x2

    aget v5, p4, v4

    mul-float/2addr v5, p0

    add-float/2addr v2, v5

    invoke-static {v2}, Llocal/mio/os4camerabridge/LegendarySensorCalibration;->clamp(F)F

    move-result v2

    .line 44
    const/4 v5, 0x3

    aget v6, p4, v5

    mul-float/2addr v6, p3

    const/4 v7, 0x4

    aget v7, p4, v7

    mul-float/2addr v7, v0

    add-float/2addr v6, v7

    const/4 v7, 0x5

    aget v7, p4, v7

    mul-float/2addr v7, p0

    add-float/2addr v6, v7

    invoke-static {v6}, Llocal/mio/os4camerabridge/LegendarySensorCalibration;->clamp(F)F

    move-result v6

    .line 45
    const/4 v7, 0x6

    aget v7, p4, v7

    mul-float/2addr v7, p3

    const/4 p3, 0x7

    aget p3, p4, p3

    mul-float/2addr p3, v0

    add-float/2addr v7, p3

    const/16 p3, 0x8

    aget p3, p4, p3

    mul-float/2addr p3, p0

    add-float/2addr v7, p3

    invoke-static {v7}, Llocal/mio/os4camerabridge/LegendarySensorCalibration;->clamp(F)F

    move-result p0

    .line 46
    const p3, 0x2b8cbccc    # 1.0E-12f

    cmpl-float p3, v0, p3

    if-lez p3, :cond_0

    div-float/2addr v6, v0

    mul-float/2addr p1, v6

    mul-float/2addr v6, p2

    move v8, v6

    move v6, p1

    move p1, v8

    goto :goto_0

    :cond_0
    move p1, v6

    .line 47
    :goto_0
    invoke-static {p0}, Llocal/mio/os4camerabridge/LegendarySensorCalibration;->encode(F)I

    move-result p0

    aput p0, p5, v1

    invoke-static {v6}, Llocal/mio/os4camerabridge/LegendarySensorCalibration;->encode(F)I

    move-result p0

    aput p0, p5, v3

    invoke-static {p1}, Llocal/mio/os4camerabridge/LegendarySensorCalibration;->encode(F)I

    move-result p0

    aput p0, p5, v4

    invoke-static {v2}, Llocal/mio/os4camerabridge/LegendarySensorCalibration;->encode(F)I

    move-result p0

    aput p0, p5, v5

    .line 48
    return-void
.end method

.method private static clamp(F)F
    .locals 1

    .line 56
    const/high16 v0, 0x3f800000    # 1.0f

    invoke-static {v0, p0}, Ljava/lang/Math;->min(FF)F

    move-result p0

    const/4 v0, 0x0

    invoke-static {v0, p0}, Ljava/lang/Math;->max(FF)F

    move-result p0

    return p0
.end method

.method private static encode(F)I
    .locals 2

    .line 55
    invoke-static {p0}, Llocal/mio/os4camerabridge/LegendarySensorCalibration;->clamp(F)F

    move-result p0

    float-to-double v0, p0

    invoke-static {v0, v1}, Ljava/lang/Math;->sqrt(D)D

    move-result-wide v0

    double-to-float p0, v0

    const v0, 0x447fc000    # 1023.0f

    mul-float/2addr p0, v0

    invoke-static {v0, p0}, Ljava/lang/Math;->min(FF)F

    move-result p0

    float-to-int p0, p0

    return p0
.end method

.method private static linear(I)F
    .locals 1

    .line 54
    int-to-float p0, p0

    const v0, 0x3a802008

    mul-float/2addr p0, v0

    mul-float/2addr p0, p0

    return p0
.end method

.method private static read([BII)I
    .locals 1

    .line 49
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

.method public static select(I)[F
    .locals 10

    .line 9
    const/16 v0, 0x708

    if-lt p0, v0, :cond_8

    const/16 v0, 0x2ee0

    if-le p0, v0, :cond_0

    goto/16 :goto_4

    .line 10
    :cond_0
    const/16 v0, 0x1bcb

    const/high16 v1, 0x3f800000    # 1.0f

    const v2, 0x49742400    # 1000000.0f

    const/4 v3, 0x0

    if-lt p0, v0, :cond_1

    move v0, v3

    goto :goto_0

    :cond_1
    const/16 v0, 0xae3

    if-gt p0, v0, :cond_2

    move v0, v1

    goto :goto_0

    :cond_2
    int-to-float v0, p0

    div-float v0, v2, v0

    const v4, 0x430c8c53

    sub-float/2addr v0, v4

    const v4, 0x435a42b7

    div-float/2addr v0, v4

    invoke-static {v0}, Llocal/mio/os4camerabridge/LegendarySensorCalibration;->clamp(F)F

    move-result v0

    .line 11
    :goto_0
    const/16 v4, 0x9

    new-array v5, v4, [F

    .line 12
    const/4 v6, 0x0

    :goto_1
    if-ge v6, v4, :cond_3

    sget-object v7, Llocal/mio/os4camerabridge/LegendarySensorCalibration;->DAY:[F

    aget v7, v7, v6

    sget-object v8, Llocal/mio/os4camerabridge/LegendarySensorCalibration;->WARM:[F

    aget v8, v8, v6

    sget-object v9, Llocal/mio/os4camerabridge/LegendarySensorCalibration;->DAY:[F

    aget v9, v9, v6

    sub-float/2addr v8, v9

    mul-float/2addr v8, v0

    add-float/2addr v7, v8

    aput v7, v5, v6

    add-int/lit8 v6, v6, 0x1

    goto :goto_1

    .line 13
    :cond_3
    int-to-float p0, p0

    div-float/2addr v2, p0

    .line 14
    const p0, 0x43404ec5

    cmpg-float v0, v2, p0

    if-lez v0, :cond_7

    const v0, 0x438ae38e

    cmpl-float v4, v2, v0

    if-ltz v4, :cond_4

    goto :goto_2

    .line 15
    :cond_4
    const v3, 0x435e38e4

    cmpl-float v4, v2, v3

    if-ltz v4, :cond_5

    const v4, 0x4373e706

    cmpg-float v4, v2, v4

    if-gtz v4, :cond_5

    goto :goto_3

    .line 16
    :cond_5
    cmpg-float v1, v2, v3

    if-gez v1, :cond_6

    sub-float/2addr v2, p0

    const p0, 0x41ef50f8

    div-float/2addr v2, p0

    invoke-static {v2}, Llocal/mio/os4camerabridge/LegendarySensorCalibration;->smooth(F)F

    move-result v1

    goto :goto_3

    .line 17
    :cond_6
    sub-float/2addr v0, v2

    const p0, 0x42078058

    div-float/2addr v0, p0

    invoke-static {v0}, Llocal/mio/os4camerabridge/LegendarySensorCalibration;->smooth(F)F

    move-result v1

    goto :goto_3

    .line 14
    :cond_7
    :goto_2
    move v1, v3

    .line 18
    :goto_3
    const/4 p0, 0x3

    aget v0, v5, p0

    const v2, 0x3c23d70a    # 0.01f

    mul-float/2addr v2, v1

    add-float/2addr v0, v2

    aput v0, v5, p0

    const/4 p0, 0x4

    aget v0, v5, p0

    const v3, 0x3ca3d70a    # 0.02f

    mul-float/2addr v1, v3

    sub-float/2addr v0, v1

    aput v0, v5, p0

    const/4 p0, 0x5

    aget v0, v5, p0

    add-float/2addr v0, v2

    aput v0, v5, p0

    .line 19
    return-object v5

    .line 9
    :cond_8
    :goto_4
    const/4 p0, 0x0

    return-object p0
.end method

.method private static smooth(F)F
    .locals 2

    .line 57
    invoke-static {p0}, Llocal/mio/os4camerabridge/LegendarySensorCalibration;->clamp(F)F

    move-result p0

    mul-float v0, p0, p0

    const/high16 v1, 0x40000000    # 2.0f

    mul-float/2addr p0, v1

    const/high16 v1, 0x40400000    # 3.0f

    sub-float/2addr v1, p0

    mul-float/2addr v0, v1

    return v0
.end method

.method public static transform([BIII[F)J
    .locals 23

    .line 23
    move-object/from16 v0, p0

    move/from16 v6, p2

    move/from16 v7, p3

    move-object/from16 v12, p4

    if-eqz v0, :cond_a

    if-lez p1, :cond_a

    if-lez v6, :cond_a

    and-int/lit8 v1, p1, 0x3

    if-nez v1, :cond_a

    and-int/lit8 v1, v6, 0x1

    if-nez v1, :cond_a

    mul-int/lit8 v1, p1, 0x5

    const/4 v2, 0x4

    div-int/lit8 v14, v1, 0x4

    if-lt v7, v14, :cond_a

    int-to-long v3, v7

    int-to-long v8, v6

    mul-long/2addr v3, v8

    array-length v1, v0

    int-to-long v8, v1

    cmp-long v1, v3, v8

    if-nez v1, :cond_a

    if-eqz v12, :cond_a

    array-length v1, v12

    const/16 v3, 0x9

    if-ne v1, v3, :cond_a

    .line 26
    array-length v1, v12

    const/4 v3, 0x0

    :goto_0
    if-ge v3, v1, :cond_1

    aget v4, v12, v3

    invoke-static {v4}, Ljava/lang/Float;->isFinite(F)Z

    move-result v4

    if-eqz v4, :cond_0

    add-int/lit8 v3, v3, 0x1

    goto :goto_0

    :cond_0
    new-instance v0, Ljava/lang/IllegalArgumentException;

    const-string v1, "Non-finite matrix"

    invoke-direct {v0, v1}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw v0

    .line 27
    :cond_1
    new-array v1, v2, [I

    new-array v2, v2, [I

    .line 28
    const-wide/16 v3, 0x0

    const/4 v5, 0x0

    :goto_1
    if-ge v5, v6, :cond_9

    const/4 v8, 0x0

    :goto_2
    if-ge v8, v14, :cond_8

    .line 29
    mul-int v9, v5, v7

    add-int/2addr v9, v8

    add-int v10, v9, v7

    .line 30
    move-wide/from16 v16, v3

    const/4 v3, 0x0

    :goto_3
    const/16 v18, 0x3

    const/4 v4, 0x2

    const/16 v19, 0x1

    if-ge v3, v4, :cond_7

    .line 31
    mul-int/lit8 v11, v3, 0x2

    move v13, v8

    invoke-static {v0, v9, v11}, Llocal/mio/os4camerabridge/LegendarySensorCalibration;->read([BII)I

    move-result v8

    move/from16 p1, v4

    add-int/lit8 v4, v11, 0x1

    move v15, v9

    const/16 v20, 0x0

    invoke-static {v0, v15, v4}, Llocal/mio/os4camerabridge/LegendarySensorCalibration;->read([BII)I

    move-result v9

    invoke-static {v0, v10, v11}, Llocal/mio/os4camerabridge/LegendarySensorCalibration;->read([BII)I

    move-result v11

    invoke-static {v0, v10, v4}, Llocal/mio/os4camerabridge/LegendarySensorCalibration;->read([BII)I

    move-result v4

    .line 32
    move/from16 v21, v13

    if-nez v3, :cond_2

    move-object v13, v1

    goto :goto_4

    :cond_2
    move-object v13, v2

    .line 33
    :goto_4
    move/from16 v22, v10

    move v10, v11

    move v11, v4

    invoke-static/range {v8 .. v13}, Llocal/mio/os4camerabridge/LegendarySensorCalibration;->cell(IIII[F[I)V

    .line 34
    aget v4, v13, v20

    if-ne v8, v4, :cond_3

    move/from16 v4, v20

    goto :goto_5

    :cond_3
    move/from16 v4, v19

    :goto_5
    aget v8, v13, v19

    if-ne v9, v8, :cond_4

    move/from16 v8, v20

    goto :goto_6

    :cond_4
    move/from16 v8, v19

    :goto_6
    add-int/2addr v4, v8

    aget v8, v13, p1

    if-ne v10, v8, :cond_5

    move/from16 v8, v20

    goto :goto_7

    :cond_5
    move/from16 v8, v19

    :goto_7
    add-int/2addr v4, v8

    aget v8, v13, v18

    if-ne v11, v8, :cond_6

    move/from16 v19, v20

    :cond_6
    add-int v4, v4, v19

    int-to-long v8, v4

    add-long v16, v16, v8

    .line 30
    add-int/lit8 v3, v3, 0x1

    move-object/from16 v12, p4

    move v9, v15

    move/from16 v8, v21

    move/from16 v10, v22

    goto :goto_3

    .line 36
    :cond_7
    move/from16 p1, v4

    move/from16 v21, v8

    move v15, v9

    move/from16 v22, v10

    const/16 v20, 0x0

    move-object v3, v2

    aget v2, v1, v20

    move-object v4, v3

    aget v3, v1, v19

    move-object v8, v4

    aget v4, v8, v20

    aget v9, v8, v19

    move-object v10, v8

    move-object v8, v1

    move v1, v15

    move v15, v5

    move v5, v9

    move-object v9, v10

    move/from16 v10, p1

    invoke-static/range {v0 .. v5}, Llocal/mio/os4camerabridge/LegendarySensorCalibration;->write([BIIIII)V

    .line 37
    aget v2, v8, v10

    aget v3, v8, v18

    aget v4, v9, v10

    aget v5, v9, v18

    move-object/from16 v0, p0

    move/from16 v1, v22

    invoke-static/range {v0 .. v5}, Llocal/mio/os4camerabridge/LegendarySensorCalibration;->write([BIIIII)V

    .line 28
    add-int/lit8 v0, v21, 0x5

    move-object/from16 v12, p4

    move-object v1, v8

    move-object v2, v9

    move v5, v15

    move-wide/from16 v3, v16

    move v8, v0

    move-object/from16 v0, p0

    goto/16 :goto_2

    :cond_8
    move-object v8, v1

    move-object v9, v2

    move v15, v5

    const/16 v20, 0x0

    add-int/lit8 v5, v15, 0x2

    move-object/from16 v0, p0

    move-object/from16 v12, p4

    goto/16 :goto_1

    .line 39
    :cond_9
    return-wide v3

    .line 25
    :cond_a
    new-instance v0, Ljava/lang/IllegalArgumentException;

    const-string v1, "Invalid cloud RAW geometry/matrix"

    invoke-direct {v0, v1}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw v0
.end method

.method private static write([BIIIII)V
    .locals 2

    .line 51
    ushr-int/lit8 v0, p2, 0x2

    int-to-byte v0, v0

    aput-byte v0, p0, p1

    add-int/lit8 v0, p1, 0x1

    ushr-int/lit8 v1, p3, 0x2

    int-to-byte v1, v1

    aput-byte v1, p0, v0

    add-int/lit8 v0, p1, 0x2

    ushr-int/lit8 v1, p4, 0x2

    int-to-byte v1, v1

    aput-byte v1, p0, v0

    add-int/lit8 v0, p1, 0x3

    ushr-int/lit8 v1, p5, 0x2

    int-to-byte v1, v1

    aput-byte v1, p0, v0

    .line 52
    add-int/lit8 p1, p1, 0x4

    and-int/lit8 p2, p2, 0x3

    and-int/lit8 p3, p3, 0x3

    shl-int/lit8 p3, p3, 0x2

    or-int/2addr p2, p3

    and-int/lit8 p3, p4, 0x3

    shl-int/lit8 p3, p3, 0x4

    or-int/2addr p2, p3

    and-int/lit8 p3, p5, 0x3

    shl-int/lit8 p3, p3, 0x6

    or-int/2addr p2, p3

    int-to-byte p2, p2

    aput-byte p2, p0, p1

    .line 53
    return-void
.end method
