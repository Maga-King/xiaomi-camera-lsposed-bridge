.class public final Llocal/mio/os4camerabridge/LegendaryWatermarkContainer;
.super Ljava/lang/Object;
.source "LegendaryWatermarkContainer.java"


# static fields
.field private static final CAMERA:Ljava/lang/String; = "http://ns.xiaomi.com/photos/1.0/camera/"

.field private static final XMP:[B


# direct methods
.method static constructor <clinit>()V
    .locals 2

    .line 18
    const-string v0, "http://ns.adobe.com/xap/1.0/\u0000"

    sget-object v1, Ljava/nio/charset/StandardCharsets;->UTF_8:Ljava/nio/charset/Charset;

    invoke-virtual {v0, v1}, Ljava/lang/String;->getBytes(Ljava/nio/charset/Charset;)[B

    move-result-object v0

    sput-object v0, Llocal/mio/os4camerabridge/LegendaryWatermarkContainer;->XMP:[B

    return-void
.end method

.method private constructor <init>()V
    .locals 0

    .line 19
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method private static fullSize(II)Z
    .locals 2

    .line 95
    const/16 v0, 0xc00

    const/16 v1, 0x1000

    if-ne p0, v1, :cond_0

    if-eq p1, v0, :cond_1

    :cond_0
    if-ne p0, v0, :cond_2

    if-ne p1, v1, :cond_2

    :cond_1
    const/4 p0, 0x1

    goto :goto_0

    :cond_2
    const/4 p0, 0x0

    :goto_0
    return p0
.end method

.method private static integer(Lorg/w3c/dom/Element;Ljava/lang/String;)I
    .locals 0

    .line 96
    invoke-interface {p0, p1}, Lorg/w3c/dom/Element;->getAttribute(Ljava/lang/String;)Ljava/lang/String;

    move-result-object p0

    invoke-static {p0}, Ljava/lang/Integer;->parseInt(Ljava/lang/String;)I

    move-result p0

    return p0
.end method

.method private static legacy([B)Ljava/lang/String;
    .locals 2
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/lang/Exception;
        }
    .end annotation

    .line 98
    invoke-static {p0}, Llocal/mio/os4camerabridge/LegendaryWatermarkContainer;->xmp([B)[B

    move-result-object p0

    .line 99
    const/4 v0, 0x0

    if-nez p0, :cond_0

    return-object v0

    .line 100
    :cond_0
    invoke-static {p0}, Llocal/mio/os4camerabridge/LegendaryWatermarkContainer;->parse([B)Lorg/w3c/dom/Document;

    move-result-object p0

    invoke-static {p0}, Llocal/mio/os4camerabridge/LegendaryWatermarkContainer;->owner(Lorg/w3c/dom/Document;)Lorg/w3c/dom/Element;

    move-result-object p0

    .line 101
    if-nez p0, :cond_1

    goto :goto_0

    :cond_1
    const-string v0, "http://ns.xiaomi.com/photos/1.0/camera/"

    const-string v1, "XMPMeta"

    invoke-interface {p0, v0, v1}, Lorg/w3c/dom/Element;->getAttributeNS(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    :goto_0
    return-object v0
.end method

.method private static owner(Lorg/w3c/dom/Document;)Lorg/w3c/dom/Element;
    .locals 5

    .line 104
    nop

    .line 105
    const-string v0, "*"

    invoke-interface {p0, v0}, Lorg/w3c/dom/Document;->getElementsByTagName(Ljava/lang/String;)Lorg/w3c/dom/NodeList;

    move-result-object p0

    .line 106
    const/4 v0, 0x0

    const/4 v1, 0x0

    :goto_0
    invoke-interface {p0}, Lorg/w3c/dom/NodeList;->getLength()I

    move-result v2

    if-ge v1, v2, :cond_2

    .line 107
    invoke-interface {p0, v1}, Lorg/w3c/dom/NodeList;->item(I)Lorg/w3c/dom/Node;

    move-result-object v2

    check-cast v2, Lorg/w3c/dom/Element;

    .line 108
    const-string v3, "http://ns.xiaomi.com/photos/1.0/camera/"

    const-string v4, "XMPMeta"

    invoke-interface {v2, v3, v4}, Lorg/w3c/dom/Element;->hasAttributeNS(Ljava/lang/String;Ljava/lang/String;)Z

    move-result v3

    if-nez v3, :cond_0

    goto :goto_1

    .line 109
    :cond_0
    if-nez v0, :cond_1

    .line 110
    move-object v0, v2

    .line 106
    :goto_1
    add-int/lit8 v1, v1, 0x1

    goto :goto_0

    .line 109
    :cond_1
    new-instance p0, Ljava/lang/IllegalArgumentException;

    const-string v0, "multiple legacy camera properties"

    invoke-direct {p0, v0}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw p0

    .line 112
    :cond_2
    return-object v0
.end method

.method private static parse([B)Lorg/w3c/dom/Document;
    .locals 2
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/lang/Exception;
        }
    .end annotation

    .line 144
    if-eqz p0, :cond_1

    .line 145
    new-instance v0, Ljava/lang/String;

    sget-object v1, Ljava/nio/charset/StandardCharsets;->UTF_8:Ljava/nio/charset/Charset;

    invoke-direct {v0, p0, v1}, Ljava/lang/String;-><init>([BLjava/nio/charset/Charset;)V

    .line 146
    const-string v1, "<!DOCTYPE"

    invoke-virtual {v0, v1}, Ljava/lang/String;->contains(Ljava/lang/CharSequence;)Z

    move-result v1

    if-nez v1, :cond_0

    const-string v1, "<!ENTITY"

    invoke-virtual {v0, v1}, Ljava/lang/String;->contains(Ljava/lang/CharSequence;)Z

    move-result v0

    if-nez v0, :cond_0

    .line 147
    invoke-static {}, Ljavax/xml/parsers/DocumentBuilderFactory;->newInstance()Ljavax/xml/parsers/DocumentBuilderFactory;

    move-result-object v0

    .line 148
    const/4 v1, 0x1

    invoke-virtual {v0, v1}, Ljavax/xml/parsers/DocumentBuilderFactory;->setNamespaceAware(Z)V

    const/4 v1, 0x0

    invoke-virtual {v0, v1}, Ljavax/xml/parsers/DocumentBuilderFactory;->setExpandEntityReferences(Z)V

    .line 149
    invoke-virtual {v0}, Ljavax/xml/parsers/DocumentBuilderFactory;->newDocumentBuilder()Ljavax/xml/parsers/DocumentBuilder;

    move-result-object v0

    new-instance v1, Ljava/io/ByteArrayInputStream;

    invoke-direct {v1, p0}, Ljava/io/ByteArrayInputStream;-><init>([B)V

    invoke-virtual {v0, v1}, Ljavax/xml/parsers/DocumentBuilder;->parse(Ljava/io/InputStream;)Lorg/w3c/dom/Document;

    move-result-object p0

    return-object p0

    .line 146
    :cond_0
    new-instance p0, Ljava/lang/IllegalArgumentException;

    const-string v0, "DTD forbidden"

    invoke-direct {p0, v0}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw p0

    .line 144
    :cond_1
    new-instance p0, Ljava/lang/IllegalArgumentException;

    const-string v0, "XMP absent"

    invoke-direct {p0, v0}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw p0
.end method

.method private static parseInner(Ljava/lang/String;)Lorg/w3c/dom/Document;
    .locals 2
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/lang/Exception;
        }
    .end annotation

    .line 140
    const-string v0, "^\\s*<\\?xml[^?]*\\?>"

    const-string v1, ""

    invoke-virtual {p0, v0, v1}, Ljava/lang/String;->replaceFirst(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object p0

    .line 141
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "<root>"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, p0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p0

    const-string v0, "</root>"

    invoke-virtual {p0, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p0

    invoke-virtual {p0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p0

    sget-object v0, Ljava/nio/charset/StandardCharsets;->UTF_8:Ljava/nio/charset/Charset;

    invoke-virtual {p0, v0}, Ljava/lang/String;->getBytes(Ljava/nio/charset/Charset;)[B

    move-result-object p0

    invoke-static {p0}, Llocal/mio/os4camerabridge/LegendaryWatermarkContainer;->parse([B)Lorg/w3c/dom/Document;

    move-result-object p0

    return-object p0
.end method

.method public static preserve([B[BI)[B
    .locals 19
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/lang/Exception;
        }
    .end annotation

    .line 42
    move-object/from16 v0, p0

    move/from16 v1, p2

    if-ltz v1, :cond_c

    move-object/from16 v2, p1

    array-length v3, v2

    if-gt v1, v3, :cond_c

    .line 43
    invoke-static {v0}, Llocal/mio/os4camerabridge/LegendaryWatermarkContainer;->legacy([B)Ljava/lang/String;

    move-result-object v3

    .line 44
    invoke-static {v2}, Llocal/mio/os4camerabridge/LegendaryContainerIntegrity;->repair([B)[B

    move-result-object v2

    .line 45
    invoke-static {v2}, Llocal/mio/os4camerabridge/LegendaryWatermarkContainer;->xmp([B)[B

    move-result-object v4

    invoke-static {v4}, Llocal/mio/os4camerabridge/LegendaryWatermarkContainer;->parse([B)Lorg/w3c/dom/Document;

    move-result-object v4

    .line 48
    const-string v5, "http://ns.xiaomi.com/photos/1.0/camera/xmend"

    array-length v6, v0

    invoke-static {v4, v5, v6, v1}, Llocal/mio/os4camerabridge/LegendaryWatermarkContainer;->shiftProperty(Lorg/w3c/dom/Document;Ljava/lang/String;II)V

    .line 49
    const-string v5, "http://ns.xiaomi.com/photos/1.0/camera/reedit"

    array-length v6, v0

    invoke-static {v4, v5, v6, v1}, Llocal/mio/os4camerabridge/LegendaryWatermarkContainer;->shiftProperty(Lorg/w3c/dom/Document;Ljava/lang/String;II)V

    .line 50
    invoke-static {v4}, Llocal/mio/os4camerabridge/LegendaryWatermarkContainer;->owner(Lorg/w3c/dom/Document;)Lorg/w3c/dom/Element;

    move-result-object v5

    .line 51
    if-eqz v5, :cond_b

    .line 52
    const-string v6, "http://ns.xiaomi.com/photos/1.0/camera/"

    if-nez v3, :cond_0

    .line 54
    const-string v0, "XMPMeta"

    invoke-interface {v5, v6, v0}, Lorg/w3c/dom/Element;->removeAttributeNS(Ljava/lang/String;Ljava/lang/String;)V

    goto/16 :goto_4

    .line 56
    :cond_0
    invoke-static {v3}, Llocal/mio/os4camerabridge/LegendaryWatermarkContainer;->parseInner(Ljava/lang/String;)Lorg/w3c/dom/Document;

    move-result-object v7

    .line 57
    invoke-interface {v7}, Lorg/w3c/dom/Document;->getDocumentElement()Lorg/w3c/dom/Element;

    move-result-object v7

    invoke-interface {v7}, Lorg/w3c/dom/Element;->getChildNodes()Lorg/w3c/dom/NodeList;

    move-result-object v7

    .line 58
    nop

    .line 59
    const/4 v9, 0x0

    const/4 v10, 0x0

    :goto_0
    invoke-interface {v7}, Lorg/w3c/dom/NodeList;->getLength()I

    move-result v11

    if-ge v9, v11, :cond_7

    invoke-interface {v7, v9}, Lorg/w3c/dom/NodeList;->item(I)Lorg/w3c/dom/Node;

    move-result-object v11

    instance-of v11, v11, Lorg/w3c/dom/Element;

    if-eqz v11, :cond_5

    .line 60
    invoke-interface {v7, v9}, Lorg/w3c/dom/NodeList;->item(I)Lorg/w3c/dom/Node;

    move-result-object v11

    check-cast v11, Lorg/w3c/dom/Element;

    .line 61
    const-string v12, "length"

    invoke-interface {v11, v12}, Lorg/w3c/dom/Element;->hasAttribute(Ljava/lang/String;)Z

    move-result v13

    if-eqz v13, :cond_4

    const-string v13, "offset"

    invoke-interface {v11, v13}, Lorg/w3c/dom/Element;->hasAttribute(Ljava/lang/String;)Z

    move-result v14

    if-nez v14, :cond_1

    move/from16 v16, v9

    goto :goto_2

    .line 62
    :cond_1
    invoke-interface {v11, v12}, Lorg/w3c/dom/Element;->getAttribute(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v12

    invoke-static {v12}, Ljava/lang/Long;->parseLong(Ljava/lang/String;)J

    move-result-wide v14

    .line 63
    invoke-interface {v11, v13}, Lorg/w3c/dom/Element;->getAttribute(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v12

    move/from16 v16, v9

    invoke-static {v12}, Ljava/lang/Long;->parseLong(Ljava/lang/String;)J

    move-result-wide v8

    .line 64
    const-wide/16 v17, 0x0

    cmp-long v12, v14, v17

    if-ltz v12, :cond_3

    cmp-long v17, v8, v17

    if-ltz v17, :cond_3

    cmp-long v14, v14, v8

    if-gtz v14, :cond_3

    array-length v14, v0

    int-to-long v14, v14

    cmp-long v14, v8, v14

    if-gtz v14, :cond_3

    .line 66
    if-lez v12, :cond_6

    .line 68
    int-to-long v14, v1

    invoke-static {v8, v9, v14, v15}, Ljava/lang/Math;->addExact(JJ)J

    move-result-wide v8

    invoke-static {v8, v9}, Ljava/lang/Long;->toString(J)Ljava/lang/String;

    move-result-object v8

    invoke-interface {v11, v13, v8}, Lorg/w3c/dom/Element;->setAttribute(Ljava/lang/String;Ljava/lang/String;)V

    .line 69
    if-eqz v1, :cond_2

    const/4 v8, 0x1

    goto :goto_1

    :cond_2
    const/4 v8, 0x0

    :goto_1
    or-int/2addr v10, v8

    goto :goto_2

    .line 65
    :cond_3
    new-instance v0, Ljava/lang/IllegalArgumentException;

    invoke-interface {v11}, Lorg/w3c/dom/Element;->getTagName()Ljava/lang/String;

    move-result-object v1

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "native watermark attachment bounds: "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-direct {v0, v1}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw v0

    .line 61
    :cond_4
    move/from16 v16, v9

    goto :goto_2

    .line 59
    :cond_5
    move/from16 v16, v9

    :cond_6
    :goto_2
    add-int/lit8 v9, v16, 0x1

    goto/16 :goto_0

    .line 72
    :cond_7
    if-eqz v10, :cond_a

    .line 73
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    .line 74
    const/4 v8, 0x0

    :goto_3
    invoke-interface {v7}, Lorg/w3c/dom/NodeList;->getLength()I

    move-result v1

    if-ge v8, v1, :cond_9

    invoke-interface {v7, v8}, Lorg/w3c/dom/NodeList;->item(I)Lorg/w3c/dom/Node;

    move-result-object v1

    instance-of v1, v1, Lorg/w3c/dom/Element;

    if-eqz v1, :cond_8

    .line 75
    new-instance v1, Ljava/lang/String;

    invoke-interface {v7, v8}, Lorg/w3c/dom/NodeList;->item(I)Lorg/w3c/dom/Node;

    move-result-object v3

    invoke-static {v3}, Llocal/mio/os4camerabridge/LegendaryWatermarkContainer;->serialize(Lorg/w3c/dom/Node;)[B

    move-result-object v3

    sget-object v9, Ljava/nio/charset/StandardCharsets;->UTF_8:Ljava/nio/charset/Charset;

    invoke-direct {v1, v3, v9}, Ljava/lang/String;-><init>([BLjava/nio/charset/Charset;)V

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 74
    :cond_8
    add-int/lit8 v8, v8, 0x1

    goto :goto_3

    .line 76
    :cond_9
    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    .line 78
    :cond_a
    const-string v0, "MiCamera:XMPMeta"

    invoke-interface {v5, v6, v0, v3}, Lorg/w3c/dom/Element;->setAttributeNS(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V

    .line 80
    :goto_4
    invoke-static {v4}, Llocal/mio/os4camerabridge/LegendaryWatermarkContainer;->serialize(Lorg/w3c/dom/Node;)[B

    move-result-object v0

    invoke-static {v2, v0}, Llocal/mio/os4camerabridge/LegendaryContainerIntegrity;->replaceXmp([B[B)[B

    move-result-object v0

    return-object v0

    .line 51
    :cond_b
    new-instance v0, Ljava/lang/IllegalArgumentException;

    const-string v1, "legacy placeholder absent"

    invoke-direct {v0, v1}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw v0

    .line 42
    :cond_c
    new-instance v0, Ljava/lang/IllegalArgumentException;

    const-string v1, "added tail"

    invoke-direct {v0, v1}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw v0
.end method

.method public static primaryGeometryValid([B)Z
    .locals 10

    .line 23
    const/4 v0, 0x0

    :try_start_0
    invoke-static {p0}, Llocal/mio/os4camerabridge/JpegWatermarkMetadataPolicy;->dimensions([B)[I

    move-result-object v1

    .line 24
    if-nez v1, :cond_0

    return v0

    .line 25
    :cond_0
    aget v2, v1, v0

    const/4 v3, 0x1

    aget v4, v1, v3

    invoke-static {v2, v4}, Llocal/mio/os4camerabridge/LegendaryWatermarkContainer;->fullSize(II)Z

    move-result v2

    if-eqz v2, :cond_1

    return v3

    .line 26
    :cond_1
    aget v2, v1, v0

    const/16 v4, 0x2000

    if-gt v2, v4, :cond_7

    aget v2, v1, v3

    if-le v2, v4, :cond_2

    goto :goto_0

    .line 27
    :cond_2
    invoke-static {p0}, Llocal/mio/os4camerabridge/LegendaryWatermarkContainer;->legacy([B)Ljava/lang/String;

    move-result-object p0

    .line 28
    if-nez p0, :cond_3

    return v0

    .line 29
    :cond_3
    invoke-static {p0}, Llocal/mio/os4camerabridge/LegendaryWatermarkContainer;->parseInner(Ljava/lang/String;)Lorg/w3c/dom/Document;

    move-result-object p0

    .line 30
    const-string v2, "madrid_image"

    invoke-interface {p0, v2}, Lorg/w3c/dom/Document;->getElementsByTagName(Ljava/lang/String;)Lorg/w3c/dom/NodeList;

    move-result-object p0

    .line 31
    invoke-interface {p0}, Lorg/w3c/dom/NodeList;->getLength()I

    move-result v2

    if-eq v2, v3, :cond_4

    return v0

    .line 32
    :cond_4
    invoke-interface {p0, v0}, Lorg/w3c/dom/NodeList;->item(I)Lorg/w3c/dom/Node;

    move-result-object p0

    check-cast p0, Lorg/w3c/dom/Element;

    .line 33
    const-string v2, "type"

    invoke-static {p0, v2}, Llocal/mio/os4camerabridge/LegendaryWatermarkContainer;->integer(Lorg/w3c/dom/Element;Ljava/lang/String;)I

    move-result v2

    const-string v4, "width"

    invoke-static {p0, v4}, Llocal/mio/os4camerabridge/LegendaryWatermarkContainer;->integer(Lorg/w3c/dom/Element;Ljava/lang/String;)I

    move-result v4

    const-string v5, "height"

    invoke-static {p0, v5}, Llocal/mio/os4camerabridge/LegendaryWatermarkContainer;->integer(Lorg/w3c/dom/Element;Ljava/lang/String;)I

    move-result v5

    .line 34
    const-string v6, "paddingx"

    invoke-static {p0, v6}, Llocal/mio/os4camerabridge/LegendaryWatermarkContainer;->integer(Lorg/w3c/dom/Element;Ljava/lang/String;)I

    move-result v6

    const-string v7, "paddingy"

    invoke-static {p0, v7}, Llocal/mio/os4camerabridge/LegendaryWatermarkContainer;->integer(Lorg/w3c/dom/Element;Ljava/lang/String;)I

    move-result p0

    .line 36
    const/16 v7, 0x2bc

    if-eq v2, v7, :cond_5

    const/16 v7, 0x2bd

    if-ne v2, v7, :cond_6

    :cond_5
    invoke-static {v4, v5}, Llocal/mio/os4camerabridge/LegendaryWatermarkContainer;->fullSize(II)Z

    move-result v2

    if-eqz v2, :cond_6

    if-ltz v6, :cond_6

    if-ltz p0, :cond_6

    int-to-long v6, v6

    int-to-long v8, v4

    add-long/2addr v6, v8

    aget v2, v1, v0

    int-to-long v8, v2

    cmp-long v2, v6, v8

    if-gtz v2, :cond_6

    int-to-long v6, p0

    int-to-long v4, v5

    add-long/2addr v6, v4

    aget p0, v1, v3
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    int-to-long v1, p0

    cmp-long p0, v6, v1

    if-gtz p0, :cond_6

    move v0, v3

    :cond_6
    return v0

    .line 26
    :cond_7
    :goto_0
    return v0

    .line 38
    :catch_0
    move-exception p0

    return v0
.end method

.method private static serialize(Lorg/w3c/dom/Node;)[B
    .locals 3
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/lang/Exception;
        }
    .end annotation

    .line 152
    invoke-static {}, Ljavax/xml/transform/TransformerFactory;->newInstance()Ljavax/xml/transform/TransformerFactory;

    move-result-object v0

    invoke-virtual {v0}, Ljavax/xml/transform/TransformerFactory;->newTransformer()Ljavax/xml/transform/Transformer;

    move-result-object v0

    .line 153
    const-string v1, "omit-xml-declaration"

    const-string v2, "yes"

    invoke-virtual {v0, v1, v2}, Ljavax/xml/transform/Transformer;->setOutputProperty(Ljava/lang/String;Ljava/lang/String;)V

    .line 154
    const-string v1, "encoding"

    const-string v2, "UTF-8"

    invoke-virtual {v0, v1, v2}, Ljavax/xml/transform/Transformer;->setOutputProperty(Ljava/lang/String;Ljava/lang/String;)V

    .line 155
    new-instance v1, Ljava/io/ByteArrayOutputStream;

    invoke-direct {v1}, Ljava/io/ByteArrayOutputStream;-><init>()V

    .line 156
    new-instance v2, Ljavax/xml/transform/dom/DOMSource;

    invoke-direct {v2, p0}, Ljavax/xml/transform/dom/DOMSource;-><init>(Lorg/w3c/dom/Node;)V

    new-instance p0, Ljavax/xml/transform/stream/StreamResult;

    invoke-direct {p0, v1}, Ljavax/xml/transform/stream/StreamResult;-><init>(Ljava/io/OutputStream;)V

    invoke-virtual {v0, v2, p0}, Ljavax/xml/transform/Transformer;->transform(Ljavax/xml/transform/Source;Ljavax/xml/transform/Result;)V

    invoke-virtual {v1}, Ljava/io/ByteArrayOutputStream;->toByteArray()[B

    move-result-object p0

    return-object p0
.end method

.method private static shiftProperty(Lorg/w3c/dom/Document;Ljava/lang/String;II)V
    .locals 7

    .line 84
    const-string v0, "*"

    invoke-interface {p0, v0}, Lorg/w3c/dom/Document;->getElementsByTagName(Ljava/lang/String;)Lorg/w3c/dom/NodeList;

    move-result-object p0

    .line 85
    const/4 v0, 0x0

    :goto_0
    invoke-interface {p0}, Lorg/w3c/dom/NodeList;->getLength()I

    move-result v1

    if-ge v0, v1, :cond_2

    .line 86
    invoke-interface {p0, v0}, Lorg/w3c/dom/NodeList;->item(I)Lorg/w3c/dom/Node;

    move-result-object v1

    check-cast v1, Lorg/w3c/dom/Element;

    .line 87
    const-string v2, "offset"

    invoke-interface {v1, p1, v2}, Lorg/w3c/dom/Element;->hasAttributeNS(Ljava/lang/String;Ljava/lang/String;)Z

    move-result v3

    if-nez v3, :cond_0

    goto :goto_1

    .line 88
    :cond_0
    invoke-interface {v1, p1, v2}, Lorg/w3c/dom/Element;->getAttributeNS(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v3

    invoke-static {v3}, Ljava/lang/Long;->parseLong(Ljava/lang/String;)J

    move-result-wide v3

    .line 89
    const-wide/16 v5, 0x0

    cmp-long v5, v3, v5

    if-lez v5, :cond_1

    int-to-long v5, p2

    cmp-long v5, v3, v5

    if-gtz v5, :cond_1

    .line 90
    invoke-interface {v1, p1, v2}, Lorg/w3c/dom/Element;->getAttributeNodeNS(Ljava/lang/String;Ljava/lang/String;)Lorg/w3c/dom/Attr;

    move-result-object v1

    .line 91
    int-to-long v5, p3

    invoke-static {v3, v4, v5, v6}, Ljava/lang/Math;->addExact(JJ)J

    move-result-wide v2

    invoke-static {v2, v3}, Ljava/lang/Long;->toString(J)Ljava/lang/String;

    move-result-object v2

    invoke-interface {v1, v2}, Lorg/w3c/dom/Attr;->setValue(Ljava/lang/String;)V

    .line 85
    :goto_1
    add-int/lit8 v0, v0, 0x1

    goto :goto_0

    .line 89
    :cond_1
    new-instance p0, Ljava/lang/IllegalArgumentException;

    const-string p1, "native EOF property bounds"

    invoke-direct {p0, p1}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw p0

    .line 93
    :cond_2
    return-void
.end method

.method private static xmp([B)[B
    .locals 10

    .line 115
    if-eqz p0, :cond_b

    array-length v0, p0

    const/4 v1, 0x4

    if-lt v0, v1, :cond_b

    const/4 v0, 0x0

    aget-byte v1, p0, v0

    const/16 v2, 0xff

    and-int/2addr v1, v2

    if-ne v1, v2, :cond_b

    const/4 v1, 0x1

    aget-byte v3, p0, v1

    and-int/2addr v3, v2

    const/16 v4, 0xd8

    if-ne v3, v4, :cond_b

    .line 117
    nop

    .line 118
    const/4 v3, 0x2

    const/4 v4, 0x0

    move v5, v3

    :goto_0
    array-length v6, p0

    if-ge v5, v6, :cond_a

    .line 119
    add-int/lit8 v6, v5, 0x1

    aget-byte v5, p0, v5

    and-int/2addr v5, v2

    if-ne v5, v2, :cond_9

    .line 120
    :goto_1
    array-length v5, p0

    if-ge v6, v5, :cond_0

    aget-byte v5, p0, v6

    and-int/2addr v5, v2

    if-ne v5, v2, :cond_0

    add-int/lit8 v6, v6, 0x1

    goto :goto_1

    .line 121
    :cond_0
    array-length v5, p0

    if-ge v6, v5, :cond_8

    .line 122
    add-int/lit8 v5, v6, 0x1

    aget-byte v6, p0, v6

    and-int/2addr v6, v2

    .line 123
    const/16 v7, 0xda

    if-eq v6, v7, :cond_a

    const/16 v7, 0xd9

    if-ne v6, v7, :cond_1

    goto/16 :goto_5

    .line 124
    :cond_1
    array-length v7, p0

    sub-int/2addr v7, v3

    if-gt v5, v7, :cond_7

    .line 125
    aget-byte v7, p0, v5

    and-int/2addr v7, v2

    shl-int/lit8 v7, v7, 0x8

    add-int/lit8 v8, v5, 0x1

    aget-byte v8, p0, v8

    and-int/2addr v8, v2

    or-int/2addr v7, v8

    .line 126
    if-lt v7, v3, :cond_6

    array-length v8, p0

    sub-int/2addr v8, v7

    if-gt v5, v8, :cond_6

    .line 127
    const/16 v8, 0xe1

    if-ne v6, v8, :cond_5

    sget-object v6, Llocal/mio/os4camerabridge/LegendaryWatermarkContainer;->XMP:[B

    array-length v6, v6

    add-int/2addr v6, v3

    if-lt v7, v6, :cond_5

    .line 128
    nop

    .line 129
    move v6, v0

    :goto_2
    sget-object v8, Llocal/mio/os4camerabridge/LegendaryWatermarkContainer;->XMP:[B

    array-length v8, v8

    if-ge v6, v8, :cond_3

    add-int/lit8 v8, v5, 0x2

    add-int/2addr v8, v6

    aget-byte v8, p0, v8

    sget-object v9, Llocal/mio/os4camerabridge/LegendaryWatermarkContainer;->XMP:[B

    aget-byte v9, v9, v6

    if-eq v8, v9, :cond_2

    move v6, v0

    goto :goto_3

    :cond_2
    add-int/lit8 v6, v6, 0x1

    goto :goto_2

    :cond_3
    move v6, v1

    .line 130
    :goto_3
    if-eqz v6, :cond_5

    .line 131
    if-nez v4, :cond_4

    .line 132
    add-int/lit8 v4, v5, 0x2

    sget-object v6, Llocal/mio/os4camerabridge/LegendaryWatermarkContainer;->XMP:[B

    array-length v6, v6

    add-int/2addr v4, v6

    add-int v6, v5, v7

    invoke-static {p0, v4, v6}, Ljava/util/Arrays;->copyOfRange([BII)[B

    move-result-object v4

    goto :goto_4

    .line 131
    :cond_4
    new-instance p0, Ljava/lang/IllegalArgumentException;

    const-string v0, "multiple standard XMP packets"

    invoke-direct {p0, v0}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw p0

    .line 135
    :cond_5
    :goto_4
    add-int/2addr v5, v7

    .line 136
    goto :goto_0

    .line 126
    :cond_6
    new-instance p0, Ljava/lang/IllegalArgumentException;

    const-string v0, "JPEG segment bounds"

    invoke-direct {p0, v0}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw p0

    .line 124
    :cond_7
    new-instance p0, Ljava/lang/IllegalArgumentException;

    const-string v0, "JPEG length"

    invoke-direct {p0, v0}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw p0

    .line 121
    :cond_8
    new-instance p0, Ljava/lang/IllegalArgumentException;

    const-string v0, "JPEG marker"

    invoke-direct {p0, v0}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw p0

    .line 119
    :cond_9
    new-instance p0, Ljava/lang/IllegalArgumentException;

    const-string v0, "JPEG header boundary"

    invoke-direct {p0, v0}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw p0

    .line 137
    :cond_a
    :goto_5
    return-object v4

    .line 116
    :cond_b
    new-instance p0, Ljava/lang/IllegalArgumentException;

    const-string v0, "JPEG absent"

    invoke-direct {p0, v0}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw p0
.end method
