.class public final Llocal/mio/os4camerabridge/SoftwareSkinSmoothing;
.super Ljava/lang/Object;
.source "SoftwareSkinSmoothing.java"


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Llocal/mio/os4camerabridge/SoftwareSkinSmoothing$State;
    }
.end annotation


# static fields
.field private static final FRAGMENT:Ljava/lang/String; = "#version 300 es\nprecision highp float;\nuniform sampler2D image; uniform vec2 stepSize; uniform float amount; in vec2 uv; out vec4 result;void main(){vec4 src=texture(image,uv);vec3 sum=vec3(0.0);float total=0.0;for(int y=-2;y<=2;y++){for(int x=-2;x<=2;x++){vec2 d=vec2(float(x),float(y));vec3 n=texture(image,uv+d*stepSize).rgb;vec3 diff=n-src.rgb;float w=exp(-dot(d,d)*0.24-dot(diff,diff)*55.0);sum+=n*w;total+=w;}}float l=dot(src.rgb,vec3(0.299,0.587,0.114));float cb=0.5+(src.b-l)*0.564;float cr=0.5+(src.r-l)*0.713;float skin=smoothstep(0.49,0.55,cr)*(1.0-smoothstep(0.66,0.73,cr))*smoothstep(0.22,0.29,cb)*(1.0-smoothstep(0.53,0.59,cb))*smoothstep(0.06,0.18,l)*(1.0-smoothstep(0.91,0.99,l));result=vec4(mix(src.rgb,sum/max(total,0.001),amount*skin*0.85),src.a);}"

.field private static final VERTEX:Ljava/lang/String; = "#version 300 es\nout vec2 uv; void main(){vec2 p=vec2((gl_VertexID<<1)&2,gl_VertexID&2);uv=p;gl_Position=vec4(p*2.0-1.0,0.0,1.0);}"


# instance fields
.field private context:Landroid/opengl/EGLContext;

.field private program:I


# direct methods
.method static bridge synthetic -$$Nest$sminteger(I)I
    .locals 0

    invoke-static {p0}, Llocal/mio/os4camerabridge/SoftwareSkinSmoothing;->integer(I)I

    move-result p0

    return p0
.end method

