.class public final Llocal/mio/os4camerabridge/JpegWatermarkMetadataPolicy;
.super Ljava/lang/Object;
.source "JpegWatermarkMetadataPolicy.java"


# static fields
.field static final SHOOTING_TAGS:[Ljava/lang/String;


# direct methods
.method static constructor <clinit>()V
    .locals 23

    .line 7
    const-string v21, "SceneCaptureType"

    const-string v22, "DigitalZoomRatio"

    const-string v1, "ExposureTime"

    const-string v2, "FNumber"

    const-string v3, "ExposureProgram"

    const-string v4, "ISOSpeedRatings"

    const-string v5, "PhotographicSensitivity"

    const-string v6, "SensitivityType"

    const-string v7, "StandardOutputSensitivity"

    const-string v8, "RecommendedExposureIndex"

    const-string v9, "ShutterSpeedValue"

    const-string v10, "ApertureValue"

    const-string v11, "BrightnessValue"

    const-string v12, "ExposureBiasValue"

    const-string v13, "MaxApertureValue"

    const-string v14, "MeteringMode"

    const-string v15, "LightSource"

    const-string v16, "Flash"

    const-string v17, "FocalLength"

    const-string v18, "FocalLengthIn35mmFilm"

    const-string v19, "WhiteBalance"

    const-string v20, "ExposureMode"

    filled-new-array/range {v1 .. v22}, [Ljava/lang/String;

    move-result-object v0

    sput-object v0, Llocal/mio/os4camerabridge/JpegWatermarkMetadataPolicy;->SHOOTING_TAGS:[Ljava/lang/String;

    return-void
.end method

.method private constructor <init>()V
    .locals 0

    .line 5
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method static dimensions([B)[I
    .locals 11

    .line 28
    const/4 v0, 0x0

    if-eqz p0, :cond_12

    array-length v1, p0

    const/4 v2, 0x4

    if-lt v1, v2, :cond_12

    const/4 v1, 0x0

    aget-byte v2, p0, v1

    invoke-static {v2}, Llocal/mio/os4camerabridge/JpegWatermarkMetadataPolicy;->u(B)I

    move-result v2

    const/16 v3, 0xff

    if-ne v2, v3, :cond_12

    const/4 v2, 0x1

    aget-byte v4, p0, v2

    invoke-static {v4}, Llocal/mio/os4camerabridge/JpegWatermarkMetadataPolicy;->u(B)I

    move-result v4

    const/16 v5, 0xd8

    if-eq v4, v5, :cond_0

    goto/16 :goto_6

    .line 30
    :cond_0
    const/4 v4, 0x2

    move v6, v4

    .line 31
    :cond_1
    :goto_0
    array-length v7, p0

    if-ge v6, v7, :cond_11

    .line 32
    add-int/lit8 v7, v6, 0x1

    aget-byte v6, p0, v6

    invoke-static {v6}, Llocal/mio/os4camerabridge/JpegWatermarkMetadataPolicy;->u(B)I

    move-result v6

    if-eq v6, v3, :cond_2

    return-object v0

    .line 33
    :cond_2
    :goto_1
    array-length v6, p0

    if-ge v7, v6, :cond_3

    aget-byte v6, p0, v7

    invoke-static {v6}, Llocal/mio/os4camerabridge/JpegWatermarkMetadataPolicy;->u(B)I

    move-result v6

    if-ne v6, v3, :cond_3

    add-int/lit8 v7, v7, 0x1

    goto :goto_1

    .line 34
    :cond_3
    array-length v6, p0

    if-lt v7, v6, :cond_4

    return-object v0

    .line 35
    :cond_4
    add-int/lit8 v6, v7, 0x1

    aget-byte v7, p0, v7

    invoke-static {v7}, Llocal/mio/os4camerabridge/JpegWatermarkMetadataPolicy;->u(B)I

    move-result v7

    .line 36
    if-eqz v7, :cond_10

    if-eq v7, v5, :cond_10

    const/16 v8, 0xd9

    if-eq v7, v8, :cond_10

    const/16 v8, 0xda

    if-ne v7, v8, :cond_5

    goto/16 :goto_5

    .line 37
    :cond_5
    if-eq v7, v2, :cond_1

    const/16 v8, 0xd0

    if-lt v7, v8, :cond_6

    const/16 v8, 0xd7

    if-gt v7, v8, :cond_6

    goto :goto_0

    .line 38
    :cond_6
    add-int/lit8 v8, v6, 0x2

    array-length v9, p0

    if-le v8, v9, :cond_7

    return-object v0

    .line 39
    :cond_7
    aget-byte v8, p0, v6

    invoke-static {v8}, Llocal/mio/os4camerabridge/JpegWatermarkMetadataPolicy;->u(B)I

    move-result v8

    const/16 v9, 0x8

    shl-int/2addr v8, v9

    add-int/lit8 v10, v6, 0x1

    aget-byte v10, p0, v10

    invoke-static {v10}, Llocal/mio/os4camerabridge/JpegWatermarkMetadataPolicy;->u(B)I

    move-result v10

    or-int/2addr v8, v10

    .line 40
    if-lt v8, v4, :cond_f

    array-length v10, p0

    sub-int/2addr v10, v6

    if-le v8, v10, :cond_8

    goto :goto_4

    .line 41
    :cond_8
    const/16 v10, 0xc0

    if-lt v7, v10, :cond_9

    const/16 v10, 0xcf

    if-gt v7, v10, :cond_9

    const/16 v10, 0xc4

    if-eq v7, v10, :cond_9

    const/16 v10, 0xc8

    if-eq v7, v10, :cond_9

    const/16 v10, 0xcc

    if-eq v7, v10, :cond_9

    move v7, v2

    goto :goto_2

    :cond_9
    move v7, v1

    .line 43
    :goto_2
    if-eqz v7, :cond_e

    .line 44
    if-ge v8, v9, :cond_a

    return-object v0

    .line 45
    :cond_a
    add-int/lit8 v3, v6, 0x7

    aget-byte v3, p0, v3

    invoke-static {v3}, Llocal/mio/os4camerabridge/JpegWatermarkMetadataPolicy;->u(B)I

    move-result v3

    .line 46
    if-lt v3, v2, :cond_d

    mul-int/lit8 v3, v3, 0x3

    add-int/2addr v3, v9

    if-eq v8, v3, :cond_b

    goto :goto_3

    .line 47
    :cond_b
    add-int/lit8 v3, v6, 0x3

    aget-byte v3, p0, v3

    invoke-static {v3}, Llocal/mio/os4camerabridge/JpegWatermarkMetadataPolicy;->u(B)I

    move-result v3

    shl-int/2addr v3, v9

    add-int/lit8 v5, v6, 0x4

    aget-byte v5, p0, v5

    invoke-static {v5}, Llocal/mio/os4camerabridge/JpegWatermarkMetadataPolicy;->u(B)I

    move-result v5

    or-int/2addr v3, v5

    .line 48
    add-int/lit8 v5, v6, 0x5

    aget-byte v5, p0, v5

    invoke-static {v5}, Llocal/mio/os4camerabridge/JpegWatermarkMetadataPolicy;->u(B)I

    move-result v5

    shl-int/2addr v5, v9

    add-int/lit8 v6, v6, 0x6

    aget-byte p0, p0, v6

    invoke-static {p0}, Llocal/mio/os4camerabridge/JpegWatermarkMetadataPolicy;->u(B)I

    move-result p0

    or-int/2addr p0, v5

    .line 49
    if-lez p0, :cond_c

    if-lez v3, :cond_c

    new-array v0, v4, [I

    aput p0, v0, v1

    aput v3, v0, v2

    :cond_c
    return-object v0

    .line 46
    :cond_d
    :goto_3
    return-object v0

    .line 51
    :cond_e
    add-int/2addr v6, v8

    .line 52
    goto/16 :goto_0

    .line 40
    :cond_f
    :goto_4
    return-object v0

    .line 36
    :cond_10
    :goto_5
    return-object v0

    .line 53
    :cond_11
    return-object v0

    .line 29
    :cond_12
    :goto_6
    return-object v0
.end method

.method static eligible(IIIZ)Z
    .locals 1

    .line 17
    const/16 v0, 0xa3

    if-eq p0, v0, :cond_0

    const/16 v0, 0xa7

    if-eq p0, v0, :cond_0

    const/16 v0, 0x100

    if-ne p0, v0, :cond_1

    :cond_0
    if-nez p1, :cond_1

    if-nez p2, :cond_1

    if-eqz p3, :cond_1

    const/4 p0, 0x1

    goto :goto_0

    :cond_1
    const/4 p0, 0x0

    :goto_0
    return p0
.end method

.method static needsRestore(Ljava/lang/String;Ljava/lang/String;)Z
    .locals 1

    .line 22
    if-eqz p0, :cond_1

    invoke-virtual {p0}, Ljava/lang/String;->isEmpty()Z

    move-result v0

    if-nez v0, :cond_1

    invoke-virtual {p0}, Ljava/lang/String;->length()I

    move-result p0

    const/16 v0, 0xa0

    if-gt p0, v0, :cond_1

    if-eqz p1, :cond_0

    .line 23
    invoke-virtual {p1}, Ljava/lang/String;->isEmpty()Z

    move-result p0

    if-eqz p0, :cond_1

    :cond_0
    const/4 p0, 0x1

    goto :goto_0

    :cond_1
    const/4 p0, 0x0

    .line 22
    :goto_0
    return p0
.end method

.method private static u(B)I
    .locals 0

    .line 56
    and-int/lit16 p0, p0, 0xff

    return p0
.end method
