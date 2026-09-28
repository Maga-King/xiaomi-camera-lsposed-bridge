.class public final Llocal/mio/os4camerabridge/GenericVideoPolicy;
.super Ljava/lang/Object;
.source "GenericVideoPolicy.java"


# direct methods
.method private constructor <init>()V
    .locals 0

    .line 5
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method public static supportsProfile(IIIII)Z
    .locals 1

    .line 8
    const/16 v0, 0xa2

    if-ne p0, v0, :cond_0

    if-nez p1, :cond_0

    const/16 p0, 0x780

    if-ne p2, p0, :cond_0

    const/16 p0, 0x438

    if-ne p3, p0, :cond_0

    const/16 p0, 0x1e

    if-ne p4, p0, :cond_0

    const/4 p0, 0x1

    goto :goto_0

    :cond_0
    const/4 p0, 0x0

    :goto_0
    return p0
.end method

.method public static supportsSession(ZILjava/lang/String;III)Z
    .locals 0

    .line 13
    if-eqz p0, :cond_1

    const/16 p0, 0xa2

    if-ne p1, p0, :cond_1

    const-string p0, "0"

    invoke-virtual {p0, p2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result p0

    if-eqz p0, :cond_1

    if-eqz p3, :cond_0

    const p0, 0x8004

    if-eq p3, p0, :cond_0

    const p0, 0xf010

    if-ne p3, p0, :cond_1

    :cond_0
    const/4 p0, 0x3

    if-ne p4, p0, :cond_1

    const/16 p0, 0x1e

    if-ne p5, p0, :cond_1

    const/4 p0, 0x1

    goto :goto_0

    :cond_1
    const/4 p0, 0x0

    :goto_0
    return p0
.end method