.method public constructor <init>()V
    .locals 0

    .line 10
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method public static apply(Landroid/graphics/Bitmap;F)Z
    .locals 34

    .line 61
    move-object/from16 v0, p0

    const/4 v1, 0x0

    if-eqz v0, :cond_1e

    invoke-virtual {v0}, Landroid/graphics/Bitmap;->isRecycled()Z

    move-result v2

    if-nez v2, :cond_1e

    invoke-virtual {v0}, Landroid/graphics/Bitmap;->isMutable()Z

    move-result v2

    if-eqz v2, :cond_1e

    const/4 v2, 0x0

    cmpg-float v2, p1, v2

    if-gtz v2, :cond_0

    goto/16 :goto_a

    .line 62
    :cond_0
    invoke-virtual {v0}, Landroid/graphics/Bitmap;->getWidth()I

    move-result v2

    int-to-long v2, v2

    invoke-virtual {v0}, Landroid/graphics/Bitmap;->getHeight()I

    move-result v4

    int-to-long v4, v4

    mul-long/2addr v2, v4

    const-wide/32 v4, 0xd59f80

    cmp-long v2, v2, v4

    if-lez v2, :cond_1

    return v1

    .line 63
    :cond_1
    invoke-static {}, Landroid/opengl/EGL14;->eglGetCurrentDisplay()Landroid/opengl/EGLDisplay;

    move-result-object v2

    .line 64
    invoke-static {}, Landroid/opengl/EGL14;->eglGetCurrentContext()Landroid/opengl/EGLContext;

    move-result-object v3

    .line 65
    const/16 v4, 0x3059

    invoke-static {v4}, Landroid/opengl/EGL14;->eglGetCurrentSurface(I)Landroid/opengl/EGLSurface;

    move-result-object v4

    .line 66
    const/16 v5, 0x305a

    invoke-static {v5}, Landroid/opengl/EGL14;->eglGetCurrentSurface(I)Landroid/opengl/EGLSurface;

    move-result-object v5

    .line 67
    invoke-static {v1}, Landroid/opengl/EGL14;->eglGetDisplay(I)Landroid/opengl/EGLDisplay;

    move-result-object v6

    .line 68
    sget-object v14, Landroid/opengl/EGL14;->EGL_NO_CONTEXT:Landroid/opengl/EGLContext;

    .line 69
    sget-object v15, Landroid/opengl/EGL14;->EGL_NO_SURFACE:Landroid/opengl/EGLSurface;

    .line 70
    nop

    .line 71
    const/4 v7, 0x2

    new-array v8, v7, [I

    .line 72
    const/4 v9, 0x1

    new-array v10, v9, [I

    .line 73
    new-instance v16, Llocal/mio/os4camerabridge/SoftwareSkinSmoothing;

    invoke-direct/range {v16 .. v16}, Llocal/mio/os4camerabridge/SoftwareSkinSmoothing;-><init>()V

    .line 75
    :try_start_0
    new-array v11, v7, [I

    new-array v12, v7, [I

    invoke-static {v6, v11, v1, v12, v1}, Landroid/opengl/EGL14;->eglInitialize(Landroid/opengl/EGLDisplay;[II[II)Z

    move-result v22
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_6

    .line 76
    if-eqz v22, :cond_18

    .line 77
    :try_start_1
    new-array v11, v9, [Landroid/opengl/EGLConfig;

    .line 78
    new-array v12, v9, [I

    .line 79
    const/16 v13, 0xd

    new-array v13, v13, [I

    fill-array-data v13, :array_0
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_4

    .line 81
    move/from16 v17, v9

    move-object v9, v11

    const/4 v11, 0x1

    move/from16 v18, v7

    move-object v7, v13

    const/4 v13, 0x0

    move-object/from16 v19, v8

    const/4 v8, 0x0

    move-object/from16 v20, v10

    const/4 v10, 0x0

    move-object/from16 v23, v19

    move-object/from16 v24, v20

    :try_start_2
    invoke-static/range {v6 .. v13}, Landroid/opengl/EGL14;->eglChooseConfig(Landroid/opengl/EGLDisplay;[II[Landroid/opengl/EGLConfig;II[II)Z

    move-result v7

    if-eqz v7, :cond_17

    aget v7, v12, v1

    if-eqz v7, :cond_17

    .line 83
    aget-object v7, v9, v1

    sget-object v8, Landroid/opengl/EGL14;->EGL_NO_CONTEXT:Landroid/opengl/EGLContext;

    const/16 v10, 0x3038

    const/16 v11, 0x3098

    const/4 v12, 0x3

    filled-new-array {v11, v12, v10}, [I

    move-result-object v11

    invoke-static {v6, v7, v8, v11, v1}, Landroid/opengl/EGL14;->eglCreateContext(Landroid/opengl/EGLDisplay;Landroid/opengl/EGLConfig;Landroid/opengl/EGLContext;[II)Landroid/opengl/EGLContext;

    move-result-object v14

    .line 85
    aget-object v7, v9, v1

    const/16 v8, 0x3057

    const/16 v9, 0x3056

    const/4 v11, 0x1

    filled-new-array {v8, v11, v9, v11, v10}, [I

    move-result-object v8

    invoke-static {v6, v7, v8, v1}, Landroid/opengl/EGL14;->eglCreatePbufferSurface(Landroid/opengl/EGLDisplay;Landroid/opengl/EGLConfig;[II)Landroid/opengl/EGLSurface;

    move-result-object v15

    .line 87
    invoke-static {v6, v15, v15, v14}, Landroid/opengl/EGL14;->eglMakeCurrent(Landroid/opengl/EGLDisplay;Landroid/opengl/EGLSurface;Landroid/opengl/EGLSurface;Landroid/opengl/EGLContext;)Z

    move-result v7

    if-eqz v7, :cond_16

    .line 88
    invoke-virtual {v0}, Landroid/graphics/Bitmap;->getWidth()I

    move-result v7

    invoke-virtual {v0}, Landroid/graphics/Bitmap;->getHeight()I

    move-result v8

    .line 89
    const/16 v9, 0xd33

    invoke-static {v9}, Llocal/mio/os4camerabridge/SoftwareSkinSmoothing;->integer(I)I

    move-result v10

    if-gt v7, v10, :cond_10

    invoke-static {v9}, Llocal/mio/os4camerabridge/SoftwareSkinSmoothing;->integer(I)I

    move-result v9
    :try_end_2
    .catchall {:try_start_2 .. :try_end_2} :catchall_3

    if-le v8, v9, :cond_2

    move-object/from16 v10, v16

    move-object/from16 v9, v23

    move-object/from16 v7, v24

    goto/16 :goto_4

    .line 90
    :cond_2
    move-object/from16 v9, v23

    const/4 v10, 0x2

    :try_start_3
    invoke-static {v10, v9, v1}, Landroid/opengl/GLES30;->glGenTextures(I[II)V
    :try_end_3
    .catchall {:try_start_3 .. :try_end_3} :catchall_2

    .line 91
    move v12, v1

    :goto_0
    const/16 v13, 0xde1

    if-ge v12, v10, :cond_3

    :try_start_4
    aget v10, v9, v12

    .line 92
    invoke-static {v13, v10}, Landroid/opengl/GLES30;->glBindTexture(II)V
    :try_end_4
    .catchall {:try_start_4 .. :try_end_4} :catchall_0

    .line 93
    const/16 v10, 0x2801

    move/from16 v23, v11

    const/16 v11, 0x2601

    :try_start_5
    invoke-static {v13, v10, v11}, Landroid/opengl/GLES30;->glTexParameteri(III)V

    .line 94
    const/16 v10, 0x2800

    invoke-static {v13, v10, v11}, Landroid/opengl/GLES30;->glTexParameteri(III)V

    .line 95
    const/16 v10, 0x2802

    const v11, 0x812f

    invoke-static {v13, v10, v11}, Landroid/opengl/GLES30;->glTexParameteri(III)V

    .line 96
    const/16 v10, 0x2803

    invoke-static {v13, v10, v11}, Landroid/opengl/GLES30;->glTexParameteri(III)V

    .line 91
    add-int/lit8 v12, v12, 0x1

    move/from16 v11, v23

    const/4 v10, 0x2

    goto :goto_0

    .line 116
    :catchall_0
    move-exception v0

    move/from16 v23, v11

    goto/16 :goto_3

    .line 98
    :cond_3
    move/from16 v23, v11

    aget v10, v9, v1

    invoke-static {v13, v10}, Landroid/opengl/GLES30;->glBindTexture(II)V

    .line 99
    invoke-static {v13, v1, v0, v1}, Landroid/opengl/GLUtils;->texImage2D(IILandroid/graphics/Bitmap;I)V

    .line 100
    aget v10, v9, v23

    invoke-static {v13, v10}, Landroid/opengl/GLES30;->glBindTexture(II)V

    .line 101
    const/16 v32, 0x1401

    const/16 v33, 0x0

    const/16 v25, 0xde1

    const/16 v26, 0x0

    const v27, 0x8058

    const/16 v30, 0x0

    const/16 v31, 0x1908

    move/from16 v28, v7

    move/from16 v29, v8

    invoke-static/range {v25 .. v33}, Landroid/opengl/GLES30;->glTexImage2D(IIIIIIIILjava/nio/Buffer;)V
    :try_end_5
    .catchall {:try_start_5 .. :try_end_5} :catchall_2

    move/from16 v19, v28

    .line 102
    move/from16 v11, v23

    move-object/from16 v7, v24

    :try_start_6
    invoke-static {v11, v7, v1}, Landroid/opengl/GLES30;->glGenFramebuffers(I[II)V

    .line 103
    aget v8, v7, v1

    const v10, 0x8d40

    invoke-static {v10, v8}, Landroid/opengl/GLES30;->glBindFramebuffer(II)V

    .line 104
    aget v8, v9, v11

    const v11, 0x8ce0

    invoke-static {v10, v11, v13, v8, v1}, Landroid/opengl/GLES30;->glFramebufferTexture2D(IIIII)V

    .line 105
    aget v17, v9, v1

    aget v18, v7, v1

    move/from16 v21, p1

    move/from16 v20, v29

    invoke-virtual/range {v16 .. v21}, Llocal/mio/os4camerabridge/SoftwareSkinSmoothing;->draw(IIIIF)Z

    move-result v8
    :try_end_6
    .catchall {:try_start_6 .. :try_end_6} :catchall_1

    move-object/from16 v10, v16

    if-nez v8, :cond_9

    .line 116
    sget-object v0, Landroid/opengl/EGL14;->EGL_NO_CONTEXT:Landroid/opengl/EGLContext;

    invoke-virtual {v0, v14}, Landroid/opengl/EGLContext;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-nez v0, :cond_4

    invoke-static {}, Landroid/opengl/EGL14;->eglGetCurrentContext()Landroid/opengl/EGLContext;

    move-result-object v0

    invoke-virtual {v14, v0}, Landroid/opengl/EGLContext;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_4

    .line 117
    const/4 v11, 0x1

    invoke-static {v11, v7, v1}, Landroid/opengl/GLES30;->glDeleteFramebuffers(I[II)V

    .line 118
    const/4 v7, 0x2

    invoke-static {v7, v9, v1}, Landroid/opengl/GLES30;->glDeleteTextures(I[II)V

    .line 119
    iget v0, v10, Llocal/mio/os4camerabridge/SoftwareSkinSmoothing;->program:I

    if-eqz v0, :cond_4

    iget v0, v10, Llocal/mio/os4camerabridge/SoftwareSkinSmoothing;->program:I

    invoke-static {v0}, Landroid/opengl/GLES30;->glDeleteProgram(I)V

    .line 121
    :cond_4
    sget-object v0, Landroid/opengl/EGL14;->EGL_NO_DISPLAY:Landroid/opengl/EGLDisplay;

    invoke-virtual {v0, v2}, Landroid/opengl/EGLDisplay;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-nez v0, :cond_5

    .line 122
    invoke-static {v2, v4, v5, v3}, Landroid/opengl/EGL14;->eglMakeCurrent(Landroid/opengl/EGLDisplay;Landroid/opengl/EGLSurface;Landroid/opengl/EGLSurface;Landroid/opengl/EGLContext;)Z

    goto :goto_1

    .line 123
    :cond_5
    if-eqz v22, :cond_6

    sget-object v0, Landroid/opengl/EGL14;->EGL_NO_SURFACE:Landroid/opengl/EGLSurface;

    sget-object v2, Landroid/opengl/EGL14;->EGL_NO_SURFACE:Landroid/opengl/EGLSurface;

    sget-object v3, Landroid/opengl/EGL14;->EGL_NO_CONTEXT:Landroid/opengl/EGLContext;

    invoke-static {v6, v0, v2, v3}, Landroid/opengl/EGL14;->eglMakeCurrent(Landroid/opengl/EGLDisplay;Landroid/opengl/EGLSurface;Landroid/opengl/EGLSurface;Landroid/opengl/EGLContext;)Z

    .line 124
    :cond_6
    :goto_1
    sget-object v0, Landroid/opengl/EGL14;->EGL_NO_SURFACE:Landroid/opengl/EGLSurface;

    invoke-virtual {v0, v15}, Landroid/opengl/EGLSurface;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-nez v0, :cond_7

    invoke-static {v6, v15}, Landroid/opengl/EGL14;->eglDestroySurface(Landroid/opengl/EGLDisplay;Landroid/opengl/EGLSurface;)Z

    .line 125
    :cond_7
    sget-object v0, Landroid/opengl/EGL14;->EGL_NO_CONTEXT:Landroid/opengl/EGLContext;

    invoke-virtual {v0, v14}, Landroid/opengl/EGLContext;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-nez v0, :cond_8

    invoke-static {v6, v14}, Landroid/opengl/EGL14;->eglDestroyContext(Landroid/opengl/EGLDisplay;Landroid/opengl/EGLContext;)Z

    .line 105
    :cond_8
    return v1

    .line 106
    :cond_9
    mul-int v8, v19, v29

    mul-int/lit8 v8, v8, 0x4

    :try_start_7
    invoke-static {v8}, Ljava/nio/ByteBuffer;->allocateDirect(I)Ljava/nio/ByteBuffer;

    move-result-object v8

    invoke-static {}, Ljava/nio/ByteOrder;->nativeOrder()Ljava/nio/ByteOrder;

    move-result-object v11

    invoke-virtual {v8, v11}, Ljava/nio/ByteBuffer;->order(Ljava/nio/ByteOrder;)Ljava/nio/ByteBuffer;

    move-result-object v31

    .line 107
    aget v8, v7, v1

    const v11, 0x8ca8

    invoke-static {v11, v8}, Landroid/opengl/GLES30;->glBindFramebuffer(II)V

    .line 108
    const/16 v8, 0xd05

    const/4 v11, 0x1

    invoke-static {v8, v11}, Landroid/opengl/GLES30;->glPixelStorei(II)V

    .line 109
    move/from16 v20, v29

    const/16 v29, 0x1908

    const/16 v30, 0x1401

    const/16 v25, 0x0

    const/16 v26, 0x0

    move/from16 v27, v19

    move/from16 v28, v20

    invoke-static/range {v25 .. v31}, Landroid/opengl/GLES30;->glReadPixels(IIIIIILjava/nio/Buffer;)V

    move-object/from16 v8, v31

    .line 110
    invoke-static {}, Landroid/opengl/GLES30;->glGetError()I

    move-result v11

    .line 111
    if-nez v11, :cond_f

    .line 112
    invoke-virtual {v8}, Ljava/nio/ByteBuffer;->rewind()Ljava/nio/ByteBuffer;

    .line 113
    invoke-virtual {v0, v8}, Landroid/graphics/Bitmap;->copyPixelsFromBuffer(Ljava/nio/Buffer;)V
    :try_end_7
    .catchall {:try_start_7 .. :try_end_7} :catchall_5

    .line 114
    nop

    .line 116
    sget-object v0, Landroid/opengl/EGL14;->EGL_NO_CONTEXT:Landroid/opengl/EGLContext;

    invoke-virtual {v0, v14}, Landroid/opengl/EGLContext;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-nez v0, :cond_a

    invoke-static {}, Landroid/opengl/EGL14;->eglGetCurrentContext()Landroid/opengl/EGLContext;

    move-result-object v0

    invoke-virtual {v14, v0}, Landroid/opengl/EGLContext;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_a

    .line 117
    const/4 v11, 0x1

    invoke-static {v11, v7, v1}, Landroid/opengl/GLES30;->glDeleteFramebuffers(I[II)V

    .line 118
    const/4 v7, 0x2

    invoke-static {v7, v9, v1}, Landroid/opengl/GLES30;->glDeleteTextures(I[II)V

    .line 119
    iget v0, v10, Llocal/mio/os4camerabridge/SoftwareSkinSmoothing;->program:I

    if-eqz v0, :cond_a

    iget v0, v10, Llocal/mio/os4camerabridge/SoftwareSkinSmoothing;->program:I

    invoke-static {v0}, Landroid/opengl/GLES30;->glDeleteProgram(I)V

    .line 121
    :cond_a
    sget-object v0, Landroid/opengl/EGL14;->EGL_NO_DISPLAY:Landroid/opengl/EGLDisplay;

    invoke-virtual {v0, v2}, Landroid/opengl/EGLDisplay;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-nez v0, :cond_b

    .line 122
    invoke-static {v2, v4, v5, v3}, Landroid/opengl/EGL14;->eglMakeCurrent(Landroid/opengl/EGLDisplay;Landroid/opengl/EGLSurface;Landroid/opengl/EGLSurface;Landroid/opengl/EGLContext;)Z

    goto :goto_2

    .line 123
    :cond_b
    if-eqz v22, :cond_c

    sget-object v0, Landroid/opengl/EGL14;->EGL_NO_SURFACE:Landroid/opengl/EGLSurface;

    sget-object v1, Landroid/opengl/EGL14;->EGL_NO_SURFACE:Landroid/opengl/EGLSurface;

    sget-object v2, Landroid/opengl/EGL14;->EGL_NO_CONTEXT:Landroid/opengl/EGLContext;

    invoke-static {v6, v0, v1, v2}, Landroid/opengl/EGL14;->eglMakeCurrent(Landroid/opengl/EGLDisplay;Landroid/opengl/EGLSurface;Landroid/opengl/EGLSurface;Landroid/opengl/EGLContext;)Z

    .line 124
    :cond_c
    :goto_2
    sget-object v0, Landroid/opengl/EGL14;->EGL_NO_SURFACE:Landroid/opengl/EGLSurface;

    invoke-virtual {v0, v15}, Landroid/opengl/EGLSurface;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-nez v0, :cond_d

    invoke-static {v6, v15}, Landroid/opengl/EGL14;->eglDestroySurface(Landroid/opengl/EGLDisplay;Landroid/opengl/EGLSurface;)Z

    .line 125
    :cond_d
    sget-object v0, Landroid/opengl/EGL14;->EGL_NO_CONTEXT:Landroid/opengl/EGLContext;

    invoke-virtual {v0, v14}, Landroid/opengl/EGLContext;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-nez v0, :cond_e

    invoke-static {v6, v14}, Landroid/opengl/EGL14;->eglDestroyContext(Landroid/opengl/EGLDisplay;Landroid/opengl/EGLContext;)Z

    .line 114
    :cond_e
    const/16 v23, 0x1

    return v23

    .line 111
    :cond_f
    :try_start_8
    new-instance v0, Ljava/lang/IllegalStateException;

    new-instance v8, Ljava/lang/StringBuilder;

    invoke-direct {v8}, Ljava/lang/StringBuilder;-><init>()V

    const-string v12, "beauty readback="

    invoke-virtual {v8, v12}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v8

    invoke-virtual {v8, v11}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v8

    invoke-virtual {v8}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v8

    invoke-direct {v0, v8}, Ljava/lang/IllegalStateException;-><init>(Ljava/lang/String;)V

    throw v0
    :try_end_8
    .catchall {:try_start_8 .. :try_end_8} :catchall_5

    .line 116
    :catchall_1
    move-exception v0

    goto/16 :goto_7

    :catchall_2
    move-exception v0

    :goto_3
    move-object/from16 v10, v16

    goto/16 :goto_6

    .line 89
    :cond_10
    move-object/from16 v10, v16

    move-object/from16 v9, v23

    move-object/from16 v7, v24

    .line 116
    :goto_4
    sget-object v0, Landroid/opengl/EGL14;->EGL_NO_CONTEXT:Landroid/opengl/EGLContext;

    invoke-virtual {v0, v14}, Landroid/opengl/EGLContext;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-nez v0, :cond_11

    invoke-static {}, Landroid/opengl/EGL14;->eglGetCurrentContext()Landroid/opengl/EGLContext;

    move-result-object v0

    invoke-virtual {v14, v0}, Landroid/opengl/EGLContext;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_11

    .line 117
    const/4 v11, 0x1

    invoke-static {v11, v7, v1}, Landroid/opengl/GLES30;->glDeleteFramebuffers(I[II)V

    .line 118
    const/4 v7, 0x2

    invoke-static {v7, v9, v1}, Landroid/opengl/GLES30;->glDeleteTextures(I[II)V

    .line 119
    iget v0, v10, Llocal/mio/os4camerabridge/SoftwareSkinSmoothing;->program:I

    if-eqz v0, :cond_11

    iget v0, v10, Llocal/mio/os4camerabridge/SoftwareSkinSmoothing;->program:I

    invoke-static {v0}, Landroid/opengl/GLES30;->glDeleteProgram(I)V

    .line 121
    :cond_11
    sget-object v0, Landroid/opengl/EGL14;->EGL_NO_DISPLAY:Landroid/opengl/EGLDisplay;

    invoke-virtual {v0, v2}, Landroid/opengl/EGLDisplay;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-nez v0, :cond_12

    .line 122
    invoke-static {v2, v4, v5, v3}, Landroid/opengl/EGL14;->eglMakeCurrent(Landroid/opengl/EGLDisplay;Landroid/opengl/EGLSurface;Landroid/opengl/EGLSurface;Landroid/opengl/EGLContext;)Z

    goto :goto_5

    .line 123
    :cond_12
    if-eqz v22, :cond_13

    sget-object v0, Landroid/opengl/EGL14;->EGL_NO_SURFACE:Landroid/opengl/EGLSurface;

    sget-object v2, Landroid/opengl/EGL14;->EGL_NO_SURFACE:Landroid/opengl/EGLSurface;

    sget-object v3, Landroid/opengl/EGL14;->EGL_NO_CONTEXT:Landroid/opengl/EGLContext;

    invoke-static {v6, v0, v2, v3}, Landroid/opengl/EGL14;->eglMakeCurrent(Landroid/opengl/EGLDisplay;Landroid/opengl/EGLSurface;Landroid/opengl/EGLSurface;Landroid/opengl/EGLContext;)Z

    .line 124
    :cond_13
    :goto_5
    sget-object v0, Landroid/opengl/EGL14;->EGL_NO_SURFACE:Landroid/opengl/EGLSurface;

    invoke-virtual {v0, v15}, Landroid/opengl/EGLSurface;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-nez v0, :cond_14

    invoke-static {v6, v15}, Landroid/opengl/EGL14;->eglDestroySurface(Landroid/opengl/EGLDisplay;Landroid/opengl/EGLSurface;)Z

    .line 125
    :cond_14
    sget-object v0, Landroid/opengl/EGL14;->EGL_NO_CONTEXT:Landroid/opengl/EGLContext;

    invoke-virtual {v0, v14}, Landroid/opengl/EGLContext;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-nez v0, :cond_15

    invoke-static {v6, v14}, Landroid/opengl/EGL14;->eglDestroyContext(Landroid/opengl/EGLDisplay;Landroid/opengl/EGLContext;)Z

    .line 89
    :cond_15
    return v1

    .line 87
    :cond_16
    move-object/from16 v10, v16

    move-object/from16 v9, v23

    move-object/from16 v7, v24

    :try_start_9
    new-instance v0, Ljava/lang/IllegalStateException;

    const-string v8, "beauty makeCurrent"

    invoke-direct {v0, v8}, Ljava/lang/IllegalStateException;-><init>(Ljava/lang/String;)V

    throw v0

    .line 81
    :cond_17
    move-object/from16 v10, v16

    move-object/from16 v9, v23

    move-object/from16 v7, v24

    .line 82
    new-instance v0, Ljava/lang/IllegalStateException;

    const-string v8, "beauty ES3 config"

    invoke-direct {v0, v8}, Ljava/lang/IllegalStateException;-><init>(Ljava/lang/String;)V

    throw v0

    .line 116
    :catchall_3
    move-exception v0

    move-object/from16 v10, v16

    move-object/from16 v9, v23

    :goto_6
    move-object/from16 v7, v24

    goto :goto_8

    :catchall_4
    move-exception v0

    move-object v9, v8

    move-object v7, v10

    :goto_7
    move-object/from16 v10, v16

    goto :goto_8

    .line 76
    :cond_18
    move-object v9, v8

    move-object v7, v10

    move-object/from16 v10, v16

    new-instance v0, Ljava/lang/IllegalStateException;

    const-string v8, "beauty eglInitialize"

    invoke-direct {v0, v8}, Ljava/lang/IllegalStateException;-><init>(Ljava/lang/String;)V

    throw v0
    :try_end_9
    .catchall {:try_start_9 .. :try_end_9} :catchall_5

    .line 116
    :catchall_5
    move-exception v0

    goto :goto_8

    :catchall_6
    move-exception v0

    move-object v9, v8

    move-object v7, v10

    move-object/from16 v10, v16

    move/from16 v22, v1

    :goto_8
    sget-object v8, Landroid/opengl/EGL14;->EGL_NO_CONTEXT:Landroid/opengl/EGLContext;

    invoke-virtual {v8, v14}, Landroid/opengl/EGLContext;->equals(Ljava/lang/Object;)Z

    move-result v8

    if-nez v8, :cond_19

    invoke-static {}, Landroid/opengl/EGL14;->eglGetCurrentContext()Landroid/opengl/EGLContext;

    move-result-object v8

    invoke-virtual {v14, v8}, Landroid/opengl/EGLContext;->equals(Ljava/lang/Object;)Z

    move-result v8

    if-eqz v8, :cond_19

    .line 117
    const/4 v11, 0x1

    invoke-static {v11, v7, v1}, Landroid/opengl/GLES30;->glDeleteFramebuffers(I[II)V

    .line 118
    const/4 v7, 0x2

    invoke-static {v7, v9, v1}, Landroid/opengl/GLES30;->glDeleteTextures(I[II)V

    .line 119
    iget v1, v10, Llocal/mio/os4camerabridge/SoftwareSkinSmoothing;->program:I

    if-eqz v1, :cond_19

    iget v1, v10, Llocal/mio/os4camerabridge/SoftwareSkinSmoothing;->program:I

    invoke-static {v1}, Landroid/opengl/GLES30;->glDeleteProgram(I)V

    .line 121
    :cond_19
    sget-object v1, Landroid/opengl/EGL14;->EGL_NO_DISPLAY:Landroid/opengl/EGLDisplay;

    invoke-virtual {v1, v2}, Landroid/opengl/EGLDisplay;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-nez v1, :cond_1a

    .line 122
    invoke-static {v2, v4, v5, v3}, Landroid/opengl/EGL14;->eglMakeCurrent(Landroid/opengl/EGLDisplay;Landroid/opengl/EGLSurface;Landroid/opengl/EGLSurface;Landroid/opengl/EGLContext;)Z

    goto :goto_9

    .line 123
    :cond_1a
    if-eqz v22, :cond_1b

    sget-object v1, Landroid/opengl/EGL14;->EGL_NO_SURFACE:Landroid/opengl/EGLSurface;

    sget-object v2, Landroid/opengl/EGL14;->EGL_NO_SURFACE:Landroid/opengl/EGLSurface;

    sget-object v3, Landroid/opengl/EGL14;->EGL_NO_CONTEXT:Landroid/opengl/EGLContext;

    invoke-static {v6, v1, v2, v3}, Landroid/opengl/EGL14;->eglMakeCurrent(Landroid/opengl/EGLDisplay;Landroid/opengl/EGLSurface;Landroid/opengl/EGLSurface;Landroid/opengl/EGLContext;)Z

    .line 124
    :cond_1b
    :goto_9
    sget-object v1, Landroid/opengl/EGL14;->EGL_NO_SURFACE:Landroid/opengl/EGLSurface;

    invoke-virtual {v1, v15}, Landroid/opengl/EGLSurface;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-nez v1, :cond_1c

    invoke-static {v6, v15}, Landroid/opengl/EGL14;->eglDestroySurface(Landroid/opengl/EGLDisplay;Landroid/opengl/EGLSurface;)Z

    .line 125
    :cond_1c
    sget-object v1, Landroid/opengl/EGL14;->EGL_NO_CONTEXT:Landroid/opengl/EGLContext;

    invoke-virtual {v1, v14}, Landroid/opengl/EGLContext;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-nez v1, :cond_1d

    invoke-static {v6, v14}, Landroid/opengl/EGL14;->eglDestroyContext(Landroid/opengl/EGLDisplay;Landroid/opengl/EGLContext;)Z

    .line 127
    :cond_1d
    throw v0

    .line 61
    :cond_1e
    :goto_a
    return v1

    nop

    :array_0
    .array-data 4
        0x3040
        0x40
        0x3033
        0x1
        0x3024
        0x8
        0x3023
        0x8
        0x3022
        0x8
        0x3021
        0x8
        0x3038
    .end array-data
.end method

.method private static createProgram()I
    .locals 7

    .line 131
    const v0, 0x8b31

    const-string v1, "#version 300 es\nout vec2 uv; void main(){vec2 p=vec2((gl_VertexID<<1)&2,gl_VertexID&2);uv=p;gl_Position=vec4(p*2.0-1.0,0.0,1.0);}"

    invoke-static {v0, v1}, Llocal/mio/os4camerabridge/SoftwareSkinSmoothing;->shader(ILjava/lang/String;)I

    move-result v0

    .line 133
    const/4 v1, 0x0

    :try_start_0
    const-string v2, "#version 300 es\nprecision highp float;\nuniform sampler2D image; uniform vec2 stepSize; uniform float amount; in vec2 uv; out vec4 result;void main(){vec4 src=texture(image,uv);vec3 sum=vec3(0.0);float total=0.0;for(int y=-2;y<=2;y++){for(int x=-2;x<=2;x++){vec2 d=vec2(float(x),float(y));vec3 n=texture(image,uv+d*stepSize).rgb;vec3 diff=n-src.rgb;float w=exp(-dot(d,d)*0.24-dot(diff,diff)*55.0);sum+=n*w;total+=w;}}float l=dot(src.rgb,vec3(0.299,0.587,0.114));float cb=0.5+(src.b-l)*0.564;float cr=0.5+(src.r-l)*0.713;float skin=smoothstep(0.49,0.55,cr)*(1.0-smoothstep(0.66,0.73,cr))*smoothstep(0.22,0.29,cb)*(1.0-smoothstep(0.53,0.59,cb))*smoothstep(0.06,0.18,l)*(1.0-smoothstep(0.91,0.99,l));result=vec4(mix(src.rgb,sum/max(total,0.001),amount*skin*0.85),src.a);}"

    const v3, 0x8b30

    invoke-static {v3, v2}, Llocal/mio/os4camerabridge/SoftwareSkinSmoothing;->shader(ILjava/lang/String;)I

    move-result v2
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_2

    .line 134
    :try_start_1
    invoke-static {}, Landroid/opengl/GLES30;->glCreateProgram()I

    move-result v3
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_1

    .line 135
    :try_start_2
    invoke-static {v3, v0}, Landroid/opengl/GLES30;->glAttachShader(II)V

    invoke-static {v3, v2}, Landroid/opengl/GLES30;->glAttachShader(II)V

    invoke-static {v3}, Landroid/opengl/GLES30;->glLinkProgram(I)V

    .line 136
    const/4 v4, 0x1

    new-array v4, v4, [I

    const v5, 0x8b82

    invoke-static {v3, v5, v4, v1}, Landroid/opengl/GLES30;->glGetProgramiv(II[II)V

    .line 137
    aget v1, v4, v1
    :try_end_2
    .catchall {:try_start_2 .. :try_end_2} :catchall_0

    if-eqz v1, :cond_1

    .line 138
    nop

    .line 139
    invoke-static {v0}, Landroid/opengl/GLES30;->glDeleteShader(I)V

    if-eqz v2, :cond_0

    invoke-static {v2}, Landroid/opengl/GLES30;->glDeleteShader(I)V

    .line 138
    :cond_0
    return v3

    .line 137
    :cond_1
    :try_start_3
    new-instance v1, Ljava/lang/IllegalStateException;

    invoke-static {v3}, Landroid/opengl/GLES30;->glGetProgramInfoLog(I)Ljava/lang/String;

    move-result-object v4

    invoke-direct {v1, v4}, Ljava/lang/IllegalStateException;-><init>(Ljava/lang/String;)V

    throw v1
    :try_end_3
    .catchall {:try_start_3 .. :try_end_3} :catchall_0

    .line 139
    :catchall_0
    move-exception v1

    goto :goto_0

    :catchall_1
    move-exception v3

    move-object v6, v3

    move v3, v1

    move-object v1, v6

    goto :goto_0

    :catchall_2
    move-exception v2

    move v3, v1

    move-object v1, v2

    move v2, v3

    :goto_0
    invoke-static {v0}, Landroid/opengl/GLES30;->glDeleteShader(I)V

    if-eqz v2, :cond_2

    invoke-static {v2}, Landroid/opengl/GLES30;->glDeleteShader(I)V

    :cond_2
    if-eqz v3, :cond_3

    invoke-static {v3}, Landroid/opengl/GLES30;->glDeleteProgram(I)V

    :cond_3
    throw v1
.end method

.method private static integer(I)I
    .locals 2

    .line 147
    const/4 v0, 0x1

    new-array v0, v0, [I

    const/4 v1, 0x0

    invoke-static {p0, v0, v1}, Landroid/opengl/GLES30;->glGetIntegerv(I[II)V

    aget p0, v0, v1

    return p0
.end method

.method private static shader(ILjava/lang/String;)I
    .locals 2

    .line 142
    invoke-static {p0}, Landroid/opengl/GLES30;->glCreateShader(I)I

    move-result p0

    invoke-static {p0, p1}, Landroid/opengl/GLES30;->glShaderSource(ILjava/lang/String;)V

    invoke-static {p0}, Landroid/opengl/GLES30;->glCompileShader(I)V

    .line 143
    const/4 p1, 0x1

    new-array p1, p1, [I

    const v0, 0x8b81

    const/4 v1, 0x0

    invoke-static {p0, v0, p1, v1}, Landroid/opengl/GLES30;->glGetShaderiv(II[II)V

    .line 144
    aget p1, p1, v1

    if-eqz p1, :cond_0

    .line 145
    return p0

    .line 144
    :cond_0
    invoke-static {p0}, Landroid/opengl/GLES30;->glGetShaderInfoLog(I)Ljava/lang/String;

    move-result-object p1

    invoke-static {p0}, Landroid/opengl/GLES30;->glDeleteShader(I)V

    new-instance p0, Ljava/lang/IllegalStateException;

    invoke-direct {p0, p1}, Ljava/lang/IllegalStateException;-><init>(Ljava/lang/String;)V

    throw p0
.end method


# virtual methods
.method public draw(IIIIF)Z
    .locals 5

    .line 30
    const/4 v0, 0x0

    cmpg-float v0, p5, v0

    const/4 v1, 0x0

    if-lez v0, :cond_8

    if-lez p1, :cond_8

    if-lez p2, :cond_8

    if-lez p3, :cond_8

    if-gtz p4, :cond_0

    goto/16 :goto_2

    .line 31
    :cond_0
    invoke-static {}, Landroid/opengl/EGL14;->eglGetCurrentContext()Landroid/opengl/EGLContext;

    move-result-object v0

    .line 32
    if-eqz v0, :cond_7

    sget-object v2, Landroid/opengl/EGL14;->EGL_NO_CONTEXT:Landroid/opengl/EGLContext;

    invoke-virtual {v2, v0}, Landroid/opengl/EGLContext;->equals(Ljava/lang/Object;)Z

    move-result v2

    if-nez v2, :cond_7

    const/16 v2, 0x1f02

    invoke-static {v2}, Landroid/opengl/GLES30;->glGetString(I)Ljava/lang/String;

    move-result-object v2

    if-nez v2, :cond_1

    goto/16 :goto_1

    .line 33
    :cond_1
    new-instance v2, Llocal/mio/os4camerabridge/SoftwareSkinSmoothing$State;

    invoke-direct {v2}, Llocal/mio/os4camerabridge/SoftwareSkinSmoothing$State;-><init>()V

    .line 35
    :try_start_0
    iget-object v3, p0, Llocal/mio/os4camerabridge/SoftwareSkinSmoothing;->context:Landroid/opengl/EGLContext;

    invoke-virtual {v0, v3}, Landroid/opengl/EGLContext;->equals(Ljava/lang/Object;)Z

    move-result v3

    if-nez v3, :cond_2

    iput-object v0, p0, Llocal/mio/os4camerabridge/SoftwareSkinSmoothing;->context:Landroid/opengl/EGLContext;

    iput v1, p0, Llocal/mio/os4camerabridge/SoftwareSkinSmoothing;->program:I

    .line 36
    :cond_2
    iget v0, p0, Llocal/mio/os4camerabridge/SoftwareSkinSmoothing;->program:I

    if-nez v0, :cond_3

    invoke-static {}, Llocal/mio/os4camerabridge/SoftwareSkinSmoothing;->createProgram()I

    move-result v0

    iput v0, p0, Llocal/mio/os4camerabridge/SoftwareSkinSmoothing;->program:I

    .line 37
    :cond_3
    const v0, 0x8ca9

    invoke-static {v0, p2}, Landroid/opengl/GLES30;->glBindFramebuffer(II)V

    .line 38
    invoke-static {v0}, Landroid/opengl/GLES30;->glCheckFramebufferStatus(I)I

    move-result p2

    const v0, 0x8cd5

    if-ne p2, v0, :cond_6

    .line 40
    sget-object p2, Llocal/mio/os4camerabridge/SoftwareSkinSmoothing$State;->CAPS:[I

    array-length v0, p2

    move v3, v1

    :goto_0
    if-ge v3, v0, :cond_4

    aget v4, p2, v3

    invoke-static {v4}, Landroid/opengl/GLES30;->glDisable(I)V

    add-int/lit8 v3, v3, 0x1

    goto :goto_0

    .line 41
    :cond_4
    const/4 p2, 0x1

    invoke-static {p2, p2, p2, p2}, Landroid/opengl/GLES30;->glColorMask(ZZZZ)V

    .line 42
    invoke-static {v1, v1, p3, p4}, Landroid/opengl/GLES30;->glViewport(IIII)V

    .line 43
    iget v0, p0, Llocal/mio/os4camerabridge/SoftwareSkinSmoothing;->program:I

    invoke-static {v0}, Landroid/opengl/GLES30;->glUseProgram(I)V

    .line 44
    const v0, 0x84c0

    invoke-static {v0}, Landroid/opengl/GLES30;->glActiveTexture(I)V

    .line 45
    invoke-static {v1, v1}, Landroid/opengl/GLES30;->glBindSampler(II)V

    .line 46
    const/16 v0, 0xde1

    invoke-static {v0, p1}, Landroid/opengl/GLES30;->glBindTexture(II)V

    .line 47
    iget p1, p0, Llocal/mio/os4camerabridge/SoftwareSkinSmoothing;->program:I

    const-string v0, "image"

    invoke-static {p1, v0}, Landroid/opengl/GLES30;->glGetUniformLocation(ILjava/lang/String;)I

    move-result p1

    invoke-static {p1, v1}, Landroid/opengl/GLES30;->glUniform1i(II)V

    .line 49
    invoke-static {p3, p4}, Ljava/lang/Math;->min(II)I

    move-result p1

    int-to-float p1, p1

    const/high16 v0, 0x44070000    # 540.0f

    div-float/2addr p1, v0

    const/high16 v0, 0x3f800000    # 1.0f

    invoke-static {v0, p1}, Ljava/lang/Math;->max(FF)F

    move-result p1

    .line 50
    iget v3, p0, Llocal/mio/os4camerabridge/SoftwareSkinSmoothing;->program:I

    const-string v4, "stepSize"

    invoke-static {v3, v4}, Landroid/opengl/GLES30;->glGetUniformLocation(ILjava/lang/String;)I

    move-result v3

    int-to-float p3, p3

    div-float p3, p1, p3

    int-to-float p4, p4

    div-float/2addr p1, p4

    invoke-static {v3, p3, p1}, Landroid/opengl/GLES30;->glUniform2f(IFF)V

    .line 51
    iget p1, p0, Llocal/mio/os4camerabridge/SoftwareSkinSmoothing;->program:I

    const-string p3, "amount"

    invoke-static {p1, p3}, Landroid/opengl/GLES30;->glGetUniformLocation(ILjava/lang/String;)I

    move-result p1

    invoke-static {v0, p5}, Ljava/lang/Math;->min(FF)F

    move-result p3

    invoke-static {p1, p3}, Landroid/opengl/GLES30;->glUniform1f(IF)V

    .line 52
    const/4 p1, 0x4

    const/4 p3, 0x3

    invoke-static {p1, v1, p3}, Landroid/opengl/GLES30;->glDrawArrays(III)V

    .line 53
    invoke-static {}, Landroid/opengl/GLES30;->glGetError()I

    move-result p1
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 54
    if-nez p1, :cond_5

    .line 55
    nop

    .line 56
    invoke-virtual {v2}, Llocal/mio/os4camerabridge/SoftwareSkinSmoothing$State;->restore()V

    .line 55
    return p2

    .line 54
    :cond_5
    :try_start_1
    new-instance p2, Ljava/lang/IllegalStateException;

    new-instance p3, Ljava/lang/StringBuilder;

    invoke-direct {p3}, Ljava/lang/StringBuilder;-><init>()V

    const-string p4, "beauty GL error="

    invoke-virtual {p3, p4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p3

    invoke-virtual {p3, p1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object p1

    invoke-virtual {p1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p1

    invoke-direct {p2, p1}, Ljava/lang/IllegalStateException;-><init>(Ljava/lang/String;)V

    throw p2

    .line 39
    :cond_6
    new-instance p1, Ljava/lang/IllegalStateException;

    const-string p2, "beauty FBO incomplete"

    invoke-direct {p1, p2}, Ljava/lang/IllegalStateException;-><init>(Ljava/lang/String;)V

    throw p1
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    .line 56
    :catchall_0
    move-exception p1

    invoke-virtual {v2}, Llocal/mio/os4camerabridge/SoftwareSkinSmoothing$State;->restore()V

    throw p1

    .line 32
    :cond_7
    :goto_1
    return v1

    .line 30
    :cond_8
    :goto_2
    return v1
.end method
