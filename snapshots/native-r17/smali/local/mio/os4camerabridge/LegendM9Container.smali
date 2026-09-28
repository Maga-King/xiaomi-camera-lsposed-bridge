.class final Llocal/mio/os4camerabridge/LegendM9Container;
.super Ljava/lang/Object;
.source "LegendM9Container.java"


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Llocal/mio/os4camerabridge/LegendM9Container$Metadata;,
        Llocal/mio/os4camerabridge/LegendM9Container$Segment;
    }
.end annotation


# static fields
.field static final CLOUD_ALGORITHM_VERSION:Ljava/lang/String; = "1.4.251127.0"

.field static final LSC_FLOATS:I = 0x374

.field private static final NS_CONTAINER:Ljava/lang/String; = "http://ns.xiaomi.com/photos/1.0/container/"

.field private static final NS_ITEM:Ljava/lang/String; = "http://ns.xiaomi.com/photos/1.0/container/item/"

.field static final RAW_BYTES:I = 0xf00000

.field static final RAW_HEIGHT:I = 0xc00

.field private static final RAW_KEY_PREFIX:Ljava/lang/String; = "xiaomi"

.field private static final RAW_KEY_SUFFIX:Ljava/lang/String; = "niubi_f4d7a2c9e1b3f5a7d2c4e6b8f0a1c3d5e7b9f2a4c6e8b0f1a3c5e7b9f0a2c4d6"

.field static final RAW_STRIDE:I = 0x1400

.field static final RAW_WIDTH:I = 0x1000

