.class final Llocal/mio/os4camerabridge/DocumentTextEnhancer;
.super Ljava/lang/Object;
.source "DocumentTextEnhancer.java"


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Llocal/mio/os4camerabridge/DocumentTextEnhancer$Result;
    }
.end annotation


# static fields
.field private static final LOCK:Ljava/lang/Object;

.field private static final MODEL_ASSET:Ljava/lang/String; = "assets/text_enhance_yuv_v1.tflite"

.field private static final MODEL_HEIGHT:I = 0x620

.field private static final MODEL_PIXELS:I = 0x328800

.field private static final MODEL_WIDTH:I = 0x840

.field private static nativeRuntimeLoaded:Z


# direct methods
.method static constructor <clinit>()V
    .locals 1

    .line 25
    new-instance v0, Ljava/lang/Object;

    invoke-direct {v0}, Ljava/lang/Object;-><init>()V

    sput-object v0, Llocal/mio/os4camerabridge/DocumentTextEnhancer;->LOCK:Ljava/lang/Object;

    return-void
.end method

.method private constructor <init>()V
    .locals 0

    .line 47
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 48
    return-void
.end method

.method private static applyResidual([III[B[B)V
    .locals 30
    .param p0, "pixels"    # [I
    .param p1, "width"    # I
    .param p2, "height"    # I
    .param p3, "inputLuma"    # [B
    .param p4, "outputLuma"    # [B

    .line 193
    move/from16 v0, p1

    move/from16 v1, p2

    add-int/lit8 v2, v0, -0x1

    const/4 v3, 0x1

    invoke-static {v3, v2}, Ljava/lang/Math;->max(II)I

    move-result v2

    .line 194
    .local v2, "xDenominator":I
    add-int/lit8 v4, v1, -0x1

    invoke-static {v3, v4}, Ljava/lang/Math;->max(II)I

    move-result v3

    .line 195
    .local v3, "yDenominator":I
    const/4 v4, 0x0

    .local v4, "y":I
    :goto_0
    if-ge v4, v1, :cond_1

    .line 196
    int-to-float v5, v4

    const v6, 0x44c3e000    # 1567.0f

    mul-float/2addr v5, v6

    int-to-float v6, v3

    div-float/2addr v5, v6

    .line 197
    .local v5, "modelY":F
    float-to-int v6, v5

    const/16 v7, 0x61f

    invoke-static {v6, v7}, Ljava/lang/Math;->min(II)I

    move-result v6

    .line 198
    .local v6, "y0":I
    add-int/lit8 v8, v6, 0x1

    invoke-static {v8, v7}, Ljava/lang/Math;->min(II)I

    move-result v7

    .line 199
    .local v7, "y1":I
    int-to-float v8, v6

    sub-float v8, v5, v8

    .line 200
    .local v8, "yFraction":F
    mul-int/lit16 v9, v6, 0x840

    .line 201
    .local v9, "row0":I
    mul-int/lit16 v10, v7, 0x840

    .line 202
    .local v10, "row1":I
    mul-int v11, v4, v0

    .line 203
    .local v11, "destinationRow":I
    const/4 v12, 0x0

    .local v12, "x":I
    :goto_1
    if-ge v12, v0, :cond_0

    .line 204
    int-to-float v13, v12

    const v14, 0x4503f000    # 2111.0f

    mul-float/2addr v13, v14

    int-to-float v14, v2

    div-float/2addr v13, v14

    .line 205
    .local v13, "modelX":F
    float-to-int v14, v13

    const/16 v15, 0x83f

    invoke-static {v14, v15}, Ljava/lang/Math;->min(II)I

    move-result v14

    .line 206
    .local v14, "x0":I
    add-int/lit8 v0, v14, 0x1

    invoke-static {v0, v15}, Ljava/lang/Math;->min(II)I

    move-result v0

    .line 207
    .local v0, "x1":I
    int-to-float v15, v14

    sub-float v15, v13, v15

    .line 209
    .local v15, "xFraction":F
    add-int v16, v9, v14

    move/from16 v17, v0

    .end local v0    # "x1":I
    .local v17, "x1":I
    aget-byte v0, p4, v16

    and-int/lit16 v0, v0, 0xff

    add-int v16, v9, v14

    move/from16 v18, v0

    aget-byte v0, p3, v16

    and-int/lit16 v0, v0, 0xff

    sub-int v0, v18, v0

    int-to-float v0, v0

    .line 211
    .local v0, "d00":F
    add-int v16, v9, v17

    move/from16 v18, v0

    .end local v0    # "d00":F
    .local v18, "d00":F
    aget-byte v0, p4, v16

    and-int/lit16 v0, v0, 0xff

    add-int v16, v9, v17

    move/from16 v19, v0

    aget-byte v0, p3, v16

    and-int/lit16 v0, v0, 0xff

    sub-int v0, v19, v0

    int-to-float v0, v0

    .line 213
    .local v0, "d10":F
    add-int v16, v10, v14

    move/from16 v19, v0

    .end local v0    # "d10":F
    .local v19, "d10":F
    aget-byte v0, p4, v16

    and-int/lit16 v0, v0, 0xff

    add-int v16, v10, v14

    move/from16 v20, v0

    aget-byte v0, p3, v16

    and-int/lit16 v0, v0, 0xff

    sub-int v0, v20, v0

    int-to-float v0, v0

    .line 215
    .local v0, "d01":F
    add-int v16, v10, v17

    move/from16 v20, v0

    .end local v0    # "d01":F
    .local v20, "d01":F
    aget-byte v0, p4, v16

    and-int/lit16 v0, v0, 0xff

    add-int v16, v10, v17

    move/from16 v21, v0

    aget-byte v0, p3, v16

    and-int/lit16 v0, v0, 0xff

    sub-int v0, v21, v0

    int-to-float v0, v0

    .line 217
    .local v0, "d11":F
    sub-float v16, v19, v18

    mul-float v16, v16, v15

    add-float v16, v18, v16

    .line 218
    .local v16, "top":F
    sub-float v21, v0, v20

    mul-float v21, v21, v15

    add-float v21, v20, v21

    .line 219
    .local v21, "bottom":F
    sub-float v22, v21, v16

    mul-float v22, v22, v8

    add-float v22, v16, v22

    invoke-static/range {v22 .. v22}, Ljava/lang/Math;->round(F)I

    move-result v22

    .line 221
    .local v22, "delta":I
    add-int v23, v11, v12

    .line 222
    .local v23, "index":I
    move/from16 v24, v0

    .end local v0    # "d11":F
    .local v24, "d11":F
    aget v0, p0, v23

    .line 223
    .local v0, "color":I
    const/high16 v25, -0x1000000

    and-int v25, v0, v25

    .line 224
    .local v25, "alpha":I
    ushr-int/lit8 v1, v0, 0x10

    and-int/lit16 v1, v1, 0xff

    add-int v1, v1, v22

    invoke-static {v1}, Llocal/mio/os4camerabridge/DocumentTextEnhancer;->clamp8(I)I

    move-result v1

    .line 225
    .local v1, "red":I
    move/from16 v26, v1

    .end local v1    # "red":I
    .local v26, "red":I
    ushr-int/lit8 v1, v0, 0x8

    and-int/lit16 v1, v1, 0xff

    add-int v1, v1, v22

    invoke-static {v1}, Llocal/mio/os4camerabridge/DocumentTextEnhancer;->clamp8(I)I

    move-result v1

    .line 226
    .local v1, "green":I
    move/from16 v27, v1

    .end local v1    # "green":I
    .local v27, "green":I
    and-int/lit16 v1, v0, 0xff

    add-int v1, v1, v22

    invoke-static {v1}, Llocal/mio/os4camerabridge/DocumentTextEnhancer;->clamp8(I)I

    move-result v1

    .line 227
    .local v1, "blue":I
    shl-int/lit8 v28, v26, 0x10

    or-int v28, v25, v28

    shl-int/lit8 v29, v27, 0x8

    or-int v28, v28, v29

    or-int v28, v28, v1

    aput v28, p0, v23

    .line 203
    .end local v0    # "color":I
    .end local v1    # "blue":I
    .end local v13    # "modelX":F
    .end local v14    # "x0":I
    .end local v15    # "xFraction":F
    .end local v16    # "top":F
    .end local v17    # "x1":I
    .end local v18    # "d00":F
    .end local v19    # "d10":F
    .end local v20    # "d01":F
    .end local v21    # "bottom":F
    .end local v22    # "delta":I
    .end local v23    # "index":I
    .end local v24    # "d11":F
    .end local v25    # "alpha":I
    .end local v26    # "red":I
    .end local v27    # "green":I
    add-int/lit8 v12, v12, 0x1

    move/from16 v0, p1

    move/from16 v1, p2

    goto/16 :goto_1

    .line 195
    .end local v5    # "modelY":F
    .end local v6    # "y0":I
    .end local v7    # "y1":I
    .end local v8    # "yFraction":F
    .end local v9    # "row0":I
    .end local v10    # "row1":I
    .end local v11    # "destinationRow":I
    .end local v12    # "x":I
    :cond_0
    add-int/lit8 v4, v4, 0x1

    move/from16 v0, p1

    move/from16 v1, p2

    goto/16 :goto_0

    .line 230
    .end local v4    # "y":I
    :cond_1
    return-void
.end method

.method private static clamp8(I)I
    .locals 2
    .param p0, "value"    # I

    .line 233
    const/16 v0, 0xff

    invoke-static {v0, p0}, Ljava/lang/Math;->min(II)I

    move-result v0

    const/4 v1, 0x0

    invoke-static {v1, v0}, Ljava/lang/Math;->max(II)I

    move-result v0

    return v0
.end method

.method static enhance([BLjava/lang/String;)Llocal/mio/os4camerabridge/DocumentTextEnhancer$Result;
    .locals 2
    .param p0, "sourceJpeg"    # [B
    .param p1, "moduleApkPath"    # Ljava/lang/String;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/lang/Exception;
        }
    .end annotation

    .line 52
    sget-object v0, Llocal/mio/os4camerabridge/DocumentTextEnhancer;->LOCK:Ljava/lang/Object;

    monitor-enter v0

    .line 53
    :try_start_0
    invoke-static {p0, p1}, Llocal/mio/os4camerabridge/DocumentTextEnhancer;->enhanceLocked([BLjava/lang/String;)Llocal/mio/os4camerabridge/DocumentTextEnhancer$Result;

    move-result-object v1

    monitor-exit v0

    return-object v1

    .line 54
    :catchall_0
    move-exception v1

    monitor-exit v0
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    throw v1
.end method

.method private static enhanceLocked([BLjava/lang/String;)Llocal/mio/os4camerabridge/DocumentTextEnhancer$Result;
    .locals 45
    .param p0, "sourceJpeg"    # [B
    .param p1, "moduleApkPath"    # Ljava/lang/String;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/lang/Exception;
        }
    .end annotation

    .line 59
    move-object/from16 v1, p0

    invoke-static {}, Landroid/os/SystemClock;->elapsedRealtime()J

    move-result-wide v2

    .line 60
    .local v2, "started":J
    if-eqz p1, :cond_11

    invoke-virtual/range {p1 .. p1}, Ljava/lang/String;->isEmpty()Z

    move-result v0

    if-nez v0, :cond_11

    .line 64
    new-instance v0, Landroid/graphics/BitmapFactory$Options;

    invoke-direct {v0}, Landroid/graphics/BitmapFactory$Options;-><init>()V

    move-object v4, v0

    .line 65
    .local v4, "decodeOptions":Landroid/graphics/BitmapFactory$Options;
    sget-object v0, Landroid/graphics/Bitmap$Config;->ARGB_8888:Landroid/graphics/Bitmap$Config;

    iput-object v0, v4, Landroid/graphics/BitmapFactory$Options;->inPreferredConfig:Landroid/graphics/Bitmap$Config;

    .line 66
    const/4 v0, 0x1

    iput-boolean v0, v4, Landroid/graphics/BitmapFactory$Options;->inMutable:Z

    .line 67
    array-length v5, v1

    const/4 v6, 0x0

    invoke-static {v1, v6, v5, v4}, Landroid/graphics/BitmapFactory;->decodeByteArray([BIILandroid/graphics/BitmapFactory$Options;)Landroid/graphics/Bitmap;

    move-result-object v7

    .line 69
    .local v7, "full":Landroid/graphics/Bitmap;
    if-eqz v7, :cond_10

    .line 72
    invoke-virtual {v7}, Landroid/graphics/Bitmap;->getWidth()I

    move-result v10

    .line 73
    .local v10, "fullWidth":I
    invoke-virtual {v7}, Landroid/graphics/Bitmap;->getHeight()I

    move-result v14

    .line 74
    .local v14, "fullHeight":I
    int-to-long v8, v10

    int-to-long v11, v14

    mul-long v15, v8, v11

    .line 75
    .local v15, "fullPixelCount":J
    const/16 v5, 0x40

    if-lt v10, v5, :cond_f

    if-lt v14, v5, :cond_f

    const-wide/32 v8, 0x2faf080

    cmp-long v5, v15, v8

    if-gtz v5, :cond_f

    .line 82
    const/4 v5, 0x0

    .line 83
    .local v5, "scaled":Landroid/graphics/Bitmap;
    const/4 v8, 0x0

    .line 85
    .local v8, "interpreter":Lorg/tensorflow/lite/Interpreter;
    const/16 v9, 0x620

    const/16 v11, 0x840

    :try_start_0
    invoke-static {v7, v11, v9, v0}, Landroid/graphics/Bitmap;->createScaledBitmap(Landroid/graphics/Bitmap;IIZ)Landroid/graphics/Bitmap;

    move-result-object v12
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_c

    move-object/from16 v17, v12

    .line 87
    .end local v5    # "scaled":Landroid/graphics/Bitmap;
    .local v17, "scaled":Landroid/graphics/Bitmap;
    const v5, 0x328800

    :try_start_1
    new-array v12, v5, [I

    move-object/from16 v18, v12

    .line 88
    .local v18, "modelPixels":[I
    const/16 v23, 0x840

    const/16 v24, 0x620

    const/16 v19, 0x0

    const/16 v20, 0x840

    const/16 v21, 0x0

    const/16 v22, 0x0

    invoke-virtual/range {v17 .. v24}, Landroid/graphics/Bitmap;->getPixels([IIIIIII)V
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_b

    move-object/from16 v12, v17

    move-object/from16 v13, v18

    .line 90
    .end local v17    # "scaled":Landroid/graphics/Bitmap;
    .end local v18    # "modelPixels":[I
    .local v12, "scaled":Landroid/graphics/Bitmap;
    .local v13, "modelPixels":[I
    if-eq v12, v7, :cond_0

    .line 91
    :try_start_2
    invoke-virtual {v12}, Landroid/graphics/Bitmap;->recycle()V
    :try_end_2
    .catchall {:try_start_2 .. :try_end_2} :catchall_0

    .line 92
    const/4 v12, 0x0

    goto :goto_0

    .line 179
    .end local v13    # "modelPixels":[I
    :catchall_0
    move-exception v0

    move-wide/from16 v23, v2

    move-object/from16 v27, v4

    move-object v5, v12

    goto/16 :goto_4

    .line 95
    .restart local v13    # "modelPixels":[I
    :cond_0
    :goto_0
    :try_start_3
    new-array v0, v5, [B

    .line 96
    .local v0, "inputLuma":[B
    invoke-static {v5}, Ljava/nio/ByteBuffer;->allocateDirect(I)Ljava/nio/ByteBuffer;

    move-result-object v9

    .line 97
    invoke-static {}, Ljava/nio/ByteOrder;->nativeOrder()Ljava/nio/ByteOrder;

    move-result-object v11

    invoke-virtual {v9, v11}, Ljava/nio/ByteBuffer;->order(Ljava/nio/ByteOrder;)Ljava/nio/ByteBuffer;

    move-result-object v9
    :try_end_3
    .catchall {:try_start_3 .. :try_end_3} :catchall_a

    .line 98
    .local v9, "input":Ljava/nio/ByteBuffer;
    const/4 v11, 0x0

    .local v11, "index":I
    :goto_1
    if-ge v11, v5, :cond_1

    .line 99
    :try_start_4
    aget v20, v13, v11
    :try_end_4
    .catchall {:try_start_4 .. :try_end_4} :catchall_2

    move/from16 v21, v20

    .line 100
    .local v21, "color":I
    move/from16 v20, v5

    ushr-int/lit8 v5, v21, 0x10

    and-int/lit16 v5, v5, 0xff

    mul-int/lit8 v5, v5, 0x4d

    ushr-int/lit8 v6, v21, 0x8

    and-int/lit16 v6, v6, 0xff

    mul-int/lit16 v6, v6, 0x96

    add-int/2addr v5, v6

    move-wide/from16 v23, v2

    move/from16 v6, v21

    .end local v2    # "started":J
    .end local v21    # "color":I
    .local v6, "color":I
    .local v23, "started":J
    and-int/lit16 v2, v6, 0xff

    mul-int/lit8 v2, v2, 0x1d

    add-int/2addr v5, v2

    add-int/lit16 v5, v5, 0x80

    ushr-int/lit8 v2, v5, 0x8

    .line 103
    .local v2, "luma":I
    int-to-byte v3, v2

    :try_start_5
    aput-byte v3, v0, v11

    .line 104
    int-to-byte v3, v2

    invoke-virtual {v9, v3}, Ljava/nio/ByteBuffer;->put(B)Ljava/nio/ByteBuffer;
    :try_end_5
    .catchall {:try_start_5 .. :try_end_5} :catchall_1

    .line 98
    nop

    .end local v2    # "luma":I
    .end local v6    # "color":I
    add-int/lit8 v11, v11, 0x1

    move/from16 v5, v20

    move-wide/from16 v2, v23

    const/4 v6, 0x0

    goto :goto_1

    .line 179
    .end local v0    # "inputLuma":[B
    .end local v9    # "input":Ljava/nio/ByteBuffer;
    .end local v11    # "index":I
    .end local v13    # "modelPixels":[I
    :catchall_1
    move-exception v0

    move-object/from16 v27, v4

    move-object v5, v12

    goto/16 :goto_4

    .end local v23    # "started":J
    .local v2, "started":J
    :catchall_2
    move-exception v0

    move-wide/from16 v23, v2

    move-object/from16 v27, v4

    move-object v5, v12

    .end local v2    # "started":J
    .restart local v23    # "started":J
    goto/16 :goto_4

    .line 98
    .end local v23    # "started":J
    .restart local v0    # "inputLuma":[B
    .restart local v2    # "started":J
    .restart local v9    # "input":Ljava/nio/ByteBuffer;
    .restart local v11    # "index":I
    .restart local v13    # "modelPixels":[I
    :cond_1
    move-wide/from16 v23, v2

    move/from16 v20, v5

    .line 106
    .end local v2    # "started":J
    .end local v11    # "index":I
    .restart local v23    # "started":J
    const/4 v2, 0x0

    :try_start_6
    invoke-static {v13, v2}, Ljava/util/Arrays;->fill([II)V

    .line 107
    const/4 v2, 0x0

    .line 108
    .end local v13    # "modelPixels":[I
    .local v2, "modelPixels":[I
    invoke-virtual {v9}, Ljava/nio/ByteBuffer;->rewind()Ljava/nio/Buffer;

    .line 110
    invoke-static/range {p1 .. p1}, Llocal/mio/os4camerabridge/DocumentTextEnhancer;->ensureNativeRuntimeLoaded(Ljava/lang/String;)V

    .line 111
    invoke-static/range {p1 .. p1}, Llocal/mio/os4camerabridge/DocumentTextEnhancer;->loadModel(Ljava/lang/String;)Ljava/nio/ByteBuffer;

    move-result-object v3

    .line 112
    .local v3, "model":Ljava/nio/ByteBuffer;
    new-instance v5, Lorg/tensorflow/lite/Interpreter$Options;

    invoke-direct {v5}, Lorg/tensorflow/lite/Interpreter$Options;-><init>()V

    .line 113
    const/4 v6, 0x2

    invoke-virtual {v5, v6}, Lorg/tensorflow/lite/Interpreter$Options;->setNumThreads(I)Lorg/tensorflow/lite/Interpreter$Options;

    move-result-object v5

    .line 114
    .local v5, "interpreterOptions":Lorg/tensorflow/lite/Interpreter$Options;
    new-instance v11, Lorg/tensorflow/lite/Interpreter;

    invoke-direct {v11, v3, v5}, Lorg/tensorflow/lite/Interpreter;-><init>(Ljava/nio/ByteBuffer;Lorg/tensorflow/lite/Interpreter$Options;)V
    :try_end_6
    .catchall {:try_start_6 .. :try_end_6} :catchall_9

    move-object v8, v11

    .line 115
    const/4 v11, 0x0

    :try_start_7
    invoke-virtual {v8, v11}, Lorg/tensorflow/lite/Interpreter;->getInputTensor(I)Lorg/tensorflow/lite/Tensor;

    move-result-object v13

    invoke-interface {v13}, Lorg/tensorflow/lite/Tensor;->shape()[I

    move-result-object v13

    .line 116
    .local v13, "inputShape":[I
    invoke-virtual {v8, v11}, Lorg/tensorflow/lite/Interpreter;->getOutputTensor(I)Lorg/tensorflow/lite/Tensor;

    move-result-object v21

    invoke-interface/range {v21 .. v21}, Lorg/tensorflow/lite/Tensor;->shape()[I

    move-result-object v11
    :try_end_7
    .catchall {:try_start_7 .. :try_end_7} :catchall_8

    .line 117
    .local v11, "outputShape":[I
    move-object/from16 v25, v2

    move-object/from16 v26, v3

    move-object/from16 v27, v4

    const/16 v2, 0x840

    const/4 v3, 0x1

    const/16 v6, 0x620

    .end local v2    # "modelPixels":[I
    .end local v3    # "model":Ljava/nio/ByteBuffer;
    .end local v4    # "decodeOptions":Landroid/graphics/BitmapFactory$Options;
    .local v25, "modelPixels":[I
    .local v26, "model":Ljava/nio/ByteBuffer;
    .local v27, "decodeOptions":Landroid/graphics/BitmapFactory$Options;
    :try_start_8
    filled-new-array {v3, v6, v2, v3}, [I

    move-result-object v4

    invoke-static {v13, v4}, Ljava/util/Arrays;->equals([I[I)Z

    move-result v2

    if-eqz v2, :cond_b

    const/16 v2, 0x840

    const/4 v3, 0x1

    const/16 v6, 0x620

    filled-new-array {v3, v6, v2, v3}, [I

    move-result-object v2

    .line 119
    invoke-static {v11, v2}, Ljava/util/Arrays;->equals([I[I)Z

    move-result v2

    if-eqz v2, :cond_a

    .line 121
    const/4 v2, 0x0

    invoke-virtual {v8, v2}, Lorg/tensorflow/lite/Interpreter;->getInputTensor(I)Lorg/tensorflow/lite/Tensor;

    move-result-object v3

    invoke-interface {v3}, Lorg/tensorflow/lite/Tensor;->dataType()Lorg/tensorflow/lite/DataType;

    move-result-object v2

    sget-object v3, Lorg/tensorflow/lite/DataType;->UINT8:Lorg/tensorflow/lite/DataType;

    if-ne v2, v3, :cond_9

    .line 123
    const/4 v2, 0x0

    invoke-virtual {v8, v2}, Lorg/tensorflow/lite/Interpreter;->getOutputTensor(I)Lorg/tensorflow/lite/Tensor;

    move-result-object v3

    invoke-interface {v3}, Lorg/tensorflow/lite/Tensor;->dataType()Lorg/tensorflow/lite/DataType;

    move-result-object v2

    sget-object v3, Lorg/tensorflow/lite/DataType;->UINT8:Lorg/tensorflow/lite/DataType;

    if-ne v2, v3, :cond_8

    .line 130
    invoke-static/range {v20 .. v20}, Ljava/nio/ByteBuffer;->allocateDirect(I)Ljava/nio/ByteBuffer;

    move-result-object v2

    .line 131
    invoke-static {}, Ljava/nio/ByteOrder;->nativeOrder()Ljava/nio/ByteOrder;

    move-result-object v3

    invoke-virtual {v2, v3}, Ljava/nio/ByteBuffer;->order(Ljava/nio/ByteOrder;)Ljava/nio/ByteBuffer;

    move-result-object v2

    .line 132
    .local v2, "output":Ljava/nio/ByteBuffer;
    invoke-static {}, Landroid/os/SystemClock;->elapsedRealtime()J

    move-result-wide v3

    .line 133
    .local v3, "inferenceStarted":J
    invoke-virtual {v8, v9, v2}, Lorg/tensorflow/lite/Interpreter;->run(Ljava/lang/Object;Ljava/lang/Object;)V

    .line 134
    invoke-static {}, Landroid/os/SystemClock;->elapsedRealtime()J

    move-result-wide v18

    sub-long v30, v18, v3

    .line 136
    .local v30, "inferenceMs":J
    invoke-virtual {v2}, Ljava/nio/ByteBuffer;->rewind()Ljava/nio/Buffer;

    .line 137
    move-wide/from16 v18, v3

    move/from16 v6, v20

    .end local v3    # "inferenceStarted":J
    .local v18, "inferenceStarted":J
    new-array v3, v6, [B

    .line 138
    .local v3, "outputLuma":[B
    invoke-virtual {v2, v3}, Ljava/nio/ByteBuffer;->get([B)Ljava/nio/ByteBuffer;
    :try_end_8
    .catchall {:try_start_8 .. :try_end_8} :catchall_7

    .line 140
    const-wide/16 v28, 0x0

    .line 141
    .local v28, "deltaTotal":J
    const/4 v4, 0x0

    .line 142
    .local v4, "maxDelta":I
    const/4 v6, 0x0

    .line 143
    .local v6, "changedPixels":I
    const/16 v32, 0x0

    move-object/from16 v38, v2

    move/from16 v37, v6

    move v6, v10

    move/from16 v2, v32

    move-wide/from16 v43, v28

    move-object/from16 v28, v9

    move-wide/from16 v9, v43

    .end local v10    # "fullWidth":I
    .local v2, "index":I
    .local v6, "fullWidth":I
    .local v9, "deltaTotal":J
    .local v28, "input":Ljava/nio/ByteBuffer;
    .local v37, "changedPixels":I
    .local v38, "output":Ljava/nio/ByteBuffer;
    :goto_2
    move-object/from16 v39, v5

    const v5, 0x328800

    .end local v5    # "interpreterOptions":Lorg/tensorflow/lite/Interpreter$Options;
    .local v39, "interpreterOptions":Lorg/tensorflow/lite/Interpreter$Options;
    if-ge v2, v5, :cond_3

    .line 144
    :try_start_9
    aget-byte v5, v3, v2

    and-int/lit16 v5, v5, 0xff

    move/from16 v29, v2

    .end local v2    # "index":I
    .local v29, "index":I
    aget-byte v2, v0, v29

    and-int/lit16 v2, v2, 0xff

    sub-int/2addr v5, v2

    .line 146
    .local v5, "delta":I
    invoke-static {v5}, Ljava/lang/Math;->abs(I)I

    move-result v2
    :try_end_9
    .catchall {:try_start_9 .. :try_end_9} :catchall_4

    .line 147
    .local v2, "absolute":I
    move/from16 v33, v5

    move/from16 v32, v6

    .end local v5    # "delta":I
    .end local v6    # "fullWidth":I
    .local v32, "fullWidth":I
    .local v33, "delta":I
    int-to-long v5, v2

    add-long/2addr v9, v5

    .line 148
    :try_start_a
    invoke-static {v4, v2}, Ljava/lang/Math;->max(II)I

    move-result v5
    :try_end_a
    .catchall {:try_start_a .. :try_end_a} :catchall_3

    move v4, v5

    .line 149
    const/4 v5, 0x2

    if-lt v2, v5, :cond_2

    .line 150
    add-int/lit8 v37, v37, 0x1

    .line 143
    .end local v2    # "absolute":I
    .end local v33    # "delta":I
    :cond_2
    add-int/lit8 v2, v29, 0x1

    move/from16 v6, v32

    move-object/from16 v5, v39

    .end local v29    # "index":I
    .local v2, "index":I
    goto :goto_2

    .line 179
    .end local v0    # "inputLuma":[B
    .end local v2    # "index":I
    .end local v3    # "outputLuma":[B
    .end local v4    # "maxDelta":I
    .end local v9    # "deltaTotal":J
    .end local v11    # "outputShape":[I
    .end local v13    # "inputShape":[I
    .end local v18    # "inferenceStarted":J
    .end local v25    # "modelPixels":[I
    .end local v26    # "model":Ljava/nio/ByteBuffer;
    .end local v28    # "input":Ljava/nio/ByteBuffer;
    .end local v30    # "inferenceMs":J
    .end local v37    # "changedPixels":I
    .end local v38    # "output":Ljava/nio/ByteBuffer;
    .end local v39    # "interpreterOptions":Lorg/tensorflow/lite/Interpreter$Options;
    :catchall_3
    move-exception v0

    move-object v5, v12

    move/from16 v10, v32

    goto/16 :goto_4

    .end local v32    # "fullWidth":I
    .restart local v6    # "fullWidth":I
    :catchall_4
    move-exception v0

    move/from16 v32, v6

    move-object v5, v12

    move/from16 v10, v32

    .end local v6    # "fullWidth":I
    .restart local v32    # "fullWidth":I
    goto/16 :goto_4

    .line 143
    .end local v32    # "fullWidth":I
    .restart local v0    # "inputLuma":[B
    .restart local v2    # "index":I
    .restart local v3    # "outputLuma":[B
    .restart local v4    # "maxDelta":I
    .restart local v6    # "fullWidth":I
    .restart local v9    # "deltaTotal":J
    .restart local v11    # "outputShape":[I
    .restart local v13    # "inputShape":[I
    .restart local v18    # "inferenceStarted":J
    .restart local v25    # "modelPixels":[I
    .restart local v26    # "model":Ljava/nio/ByteBuffer;
    .restart local v28    # "input":Ljava/nio/ByteBuffer;
    .restart local v30    # "inferenceMs":J
    .restart local v37    # "changedPixels":I
    .restart local v38    # "output":Ljava/nio/ByteBuffer;
    .restart local v39    # "interpreterOptions":Lorg/tensorflow/lite/Interpreter$Options;
    :cond_3
    move/from16 v29, v2

    move/from16 v32, v6

    .line 154
    .end local v2    # "index":I
    .end local v6    # "fullWidth":I
    .restart local v32    # "fullWidth":I
    :try_start_b
    invoke-static/range {v15 .. v16}, Ljava/lang/Math;->toIntExact(J)I

    move-result v2

    .line 155
    .local v2, "pixelCount":I
    new-array v5, v2, [I
    :try_end_b
    .catchall {:try_start_b .. :try_end_b} :catchall_5

    .line 156
    .local v5, "fullPixels":[I
    move-object v6, v11

    .end local v11    # "outputShape":[I
    .local v6, "outputShape":[I
    const/4 v11, 0x0

    move-object/from16 v20, v12

    .end local v12    # "scaled":Landroid/graphics/Bitmap;
    .local v20, "scaled":Landroid/graphics/Bitmap;
    const/4 v12, 0x0

    move-wide/from16 v33, v9

    .end local v9    # "deltaTotal":J
    .local v33, "deltaTotal":J
    const/4 v9, 0x0

    move-object v10, v13

    .end local v13    # "inputShape":[I
    .local v10, "inputShape":[I
    move/from16 v13, v32

    move/from16 v42, v2

    move/from16 v36, v4

    move-object/from16 v40, v6

    move-object v6, v8

    move-object/from16 v2, v20

    move-object/from16 v41, v28

    move-object v8, v5

    move-object/from16 v20, v10

    move/from16 v10, v32

    move-wide/from16 v4, v33

    .end local v5    # "fullPixels":[I
    .end local v28    # "input":Ljava/nio/ByteBuffer;
    .end local v32    # "fullWidth":I
    .end local v33    # "deltaTotal":J
    .local v2, "scaled":Landroid/graphics/Bitmap;
    .local v4, "deltaTotal":J
    .local v6, "interpreter":Lorg/tensorflow/lite/Interpreter;
    .local v8, "fullPixels":[I
    .local v10, "fullWidth":I
    .local v20, "inputShape":[I
    .local v36, "maxDelta":I
    .local v40, "outputShape":[I
    .local v41, "input":Ljava/nio/ByteBuffer;
    .local v42, "pixelCount":I
    :try_start_c
    invoke-virtual/range {v7 .. v14}, Landroid/graphics/Bitmap;->getPixels([IIIIIII)V

    .line 158
    invoke-static {v8, v10, v14, v0, v3}, Llocal/mio/os4camerabridge/DocumentTextEnhancer;->applyResidual([III[B[B)V

    .line 160
    const/4 v11, 0x0

    const/4 v12, 0x0

    const/4 v9, 0x0

    move v13, v10

    invoke-virtual/range {v7 .. v14}, Landroid/graphics/Bitmap;->setPixels([IIIIIII)V

    .line 162
    const/4 v11, 0x0

    invoke-static {v8, v11}, Ljava/util/Arrays;->fill([II)V

    .line 164
    new-instance v9, Ljava/io/ByteArrayOutputStream;

    array-length v11, v1

    const/16 v21, 0x2

    mul-int/lit8 v11, v11, 0x2

    .line 165
    const/high16 v12, 0x400000

    invoke-static {v11, v12}, Ljava/lang/Math;->max(II)I

    move-result v11

    invoke-direct {v9, v11}, Ljava/io/ByteArrayOutputStream;-><init>(I)V

    .line 166
    .local v9, "encoded":Ljava/io/ByteArrayOutputStream;
    sget-object v11, Landroid/graphics/Bitmap$CompressFormat;->JPEG:Landroid/graphics/Bitmap$CompressFormat;

    const/16 v12, 0x64

    invoke-virtual {v7, v11, v12, v9}, Landroid/graphics/Bitmap;->compress(Landroid/graphics/Bitmap$CompressFormat;ILjava/io/OutputStream;)Z

    move-result v11

    if-eqz v11, :cond_7

    .line 169
    invoke-virtual {v9}, Ljava/io/ByteArrayOutputStream;->toByteArray()[B

    move-result-object v29

    move-object/from16 v11, v29

    .line 170
    .local v11, "jpeg":[B
    array-length v12, v11

    const/4 v13, 0x4

    if-lt v12, v13, :cond_6

    const/16 v22, 0x0

    aget-byte v12, v11, v22

    const/4 v13, -0x1

    if-ne v12, v13, :cond_6

    const/16 v17, 0x1

    aget-byte v12, v11, v17

    const/16 v13, -0x28

    if-ne v12, v13, :cond_6

    .line 174
    new-instance v28, Llocal/mio/os4camerabridge/DocumentTextEnhancer$Result;

    .line 175
    invoke-static {}, Landroid/os/SystemClock;->elapsedRealtime()J

    move-result-wide v12

    sub-long v32, v12, v23

    long-to-double v12, v4

    const-wide v21, 0x4149440000000000L    # 3311616.0

    div-double v34, v12, v21

    move-object/from16 v29, v11

    .end local v11    # "jpeg":[B
    .local v29, "jpeg":[B
    invoke-direct/range {v28 .. v37}, Llocal/mio/os4camerabridge/DocumentTextEnhancer$Result;-><init>([BJJDII)V
    :try_end_c
    .catchall {:try_start_c .. :try_end_c} :catchall_6

    .line 179
    nop

    .line 180
    invoke-virtual {v6}, Lorg/tensorflow/lite/Interpreter;->close()V

    .line 182
    if-eqz v2, :cond_4

    if-eq v2, v7, :cond_4

    invoke-virtual {v2}, Landroid/graphics/Bitmap;->isRecycled()Z

    move-result v11

    if-nez v11, :cond_4

    .line 183
    invoke-virtual {v2}, Landroid/graphics/Bitmap;->recycle()V

    .line 185
    :cond_4
    invoke-virtual {v7}, Landroid/graphics/Bitmap;->isRecycled()Z

    move-result v11

    if-nez v11, :cond_5

    .line 186
    invoke-virtual {v7}, Landroid/graphics/Bitmap;->recycle()V

    .line 174
    :cond_5
    return-object v28

    .line 170
    .end local v29    # "jpeg":[B
    .restart local v11    # "jpeg":[B
    :cond_6
    move-object/from16 v29, v11

    .line 172
    .end local v11    # "jpeg":[B
    .restart local v29    # "jpeg":[B
    :try_start_d
    new-instance v11, Ljava/lang/IllegalStateException;

    const-string v12, "document JPEG output invalid"

    invoke-direct {v11, v12}, Ljava/lang/IllegalStateException;-><init>(Ljava/lang/String;)V

    .end local v2    # "scaled":Landroid/graphics/Bitmap;
    .end local v6    # "interpreter":Lorg/tensorflow/lite/Interpreter;
    .end local v7    # "full":Landroid/graphics/Bitmap;
    .end local v10    # "fullWidth":I
    .end local v14    # "fullHeight":I
    .end local v15    # "fullPixelCount":J
    .end local v23    # "started":J
    .end local v27    # "decodeOptions":Landroid/graphics/BitmapFactory$Options;
    .end local p0    # "sourceJpeg":[B
    .end local p1    # "moduleApkPath":Ljava/lang/String;
    throw v11

    .line 167
    .end local v29    # "jpeg":[B
    .restart local v2    # "scaled":Landroid/graphics/Bitmap;
    .restart local v6    # "interpreter":Lorg/tensorflow/lite/Interpreter;
    .restart local v7    # "full":Landroid/graphics/Bitmap;
    .restart local v10    # "fullWidth":I
    .restart local v14    # "fullHeight":I
    .restart local v15    # "fullPixelCount":J
    .restart local v23    # "started":J
    .restart local v27    # "decodeOptions":Landroid/graphics/BitmapFactory$Options;
    .restart local p0    # "sourceJpeg":[B
    .restart local p1    # "moduleApkPath":Ljava/lang/String;
    :cond_7
    new-instance v11, Ljava/lang/IllegalStateException;

    const-string v12, "document JPEG encode failed"

    invoke-direct {v11, v12}, Ljava/lang/IllegalStateException;-><init>(Ljava/lang/String;)V

    .end local v2    # "scaled":Landroid/graphics/Bitmap;
    .end local v6    # "interpreter":Lorg/tensorflow/lite/Interpreter;
    .end local v7    # "full":Landroid/graphics/Bitmap;
    .end local v10    # "fullWidth":I
    .end local v14    # "fullHeight":I
    .end local v15    # "fullPixelCount":J
    .end local v23    # "started":J
    .end local v27    # "decodeOptions":Landroid/graphics/BitmapFactory$Options;
    .end local p0    # "sourceJpeg":[B
    .end local p1    # "moduleApkPath":Ljava/lang/String;
    throw v11

    .line 179
    .end local v0    # "inputLuma":[B
    .end local v3    # "outputLuma":[B
    .end local v4    # "deltaTotal":J
    .end local v9    # "encoded":Ljava/io/ByteArrayOutputStream;
    .end local v18    # "inferenceStarted":J
    .end local v20    # "inputShape":[I
    .end local v25    # "modelPixels":[I
    .end local v26    # "model":Ljava/nio/ByteBuffer;
    .end local v30    # "inferenceMs":J
    .end local v36    # "maxDelta":I
    .end local v37    # "changedPixels":I
    .end local v38    # "output":Ljava/nio/ByteBuffer;
    .end local v39    # "interpreterOptions":Lorg/tensorflow/lite/Interpreter$Options;
    .end local v40    # "outputShape":[I
    .end local v41    # "input":Ljava/nio/ByteBuffer;
    .end local v42    # "pixelCount":I
    .restart local v7    # "full":Landroid/graphics/Bitmap;
    .local v8, "interpreter":Lorg/tensorflow/lite/Interpreter;
    .restart local v12    # "scaled":Landroid/graphics/Bitmap;
    .restart local v14    # "fullHeight":I
    .restart local v15    # "fullPixelCount":J
    .restart local v23    # "started":J
    .restart local v27    # "decodeOptions":Landroid/graphics/BitmapFactory$Options;
    .restart local v32    # "fullWidth":I
    .restart local p0    # "sourceJpeg":[B
    .restart local p1    # "moduleApkPath":Ljava/lang/String;
    :catchall_5
    move-exception v0

    move-object v6, v8

    move-object v2, v12

    move/from16 v10, v32

    move-object v5, v2

    .end local v8    # "interpreter":Lorg/tensorflow/lite/Interpreter;
    .end local v12    # "scaled":Landroid/graphics/Bitmap;
    .end local v32    # "fullWidth":I
    .restart local v2    # "scaled":Landroid/graphics/Bitmap;
    .restart local v6    # "interpreter":Lorg/tensorflow/lite/Interpreter;
    .restart local v10    # "fullWidth":I
    goto/16 :goto_4

    .line 123
    .end local v2    # "scaled":Landroid/graphics/Bitmap;
    .end local v6    # "interpreter":Lorg/tensorflow/lite/Interpreter;
    .restart local v0    # "inputLuma":[B
    .local v5, "interpreterOptions":Lorg/tensorflow/lite/Interpreter$Options;
    .restart local v8    # "interpreter":Lorg/tensorflow/lite/Interpreter;
    .local v9, "input":Ljava/nio/ByteBuffer;
    .local v11, "outputShape":[I
    .restart local v12    # "scaled":Landroid/graphics/Bitmap;
    .restart local v13    # "inputShape":[I
    .restart local v25    # "modelPixels":[I
    .restart local v26    # "model":Ljava/nio/ByteBuffer;
    :cond_8
    move-object/from16 v39, v5

    move-object v6, v8

    move-object/from16 v41, v9

    move-object/from16 v40, v11

    move-object v2, v12

    move-object/from16 v20, v13

    .end local v5    # "interpreterOptions":Lorg/tensorflow/lite/Interpreter$Options;
    .end local v8    # "interpreter":Lorg/tensorflow/lite/Interpreter;
    .end local v9    # "input":Ljava/nio/ByteBuffer;
    .end local v11    # "outputShape":[I
    .end local v12    # "scaled":Landroid/graphics/Bitmap;
    .end local v13    # "inputShape":[I
    .restart local v2    # "scaled":Landroid/graphics/Bitmap;
    .restart local v6    # "interpreter":Lorg/tensorflow/lite/Interpreter;
    .restart local v20    # "inputShape":[I
    .restart local v39    # "interpreterOptions":Lorg/tensorflow/lite/Interpreter$Options;
    .restart local v40    # "outputShape":[I
    .restart local v41    # "input":Ljava/nio/ByteBuffer;
    goto :goto_3

    .line 121
    .end local v2    # "scaled":Landroid/graphics/Bitmap;
    .end local v6    # "interpreter":Lorg/tensorflow/lite/Interpreter;
    .end local v20    # "inputShape":[I
    .end local v39    # "interpreterOptions":Lorg/tensorflow/lite/Interpreter$Options;
    .end local v40    # "outputShape":[I
    .end local v41    # "input":Ljava/nio/ByteBuffer;
    .restart local v5    # "interpreterOptions":Lorg/tensorflow/lite/Interpreter$Options;
    .restart local v8    # "interpreter":Lorg/tensorflow/lite/Interpreter;
    .restart local v9    # "input":Ljava/nio/ByteBuffer;
    .restart local v11    # "outputShape":[I
    .restart local v12    # "scaled":Landroid/graphics/Bitmap;
    .restart local v13    # "inputShape":[I
    :cond_9
    move-object/from16 v39, v5

    move-object v6, v8

    move-object/from16 v41, v9

    move-object/from16 v40, v11

    move-object v2, v12

    move-object/from16 v20, v13

    .end local v5    # "interpreterOptions":Lorg/tensorflow/lite/Interpreter$Options;
    .end local v8    # "interpreter":Lorg/tensorflow/lite/Interpreter;
    .end local v9    # "input":Ljava/nio/ByteBuffer;
    .end local v11    # "outputShape":[I
    .end local v12    # "scaled":Landroid/graphics/Bitmap;
    .end local v13    # "inputShape":[I
    .restart local v2    # "scaled":Landroid/graphics/Bitmap;
    .restart local v6    # "interpreter":Lorg/tensorflow/lite/Interpreter;
    .restart local v20    # "inputShape":[I
    .restart local v39    # "interpreterOptions":Lorg/tensorflow/lite/Interpreter$Options;
    .restart local v40    # "outputShape":[I
    .restart local v41    # "input":Ljava/nio/ByteBuffer;
    goto :goto_3

    .line 119
    .end local v2    # "scaled":Landroid/graphics/Bitmap;
    .end local v6    # "interpreter":Lorg/tensorflow/lite/Interpreter;
    .end local v20    # "inputShape":[I
    .end local v39    # "interpreterOptions":Lorg/tensorflow/lite/Interpreter$Options;
    .end local v40    # "outputShape":[I
    .end local v41    # "input":Ljava/nio/ByteBuffer;
    .restart local v5    # "interpreterOptions":Lorg/tensorflow/lite/Interpreter$Options;
    .restart local v8    # "interpreter":Lorg/tensorflow/lite/Interpreter;
    .restart local v9    # "input":Ljava/nio/ByteBuffer;
    .restart local v11    # "outputShape":[I
    .restart local v12    # "scaled":Landroid/graphics/Bitmap;
    .restart local v13    # "inputShape":[I
    :cond_a
    move-object/from16 v39, v5

    move-object v6, v8

    move-object/from16 v41, v9

    move-object/from16 v40, v11

    move-object v2, v12

    move-object/from16 v20, v13

    .end local v5    # "interpreterOptions":Lorg/tensorflow/lite/Interpreter$Options;
    .end local v8    # "interpreter":Lorg/tensorflow/lite/Interpreter;
    .end local v9    # "input":Ljava/nio/ByteBuffer;
    .end local v11    # "outputShape":[I
    .end local v12    # "scaled":Landroid/graphics/Bitmap;
    .end local v13    # "inputShape":[I
    .restart local v2    # "scaled":Landroid/graphics/Bitmap;
    .restart local v6    # "interpreter":Lorg/tensorflow/lite/Interpreter;
    .restart local v20    # "inputShape":[I
    .restart local v39    # "interpreterOptions":Lorg/tensorflow/lite/Interpreter$Options;
    .restart local v40    # "outputShape":[I
    .restart local v41    # "input":Ljava/nio/ByteBuffer;
    goto :goto_3

    .line 117
    .end local v2    # "scaled":Landroid/graphics/Bitmap;
    .end local v6    # "interpreter":Lorg/tensorflow/lite/Interpreter;
    .end local v20    # "inputShape":[I
    .end local v39    # "interpreterOptions":Lorg/tensorflow/lite/Interpreter$Options;
    .end local v40    # "outputShape":[I
    .end local v41    # "input":Ljava/nio/ByteBuffer;
    .restart local v5    # "interpreterOptions":Lorg/tensorflow/lite/Interpreter$Options;
    .restart local v8    # "interpreter":Lorg/tensorflow/lite/Interpreter;
    .restart local v9    # "input":Ljava/nio/ByteBuffer;
    .restart local v11    # "outputShape":[I
    .restart local v12    # "scaled":Landroid/graphics/Bitmap;
    .restart local v13    # "inputShape":[I
    :cond_b
    move-object/from16 v39, v5

    move-object v6, v8

    move-object/from16 v41, v9

    move-object/from16 v40, v11

    move-object v2, v12

    move-object/from16 v20, v13

    .line 125
    .end local v5    # "interpreterOptions":Lorg/tensorflow/lite/Interpreter$Options;
    .end local v8    # "interpreter":Lorg/tensorflow/lite/Interpreter;
    .end local v9    # "input":Ljava/nio/ByteBuffer;
    .end local v11    # "outputShape":[I
    .end local v12    # "scaled":Landroid/graphics/Bitmap;
    .end local v13    # "inputShape":[I
    .restart local v2    # "scaled":Landroid/graphics/Bitmap;
    .restart local v6    # "interpreter":Lorg/tensorflow/lite/Interpreter;
    .restart local v20    # "inputShape":[I
    .restart local v39    # "interpreterOptions":Lorg/tensorflow/lite/Interpreter$Options;
    .restart local v40    # "outputShape":[I
    .restart local v41    # "input":Ljava/nio/ByteBuffer;
    :goto_3
    new-instance v3, Ljava/lang/IllegalStateException;

    new-instance v4, Ljava/lang/StringBuilder;

    invoke-direct {v4}, Ljava/lang/StringBuilder;-><init>()V

    const-string v5, "unexpected model tensors in="

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    .line 126
    invoke-static/range {v20 .. v20}, Ljava/util/Arrays;->toString([I)Ljava/lang/String;

    move-result-object v5

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    const-string v5, " out="

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    .line 127
    invoke-static/range {v40 .. v40}, Ljava/util/Arrays;->toString([I)Ljava/lang/String;

    move-result-object v5

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v4

    invoke-direct {v3, v4}, Ljava/lang/IllegalStateException;-><init>(Ljava/lang/String;)V

    .end local v2    # "scaled":Landroid/graphics/Bitmap;
    .end local v6    # "interpreter":Lorg/tensorflow/lite/Interpreter;
    .end local v7    # "full":Landroid/graphics/Bitmap;
    .end local v10    # "fullWidth":I
    .end local v14    # "fullHeight":I
    .end local v15    # "fullPixelCount":J
    .end local v23    # "started":J
    .end local v27    # "decodeOptions":Landroid/graphics/BitmapFactory$Options;
    .end local p0    # "sourceJpeg":[B
    .end local p1    # "moduleApkPath":Ljava/lang/String;
    throw v3
    :try_end_d
    .catchall {:try_start_d .. :try_end_d} :catchall_6

    .line 179
    .end local v0    # "inputLuma":[B
    .end local v20    # "inputShape":[I
    .end local v25    # "modelPixels":[I
    .end local v26    # "model":Ljava/nio/ByteBuffer;
    .end local v39    # "interpreterOptions":Lorg/tensorflow/lite/Interpreter$Options;
    .end local v40    # "outputShape":[I
    .end local v41    # "input":Ljava/nio/ByteBuffer;
    .restart local v2    # "scaled":Landroid/graphics/Bitmap;
    .restart local v6    # "interpreter":Lorg/tensorflow/lite/Interpreter;
    .restart local v7    # "full":Landroid/graphics/Bitmap;
    .restart local v10    # "fullWidth":I
    .restart local v14    # "fullHeight":I
    .restart local v15    # "fullPixelCount":J
    .restart local v23    # "started":J
    .restart local v27    # "decodeOptions":Landroid/graphics/BitmapFactory$Options;
    .restart local p0    # "sourceJpeg":[B
    .restart local p1    # "moduleApkPath":Ljava/lang/String;
    :catchall_6
    move-exception v0

    move-object v5, v2

    move-object v8, v6

    goto :goto_4

    .end local v2    # "scaled":Landroid/graphics/Bitmap;
    .end local v6    # "interpreter":Lorg/tensorflow/lite/Interpreter;
    .restart local v8    # "interpreter":Lorg/tensorflow/lite/Interpreter;
    .restart local v12    # "scaled":Landroid/graphics/Bitmap;
    :catchall_7
    move-exception v0

    move-object v6, v8

    move-object v2, v12

    move-object v5, v2

    .end local v8    # "interpreter":Lorg/tensorflow/lite/Interpreter;
    .end local v12    # "scaled":Landroid/graphics/Bitmap;
    .restart local v2    # "scaled":Landroid/graphics/Bitmap;
    .restart local v6    # "interpreter":Lorg/tensorflow/lite/Interpreter;
    goto :goto_4

    .end local v2    # "scaled":Landroid/graphics/Bitmap;
    .end local v6    # "interpreter":Lorg/tensorflow/lite/Interpreter;
    .end local v27    # "decodeOptions":Landroid/graphics/BitmapFactory$Options;
    .local v4, "decodeOptions":Landroid/graphics/BitmapFactory$Options;
    .restart local v8    # "interpreter":Lorg/tensorflow/lite/Interpreter;
    .restart local v12    # "scaled":Landroid/graphics/Bitmap;
    :catchall_8
    move-exception v0

    move-object/from16 v27, v4

    move-object v6, v8

    move-object v2, v12

    move-object v5, v2

    .end local v4    # "decodeOptions":Landroid/graphics/BitmapFactory$Options;
    .end local v8    # "interpreter":Lorg/tensorflow/lite/Interpreter;
    .end local v12    # "scaled":Landroid/graphics/Bitmap;
    .restart local v2    # "scaled":Landroid/graphics/Bitmap;
    .restart local v6    # "interpreter":Lorg/tensorflow/lite/Interpreter;
    .restart local v27    # "decodeOptions":Landroid/graphics/BitmapFactory$Options;
    goto :goto_4

    .end local v2    # "scaled":Landroid/graphics/Bitmap;
    .end local v6    # "interpreter":Lorg/tensorflow/lite/Interpreter;
    .end local v27    # "decodeOptions":Landroid/graphics/BitmapFactory$Options;
    .restart local v4    # "decodeOptions":Landroid/graphics/BitmapFactory$Options;
    .restart local v8    # "interpreter":Lorg/tensorflow/lite/Interpreter;
    .restart local v12    # "scaled":Landroid/graphics/Bitmap;
    :catchall_9
    move-exception v0

    move-object/from16 v27, v4

    move-object v2, v12

    move-object v5, v2

    .end local v4    # "decodeOptions":Landroid/graphics/BitmapFactory$Options;
    .end local v12    # "scaled":Landroid/graphics/Bitmap;
    .restart local v2    # "scaled":Landroid/graphics/Bitmap;
    .restart local v27    # "decodeOptions":Landroid/graphics/BitmapFactory$Options;
    goto :goto_4

    .end local v23    # "started":J
    .end local v27    # "decodeOptions":Landroid/graphics/BitmapFactory$Options;
    .local v2, "started":J
    .restart local v4    # "decodeOptions":Landroid/graphics/BitmapFactory$Options;
    .restart local v12    # "scaled":Landroid/graphics/Bitmap;
    :catchall_a
    move-exception v0

    move-wide/from16 v23, v2

    move-object/from16 v27, v4

    move-object v2, v12

    move-object v5, v2

    .end local v4    # "decodeOptions":Landroid/graphics/BitmapFactory$Options;
    .end local v12    # "scaled":Landroid/graphics/Bitmap;
    .local v2, "scaled":Landroid/graphics/Bitmap;
    .restart local v23    # "started":J
    .restart local v27    # "decodeOptions":Landroid/graphics/BitmapFactory$Options;
    goto :goto_4

    .end local v23    # "started":J
    .end local v27    # "decodeOptions":Landroid/graphics/BitmapFactory$Options;
    .local v2, "started":J
    .restart local v4    # "decodeOptions":Landroid/graphics/BitmapFactory$Options;
    .restart local v17    # "scaled":Landroid/graphics/Bitmap;
    :catchall_b
    move-exception v0

    move-wide/from16 v23, v2

    move-object/from16 v27, v4

    move-object/from16 v12, v17

    move-object v5, v12

    .end local v2    # "started":J
    .end local v4    # "decodeOptions":Landroid/graphics/BitmapFactory$Options;
    .end local v17    # "scaled":Landroid/graphics/Bitmap;
    .restart local v12    # "scaled":Landroid/graphics/Bitmap;
    .restart local v23    # "started":J
    .restart local v27    # "decodeOptions":Landroid/graphics/BitmapFactory$Options;
    goto :goto_4

    .end local v12    # "scaled":Landroid/graphics/Bitmap;
    .end local v23    # "started":J
    .end local v27    # "decodeOptions":Landroid/graphics/BitmapFactory$Options;
    .restart local v2    # "started":J
    .restart local v4    # "decodeOptions":Landroid/graphics/BitmapFactory$Options;
    .local v5, "scaled":Landroid/graphics/Bitmap;
    :catchall_c
    move-exception v0

    move-wide/from16 v23, v2

    move-object/from16 v27, v4

    .end local v2    # "started":J
    .end local v4    # "decodeOptions":Landroid/graphics/BitmapFactory$Options;
    .restart local v23    # "started":J
    .restart local v27    # "decodeOptions":Landroid/graphics/BitmapFactory$Options;
    :goto_4
    if-eqz v8, :cond_c

    .line 180
    invoke-virtual {v8}, Lorg/tensorflow/lite/Interpreter;->close()V

    .line 182
    :cond_c
    if-eqz v5, :cond_d

    if-eq v5, v7, :cond_d

    invoke-virtual {v5}, Landroid/graphics/Bitmap;->isRecycled()Z

    move-result v2

    if-nez v2, :cond_d

    .line 183
    invoke-virtual {v5}, Landroid/graphics/Bitmap;->recycle()V

    .line 185
    :cond_d
    invoke-virtual {v7}, Landroid/graphics/Bitmap;->isRecycled()Z

    move-result v2

    if-nez v2, :cond_e

    .line 186
    invoke-virtual {v7}, Landroid/graphics/Bitmap;->recycle()V

    .line 188
    :cond_e
    throw v0

    .line 75
    .end local v5    # "scaled":Landroid/graphics/Bitmap;
    .end local v8    # "interpreter":Lorg/tensorflow/lite/Interpreter;
    .end local v23    # "started":J
    .end local v27    # "decodeOptions":Landroid/graphics/BitmapFactory$Options;
    .restart local v2    # "started":J
    .restart local v4    # "decodeOptions":Landroid/graphics/BitmapFactory$Options;
    :cond_f
    move-wide/from16 v23, v2

    move-object/from16 v27, v4

    .line 77
    .end local v2    # "started":J
    .end local v4    # "decodeOptions":Landroid/graphics/BitmapFactory$Options;
    .restart local v23    # "started":J
    .restart local v27    # "decodeOptions":Landroid/graphics/BitmapFactory$Options;
    invoke-virtual {v7}, Landroid/graphics/Bitmap;->recycle()V

    .line 78
    new-instance v0, Ljava/lang/IllegalStateException;

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "unsupported document size "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, v10}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v2

    const-string v3, "x"

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, v14}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-direct {v0, v2}, Ljava/lang/IllegalStateException;-><init>(Ljava/lang/String;)V

    throw v0

    .line 70
    .end local v10    # "fullWidth":I
    .end local v14    # "fullHeight":I
    .end local v15    # "fullPixelCount":J
    .end local v23    # "started":J
    .end local v27    # "decodeOptions":Landroid/graphics/BitmapFactory$Options;
    .restart local v2    # "started":J
    .restart local v4    # "decodeOptions":Landroid/graphics/BitmapFactory$Options;
    :cond_10
    move-wide/from16 v23, v2

    .end local v2    # "started":J
    .restart local v23    # "started":J
    new-instance v0, Ljava/lang/IllegalStateException;

    const-string v2, "document JPEG decode failed"

    invoke-direct {v0, v2}, Ljava/lang/IllegalStateException;-><init>(Ljava/lang/String;)V

    throw v0

    .line 60
    .end local v4    # "decodeOptions":Landroid/graphics/BitmapFactory$Options;
    .end local v7    # "full":Landroid/graphics/Bitmap;
    .end local v23    # "started":J
    .restart local v2    # "started":J
    :cond_11
    move-wide/from16 v23, v2

    .line 61
    .end local v2    # "started":J
    .restart local v23    # "started":J
    new-instance v0, Ljava/lang/IllegalStateException;

    const-string v2, "module APK path is absent"

    invoke-direct {v0, v2}, Ljava/lang/IllegalStateException;-><init>(Ljava/lang/String;)V

    throw v0
.end method

.method private static ensureNativeRuntimeLoaded(Ljava/lang/String;)V
    .locals 7
    .param p0, "moduleApkPath"    # Ljava/lang/String;

    .line 271
    sget-boolean v0, Llocal/mio/os4camerabridge/DocumentTextEnhancer;->nativeRuntimeLoaded:Z

    if-eqz v0, :cond_0

    .line 272
    return-void

    .line 274
    :cond_0
    new-instance v0, Ljava/io/File;

    invoke-direct {v0, p0}, Ljava/io/File;-><init>(Ljava/lang/String;)V

    .line 275
    .local v0, "apk":Ljava/io/File;
    invoke-virtual {v0}, Ljava/io/File;->getParentFile()Ljava/io/File;

    move-result-object v1

    .line 276
    .local v1, "codeDirectory":Ljava/io/File;
    if-eqz v1, :cond_2

    .line 280
    new-instance v2, Ljava/io/File;

    new-instance v3, Ljava/io/File;

    const-string v4, "lib/arm64"

    invoke-direct {v3, v1, v4}, Ljava/io/File;-><init>(Ljava/io/File;Ljava/lang/String;)V

    const-string v4, "libtensorflowlite_jni.so"

    invoke-direct {v2, v3, v4}, Ljava/io/File;-><init>(Ljava/io/File;Ljava/lang/String;)V

    .line 282
    .local v2, "library":Ljava/io/File;
    invoke-virtual {v2}, Ljava/io/File;->isFile()Z

    move-result v3

    if-eqz v3, :cond_1

    invoke-virtual {v2}, Ljava/io/File;->length()J

    move-result-wide v3

    const-wide/16 v5, 0x0

    cmp-long v3, v3, v5

    if-eqz v3, :cond_1

    .line 286
    invoke-virtual {v2}, Ljava/io/File;->getAbsolutePath()Ljava/lang/String;

    move-result-object v3

    invoke-static {v3}, Ljava/lang/System;->load(Ljava/lang/String;)V

    .line 287
    const/4 v3, 0x1

    sput-boolean v3, Llocal/mio/os4camerabridge/DocumentTextEnhancer;->nativeRuntimeLoaded:Z

    .line 288
    return-void

    .line 283
    :cond_1
    new-instance v3, Ljava/lang/IllegalStateException;

    new-instance v4, Ljava/lang/StringBuilder;

    invoke-direct {v4}, Ljava/lang/StringBuilder;-><init>()V

    const-string v5, "module TFLite JNI missing "

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v4

    invoke-direct {v3, v4}, Ljava/lang/IllegalStateException;-><init>(Ljava/lang/String;)V

    throw v3

    .line 277
    .end local v2    # "library":Ljava/io/File;
    :cond_2
    new-instance v2, Ljava/lang/IllegalStateException;

    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    const-string v4, "invalid module APK path "

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3, p0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    invoke-direct {v2, v3}, Ljava/lang/IllegalStateException;-><init>(Ljava/lang/String;)V

    throw v2
.end method

.method private static loadModel(Ljava/lang/String;)Ljava/nio/ByteBuffer;
    .locals 8
    .param p0, "moduleApkPath"    # Ljava/lang/String;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/lang/Exception;
        }
    .end annotation

    .line 238
    new-instance v0, Ljava/util/zip/ZipFile;

    invoke-direct {v0, p0}, Ljava/util/zip/ZipFile;-><init>(Ljava/lang/String;)V

    .line 239
    .local v0, "apk":Ljava/util/zip/ZipFile;
    :try_start_0
    const-string v1, "assets/text_enhance_yuv_v1.tflite"

    invoke-virtual {v0, v1}, Ljava/util/zip/ZipFile;->getEntry(Ljava/lang/String;)Ljava/util/zip/ZipEntry;

    move-result-object v1

    .line 240
    .local v1, "entry":Ljava/util/zip/ZipEntry;
    if-eqz v1, :cond_4

    invoke-virtual {v1}, Ljava/util/zip/ZipEntry;->getSize()J

    move-result-wide v2

    const-wide/16 v4, 0x0

    cmp-long v2, v2, v4

    if-lez v2, :cond_4

    .line 241
    invoke-virtual {v1}, Ljava/util/zip/ZipEntry;->getSize()J

    move-result-wide v2

    const-wide/32 v4, 0x7fffffff

    cmp-long v2, v2, v4

    if-gtz v2, :cond_4

    .line 244
    invoke-virtual {v1}, Ljava/util/zip/ZipEntry;->getSize()J

    move-result-wide v2

    long-to-int v2, v2

    invoke-static {v2}, Ljava/nio/ByteBuffer;->allocateDirect(I)Ljava/nio/ByteBuffer;

    move-result-object v2

    .line 245
    invoke-static {}, Ljava/nio/ByteOrder;->nativeOrder()Ljava/nio/ByteOrder;

    move-result-object v3

    invoke-virtual {v2, v3}, Ljava/nio/ByteBuffer;->order(Ljava/nio/ByteOrder;)Ljava/nio/ByteBuffer;

    move-result-object v2

    .line 246
    .local v2, "buffer":Ljava/nio/ByteBuffer;
    invoke-virtual {v0, v1}, Ljava/util/zip/ZipFile;->getInputStream(Ljava/util/zip/ZipEntry;)Ljava/io/InputStream;

    move-result-object v3
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_2

    .line 247
    .local v3, "input":Ljava/io/InputStream;
    const/16 v4, 0x4000

    :try_start_1
    new-array v4, v4, [B

    .line 249
    .local v4, "chunk":[B
    :goto_0
    invoke-virtual {v3, v4}, Ljava/io/InputStream;->read([B)I

    move-result v5

    move v6, v5

    .local v6, "read":I
    const/4 v7, -0x1

    if-eq v5, v7, :cond_0

    .line 250
    const/4 v5, 0x0

    invoke-virtual {v2, v4, v5, v6}, Ljava/nio/ByteBuffer;->put([BII)Ljava/nio/ByteBuffer;
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    goto :goto_0

    .line 252
    .end local v4    # "chunk":[B
    .end local v6    # "read":I
    :cond_0
    if-eqz v3, :cond_1

    :try_start_2
    invoke-virtual {v3}, Ljava/io/InputStream;->close()V

    .line 253
    .end local v3    # "input":Ljava/io/InputStream;
    :cond_1
    invoke-virtual {v2}, Ljava/nio/ByteBuffer;->position()I

    move-result v3

    int-to-long v3, v3

    invoke-virtual {v1}, Ljava/util/zip/ZipEntry;->getSize()J

    move-result-wide v5

    cmp-long v3, v3, v5

    if-nez v3, :cond_2

    .line 257
    invoke-virtual {v2}, Ljava/nio/ByteBuffer;->rewind()Ljava/nio/Buffer;
    :try_end_2
    .catchall {:try_start_2 .. :try_end_2} :catchall_2

    .line 258
    nop

    .line 259
    invoke-virtual {v0}, Ljava/util/zip/ZipFile;->close()V

    .line 258
    return-object v2

    .line 254
    :cond_2
    :try_start_3
    new-instance v3, Ljava/lang/IllegalStateException;

    new-instance v4, Ljava/lang/StringBuilder;

    invoke-direct {v4}, Ljava/lang/StringBuilder;-><init>()V

    const-string v5, "short model read "

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    .line 255
    invoke-virtual {v2}, Ljava/nio/ByteBuffer;->position()I

    move-result v5

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v4

    const-string v5, "/"

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v1}, Ljava/util/zip/ZipEntry;->getSize()J

    move-result-wide v5

    invoke-virtual {v4, v5, v6}, Ljava/lang/StringBuilder;->append(J)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v4

    invoke-direct {v3, v4}, Ljava/lang/IllegalStateException;-><init>(Ljava/lang/String;)V

    .end local v0    # "apk":Ljava/util/zip/ZipFile;
    .end local p0    # "moduleApkPath":Ljava/lang/String;
    throw v3
    :try_end_3
    .catchall {:try_start_3 .. :try_end_3} :catchall_2

    .line 246
    .restart local v0    # "apk":Ljava/util/zip/ZipFile;
    .restart local v3    # "input":Ljava/io/InputStream;
    .restart local p0    # "moduleApkPath":Ljava/lang/String;
    :catchall_0
    move-exception v4

    if-eqz v3, :cond_3

    :try_start_4
    invoke-virtual {v3}, Ljava/io/InputStream;->close()V
    :try_end_4
    .catchall {:try_start_4 .. :try_end_4} :catchall_1

    goto :goto_1

    :catchall_1
    move-exception v5

    :try_start_5
    invoke-virtual {v4, v5}, Ljava/lang/Throwable;->addSuppressed(Ljava/lang/Throwable;)V

    .end local v0    # "apk":Ljava/util/zip/ZipFile;
    .end local p0    # "moduleApkPath":Ljava/lang/String;
    :cond_3
    :goto_1
    throw v4

    .line 242
    .end local v2    # "buffer":Ljava/nio/ByteBuffer;
    .end local v3    # "input":Ljava/io/InputStream;
    .restart local v0    # "apk":Ljava/util/zip/ZipFile;
    .restart local p0    # "moduleApkPath":Ljava/lang/String;
    :cond_4
    new-instance v2, Ljava/lang/IllegalStateException;

    const-string v3, "model asset missing"

    invoke-direct {v2, v3}, Ljava/lang/IllegalStateException;-><init>(Ljava/lang/String;)V

    .end local v0    # "apk":Ljava/util/zip/ZipFile;
    .end local p0    # "moduleApkPath":Ljava/lang/String;
    throw v2
    :try_end_5
    .catchall {:try_start_5 .. :try_end_5} :catchall_2

    .line 238
    .end local v1    # "entry":Ljava/util/zip/ZipEntry;
    .restart local v0    # "apk":Ljava/util/zip/ZipFile;
    .restart local p0    # "moduleApkPath":Ljava/lang/String;
    :catchall_2
    move-exception v1

    :try_start_6
    invoke-virtual {v0}, Ljava/util/zip/ZipFile;->close()V
    :try_end_6
    .catchall {:try_start_6 .. :try_end_6} :catchall_3

    goto :goto_2

    :catchall_3
    move-exception v2

    invoke-virtual {v1, v2}, Ljava/lang/Throwable;->addSuppressed(Ljava/lang/Throwable;)V

    :goto_2
    throw v1
.end method
