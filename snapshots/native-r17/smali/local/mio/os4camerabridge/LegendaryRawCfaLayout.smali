.class public final Llocal/mio/os4camerabridge/LegendaryRawCfaLayout;
.super Ljava/lang/Object;
.source "LegendaryRawCfaLayout.java"


# static fields
.field private static final RGGB_SOURCE_POSITIONS:[[I


# direct methods
.method static constructor <clinit>()V
    .locals 7

    .line 5
    const/4 v0, 0x0

    const/4 v1, 0x1

    const/4 v2, 0x2

    const/4 v3, 0x3

    filled-new-array {v0, v1, v2, v3}, [I

    move-result-object v4

    filled-new-array {v1, v0, v3, v2}, [I

    move-result-object v5

    filled-new-array {v2, v3, v0, v1}, [I

    move-result-object v6

    filled-new-array {v3, v2, v1, v0}, [I

    move-result-object v0

    filled-new-array {v4, v5, v6, v0}, [[I

    move-result-object v0

    sput-object v0, Llocal/mio/os4camerabridge/LegendaryRawCfaLayout;->RGGB_SOURCE_POSITIONS:[[I

    return-void
.end method

.method private constructor <init>()V
    .locals 0

    .line 8
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method private static read([BII)I
    .locals 1

    .line 35
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

.method public static toRggb([BIII)[B
    .locals 17

    .line 10
    move-object/from16 v0, p0

    move/from16 v1, p1

    move/from16 v2, p2

    move/from16 v3, p3

    if-ltz v3, :cond_8

    const/4 v4, 0x3

    if-gt v3, v4, :cond_8

    if-lez v1, :cond_8

    const/16 v4, 0x2000

    if-gt v1, v4, :cond_8

    rem-int/lit8 v5, v1, 0x4

    if-nez v5, :cond_8

    if-lez v2, :cond_8

    if-gt v2, v4, :cond_8

    rem-int/lit8 v4, v2, 0x2

    if-nez v4, :cond_8

    .line 13
    div-int/lit8 v4, v1, 0x4

    mul-int/lit8 v4, v4, 0x5

    .line 14
    if-eqz v0, :cond_7

    int-to-long v5, v4

    int-to-long v7, v2

    mul-long/2addr v5, v7

    array-length v7, v0

    int-to-long v7, v7

    cmp-long v5, v5, v7

    if-nez v5, :cond_7

    .line 16
    if-nez v3, :cond_0

    return-object v0

    .line 17
    :cond_0
    array-length v5, v0

    new-array v5, v5, [B

    .line 18
    sget-object v6, Llocal/mio/os4camerabridge/LegendaryRawCfaLayout;->RGGB_SOURCE_POSITIONS:[[I

    aget-object v3, v6, v3

    .line 19
    const/4 v7, 0x0

    :goto_0
    if-ge v7, v2, :cond_6

    .line 20
    mul-int v8, v7, v4

    add-int v9, v8, v4

    .line 21
    const/4 v10, 0x0

    :goto_1
    if-ge v10, v1, :cond_5

    .line 22
    div-int/lit8 v11, v10, 0x4

    mul-int/lit8 v11, v11, 0x5

    .line 23
    const/4 v12, 0x0

    :goto_2
    const/4 v13, 0x4

    if-ge v12, v13, :cond_4

    .line 24
    const/4 v14, 0x0

    :goto_3
    if-ge v14, v13, :cond_3

    .line 25
    aget v15, v3, v14

    .line 26
    const/4 v6, 0x2

    if-ge v15, v6, :cond_1

    move/from16 v16, v8

    goto :goto_4

    :cond_1
    move/from16 v16, v9

    :goto_4
    add-int v13, v16, v11

    rem-int/lit8 v15, v15, 0x2

    add-int/2addr v15, v12

    invoke-static {v0, v13, v15}, Llocal/mio/os4camerabridge/LegendaryRawCfaLayout;->read([BII)I

    move-result v13

    .line 27
    if-ge v14, v6, :cond_2

    move v6, v8

    goto :goto_5

    :cond_2
    move v6, v9

    :goto_5
    add-int/2addr v6, v11

    rem-int/lit8 v15, v14, 0x2

    add-int/2addr v15, v12

    invoke-static {v5, v6, v15, v13}, Llocal/mio/os4camerabridge/LegendaryRawCfaLayout;->write([BIII)V

    .line 24
    add-int/lit8 v14, v14, 0x1

    const/4 v13, 0x4

    goto :goto_3

    .line 23
    :cond_3
    add-int/lit8 v12, v12, 0x2

    goto :goto_2

    .line 21
    :cond_4
    add-int/lit8 v10, v10, 0x4

    goto :goto_1

    .line 19
    :cond_5
    add-int/lit8 v7, v7, 0x2

    goto :goto_0

    .line 32
    :cond_6
    return-object v5

    .line 15
    :cond_7
    new-instance v0, Ljava/lang/IllegalArgumentException;

    const-string v1, "RAW10 length"

    invoke-direct {v0, v1}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw v0

    .line 12
    :cond_8
    new-instance v0, Ljava/lang/IllegalArgumentException;

    const-string v1, "CFA/geometry"

    invoke-direct {v0, v1}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw v0
.end method

.method private static write([BIII)V
    .locals 3

    .line 38
    add-int v0, p1, p2

    ushr-int/lit8 v1, p3, 0x2

    int-to-byte v1, v1

    aput-byte v1, p0, v0

    .line 39
    add-int/lit8 p1, p1, 0x4

    aget-byte v0, p0, p1

    and-int/lit16 v0, v0, 0xff

    mul-int/lit8 p2, p2, 0x2

    const/4 v1, 0x3

    shl-int v2, v1, p2

    not-int v2, v2

    and-int/2addr v0, v2

    and-int/2addr p3, v1

    shl-int p2, p3, p2

    or-int/2addr p2, v0

    int-to-byte p2, p2

    aput-byte p2, p0, p1

    .line 40
    return-void
.end method