.field private static final XMP_HEADER:[B


# direct methods
.method static bridge synthetic -$$Nest$smpositive(F)Z
    .locals 0

    invoke-static {p0}, Llocal/mio/os4camerabridge/LegendM9Container;->positive(F)Z

    move-result p0

    return p0
.end method

.method static bridge synthetic -$$Nest$smrequire(ZLjava/lang/String;)V
    .locals 0

    invoke-static {p0, p1}, Llocal/mio/os4camerabridge/LegendM9Container;->require(ZLjava/lang/String;)V

    return-void
.end method

.method static constructor <clinit>()V
    .locals 2

    .line 22
    sget-object v0, Ljava/nio/charset/StandardCharsets;->UTF_8:Ljava/nio/charset/Charset;

    .line 24
    const-string v1, "http://ns.adobe.com/xap/1.0/\u0000"

    invoke-virtual {v1, v0}, Ljava/lang/String;->getBytes(Ljava/nio/charset/Charset;)[B

    move-result-object v0

    sput-object v0, Llocal/mio/os4camerabridge/LegendM9Container;->XMP_HEADER:[B

    .line 22
    return-void
.end method

.method private constructor <init>()V
    .locals 0

    .line 85
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 86
    return-void
.end method

.method private static addM3Container([BII)[B
    .locals 8
    .param p0, "primary"    # [B
    .param p1, "width"    # I
    .param p2, "height"    # I

    .line 423
    invoke-static {p0}, Llocal/mio/os4camerabridge/LegendM9Container;->findXmp([B)Llocal/mio/os4camerabridge/LegendM9Container$Segment;

    move-result-object v0

    .line 424
    .local v0, "xmp":Llocal/mio/os4camerabridge/LegendM9Container$Segment;
    const-string v1, "http://ns.xiaomi.com/photos/1.0/container/"

    if-eqz v0, :cond_1

    invoke-static {p0, v0}, Llocal/mio/os4camerabridge/LegendM9Container;->xml([BLlocal/mio/os4camerabridge/LegendM9Container$Segment;)Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v2, v1}, Ljava/lang/String;->contains(Ljava/lang/CharSequence;)Z

    move-result v2

    if-nez v2, :cond_0

    goto :goto_0

    .line 425
    :cond_0
    new-instance v1, Ljava/lang/IllegalArgumentException;

    const-string v2, "input already has MiContainer"

    invoke-direct {v1, v2}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw v1

    .line 427
    :cond_1
    :goto_0
    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "&lt;madrid_image type=&quot;701&quot; offset=&quot;0&quot; length=&quot;0&quot; paddingx=&quot;0&quot; paddingy=&quot;0&quot; width=&quot;"

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, p1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v2

    const-string v3, "&quot; height=&quot;"

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, p2}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v2

    const-string v3, "&quot; location_enabled=&quot;0&quot; time_enabled=&quot;0&quot; dark=&quot;0&quot; /&gt;"

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    .line 432
    .local v2, "madrid":Ljava/lang/String;
    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    const-string v4, "    <rdf:Description\n      rdf:about=\"\"\n      xmlns:MiCamera=\"http://ns.xiaomi.com/photos/1.0/camera/\"\n      MiCamera:XMPMeta=\""

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    const-string v4, "\"/>\n    <rdf:Description\n      rdf:about=\"\"\n      xmlns:MiContainer=\""

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v3, "\"\n      xmlns:Item=\""

    invoke-virtual {v1, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v3, "http://ns.xiaomi.com/photos/1.0/container/item/"

    invoke-virtual {v1, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v3, "\"\n      MiContainer:Version=\"1.0\">\n      <MiContainer:Directory>\n        <rdf:Seq>\n"

    invoke-virtual {v1, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    const-string v4, "              Item:Orient=\"0\"\n              Item:width=\""

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3, p1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v3

    const-string v4, "\"\n              Item:height=\""

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3, p2}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v3

    const-string v4, "\"\n              Item:UseMainImage=\"1\""

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    .line 443
    const-string v4, "Legend.MONOPAN"

    const/4 v5, 0x0

    const-string v6, "image/jpeg"

    invoke-static {v4, v5, v5, v6, v3}, Llocal/mio/os4camerabridge/LegendM9Container;->itemXml(Ljava/lang/String;IILjava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v1, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v3, "        </rdf:Seq>\n      </MiContainer:Directory>\n    </rdf:Description>\n"

    invoke-virtual {v1, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    .line 454
    .local v1, "fragments":Ljava/lang/String;
    if-nez v0, :cond_2

    .line 455
    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    const-string v4, "<x:xmpmeta\n  xmlns:x=\"adobe:ns:meta/\"\n  x:xmptk=\"Adobe XMP Core 5.1.2\">\n  <rdf:RDF\n    xmlns:rdf=\"http://www.w3.org/1999/02/22-rdf-syntax-ns#\">\n"

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    const-string v4, "  </rdf:RDF>\n</x:xmpmeta>"

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    .local v3, "merged":Ljava/lang/String;
    goto :goto_2

    .line 463
    .end local v3    # "merged":Ljava/lang/String;
    :cond_2
    invoke-static {p0, v0}, Llocal/mio/os4camerabridge/LegendM9Container;->xml([BLlocal/mio/os4camerabridge/LegendM9Container$Segment;)Ljava/lang/String;

    move-result-object v3

    invoke-static {v3}, Llocal/mio/os4camerabridge/LegendM9Container;->withoutOwnedCameraXmpMeta(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v3

    .line 464
    .local v3, "original":Ljava/lang/String;
    const-string v4, "    <rdf:Description"

    invoke-virtual {v3, v4}, Ljava/lang/String;->indexOf(Ljava/lang/String;)I

    move-result v4

    .line 465
    .local v4, "mergePoint":I
    if-gez v4, :cond_3

    .line 466
    const-string v6, "</rdf:RDF>"

    invoke-virtual {v3, v6}, Ljava/lang/String;->indexOf(Ljava/lang/String;)I

    move-result v4

    .line 468
    :cond_3
    if-ltz v4, :cond_4

    const/4 v6, 0x1

    goto :goto_1

    :cond_4
    move v6, v5

    :goto_1
    const-string v7, "XMP has no RDF merge point"

    invoke-static {v6, v7}, Llocal/mio/os4camerabridge/LegendM9Container;->require(ZLjava/lang/String;)V

    .line 469
    new-instance v6, Ljava/lang/StringBuilder;

    invoke-direct {v6}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v3, v5, v4}, Ljava/lang/String;->substring(II)Ljava/lang/String;

    move-result-object v5

    invoke-virtual {v6, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    .line 470
    invoke-virtual {v3, v4}, Ljava/lang/String;->substring(I)Ljava/lang/String;

    move-result-object v6

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v5

    move-object v3, v5

    .line 472
    .end local v4    # "mergePoint":I
    .local v3, "merged":Ljava/lang/String;
    :goto_2
    invoke-static {v3}, Llocal/mio/os4camerabridge/LegendM9Container;->xmpApp1(Ljava/lang/String;)[B

    move-result-object v4

    .line 473
    .local v4, "app1":[B
    if-nez v0, :cond_5

    .line 474
    invoke-static {p0}, Llocal/mio/os4camerabridge/LegendM9Container;->metadataInsertion([B)I

    move-result v5

    .line 475
    .local v5, "insertion":I
    invoke-static {p0, v5, v5, v4}, Llocal/mio/os4camerabridge/LegendM9Container;->replace([BII[B)[B

    move-result-object v6

    return-object v6

    .line 477
    .end local v5    # "insertion":I
    :cond_5
    iget v5, v0, Llocal/mio/os4camerabridge/LegendM9Container$Segment;->markerOffset:I

    iget v6, v0, Llocal/mio/os4camerabridge/LegendM9Container$Segment;->markerOffset:I

    iget v7, v0, Llocal/mio/os4camerabridge/LegendM9Container$Segment;->totalLength:I

    add-int/2addr v6, v7

    invoke-static {p0, v5, v6, v4}, Llocal/mio/os4camerabridge/LegendM9Container;->replace([BII[B)[B

    move-result-object v5

    return-object v5
.end method

.method private static addM9Container([B[B[BI)[B
    .locals 9
    .param p0, "primary"    # [B
    .param p1, "raw"    # [B
    .param p2, "metadata"    # [B
    .param p3, "orientation"    # I

    .line 377
    invoke-static {p0}, Llocal/mio/os4camerabridge/LegendM9Container;->findXmp([B)Llocal/mio/os4camerabridge/LegendM9Container$Segment;

    move-result-object v0

    .line 378
    .local v0, "xmp":Llocal/mio/os4camerabridge/LegendM9Container$Segment;
    if-eqz v0, :cond_1

    invoke-static {p0, v0}, Llocal/mio/os4camerabridge/LegendM9Container;->xml([BLlocal/mio/os4camerabridge/LegendM9Container$Segment;)Ljava/lang/String;

    move-result-object v1

    const-string v2, "http://ns.xiaomi.com/photos/1.0/container/"

    invoke-virtual {v1, v2}, Ljava/lang/String;->contains(Ljava/lang/CharSequence;)Z

    move-result v1

    if-nez v1, :cond_0

    goto :goto_0

    .line 379
    :cond_0
    new-instance v1, Ljava/lang/IllegalArgumentException;

    const-string v2, "input already has MiContainer"

    invoke-direct {v1, v2}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw v1

    .line 381
    :cond_1
    :goto_0
    array-length v1, p1

    array-length v2, p1

    array-length v3, p2

    add-int/2addr v2, v3

    array-length v3, p2

    invoke-static {v1, v2, v3, p3}, Llocal/mio/os4camerabridge/LegendM9Container;->m9Fragments(IIII)Ljava/lang/String;

    move-result-object v1

    .line 384
    .local v1, "fragments":Ljava/lang/String;
    const/4 v2, 0x0

    if-nez v0, :cond_2

    .line 385
    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    const-string v4, "<x:xmpmeta\n  xmlns:x=\"adobe:ns:meta/\"\n  x:xmptk=\"Adobe XMP Core 5.1.2\">\n  <rdf:RDF\n    xmlns:rdf=\"http://www.w3.org/1999/02/22-rdf-syntax-ns#\">\n"

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    const-string v4, "  </rdf:RDF>\n</x:xmpmeta>"

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    .local v3, "merged":Ljava/lang/String;
    goto :goto_2

    .line 393
    .end local v3    # "merged":Ljava/lang/String;
    :cond_2
    invoke-static {p0, v0}, Llocal/mio/os4camerabridge/LegendM9Container;->xml([BLlocal/mio/os4camerabridge/LegendM9Container$Segment;)Ljava/lang/String;

    move-result-object v3

    invoke-static {v3}, Llocal/mio/os4camerabridge/LegendM9Container;->withoutOwnedCameraXmpMeta(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v3

    .line 394
    .local v3, "original":Ljava/lang/String;
    const-string v4, "    <rdf:Description"

    invoke-virtual {v3, v4}, Ljava/lang/String;->indexOf(Ljava/lang/String;)I

    move-result v4

    .line 395
    .local v4, "mergePoint":I
    if-gez v4, :cond_3

    .line 396
    const-string v5, "</rdf:RDF>"

    invoke-virtual {v3, v5}, Ljava/lang/String;->indexOf(Ljava/lang/String;)I

    move-result v4

    .line 398
    :cond_3
    if-ltz v4, :cond_4

    const/4 v5, 0x1

    goto :goto_1

    :cond_4
    move v5, v2

    :goto_1
    const-string v6, "XMP has no RDF merge point"

    invoke-static {v5, v6}, Llocal/mio/os4camerabridge/LegendM9Container;->require(ZLjava/lang/String;)V

    .line 399
    new-instance v5, Ljava/lang/StringBuilder;

    invoke-direct {v5}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v3, v2, v4}, Ljava/lang/String;->substring(II)Ljava/lang/String;

    move-result-object v6

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    .line 400
    invoke-virtual {v3, v4}, Ljava/lang/String;->substring(I)Ljava/lang/String;

    move-result-object v6

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v5

    move-object v3, v5

    .line 402
    .end local v4    # "mergePoint":I
    .local v3, "merged":Ljava/lang/String;
    :goto_2
    invoke-static {v3}, Llocal/mio/os4camerabridge/LegendM9Container;->xmpApp1(Ljava/lang/String;)[B

    move-result-object v4

    .line 404
    .local v4, "app1":[B
    if-nez v0, :cond_5

    .line 405
    invoke-static {p0}, Llocal/mio/os4camerabridge/LegendM9Container;->metadataInsertion([B)I

    move-result v5

    .line 406
    .local v5, "insertion":I
    invoke-static {p0, v5, v5, v4}, Llocal/mio/os4camerabridge/LegendM9Container;->replace([BII[B)[B

    move-result-object v5

    .line 407
    .local v5, "primaryWithXmp":[B
    goto :goto_3

    .line 408
    .end local v5    # "primaryWithXmp":[B
    :cond_5
    iget v5, v0, Llocal/mio/os4camerabridge/LegendM9Container$Segment;->markerOffset:I

    iget v6, v0, Llocal/mio/os4camerabridge/LegendM9Container$Segment;->markerOffset:I

    iget v7, v0, Llocal/mio/os4camerabridge/LegendM9Container$Segment;->totalLength:I

    add-int/2addr v6, v7

    invoke-static {p0, v5, v6, v4}, Llocal/mio/os4camerabridge/LegendM9Container;->replace([BII[B)[B

    move-result-object v5

    .line 411
    .restart local v5    # "primaryWithXmp":[B
    :goto_3
    array-length v6, v5

    array-length v7, p1

    add-int/2addr v6, v7

    array-length v7, p2

    add-int/2addr v6, v7

    new-array v6, v6, [B

    .line 413
    .local v6, "output":[B
    array-length v7, v5

    invoke-static {v5, v2, v6, v2, v7}, Ljava/lang/System;->arraycopy(Ljava/lang/Object;ILjava/lang/Object;II)V

    .line 415
    array-length v7, v5

    array-length v8, p1

    invoke-static {p1, v2, v6, v7, v8}, Ljava/lang/System;->arraycopy(Ljava/lang/Object;ILjava/lang/Object;II)V

    .line 416
    array-length v7, v5

    array-length v8, p1

    add-int/2addr v7, v8

    array-length v8, p2

    invoke-static {p2, v2, v6, v7, v8}, Ljava/lang/System;->arraycopy(Ljava/lang/Object;ILjava/lang/Object;II)V

    .line 418
    return-object v6
.end method

.method private static buildMessage(Ljava/lang/String;Llocal/mio/os4camerabridge/LegendM9Container$Metadata;[F)[B
    .locals 13
    .param p0, "basename"    # Ljava/lang/String;
    .param p1, "metadata"    # Llocal/mio/os4camerabridge/LegendM9Container$Metadata;
    .param p2, "lsc"    # [F

    .line 258
    const/4 v0, 0x2

    new-array v1, v0, [I

    const/4 v2, 0x1

    const/16 v3, 0xdd

    aput v3, v1, v2

    const/4 v4, 0x0

    const/4 v5, 0x4

    aput v5, v1, v4

    sget-object v6, Ljava/lang/Float;->TYPE:Ljava/lang/Class;

    invoke-static {v6, v1}, Ljava/lang/reflect/Array;->newInstance(Ljava/lang/Class;[I)Ljava/lang/Object;

    move-result-object v1

    check-cast v1, [[F

    .line 259
    .local v1, "reordered":[[F
    const/4 v6, 0x0

    .local v6, "point":I
    :goto_0
    const/4 v7, 0x3

    if-ge v6, v3, :cond_2

    .line 260
    mul-int/lit8 v8, v6, 0x4

    .line 263
    .local v8, "source":I
    aget-object v9, v1, v4

    add-int/lit8 v10, v8, 0x1

    aget v10, p2, v10

    aput v10, v9, v6

    .line 264
    aget-object v9, v1, v2

    add-int/lit8 v10, v8, 0x2

    aget v10, p2, v10

    aput v10, v9, v6

    .line 265
    aget-object v9, v1, v0

    aget v10, p2, v8

    aput v10, v9, v6

    .line 266
    aget-object v7, v1, v7

    add-int/lit8 v9, v8, 0x3

    aget v9, p2, v9

    aput v9, v7, v6

    .line 267
    const/4 v7, 0x0

    .local v7, "channel":I
    :goto_1
    if-ge v7, v5, :cond_1

    .line 268
    aget-object v9, v1, v7

    aget v9, v9, v6

    .line 269
    .local v9, "value":F
    invoke-static {v9}, Ljava/lang/Float;->isFinite(F)Z

    move-result v10

    if-eqz v10, :cond_0

    const v10, 0x3c23d70a    # 0.01f

    cmpl-float v10, v9, v10

    if-lez v10, :cond_0

    const/high16 v10, 0x42800000    # 64.0f

    cmpg-float v10, v9, v10

    if-gtz v10, :cond_0

    move v10, v2

    goto :goto_2

    :cond_0
    move v10, v4

    :goto_2
    new-instance v11, Ljava/lang/StringBuilder;

    invoke-direct {v11}, Ljava/lang/StringBuilder;-><init>()V

    const-string v12, "invalid LSC value "

    invoke-virtual {v11, v12}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v11

    invoke-virtual {v11, v9}, Ljava/lang/StringBuilder;->append(F)Ljava/lang/StringBuilder;

    move-result-object v11

    invoke-virtual {v11}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v11

    invoke-static {v10, v11}, Llocal/mio/os4camerabridge/LegendM9Container;->require(ZLjava/lang/String;)V

    .line 267
    .end local v9    # "value":F
    add-int/lit8 v7, v7, 0x1

    goto :goto_1

    .line 259
    .end local v7    # "channel":I
    .end local v8    # "source":I
    :cond_1
    add-int/lit8 v6, v6, 0x1

    goto :goto_0

    .line 275
    .end local v6    # "point":I
    :cond_2
    new-instance v3, Ljava/io/ByteArrayOutputStream;

    const/16 v6, 0xf3c

    invoke-direct {v3, v6}, Ljava/io/ByteArrayOutputStream;-><init>(I)V

    .line 276
    .local v3, "output":Ljava/io/ByteArrayOutputStream;
    new-instance v6, Ljava/lang/StringBuilder;

    invoke-direct {v6}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v6, p0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    const-string v8, "\u0000"

    invoke-virtual {v6, v8}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    invoke-virtual {v6}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v6

    invoke-static {v3, v2, v6}, Llocal/mio/os4camerabridge/LegendM9Container;->string(Ljava/io/ByteArrayOutputStream;ILjava/lang/String;)V

    .line 277
    iget v6, p1, Llocal/mio/os4camerabridge/LegendM9Container$Metadata;->sensitivityIso:I

    int-to-long v8, v6

    invoke-static {v3, v0, v8, v9}, Llocal/mio/os4camerabridge/LegendM9Container;->varintField(Ljava/io/ByteArrayOutputStream;IJ)V

    .line 278
    iget v6, p1, Llocal/mio/os4camerabridge/LegendM9Container$Metadata;->awbR:F

    iget v8, p1, Llocal/mio/os4camerabridge/LegendM9Container$Metadata;->awbG:F

    iget v9, p1, Llocal/mio/os4camerabridge/LegendM9Container$Metadata;->awbB:F

    new-array v10, v7, [F

    aput v6, v10, v4

    aput v8, v10, v2

    aput v9, v10, v0

    invoke-static {v10}, Llocal/mio/os4camerabridge/LegendM9Container;->floatsMessage([F)[B

    move-result-object v6

    invoke-static {v3, v7, v6}, Llocal/mio/os4camerabridge/LegendM9Container;->message(Ljava/io/ByteArrayOutputStream;I[B)V

    .line 280
    iget v6, p1, Llocal/mio/os4camerabridge/LegendM9Container$Metadata;->adrcGain:F

    invoke-static {v3, v5, v6}, Llocal/mio/os4camerabridge/LegendM9Container;->fixed32(Ljava/io/ByteArrayOutputStream;IF)V

    .line 281
    const/4 v5, 0x5

    iget v6, p1, Llocal/mio/os4camerabridge/LegendM9Container$Metadata;->ispGain:F

    invoke-static {v3, v5, v6}, Llocal/mio/os4camerabridge/LegendM9Container;->fixed32(Ljava/io/ByteArrayOutputStream;IF)V

    .line 282
    const/16 v5, 0x1000

    const/16 v6, 0xc00

    invoke-static {v5, v6}, Llocal/mio/os4camerabridge/LegendM9Container;->rawBoundsMessage(II)[B

    move-result-object v5

    const/4 v6, 0x7

    invoke-static {v3, v6, v5}, Llocal/mio/os4camerabridge/LegendM9Container;->message(Ljava/io/ByteArrayOutputStream;I[B)V

    .line 283
    iget v5, p1, Llocal/mio/os4camerabridge/LegendM9Container$Metadata;->sensorMode:I

    if-eqz v5, :cond_3

    .line 284
    iget v5, p1, Llocal/mio/os4camerabridge/LegendM9Container$Metadata;->sensorMode:I

    int-to-long v5, v5

    const/16 v8, 0x8

    invoke-static {v3, v8, v5, v6}, Llocal/mio/os4camerabridge/LegendM9Container;->varintField(Ljava/io/ByteArrayOutputStream;IJ)V

    .line 286
    :cond_3
    iget v5, p1, Llocal/mio/os4camerabridge/LegendM9Container$Metadata;->exposureMs:F

    const/16 v6, 0x9

    invoke-static {v3, v6, v5}, Llocal/mio/os4camerabridge/LegendM9Container;->fixed32(Ljava/io/ByteArrayOutputStream;IF)V

    .line 287
    const/16 v5, 0xa

    const/high16 v8, 0x3f800000    # 1.0f

    invoke-static {v3, v5, v8}, Llocal/mio/os4camerabridge/LegendM9Container;->fixed32(Ljava/io/ByteArrayOutputStream;IF)V

    .line 288
    iget v5, p1, Llocal/mio/os4camerabridge/LegendM9Container$Metadata;->orientation:I

    if-eqz v5, :cond_4

    .line 289
    iget v5, p1, Llocal/mio/os4camerabridge/LegendM9Container$Metadata;->orientation:I

    int-to-long v8, v5

    const/16 v5, 0xb

    invoke-static {v3, v5, v8, v9}, Llocal/mio/os4camerabridge/LegendM9Container;->varintField(Ljava/io/ByteArrayOutputStream;IJ)V

    .line 291
    :cond_4
    const/16 v5, 0xc

    const-wide/16 v8, 0xd

    invoke-static {v3, v5, v8, v9}, Llocal/mio/os4camerabridge/LegendM9Container;->varintField(Ljava/io/ByteArrayOutputStream;IJ)V

    .line 292
    const/16 v5, 0xd

    const-wide/16 v8, 0x11

    invoke-static {v3, v5, v8, v9}, Llocal/mio/os4camerabridge/LegendM9Container;->varintField(Ljava/io/ByteArrayOutputStream;IJ)V

    .line 293
    const/16 v5, 0xe

    aget-object v4, v1, v4

    invoke-static {v3, v5, v4}, Llocal/mio/os4camerabridge/LegendM9Container;->packedFloats(Ljava/io/ByteArrayOutputStream;I[F)V

    .line 294
    const/16 v4, 0xf

    aget-object v2, v1, v2

    invoke-static {v3, v4, v2}, Llocal/mio/os4camerabridge/LegendM9Container;->packedFloats(Ljava/io/ByteArrayOutputStream;I[F)V

    .line 295
    const/16 v2, 0x10

    aget-object v0, v1, v0

    invoke-static {v3, v2, v0}, Llocal/mio/os4camerabridge/LegendM9Container;->packedFloats(Ljava/io/ByteArrayOutputStream;I[F)V

    .line 296
    const/16 v0, 0x11

    aget-object v2, v1, v7

    invoke-static {v3, v0, v2}, Llocal/mio/os4camerabridge/LegendM9Container;->packedFloats(Ljava/io/ByteArrayOutputStream;I[F)V

    .line 297
    new-array v0, v6, [F

    fill-array-data v0, :array_0

    const/16 v2, 0x12

    invoke-static {v3, v2, v0}, Llocal/mio/os4camerabridge/LegendM9Container;->packedFloats(Ljava/io/ByteArrayOutputStream;I[F)V

    .line 302
    iget v0, p1, Llocal/mio/os4camerabridge/LegendM9Container$Metadata;->cct:I

    int-to-float v0, v0

    const/16 v2, 0x13

    invoke-static {v3, v2, v0}, Llocal/mio/os4camerabridge/LegendM9Container;->fixed32(Ljava/io/ByteArrayOutputStream;IF)V

    .line 303
    iget v0, p1, Llocal/mio/os4camerabridge/LegendM9Container$Metadata;->luxIndex:I

    int-to-long v4, v0

    const/16 v0, 0x14

    invoke-static {v3, v0, v4, v5}, Llocal/mio/os4camerabridge/LegendM9Container;->varintField(Ljava/io/ByteArrayOutputStream;IJ)V

    .line 304
    const/16 v0, 0x16

    const-wide/16 v4, 0x1000

    invoke-static {v3, v0, v4, v5}, Llocal/mio/os4camerabridge/LegendM9Container;->varintField(Ljava/io/ByteArrayOutputStream;IJ)V

    .line 305
    const/16 v0, 0x17

    const-wide/16 v6, 0xc00

    invoke-static {v3, v0, v6, v7}, Llocal/mio/os4camerabridge/LegendM9Container;->varintField(Ljava/io/ByteArrayOutputStream;IJ)V

    .line 306
    const/16 v0, 0x18

    invoke-static {v3, v0, v4, v5}, Llocal/mio/os4camerabridge/LegendM9Container;->varintField(Ljava/io/ByteArrayOutputStream;IJ)V

    .line 307
    const/16 v0, 0x19

    invoke-static {v3, v0, v6, v7}, Llocal/mio/os4camerabridge/LegendM9Container;->varintField(Ljava/io/ByteArrayOutputStream;IJ)V

    .line 308
    iget v0, p1, Llocal/mio/os4camerabridge/LegendM9Container$Metadata;->sensorType:I

    int-to-long v4, v0

    const/16 v0, 0x1b

    invoke-static {v3, v0, v4, v5}, Llocal/mio/os4camerabridge/LegendM9Container;->varintField(Ljava/io/ByteArrayOutputStream;IJ)V

    .line 309
    const/16 v0, 0x1c

    const-string v2, "1.4.251127.0"

    invoke-static {v3, v0, v2}, Llocal/mio/os4camerabridge/LegendM9Container;->string(Ljava/io/ByteArrayOutputStream;ILjava/lang/String;)V

    .line 310
    invoke-virtual {v3}, Ljava/io/ByteArrayOutputStream;->toByteArray()[B

    move-result-object v0

    return-object v0

    :array_0
    .array-data 4
        0x3f800000    # 1.0f
        0x0
        0x0
        0x0
        0x3f800000    # 1.0f
        0x0
        0x0
        0x0
        0x3f800000    # 1.0f
    .end array-data
.end method

.method private static buildTransferLut(II)[I
    .locals 9
    .param p0, "black"    # I
    .param p1, "white"    # I

    .line 202
    const/16 v0, 0x400

    if-ltz p0, :cond_0

    if-ge p0, p1, :cond_0

    if-gt p1, v0, :cond_0

    const/4 v1, 0x1

    goto :goto_0

    :cond_0
    const/4 v1, 0x0

    :goto_0
    const-string v2, "invalid RAW10 levels"

    invoke-static {v1, v2}, Llocal/mio/os4camerabridge/LegendM9Container;->require(ZLjava/lang/String;)V

    .line 204
    sub-int v1, p1, p0

    int-to-float v1, v1

    const/high16 v2, 0x3f800000    # 1.0f

    div-float v1, v2, v1

    .line 205
    .local v1, "inverseRange":F
    int-to-float v3, p0

    mul-float/2addr v3, v1

    .line 206
    .local v3, "normalizedBlack":F
    new-array v0, v0, [I

    .line 207
    .local v0, "lut":[I
    const/4 v4, 0x0

    .local v4, "value":I
    :goto_1
    array-length v5, v0

    if-ge v4, v5, :cond_1

    .line 208
    int-to-float v5, v4

    mul-float/2addr v5, v1

    sub-float/2addr v5, v3

    .line 209
    const/4 v6, 0x0

    invoke-static {v6, v5}, Ljava/lang/Math;->max(FF)F

    move-result v5

    .line 208
    invoke-static {v2, v5}, Ljava/lang/Math;->min(FF)F

    move-result v5

    .line 211
    .local v5, "normalized":F
    float-to-double v7, v5

    .line 213
    invoke-static {v7, v8}, Ljava/lang/Math;->sqrt(D)D

    move-result-wide v7

    double-to-float v7, v7

    const v8, 0x447fc000    # 1023.0f

    mul-float/2addr v7, v8

    .line 212
    invoke-static {v6, v7}, Ljava/lang/Math;->max(FF)F

    move-result v6

    .line 211
    invoke-static {v8, v6}, Ljava/lang/Math;->min(FF)F

    move-result v6

    float-to-int v6, v6

    aput v6, v0, v4

    .line 207
    .end local v5    # "normalized":F
    add-int/lit8 v4, v4, 0x1

    goto :goto_1

    .line 215
    .end local v4    # "value":I
    :cond_1
    return-object v0
.end method

.method private static count(Ljava/lang/String;Ljava/lang/String;)I
    .locals 4
    .param p0, "text"    # Ljava/lang/String;
    .param p1, "needle"    # Ljava/lang/String;

    .line 734
    const/4 v0, 0x0

    .line 735
    .local v0, "count":I
    const/4 v1, 0x0

    .line 737
    .local v1, "cursor":I
    :goto_0
    invoke-virtual {p0, p1, v1}, Ljava/lang/String;->indexOf(Ljava/lang/String;I)I

    move-result v2

    .line 738
    .local v2, "found":I
    if-gez v2, :cond_0

    .line 739
    return v0

    .line 741
    :cond_0
    add-int/lit8 v0, v0, 0x1

    .line 742
    invoke-virtual {p1}, Ljava/lang/String;->length()I

    move-result v3

    add-int v1, v2, v3

    .line 743
    .end local v2    # "found":I
    goto :goto_0
.end method

.method private static findXmp([B)Llocal/mio/os4camerabridge/LegendM9Container$Segment;
    .locals 7
    .param p0, "jpeg"    # [B

    .line 660
    const/4 v0, 0x2

    .line 661
    .local v0, "offset":I
    :goto_0
    add-int/lit8 v1, v0, 0x4

    array-length v2, p0

    const/4 v3, 0x0

    if-gt v1, v2, :cond_6

    .line 662
    aget-byte v1, p0, v0

    const/16 v2, 0xff

    and-int/2addr v1, v2

    if-eq v1, v2, :cond_0

    .line 663
    add-int/lit8 v0, v0, 0x1

    .line 664
    goto :goto_0

    .line 666
    :cond_0
    add-int/lit8 v1, v0, 0x1

    aget-byte v1, p0, v1

    and-int/2addr v1, v2

    .line 667
    .local v1, "marker":I
    const/16 v2, 0xda

    if-ne v1, v2, :cond_1

    .line 668
    return-object v3

    .line 670
    :cond_1
    const/16 v2, 0xd8

    if-eq v1, v2, :cond_5

    const/16 v2, 0xd9

    if-eq v1, v2, :cond_5

    if-eqz v1, :cond_5

    const/16 v2, 0xd0

    if-lt v1, v2, :cond_2

    const/16 v2, 0xd7

    if-gt v1, v2, :cond_2

    goto :goto_2

    .line 675
    :cond_2
    add-int/lit8 v2, v0, 0x2

    invoke-static {p0, v2}, Llocal/mio/os4camerabridge/LegendM9Container;->u16be([BI)I

    move-result v2

    .line 676
    .local v2, "length":I
    add-int/lit8 v3, v2, 0x2

    .line 677
    .local v3, "total":I
    const/4 v4, 0x2

    if-lt v2, v4, :cond_3

    add-int v4, v0, v3

    array-length v5, p0

    if-gt v4, v5, :cond_3

    const/4 v4, 0x1

    goto :goto_1

    :cond_3
    const/4 v4, 0x0

    :goto_1
    const-string v5, "malformed JPEG segment"

    invoke-static {v4, v5}, Llocal/mio/os4camerabridge/LegendM9Container;->require(ZLjava/lang/String;)V

    .line 679
    add-int/lit8 v4, v2, -0x2

    .line 680
    .local v4, "bodyLength":I
    const/16 v5, 0xe1

    if-ne v1, v5, :cond_4

    add-int/lit8 v5, v0, 0x4

    sget-object v6, Llocal/mio/os4camerabridge/LegendM9Container;->XMP_HEADER:[B

    .line 681
    invoke-static {p0, v5, v4, v6}, Llocal/mio/os4camerabridge/LegendM9Container;->startsWith([BII[B)Z

    move-result v5

    if-eqz v5, :cond_4

    .line 682
    new-instance v5, Llocal/mio/os4camerabridge/LegendM9Container$Segment;

    add-int/lit8 v6, v0, 0x4

    invoke-direct {v5, v0, v3, v6, v4}, Llocal/mio/os4camerabridge/LegendM9Container$Segment;-><init>(IIII)V

    return-object v5

    .line 684
    :cond_4
    add-int/2addr v0, v3

    .line 685
    .end local v1    # "marker":I
    .end local v2    # "length":I
    .end local v3    # "total":I
    .end local v4    # "bodyLength":I
    goto :goto_0

    .line 672
    .restart local v1    # "marker":I
    :cond_5
    :goto_2
    add-int/lit8 v0, v0, 0x2

    .line 673
    goto :goto_0

    .line 686
    .end local v1    # "marker":I
    :cond_6
    return-object v3
.end method

.method private static fixed32(Ljava/io/ByteArrayOutputStream;IF)V
    .locals 4
    .param p0, "output"    # Ljava/io/ByteArrayOutputStream;
    .param p1, "field"    # I
    .param p2, "value"    # F

    .line 341
    int-to-long v0, p1

    const/4 v2, 0x3

    shl-long/2addr v0, v2

    const-wide/16 v2, 0x5

    or-long/2addr v0, v2

    invoke-static {p0, v0, v1}, Llocal/mio/os4camerabridge/LegendM9Container;->writeVarint(Ljava/io/ByteArrayOutputStream;J)V

    .line 342
    invoke-static {p2}, Ljava/lang/Float;->floatToRawIntBits(F)I

    move-result v0

    .line 343
    .local v0, "bits":I
    and-int/lit16 v1, v0, 0xff

    invoke-virtual {p0, v1}, Ljava/io/ByteArrayOutputStream;->write(I)V

    .line 344
    ushr-int/lit8 v1, v0, 0x8

    and-int/lit16 v1, v1, 0xff

    invoke-virtual {p0, v1}, Ljava/io/ByteArrayOutputStream;->write(I)V

    .line 345
    ushr-int/lit8 v1, v0, 0x10

    and-int/lit16 v1, v1, 0xff

    invoke-virtual {p0, v1}, Ljava/io/ByteArrayOutputStream;->write(I)V

    .line 346
    ushr-int/lit8 v1, v0, 0x18

    and-int/lit16 v1, v1, 0xff

    invoke-virtual {p0, v1}, Ljava/io/ByteArrayOutputStream;->write(I)V

    .line 347
    return-void
.end method

.method private static varargs floatsMessage([F)[B
    .locals 4
    .param p0, "values"    # [F

    .line 314
    new-instance v0, Ljava/io/ByteArrayOutputStream;

    array-length v1, p0

    mul-int/lit8 v1, v1, 0x5

    invoke-direct {v0, v1}, Ljava/io/ByteArrayOutputStream;-><init>(I)V

    .line 316
    .local v0, "output":Ljava/io/ByteArrayOutputStream;
    const/4 v1, 0x0

    .local v1, "index":I
    :goto_0
    array-length v2, p0

    if-ge v1, v2, :cond_0

    .line 317
    add-int/lit8 v2, v1, 0x1

    aget v3, p0, v1

    invoke-static {v0, v2, v3}, Llocal/mio/os4camerabridge/LegendM9Container;->fixed32(Ljava/io/ByteArrayOutputStream;IF)V

    .line 316
    add-int/lit8 v1, v1, 0x1

    goto :goto_0

    .line 319
    .end local v1    # "index":I
    :cond_0
    invoke-virtual {v0}, Ljava/io/ByteArrayOutputStream;->toByteArray()[B

    move-result-object v1

    return-object v1
.end method

.method private static item(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;
    .locals 6
    .param p0, "xml"    # Ljava/lang/String;
    .param p1, "needle"    # Ljava/lang/String;

    .line 713
    invoke-virtual {p0, p1}, Ljava/lang/String;->indexOf(Ljava/lang/String;)I

    move-result v0

    .line 714
    .local v0, "name":I
    const-string v1, "<MiContainer:Item"

    invoke-virtual {p0, v1, v0}, Ljava/lang/String;->lastIndexOf(Ljava/lang/String;I)I

    move-result v1

    .line 715
    .local v1, "start":I
    const-string v2, "/>"

    invoke-virtual {p0, v2, v0}, Ljava/lang/String;->indexOf(Ljava/lang/String;I)I

    move-result v2

    .line 716
    .local v2, "end":I
    if-ltz v0, :cond_0

    if-ltz v1, :cond_0

    if-ltz v2, :cond_0

    const/4 v3, 0x1

    goto :goto_0

    :cond_0
    const/4 v3, 0x0

    :goto_0
    new-instance v4, Ljava/lang/StringBuilder;

    invoke-direct {v4}, Ljava/lang/StringBuilder;-><init>()V

    const-string v5, "missing item "

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v4

    invoke-static {v3, v4}, Llocal/mio/os4camerabridge/LegendM9Container;->require(ZLjava/lang/String;)V

    .line 718
    invoke-virtual {p0, v1, v2}, Ljava/lang/String;->substring(II)Ljava/lang/String;

    move-result-object v3

    return-object v3
.end method

.method private static itemXml(Ljava/lang/String;IILjava/lang/String;Ljava/lang/String;)Ljava/lang/String;
    .locals 4
    .param p0, "name"    # Ljava/lang/String;
    .param p1, "length"    # I
    .param p2, "offset"    # I
    .param p3, "mime"    # Ljava/lang/String;
    .param p4, "additional"    # Ljava/lang/String;

    .line 522
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "          <rdf:li\n            rdf:parseType=\"Resource\">\n            <MiContainer:Item\n              Item:name=\""

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, p0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, "\"\n              Item:length=\""

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, p1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, "\"\n              Item:Offset=\""

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, p2}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, "\"\n              Item:OffsetType=\"EOF\"\n              Item:Mime=\""

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, p3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, "\""

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    .line 530
    const-string v1, "/>\n"

    if-nez p4, :cond_0

    goto :goto_0

    :cond_0
    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "\n"

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, p4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    :goto_0
    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, "          </rdf:li>\n"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    .line 522
    return-object v0
.end method

.method private static jpegDimensions([B)[I
    .locals 9
    .param p0, "jpeg"    # [B

    .line 759
    const/4 v0, 0x0

    if-eqz p0, :cond_a

    array-length v1, p0

    const/4 v2, 0x4

    if-lt v1, v2, :cond_a

    aget-byte v1, p0, v0

    const/16 v2, 0xff

    and-int/2addr v1, v2

    if-ne v1, v2, :cond_a

    const/4 v1, 0x1

    aget-byte v3, p0, v1

    and-int/2addr v3, v2

    const/16 v4, 0xd8

    if-eq v3, v4, :cond_0

    goto/16 :goto_5

    .line 764
    :cond_0
    const/4 v3, 0x2

    .line 765
    .local v3, "offset":I
    :goto_0
    add-int/lit8 v5, v3, 0x4

    array-length v6, p0

    if-gt v5, v6, :cond_9

    .line 766
    aget-byte v5, p0, v3

    and-int/2addr v5, v2

    if-eq v5, v2, :cond_1

    .line 767
    add-int/lit8 v3, v3, 0x1

    .line 768
    goto :goto_0

    .line 770
    :cond_1
    add-int/lit8 v5, v3, 0x1

    aget-byte v5, p0, v5

    and-int/2addr v5, v2

    .line 771
    .local v5, "marker":I
    if-eq v5, v4, :cond_8

    const/16 v6, 0xd9

    if-eq v5, v6, :cond_8

    if-eqz v5, :cond_8

    const/16 v6, 0xd0

    if-lt v5, v6, :cond_2

    const/16 v6, 0xd7

    if-gt v5, v6, :cond_2

    goto :goto_3

    .line 776
    :cond_2
    add-int/lit8 v6, v3, 0x2

    invoke-static {p0, v6}, Llocal/mio/os4camerabridge/LegendM9Container;->u16be([BI)I

    move-result v6

    .line 777
    .local v6, "length":I
    const/4 v7, 0x2

    if-lt v6, v7, :cond_7

    add-int v8, v3, v6

    add-int/2addr v8, v7

    array-length v7, p0

    if-le v8, v7, :cond_3

    goto :goto_2

    .line 780
    :cond_3
    const/16 v7, 0xc0

    if-lt v5, v7, :cond_4

    const/16 v7, 0xcf

    if-gt v5, v7, :cond_4

    const/16 v7, 0xc4

    if-eq v5, v7, :cond_4

    const/16 v7, 0xc8

    if-eq v5, v7, :cond_4

    const/16 v7, 0xcc

    if-eq v5, v7, :cond_4

    move v7, v1

    goto :goto_1

    :cond_4
    move v7, v0

    .line 782
    .local v7, "sof":Z
    :goto_1
    if-eqz v7, :cond_5

    const/4 v8, 0x7

    if-lt v6, v8, :cond_5

    .line 783
    add-int/lit8 v0, v3, 0x5

    invoke-static {p0, v0}, Llocal/mio/os4camerabridge/LegendM9Container;->u16be([BI)I

    move-result v0

    .line 784
    .local v0, "height":I
    add-int/lit8 v1, v3, 0x7

    invoke-static {p0, v1}, Llocal/mio/os4camerabridge/LegendM9Container;->u16be([BI)I

    move-result v1

    .line 785
    .local v1, "width":I
    filled-new-array {v1, v0}, [I

    move-result-object v2

    return-object v2

    .line 787
    .end local v0    # "height":I
    .end local v1    # "width":I
    :cond_5
    const/16 v8, 0xda

    if-ne v5, v8, :cond_6

    .line 788
    goto :goto_4

    .line 790
    :cond_6
    add-int/lit8 v8, v6, 0x2

    add-int/2addr v3, v8

    .line 791
    .end local v5    # "marker":I
    .end local v6    # "length":I
    .end local v7    # "sof":Z
    goto :goto_0

    .line 778
    .restart local v5    # "marker":I
    .restart local v6    # "length":I
    :cond_7
    :goto_2
    filled-new-array {v0, v0}, [I

    move-result-object v0

    return-object v0

    .line 773
    .end local v6    # "length":I
    :cond_8
    :goto_3
    add-int/lit8 v3, v3, 0x2

    .line 774
    goto :goto_0

    .line 792
    .end local v5    # "marker":I
    :cond_9
    :goto_4
    filled-new-array {v0, v0}, [I

    move-result-object v0

    return-object v0

    .line 762
    .end local v3    # "offset":I
    :cond_a
    :goto_5
    filled-new-array {v0, v0}, [I

    move-result-object v0

    return-object v0
.end method

.method private static m9Fragments(IIII)Ljava/lang/String;
    .locals 5
    .param p0, "rawLength"    # I
    .param p1, "rawOffset"    # I
    .param p2, "metadataLength"    # I
    .param p3, "orientation"    # I

    .line 483
    const-string v0, "&lt;madrid_image type=&quot;701&quot; offset=&quot;0&quot; length=&quot;0&quot; paddingx=&quot;0&quot; paddingy=&quot;0&quot; width=&quot;4096&quot; height=&quot;3072&quot; location_enabled=&quot;0&quot; time_enabled=&quot;0&quot; dark=&quot;0&quot; /&gt;"

    .line 488
    .local v0, "madrid":Ljava/lang/String;
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "    <rdf:Description\n      rdf:about=\"\"\n      xmlns:MiCamera=\"http://ns.xiaomi.com/photos/1.0/camera/\"\n      MiCamera:XMPMeta=\""

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, "\"/>\n    <rdf:Description\n      rdf:about=\"\"\n      xmlns:MiContainer=\""

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, "http://ns.xiaomi.com/photos/1.0/container/"

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, "\"\n      xmlns:Item=\""

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, "http://ns.xiaomi.com/photos/1.0/container/item/"

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, "\"\n      MiContainer:Version=\"1.0\">\n      <MiContainer:Directory>\n        <rdf:Seq>\n"

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "              Item:Orient=\""

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, p3}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v2

    const-string v3, "\"\n              Item:width=\"4096\"\n              Item:height=\"3072\"\n              Item:stride=\"5120\""

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    .line 507
    const-string v3, "Legend.M9"

    const-string v4, "image/mipiraw10"

    invoke-static {v3, p0, p1, v4, v2}, Llocal/mio/os4camerabridge/LegendM9Container;->itemXml(Ljava/lang/String;IILjava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    .line 513
    const-string v2, "Legend.M9.meta"

    const-string v3, "meta/protobuf"

    const/4 v4, 0x0

    invoke-static {v2, p2, p2, v3, v4}, Llocal/mio/os4camerabridge/LegendM9Container;->itemXml(Ljava/lang/String;IILjava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, "        </rdf:Seq>\n      </MiContainer:Directory>\n    </rdf:Description>\n"

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    .line 488
    return-object v1
.end method

.method private static message(Ljava/io/ByteArrayOutputStream;I[B)V
    .locals 4
    .param p0, "output"    # Ljava/io/ByteArrayOutputStream;
    .param p1, "field"    # I
    .param p2, "value"    # [B

    .line 356
    int-to-long v0, p1

    const/4 v2, 0x3

    shl-long/2addr v0, v2

    const-wide/16 v2, 0x2

    or-long/2addr v0, v2

    invoke-static {p0, v0, v1}, Llocal/mio/os4camerabridge/LegendM9Container;->writeVarint(Ljava/io/ByteArrayOutputStream;J)V

    .line 357
    array-length v0, p2

    int-to-long v0, v0

    invoke-static {p0, v0, v1}, Llocal/mio/os4camerabridge/LegendM9Container;->writeVarint(Ljava/io/ByteArrayOutputStream;J)V

    .line 358
    const/4 v0, 0x0

    array-length v1, p2

    invoke-virtual {p0, p2, v0, v1}, Ljava/io/ByteArrayOutputStream;->write([BII)V

    .line 359
    return-void
.end method

.method private static metadataInsertion([B)I
    .locals 5
    .param p0, "jpeg"    # [B

    .line 690
    const/4 v0, 0x2

    .line 691
    .local v0, "offset":I
    const/4 v1, 0x2

    .line 692
    .local v1, "insertion":I
    :goto_0
    add-int/lit8 v2, v0, 0x4

    array-length v3, p0

    if-gt v2, v3, :cond_2

    .line 693
    add-int/lit8 v2, v0, 0x1

    aget-byte v2, p0, v2

    const/16 v3, 0xff

    and-int/2addr v2, v3

    .line 694
    .local v2, "marker":I
    aget-byte v4, p0, v0

    and-int/2addr v4, v3

    if-ne v4, v3, :cond_2

    const/16 v3, 0xe0

    if-eq v2, v3, :cond_0

    const/16 v3, 0xe1

    if-eq v2, v3, :cond_0

    .line 696
    goto :goto_2

    .line 698
    :cond_0
    add-int/lit8 v3, v0, 0x2

    invoke-static {p0, v3}, Llocal/mio/os4camerabridge/LegendM9Container;->u16be([BI)I

    move-result v3

    add-int/2addr v3, v0

    add-int/lit8 v1, v3, 0x2

    .line 699
    array-length v3, p0

    if-gt v1, v3, :cond_1

    const/4 v3, 0x1

    goto :goto_1

    :cond_1
    const/4 v3, 0x0

    :goto_1
    const-string v4, "malformed metadata prefix"

    invoke-static {v3, v4}, Llocal/mio/os4camerabridge/LegendM9Container;->require(ZLjava/lang/String;)V

    .line 700
    move v0, v1

    .line 701
    .end local v2    # "marker":I
    goto :goto_0

    .line 702
    :cond_2
    :goto_2
    return v1
.end method

.method private static normalizeBasename(Ljava/lang/String;)Ljava/lang/String;
    .locals 9
    .param p0, "source"    # Ljava/lang/String;

    .line 139
    if-nez p0, :cond_0

    const-string v0, ""

    goto :goto_0

    :cond_0
    move-object v0, p0

    .line 140
    .local v0, "name":Ljava/lang/String;
    :goto_0
    const/16 v1, 0x2f

    invoke-virtual {v0, v1}, Ljava/lang/String;->lastIndexOf(I)I

    move-result v2

    const/16 v3, 0x5c

    invoke-virtual {v0, v3}, Ljava/lang/String;->lastIndexOf(I)I

    move-result v4

    invoke-static {v2, v4}, Ljava/lang/Math;->max(II)I

    move-result v2

    .line 141
    .local v2, "slash":I
    if-ltz v2, :cond_1

    .line 142
    add-int/lit8 v4, v2, 0x1

    invoke-virtual {v0, v4}, Ljava/lang/String;->substring(I)Ljava/lang/String;

    move-result-object v0

    .line 144
    :cond_1
    const-string v4, ".tmp"

    invoke-virtual {v0, v4}, Ljava/lang/String;->endsWith(Ljava/lang/String;)Z

    move-result v4

    const/4 v5, 0x4

    const/4 v6, 0x0

    if-eqz v4, :cond_2

    .line 145
    invoke-virtual {v0}, Ljava/lang/String;->length()I

    move-result v4

    sub-int/2addr v4, v5

    invoke-virtual {v0, v6, v4}, Ljava/lang/String;->substring(II)Ljava/lang/String;

    move-result-object v0

    .line 147
    :cond_2
    sget-object v4, Ljava/util/Locale;->ROOT:Ljava/util/Locale;

    invoke-virtual {v0, v4}, Ljava/lang/String;->toLowerCase(Ljava/util/Locale;)Ljava/lang/String;

    move-result-object v4

    .line 148
    .local v4, "lower":Ljava/lang/String;
    const-string v7, ".jpg"

    invoke-virtual {v4, v7}, Ljava/lang/String;->endsWith(Ljava/lang/String;)Z

    move-result v8

    if-nez v8, :cond_3

    const-string v8, ".jpeg"

    invoke-virtual {v4, v8}, Ljava/lang/String;->endsWith(Ljava/lang/String;)Z

    move-result v8

    if-nez v8, :cond_3

    .line 149
    new-instance v8, Ljava/lang/StringBuilder;

    invoke-direct {v8}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v8, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v8

    invoke-virtual {v8, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v7

    invoke-virtual {v7}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    .line 151
    :cond_3
    invoke-virtual {v0}, Ljava/lang/String;->length()I

    move-result v7

    if-le v7, v5, :cond_4

    invoke-virtual {v0, v1}, Ljava/lang/String;->indexOf(I)I

    move-result v1

    if-gez v1, :cond_4

    .line 152
    invoke-virtual {v0, v3}, Ljava/lang/String;->indexOf(I)I

    move-result v1

    if-gez v1, :cond_4

    const/4 v6, 0x1

    goto :goto_1

    :cond_4
    nop

    :goto_1
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "invalid M9 basename \'"

    invoke-virtual {v1, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v3, "\'"

    invoke-virtual {v1, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    .line 151
    invoke-static {v6, v1}, Llocal/mio/os4camerabridge/LegendM9Container;->require(ZLjava/lang/String;)V

    .line 154
    return-object v0
.end method

.method private static packRggbToCloudBggr([BIILjava/lang/String;)[B
    .locals 23
    .param p0, "source"    # [B
    .param p1, "black"    # I
    .param p2, "white"    # I
    .param p3, "basename"    # Ljava/lang/String;

    .line 165
    move-object/from16 v0, p0

    invoke-static/range {p1 .. p2}, Llocal/mio/os4camerabridge/LegendM9Container;->buildTransferLut(II)[I

    move-result-object v1

    .line 166
    .local v1, "lut":[I
    invoke-virtual {v0}, [B->clone()Ljava/lang/Object;

    move-result-object v2

    move-object v3, v2

    check-cast v3, [B

    .line 167
    .local v3, "output":[B
    const/16 v2, 0x1400

    .line 168
    .local v2, "activeRowBytes":I
    const/4 v4, 0x0

    move v9, v4

    .local v9, "row":I
    :goto_0
    const/16 v4, 0xc00

    if-ge v9, v4, :cond_1

    .line 169
    mul-int/lit16 v10, v9, 0x1400

    .line 170
    .local v10, "top":I
    add-int/lit16 v11, v10, 0x1400

    .line 171
    .local v11, "bottom":I
    const/4 v4, 0x0

    move v12, v4

    .local v12, "columnByte":I
    :goto_1
    if-ge v12, v2, :cond_0

    .line 173
    add-int v4, v10, v12

    .line 174
    .local v4, "topOffset":I
    add-int v13, v11, v12

    .line 175
    .local v13, "bottomOffset":I
    const/4 v5, 0x0

    invoke-static {v0, v4, v5}, Llocal/mio/os4camerabridge/LegendM9Container;->raw10Pixel([BII)I

    move-result v14

    .line 176
    .local v14, "top0":I
    const/4 v6, 0x1

    invoke-static {v0, v4, v6}, Llocal/mio/os4camerabridge/LegendM9Container;->raw10Pixel([BII)I

    move-result v15

    .line 177
    .local v15, "top1":I
    const/4 v7, 0x2

    invoke-static {v0, v4, v7}, Llocal/mio/os4camerabridge/LegendM9Container;->raw10Pixel([BII)I

    move-result v16

    .line 178
    .local v16, "top2":I
    const/4 v8, 0x3

    invoke-static {v0, v4, v8}, Llocal/mio/os4camerabridge/LegendM9Container;->raw10Pixel([BII)I

    move-result v17

    .line 179
    .local v17, "top3":I
    invoke-static {v0, v13, v5}, Llocal/mio/os4camerabridge/LegendM9Container;->raw10Pixel([BII)I

    move-result v18

    .line 180
    .local v18, "bottom0":I
    invoke-static {v0, v13, v6}, Llocal/mio/os4camerabridge/LegendM9Container;->raw10Pixel([BII)I

    move-result v19

    .line 181
    .local v19, "bottom1":I
    invoke-static {v0, v13, v7}, Llocal/mio/os4camerabridge/LegendM9Container;->raw10Pixel([BII)I

    move-result v20

    .line 182
    .local v20, "bottom2":I
    invoke-static {v0, v13, v8}, Llocal/mio/os4camerabridge/LegendM9Container;->raw10Pixel([BII)I

    move-result v21

    .line 184
    .local v21, "bottom3":I
    aget v5, v1, v19

    aget v6, v1, v18

    aget v7, v1, v21

    aget v8, v1, v20

    invoke-static/range {v3 .. v8}, Llocal/mio/os4camerabridge/LegendM9Container;->writeGroup([BIIIII)V

    .line 187
    move/from16 v22, v4

    .end local v4    # "topOffset":I
    .local v22, "topOffset":I
    aget v5, v1, v15

    aget v6, v1, v14

    aget v7, v1, v17

    aget v8, v1, v16

    move v4, v13

    .end local v13    # "bottomOffset":I
    .local v4, "bottomOffset":I
    invoke-static/range {v3 .. v8}, Llocal/mio/os4camerabridge/LegendM9Container;->writeGroup([BIIIII)V

    .line 172
    .end local v4    # "bottomOffset":I
    .end local v14    # "top0":I
    .end local v15    # "top1":I
    .end local v16    # "top2":I
    .end local v17    # "top3":I
    .end local v18    # "bottom0":I
    .end local v19    # "bottom1":I
    .end local v20    # "bottom2":I
    .end local v21    # "bottom3":I
    .end local v22    # "topOffset":I
    add-int/lit8 v12, v12, 0x5

    goto :goto_1

    .line 168
    .end local v10    # "top":I
    .end local v11    # "bottom":I
    .end local v12    # "columnByte":I
    :cond_0
    add-int/lit8 v9, v9, 0x2

    goto :goto_0

    .line 191
    .end local v9    # "row":I
    :cond_1
    move-object/from16 v4, p3

    invoke-static {v3, v4}, Llocal/mio/os4camerabridge/LegendM9Container;->rc4XorInPlace([BLjava/lang/String;)V

    .line 192
    return-object v3
.end method

.method private static packedFloats(Ljava/io/ByteArrayOutputStream;I[F)V
    .locals 4
    .param p0, "output"    # Ljava/io/ByteArrayOutputStream;
    .param p1, "field"    # I
    .param p2, "values"    # [F

    .line 331
    array-length v0, p2

    mul-int/lit8 v0, v0, 0x4

    invoke-static {v0}, Ljava/nio/ByteBuffer;->allocate(I)Ljava/nio/ByteBuffer;

    move-result-object v0

    sget-object v1, Ljava/nio/ByteOrder;->LITTLE_ENDIAN:Ljava/nio/ByteOrder;

    .line 332
    invoke-virtual {v0, v1}, Ljava/nio/ByteBuffer;->order(Ljava/nio/ByteOrder;)Ljava/nio/ByteBuffer;

    move-result-object v0

    .line 333
    .local v0, "bytes":Ljava/nio/ByteBuffer;
    array-length v1, p2

    const/4 v2, 0x0

    :goto_0
    if-ge v2, v1, :cond_0

    aget v3, p2, v2

    .line 334
    .local v3, "value":F
    invoke-virtual {v0, v3}, Ljava/nio/ByteBuffer;->putFloat(F)Ljava/nio/ByteBuffer;

    .line 333
    .end local v3    # "value":F
    add-int/lit8 v2, v2, 0x1

    goto :goto_0

    .line 336
    :cond_0
    invoke-virtual {v0}, Ljava/nio/ByteBuffer;->array()[B

    move-result-object v1

    invoke-static {p0, p1, v1}, Llocal/mio/os4camerabridge/LegendM9Container;->message(Ljava/io/ByteArrayOutputStream;I[B)V

    .line 337
    return-void
.end method

.method private static positive(Ljava/lang/String;Ljava/lang/String;)I
    .locals 8
    .param p0, "text"    # Ljava/lang/String;
    .param p1, "attribute"    # Ljava/lang/String;

    .line 722
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v0, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, "=\""

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    .line 723
    .local v0, "prefix":Ljava/lang/String;
    invoke-virtual {p0, v0}, Ljava/lang/String;->indexOf(Ljava/lang/String;)I

    move-result v1

    .line 724
    .local v1, "start":I
    if-gez v1, :cond_0

    const/4 v2, -0x1

    goto :goto_0

    .line 725
    :cond_0
    invoke-virtual {v0}, Ljava/lang/String;->length()I

    move-result v2

    add-int/2addr v2, v1

    const/16 v3, 0x22

    invoke-virtual {p0, v3, v2}, Ljava/lang/String;->indexOf(II)I

    move-result v2

    :goto_0
    nop

    .line 726
    .local v2, "end":I
    const/4 v3, 0x1

    const/4 v4, 0x0

    if-ltz v1, :cond_1

    if-ltz v2, :cond_1

    move v5, v3

    goto :goto_1

    :cond_1
    move v5, v4

    :goto_1
    new-instance v6, Ljava/lang/StringBuilder;

    invoke-direct {v6}, Ljava/lang/StringBuilder;-><init>()V

    const-string v7, "missing "

    invoke-virtual {v6, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    invoke-virtual {v6, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    invoke-virtual {v6}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v6

    invoke-static {v5, v6}, Llocal/mio/os4camerabridge/LegendM9Container;->require(ZLjava/lang/String;)V

    .line 727
    nop

    .line 728
    invoke-virtual {v0}, Ljava/lang/String;->length()I

    move-result v5

    add-int/2addr v5, v1

    .line 727
    invoke-virtual {p0, v5, v2}, Ljava/lang/String;->substring(II)Ljava/lang/String;

    move-result-object v5

    invoke-static {v5}, Ljava/lang/Integer;->parseInt(Ljava/lang/String;)I

    move-result v5

    .line 729
    .local v5, "value":I
    if-lez v5, :cond_2

    goto :goto_2

    :cond_2
    move v3, v4

    :goto_2
    new-instance v4, Ljava/lang/StringBuilder;

    invoke-direct {v4}, Ljava/lang/StringBuilder;-><init>()V

    const-string v6, "nonpositive "

    invoke-virtual {v4, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v4

    invoke-static {v3, v4}, Llocal/mio/os4camerabridge/LegendM9Container;->require(ZLjava/lang/String;)V

    .line 730
    return v5
.end method

.method private static positive(F)Z
    .locals 1
    .param p0, "value"    # F

    .line 814
    invoke-static {p0}, Ljava/lang/Float;->isFinite(F)Z

    move-result v0

    if-eqz v0, :cond_0

    const/4 v0, 0x0

    cmpl-float v0, p0, v0

    if-lez v0, :cond_0

    const/4 v0, 0x1

    goto :goto_0

    :cond_0
    const/4 v0, 0x0

    :goto_0
    return v0
.end method

.method private static raw10Pixel([BII)I
    .locals 3
    .param p0, "bytes"    # [B
    .param p1, "offset"    # I
    .param p2, "pixel"    # I

    .line 196
    add-int/lit8 v0, p1, 0x4

    aget-byte v0, p0, v0

    and-int/lit16 v0, v0, 0xff

    .line 197
    .local v0, "low":I
    add-int v1, p1, p2

    aget-byte v1, p0, v1

    and-int/lit16 v1, v1, 0xff

    shl-int/lit8 v1, v1, 0x2

    mul-int/lit8 v2, p2, 0x2

    ushr-int v2, v0, v2

    and-int/lit8 v2, v2, 0x3

    or-int/2addr v1, v2

    return v1
.end method

.method private static rawBoundsMessage(II)[B
    .locals 3
    .param p0, "width"    # I
    .param p1, "height"    # I

    .line 323
    new-instance v0, Ljava/io/ByteArrayOutputStream;

    const/16 v1, 0xa

    invoke-direct {v0, v1}, Ljava/io/ByteArrayOutputStream;-><init>(I)V

    .line 324
    .local v0, "output":Ljava/io/ByteArrayOutputStream;
    const/4 v1, 0x3

    int-to-float v2, p0

    invoke-static {v0, v1, v2}, Llocal/mio/os4camerabridge/LegendM9Container;->fixed32(Ljava/io/ByteArrayOutputStream;IF)V

    .line 325
    const/4 v1, 0x4

    int-to-float v2, p1

    invoke-static {v0, v1, v2}, Llocal/mio/os4camerabridge/LegendM9Container;->fixed32(Ljava/io/ByteArrayOutputStream;IF)V

    .line 326
    invoke-virtual {v0}, Ljava/io/ByteArrayOutputStream;->toByteArray()[B

    move-result-object v1

    return-object v1
.end method

.method private static rc4XorInPlace([BLjava/lang/String;)V
    .locals 10
    .param p0, "bytes"    # [B
    .param p1, "basename"    # Ljava/lang/String;

    .line 219
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "xiaomi"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, "niubi_f4d7a2c9e1b3f5a7d2c4e6b8f0a1c3d5e7b9f2a4c6e8b0f1a3c5e7b9f0a2c4d6"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    sget-object v1, Ljava/nio/charset/StandardCharsets;->UTF_8:Ljava/nio/charset/Charset;

    .line 220
    invoke-virtual {v0, v1}, Ljava/lang/String;->getBytes(Ljava/nio/charset/Charset;)[B

    move-result-object v0

    .line 221
    .local v0, "key":[B
    array-length v1, v0

    const/16 v2, 0xfe

    invoke-static {v1, v2}, Ljava/lang/Math;->min(II)I

    move-result v1

    .line 222
    .local v1, "keyLength":I
    if-lez v1, :cond_0

    const/4 v2, 0x1

    goto :goto_0

    :cond_0
    const/4 v2, 0x0

    :goto_0
    const-string v3, "empty RAW RC4 key"

    invoke-static {v2, v3}, Llocal/mio/os4camerabridge/LegendM9Container;->require(ZLjava/lang/String;)V

    .line 223
    const/16 v2, 0x100

    new-array v2, v2, [I

    .line 224
    .local v2, "state":[I
    const/4 v3, 0x0

    .local v3, "index":I
    :goto_1
    array-length v4, v2

    if-ge v3, v4, :cond_1

    .line 225
    aput v3, v2, v3

    .line 224
    add-int/lit8 v3, v3, 0x1

    goto :goto_1

    .line 227
    .end local v3    # "index":I
    :cond_1
    const/4 v3, 0x0

    .line 228
    .local v3, "j":I
    const/4 v4, 0x0

    .local v4, "index":I
    :goto_2
    array-length v5, v2

    if-ge v4, v5, :cond_2

    .line 229
    aget v5, v2, v4

    add-int/2addr v5, v3

    rem-int v6, v4, v1

    aget-byte v6, v0, v6

    and-int/lit16 v6, v6, 0xff

    add-int/2addr v5, v6

    and-int/lit16 v3, v5, 0xff

    .line 230
    aget v5, v2, v4

    .line 231
    .local v5, "swap":I
    aget v6, v2, v3

    aput v6, v2, v4

    .line 232
    aput v5, v2, v3

    .line 228
    .end local v5    # "swap":I
    add-int/lit8 v4, v4, 0x1

    goto :goto_2

    .line 234
    .end local v4    # "index":I
    :cond_2
    const/4 v4, 0x0

    .line 235
    .local v4, "i":I
    const/4 v3, 0x0

    .line 236
    const/4 v5, 0x0

    .local v5, "index":I
    :goto_3
    array-length v6, p0

    if-ge v5, v6, :cond_3

    .line 237
    add-int/lit8 v6, v4, 0x1

    and-int/lit16 v4, v6, 0xff

    .line 238
    aget v6, v2, v4

    add-int/2addr v6, v3

    and-int/lit16 v3, v6, 0xff

    .line 239
    aget v6, v2, v4

    .line 240
    .local v6, "swap":I
    aget v7, v2, v3

    aput v7, v2, v4

    .line 241
    aput v6, v2, v3

    .line 242
    aget-byte v7, p0, v5

    aget v8, v2, v4

    aget v9, v2, v3

    add-int/2addr v8, v9

    and-int/lit16 v8, v8, 0xff

    aget v8, v2, v8

    int-to-byte v8, v8

    xor-int/2addr v7, v8

    int-to-byte v7, v7

    aput-byte v7, p0, v5

    .line 236
    .end local v6    # "swap":I
    add-int/lit8 v5, v5, 0x1

    goto :goto_3

    .line 244
    .end local v5    # "index":I
    :cond_3
    return-void
.end method

.method private static replace([BII[B)[B
    .locals 3
    .param p0, "source"    # [B
    .param p1, "start"    # I
    .param p2, "end"    # I
    .param p3, "replacement"    # [B

    .line 748
    array-length v0, p0

    sub-int v1, p2, p1

    sub-int/2addr v0, v1

    array-length v1, p3

    add-int/2addr v0, v1

    new-array v0, v0, [B

    .line 750
    .local v0, "output":[B
    const/4 v1, 0x0

    invoke-static {p0, v1, v0, v1, p1}, Ljava/lang/System;->arraycopy(Ljava/lang/Object;ILjava/lang/Object;II)V

    .line 751
    array-length v2, p3

    invoke-static {p3, v1, v0, p1, v2}, Ljava/lang/System;->arraycopy(Ljava/lang/Object;ILjava/lang/Object;II)V

    .line 753
    array-length v1, p3

    add-int/2addr v1, p1

    array-length v2, p0

    sub-int/2addr v2, p2

    invoke-static {p0, p2, v0, v1, v2}, Ljava/lang/System;->arraycopy(Ljava/lang/Object;ILjava/lang/Object;II)V

    .line 755
    return-object v0
.end method

.method private static require(ZLjava/lang/String;)V
    .locals 1
    .param p0, "condition"    # Z
    .param p1, "message"    # Ljava/lang/String;

    .line 818
    if-eqz p0, :cond_0

    .line 821
    return-void

    .line 819
    :cond_0
    new-instance v0, Ljava/lang/IllegalArgumentException;

    invoke-direct {v0, p1}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw v0
.end method

.method private static requireJpeg([B)V
    .locals 4
    .param p0, "jpeg"    # [B

    .line 824
    const/4 v0, 0x0

    if-eqz p0, :cond_0

    array-length v1, p0

    const/4 v2, 0x4

    if-lt v1, v2, :cond_0

    aget-byte v1, p0, v0

    const/16 v2, 0xff

    and-int/2addr v1, v2

    if-ne v1, v2, :cond_0

    const/4 v1, 0x1

    aget-byte v3, p0, v1

    and-int/2addr v2, v3

    const/16 v3, 0xd8

    if-ne v2, v3, :cond_0

    move v0, v1

    :cond_0
    const-string v1, "input is not a JPEG"

    invoke-static {v0, v1}, Llocal/mio/os4camerabridge/LegendM9Container;->require(ZLjava/lang/String;)V

    .line 828
    return-void
.end method

.method private static requireOwnedCameraDescription(Ljava/lang/String;)V
    .locals 10
    .param p0, "opening"    # Ljava/lang/String;

    .line 560
    const-string v0, "<rdf:Description"

    invoke-virtual {v0}, Ljava/lang/String;->length()I

    move-result v0

    .line 561
    .local v0, "cursor":I
    const/4 v1, 0x0

    .line 562
    .local v1, "found":Z
    :goto_0
    invoke-virtual {p0}, Ljava/lang/String;->length()I

    move-result v2

    if-ge v0, v2, :cond_d

    .line 563
    :goto_1
    invoke-virtual {p0}, Ljava/lang/String;->length()I

    move-result v2

    if-ge v0, v2, :cond_0

    .line 564
    invoke-virtual {p0, v0}, Ljava/lang/String;->charAt(I)C

    move-result v2

    invoke-static {v2}, Ljava/lang/Character;->isWhitespace(C)Z

    move-result v2

    if-eqz v2, :cond_0

    .line 565
    add-int/lit8 v0, v0, 0x1

    goto :goto_1

    .line 567
    :cond_0
    invoke-virtual {p0}, Ljava/lang/String;->length()I

    move-result v2

    if-ge v0, v2, :cond_d

    invoke-virtual {p0, v0}, Ljava/lang/String;->charAt(I)C

    move-result v2

    const/16 v3, 0x3e

    if-eq v2, v3, :cond_d

    .line 568
    invoke-virtual {p0, v0}, Ljava/lang/String;->charAt(I)C

    move-result v2

    const/16 v4, 0x2f

    if-ne v2, v4, :cond_1

    .line 569
    goto/16 :goto_a

    .line 571
    :cond_1
    move v2, v0

    .line 572
    .local v2, "nameEnd":I
    :goto_2
    invoke-virtual {p0}, Ljava/lang/String;->length()I

    move-result v5

    const/16 v6, 0x3d

    if-ge v2, v5, :cond_3

    .line 573
    invoke-virtual {p0, v2}, Ljava/lang/String;->charAt(I)C

    move-result v5

    .line 574
    .local v5, "value":C
    invoke-static {v5}, Ljava/lang/Character;->isWhitespace(C)Z

    move-result v7

    if-nez v7, :cond_3

    if-eq v5, v6, :cond_3

    if-eq v5, v3, :cond_3

    if-ne v5, v4, :cond_2

    .line 576
    goto :goto_3

    .line 578
    :cond_2
    nop

    .end local v5    # "value":C
    add-int/lit8 v2, v2, 0x1

    .line 579
    goto :goto_2

    .line 580
    :cond_3
    :goto_3
    invoke-virtual {p0, v0, v2}, Ljava/lang/String;->substring(II)Ljava/lang/String;

    move-result-object v3

    .line 581
    .local v3, "name":Ljava/lang/String;
    move v0, v2

    .line 582
    :goto_4
    invoke-virtual {p0}, Ljava/lang/String;->length()I

    move-result v4

    if-ge v0, v4, :cond_4

    .line 583
    invoke-virtual {p0, v0}, Ljava/lang/String;->charAt(I)C

    move-result v4

    invoke-static {v4}, Ljava/lang/Character;->isWhitespace(C)Z

    move-result v4

    if-eqz v4, :cond_4

    .line 584
    add-int/lit8 v0, v0, 0x1

    goto :goto_4

    .line 586
    :cond_4
    invoke-virtual {p0}, Ljava/lang/String;->length()I

    move-result v4

    const/4 v5, 0x0

    const/4 v7, 0x1

    if-ge v0, v4, :cond_5

    invoke-virtual {p0, v0}, Ljava/lang/String;->charAt(I)C

    move-result v4

    if-ne v4, v6, :cond_5

    move v4, v7

    goto :goto_5

    :cond_5
    move v4, v5

    :goto_5
    const-string v6, "malformed MiCamera:XMPMeta attribute"

    invoke-static {v4, v6}, Llocal/mio/os4camerabridge/LegendM9Container;->require(ZLjava/lang/String;)V

    .line 588
    add-int/lit8 v0, v0, 0x1

    .line 589
    :goto_6
    invoke-virtual {p0}, Ljava/lang/String;->length()I

    move-result v4

    if-ge v0, v4, :cond_6

    .line 590
    invoke-virtual {p0, v0}, Ljava/lang/String;->charAt(I)C

    move-result v4

    invoke-static {v4}, Ljava/lang/Character;->isWhitespace(C)Z

    move-result v4

    if-eqz v4, :cond_6

    .line 591
    add-int/lit8 v0, v0, 0x1

    goto :goto_6

    .line 593
    :cond_6
    invoke-virtual {p0}, Ljava/lang/String;->length()I

    move-result v4

    if-ge v0, v4, :cond_8

    .line 594
    invoke-virtual {p0, v0}, Ljava/lang/String;->charAt(I)C

    move-result v4

    const/16 v6, 0x22

    if-eq v4, v6, :cond_7

    .line 595
    invoke-virtual {p0, v0}, Ljava/lang/String;->charAt(I)C

    move-result v4

    const/16 v6, 0x27

    if-ne v4, v6, :cond_8

    :cond_7
    move v4, v7

    goto :goto_7

    :cond_8
    move v4, v5

    .line 593
    :goto_7
    const-string v6, "unquoted MiCamera:XMPMeta attribute"

    invoke-static {v4, v6}, Llocal/mio/os4camerabridge/LegendM9Container;->require(ZLjava/lang/String;)V

    .line 597
    invoke-virtual {p0, v0}, Ljava/lang/String;->charAt(I)C

    move-result v4

    .line 598
    .local v4, "quote":C
    add-int/lit8 v6, v0, 0x1

    invoke-virtual {p0, v4, v6}, Ljava/lang/String;->indexOf(II)I

    move-result v6

    .line 599
    .local v6, "valueEnd":I
    if-ltz v6, :cond_9

    move v8, v7

    goto :goto_8

    :cond_9
    move v8, v5

    :goto_8
    const-string v9, "unterminated MiCamera:XMPMeta attribute"

    invoke-static {v8, v9}, Llocal/mio/os4camerabridge/LegendM9Container;->require(ZLjava/lang/String;)V

    .line 601
    const-string v8, "MiCamera:XMPMeta"

    invoke-virtual {v8, v3}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v8

    if-eqz v8, :cond_a

    .line 602
    const/4 v1, 0x1

    goto :goto_9

    .line 604
    :cond_a
    const-string v8, "rdf:about"

    invoke-virtual {v8, v3}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v8

    if-nez v8, :cond_b

    const-string v8, "xmlns:"

    invoke-virtual {v3, v8}, Ljava/lang/String;->startsWith(Ljava/lang/String;)Z

    move-result v8

    if-eqz v8, :cond_c

    :cond_b
    move v5, v7

    :cond_c
    new-instance v7, Ljava/lang/StringBuilder;

    invoke-direct {v7}, Ljava/lang/StringBuilder;-><init>()V

    const-string v8, "MiCamera:XMPMeta description owns attribute "

    invoke-virtual {v7, v8}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v7

    invoke-virtual {v7, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v7

    invoke-virtual {v7}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v7

    invoke-static {v5, v7}, Llocal/mio/os4camerabridge/LegendM9Container;->require(ZLjava/lang/String;)V

    .line 607
    :goto_9
    add-int/lit8 v0, v6, 0x1

    .line 608
    .end local v2    # "nameEnd":I
    .end local v3    # "name":Ljava/lang/String;
    .end local v4    # "quote":C
    .end local v6    # "valueEnd":I
    goto/16 :goto_0

    .line 609
    :cond_d
    :goto_a
    const-string v2, "MiCamera:XMPMeta property disappeared"

    invoke-static {v1, v2}, Llocal/mio/os4camerabridge/LegendM9Container;->require(ZLjava/lang/String;)V

    .line 610
    return-void
.end method

.method private static startsWith([BII[B)Z
    .locals 4
    .param p0, "source"    # [B
    .param p1, "offset"    # I
    .param p2, "available"    # I
    .param p3, "prefix"    # [B

    .line 797
    array-length v0, p3

    const/4 v1, 0x0

    if-lt p2, v0, :cond_3

    if-ltz p1, :cond_3

    array-length v0, p3

    add-int/2addr v0, p1

    array-length v2, p0

    if-le v0, v2, :cond_0

    goto :goto_1

    .line 801
    :cond_0
    const/4 v0, 0x0

    .local v0, "index":I
    :goto_0
    array-length v2, p3

    if-ge v0, v2, :cond_2

    .line 802
    add-int v2, p1, v0

    aget-byte v2, p0, v2

    aget-byte v3, p3, v0

    if-eq v2, v3, :cond_1

    .line 803
    return v1

    .line 801
    :cond_1
    add-int/lit8 v0, v0, 0x1

    goto :goto_0

    .line 806
    .end local v0    # "index":I
    :cond_2
    const/4 v0, 0x1

    return v0

    .line 799
    :cond_3
    :goto_1
    return v1
.end method

.method private static string(Ljava/io/ByteArrayOutputStream;ILjava/lang/String;)V
    .locals 1
    .param p0, "output"    # Ljava/io/ByteArrayOutputStream;
    .param p1, "field"    # I
    .param p2, "value"    # Ljava/lang/String;

    .line 351
    sget-object v0, Ljava/nio/charset/StandardCharsets;->UTF_8:Ljava/nio/charset/Charset;

    invoke-virtual {p2, v0}, Ljava/lang/String;->getBytes(Ljava/nio/charset/Charset;)[B

    move-result-object v0

    invoke-static {p0, p1, v0}, Llocal/mio/os4camerabridge/LegendM9Container;->message(Ljava/io/ByteArrayOutputStream;I[B)V

    .line 352
    return-void
.end method

.method private static u16be([BI)I
    .locals 2
    .param p0, "bytes"    # [B
    .param p1, "offset"    # I

    .line 810
    aget-byte v0, p0, p1

    and-int/lit16 v0, v0, 0xff

    shl-int/lit8 v0, v0, 0x8

    add-int/lit8 v1, p1, 0x1

    aget-byte v1, p0, v1

    and-int/lit16 v1, v1, 0xff

    or-int/2addr v0, v1

    return v0
.end method

.method private static varintField(Ljava/io/ByteArrayOutputStream;IJ)V
    .locals 3
    .param p0, "output"    # Ljava/io/ByteArrayOutputStream;
    .param p1, "field"    # I
    .param p2, "value"    # J

    .line 363
    int-to-long v0, p1

    const/4 v2, 0x3

    shl-long/2addr v0, v2

    invoke-static {p0, v0, v1}, Llocal/mio/os4camerabridge/LegendM9Container;->writeVarint(Ljava/io/ByteArrayOutputStream;J)V

    .line 364
    invoke-static {p0, p2, p3}, Llocal/mio/os4camerabridge/LegendM9Container;->writeVarint(Ljava/io/ByteArrayOutputStream;J)V

    .line 365
    return-void
.end method

.method private static verify([BII)V
    .locals 16
    .param p0, "output"    # [B
    .param p1, "rawLength"    # I
    .param p2, "metadataLength"    # I

    .line 614
    move-object/from16 v0, p0

    move/from16 v1, p1

    move/from16 v2, p2

    invoke-static {v0}, Llocal/mio/os4camerabridge/LegendM9Container;->requireJpeg([B)V

    .line 615
    invoke-static {v0}, Llocal/mio/os4camerabridge/LegendExifTagger;->read([B)I

    move-result v3

    const/4 v5, 0x1

    if-ne v3, v5, :cond_0

    move v3, v5

    goto :goto_0

    :cond_0
    const/4 v3, 0x0

    :goto_0
    const-string v6, "M9 EXIF marker missing"

    invoke-static {v3, v6}, Llocal/mio/os4camerabridge/LegendM9Container;->require(ZLjava/lang/String;)V

    .line 617
    invoke-static {v0}, Llocal/mio/os4camerabridge/LegendM9Container;->findXmp([B)Llocal/mio/os4camerabridge/LegendM9Container$Segment;

    move-result-object v3

    .line 618
    .local v3, "xmp":Llocal/mio/os4camerabridge/LegendM9Container$Segment;
    if-eqz v3, :cond_1

    move v6, v5

    goto :goto_1

    :cond_1
    const/4 v6, 0x0

    :goto_1
    const-string v7, "M9 XMP missing"

    invoke-static {v6, v7}, Llocal/mio/os4camerabridge/LegendM9Container;->require(ZLjava/lang/String;)V

    .line 619
    invoke-static {v0, v3}, Llocal/mio/os4camerabridge/LegendM9Container;->xml([BLlocal/mio/os4camerabridge/LegendM9Container$Segment;)Ljava/lang/String;

    move-result-object v6

    .line 620
    .local v6, "text":Ljava/lang/String;
    const-string v7, "MiCamera:XMPMeta="

    invoke-static {v6, v7}, Llocal/mio/os4camerabridge/LegendM9Container;->count(Ljava/lang/String;Ljava/lang/String;)I

    move-result v7

    if-gt v7, v5, :cond_2

    move v7, v5

    goto :goto_2

    :cond_2
    const/4 v7, 0x0

    :goto_2
    const-string v8, "M9 must not duplicate native watermark metadata"

    invoke-static {v7, v8}, Llocal/mio/os4camerabridge/LegendM9Container;->require(ZLjava/lang/String;)V

    .line 622
    const-string v7, "Item:name=\"Legend.M9\""

    invoke-static {v6, v7}, Llocal/mio/os4camerabridge/LegendM9Container;->count(Ljava/lang/String;Ljava/lang/String;)I

    move-result v8

    const-string v9, "Item:name=\"Legend.M9.meta\""

    if-ne v8, v5, :cond_3

    .line 623
    invoke-static {v6, v9}, Llocal/mio/os4camerabridge/LegendM9Container;->count(Ljava/lang/String;Ljava/lang/String;)I

    move-result v8

    if-ne v8, v5, :cond_3

    move v8, v5

    goto :goto_3

    :cond_3
    const/4 v8, 0x0

    .line 622
    :goto_3
    const-string v10, "M9 item set invalid"

    invoke-static {v8, v10}, Llocal/mio/os4camerabridge/LegendM9Container;->require(ZLjava/lang/String;)V

    .line 625
    invoke-static {v6, v7}, Llocal/mio/os4camerabridge/LegendM9Container;->item(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v7

    .line 626
    .local v7, "rawItem":Ljava/lang/String;
    invoke-static {v6, v9}, Llocal/mio/os4camerabridge/LegendM9Container;->item(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v8

    .line 627
    .local v8, "metaItem":Ljava/lang/String;
    const-string v9, "Item:length"

    invoke-static {v7, v9}, Llocal/mio/os4camerabridge/LegendM9Container;->positive(Ljava/lang/String;Ljava/lang/String;)I

    move-result v10

    .line 628
    .local v10, "rawDeclaredLength":I
    const-string v11, "Item:Offset"

    invoke-static {v7, v11}, Llocal/mio/os4camerabridge/LegendM9Container;->positive(Ljava/lang/String;Ljava/lang/String;)I

    move-result v12

    .line 629
    .local v12, "rawDeclaredOffset":I
    invoke-static {v8, v9}, Llocal/mio/os4camerabridge/LegendM9Container;->positive(Ljava/lang/String;Ljava/lang/String;)I

    move-result v9

    .line 630
    .local v9, "metaDeclaredLength":I
    invoke-static {v8, v11}, Llocal/mio/os4camerabridge/LegendM9Container;->positive(Ljava/lang/String;Ljava/lang/String;)I

    move-result v11

    .line 631
    .local v11, "metaDeclaredOffset":I
    if-ne v10, v1, :cond_4

    if-ne v9, v2, :cond_4

    add-int v13, v1, v2

    if-ne v12, v13, :cond_4

    if-ne v11, v2, :cond_4

    move v13, v5

    goto :goto_4

    :cond_4
    const/4 v13, 0x0

    :goto_4
    const-string v14, "M9 EOF ranges are inconsistent"

    invoke-static {v13, v14}, Llocal/mio/os4camerabridge/LegendM9Container;->require(ZLjava/lang/String;)V

    .line 636
    array-length v13, v0

    sub-int/2addr v13, v12

    .line 637
    .local v13, "rawStart":I
    array-length v14, v0

    sub-int/2addr v14, v11

    .line 638
    .local v14, "metaStart":I
    if-lez v13, :cond_5

    add-int v15, v13, v1

    if-ne v15, v14, :cond_5

    add-int v15, v14, v2

    array-length v4, v0

    if-ne v15, v4, :cond_5

    move v4, v5

    goto :goto_5

    :cond_5
    const/4 v4, 0x0

    :goto_5
    const-string v5, "M9 payloads are not contiguous at EOF"

    invoke-static {v4, v5}, Llocal/mio/os4camerabridge/LegendM9Container;->require(ZLjava/lang/String;)V

    .line 641
    return-void
.end method

.method private static withoutOwnedCameraXmpMeta(Ljava/lang/String;)Ljava/lang/String;
    .locals 10
    .param p0, "xml"    # Ljava/lang/String;

    .line 536
    nop

    :goto_0
    const-string v0, "MiCamera:XMPMeta="

    invoke-virtual {p0, v0}, Ljava/lang/String;->indexOf(Ljava/lang/String;)I

    move-result v0

    .line 537
    .local v0, "property":I
    if-gez v0, :cond_0

    .line 538
    return-object p0

    .line 540
    :cond_0
    const-string v1, "<rdf:Description"

    invoke-virtual {p0, v1, v0}, Ljava/lang/String;->lastIndexOf(Ljava/lang/String;I)I

    move-result v1

    .line 541
    .local v1, "start":I
    const/16 v2, 0x3e

    invoke-virtual {p0, v2, v0}, Ljava/lang/String;->indexOf(II)I

    move-result v2

    .line 542
    .local v2, "tagEnd":I
    const/4 v3, 0x1

    const/4 v4, 0x0

    if-ltz v1, :cond_1

    if-ltz v2, :cond_1

    if-gt v0, v2, :cond_1

    move v5, v3

    goto :goto_1

    :cond_1
    move v5, v4

    :goto_1
    const-string v6, "MiCamera:XMPMeta is not an rdf:Description attribute"

    invoke-static {v5, v6}, Llocal/mio/os4camerabridge/LegendM9Container;->require(ZLjava/lang/String;)V

    .line 544
    add-int/lit8 v5, v2, 0x1

    .line 545
    .local v5, "end":I
    invoke-virtual {p0, v1, v5}, Ljava/lang/String;->substring(II)Ljava/lang/String;

    move-result-object v6

    .line 546
    .local v6, "opening":Ljava/lang/String;
    invoke-static {v6}, Llocal/mio/os4camerabridge/LegendM9Container;->requireOwnedCameraDescription(Ljava/lang/String;)V

    .line 547
    invoke-virtual {v6}, Ljava/lang/String;->trim()Ljava/lang/String;

    move-result-object v7

    const-string v8, "/>"

    invoke-virtual {v7, v8}, Ljava/lang/String;->endsWith(Ljava/lang/String;)Z

    move-result v7

    if-nez v7, :cond_3

    .line 548
    const-string v7, "</rdf:Description>"

    invoke-virtual {p0, v7, v5}, Ljava/lang/String;->indexOf(Ljava/lang/String;I)I

    move-result v8

    .line 549
    .local v8, "closing":I
    if-ltz v8, :cond_2

    goto :goto_2

    :cond_2
    move v3, v4

    :goto_2
    const-string v9, "unterminated MiCamera:XMPMeta description"

    invoke-static {v3, v9}, Llocal/mio/os4camerabridge/LegendM9Container;->require(ZLjava/lang/String;)V

    .line 551
    invoke-virtual {p0, v5, v8}, Ljava/lang/String;->substring(II)Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/String;->trim()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/String;->isEmpty()Z

    move-result v3

    const-string v9, "MiCamera:XMPMeta description owns child metadata"

    invoke-static {v3, v9}, Llocal/mio/os4camerabridge/LegendM9Container;->require(ZLjava/lang/String;)V

    .line 553
    invoke-virtual {v7}, Ljava/lang/String;->length()I

    move-result v3

    add-int v5, v8, v3

    .line 555
    .end local v8    # "closing":I
    :cond_3
    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {p0, v4, v1}, Ljava/lang/String;->substring(II)Ljava/lang/String;

    move-result-object v4

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {p0, v5}, Ljava/lang/String;->substring(I)Ljava/lang/String;

    move-result-object v4

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p0

    .line 556
    .end local v0    # "property":I
    .end local v1    # "start":I
    .end local v2    # "tagEnd":I
    .end local v5    # "end":I
    .end local v6    # "opening":Ljava/lang/String;
    goto :goto_0
.end method

.method static wrap([B[B[FLjava/lang/String;Llocal/mio/os4camerabridge/LegendM9Container$Metadata;)[B
    .locals 8
    .param p0, "jpeg"    # [B
    .param p1, "raw10"    # [B
    .param p2, "lsc"    # [F
    .param p3, "jpegBasename"    # Ljava/lang/String;
    .param p4, "metadata"    # Llocal/mio/os4camerabridge/LegendM9Container$Metadata;

    .line 90
    invoke-static {p0}, Llocal/mio/os4camerabridge/LegendM9Container;->requireJpeg([B)V

    .line 91
    invoke-static {p0}, Llocal/mio/os4camerabridge/LegendM9Container;->jpegDimensions([B)[I

    move-result-object v0

    .line 92
    .local v0, "dimensions":[I
    const/4 v1, 0x0

    aget v2, v0, v1

    const/16 v3, 0xc00

    const/4 v4, 0x1

    const/16 v5, 0x1000

    if-ne v2, v5, :cond_0

    aget v2, v0, v4

    if-eq v2, v3, :cond_1

    :cond_0
    aget v2, v0, v1

    if-ne v2, v3, :cond_2

    aget v2, v0, v4

    if-ne v2, v5, :cond_2

    :cond_1
    move v2, v4

    goto :goto_0

    :cond_2
    move v2, v1

    :goto_0
    invoke-static {p0}, Llocal/mio/os4camerabridge/LegendaryWatermarkContainer;->primaryGeometryValid([B)Z

    move-result v2

    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    const-string v5, "M9 primary must retain a native full-size image ROI, got "

    invoke-virtual {v3, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    aget v5, v0, v1

    invoke-virtual {v3, v5}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v3

    const-string v5, "x"

    invoke-virtual {v3, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    aget v5, v0, v4

    invoke-virtual {v3, v5}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    invoke-static {v2, v3}, Llocal/mio/os4camerabridge/LegendM9Container;->require(ZLjava/lang/String;)V

    .line 96
    if-eqz p1, :cond_3

    array-length v2, p1

    const/high16 v3, 0xf00000

    if-ne v2, v3, :cond_3

    move v2, v4

    goto :goto_1

    :cond_3
    move v2, v1

    :goto_1
    const-string v3, "RAW10 length invalid"

    invoke-static {v2, v3}, Llocal/mio/os4camerabridge/LegendM9Container;->require(ZLjava/lang/String;)V

    .line 98
    if-eqz p2, :cond_4

    array-length v2, p2

    const/16 v3, 0x374

    if-ne v2, v3, :cond_4

    move v2, v4

    goto :goto_2

    :cond_4
    move v2, v1

    :goto_2
    const-string v3, "LSC must contain 884 floats"

    invoke-static {v2, v3}, Llocal/mio/os4camerabridge/LegendM9Container;->require(ZLjava/lang/String;)V

    .line 100
    invoke-static {p3}, Llocal/mio/os4camerabridge/LegendM9Container;->normalizeBasename(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v2

    .line 101
    .local v2, "basename":Ljava/lang/String;
    invoke-virtual {p4}, Llocal/mio/os4camerabridge/LegendM9Container$Metadata;->validate()V

    .line 103
    invoke-static {p0, v4}, Llocal/mio/os4camerabridge/LegendExifTagger;->tag([BI)[B

    move-result-object v3

    .line 104
    .local v3, "tagged":[B
    invoke-static {v3}, Llocal/mio/os4camerabridge/LegendExifTagger;->read([B)I

    move-result v5

    if-ne v5, v4, :cond_5

    move v1, v4

    :cond_5
    const-string v4, "legendmode EXIF readback failed"

    invoke-static {v1, v4}, Llocal/mio/os4camerabridge/LegendM9Container;->require(ZLjava/lang/String;)V

    .line 106
    iget v1, p4, Llocal/mio/os4camerabridge/LegendM9Container$Metadata;->blackLevel:I

    iget v4, p4, Llocal/mio/os4camerabridge/LegendM9Container$Metadata;->whiteLevel:I

    invoke-static {p1, v1, v4, v2}, Llocal/mio/os4camerabridge/LegendM9Container;->packRggbToCloudBggr([BIILjava/lang/String;)[B

    move-result-object v1

    .line 108
    .local v1, "packedRaw":[B
    invoke-static {v2, p4, p2}, Llocal/mio/os4camerabridge/LegendM9Container;->buildMessage(Ljava/lang/String;Llocal/mio/os4camerabridge/LegendM9Container$Metadata;[F)[B

    move-result-object v4

    .line 109
    .local v4, "message":[B
    iget v5, p4, Llocal/mio/os4camerabridge/LegendM9Container$Metadata;->orientation:I

    invoke-static {v3, v1, v4, v5}, Llocal/mio/os4camerabridge/LegendM9Container;->addM9Container([B[B[BI)[B

    move-result-object v5

    .line 111
    .local v5, "output":[B
    array-length v6, v1

    array-length v7, v4

    invoke-static {v5, v6, v7}, Llocal/mio/os4camerabridge/LegendM9Container;->verify([BII)V

    .line 112
    invoke-static {v5}, Llocal/mio/os4camerabridge/LegendaryContainerIntegrityBridge;->finish([B)[B
    move-result-object v5
    return-object v5
.end method

.method static wrapM3([B)[B
    .locals 9
    .param p0, "jpeg"    # [B

    .line 121
    invoke-static {p0}, Llocal/mio/os4camerabridge/LegendM9Container;->requireJpeg([B)V

    .line 122
    invoke-static {p0}, Llocal/mio/os4camerabridge/LegendM9Container;->jpegDimensions([B)[I

    move-result-object v0

    .line 123
    .local v0, "dimensions":[I
    const/4 v1, 0x2

    invoke-static {p0, v1}, Llocal/mio/os4camerabridge/LegendExifTagger;->tag([BI)[B

    move-result-object v2

    .line 124
    .local v2, "tagged":[B
    const/4 v3, 0x0

    aget v4, v0, v3

    const/4 v5, 0x1

    aget v6, v0, v5

    invoke-static {v2, v4, v6}, Llocal/mio/os4camerabridge/LegendM9Container;->addM3Container([BII)[B

    move-result-object v4

    .line 126
    .local v4, "output":[B
    invoke-static {v4}, Llocal/mio/os4camerabridge/LegendExifTagger;->read([B)I

    move-result v6

    if-ne v6, v1, :cond_0

    move v1, v5

    goto :goto_0

    :cond_0
    move v1, v3

    :goto_0
    const-string v6, "M3 EXIF marker missing"

    invoke-static {v1, v6}, Llocal/mio/os4camerabridge/LegendM9Container;->require(ZLjava/lang/String;)V

    .line 128
    invoke-static {v4}, Llocal/mio/os4camerabridge/LegendM9Container;->findXmp([B)Llocal/mio/os4camerabridge/LegendM9Container$Segment;

    move-result-object v1

    .line 129
    .local v1, "xmp":Llocal/mio/os4camerabridge/LegendM9Container$Segment;
    if-eqz v1, :cond_1

    move v6, v5

    goto :goto_1

    :cond_1
    move v6, v3

    :goto_1
    const-string v7, "M3 XMP missing"

    invoke-static {v6, v7}, Llocal/mio/os4camerabridge/LegendM9Container;->require(ZLjava/lang/String;)V

    .line 130
    invoke-static {v4, v1}, Llocal/mio/os4camerabridge/LegendM9Container;->xml([BLlocal/mio/os4camerabridge/LegendM9Container$Segment;)Ljava/lang/String;

    move-result-object v6

    .line 131
    .local v6, "text":Ljava/lang/String;
    const-string v7, "Item:name=\"Legend.MONOPAN\""

    invoke-static {v6, v7}, Llocal/mio/os4camerabridge/LegendM9Container;->count(Ljava/lang/String;Ljava/lang/String;)I

    move-result v7

    if-ne v7, v5, :cond_2

    move v7, v5

    goto :goto_2

    :cond_2
    move v7, v3

    :goto_2
    const-string v8, "M3 item set invalid"

    invoke-static {v7, v8}, Llocal/mio/os4camerabridge/LegendM9Container;->require(ZLjava/lang/String;)V

    .line 133
    const-string v7, "Item:UseMainImage=\"1\""

    invoke-static {v6, v7}, Llocal/mio/os4camerabridge/LegendM9Container;->count(Ljava/lang/String;Ljava/lang/String;)I

    move-result v7

    if-ne v7, v5, :cond_3

    move v3, v5

    :cond_3
    const-string v5, "M3 must consume the primary JPEG"

    invoke-static {v3, v5}, Llocal/mio/os4camerabridge/LegendM9Container;->require(ZLjava/lang/String;)V

    .line 135
    invoke-static {v4}, Llocal/mio/os4camerabridge/LegendaryContainerIntegrityBridge;->finish([B)[B
    move-result-object v4
    return-object v4
.end method

.method private static writeGroup([BIIIII)V
    .locals 3
    .param p0, "bytes"    # [B
    .param p1, "offset"    # I
    .param p2, "a"    # I
    .param p3, "b"    # I
    .param p4, "c"    # I
    .param p5, "d"    # I

    .line 248
    ushr-int/lit8 v0, p2, 0x2

    int-to-byte v0, v0

    aput-byte v0, p0, p1

    .line 249
    add-int/lit8 v0, p1, 0x1

    ushr-int/lit8 v1, p3, 0x2

    int-to-byte v1, v1

    aput-byte v1, p0, v0

    .line 250
    add-int/lit8 v0, p1, 0x2

    ushr-int/lit8 v1, p4, 0x2

    int-to-byte v1, v1

    aput-byte v1, p0, v0

    .line 251
    add-int/lit8 v0, p1, 0x3

    ushr-int/lit8 v1, p5, 0x2

    int-to-byte v1, v1

    aput-byte v1, p0, v0

    .line 252
    add-int/lit8 v0, p1, 0x4

    and-int/lit8 v1, p2, 0x3

    and-int/lit8 v2, p3, 0x3

    shl-int/lit8 v2, v2, 0x2

    or-int/2addr v1, v2

    and-int/lit8 v2, p4, 0x3

    shl-int/lit8 v2, v2, 0x4

    or-int/2addr v1, v2

    and-int/lit8 v2, p5, 0x3

    shl-int/lit8 v2, v2, 0x6

    or-int/2addr v1, v2

    int-to-byte v1, v1

    aput-byte v1, p0, v0

    .line 254
    return-void
.end method

.method private static writeVarint(Ljava/io/ByteArrayOutputStream;J)V
    .locals 4
    .param p0, "output"    # Ljava/io/ByteArrayOutputStream;
    .param p1, "value"    # J

    .line 368
    nop

    :goto_0
    const-wide/16 v0, -0x80

    and-long/2addr v0, p1

    const-wide/16 v2, 0x0

    cmp-long v0, v0, v2

    if-eqz v0, :cond_0

    .line 369
    long-to-int v0, p1

    and-int/lit8 v0, v0, 0x7f

    or-int/lit16 v0, v0, 0x80

    invoke-virtual {p0, v0}, Ljava/io/ByteArrayOutputStream;->write(I)V

    .line 370
    const/4 v0, 0x7

    ushr-long/2addr p1, v0

    goto :goto_0

    .line 372
    :cond_0
    long-to-int v0, p1

    invoke-virtual {p0, v0}, Ljava/io/ByteArrayOutputStream;->write(I)V

    .line 373
    return-void
.end method

.method private static xml([BLlocal/mio/os4camerabridge/LegendM9Container$Segment;)Ljava/lang/String;
    .locals 4
    .param p0, "jpeg"    # [B
    .param p1, "segment"    # Llocal/mio/os4camerabridge/LegendM9Container$Segment;

    .line 706
    new-instance v0, Ljava/lang/String;

    iget v1, p1, Llocal/mio/os4camerabridge/LegendM9Container$Segment;->bodyOffset:I

    sget-object v2, Llocal/mio/os4camerabridge/LegendM9Container;->XMP_HEADER:[B

    array-length v2, v2

    add-int/2addr v1, v2

    iget v2, p1, Llocal/mio/os4camerabridge/LegendM9Container$Segment;->bodyLength:I

    sget-object v3, Llocal/mio/os4camerabridge/LegendM9Container;->XMP_HEADER:[B

    array-length v3, v3

    sub-int/2addr v2, v3

    sget-object v3, Ljava/nio/charset/StandardCharsets;->UTF_8:Ljava/nio/charset/Charset;

    invoke-direct {v0, p0, v1, v2, v3}, Ljava/lang/String;-><init>([BIILjava/nio/charset/Charset;)V

    return-object v0
.end method

.method private static xmpApp1(Ljava/lang/String;)[B
    .locals 7
    .param p0, "xml"    # Ljava/lang/String;

    .line 644
    sget-object v0, Ljava/nio/charset/StandardCharsets;->UTF_8:Ljava/nio/charset/Charset;

    invoke-virtual {p0, v0}, Ljava/lang/String;->getBytes(Ljava/nio/charset/Charset;)[B

    move-result-object v0

    .line 645
    .local v0, "body":[B
    sget-object v1, Llocal/mio/os4camerabridge/LegendM9Container;->XMP_HEADER:[B

    array-length v1, v1

    array-length v2, v0

    add-int/2addr v1, v2

    .line 646
    .local v1, "contentLength":I
    add-int/lit8 v2, v1, 0x2

    .line 647
    .local v2, "segmentLength":I
    const v3, 0xffff

    const/4 v4, 0x0

    if-gt v2, v3, :cond_0

    const/4 v3, 0x1

    goto :goto_0

    :cond_0
    move v3, v4

    :goto_0
    const-string v5, "Legend XMP exceeds APP1 64 KiB"

    invoke-static {v3, v5}, Llocal/mio/os4camerabridge/LegendM9Container;->require(ZLjava/lang/String;)V

    .line 648
    new-instance v3, Ljava/io/ByteArrayOutputStream;

    add-int/lit8 v5, v1, 0x4

    invoke-direct {v3, v5}, Ljava/io/ByteArrayOutputStream;-><init>(I)V

    .line 650
    .local v3, "output":Ljava/io/ByteArrayOutputStream;
    const/16 v5, 0xff

    invoke-virtual {v3, v5}, Ljava/io/ByteArrayOutputStream;->write(I)V

    .line 651
    const/16 v6, 0xe1

    invoke-virtual {v3, v6}, Ljava/io/ByteArrayOutputStream;->write(I)V

    .line 652
    ushr-int/lit8 v6, v2, 0x8

    and-int/2addr v5, v6

    invoke-virtual {v3, v5}, Ljava/io/ByteArrayOutputStream;->write(I)V

    .line 653
    and-int/lit16 v5, v2, 0xff

    invoke-virtual {v3, v5}, Ljava/io/ByteArrayOutputStream;->write(I)V

    .line 654
    sget-object v5, Llocal/mio/os4camerabridge/LegendM9Container;->XMP_HEADER:[B

    sget-object v6, Llocal/mio/os4camerabridge/LegendM9Container;->XMP_HEADER:[B

    array-length v6, v6

    invoke-virtual {v3, v5, v4, v6}, Ljava/io/ByteArrayOutputStream;->write([BII)V

    .line 655
    array-length v5, v0

    invoke-virtual {v3, v0, v4, v5}, Ljava/io/ByteArrayOutputStream;->write([BII)V

    .line 656
    invoke-virtual {v3}, Ljava/io/ByteArrayOutputStream;->toByteArray()[B

    move-result-object v4

    return-object v4
.end method
