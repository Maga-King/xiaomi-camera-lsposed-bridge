.class public final Llocal/mio/os4camerabridge/LegendaryContainerIntegrity;
.super Ljava/lang/Object;
.source "LegendaryContainerIntegrity.java"


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Llocal/mio/os4camerabridge/LegendaryContainerIntegrity$Segment;,
        Llocal/mio/os4camerabridge/LegendaryContainerIntegrity$Edit;
    }
.end annotation


# static fields
.field private static final CONTAINER:Ljava/lang/String; = "http://ns.google.com/photos/1.0/container/"

.field private static final GOOGLE:Ljava/lang/String; = "http://ns.google.com/photos/1.0/container/item/"

.field private static final HDR:Ljava/lang/String; = "http://ns.adobe.com/hdr-gain-map/1.0/"

.field private static final MI:Ljava/lang/String; = "http://ns.xiaomi.com/photos/1.0/container/item/"

.field private static final XMLNS:Ljava/lang/String; = "http://www.w3.org/2000/xmlns/"

.field private static final XMP:[B


# direct methods
.method static constructor <clinit>()V
    .locals 2

    .line 26
    const-string v0, "http://ns.adobe.com/xap/1.0/\u0000"

    sget-object v1, Ljava/nio/charset/StandardCharsets;->UTF_8:Ljava/nio/charset/Charset;

    invoke-virtual {v0, v1}, Ljava/lang/String;->getBytes(Ljava/nio/charset/Charset;)[B

    move-result-object v0

    sput-object v0, Llocal/mio/os4camerabridge/LegendaryContainerIntegrity;->XMP:[B

    return-void
.end method

.method private constructor <init>()V
    .locals 0

    .line 28
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method private static elements(Lorg/w3c/dom/Document;)Ljava/util/List;
    .locals 3
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Lorg/w3c/dom/Document;",
            ")",
            "Ljava/util/List<",
            "Lorg/w3c/dom/Element;",
            ">;"
        }
    .end annotation

    .line 219
    new-instance v0, Ljava/util/ArrayList;

    invoke-direct {v0}, Ljava/util/ArrayList;-><init>()V

    .line 220
    const-string v1, "*"

    invoke-interface {p0, v1}, Lorg/w3c/dom/Document;->getElementsByTagName(Ljava/lang/String;)Lorg/w3c/dom/NodeList;

    move-result-object p0

    .line 221
    const/4 v1, 0x0

    :goto_0
    invoke-interface {p0}, Lorg/w3c/dom/NodeList;->getLength()I

    move-result v2

    if-ge v1, v2, :cond_0

    invoke-interface {p0, v1}, Lorg/w3c/dom/NodeList;->item(I)Lorg/w3c/dom/Node;

    move-result-object v2

    check-cast v2, Lorg/w3c/dom/Element;

    invoke-interface {v0, v2}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    add-int/lit8 v1, v1, 0x1

    goto :goto_0

    .line 222
    :cond_0
    return-object v0
.end method

.method public static hasCompletePrimaryJpeg([B)Z
    .locals 3

    .line 32
    const/4 v0, 0x0

    if-eqz p0, :cond_4

    array-length v1, p0

    const/4 v2, 0x4

    if-ge v1, v2, :cond_0

    goto :goto_1

    .line 34
    :cond_0
    :try_start_0
    invoke-static {p0}, Llocal/mio/os4camerabridge/JpegWatermarkMetadataPolicy;->dimensions([B)[I

    move-result-object v1

    .line 35
    if-eqz v1, :cond_3

    aget v2, v1, v0

    if-lez v2, :cond_3

    const/4 v2, 0x1

    aget v1, v1, v2

    if-gtz v1, :cond_1

    goto :goto_0

    .line 36
    :cond_1
    invoke-static {p0}, Llocal/mio/os4camerabridge/LegendaryContainerIntegrity;->headers([B)Ljava/util/List;

    .line 37
    array-length v1, p0

    invoke-static {p0, v0, v1}, Llocal/mio/os4camerabridge/LegendaryContainerIntegrity;->jpegEnd([BII)I

    move-result p0
    :try_end_0
    .catch Ljava/lang/RuntimeException; {:try_start_0 .. :try_end_0} :catch_0

    const/4 v1, 0x2

    if-le p0, v1, :cond_2

    move v0, v2

    :cond_2
    return v0

    .line 35
    :cond_3
    :goto_0
    return v0

    .line 38
    :catch_0
    move-exception p0

    return v0

    .line 32
    :cond_4
    :goto_1
    return v0
.end method

.method private static headers([B)Ljava/util/List;
    .locals 8
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "([B)",
            "Ljava/util/List<",
            "Llocal/mio/os4camerabridge/LegendaryContainerIntegrity$Segment;",
            ">;"
        }
    .end annotation

    .line 230
    const/4 v0, 0x2

    new-array v1, v0, [B

    fill-array-data v1, :array_0

    const/4 v2, 0x0

    invoke-static {p0, v2, v1}, Llocal/mio/os4camerabridge/LegendaryContainerIntegrity;->starts([BI[B)Z

    move-result v1

    if-eqz v1, :cond_7

    .line 231
    new-instance v1, Ljava/util/ArrayList;

    invoke-direct {v1}, Ljava/util/ArrayList;-><init>()V

    .line 232
    move v3, v0

    :goto_0
    array-length v4, p0

    if-ge v3, v4, :cond_6

    .line 233
    nop

    .line 234
    add-int/lit8 v4, v3, 0x1

    aget-byte v5, p0, v3

    const/16 v6, 0xff

    and-int/2addr v5, v6

    if-ne v5, v6, :cond_5

    .line 235
    :goto_1
    array-length v5, p0

    if-ge v4, v5, :cond_0

    aget-byte v5, p0, v4

    and-int/2addr v5, v6

    if-ne v5, v6, :cond_0

    add-int/lit8 v4, v4, 0x1

    goto :goto_1

    .line 236
    :cond_0
    array-length v5, p0

    if-ge v4, v5, :cond_4

    .line 237
    add-int/lit8 v5, v4, 0x1

    aget-byte v4, p0, v4

    and-int/2addr v4, v6

    .line 238
    const/16 v6, 0xda

    if-eq v4, v6, :cond_3

    const/16 v6, 0xd9

    if-ne v4, v6, :cond_1

    goto :goto_2

    .line 239
    :cond_1
    invoke-static {p0, v5, v2}, Llocal/mio/os4camerabridge/LegendaryContainerIntegrity;->u16([BIZ)I

    move-result v6

    .line 240
    if-lt v6, v0, :cond_2

    array-length v7, p0

    sub-int/2addr v7, v6

    if-gt v5, v7, :cond_2

    .line 241
    new-instance v7, Llocal/mio/os4camerabridge/LegendaryContainerIntegrity$Segment;

    add-int/2addr v5, v6

    invoke-direct {v7, v4, v3, v5}, Llocal/mio/os4camerabridge/LegendaryContainerIntegrity$Segment;-><init>(III)V

    invoke-interface {v1, v7}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    .line 242
    move v3, v5

    goto :goto_0

    .line 240
    :cond_2
    new-instance p0, Ljava/lang/IllegalArgumentException;

    const-string v0, "JPEG segment bounds"

    invoke-direct {p0, v0}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw p0

    .line 238
    :cond_3
    :goto_2
    return-object v1

    .line 236
    :cond_4
    new-instance p0, Ljava/lang/IllegalArgumentException;

    const-string v0, "JPEG marker truncated"

    invoke-direct {p0, v0}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw p0

    .line 234
    :cond_5
    new-instance p0, Ljava/lang/IllegalArgumentException;

    const-string v0, "JPEG header boundary"

    invoke-direct {p0, v0}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw p0

    .line 243
    :cond_6
    new-instance p0, Ljava/lang/IllegalArgumentException;

    const-string v0, "JPEG scan missing"

    invoke-direct {p0, v0}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw p0

    .line 230
    :cond_7
    new-instance p0, Ljava/lang/IllegalArgumentException;

    const-string v0, "not JPEG"

    invoke-direct {p0, v0}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw p0

    :array_0
    .array-data 1
        -0x1t
        -0x28t
    .end array-data
.end method

.method private static jpegEnd([BII)I
    .locals 6

    .line 246
    const/4 v0, 0x2

    add-int/2addr p1, v0

    const/4 v1, 0x0

    move v2, v1

    .line 247
    :cond_0
    :goto_0
    if-ge p1, p2, :cond_b

    .line 248
    const/16 v3, 0xff

    if-eqz v2, :cond_1

    :goto_1
    if-ge p1, p2, :cond_1

    aget-byte v4, p0, p1

    and-int/2addr v4, v3

    if-eq v4, v3, :cond_1

    add-int/lit8 p1, p1, 0x1

    goto :goto_1

    .line 249
    :cond_1
    if-ge p1, p2, :cond_a

    add-int/lit8 v4, p1, 0x1

    aget-byte p1, p0, p1

    and-int/2addr p1, v3

    if-ne p1, v3, :cond_a

    .line 250
    :goto_2
    if-ge v4, p2, :cond_2

    aget-byte p1, p0, v4

    and-int/2addr p1, v3

    if-ne p1, v3, :cond_2

    add-int/lit8 v4, v4, 0x1

    goto :goto_2

    .line 251
    :cond_2
    if-ge v4, p2, :cond_9

    .line 252
    add-int/lit8 p1, v4, 0x1

    aget-byte v4, p0, v4

    and-int/2addr v3, v4

    .line 253
    if-eqz v2, :cond_4

    if-eqz v3, :cond_3

    const/16 v4, 0xd0

    if-lt v3, v4, :cond_4

    const/16 v4, 0xd7

    if-gt v3, v4, :cond_4

    :cond_3
    goto :goto_0

    .line 254
    :cond_4
    const/16 v4, 0xd9

    if-ne v3, v4, :cond_5

    return p1

    .line 255
    :cond_5
    const/16 v4, 0xd8

    if-eq v3, v4, :cond_0

    const/4 v4, 0x1

    if-ne v3, v4, :cond_6

    goto :goto_0

    .line 256
    :cond_6
    invoke-static {p0, p1, v1}, Llocal/mio/os4camerabridge/LegendaryContainerIntegrity;->u16([BIZ)I

    move-result v2

    .line 257
    if-lt v2, v0, :cond_8

    sub-int v5, p2, v2

    if-gt p1, v5, :cond_8

    .line 258
    add-int/2addr p1, v2

    const/16 v2, 0xda

    if-ne v3, v2, :cond_7

    move v2, v4

    goto :goto_3

    :cond_7
    move v2, v1

    .line 259
    :goto_3
    goto :goto_0

    .line 257
    :cond_8
    new-instance p0, Ljava/lang/IllegalArgumentException;

    const-string p1, "JPEG scan length"

    invoke-direct {p0, p1}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw p0

    .line 251
    :cond_9
    new-instance p0, Ljava/lang/IllegalArgumentException;

    const-string p1, "JPEG scan truncated"

    invoke-direct {p0, p1}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw p0

    .line 249
    :cond_a
    new-instance p0, Ljava/lang/IllegalArgumentException;

    const-string p1, "JPEG scan boundary"

    invoke-direct {p0, p1}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw p0

    .line 260
    :cond_b
    new-instance p0, Ljava/lang/IllegalArgumentException;

    const-string p1, "JPEG EOI absent"

    invoke-direct {p0, p1}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw p0
.end method

.method static synthetic lambda$repair$0(Llocal/mio/os4camerabridge/LegendaryContainerIntegrity$Edit;Llocal/mio/os4camerabridge/LegendaryContainerIntegrity$Edit;)I
    .locals 0

    .line 162
    iget p0, p0, Llocal/mio/os4camerabridge/LegendaryContainerIntegrity$Edit;->start:I

    iget p1, p1, Llocal/mio/os4camerabridge/LegendaryContainerIntegrity$Edit;->start:I

    invoke-static {p0, p1}, Ljava/lang/Integer;->compare(II)I

    move-result p0

    return p0
.end method

.method private static position(ILjava/util/List;)I
    .locals 4
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(I",
            "Ljava/util/List<",
            "Llocal/mio/os4camerabridge/LegendaryContainerIntegrity$Edit;",
            ">;)I"
        }
    .end annotation

    .line 200
    nop

    .line 201
    invoke-interface {p1}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object p1

    const/4 v0, 0x0

    :goto_0
    invoke-interface {p1}, Ljava/util/Iterator;->hasNext()Z

    move-result v1

    if-eqz v1, :cond_2

    invoke-interface {p1}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Llocal/mio/os4camerabridge/LegendaryContainerIntegrity$Edit;

    .line 202
    iget v2, v1, Llocal/mio/os4camerabridge/LegendaryContainerIntegrity$Edit;->end:I

    if-lt p0, v2, :cond_0

    iget-object v2, v1, Llocal/mio/os4camerabridge/LegendaryContainerIntegrity$Edit;->bytes:[B

    array-length v2, v2

    iget v3, v1, Llocal/mio/os4camerabridge/LegendaryContainerIntegrity$Edit;->end:I

    iget v1, v1, Llocal/mio/os4camerabridge/LegendaryContainerIntegrity$Edit;->start:I

    sub-int/2addr v3, v1

    sub-int/2addr v2, v3

    add-int/2addr v0, v2

    goto :goto_1

    .line 203
    :cond_0
    iget v1, v1, Llocal/mio/os4camerabridge/LegendaryContainerIntegrity$Edit;->start:I

    if-gt p0, v1, :cond_1

    .line 204
    :goto_1
    goto :goto_0

    .line 203
    :cond_1
    new-instance p0, Ljava/lang/IllegalArgumentException;

    const-string p1, "MPF points inside edited header"

    invoke-direct {p0, p1}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw p0

    .line 205
    :cond_2
    add-int/2addr p0, v0

    return p0
.end method

.method private static put32([BIIZ)V
    .locals 3

    .line 216
    const/4 v0, 0x0

    :goto_0
    const/4 v1, 0x4

    if-ge v0, v1, :cond_1

    add-int v1, p1, v0

    if-eqz p3, :cond_0

    mul-int/lit8 v2, v0, 0x8

    goto :goto_1

    :cond_0
    rsub-int/lit8 v2, v0, 0x3

    mul-int/lit8 v2, v2, 0x8

    :goto_1
    ushr-int v2, p2, v2

    int-to-byte v2, v2

    aput-byte v2, p0, v1

    add-int/lit8 v0, v0, 0x1

    goto :goto_0

    .line 217
    :cond_1
    return-void
.end method

.method private static relocateMpf([B[BLlocal/mio/os4camerabridge/LegendaryContainerIntegrity$Segment;Ljava/util/List;)V
    .locals 19
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "([B[B",
            "Llocal/mio/os4camerabridge/LegendaryContainerIntegrity$Segment;",
            "Ljava/util/List<",
            "Llocal/mio/os4camerabridge/LegendaryContainerIntegrity$Edit;",
            ">;)V"
        }
    .end annotation

    .line 179
    move-object/from16 v0, p0

    move-object/from16 v1, p1

    move-object/from16 v2, p2

    move-object/from16 v3, p3

    iget v4, v2, Llocal/mio/os4camerabridge/LegendaryContainerIntegrity$Segment;->start:I

    add-int/lit8 v4, v4, 0x8

    invoke-static {v4, v3}, Llocal/mio/os4camerabridge/LegendaryContainerIntegrity;->position(ILjava/util/List;)I

    move-result v5

    .line 180
    aget-byte v6, v0, v4

    const/16 v8, 0x49

    if-ne v6, v8, :cond_0

    add-int/lit8 v6, v4, 0x1

    aget-byte v6, v0, v6

    if-ne v6, v8, :cond_0

    const/4 v6, 0x1

    goto :goto_0

    :cond_0
    const/4 v6, 0x0

    .line 181
    :goto_0
    if-nez v6, :cond_2

    aget-byte v8, v0, v4

    const/16 v9, 0x4d

    if-ne v8, v9, :cond_1

    add-int/lit8 v8, v4, 0x1

    aget-byte v8, v0, v8

    if-ne v8, v9, :cond_1

    goto :goto_1

    :cond_1
    new-instance v0, Ljava/lang/IllegalArgumentException;

    const-string v1, "MPF endian"

    invoke-direct {v0, v1}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw v0

    .line 182
    :cond_2
    :goto_1
    add-int/lit8 v8, v4, 0x4

    invoke-static {v0, v8, v6}, Llocal/mio/os4camerabridge/LegendaryContainerIntegrity;->u32([BIZ)I

    move-result v8

    add-int/2addr v8, v4

    invoke-static {v0, v8, v6}, Llocal/mio/os4camerabridge/LegendaryContainerIntegrity;->u16([BIZ)I

    move-result v9

    .line 183
    const/16 v10, 0x80

    if-gt v9, v10, :cond_b

    add-int/lit8 v8, v8, 0x2

    mul-int/lit8 v10, v9, 0xc

    add-int/2addr v10, v8

    iget v11, v2, Llocal/mio/os4camerabridge/LegendaryContainerIntegrity$Segment;->end:I

    if-gt v10, v11, :cond_b

    .line 184
    const/4 v10, 0x0

    :goto_2
    if-ge v10, v9, :cond_a

    .line 185
    mul-int/lit8 v11, v10, 0xc

    add-int/2addr v11, v8

    .line 186
    invoke-static {v0, v11, v6}, Llocal/mio/os4camerabridge/LegendaryContainerIntegrity;->u16([BIZ)I

    move-result v12

    const v13, 0xb002

    if-eq v12, v13, :cond_3

    goto/16 :goto_5

    .line 187
    :cond_3
    add-int/lit8 v12, v11, 0x4

    invoke-static {v0, v12, v6}, Llocal/mio/os4camerabridge/LegendaryContainerIntegrity;->u32([BIZ)I

    move-result v12

    add-int/lit8 v11, v11, 0x8

    invoke-static {v0, v11, v6}, Llocal/mio/os4camerabridge/LegendaryContainerIntegrity;->u32([BIZ)I

    move-result v11

    add-int/2addr v11, v4

    .line 188
    const/16 v13, 0x10

    if-lt v12, v13, :cond_9

    rem-int/lit8 v13, v12, 0x10

    if-nez v13, :cond_9

    if-lt v11, v4, :cond_9

    add-int v13, v11, v12

    iget v14, v2, Llocal/mio/os4camerabridge/LegendaryContainerIntegrity$Segment;->end:I

    if-gt v13, v14, :cond_9

    .line 189
    const/4 v13, 0x0

    :goto_3
    div-int/lit8 v14, v12, 0x10

    if-ge v13, v14, :cond_8

    .line 190
    mul-int/lit8 v14, v13, 0x10

    add-int/2addr v14, v11

    add-int/lit8 v15, v14, 0x4

    invoke-static {v0, v15, v6}, Llocal/mio/os4camerabridge/LegendaryContainerIntegrity;->u32([BIZ)I

    move-result v16

    add-int/lit8 v14, v14, 0x8

    invoke-static {v0, v14, v6}, Llocal/mio/os4camerabridge/LegendaryContainerIntegrity;->u32([BIZ)I

    move-result v17

    .line 191
    if-nez v13, :cond_4

    if-nez v17, :cond_4

    const/4 v7, 0x0

    goto :goto_4

    :cond_4
    add-int v18, v4, v17

    move/from16 v7, v18

    .line 192
    :goto_4
    if-ltz v7, :cond_7

    if-ltz v16, :cond_7

    array-length v2, v0

    sub-int v2, v2, v16

    if-gt v7, v2, :cond_7

    .line 193
    invoke-static {v7, v3}, Llocal/mio/os4camerabridge/LegendaryContainerIntegrity;->position(ILjava/util/List;)I

    move-result v2

    .line 194
    invoke-static {v15, v3}, Llocal/mio/os4camerabridge/LegendaryContainerIntegrity;->position(ILjava/util/List;)I

    move-result v15

    add-int v7, v7, v16

    invoke-static {v7, v3}, Llocal/mio/os4camerabridge/LegendaryContainerIntegrity;->position(ILjava/util/List;)I

    move-result v7

    sub-int/2addr v7, v2

    invoke-static {v1, v15, v7, v6}, Llocal/mio/os4camerabridge/LegendaryContainerIntegrity;->put32([BIIZ)V

    .line 195
    if-nez v13, :cond_5

    if-eqz v17, :cond_6

    :cond_5
    invoke-static {v14, v3}, Llocal/mio/os4camerabridge/LegendaryContainerIntegrity;->position(ILjava/util/List;)I

    move-result v7

    sub-int/2addr v2, v5

    invoke-static {v1, v7, v2, v6}, Llocal/mio/os4camerabridge/LegendaryContainerIntegrity;->put32([BIIZ)V

    .line 189
    :cond_6
    add-int/lit8 v13, v13, 0x1

    move-object/from16 v2, p2

    goto :goto_3

    .line 192
    :cond_7
    new-instance v0, Ljava/lang/IllegalArgumentException;

    const-string v1, "MPF image bounds"

    invoke-direct {v0, v1}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw v0

    .line 184
    :cond_8
    :goto_5
    add-int/lit8 v10, v10, 0x1

    move-object/from16 v2, p2

    goto/16 :goto_2

    .line 188
    :cond_9
    new-instance v0, Ljava/lang/IllegalArgumentException;

    const-string v1, "MPF entries"

    invoke-direct {v0, v1}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw v0

    .line 198
    :cond_a
    return-void

    .line 183
    :cond_b
    new-instance v0, Ljava/lang/IllegalArgumentException;

    const-string v1, "MPF IFD bounds"

    invoke-direct {v0, v1}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw v0
.end method

.method public static repair([B)[B
    .locals 25
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/lang/Exception;
        }
    .end annotation

    .line 76
    move-object/from16 v0, p0

    invoke-static {v0}, Llocal/mio/os4camerabridge/LegendaryContainerIntegrity;->headers([B)Ljava/util/List;

    move-result-object v1

    .line 77
    nop

    .line 78
    invoke-interface {v1}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object v2

    const/4 v3, 0x0

    :goto_0
    invoke-interface {v2}, Ljava/util/Iterator;->hasNext()Z

    move-result v4

    const/16 v5, 0xe1

    const/4 v6, 0x4

    if-eqz v4, :cond_2

    invoke-interface {v2}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v4

    check-cast v4, Llocal/mio/os4camerabridge/LegendaryContainerIntegrity$Segment;

    iget v7, v4, Llocal/mio/os4camerabridge/LegendaryContainerIntegrity$Segment;->marker:I

    if-ne v7, v5, :cond_1

    iget v5, v4, Llocal/mio/os4camerabridge/LegendaryContainerIntegrity$Segment;->start:I

    add-int/2addr v5, v6

    sget-object v6, Llocal/mio/os4camerabridge/LegendaryContainerIntegrity;->XMP:[B

    invoke-static {v0, v5, v6}, Llocal/mio/os4camerabridge/LegendaryContainerIntegrity;->starts([BI[B)Z

    move-result v5

    if-eqz v5, :cond_1

    .line 79
    if-nez v3, :cond_0

    .line 80
    move-object v3, v4

    goto :goto_1

    .line 79
    :cond_0
    new-instance v0, Ljava/lang/IllegalArgumentException;

    const-string v1, "multiple standard XMP packets"

    invoke-direct {v0, v1}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw v0

    .line 78
    :cond_1
    :goto_1
    goto :goto_0

    .line 82
    :cond_2
    if-nez v3, :cond_3

    return-object v0

    .line 83
    :cond_3
    new-instance v2, Ljava/lang/String;

    iget v4, v3, Llocal/mio/os4camerabridge/LegendaryContainerIntegrity$Segment;->start:I

    add-int/2addr v4, v6

    sget-object v7, Llocal/mio/os4camerabridge/LegendaryContainerIntegrity;->XMP:[B

    array-length v7, v7

    add-int/2addr v4, v7

    iget v7, v3, Llocal/mio/os4camerabridge/LegendaryContainerIntegrity$Segment;->end:I

    iget v8, v3, Llocal/mio/os4camerabridge/LegendaryContainerIntegrity$Segment;->start:I

    sub-int/2addr v7, v8

    sub-int/2addr v7, v6

    sget-object v8, Llocal/mio/os4camerabridge/LegendaryContainerIntegrity;->XMP:[B

    array-length v8, v8

    sub-int/2addr v7, v8

    sget-object v8, Ljava/nio/charset/StandardCharsets;->UTF_8:Ljava/nio/charset/Charset;

    invoke-direct {v2, v0, v4, v7, v8}, Ljava/lang/String;-><init>([BIILjava/nio/charset/Charset;)V

    .line 84
    const-string v4, "Legend.M9"

    invoke-virtual {v2, v4}, Ljava/lang/String;->contains(Ljava/lang/CharSequence;)Z

    move-result v7

    const-string v8, "Legend.MONOPAN"

    if-nez v7, :cond_4

    invoke-virtual {v2, v8}, Ljava/lang/String;->contains(Ljava/lang/CharSequence;)Z

    move-result v7

    if-nez v7, :cond_4

    return-object v0

    .line 85
    :cond_4
    const-string v7, "<!DOCTYPE"

    invoke-virtual {v2, v7}, Ljava/lang/String;->contains(Ljava/lang/CharSequence;)Z

    move-result v7

    if-nez v7, :cond_24

    const-string v7, "<!ENTITY"

    invoke-virtual {v2, v7}, Ljava/lang/String;->contains(Ljava/lang/CharSequence;)Z

    move-result v7

    if-nez v7, :cond_24

    .line 86
    invoke-static {}, Ljavax/xml/parsers/DocumentBuilderFactory;->newInstance()Ljavax/xml/parsers/DocumentBuilderFactory;

    move-result-object v7

    .line 87
    const/4 v9, 0x1

    invoke-virtual {v7, v9}, Ljavax/xml/parsers/DocumentBuilderFactory;->setNamespaceAware(Z)V

    .line 88
    const/4 v10, 0x0

    invoke-virtual {v7, v10}, Ljavax/xml/parsers/DocumentBuilderFactory;->setExpandEntityReferences(Z)V

    .line 89
    invoke-virtual {v7}, Ljavax/xml/parsers/DocumentBuilderFactory;->newDocumentBuilder()Ljavax/xml/parsers/DocumentBuilder;

    move-result-object v7

    new-instance v11, Ljava/io/ByteArrayInputStream;

    sget-object v12, Ljava/nio/charset/StandardCharsets;->UTF_8:Ljava/nio/charset/Charset;

    invoke-virtual {v2, v12}, Ljava/lang/String;->getBytes(Ljava/nio/charset/Charset;)[B

    move-result-object v2

    invoke-direct {v11, v2}, Ljava/io/ByteArrayInputStream;-><init>([B)V

    invoke-virtual {v7, v11}, Ljavax/xml/parsers/DocumentBuilder;->parse(Ljava/io/InputStream;)Lorg/w3c/dom/Document;

    move-result-object v2

    .line 90
    invoke-static {v2}, Llocal/mio/os4camerabridge/LegendaryContainerIntegrity;->elements(Lorg/w3c/dom/Document;)Ljava/util/List;

    move-result-object v7

    .line 91
    nop

    .line 92
    array-length v11, v0

    .line 93
    new-instance v12, Ljava/util/ArrayList;

    invoke-direct {v12}, Ljava/util/ArrayList;-><init>()V

    .line 94
    invoke-interface {v7}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object v13

    move v14, v10

    move v15, v14

    :goto_2
    invoke-interface {v13}, Ljava/util/Iterator;->hasNext()Z

    move-result v16

    move/from16 v17, v9

    const-string v9, "Semantic"

    move/from16 v18, v6

    const-string v6, "http://ns.google.com/photos/1.0/container/item/"

    const-string v5, "MiItem"

    const-string v10, "name"

    move-object/from16 v19, v1

    const-string v1, "http://ns.xiaomi.com/photos/1.0/container/item/"

    if-eqz v16, :cond_c

    invoke-interface {v13}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v16

    move-object/from16 v20, v7

    move-object/from16 v7, v16

    check-cast v7, Lorg/w3c/dom/Element;

    .line 95
    invoke-interface {v7, v1, v10}, Lorg/w3c/dom/Element;->getAttributeNS(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v10

    .line 96
    invoke-virtual {v10, v4}, Ljava/lang/String;->startsWith(Ljava/lang/String;)Z

    move-result v16

    if-nez v16, :cond_6

    invoke-virtual {v10, v8}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v10

    if-eqz v10, :cond_5

    goto :goto_3

    :cond_5
    move-object/from16 v16, v4

    move-object/from16 v23, v13

    goto :goto_4

    .line 97
    :cond_6
    :goto_3
    nop

    .line 98
    invoke-interface {v7, v5}, Lorg/w3c/dom/Element;->lookupNamespaceURI(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v5

    invoke-virtual {v1, v5}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v5

    if-nez v5, :cond_7

    move/from16 v15, v17

    .line 99
    :cond_7
    const-string v5, "Offset"

    invoke-interface {v7, v1, v5}, Lorg/w3c/dom/Element;->getAttributeNS(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v5

    .line 100
    const-string v10, "length"

    invoke-interface {v7, v1, v10}, Lorg/w3c/dom/Element;->getAttributeNS(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1

    .line 101
    invoke-virtual {v5}, Ljava/lang/String;->isEmpty()Z

    move-result v10

    if-nez v10, :cond_9

    invoke-virtual {v1}, Ljava/lang/String;->isEmpty()Z

    move-result v10

    if-nez v10, :cond_9

    .line 102
    move-object/from16 v16, v4

    invoke-static {v5}, Ljava/lang/Long;->parseLong(Ljava/lang/String;)J

    move-result-wide v4

    invoke-static {v1}, Ljava/lang/Long;->parseLong(Ljava/lang/String;)J

    move-result-wide v21

    .line 103
    const-wide/16 v23, 0x0

    cmp-long v1, v4, v23

    if-ltz v1, :cond_8

    cmp-long v1, v21, v23

    if-ltz v1, :cond_8

    array-length v10, v0

    move-object/from16 v23, v13

    int-to-long v13, v10

    cmp-long v10, v4, v13

    if-gtz v10, :cond_8

    cmp-long v10, v21, v4

    if-gtz v10, :cond_8

    .line 104
    if-lez v1, :cond_a

    array-length v1, v0

    long-to-int v4, v4

    sub-int/2addr v1, v4

    invoke-static {v11, v1}, Ljava/lang/Math;->min(II)I

    move-result v1

    move v11, v1

    move/from16 v14, v17

    goto :goto_4

    .line 103
    :cond_8
    new-instance v0, Ljava/lang/IllegalArgumentException;

    const-string v1, "Legend payload bounds"

    invoke-direct {v0, v1}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw v0

    .line 101
    :cond_9
    move-object/from16 v16, v4

    move-object/from16 v23, v13

    .line 107
    :cond_a
    move/from16 v14, v17

    :goto_4
    const-string v1, "GainMap"

    invoke-interface {v7, v6, v9}, Lorg/w3c/dom/Element;->getAttributeNS(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v4

    invoke-virtual {v1, v4}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-eqz v1, :cond_b

    invoke-interface {v12, v7}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    .line 108
    :cond_b
    move-object/from16 v4, v16

    move/from16 v9, v17

    move/from16 v6, v18

    move-object/from16 v1, v19

    move-object/from16 v7, v20

    move-object/from16 v13, v23

    const/16 v5, 0xe1

    const/4 v10, 0x0

    goto/16 :goto_2

    .line 109
    :cond_c
    move-object/from16 v20, v7

    if-nez v14, :cond_d

    return-object v0

    .line 110
    :cond_d
    array-length v4, v0

    const/4 v7, 0x0

    invoke-static {v0, v7, v4}, Llocal/mio/os4camerabridge/LegendaryContainerIntegrity;->jpegEnd([BII)I

    move-result v4

    .line 111
    invoke-interface {v12}, Ljava/util/List;->isEmpty()Z

    move-result v7

    const/4 v8, 0x2

    if-nez v7, :cond_f

    add-int/lit8 v7, v4, 0x2

    if-gt v7, v11, :cond_e

    new-array v7, v8, [B

    fill-array-data v7, :array_0

    .line 112
    invoke-static {v0, v4, v7}, Llocal/mio/os4camerabridge/LegendaryContainerIntegrity;->starts([BI[B)Z

    move-result v4

    if-nez v4, :cond_f

    :cond_e
    move/from16 v7, v17

    goto :goto_5

    :cond_f
    const/4 v7, 0x0

    .line 113
    :goto_5
    if-nez v15, :cond_10

    if-nez v7, :cond_10

    return-object v0

    .line 114
    :cond_10
    if-eqz v15, :cond_12

    .line 117
    invoke-interface/range {v20 .. v20}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object v4

    :goto_6
    invoke-interface {v4}, Ljava/util/Iterator;->hasNext()Z

    move-result v11

    if-eqz v11, :cond_12

    invoke-interface {v4}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v11

    check-cast v11, Lorg/w3c/dom/Element;

    invoke-interface {v11, v1, v10}, Lorg/w3c/dom/Element;->getAttributeNS(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v13

    const-string v14, "Legend."

    invoke-virtual {v13, v14}, Ljava/lang/String;->startsWith(Ljava/lang/String;)Z

    move-result v13

    if-eqz v13, :cond_11

    .line 118
    invoke-interface {v11, v5}, Lorg/w3c/dom/Element;->lookupNamespaceURI(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v13

    invoke-virtual {v1, v13}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v13

    if-nez v13, :cond_11

    .line 119
    const-string v13, "http://www.w3.org/2000/xmlns/"

    const-string v14, "xmlns:MiItem"

    invoke-interface {v11, v13, v14, v1}, Lorg/w3c/dom/Element;->setAttributeNS(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V

    .line 117
    :cond_11
    goto :goto_6

    .line 122
    :cond_12
    if-eqz v7, :cond_1b

    .line 123
    invoke-interface {v12}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object v1

    :goto_7
    invoke-interface {v1}, Ljava/util/Iterator;->hasNext()Z

    move-result v4

    if-eqz v4, :cond_14

    invoke-interface {v1}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v4

    check-cast v4, Lorg/w3c/dom/Element;

    .line 124
    invoke-interface {v4}, Lorg/w3c/dom/Element;->getParentNode()Lorg/w3c/dom/Node;

    move-result-object v4

    .line 125
    if-eqz v4, :cond_13

    invoke-interface {v4}, Lorg/w3c/dom/Node;->getParentNode()Lorg/w3c/dom/Node;

    move-result-object v5

    if-eqz v5, :cond_13

    invoke-interface {v4}, Lorg/w3c/dom/Node;->getParentNode()Lorg/w3c/dom/Node;

    move-result-object v5

    invoke-interface {v5, v4}, Lorg/w3c/dom/Node;->removeChild(Lorg/w3c/dom/Node;)Lorg/w3c/dom/Node;

    .line 126
    :cond_13
    goto :goto_7

    .line 127
    :cond_14
    invoke-static {v2}, Llocal/mio/os4camerabridge/LegendaryContainerIntegrity;->elements(Lorg/w3c/dom/Document;)Ljava/util/List;

    move-result-object v1

    invoke-interface {v1}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object v1

    :goto_8
    invoke-interface {v1}, Ljava/util/Iterator;->hasNext()Z

    move-result v4

    if-eqz v4, :cond_17

    invoke-interface {v1}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v4

    check-cast v4, Lorg/w3c/dom/Element;

    .line 128
    invoke-interface {v4}, Lorg/w3c/dom/Element;->getAttributes()Lorg/w3c/dom/NamedNodeMap;

    move-result-object v5

    .line 129
    invoke-interface {v5}, Lorg/w3c/dom/NamedNodeMap;->getLength()I

    move-result v10

    add-int/lit8 v10, v10, -0x1

    :goto_9
    if-ltz v10, :cond_16

    .line 130
    invoke-interface {v5, v10}, Lorg/w3c/dom/NamedNodeMap;->item(I)Lorg/w3c/dom/Node;

    move-result-object v11

    .line 131
    const-string v12, "http://ns.adobe.com/hdr-gain-map/1.0/"

    invoke-interface {v11}, Lorg/w3c/dom/Node;->getNamespaceURI()Ljava/lang/String;

    move-result-object v13

    invoke-virtual {v12, v13}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v12

    if-eqz v12, :cond_15

    check-cast v11, Lorg/w3c/dom/Attr;

    invoke-interface {v4, v11}, Lorg/w3c/dom/Element;->removeAttributeNode(Lorg/w3c/dom/Attr;)Lorg/w3c/dom/Attr;

    .line 129
    :cond_15
    add-int/lit8 v10, v10, -0x1

    goto :goto_9

    .line 133
    :cond_16
    goto :goto_8

    .line 136
    :cond_17
    invoke-static {v2}, Llocal/mio/os4camerabridge/LegendaryContainerIntegrity;->elements(Lorg/w3c/dom/Document;)Ljava/util/List;

    move-result-object v1

    invoke-interface {v1}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object v1

    :goto_a
    invoke-interface {v1}, Ljava/util/Iterator;->hasNext()Z

    move-result v4

    if-eqz v4, :cond_1b

    invoke-interface {v1}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v4

    check-cast v4, Lorg/w3c/dom/Element;

    invoke-interface {v4}, Lorg/w3c/dom/Element;->getNamespaceURI()Ljava/lang/String;

    move-result-object v5

    const-string v10, "http://ns.google.com/photos/1.0/container/"

    invoke-virtual {v10, v5}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v5

    if-eqz v5, :cond_1a

    const-string v5, "Directory"

    invoke-interface {v4}, Lorg/w3c/dom/Element;->getLocalName()Ljava/lang/String;

    move-result-object v11

    invoke-virtual {v5, v11}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v5

    if-eqz v5, :cond_1a

    .line 137
    nop

    .line 138
    const-string v5, "Item"

    invoke-interface {v4, v10, v5}, Lorg/w3c/dom/Element;->getElementsByTagNameNS(Ljava/lang/String;Ljava/lang/String;)Lorg/w3c/dom/NodeList;

    move-result-object v5

    .line 139
    const/4 v10, 0x0

    const/4 v11, 0x0

    :goto_b
    invoke-interface {v5}, Lorg/w3c/dom/NodeList;->getLength()I

    move-result v12

    if-ge v10, v12, :cond_19

    .line 140
    invoke-interface {v5, v10}, Lorg/w3c/dom/NodeList;->item(I)Lorg/w3c/dom/Node;

    move-result-object v12

    check-cast v12, Lorg/w3c/dom/Element;

    invoke-interface {v12, v6, v9}, Lorg/w3c/dom/Element;->getAttributeNS(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v12

    .line 141
    invoke-virtual {v12}, Ljava/lang/String;->isEmpty()Z

    move-result v13

    if-nez v13, :cond_18

    const-string v13, "Primary"

    invoke-virtual {v12, v13}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v12

    if-nez v12, :cond_18

    move/from16 v11, v17

    .line 139
    :cond_18
    add-int/lit8 v10, v10, 0x1

    goto :goto_b

    .line 143
    :cond_19
    if-nez v11, :cond_1a

    invoke-interface {v4}, Lorg/w3c/dom/Element;->getParentNode()Lorg/w3c/dom/Node;

    move-result-object v5

    if-eqz v5, :cond_1a

    invoke-interface {v4}, Lorg/w3c/dom/Element;->getParentNode()Lorg/w3c/dom/Node;

    move-result-object v5

    invoke-interface {v5, v4}, Lorg/w3c/dom/Node;->removeChild(Lorg/w3c/dom/Node;)Lorg/w3c/dom/Node;

    .line 136
    :cond_1a
    goto :goto_a

    .line 146
    :cond_1b
    new-instance v1, Ljava/io/ByteArrayOutputStream;

    invoke-direct {v1}, Ljava/io/ByteArrayOutputStream;-><init>()V

    .line 147
    invoke-static {}, Ljavax/xml/transform/TransformerFactory;->newInstance()Ljavax/xml/transform/TransformerFactory;

    move-result-object v4

    invoke-virtual {v4}, Ljavax/xml/transform/TransformerFactory;->newTransformer()Ljavax/xml/transform/Transformer;

    move-result-object v4

    .line 148
    const-string v5, "omit-xml-declaration"

    const-string v6, "yes"

    invoke-virtual {v4, v5, v6}, Ljavax/xml/transform/Transformer;->setOutputProperty(Ljava/lang/String;Ljava/lang/String;)V

    .line 149
    const-string v5, "encoding"

    const-string v6, "UTF-8"

    invoke-virtual {v4, v5, v6}, Ljavax/xml/transform/Transformer;->setOutputProperty(Ljava/lang/String;Ljava/lang/String;)V

    .line 150
    new-instance v5, Ljavax/xml/transform/dom/DOMSource;

    invoke-direct {v5, v2}, Ljavax/xml/transform/dom/DOMSource;-><init>(Lorg/w3c/dom/Node;)V

    new-instance v2, Ljavax/xml/transform/stream/StreamResult;

    invoke-direct {v2, v1}, Ljavax/xml/transform/stream/StreamResult;-><init>(Ljava/io/OutputStream;)V

    invoke-virtual {v4, v5, v2}, Ljavax/xml/transform/Transformer;->transform(Ljavax/xml/transform/Source;Ljavax/xml/transform/Result;)V

    .line 151
    invoke-virtual {v1}, Ljava/io/ByteArrayOutputStream;->toByteArray()[B

    move-result-object v1

    .line 152
    sget-object v2, Llocal/mio/os4camerabridge/LegendaryContainerIntegrity;->XMP:[B

    array-length v2, v2

    add-int/2addr v2, v8

    array-length v4, v1

    add-int/2addr v2, v4

    .line 153
    const v4, 0xffff

    if-gt v2, v4, :cond_23

    .line 154
    new-instance v4, Ljava/io/ByteArrayOutputStream;

    add-int/lit8 v5, v2, 0x2

    invoke-direct {v4, v5}, Ljava/io/ByteArrayOutputStream;-><init>(I)V

    .line 155
    const/16 v5, 0xff

    invoke-virtual {v4, v5}, Ljava/io/ByteArrayOutputStream;->write(I)V

    const/16 v6, 0xe1

    invoke-virtual {v4, v6}, Ljava/io/ByteArrayOutputStream;->write(I)V

    ushr-int/lit8 v6, v2, 0x8

    invoke-virtual {v4, v6}, Ljava/io/ByteArrayOutputStream;->write(I)V

    and-int/2addr v2, v5

    invoke-virtual {v4, v2}, Ljava/io/ByteArrayOutputStream;->write(I)V

    .line 156
    sget-object v2, Llocal/mio/os4camerabridge/LegendaryContainerIntegrity;->XMP:[B

    invoke-virtual {v4, v2}, Ljava/io/ByteArrayOutputStream;->write([B)V

    invoke-virtual {v4, v1}, Ljava/io/ByteArrayOutputStream;->write([B)V

    .line 157
    new-instance v2, Ljava/util/ArrayList;

    invoke-direct {v2}, Ljava/util/ArrayList;-><init>()V

    .line 158
    new-instance v5, Llocal/mio/os4camerabridge/LegendaryContainerIntegrity$Edit;

    iget v6, v3, Llocal/mio/os4camerabridge/LegendaryContainerIntegrity$Segment;->start:I

    iget v3, v3, Llocal/mio/os4camerabridge/LegendaryContainerIntegrity$Segment;->end:I

    invoke-virtual {v4}, Ljava/io/ByteArrayOutputStream;->toByteArray()[B

    move-result-object v4

    invoke-direct {v5, v6, v3, v4}, Llocal/mio/os4camerabridge/LegendaryContainerIntegrity$Edit;-><init>(II[B)V

    invoke-interface {v2, v5}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    .line 159
    const/16 v3, 0xe2

    if-eqz v7, :cond_1d

    invoke-interface/range {v19 .. v19}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object v4

    :goto_c
    invoke-interface {v4}, Ljava/util/Iterator;->hasNext()Z

    move-result v5

    if-eqz v5, :cond_1d

    invoke-interface {v4}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v5

    check-cast v5, Llocal/mio/os4camerabridge/LegendaryContainerIntegrity$Segment;

    .line 160
    iget v6, v5, Llocal/mio/os4camerabridge/LegendaryContainerIntegrity$Segment;->marker:I

    if-ne v6, v3, :cond_1c

    iget v6, v5, Llocal/mio/os4camerabridge/LegendaryContainerIntegrity$Segment;->start:I

    add-int/lit8 v6, v6, 0x4

    move/from16 v8, v18

    new-array v9, v8, [B

    fill-array-data v9, :array_1

    invoke-static {v0, v6, v9}, Llocal/mio/os4camerabridge/LegendaryContainerIntegrity;->starts([BI[B)Z

    move-result v6

    if-eqz v6, :cond_1c

    .line 161
    new-instance v6, Llocal/mio/os4camerabridge/LegendaryContainerIntegrity$Edit;

    iget v8, v5, Llocal/mio/os4camerabridge/LegendaryContainerIntegrity$Segment;->start:I

    iget v5, v5, Llocal/mio/os4camerabridge/LegendaryContainerIntegrity$Segment;->end:I

    const/4 v9, 0x0

    new-array v10, v9, [B

    invoke-direct {v6, v8, v5, v10}, Llocal/mio/os4camerabridge/LegendaryContainerIntegrity$Edit;-><init>(II[B)V

    invoke-interface {v2, v6}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    goto :goto_d

    .line 160
    :cond_1c
    const/4 v9, 0x0

    :goto_d
    const/16 v18, 0x4

    goto :goto_c

    .line 159
    :cond_1d
    const/4 v9, 0x0

    .line 162
    new-instance v4, Llocal/mio/os4camerabridge/LegendaryContainerIntegrity$$ExternalSyntheticLambda0;

    invoke-direct {v4}, Llocal/mio/os4camerabridge/LegendaryContainerIntegrity$$ExternalSyntheticLambda0;-><init>()V

    invoke-interface {v2, v4}, Ljava/util/List;->sort(Ljava/util/Comparator;)V

    .line 163
    new-instance v4, Ljava/io/ByteArrayOutputStream;

    array-length v5, v0

    array-length v1, v1

    add-int/2addr v5, v1

    invoke-direct {v4, v5}, Ljava/io/ByteArrayOutputStream;-><init>(I)V

    .line 164
    nop

    .line 165
    invoke-interface {v2}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object v1

    move v10, v9

    :goto_e
    invoke-interface {v1}, Ljava/util/Iterator;->hasNext()Z

    move-result v5

    if-eqz v5, :cond_1f

    invoke-interface {v1}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v5

    check-cast v5, Llocal/mio/os4camerabridge/LegendaryContainerIntegrity$Edit;

    .line 166
    iget v6, v5, Llocal/mio/os4camerabridge/LegendaryContainerIntegrity$Edit;->start:I

    if-lt v6, v10, :cond_1e

    .line 167
    iget v6, v5, Llocal/mio/os4camerabridge/LegendaryContainerIntegrity$Edit;->start:I

    sub-int/2addr v6, v10

    invoke-virtual {v4, v0, v10, v6}, Ljava/io/ByteArrayOutputStream;->write([BII)V

    iget-object v6, v5, Llocal/mio/os4camerabridge/LegendaryContainerIntegrity$Edit;->bytes:[B

    invoke-virtual {v4, v6}, Ljava/io/ByteArrayOutputStream;->write([B)V

    iget v10, v5, Llocal/mio/os4camerabridge/LegendaryContainerIntegrity$Edit;->end:I

    .line 168
    goto :goto_e

    .line 166
    :cond_1e
    new-instance v0, Ljava/lang/IllegalArgumentException;

    const-string v1, "overlapping header edits"

    invoke-direct {v0, v1}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw v0

    .line 169
    :cond_1f
    array-length v1, v0

    sub-int/2addr v1, v10

    invoke-virtual {v4, v0, v10, v1}, Ljava/io/ByteArrayOutputStream;->write([BII)V

    .line 170
    invoke-virtual {v4}, Ljava/io/ByteArrayOutputStream;->toByteArray()[B

    move-result-object v1

    .line 171
    if-nez v7, :cond_22

    invoke-interface/range {v19 .. v19}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object v4

    :cond_20
    :goto_f
    invoke-interface {v4}, Ljava/util/Iterator;->hasNext()Z

    move-result v5

    if-eqz v5, :cond_22

    invoke-interface {v4}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v5

    check-cast v5, Llocal/mio/os4camerabridge/LegendaryContainerIntegrity$Segment;

    .line 172
    iget v6, v5, Llocal/mio/os4camerabridge/LegendaryContainerIntegrity$Segment;->marker:I

    if-ne v6, v3, :cond_21

    iget v6, v5, Llocal/mio/os4camerabridge/LegendaryContainerIntegrity$Segment;->start:I

    const/4 v8, 0x4

    add-int/2addr v6, v8

    new-array v7, v8, [B

    fill-array-data v7, :array_2

    invoke-static {v0, v6, v7}, Llocal/mio/os4camerabridge/LegendaryContainerIntegrity;->starts([BI[B)Z

    move-result v6

    if-eqz v6, :cond_20

    invoke-static {v0, v1, v5, v2}, Llocal/mio/os4camerabridge/LegendaryContainerIntegrity;->relocateMpf([B[BLlocal/mio/os4camerabridge/LegendaryContainerIntegrity$Segment;Ljava/util/List;)V

    goto :goto_f

    :cond_21
    const/4 v8, 0x4

    goto :goto_f

    .line 175
    :cond_22
    return-object v1

    .line 153
    :cond_23
    new-instance v0, Ljava/lang/IllegalArgumentException;

    const-string v1, "XMP APP1 too large"

    invoke-direct {v0, v1}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw v0

    .line 85
    :cond_24
    new-instance v0, Ljava/lang/IllegalArgumentException;

    const-string v1, "XMP DTD forbidden"

    invoke-direct {v0, v1}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw v0

    nop

    :array_0
    .array-data 1
        -0x1t
        -0x28t
    .end array-data

    nop

    :array_1
    .array-data 1
        0x4dt
        0x50t
        0x46t
        0x0t
    .end array-data

    :array_2
    .array-data 1
        0x4dt
        0x50t
        0x46t
        0x0t
    .end array-data
.end method

.method public static replaceXmp([B[B)[B
    .locals 7
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/lang/Exception;
        }
    .end annotation

    .line 43
    invoke-static {p0}, Llocal/mio/os4camerabridge/LegendaryContainerIntegrity;->headers([B)Ljava/util/List;

    move-result-object v0

    .line 44
    nop

    .line 45
    invoke-interface {v0}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object v1

    const/4 v2, 0x0

    :goto_0
    invoke-interface {v1}, Ljava/util/Iterator;->hasNext()Z

    move-result v3

    const/16 v4, 0xe1

    const/4 v5, 0x4

    if-eqz v3, :cond_2

    invoke-interface {v1}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v3

    check-cast v3, Llocal/mio/os4camerabridge/LegendaryContainerIntegrity$Segment;

    iget v6, v3, Llocal/mio/os4camerabridge/LegendaryContainerIntegrity$Segment;->marker:I

    if-ne v6, v4, :cond_1

    iget v4, v3, Llocal/mio/os4camerabridge/LegendaryContainerIntegrity$Segment;->start:I

    add-int/2addr v4, v5

    sget-object v5, Llocal/mio/os4camerabridge/LegendaryContainerIntegrity;->XMP:[B

    invoke-static {p0, v4, v5}, Llocal/mio/os4camerabridge/LegendaryContainerIntegrity;->starts([BI[B)Z

    move-result v4

    if-eqz v4, :cond_1

    .line 46
    if-nez v2, :cond_0

    .line 47
    move-object v2, v3

    goto :goto_1

    .line 46
    :cond_0
    new-instance p0, Ljava/lang/IllegalArgumentException;

    const-string p1, "multiple XMP packets"

    invoke-direct {p0, p1}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw p0

    .line 45
    :cond_1
    :goto_1
    goto :goto_0

    .line 49
    :cond_2
    if-eqz v2, :cond_6

    .line 50
    sget-object v1, Llocal/mio/os4camerabridge/LegendaryContainerIntegrity;->XMP:[B

    array-length v1, v1

    add-int/lit8 v1, v1, 0x2

    array-length v3, p1

    add-int/2addr v1, v3

    .line 51
    const v3, 0xffff

    if-gt v1, v3, :cond_5

    .line 52
    new-instance v3, Ljava/io/ByteArrayOutputStream;

    add-int/lit8 v6, v1, 0x2

    invoke-direct {v3, v6}, Ljava/io/ByteArrayOutputStream;-><init>(I)V

    .line 53
    const/16 v6, 0xff

    invoke-virtual {v3, v6}, Ljava/io/ByteArrayOutputStream;->write(I)V

    invoke-virtual {v3, v4}, Ljava/io/ByteArrayOutputStream;->write(I)V

    ushr-int/lit8 v4, v1, 0x8

    invoke-virtual {v3, v4}, Ljava/io/ByteArrayOutputStream;->write(I)V

    and-int/2addr v1, v6

    invoke-virtual {v3, v1}, Ljava/io/ByteArrayOutputStream;->write(I)V

    .line 54
    sget-object v1, Llocal/mio/os4camerabridge/LegendaryContainerIntegrity;->XMP:[B

    invoke-virtual {v3, v1}, Ljava/io/ByteArrayOutputStream;->write([B)V

    invoke-virtual {v3, p1}, Ljava/io/ByteArrayOutputStream;->write([B)V

    .line 55
    new-instance p1, Llocal/mio/os4camerabridge/LegendaryContainerIntegrity$Edit;

    iget v1, v2, Llocal/mio/os4camerabridge/LegendaryContainerIntegrity$Segment;->start:I

    iget v4, v2, Llocal/mio/os4camerabridge/LegendaryContainerIntegrity$Segment;->end:I

    invoke-virtual {v3}, Ljava/io/ByteArrayOutputStream;->toByteArray()[B

    move-result-object v6

    invoke-direct {p1, v1, v4, v6}, Llocal/mio/os4camerabridge/LegendaryContainerIntegrity$Edit;-><init>(II[B)V

    invoke-static {p1}, Ljava/util/Collections;->singletonList(Ljava/lang/Object;)Ljava/util/List;

    move-result-object p1

    .line 56
    new-instance v1, Ljava/io/ByteArrayOutputStream;

    array-length v4, p0

    invoke-virtual {v3}, Ljava/io/ByteArrayOutputStream;->size()I

    move-result v6

    add-int/2addr v4, v6

    invoke-direct {v1, v4}, Ljava/io/ByteArrayOutputStream;-><init>(I)V

    .line 57
    iget v4, v2, Llocal/mio/os4camerabridge/LegendaryContainerIntegrity$Segment;->start:I

    const/4 v6, 0x0

    invoke-virtual {v1, p0, v6, v4}, Ljava/io/ByteArrayOutputStream;->write([BII)V

    invoke-virtual {v3}, Ljava/io/ByteArrayOutputStream;->toByteArray()[B

    move-result-object v3

    invoke-virtual {v1, v3}, Ljava/io/ByteArrayOutputStream;->write([B)V

    .line 58
    iget v3, v2, Llocal/mio/os4camerabridge/LegendaryContainerIntegrity$Segment;->end:I

    array-length v4, p0

    iget v2, v2, Llocal/mio/os4camerabridge/LegendaryContainerIntegrity$Segment;->end:I

    sub-int/2addr v4, v2

    invoke-virtual {v1, p0, v3, v4}, Ljava/io/ByteArrayOutputStream;->write([BII)V

    .line 59
    invoke-virtual {v1}, Ljava/io/ByteArrayOutputStream;->toByteArray()[B

    move-result-object v1

    .line 60
    invoke-interface {v0}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object v0

    :goto_2
    invoke-interface {v0}, Ljava/util/Iterator;->hasNext()Z

    move-result v2

    if-eqz v2, :cond_4

    invoke-interface {v0}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v2

    check-cast v2, Llocal/mio/os4camerabridge/LegendaryContainerIntegrity$Segment;

    iget v3, v2, Llocal/mio/os4camerabridge/LegendaryContainerIntegrity$Segment;->marker:I

    const/16 v4, 0xe2

    if-ne v3, v4, :cond_3

    iget v3, v2, Llocal/mio/os4camerabridge/LegendaryContainerIntegrity$Segment;->start:I

    add-int/2addr v3, v5

    new-array v4, v5, [B

    fill-array-data v4, :array_0

    invoke-static {p0, v3, v4}, Llocal/mio/os4camerabridge/LegendaryContainerIntegrity;->starts([BI[B)Z

    move-result v3

    if-eqz v3, :cond_3

    .line 61
    invoke-static {p0, v1, v2, p1}, Llocal/mio/os4camerabridge/LegendaryContainerIntegrity;->relocateMpf([B[BLlocal/mio/os4camerabridge/LegendaryContainerIntegrity$Segment;Ljava/util/List;)V

    .line 60
    :cond_3
    goto :goto_2

    .line 62
    :cond_4
    return-object v1

    .line 51
    :cond_5
    new-instance p0, Ljava/lang/IllegalArgumentException;

    const-string p1, "XMP header too large"

    invoke-direct {p0, p1}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw p0

    .line 49
    :cond_6
    new-instance p0, Ljava/lang/IllegalArgumentException;

    const-string p1, "XMP packet absent"

    invoke-direct {p0, p1}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw p0

    :array_0
    .array-data 1
        0x4dt
        0x50t
        0x46t
        0x0t
    .end array-data
.end method

.method private static starts([BI[B)Z
    .locals 4

    .line 225
    const/4 v0, 0x0

    if-ltz p1, :cond_3

    array-length v1, p0

    array-length v2, p2

    sub-int/2addr v1, v2

    if-le p1, v1, :cond_0

    goto :goto_1

    .line 226
    :cond_0
    move v1, v0

    :goto_0
    array-length v2, p2

    if-ge v1, v2, :cond_2

    add-int v2, p1, v1

    aget-byte v2, p0, v2

    aget-byte v3, p2, v1

    if-eq v2, v3, :cond_1

    return v0

    :cond_1
    add-int/lit8 v1, v1, 0x1

    goto :goto_0

    .line 227
    :cond_2
    const/4 p0, 0x1

    return p0

    .line 225
    :cond_3
    :goto_1
    return v0
.end method

.method private static u16([BIZ)I
    .locals 1

    .line 208
    if-ltz p1, :cond_1

    array-length v0, p0

    add-int/lit8 v0, v0, -0x2

    if-gt p1, v0, :cond_1

    .line 209
    if-eqz p2, :cond_0

    aget-byte p2, p0, p1

    and-int/lit16 p2, p2, 0xff

    add-int/lit8 p1, p1, 0x1

    aget-byte p0, p0, p1

    and-int/lit16 p0, p0, 0xff

    shl-int/lit8 p0, p0, 0x8

    goto :goto_0

    :cond_0
    aget-byte p2, p0, p1

    and-int/lit16 p2, p2, 0xff

    shl-int/lit8 p2, p2, 0x8

    add-int/lit8 p1, p1, 0x1

    aget-byte p0, p0, p1

    and-int/lit16 p0, p0, 0xff

    :goto_0
    or-int/2addr p0, p2

    return p0

    .line 208
    :cond_1
    new-instance p0, Ljava/lang/IllegalArgumentException;

    const-string p1, "u16 bounds"

    invoke-direct {p0, p1}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw p0
.end method

.method private static u32([BIZ)I
    .locals 1

    .line 212
    if-ltz p1, :cond_1

    array-length v0, p0

    add-int/lit8 v0, v0, -0x4

    if-gt p1, v0, :cond_1

    .line 213
    if-eqz p2, :cond_0

    const/4 p2, 0x1

    invoke-static {p0, p1, p2}, Llocal/mio/os4camerabridge/LegendaryContainerIntegrity;->u16([BIZ)I

    move-result v0

    add-int/lit8 p1, p1, 0x2

    invoke-static {p0, p1, p2}, Llocal/mio/os4camerabridge/LegendaryContainerIntegrity;->u16([BIZ)I

    move-result p0

    shl-int/lit8 p0, p0, 0x10

    goto :goto_0

    :cond_0
    const/4 p2, 0x0

    invoke-static {p0, p1, p2}, Llocal/mio/os4camerabridge/LegendaryContainerIntegrity;->u16([BIZ)I

    move-result v0

    shl-int/lit8 v0, v0, 0x10

    add-int/lit8 p1, p1, 0x2

    invoke-static {p0, p1, p2}, Llocal/mio/os4camerabridge/LegendaryContainerIntegrity;->u16([BIZ)I

    move-result p0

    :goto_0
    or-int/2addr p0, v0

    return p0

    .line 212
    :cond_1
    new-instance p0, Ljava/lang/IllegalArgumentException;

    const-string p1, "u32 bounds"

    invoke-direct {p0, p1}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw p0
.end method
