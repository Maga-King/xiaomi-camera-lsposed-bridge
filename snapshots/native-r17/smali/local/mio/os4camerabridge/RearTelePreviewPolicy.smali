.class public final Llocal/mio/os4camerabridge/RearTelePreviewPolicy;
.super Ljava/lang/Object;
.source "RearTelePreviewPolicy.java"


# direct methods
.method private constructor <init>()V
    .locals 0

    .line 5
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method public static eligible(IIZZZF)Z
    .locals 1

    .line 9
    const/16 v0, 0xa3

    if-ne p0, v0, :cond_0

    if-nez p1, :cond_0

    if-eqz p2, :cond_0

    if-nez p3, :cond_0

    if-eqz p4, :cond_0

    .line 10
    invoke-static {p5}, Ljava/lang/Float;->isFinite(F)Z

    move-result p0

    if-eqz p0, :cond_0

    const/high16 p0, 0x40400000    # 3.0f

    cmpl-float p0, p5, p0

    if-ltz p0, :cond_0

    const/high16 p0, 0x41a00000    # 20.0f

    cmpg-float p0, p5, p0

    if-gtz p0, :cond_0

    const/4 p0, 0x1

    goto :goto_0

    :cond_0
    const/4 p0, 0x0

    .line 9
    :goto_0
    return p0
.end method

.method public static mask([I)[I
    .locals 3

    .line 14
    const/4 v0, 0x0

    if-eqz p0, :cond_0

    array-length v1, p0

    const/4 v2, 0x1

    if-eq v1, v2, :cond_0

    return-object v0

    .line 15
    :cond_0
    const/4 v1, 0x0

    if-nez p0, :cond_1

    goto :goto_0

    :cond_1
    aget v1, p0, v1

    .line 16
    :goto_0
    if-gez v1, :cond_2

    return-object v0

    .line 17
    :cond_2
    or-int/lit8 p0, v1, 0x2

    filled-new-array {p0}, [I

    move-result-object p0

    return-object p0
.end method
