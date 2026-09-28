.class final Llocal/mio/os4camerabridge/LegendExifTagger;
.super Ljava/lang/Object;
.source "LegendExifTagger.java"


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Llocal/mio/os4camerabridge/LegendExifTagger$TiffParseException;
    }
.end annotation


# static fields
.field private static final EXIF_MAGIC:[B

.field static final TAG_LEGEND_MODE:I = 0x88b0


# direct methods
.method static constructor <clinit>()V
    .locals 1

    .line 19
    const/4 v0, 0x6

    new-array v0, v0, [B

    fill-array-data v0, :array_0

    sput-object v0, Llocal/mio/os4camerabridge/LegendExifTagger;->EXIF_MAGIC:[B

    return-void

    nop

    :array_0
    .array-data 1
        0x45t
        0x78t
        0x69t
        0x66t
        0x0t
        0x0t
    .end array-data
.end method

.method private constructor <init>()V
    .locals 0

    .line 21
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 22
    return-void
.end method

.method private static app1([B)[B
    .locals 7
    .param p0, "body"    # [B

    .line 318
    array-length v0, p0

    const/4 v1, 0x2

    add-int/2addr v0, v1

    .line 319
    .local v0, "segmentLength":I
    const v2, 0xffff

    if-gt v0, v2, :cond_0

    .line 322
    array-length v2, p0

    const/4 v3, 0x4

    add-int/2addr v2, v3

    new-array v2, v2, [B

    .line 323
    .local v2, "output":[B
    const/4 v4, -0x1

    const/4 v5, 0x0

    aput-byte v4, v2, v5

    .line 324
    const/4 v4, 0x1

    const/16 v6, -0x1f

    aput-byte v6, v2, v4

    .line 325
    ushr-int/lit8 v4, v0, 0x8

    and-int/lit16 v4, v4, 0xff

    int-to-byte v4, v4

    aput-byte v4, v2, v1

    .line 326
    and-int/lit16 v1, v0, 0xff

    int-to-byte v1, v1

    const/4 v4, 0x3

    aput-byte v1, v2, v4

    .line 327
    array-length v1, p0

    invoke-static {p0, v5, v2, v3, v1}, Ljava/lang/System;->arraycopy(Ljava/lang/Object;ILjava/lang/Object;II)V

    .line 328
    return-object v2

    .line 320
    .end local v2    # "output":[B
    :cond_0
    new-instance v1, Llocal/mio/os4camerabridge/LegendExifTagger$TiffParseException;

    const-string v2, "EXIF APP1 exceeds 64 KiB"

    invoke-direct {v1, v2}, Llocal/mio/os4camerabridge/LegendExifTagger$TiffParseException;-><init>(Ljava/lang/String;)V

    throw v1
.end method

.method private static buildMinimalExifApp1(I)[B
    .locals 4
    .param p0, "mode"    # I

    .line 299
    new-instance v0, Ljava/io/ByteArrayOutputStream;

    const/16 v1, 0x20

    invoke-direct {v0, v1}, Ljava/io/ByteArrayOutputStream;-><init>(I)V

    .line 300
    .local v0, "body":Ljava/io/ByteArrayOutputStream;
    sget-object v1, Llocal/mio/os4camerabridge/LegendExifTagger;->EXIF_MAGIC:[B

    sget-object v2, Llocal/mio/os4camerabridge/LegendExifTagger;->EXIF_MAGIC:[B

    array-length v2, v2

    const/4 v3, 0x0

    invoke-virtual {v0, v1, v3, v2}, Ljava/io/ByteArrayOutputStream;->write([BII)V

    .line 301
    const/16 v1, 0x49

    invoke-virtual {v0, v1}, Ljava/io/ByteArrayOutputStream;->write(I)V

    .line 302
    invoke-virtual {v0, v1}, Ljava/io/ByteArrayOutputStream;->write(I)V

    .line 303
    const/16 v1, 0x2a

    invoke-static {v0, v1}, Llocal/mio/os4camerabridge/LegendExifTagger;->writeU16le(Ljava/io/ByteArrayOutputStream;I)V

    .line 304
    const/16 v1, 0x8

    invoke-static {v0, v1}, Llocal/mio/os4camerabridge/LegendExifTagger;->writeU32le(Ljava/io/ByteArrayOutputStream;I)V

    .line 305
    const/4 v1, 0x1

    invoke-static {v0, v1}, Llocal/mio/os4camerabridge/LegendExifTagger;->writeU16le(Ljava/io/ByteArrayOutputStream;I)V

    .line 306
    const v2, 0x88b0

    invoke-static {v0, v2}, Llocal/mio/os4camerabridge/LegendExifTagger;->writeU16le(Ljava/io/ByteArrayOutputStream;I)V

    .line 307
    invoke-static {v0, v1}, Llocal/mio/os4camerabridge/LegendExifTagger;->writeU16le(Ljava/io/ByteArrayOutputStream;I)V

    .line 308
    invoke-static {v0, v1}, Llocal/mio/os4camerabridge/LegendExifTagger;->writeU32le(Ljava/io/ByteArrayOutputStream;I)V

    .line 309
    and-int/lit16 v1, p0, 0xff

    invoke-virtual {v0, v1}, Ljava/io/ByteArrayOutputStream;->write(I)V

    .line 310
    invoke-virtual {v0, v3}, Ljava/io/ByteArrayOutputStream;->write(I)V

    .line 311
    invoke-virtual {v0, v3}, Ljava/io/ByteArrayOutputStream;->write(I)V

    .line 312
    invoke-virtual {v0, v3}, Ljava/io/ByteArrayOutputStream;->write(I)V

    .line 313
    invoke-static {v0, v3}, Llocal/mio/os4camerabridge/LegendExifTagger;->writeU32le(Ljava/io/ByteArrayOutputStream;I)V

    .line 314
    invoke-virtual {v0}, Ljava/io/ByteArrayOutputStream;->toByteArray()[B

    move-result-object v1

    invoke-static {v1}, Llocal/mio/os4camerabridge/LegendExifTagger;->app1([B)[B

    move-result-object v1

    return-object v1
.end method

.method private static findExifSegment([B)[I
    .locals 6
    .param p0, "jpeg"    # [B

    .line 59
    const/4 v0, 0x2

    .line 60
    .local v0, "offset":I
    :goto_0
    add-int/lit8 v1, v0, 0x4

    array-length v2, p0

    const/4 v3, 0x0

    if-gt v1, v2, :cond_7

    .line 61
    aget-byte v1, p0, v0

    const/16 v2, 0xff

    and-int/2addr v1, v2

    if-eq v1, v2, :cond_0

    .line 62
    add-int/lit8 v0, v0, 0x1

    .line 63
    goto :goto_0

    .line 65
    :cond_0
    add-int/lit8 v1, v0, 0x1

    aget-byte v1, p0, v1

    and-int/2addr v1, v2

    .line 66
    .local v1, "marker":I
    const/16 v2, 0xda

    if-ne v1, v2, :cond_1

    .line 67
    return-object v3

    .line 69
    :cond_1
    const/16 v2, 0xd8

    if-eq v1, v2, :cond_6

    const/16 v2, 0xd9

    if-eq v1, v2, :cond_6

    if-eqz v1, :cond_6

    const/16 v2, 0xd0

    if-lt v1, v2, :cond_2

    const/16 v2, 0xd7

    if-gt v1, v2, :cond_2

    goto :goto_2

    .line 74
    :cond_2
    add-int/lit8 v2, v0, 0x2

    invoke-static {p0, v2}, Llocal/mio/os4camerabridge/LegendExifTagger;->u16be([BI)I

    move-result v2

    .line 75
    .local v2, "segmentLength":I
    const/4 v4, 0x2

    if-lt v2, v4, :cond_5

    add-int v5, v0, v2

    add-int/2addr v5, v4

    array-length v4, p0

    if-le v5, v4, :cond_3

    goto :goto_1

    .line 79
    :cond_3
    const/16 v3, 0xe1

    if-ne v1, v3, :cond_4

    add-int/lit8 v3, v0, 0x4

    sget-object v4, Llocal/mio/os4camerabridge/LegendExifTagger;->EXIF_MAGIC:[B

    .line 80
    invoke-static {p0, v3, v4}, Llocal/mio/os4camerabridge/LegendExifTagger;->startsWith([BI[B)Z

    move-result v3

    if-eqz v3, :cond_4

    .line 81
    add-int/lit8 v3, v2, 0x2

    filled-new-array {v0, v3}, [I

    move-result-object v3

    return-object v3

    .line 83
    :cond_4
    add-int/lit8 v3, v2, 0x2

    add-int/2addr v0, v3

    .line 84
    .end local v1    # "marker":I
    .end local v2    # "segmentLength":I
    goto :goto_0

    .line 77
    .restart local v1    # "marker":I
    .restart local v2    # "segmentLength":I
    :cond_5
    :goto_1
    return-object v3

    .line 71
    .end local v2    # "segmentLength":I
    :cond_6
    :goto_2
    add-int/lit8 v0, v0, 0x2

    .line 72
    goto :goto_0

    .line 85
    .end local v1    # "marker":I
    :cond_7
    return-object v3
.end method

.method private static getU16([BIZ)I
    .locals 1
    .param p0, "bytes"    # [B
    .param p1, "offset"    # I
    .param p2, "littleEndian"    # Z

    .line 343
    invoke-static {p0, p1, p2}, Llocal/mio/os4camerabridge/LegendExifTagger;->u16([BIZ)I

    move-result v0

    return v0
.end method

.method private static getU32([BIZ)J
    .locals 2
    .param p0, "bytes"    # [B
    .param p1, "offset"    # I
    .param p2, "littleEndian"    # Z

    .line 348
    invoke-static {p0, p1, p2}, Llocal/mio/os4camerabridge/LegendExifTagger;->u32([BIZ)J

    move-result-wide v0

    return-wide v0
.end method

.method private static injectIntoExisting([BIII)[B
    .locals 29
    .param p0, "jpeg"    # [B
    .param p1, "markerOffset"    # I
    .param p2, "totalLength"    # I
    .param p3, "mode"    # I

    .line 155
    move/from16 v0, p3

    add-int/lit8 v1, p2, -0x4

    .line 156
    .local v1, "bodyLength":I
    new-array v2, v1, [B

    .line 157
    .local v2, "body":[B
    add-int/lit8 v3, p1, 0x4

    const/4 v4, 0x0

    move-object/from16 v5, p0

    invoke-static {v5, v3, v2, v4, v1}, Ljava/lang/System;->arraycopy(Ljava/lang/Object;ILjava/lang/Object;II)V

    .line 158
    const/16 v3, 0xe

    if-lt v1, v3, :cond_16

    sget-object v3, Llocal/mio/os4camerabridge/LegendExifTagger;->EXIF_MAGIC:[B

    invoke-static {v2, v4, v3}, Llocal/mio/os4camerabridge/LegendExifTagger;->startsWith([BI[B)Z

    move-result v3

    if-eqz v3, :cond_16

    .line 162
    const/4 v3, 0x6

    aget-byte v6, v2, v3

    and-int/lit16 v6, v6, 0xff

    .line 163
    .local v6, "first":I
    const/4 v7, 0x7

    aget-byte v7, v2, v7

    and-int/lit16 v7, v7, 0xff

    .line 164
    .local v7, "second":I
    const/16 v8, 0x49

    if-ne v6, v8, :cond_0

    if-ne v7, v8, :cond_0

    .line 165
    const/4 v8, 0x1

    .local v8, "littleEndian":Z
    goto :goto_0

    .line 166
    .end local v8    # "littleEndian":Z
    :cond_0
    const/16 v8, 0x4d

    if-ne v6, v8, :cond_15

    if-ne v7, v8, :cond_15

    .line 167
    const/4 v8, 0x0

    .line 172
    .restart local v8    # "littleEndian":Z
    :goto_0
    const/16 v9, 0xa

    invoke-static {v2, v9, v8}, Llocal/mio/os4camerabridge/LegendExifTagger;->getU32([BIZ)J

    move-result-wide v10

    long-to-int v10, v10

    add-int/2addr v10, v3

    .line 173
    .local v10, "ifd0":I
    if-lt v10, v3, :cond_14

    add-int/lit8 v3, v10, 0x2

    if-gt v3, v1, :cond_14

    .line 176
    invoke-static {v2, v10, v8}, Llocal/mio/os4camerabridge/LegendExifTagger;->getU16([BIZ)I

    move-result v3

    .line 177
    .local v3, "ifd0Count":I
    add-int/lit8 v11, v10, 0x2

    .line 178
    .local v11, "ifd0Entries":I
    mul-int/lit8 v12, v3, 0xc

    add-int/2addr v12, v11

    const/4 v13, 0x4

    add-int/2addr v12, v13

    if-gt v12, v1, :cond_13

    .line 183
    const/4 v12, 0x0

    .local v12, "index":I
    :goto_1
    const v14, 0x88b0

    if-ge v12, v3, :cond_2

    .line 184
    mul-int/lit8 v15, v12, 0xc

    add-int/2addr v15, v11

    .line 185
    .local v15, "entry":I
    invoke-static {v2, v15, v8}, Llocal/mio/os4camerabridge/LegendExifTagger;->getU16([BIZ)I

    move-result v9

    if-ne v9, v14, :cond_1

    .line 186
    invoke-static {v2, v15, v8, v0}, Llocal/mio/os4camerabridge/LegendExifTagger;->writeLegendEntry([BIZI)V

    .line 187
    invoke-static {v2}, Llocal/mio/os4camerabridge/LegendExifTagger;->app1([B)[B

    move-result-object v4

    return-object v4

    .line 183
    .end local v15    # "entry":I
    :cond_1
    add-int/lit8 v12, v12, 0x1

    const/16 v9, 0xa

    goto :goto_1

    .line 192
    .end local v12    # "index":I
    :cond_2
    const/4 v9, -0x1

    .line 193
    .local v9, "pointerEntry":I
    const/4 v12, -0x1

    .line 194
    .local v12, "exifIfdRelative":I
    const/4 v15, 0x0

    .local v15, "index":I
    :goto_2
    if-ge v15, v3, :cond_7

    .line 195
    mul-int/lit8 v17, v15, 0xc

    add-int v4, v11, v17

    .line 196
    .local v4, "entry":I
    invoke-static {v2, v4, v8}, Llocal/mio/os4camerabridge/LegendExifTagger;->getU16([BIZ)I

    move-result v13

    .line 197
    .local v13, "tag":I
    add-int/lit8 v14, v4, 0x2

    invoke-static {v2, v14, v8}, Llocal/mio/os4camerabridge/LegendExifTagger;->getU16([BIZ)I

    move-result v14

    .line 198
    .local v14, "type":I
    move/from16 v19, v3

    .end local v3    # "ifd0Count":I
    .local v19, "ifd0Count":I
    add-int/lit8 v3, v4, 0x4

    invoke-static {v2, v3, v8}, Llocal/mio/os4camerabridge/LegendExifTagger;->getU32([BIZ)J

    move-result-wide v20

    .line 199
    .local v20, "count":J
    const v3, 0x8769

    if-ne v13, v3, :cond_5

    const-wide/16 v22, 0x1

    cmp-long v3, v20, v22

    if-nez v3, :cond_5

    const/4 v3, 0x3

    if-eq v14, v3, :cond_3

    const/4 v3, 0x4

    if-ne v14, v3, :cond_6

    .line 200
    :cond_3
    move v9, v4

    .line 201
    const/4 v3, 0x3

    if-ne v14, v3, :cond_4

    .line 202
    add-int/lit8 v3, v4, 0x8

    invoke-static {v2, v3, v8}, Llocal/mio/os4camerabridge/LegendExifTagger;->getU16([BIZ)I

    move-result v3

    move/from16 v22, v4

    goto :goto_3

    .line 203
    :cond_4
    add-int/lit8 v3, v4, 0x8

    move/from16 v22, v4

    .end local v4    # "entry":I
    .local v22, "entry":I
    invoke-static {v2, v3, v8}, Llocal/mio/os4camerabridge/LegendExifTagger;->getU32([BIZ)J

    move-result-wide v3

    long-to-int v3, v3

    :goto_3
    move v12, v3

    .line 204
    goto :goto_4

    .line 199
    .end local v22    # "entry":I
    .restart local v4    # "entry":I
    :cond_5
    move/from16 v22, v4

    .line 194
    .end local v4    # "entry":I
    .end local v13    # "tag":I
    .end local v14    # "type":I
    .end local v20    # "count":J
    :cond_6
    add-int/lit8 v15, v15, 0x1

    move/from16 v3, v19

    const/4 v4, 0x0

    const/4 v13, 0x4

    const v14, 0x88b0

    goto :goto_2

    .end local v19    # "ifd0Count":I
    .restart local v3    # "ifd0Count":I
    :cond_7
    move/from16 v19, v3

    .line 208
    .end local v3    # "ifd0Count":I
    .end local v15    # "index":I
    .restart local v19    # "ifd0Count":I
    :goto_4
    move v3, v10

    .line 209
    .local v3, "targetIfd":I
    const/4 v4, 0x1

    .line 210
    .local v4, "replaceIfd0Pointer":Z
    if-ltz v9, :cond_8

    if-ltz v12, :cond_8

    .line 211
    add-int/lit8 v13, v12, 0x6

    .line 212
    .local v13, "candidate":I
    add-int/lit8 v14, v13, 0x2

    if-gt v14, v1, :cond_8

    .line 213
    invoke-static {v2, v13, v8}, Llocal/mio/os4camerabridge/LegendExifTagger;->getU16([BIZ)I

    move-result v14

    .line 214
    .local v14, "count":I
    add-int/lit8 v15, v13, 0x2

    mul-int/lit8 v20, v14, 0xc

    add-int v15, v15, v20

    const/16 v17, 0x4

    add-int/lit8 v15, v15, 0x4

    if-gt v15, v1, :cond_8

    .line 215
    move v3, v13

    .line 216
    const/4 v4, 0x0

    .line 221
    .end local v13    # "candidate":I
    .end local v14    # "count":I
    :cond_8
    invoke-static {v2, v3, v8}, Llocal/mio/os4camerabridge/LegendExifTagger;->getU16([BIZ)I

    move-result v13

    .line 222
    .local v13, "targetCount":I
    add-int/lit8 v14, v3, 0x2

    .line 223
    .local v14, "targetEntries":I
    mul-int/lit8 v15, v13, 0xc

    add-int/2addr v15, v14

    .line 224
    .local v15, "nextIfdOffset":I
    move/from16 v20, v3

    .end local v3    # "targetIfd":I
    .local v20, "targetIfd":I
    add-int/lit8 v3, v15, 0x4

    if-gt v3, v1, :cond_12

    .line 228
    new-instance v3, Ljava/util/ArrayList;

    move/from16 v21, v1

    .end local v1    # "bodyLength":I
    .local v21, "bodyLength":I
    add-int/lit8 v1, v13, 0x1

    invoke-direct {v3, v1}, Ljava/util/ArrayList;-><init>(I)V

    .line 229
    .local v3, "entries":Ljava/util/ArrayList;, "Ljava/util/ArrayList<[B>;"
    const/4 v1, 0x0

    .local v1, "index":I
    :goto_5
    if-ge v1, v13, :cond_9

    .line 230
    mul-int/lit8 v22, v1, 0xc

    move/from16 v23, v1

    .end local v1    # "index":I
    .local v23, "index":I
    add-int v1, v14, v22

    .line 231
    .local v1, "entry":I
    move/from16 v22, v4

    .end local v4    # "replaceIfd0Pointer":Z
    .local v22, "replaceIfd0Pointer":Z
    add-int/lit8 v4, v1, 0xc

    invoke-static {v2, v1, v4}, Ljava/util/Arrays;->copyOfRange([BII)[B

    move-result-object v4

    invoke-virtual {v3, v4}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    .line 229
    .end local v1    # "entry":I
    add-int/lit8 v1, v23, 0x1

    move/from16 v4, v22

    .end local v23    # "index":I
    .local v1, "index":I
    goto :goto_5

    .end local v22    # "replaceIfd0Pointer":Z
    .restart local v4    # "replaceIfd0Pointer":Z
    :cond_9
    move/from16 v23, v1

    move/from16 v22, v4

    .line 233
    .end local v1    # "index":I
    .end local v4    # "replaceIfd0Pointer":Z
    .restart local v22    # "replaceIfd0Pointer":Z
    add-int/lit8 v1, v15, 0x4

    invoke-static {v2, v15, v1}, Ljava/util/Arrays;->copyOfRange([BII)[B

    move-result-object v1

    .line 235
    .local v1, "nextPointer":[B
    const/4 v4, 0x0

    .line 236
    .local v4, "replaced":Z
    const/16 v23, 0x0

    move/from16 v24, v4

    move/from16 v4, v23

    .local v4, "index":I
    .local v24, "replaced":Z
    :goto_6
    invoke-virtual {v3}, Ljava/util/ArrayList;->size()I

    move-result v5

    if-ge v4, v5, :cond_b

    .line 237
    invoke-virtual {v3, v4}, Ljava/util/ArrayList;->get(I)Ljava/lang/Object;

    move-result-object v5

    check-cast v5, [B

    move/from16 v23, v6

    const/4 v6, 0x0

    .end local v6    # "first":I
    .local v23, "first":I
    invoke-static {v5, v6, v8}, Llocal/mio/os4camerabridge/LegendExifTagger;->getU16([BIZ)I

    move-result v5

    const v6, 0x88b0

    if-ne v5, v6, :cond_a

    .line 239
    invoke-static {v8, v0}, Llocal/mio/os4camerabridge/LegendExifTagger;->legendEntry(ZI)[B

    move-result-object v5

    invoke-virtual {v3, v4, v5}, Ljava/util/ArrayList;->set(ILjava/lang/Object;)Ljava/lang/Object;

    .line 240
    const/4 v5, 0x1

    .line 241
    .end local v24    # "replaced":Z
    .local v5, "replaced":Z
    move v4, v5

    goto :goto_7

    .line 236
    .end local v5    # "replaced":Z
    .restart local v24    # "replaced":Z
    :cond_a
    add-int/lit8 v4, v4, 0x1

    move-object/from16 v5, p0

    move/from16 v6, v23

    goto :goto_6

    .end local v23    # "first":I
    .restart local v6    # "first":I
    :cond_b
    move/from16 v23, v6

    .end local v6    # "first":I
    .restart local v23    # "first":I
    move/from16 v4, v24

    .line 244
    .end local v24    # "replaced":Z
    .local v4, "replaced":Z
    :goto_7
    if-nez v4, :cond_c

    .line 245
    invoke-static {v8, v0}, Llocal/mio/os4camerabridge/LegendExifTagger;->legendEntry(ZI)[B

    move-result-object v5

    invoke-virtual {v3, v5}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    .line 247
    :cond_c
    new-instance v5, Llocal/mio/os4camerabridge/LegendExifTagger$$ExternalSyntheticLambda0;

    invoke-direct {v5, v8}, Llocal/mio/os4camerabridge/LegendExifTagger$$ExternalSyntheticLambda0;-><init>(Z)V

    invoke-static {v5}, Ljava/util/Comparator;->comparingInt(Ljava/util/function/ToIntFunction;)Ljava/util/Comparator;

    move-result-object v5

    invoke-virtual {v3, v5}, Ljava/util/ArrayList;->sort(Ljava/util/Comparator;)V

    .line 250
    add-int/lit8 v5, v21, -0x6

    and-int/lit8 v5, v5, 0x1

    add-int v5, v21, v5

    .line 251
    .local v5, "cloneOffset":I
    add-int/lit8 v6, v5, -0x6

    .line 252
    .local v6, "relativeCloneOffset":I
    add-int/lit8 v16, v5, 0x2

    invoke-virtual {v3}, Ljava/util/ArrayList;->size()I

    move-result v24

    const/16 v0, 0xc

    mul-int/lit8 v24, v24, 0xc

    add-int v16, v16, v24

    const/16 v17, 0x4

    add-int/lit8 v0, v16, 0x4

    .line 253
    .local v0, "newLength":I
    move-object/from16 v16, v3

    .end local v3    # "entries":Ljava/util/ArrayList;, "Ljava/util/ArrayList<[B>;"
    .local v16, "entries":Ljava/util/ArrayList;, "Ljava/util/ArrayList<[B>;"
    invoke-static {v2, v0}, Ljava/util/Arrays;->copyOf([BI)[B

    move-result-object v3

    .line 254
    .local v3, "output":[B
    move/from16 v25, v0

    .end local v0    # "newLength":I
    .local v25, "newLength":I
    invoke-virtual/range {v16 .. v16}, Ljava/util/ArrayList;->size()I

    move-result v0

    invoke-static {v3, v5, v8, v0}, Llocal/mio/os4camerabridge/LegendExifTagger;->putU16([BIZI)V

    .line 255
    add-int/lit8 v0, v5, 0x2

    .line 256
    .local v0, "destination":I
    invoke-virtual/range {v16 .. v16}, Ljava/util/ArrayList;->iterator()Ljava/util/Iterator;

    move-result-object v26

    :goto_8
    invoke-interface/range {v26 .. v26}, Ljava/util/Iterator;->hasNext()Z

    move-result v27

    if-eqz v27, :cond_d

    invoke-interface/range {v26 .. v26}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v27

    move-object/from16 v28, v2

    .end local v2    # "body":[B
    .local v28, "body":[B
    move-object/from16 v2, v27

    check-cast v2, [B

    .line 257
    .local v2, "entry":[B
    move/from16 v27, v4

    move/from16 v24, v5

    const/16 v4, 0xc

    const/4 v5, 0x0

    .end local v4    # "replaced":Z
    .end local v5    # "cloneOffset":I
    .local v24, "cloneOffset":I
    .local v27, "replaced":Z
    invoke-static {v2, v5, v3, v0, v4}, Ljava/lang/System;->arraycopy(Ljava/lang/Object;ILjava/lang/Object;II)V

    .line 258
    nop

    .end local v2    # "entry":[B
    add-int/lit8 v0, v0, 0xc

    .line 259
    move/from16 v5, v24

    move/from16 v4, v27

    move-object/from16 v2, v28

    goto :goto_8

    .line 260
    .end local v24    # "cloneOffset":I
    .end local v27    # "replaced":Z
    .end local v28    # "body":[B
    .local v2, "body":[B
    .restart local v4    # "replaced":Z
    .restart local v5    # "cloneOffset":I
    :cond_d
    move-object/from16 v28, v2

    move/from16 v27, v4

    move/from16 v24, v5

    const/4 v5, 0x0

    .end local v2    # "body":[B
    .end local v4    # "replaced":Z
    .end local v5    # "cloneOffset":I
    .restart local v24    # "cloneOffset":I
    .restart local v27    # "replaced":Z
    .restart local v28    # "body":[B
    const/4 v2, 0x4

    invoke-static {v1, v5, v3, v0, v2}, Ljava/lang/System;->arraycopy(Ljava/lang/Object;ILjava/lang/Object;II)V

    .line 261
    add-int/lit8 v2, v25, 0x2

    const v4, 0xffff

    if-gt v2, v4, :cond_11

    .line 264
    if-eqz v22, :cond_e

    .line 265
    int-to-long v4, v6

    const/16 v2, 0xa

    invoke-static {v3, v2, v8, v4, v5}, Llocal/mio/os4camerabridge/LegendExifTagger;->putU32([BIZJ)V

    goto :goto_9

    .line 266
    :cond_e
    add-int/lit8 v2, v9, 0x2

    invoke-static {v3, v2, v8}, Llocal/mio/os4camerabridge/LegendExifTagger;->getU16([BIZ)I

    move-result v2

    const/4 v5, 0x3

    if-ne v2, v5, :cond_10

    .line 267
    if-gt v6, v4, :cond_f

    .line 270
    add-int/lit8 v2, v9, 0x8

    invoke-static {v3, v2, v8, v6}, Llocal/mio/os4camerabridge/LegendExifTagger;->putU16([BIZI)V

    .line 272
    add-int/lit8 v2, v9, 0xa

    const/16 v18, 0x0

    aput-byte v18, v3, v2

    .line 273
    add-int/lit8 v2, v9, 0xb

    aput-byte v18, v3, v2

    goto :goto_9

    .line 268
    :cond_f
    new-instance v2, Llocal/mio/os4camerabridge/LegendExifTagger$TiffParseException;

    const-string v4, "ExifIFD offset overflows SHORT"

    invoke-direct {v2, v4}, Llocal/mio/os4camerabridge/LegendExifTagger$TiffParseException;-><init>(Ljava/lang/String;)V

    throw v2

    .line 275
    :cond_10
    add-int/lit8 v2, v9, 0x8

    int-to-long v4, v6

    invoke-static {v3, v2, v8, v4, v5}, Llocal/mio/os4camerabridge/LegendExifTagger;->putU32([BIZJ)V

    .line 278
    :goto_9
    invoke-static {v3}, Llocal/mio/os4camerabridge/LegendExifTagger;->app1([B)[B

    move-result-object v2

    return-object v2

    .line 262
    :cond_11
    new-instance v2, Llocal/mio/os4camerabridge/LegendExifTagger$TiffParseException;

    const-string v4, "EXIF APP1 exceeds 64 KiB"

    invoke-direct {v2, v4}, Llocal/mio/os4camerabridge/LegendExifTagger$TiffParseException;-><init>(Ljava/lang/String;)V

    throw v2

    .line 225
    .end local v0    # "destination":I
    .end local v3    # "output":[B
    .end local v16    # "entries":Ljava/util/ArrayList;, "Ljava/util/ArrayList<[B>;"
    .end local v21    # "bodyLength":I
    .end local v22    # "replaceIfd0Pointer":Z
    .end local v23    # "first":I
    .end local v24    # "cloneOffset":I
    .end local v25    # "newLength":I
    .end local v27    # "replaced":Z
    .end local v28    # "body":[B
    .local v1, "bodyLength":I
    .restart local v2    # "body":[B
    .local v4, "replaceIfd0Pointer":Z
    .local v6, "first":I
    :cond_12
    move/from16 v21, v1

    .end local v1    # "bodyLength":I
    .restart local v21    # "bodyLength":I
    new-instance v0, Llocal/mio/os4camerabridge/LegendExifTagger$TiffParseException;

    const-string v1, "target IFD out of bounds"

    invoke-direct {v0, v1}, Llocal/mio/os4camerabridge/LegendExifTagger$TiffParseException;-><init>(Ljava/lang/String;)V

    throw v0

    .line 179
    .end local v4    # "replaceIfd0Pointer":Z
    .end local v9    # "pointerEntry":I
    .end local v12    # "exifIfdRelative":I
    .end local v13    # "targetCount":I
    .end local v14    # "targetEntries":I
    .end local v15    # "nextIfdOffset":I
    .end local v19    # "ifd0Count":I
    .end local v20    # "targetIfd":I
    .end local v21    # "bodyLength":I
    .restart local v1    # "bodyLength":I
    .local v3, "ifd0Count":I
    :cond_13
    move/from16 v21, v1

    .end local v1    # "bodyLength":I
    .restart local v21    # "bodyLength":I
    new-instance v0, Llocal/mio/os4camerabridge/LegendExifTagger$TiffParseException;

    const-string v1, "IFD0 entries out of bounds"

    invoke-direct {v0, v1}, Llocal/mio/os4camerabridge/LegendExifTagger$TiffParseException;-><init>(Ljava/lang/String;)V

    throw v0

    .line 173
    .end local v3    # "ifd0Count":I
    .end local v11    # "ifd0Entries":I
    .end local v21    # "bodyLength":I
    .restart local v1    # "bodyLength":I
    :cond_14
    move/from16 v21, v1

    move-object/from16 v28, v2

    move/from16 v23, v6

    .line 174
    .end local v1    # "bodyLength":I
    .end local v2    # "body":[B
    .end local v6    # "first":I
    .restart local v21    # "bodyLength":I
    .restart local v23    # "first":I
    .restart local v28    # "body":[B
    new-instance v0, Llocal/mio/os4camerabridge/LegendExifTagger$TiffParseException;

    const-string v1, "IFD0 out of bounds"

    invoke-direct {v0, v1}, Llocal/mio/os4camerabridge/LegendExifTagger$TiffParseException;-><init>(Ljava/lang/String;)V

    throw v0

    .line 166
    .end local v8    # "littleEndian":Z
    .end local v10    # "ifd0":I
    .end local v21    # "bodyLength":I
    .end local v23    # "first":I
    .end local v28    # "body":[B
    .restart local v1    # "bodyLength":I
    .restart local v2    # "body":[B
    .restart local v6    # "first":I
    :cond_15
    move/from16 v21, v1

    move-object/from16 v28, v2

    move/from16 v23, v6

    .line 169
    .end local v1    # "bodyLength":I
    .end local v2    # "body":[B
    .end local v6    # "first":I
    .restart local v21    # "bodyLength":I
    .restart local v23    # "first":I
    .restart local v28    # "body":[B
    new-instance v0, Llocal/mio/os4camerabridge/LegendExifTagger$TiffParseException;

    const-string v1, "bad byte order"

    invoke-direct {v0, v1}, Llocal/mio/os4camerabridge/LegendExifTagger$TiffParseException;-><init>(Ljava/lang/String;)V

    throw v0

    .line 158
    .end local v7    # "second":I
    .end local v21    # "bodyLength":I
    .end local v23    # "first":I
    .end local v28    # "body":[B
    .restart local v1    # "bodyLength":I
    .restart local v2    # "body":[B
    :cond_16
    move/from16 v21, v1

    move-object/from16 v28, v2

    .line 159
    .end local v1    # "bodyLength":I
    .end local v2    # "body":[B
    .restart local v21    # "bodyLength":I
    .restart local v28    # "body":[B
    new-instance v0, Llocal/mio/os4camerabridge/LegendExifTagger$TiffParseException;

    const-string v1, "bad EXIF body"

    invoke-direct {v0, v1}, Llocal/mio/os4camerabridge/LegendExifTagger$TiffParseException;-><init>(Ljava/lang/String;)V

    throw v0
.end method

.method private static insertAfterSoi([B[B)[B
    .locals 4
    .param p0, "jpeg"    # [B
    .param p1, "segment"    # [B

    .line 332
    array-length v0, p0

    array-length v1, p1

    add-int/2addr v0, v1

    new-array v0, v0, [B

    .line 333
    .local v0, "output":[B
    const/4 v1, 0x0

    aget-byte v2, p0, v1

    aput-byte v2, v0, v1

    .line 334
    const/4 v2, 0x1

    aget-byte v3, p0, v2

    aput-byte v3, v0, v2

    .line 335
    array-length v2, p1

    const/4 v3, 0x2

    invoke-static {p1, v1, v0, v3, v2}, Ljava/lang/System;->arraycopy(Ljava/lang/Object;ILjava/lang/Object;II)V

    .line 336
    array-length v1, p1

    add-int/2addr v1, v3

    array-length v2, p0

    sub-int/2addr v2, v3

    invoke-static {p0, v3, v0, v1, v2}, Ljava/lang/System;->arraycopy(Ljava/lang/Object;ILjava/lang/Object;II)V

    .line 338
    return-object v0
.end method

.method static synthetic lambda$injectIntoExisting$0(Z[B)I
    .locals 1
    .param p0, "littleEndian"    # Z
    .param p1, "value"    # [B

    .line 248
    const/4 v0, 0x0

    invoke-static {p1, v0, p0}, Llocal/mio/os4camerabridge/LegendExifTagger;->getU16([BIZ)I

    move-result v0

    return v0
.end method

.method private static legendEntry(ZI)[B
    .locals 2
    .param p0, "littleEndian"    # Z
    .param p1, "mode"    # I

    .line 282
    const/16 v0, 0xc

    new-array v0, v0, [B

    .line 283
    .local v0, "entry":[B
    const/4 v1, 0x0

    invoke-static {v0, v1, p0, p1}, Llocal/mio/os4camerabridge/LegendExifTagger;->writeLegendEntry([BIZI)V

    .line 284
    return-object v0
.end method

.method private static putU16([BIZI)V
    .locals 2
    .param p0, "bytes"    # [B
    .param p1, "offset"    # I
    .param p2, "littleEndian"    # Z
    .param p3, "value"    # I

    .line 353
    if-eqz p2, :cond_0

    .line 354
    and-int/lit16 v0, p3, 0xff

    int-to-byte v0, v0

    aput-byte v0, p0, p1

    .line 355
    add-int/lit8 v0, p1, 0x1

    ushr-int/lit8 v1, p3, 0x8

    and-int/lit16 v1, v1, 0xff

    int-to-byte v1, v1

    aput-byte v1, p0, v0

    goto :goto_0

    .line 357
    :cond_0
    ushr-int/lit8 v0, p3, 0x8

    and-int/lit16 v0, v0, 0xff

    int-to-byte v0, v0

    aput-byte v0, p0, p1

    .line 358
    add-int/lit8 v0, p1, 0x1

    and-int/lit16 v1, p3, 0xff

    int-to-byte v1, v1

    aput-byte v1, p0, v0

    .line 360
    :goto_0
    return-void
.end method

.method private static putU32([BIZJ)V
    .locals 8
    .param p0, "bytes"    # [B
    .param p1, "offset"    # I
    .param p2, "littleEndian"    # Z
    .param p3, "value"    # J

    .line 364
    const/16 v0, 0x8

    const/16 v1, 0x10

    const/16 v2, 0x18

    const-wide/16 v3, 0xff

    if-eqz p2, :cond_0

    .line 365
    and-long v5, p3, v3

    long-to-int v5, v5

    int-to-byte v5, v5

    aput-byte v5, p0, p1

    .line 366
    add-int/lit8 v5, p1, 0x1

    ushr-long v6, p3, v0

    and-long/2addr v6, v3

    long-to-int v0, v6

    int-to-byte v0, v0

    aput-byte v0, p0, v5

    .line 367
    add-int/lit8 v0, p1, 0x2

    ushr-long v5, p3, v1

    and-long/2addr v5, v3

    long-to-int v1, v5

    int-to-byte v1, v1

    aput-byte v1, p0, v0

    .line 368
    add-int/lit8 v0, p1, 0x3

    ushr-long v1, p3, v2

    and-long/2addr v1, v3

    long-to-int v1, v1

    int-to-byte v1, v1

    aput-byte v1, p0, v0

    goto :goto_0

    .line 370
    :cond_0
    ushr-long v5, p3, v2

    and-long/2addr v5, v3

    long-to-int v2, v5

    int-to-byte v2, v2

    aput-byte v2, p0, p1

    .line 371
    add-int/lit8 v2, p1, 0x1

    ushr-long v5, p3, v1

    and-long/2addr v5, v3

    long-to-int v1, v5

    int-to-byte v1, v1

    aput-byte v1, p0, v2

    .line 372
    add-int/lit8 v1, p1, 0x2

    ushr-long v5, p3, v0

    and-long/2addr v5, v3

    long-to-int v0, v5

    int-to-byte v0, v0

    aput-byte v0, p0, v1

    .line 373
    add-int/lit8 v0, p1, 0x3

    and-long v1, p3, v3

    long-to-int v1, v1

    int-to-byte v1, v1

    aput-byte v1, p0, v0

    .line 375
    :goto_0
    return-void
.end method

.method static read([B)I
    .locals 5
    .param p0, "jpeg"    # [B

    .line 48
    invoke-static {p0}, Llocal/mio/os4camerabridge/LegendExifTagger;->findExifSegment([B)[I

    move-result-object v0

    .line 49
    .local v0, "exif":[I
    if-nez v0, :cond_0

    .line 50
    const/4 v1, -0x1

    return v1

    .line 52
    :cond_0
    const/4 v1, 0x1

    aget v1, v0, v1

    add-int/lit8 v1, v1, -0x4

    .line 53
    .local v1, "bodyLength":I
    new-array v2, v1, [B

    .line 54
    .local v2, "body":[B
    const/4 v3, 0x0

    aget v4, v0, v3

    add-int/lit8 v4, v4, 0x4

    invoke-static {p0, v4, v2, v3, v1}, Ljava/lang/System;->arraycopy(Ljava/lang/Object;ILjava/lang/Object;II)V

    .line 55
    invoke-static {v2}, Llocal/mio/os4camerabridge/LegendExifTagger;->readFromExifBody([B)I

    move-result v3

    return v3
.end method

.method private static readFromExifBody([B)I
    .locals 9
    .param p0, "body"    # [B

    .line 89
    array-length v0, p0

    const/16 v1, 0xe

    const/4 v2, -0x1

    if-lt v0, v1, :cond_5

    sget-object v0, Llocal/mio/os4camerabridge/LegendExifTagger;->EXIF_MAGIC:[B

    const/4 v1, 0x0

    invoke-static {p0, v1, v0}, Llocal/mio/os4camerabridge/LegendExifTagger;->startsWith([BI[B)Z

    move-result v0

    if-nez v0, :cond_0

    goto :goto_1

    .line 93
    :cond_0
    const/4 v0, 0x6

    aget-byte v3, p0, v0

    and-int/lit16 v3, v3, 0xff

    .line 94
    .local v3, "first":I
    const/4 v4, 0x7

    aget-byte v4, p0, v4

    and-int/lit16 v4, v4, 0xff

    .line 95
    .local v4, "second":I
    const/16 v5, 0x49

    if-ne v3, v5, :cond_1

    if-ne v4, v5, :cond_1

    .line 96
    const/4 v5, 0x1

    .local v5, "littleEndian":Z
    goto :goto_0

    .line 97
    .end local v5    # "littleEndian":Z
    :cond_1
    const/16 v5, 0x4d

    if-ne v3, v5, :cond_4

    if-ne v4, v5, :cond_4

    .line 98
    const/4 v5, 0x0

    .line 102
    .restart local v5    # "littleEndian":Z
    :goto_0
    const/16 v6, 0xa

    invoke-static {p0, v6, v5}, Llocal/mio/os4camerabridge/LegendExifTagger;->u32([BIZ)J

    move-result-wide v6

    long-to-int v6, v6

    invoke-static {p0, v0, v6, v5}, Llocal/mio/os4camerabridge/LegendExifTagger;->scanIfd([BIIZ)[I

    move-result-object v6

    .line 104
    .local v6, "scan":[I
    aget v7, v6, v1

    if-eq v7, v2, :cond_2

    .line 105
    aget v0, v6, v1

    return v0

    .line 107
    :cond_2
    const/4 v7, 0x1

    aget v8, v6, v7

    if-eq v8, v2, :cond_3

    .line 108
    aget v2, v6, v7

    invoke-static {p0, v0, v2, v5}, Llocal/mio/os4camerabridge/LegendExifTagger;->scanIfd([BIIZ)[I

    move-result-object v0

    aget v0, v0, v1

    return v0

    .line 110
    :cond_3
    return v2

    .line 100
    .end local v5    # "littleEndian":Z
    .end local v6    # "scan":[I
    :cond_4
    return v2

    .line 90
    .end local v3    # "first":I
    .end local v4    # "second":I
    :cond_5
    :goto_1
    return v2
.end method

.method private static requireJpeg([B)V
    .locals 2
    .param p0, "jpeg"    # [B

    .line 425
    if-eqz p0, :cond_0

    array-length v0, p0

    const/4 v1, 0x4

    if-lt v0, v1, :cond_0

    const/4 v0, 0x0

    aget-byte v0, p0, v0

    const/16 v1, 0xff

    and-int/2addr v0, v1

    if-ne v0, v1, :cond_0

    const/4 v0, 0x1

    aget-byte v0, p0, v0

    and-int/2addr v0, v1

    const/16 v1, 0xd8

    if-ne v0, v1, :cond_0

    .line 430
    return-void

    .line 428
    :cond_0
    new-instance v0, Ljava/lang/IllegalArgumentException;

    const-string v1, "input is not a JPEG"

    invoke-direct {v0, v1}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw v0
.end method

.method private static scanIfd([BIIZ)[I
    .locals 18
    .param p0, "body"    # [B
    .param p1, "tiffStart"    # I
    .param p2, "relative"    # I
    .param p3, "littleEndian"    # Z

    .line 115
    move-object/from16 v0, p0

    move/from16 v1, p3

    add-int v2, p1, p2

    .line 116
    .local v2, "start":I
    const/4 v3, -0x1

    if-ltz p2, :cond_b

    add-int/lit8 v4, v2, 0x2

    array-length v5, v0

    if-le v4, v5, :cond_0

    goto/16 :goto_4

    .line 119
    :cond_0
    invoke-static {v0, v2, v1}, Llocal/mio/os4camerabridge/LegendExifTagger;->u16([BIZ)I

    move-result v4

    .line 120
    .local v4, "count":I
    add-int/lit8 v5, v2, 0x2

    .line 121
    .local v5, "entries":I
    mul-int/lit8 v6, v4, 0xc

    add-int/2addr v6, v5

    array-length v7, v0

    if-le v6, v7, :cond_1

    .line 122
    filled-new-array {v3, v3}, [I

    move-result-object v3

    return-object v3

    .line 124
    :cond_1
    const/4 v6, -0x1

    .line 125
    .local v6, "exifIfd":I
    const/4 v7, 0x0

    .local v7, "index":I
    :goto_0
    if-ge v7, v4, :cond_a

    .line 126
    mul-int/lit8 v8, v7, 0xc

    add-int/2addr v8, v5

    .line 127
    .local v8, "entry":I
    invoke-static {v0, v8, v1}, Llocal/mio/os4camerabridge/LegendExifTagger;->u16([BIZ)I

    move-result v9

    .line 128
    .local v9, "tag":I
    add-int/lit8 v10, v8, 0x2

    invoke-static {v0, v10, v1}, Llocal/mio/os4camerabridge/LegendExifTagger;->u16([BIZ)I

    move-result v10

    .line 129
    .local v10, "type":I
    add-int/lit8 v11, v8, 0x4

    invoke-static {v0, v11, v1}, Llocal/mio/os4camerabridge/LegendExifTagger;->u32([BIZ)J

    move-result-wide v11

    .line 130
    .local v11, "itemCount":J
    const v13, 0x8769

    const/4 v14, 0x3

    const/4 v15, 0x4

    if-ne v9, v13, :cond_5

    const-wide/16 v16, 0x1

    cmp-long v13, v11, v16

    if-nez v13, :cond_5

    if-eq v10, v14, :cond_3

    if-ne v10, v15, :cond_2

    goto :goto_1

    :cond_2
    move/from16 v16, v4

    goto :goto_3

    .line 131
    :cond_3
    :goto_1
    if-ne v10, v14, :cond_4

    .line 132
    add-int/lit8 v13, v8, 0x8

    invoke-static {v0, v13, v1}, Llocal/mio/os4camerabridge/LegendExifTagger;->u16([BIZ)I

    move-result v13

    move/from16 v16, v4

    goto :goto_2

    .line 133
    :cond_4
    add-int/lit8 v13, v8, 0x8

    move/from16 v16, v4

    .end local v4    # "count":I
    .local v16, "count":I
    invoke-static {v0, v13, v1}, Llocal/mio/os4camerabridge/LegendExifTagger;->u32([BIZ)J

    move-result-wide v3

    long-to-int v13, v3

    :goto_2
    move v6, v13

    .end local v6    # "exifIfd":I
    .local v13, "exifIfd":I
    goto :goto_3

    .line 130
    .end local v13    # "exifIfd":I
    .end local v16    # "count":I
    .restart local v4    # "count":I
    .restart local v6    # "exifIfd":I
    :cond_5
    move/from16 v16, v4

    .line 135
    .end local v4    # "count":I
    .restart local v16    # "count":I
    :goto_3
    const v3, 0x88b0

    if-ne v9, v3, :cond_9

    .line 136
    const/4 v3, 0x1

    if-ne v10, v3, :cond_6

    .line 137
    add-int/lit8 v3, v8, 0x8

    aget-byte v3, v0, v3

    and-int/lit16 v3, v3, 0xff

    filled-new-array {v3, v6}, [I

    move-result-object v3

    return-object v3

    .line 139
    :cond_6
    if-ne v10, v14, :cond_7

    .line 140
    add-int/lit8 v3, v8, 0x8

    invoke-static {v0, v3, v1}, Llocal/mio/os4camerabridge/LegendExifTagger;->u16([BIZ)I

    move-result v3

    filled-new-array {v3, v6}, [I

    move-result-object v3

    return-object v3

    .line 143
    :cond_7
    if-ne v10, v15, :cond_8

    .line 144
    add-int/lit8 v3, v8, 0x8

    invoke-static {v0, v3, v1}, Llocal/mio/os4camerabridge/LegendExifTagger;->u32([BIZ)J

    move-result-wide v3

    long-to-int v3, v3

    filled-new-array {v3, v6}, [I

    move-result-object v3

    return-object v3

    .line 147
    :cond_8
    add-int/lit8 v3, v8, 0x8

    aget-byte v3, v0, v3

    and-int/lit16 v3, v3, 0xff

    filled-new-array {v3, v6}, [I

    move-result-object v3

    return-object v3

    .line 125
    .end local v8    # "entry":I
    .end local v9    # "tag":I
    .end local v10    # "type":I
    .end local v11    # "itemCount":J
    :cond_9
    add-int/lit8 v7, v7, 0x1

    move/from16 v4, v16

    const/4 v3, -0x1

    goto/16 :goto_0

    .line 150
    .end local v7    # "index":I
    .end local v16    # "count":I
    .restart local v4    # "count":I
    :cond_a
    const/4 v3, -0x1

    filled-new-array {v3, v6}, [I

    move-result-object v3

    return-object v3

    .line 117
    .end local v4    # "count":I
    .end local v5    # "entries":I
    .end local v6    # "exifIfd":I
    :cond_b
    :goto_4
    filled-new-array {v3, v3}, [I

    move-result-object v3

    return-object v3
.end method

.method private static startsWith([BI[B)Z
    .locals 4
    .param p0, "bytes"    # [B
    .param p1, "offset"    # I
    .param p2, "prefix"    # [B

    .line 413
    const/4 v0, 0x0

    if-ltz p1, :cond_3

    array-length v1, p2

    add-int/2addr v1, p1

    array-length v2, p0

    if-le v1, v2, :cond_0

    goto :goto_1

    .line 416
    :cond_0
    const/4 v1, 0x0

    .local v1, "index":I
    :goto_0
    array-length v2, p2

    if-ge v1, v2, :cond_2

    .line 417
    add-int v2, p1, v1

    aget-byte v2, p0, v2

    aget-byte v3, p2, v1

    if-eq v2, v3, :cond_1

    .line 418
    return v0

    .line 416
    :cond_1
    add-int/lit8 v1, v1, 0x1

    goto :goto_0

    .line 421
    .end local v1    # "index":I
    :cond_2
    const/4 v0, 0x1

    return v0

    .line 414
    :cond_3
    :goto_1
    return v0
.end method

.method static tag([BI)[B
    .locals 8
    .param p0, "jpeg"    # [B
    .param p1, "mode"    # I

    .line 25
    invoke-static {p0}, Llocal/mio/os4camerabridge/LegendExifTagger;->requireJpeg([B)V

    .line 26
    invoke-static {p0}, Llocal/mio/os4camerabridge/LegendExifTagger;->findExifSegment([B)[I

    move-result-object v0

    .line 27
    .local v0, "exif":[I
    if-nez v0, :cond_0

    .line 28
    invoke-static {p1}, Llocal/mio/os4camerabridge/LegendExifTagger;->buildMinimalExifApp1(I)[B

    move-result-object v1

    invoke-static {p0, v1}, Llocal/mio/os4camerabridge/LegendExifTagger;->insertAfterSoi([B[B)[B

    move-result-object v1

    return-object v1

    .line 32
    :cond_0
    const/4 v1, 0x1

    const/4 v2, 0x0

    :try_start_0
    aget v3, v0, v2

    aget v4, v0, v1

    invoke-static {p0, v3, v4, p1}, Llocal/mio/os4camerabridge/LegendExifTagger;->injectIntoExisting([BIII)[B

    move-result-object v3
    :try_end_0
    .catch Llocal/mio/os4camerabridge/LegendExifTagger$TiffParseException; {:try_start_0 .. :try_end_0} :catch_0

    .line 37
    .local v3, "replacement":[B
    goto :goto_0

    .line 33
    .end local v3    # "replacement":[B
    :catch_0
    move-exception v3

    .line 36
    .local v3, "exception":Llocal/mio/os4camerabridge/LegendExifTagger$TiffParseException;
    invoke-static {p1}, Llocal/mio/os4camerabridge/LegendExifTagger;->buildMinimalExifApp1(I)[B

    move-result-object v4

    move-object v3, v4

    .line 38
    .local v3, "replacement":[B
    :goto_0
    array-length v4, p0

    aget v5, v0, v1

    sub-int/2addr v4, v5

    array-length v5, v3

    add-int/2addr v4, v5

    new-array v4, v4, [B

    .line 39
    .local v4, "output":[B
    aget v5, v0, v2

    invoke-static {p0, v2, v4, v2, v5}, Ljava/lang/System;->arraycopy(Ljava/lang/Object;ILjava/lang/Object;II)V

    .line 40
    aget v5, v0, v2

    array-length v6, v3

    invoke-static {v3, v2, v4, v5, v6}, Ljava/lang/System;->arraycopy(Ljava/lang/Object;ILjava/lang/Object;II)V

    .line 41
    aget v5, v0, v2

    aget v6, v0, v1

    add-int/2addr v5, v6

    aget v6, v0, v2

    array-length v7, v3

    add-int/2addr v6, v7

    array-length v7, p0

    aget v2, v0, v2

    sub-int/2addr v7, v2

    aget v1, v0, v1

    sub-int/2addr v7, v1

    invoke-static {p0, v5, v4, v6, v7}, Ljava/lang/System;->arraycopy(Ljava/lang/Object;ILjava/lang/Object;II)V

    .line 44
    return-object v4
.end method

.method private static u16([BIZ)I
    .locals 3
    .param p0, "bytes"    # [B
    .param p1, "offset"    # I
    .param p2, "littleEndian"    # Z

    .line 383
    aget-byte v0, p0, p1

    and-int/lit16 v0, v0, 0xff

    .line 384
    .local v0, "first":I
    add-int/lit8 v1, p1, 0x1

    aget-byte v1, p0, v1

    and-int/lit16 v1, v1, 0xff

    .line 385
    .local v1, "second":I
    if-eqz p2, :cond_0

    shl-int/lit8 v2, v1, 0x8

    or-int/2addr v2, v0

    goto :goto_0

    :cond_0
    shl-int/lit8 v2, v0, 0x8

    or-int/2addr v2, v1

    :goto_0
    return v2
.end method

.method private static u16be([BI)I
    .locals 2
    .param p0, "bytes"    # [B
    .param p1, "offset"    # I

    .line 378
    aget-byte v0, p0, p1

    and-int/lit16 v0, v0, 0xff

    shl-int/lit8 v0, v0, 0x8

    add-int/lit8 v1, p1, 0x1

    aget-byte v1, p0, v1

    and-int/lit16 v1, v1, 0xff

    or-int/2addr v0, v1

    return v0
.end method

.method private static u32([BIZ)J
    .locals 14
    .param p0, "bytes"    # [B
    .param p1, "offset"    # I
    .param p2, "littleEndian"    # Z

    .line 390
    aget-byte v0, p0, p1

    int-to-long v0, v0

    const-wide/16 v2, 0xff

    and-long/2addr v0, v2

    .line 391
    .local v0, "a":J
    add-int/lit8 v4, p1, 0x1

    aget-byte v4, p0, v4

    int-to-long v4, v4

    and-long/2addr v4, v2

    .line 392
    .local v4, "b":J
    add-int/lit8 v6, p1, 0x2

    aget-byte v6, p0, v6

    int-to-long v6, v6

    and-long/2addr v6, v2

    .line 393
    .local v6, "c":J
    add-int/lit8 v8, p1, 0x3

    aget-byte v8, p0, v8

    int-to-long v8, v8

    and-long/2addr v2, v8

    .line 394
    .local v2, "d":J
    const/16 v8, 0x8

    const/16 v9, 0x10

    const/16 v10, 0x18

    if-eqz p2, :cond_0

    .line 395
    shl-long v11, v4, v8

    or-long/2addr v11, v0

    shl-long v8, v6, v9

    or-long/2addr v8, v11

    shl-long v10, v2, v10

    or-long/2addr v8, v10

    goto :goto_0

    .line 396
    :cond_0
    shl-long v10, v0, v10

    shl-long v12, v4, v9

    or-long v9, v10, v12

    shl-long v11, v6, v8

    or-long v8, v9, v11

    or-long/2addr v8, v2

    .line 394
    :goto_0
    return-wide v8
.end method

.method private static writeLegendEntry([BIZI)V
    .locals 3
    .param p0, "bytes"    # [B
    .param p1, "offset"    # I
    .param p2, "littleEndian"    # Z
    .param p3, "mode"    # I

    .line 289
    const v0, 0x88b0

    invoke-static {p0, p1, p2, v0}, Llocal/mio/os4camerabridge/LegendExifTagger;->putU16([BIZI)V

    .line 290
    add-int/lit8 v0, p1, 0x2

    const/4 v1, 0x1

    invoke-static {p0, v0, p2, v1}, Llocal/mio/os4camerabridge/LegendExifTagger;->putU16([BIZI)V

    .line 291
    add-int/lit8 v0, p1, 0x4

    const-wide/16 v1, 0x1

    invoke-static {p0, v0, p2, v1, v2}, Llocal/mio/os4camerabridge/LegendExifTagger;->putU32([BIZJ)V

    .line 292
    add-int/lit8 v0, p1, 0x8

    and-int/lit16 v1, p3, 0xff

    int-to-byte v1, v1

    aput-byte v1, p0, v0

    .line 293
    add-int/lit8 v0, p1, 0x9

    const/4 v1, 0x0

    aput-byte v1, p0, v0

    .line 294
    add-int/lit8 v0, p1, 0xa

    aput-byte v1, p0, v0

    .line 295
    add-int/lit8 v0, p1, 0xb

    aput-byte v1, p0, v0

    .line 296
    return-void
.end method

.method private static writeU16le(Ljava/io/ByteArrayOutputStream;I)V
    .locals 1
    .param p0, "output"    # Ljava/io/ByteArrayOutputStream;
    .param p1, "value"    # I

    .line 400
    and-int/lit16 v0, p1, 0xff

    invoke-virtual {p0, v0}, Ljava/io/ByteArrayOutputStream;->write(I)V

    .line 401
    ushr-int/lit8 v0, p1, 0x8

    and-int/lit16 v0, v0, 0xff

    invoke-virtual {p0, v0}, Ljava/io/ByteArrayOutputStream;->write(I)V

    .line 402
    return-void
.end method

.method private static writeU32le(Ljava/io/ByteArrayOutputStream;I)V
    .locals 1
    .param p0, "output"    # Ljava/io/ByteArrayOutputStream;
    .param p1, "value"    # I

    .line 405
    and-int/lit16 v0, p1, 0xff

    invoke-virtual {p0, v0}, Ljava/io/ByteArrayOutputStream;->write(I)V

    .line 406
    ushr-int/lit8 v0, p1, 0x8

    and-int/lit16 v0, v0, 0xff

    invoke-virtual {p0, v0}, Ljava/io/ByteArrayOutputStream;->write(I)V

    .line 407
    ushr-int/lit8 v0, p1, 0x10

    and-int/lit16 v0, v0, 0xff

    invoke-virtual {p0, v0}, Ljava/io/ByteArrayOutputStream;->write(I)V

    .line 408
    ushr-int/lit8 v0, p1, 0x18

    and-int/lit16 v0, v0, 0xff

    invoke-virtual {p0, v0}, Ljava/io/ByteArrayOutputStream;->write(I)V

    .line 409
    return-void
.end method
