.class final Llocal/mio/os4camerabridge/SoftwareSkinSmoothing$State;
.super Ljava/lang/Object;
.source "SoftwareSkinSmoothing.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Llocal/mio/os4camerabridge/SoftwareSkinSmoothing;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x1a
    name = "State"
.end annotation


# static fields
.field static final CAPS:[I


# instance fields
.field final active:I

.field final draw:I

.field final enabled:[Z

.field final mask:[I

.field final program:I

.field final read:I

.field final sampler:I

.field final texture:I

.field final viewport:[I


# direct methods
.method static constructor <clinit>()V
    .locals 1

    .line 149
    const/4 v0, 0x6

    new-array v0, v0, [I

    fill-array-data v0, :array_0

    sput-object v0, Llocal/mio/os4camerabridge/SoftwareSkinSmoothing$State;->CAPS:[I

    return-void

    nop

    :array_0
    .array-data 4
        0xbe2
        0xb71
        0xc11
        0xb44
        0xb90
        0x8c89
    .end array-data
.end method

.method constructor <init>()V
    .locals 3

    .line 155
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 150
    const v0, 0x8ca6

    invoke-static {v0}, Llocal/mio/os4camerabridge/SoftwareSkinSmoothing;->-$$Nest$sminteger(I)I

    move-result v0

    iput v0, p0, Llocal/mio/os4camerabridge/SoftwareSkinSmoothing$State;->draw:I

    const v0, 0x8caa

    invoke-static {v0}, Llocal/mio/os4camerabridge/SoftwareSkinSmoothing;->-$$Nest$sminteger(I)I

    move-result v0

    iput v0, p0, Llocal/mio/os4camerabridge/SoftwareSkinSmoothing$State;->read:I

    .line 151
    const v0, 0x8b8d

    invoke-static {v0}, Llocal/mio/os4camerabridge/SoftwareSkinSmoothing;->-$$Nest$sminteger(I)I

    move-result v0

    iput v0, p0, Llocal/mio/os4camerabridge/SoftwareSkinSmoothing$State;->program:I

    .line 150
    nop

    .line 151
    const v0, 0x84e0

    invoke-static {v0}, Llocal/mio/os4camerabridge/SoftwareSkinSmoothing;->-$$Nest$sminteger(I)I

    move-result v0

    iput v0, p0, Llocal/mio/os4camerabridge/SoftwareSkinSmoothing$State;->active:I

    .line 153
    const/4 v0, 0x4

    new-array v1, v0, [I

    iput-object v1, p0, Llocal/mio/os4camerabridge/SoftwareSkinSmoothing$State;->viewport:[I

    new-array v0, v0, [I

    iput-object v0, p0, Llocal/mio/os4camerabridge/SoftwareSkinSmoothing$State;->mask:[I

    .line 154
    sget-object v0, Llocal/mio/os4camerabridge/SoftwareSkinSmoothing$State;->CAPS:[I

    array-length v0, v0

    new-array v0, v0, [Z

    iput-object v0, p0, Llocal/mio/os4camerabridge/SoftwareSkinSmoothing$State;->enabled:[Z

    .line 156
    iget-object v0, p0, Llocal/mio/os4camerabridge/SoftwareSkinSmoothing$State;->viewport:[I

    const/16 v1, 0xba2

    const/4 v2, 0x0

    invoke-static {v1, v0, v2}, Landroid/opengl/GLES30;->glGetIntegerv(I[II)V

    const/16 v0, 0xc23

    iget-object v1, p0, Llocal/mio/os4camerabridge/SoftwareSkinSmoothing$State;->mask:[I

    invoke-static {v0, v1, v2}, Landroid/opengl/GLES30;->glGetIntegerv(I[II)V

    .line 157
    nop

    :goto_0
    sget-object v0, Llocal/mio/os4camerabridge/SoftwareSkinSmoothing$State;->CAPS:[I

    array-length v0, v0

    if-ge v2, v0, :cond_0

    iget-object v0, p0, Llocal/mio/os4camerabridge/SoftwareSkinSmoothing$State;->enabled:[Z

    sget-object v1, Llocal/mio/os4camerabridge/SoftwareSkinSmoothing$State;->CAPS:[I

    aget v1, v1, v2

    invoke-static {v1}, Landroid/opengl/GLES30;->glIsEnabled(I)Z

    move-result v1

    aput-boolean v1, v0, v2

    add-int/lit8 v2, v2, 0x1

    goto :goto_0

    .line 158
    :cond_0
    const v0, 0x84c0

    invoke-static {v0}, Landroid/opengl/GLES30;->glActiveTexture(I)V

    const v0, 0x8069

    invoke-static {v0}, Llocal/mio/os4camerabridge/SoftwareSkinSmoothing;->-$$Nest$sminteger(I)I

    move-result v0

    iput v0, p0, Llocal/mio/os4camerabridge/SoftwareSkinSmoothing$State;->texture:I

    const v0, 0x8919

    invoke-static {v0}, Llocal/mio/os4camerabridge/SoftwareSkinSmoothing;->-$$Nest$sminteger(I)I

    move-result v0

    iput v0, p0, Llocal/mio/os4camerabridge/SoftwareSkinSmoothing$State;->sampler:I

    .line 159
    return-void
.end method


# virtual methods
.method restore()V
    .locals 8

    .line 161
    const/16 v0, 0xde1

    iget v1, p0, Llocal/mio/os4camerabridge/SoftwareSkinSmoothing$State;->texture:I

    invoke-static {v0, v1}, Landroid/opengl/GLES30;->glBindTexture(II)V

    iget v0, p0, Llocal/mio/os4camerabridge/SoftwareSkinSmoothing$State;->sampler:I

    const/4 v1, 0x0

    invoke-static {v1, v0}, Landroid/opengl/GLES30;->glBindSampler(II)V

    iget v0, p0, Llocal/mio/os4camerabridge/SoftwareSkinSmoothing$State;->active:I

    invoke-static {v0}, Landroid/opengl/GLES30;->glActiveTexture(I)V

    .line 162
    iget v0, p0, Llocal/mio/os4camerabridge/SoftwareSkinSmoothing$State;->program:I

    invoke-static {v0}, Landroid/opengl/GLES30;->glUseProgram(I)V

    const v0, 0x8ca9

    iget v2, p0, Llocal/mio/os4camerabridge/SoftwareSkinSmoothing$State;->draw:I

    invoke-static {v0, v2}, Landroid/opengl/GLES30;->glBindFramebuffer(II)V

    const v0, 0x8ca8

    iget v2, p0, Llocal/mio/os4camerabridge/SoftwareSkinSmoothing$State;->read:I

    invoke-static {v0, v2}, Landroid/opengl/GLES30;->glBindFramebuffer(II)V

    .line 163
    iget-object v0, p0, Llocal/mio/os4camerabridge/SoftwareSkinSmoothing$State;->viewport:[I

    aget v0, v0, v1

    iget-object v2, p0, Llocal/mio/os4camerabridge/SoftwareSkinSmoothing$State;->viewport:[I

    const/4 v3, 0x1

    aget v2, v2, v3

    iget-object v4, p0, Llocal/mio/os4camerabridge/SoftwareSkinSmoothing$State;->viewport:[I

    const/4 v5, 0x2

    aget v4, v4, v5

    iget-object v6, p0, Llocal/mio/os4camerabridge/SoftwareSkinSmoothing$State;->viewport:[I

    const/4 v7, 0x3

    aget v6, v6, v7

    invoke-static {v0, v2, v4, v6}, Landroid/opengl/GLES30;->glViewport(IIII)V

    .line 164
    iget-object v0, p0, Llocal/mio/os4camerabridge/SoftwareSkinSmoothing$State;->mask:[I

    aget v0, v0, v1

    if-eqz v0, :cond_0

    move v0, v3

    goto :goto_0

    :cond_0
    move v0, v1

    :goto_0
    iget-object v2, p0, Llocal/mio/os4camerabridge/SoftwareSkinSmoothing$State;->mask:[I

    aget v2, v2, v3

    if-eqz v2, :cond_1

    move v2, v3

    goto :goto_1

    :cond_1
    move v2, v1

    :goto_1
    iget-object v4, p0, Llocal/mio/os4camerabridge/SoftwareSkinSmoothing$State;->mask:[I

    aget v4, v4, v5

    if-eqz v4, :cond_2

    move v4, v3

    goto :goto_2

    :cond_2
    move v4, v1

    :goto_2
    iget-object v5, p0, Llocal/mio/os4camerabridge/SoftwareSkinSmoothing$State;->mask:[I

    aget v5, v5, v7

    if-eqz v5, :cond_3

    goto :goto_3

    :cond_3
    move v3, v1

    :goto_3
    invoke-static {v0, v2, v4, v3}, Landroid/opengl/GLES30;->glColorMask(ZZZZ)V

    .line 165
    nop

    :goto_4
    sget-object v0, Llocal/mio/os4camerabridge/SoftwareSkinSmoothing$State;->CAPS:[I

    array-length v0, v0

    if-ge v1, v0, :cond_5

    iget-object v0, p0, Llocal/mio/os4camerabridge/SoftwareSkinSmoothing$State;->enabled:[Z

    aget-boolean v0, v0, v1

    if-eqz v0, :cond_4

    sget-object v0, Llocal/mio/os4camerabridge/SoftwareSkinSmoothing$State;->CAPS:[I

    aget v0, v0, v1

    invoke-static {v0}, Landroid/opengl/GLES30;->glEnable(I)V

    goto :goto_5

    :cond_4
    sget-object v0, Llocal/mio/os4camerabridge/SoftwareSkinSmoothing$State;->CAPS:[I

    aget v0, v0, v1

    invoke-static {v0}, Landroid/opengl/GLES30;->glDisable(I)V

    :goto_5
    add-int/lit8 v1, v1, 0x1

    goto :goto_4

    .line 166
    :cond_5
    return-void
.end method
