.class public final Llocal/mio/os4camerabridge/LegendaryProcessingProvider;
.super Landroid/content/ContentProvider;
.source "LegendaryProcessingProvider.java"


# static fields
.field public static final AUTHORITY:Ljava/lang/String; = "local.mio.os4camerabridge.legend"

.field public static final GAMMA:Ljava/lang/String; = "optional_aisp_gamma"

.field public static final MATRIX:Ljava/lang/String; = "optional_sensor_matrix"

.field public static final PREFS:Ljava/lang/String; = "legendary_processing"

.field private static final RENDER_LOCK:Ljava/lang/Object;

.field public static final URI:Landroid/net/Uri;

.field private static codecLoaded:Z

.field private static volatile lastStatus:Ljava/lang/String;

.field private static lastTiming:Ljava/lang/String;


# direct methods
.method static constructor <clinit>()V
    .locals 1

    .line 24
    const-string v0, "content://local.mio.os4camerabridge.legend"

    invoke-static {v0}, Landroid/net/Uri;->parse(Ljava/lang/String;)Landroid/net/Uri;

    move-result-object v0

    sput-object v0, Llocal/mio/os4camerabridge/LegendaryProcessingProvider;->URI:Landroid/net/Uri;

    .line 28
    new-instance v0, Ljava/lang/Object;

    invoke-direct {v0}, Ljava/lang/Object;-><init>()V

    sput-object v0, Llocal/mio/os4camerabridge/LegendaryProcessingProvider;->RENDER_LOCK:Ljava/lang/Object;

    .line 29
    const-string v0, "\u5c1a\u672a\u5904\u7406\u3002Gamma \u4ec5\u5728\u517c\u5bb9\u7684\u5c0f\u7c73 AISP \u63a5\u53e3\u5b58\u5728\u65f6\u751f\u6548\u3002"

    sput-object v0, Llocal/mio/os4camerabridge/LegendaryProcessingProvider;->lastStatus:Ljava/lang/String;

    .line 31
    const-string v0, "not measured"

    sput-object v0, Llocal/mio/os4camerabridge/LegendaryProcessingProvider;->lastTiming:Ljava/lang/String;

    return-void
.end method

.method public constructor <init>()V
    .locals 0

    .line 22
    invoke-direct {p0}, Landroid/content/ContentProvider;-><init>()V

    return-void
.end method

.method private checkCaller()V
    .locals 5

    .line 43
    invoke-static {}, Landroid/os/Binder;->getCallingUid()I

    move-result v0

    .line 44
    invoke-static {}, Landroid/os/Process;->myUid()I

    move-result v1

    if-eq v0, v1, :cond_3

    if-nez v0, :cond_0

    goto :goto_1

    .line 45
    :cond_0
    invoke-virtual {p0}, Llocal/mio/os4camerabridge/LegendaryProcessingProvider;->getContext()Landroid/content/Context;

    move-result-object v1

    invoke-virtual {v1}, Landroid/content/Context;->getPackageManager()Landroid/content/pm/PackageManager;

    move-result-object v1

    invoke-virtual {v1, v0}, Landroid/content/pm/PackageManager;->getPackagesForUid(I)[Ljava/lang/String;

    move-result-object v0

    .line 46
    if-eqz v0, :cond_2

    array-length v1, v0

    const/4 v2, 0x0

    :goto_0
    if-ge v2, v1, :cond_2

    aget-object v3, v0, v2

    const-string v4, "com.android.camera"

    invoke-virtual {v4, v3}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v3

    if-eqz v3, :cond_1

    return-void

    :cond_1
    add-int/lit8 v2, v2, 0x1

    goto :goto_0

    .line 47
    :cond_2
    new-instance v0, Ljava/lang/SecurityException;

    const-string v1, "Camera-only processing provider"

    invoke-direct {v0, v1}, Ljava/lang/SecurityException;-><init>(Ljava/lang/String;)V

    throw v0

    .line 44
    :cond_3
    :goto_1
    return-void
.end method

.method static grantCameraVisibility(Landroid/content/Context;)V
    .locals 3

    .line 36
    :try_start_0
    const-string v0, "com.android.camera"

    sget-object v1, Llocal/mio/os4camerabridge/LegendaryProcessingProvider;->URI:Landroid/net/Uri;

    const/16 v2, 0x41

    invoke-virtual {p0, v0, v1, v2}, Landroid/content/Context;->grantUriPermission(Ljava/lang/String;Landroid/net/Uri;I)V
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    .line 39
    goto :goto_0

    :catch_0
    move-exception p0

    const-string v0, "LegendaryNative"

    const-string v1, "Camera URI visibility grant unavailable"

    invoke-static {v0, v1, p0}, Landroid/util/Log;->w(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)I

    .line 40
    :goto_0
    return-void
.end method

.method private preferences()Landroid/content/SharedPreferences;
    .locals 3

    .line 41
    invoke-virtual {p0}, Llocal/mio/os4camerabridge/LegendaryProcessingProvider;->getContext()Landroid/content/Context;

    move-result-object v0

    const-string v1, "legendary_processing"

    const/4 v2, 0x0

    invoke-virtual {v0, v1, v2}, Landroid/content/Context;->getSharedPreferences(Ljava/lang/String;I)Landroid/content/SharedPreferences;

    move-result-object v0

    return-object v0
.end method

.method private static prepareModels(Landroid/content/Context;)Ljava/io/File;
    .locals 11
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .line 172
    new-instance v0, Ljava/io/File;

    invoke-virtual {p0}, Landroid/content/Context;->getNoBackupFilesDir()Ljava/io/File;

    move-result-object v1

    const-string v2, "legend_models_r1"

    invoke-direct {v0, v1, v2}, Ljava/io/File;-><init>(Ljava/io/File;Ljava/lang/String;)V

    .line 173
    invoke-virtual {v0}, Ljava/io/File;->isDirectory()Z

    move-result v1

    if-nez v1, :cond_1

    invoke-virtual {v0}, Ljava/io/File;->mkdirs()Z

    move-result v1

    if-eqz v1, :cond_0

    goto :goto_0

    :cond_0
    new-instance p0, Ljava/io/IOException;

    const-string v0, "Model directory unavailable"

    invoke-direct {p0, v0}, Ljava/io/IOException;-><init>(Ljava/lang/String;)V

    throw p0

    .line 174
    :cond_1
    :goto_0
    const-string v1, "styletrans_colorfix_v81_arch79.bin"

    const-string v2, "leica_m9s2_param.bin"

    const-string v3, "styletrans_low_v81_arch79.bin"

    const-string v4, "styletrans_high_v81_arch79.bin"

    filled-new-array {v3, v4, v1, v2}, [Ljava/lang/String;

    move-result-object v1

    .line 175
    const/4 v2, 0x4

    new-array v3, v2, [J

    fill-array-data v3, :array_0

    .line 176
    const/4 v4, 0x0

    :goto_1
    if-ge v4, v2, :cond_7

    .line 177
    new-instance v5, Ljava/io/File;

    aget-object v6, v1, v4

    invoke-direct {v5, v0, v6}, Ljava/io/File;-><init>(Ljava/io/File;Ljava/lang/String;)V

    .line 178
    invoke-virtual {v5}, Ljava/io/File;->length()J

    move-result-wide v6

    aget-wide v8, v3, v4

    cmp-long v6, v6, v8

    if-nez v6, :cond_2

    goto :goto_2

    .line 179
    :cond_2
    const-string v6, "model_"

    const-string v7, ".part"

    invoke-static {v6, v7, v0}, Ljava/io/File;->createTempFile(Ljava/lang/String;Ljava/lang/String;Ljava/io/File;)Ljava/io/File;

    move-result-object v6

    .line 181
    :try_start_0
    invoke-virtual {p0}, Landroid/content/Context;->getAssets()Landroid/content/res/AssetManager;

    move-result-object v7

    aget-object v8, v1, v4

    new-instance v9, Ljava/lang/StringBuilder;

    invoke-direct {v9}, Ljava/lang/StringBuilder;-><init>()V

    const-string v10, "legendary/models/"

    invoke-virtual {v9, v10}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v9

    invoke-virtual {v9, v8}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v8

    invoke-virtual {v8}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v8

    invoke-virtual {v7, v8}, Landroid/content/res/AssetManager;->open(Ljava/lang/String;)Ljava/io/InputStream;

    move-result-object v7
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_4

    .line 182
    :try_start_1
    new-instance v8, Ljava/io/FileOutputStream;

    invoke-direct {v8, v6}, Ljava/io/FileOutputStream;-><init>(Ljava/io/File;)V
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_2

    .line 183
    :try_start_2
    invoke-virtual {v7, v8}, Ljava/io/InputStream;->transferTo(Ljava/io/OutputStream;)J

    invoke-virtual {v8}, Ljava/io/FileOutputStream;->getFD()Ljava/io/FileDescriptor;

    move-result-object v9

    invoke-virtual {v9}, Ljava/io/FileDescriptor;->sync()V
    :try_end_2
    .catchall {:try_start_2 .. :try_end_2} :catchall_0

    .line 184
    :try_start_3
    invoke-virtual {v8}, Ljava/io/FileOutputStream;->close()V
    :try_end_3
    .catchall {:try_start_3 .. :try_end_3} :catchall_2

    if-eqz v7, :cond_3

    :try_start_4
    invoke-virtual {v7}, Ljava/io/InputStream;->close()V

    .line 185
    :cond_3
    invoke-virtual {v6}, Ljava/io/File;->length()J

    move-result-wide v7

    aget-wide v9, v3, v4

    cmp-long v7, v7, v9

    if-nez v7, :cond_5

    .line 186
    invoke-virtual {v6, v5}, Ljava/io/File;->renameTo(Ljava/io/File;)Z

    move-result v5
    :try_end_4
    .catchall {:try_start_4 .. :try_end_4} :catchall_4

    if-eqz v5, :cond_4

    .line 187
    invoke-virtual {v6}, Ljava/io/File;->delete()Z

    .line 176
    :goto_2
    add-int/lit8 v4, v4, 0x1

    goto :goto_1

    .line 186
    :cond_4
    :try_start_5
    new-instance p0, Ljava/io/IOException;

    const-string v0, "Model installation failed"

    invoke-direct {p0, v0}, Ljava/io/IOException;-><init>(Ljava/lang/String;)V

    throw p0

    .line 185
    :cond_5
    new-instance p0, Ljava/io/IOException;

    const-string v0, "Bundled model length mismatch"

    invoke-direct {p0, v0}, Ljava/io/IOException;-><init>(Ljava/lang/String;)V

    throw p0
    :try_end_5
    .catchall {:try_start_5 .. :try_end_5} :catchall_4

    .line 181
    :catchall_0
    move-exception p0

    :try_start_6
    invoke-virtual {v8}, Ljava/io/FileOutputStream;->close()V
    :try_end_6
    .catchall {:try_start_6 .. :try_end_6} :catchall_1

    goto :goto_3

    :catchall_1
    move-exception v0

    :try_start_7
    invoke-virtual {p0, v0}, Ljava/lang/Throwable;->addSuppressed(Ljava/lang/Throwable;)V

    :goto_3
    throw p0
    :try_end_7
    .catchall {:try_start_7 .. :try_end_7} :catchall_2

    :catchall_2
    move-exception p0

    if-eqz v7, :cond_6

    :try_start_8
    invoke-virtual {v7}, Ljava/io/InputStream;->close()V
    :try_end_8
    .catchall {:try_start_8 .. :try_end_8} :catchall_3

    goto :goto_4

    :catchall_3
    move-exception v0

    :try_start_9
    invoke-virtual {p0, v0}, Ljava/lang/Throwable;->addSuppressed(Ljava/lang/Throwable;)V

    :cond_6
    :goto_4
    throw p0
    :try_end_9
    .catchall {:try_start_9 .. :try_end_9} :catchall_4

    .line 187
    :catchall_4
    move-exception p0

    invoke-virtual {v6}, Ljava/io/File;->delete()Z

    throw p0

    .line 189
    :cond_7
    return-object v0

    nop

    :array_0
    .array-data 8
        0x98ab10
        0x97ab10
        0x802840
        0x19ba56
    .end array-data
.end method

.method private render(Landroid/os/Bundle;)J
    .locals 32
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/lang/Exception;
        }
    .end annotation

    .line 83
    move-object/from16 v0, p1

    invoke-static {}, Landroid/os/SystemClock;->elapsedRealtime()J

    move-result-wide v1

    .line 84
    const-string v3, "mode"

    invoke-virtual {v0, v3}, Landroid/os/Bundle;->getInt(Ljava/lang/String;)I

    move-result v3

    const-string v4, "lux"

    const/4 v5, -0x1

    invoke-virtual {v0, v4, v5}, Landroid/os/Bundle;->getInt(Ljava/lang/String;I)I

    move-result v4

    const-string v6, "cct"

    invoke-virtual {v0, v6, v5}, Landroid/os/Bundle;->getInt(Ljava/lang/String;I)I

    move-result v5

    .line 85
    const/4 v6, 0x1

    if-eq v3, v6, :cond_0

    const/4 v7, 0x2

    if-ne v3, v7, :cond_16

    :cond_0
    if-ltz v4, :cond_16

    const/16 v7, 0x5dc

    if-lt v5, v7, :cond_16

    const/16 v7, 0x4e20

    if-gt v5, v7, :cond_16

    .line 87
    const-string v7, "input"

    const-class v8, Landroid/os/ParcelFileDescriptor;

    invoke-virtual {v0, v7, v8}, Landroid/os/Bundle;->getParcelable(Ljava/lang/String;Ljava/lang/Class;)Ljava/lang/Object;

    move-result-object v7

    check-cast v7, Landroid/os/ParcelFileDescriptor;

    .line 88
    const-string v8, "output"

    const-class v9, Landroid/os/ParcelFileDescriptor;

    invoke-virtual {v0, v8, v9}, Landroid/os/Bundle;->getParcelable(Ljava/lang/String;Ljava/lang/Class;)Ljava/lang/Object;

    move-result-object v0

    move-object v8, v0

    check-cast v8, Landroid/os/ParcelFileDescriptor;

    .line 89
    if-eqz v7, :cond_15

    if-eqz v8, :cond_15

    .line 90
    invoke-virtual/range {p0 .. p0}, Llocal/mio/os4camerabridge/LegendaryProcessingProvider;->getContext()Landroid/content/Context;

    move-result-object v0

    .line 91
    new-instance v9, Ljava/io/File;

    invoke-virtual {v0}, Landroid/content/Context;->getApplicationInfo()Landroid/content/pm/ApplicationInfo;

    move-result-object v10

    iget-object v10, v10, Landroid/content/pm/ApplicationInfo;->nativeLibraryDir:Ljava/lang/String;

    invoke-direct {v9, v10}, Ljava/io/File;-><init>(Ljava/lang/String;)V

    .line 92
    invoke-static {v0}, Llocal/mio/os4camerabridge/LegendaryProcessingProvider;->prepareModels(Landroid/content/Context;)Ljava/io/File;

    move-result-object v10

    .line 93
    sget-boolean v11, Llocal/mio/os4camerabridge/LegendaryProcessingProvider;->codecLoaded:Z

    if-nez v11, :cond_1

    .line 94
    new-instance v11, Ljava/io/File;

    const-string v12, "liblegend_pixel_codec.so"

    invoke-direct {v11, v9, v12}, Ljava/io/File;-><init>(Ljava/io/File;Ljava/lang/String;)V

    invoke-virtual {v11}, Ljava/io/File;->getPath()Ljava/lang/String;

    move-result-object v11

    invoke-static {v11}, Ljava/lang/System;->load(Ljava/lang/String;)V

    .line 95
    sput-boolean v6, Llocal/mio/os4camerabridge/LegendaryProcessingProvider;->codecLoaded:Z

    .line 97
    :cond_1
    const-string v11, "legend_in_"

    invoke-virtual {v0}, Landroid/content/Context;->getCacheDir()Ljava/io/File;

    move-result-object v12

    const-string v13, ".nv12"

    invoke-static {v11, v13, v12}, Ljava/io/File;->createTempFile(Ljava/lang/String;Ljava/lang/String;Ljava/io/File;)Ljava/io/File;

    move-result-object v11

    .line 98
    const-string v12, "legend_out_"

    invoke-virtual {v0}, Landroid/content/Context;->getCacheDir()Ljava/io/File;

    move-result-object v14

    invoke-static {v12, v13, v14}, Ljava/io/File;->createTempFile(Ljava/lang/String;Ljava/lang/String;Ljava/io/File;)Ljava/io/File;

    move-result-object v12

    .line 99
    const-string v13, ".txt"

    invoke-virtual {v0}, Landroid/content/Context;->getCacheDir()Ljava/io/File;

    move-result-object v14

    const-string v15, "legend_worker_"

    invoke-static {v15, v13, v14}, Ljava/io/File;->createTempFile(Ljava/lang/String;Ljava/lang/String;Ljava/io/File;)Ljava/io/File;

    move-result-object v13

    .line 100
    invoke-static {}, Landroid/os/SystemClock;->elapsedRealtime()J

    move-result-wide v14

    .line 101
    nop

    .line 102
    nop

    .line 103
    :try_start_0
    new-instance v6, Landroid/graphics/BitmapFactory$Options;

    invoke-direct {v6}, Landroid/graphics/BitmapFactory$Options;-><init>()V

    .line 104
    move-object/from16 p1, v0

    const/4 v0, 0x1

    iput-boolean v0, v6, Landroid/graphics/BitmapFactory$Options;->inJustDecodeBounds:Z

    .line 105
    invoke-virtual {v7}, Landroid/os/ParcelFileDescriptor;->getFileDescriptor()Ljava/io/FileDescriptor;

    move-result-object v0
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_11

    move-wide/from16 v17, v1

    const/4 v1, 0x0

    :try_start_1
    invoke-static {v0, v1, v6}, Landroid/graphics/BitmapFactory;->decodeFileDescriptor(Ljava/io/FileDescriptor;Landroid/graphics/Rect;Landroid/graphics/BitmapFactory$Options;)Landroid/graphics/Bitmap;
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_10

    .line 106
    :try_start_2
    iget v0, v6, Landroid/graphics/BitmapFactory$Options;->outWidth:I
    :try_end_2
    .catchall {:try_start_2 .. :try_end_2} :catchall_11

    const/16 v1, 0x1000

    const/16 v2, 0xc00

    if-ne v0, v1, :cond_2

    :try_start_3
    iget v0, v6, Landroid/graphics/BitmapFactory$Options;->outHeight:I
    :try_end_3
    .catchall {:try_start_3 .. :try_end_3} :catchall_0

    if-eq v0, v2, :cond_3

    goto :goto_0

    .line 102
    :catchall_0
    move-exception v0

    move-object v1, v0

    move-object/from16 v21, v7

    move-object/from16 v17, v8

    move-object/from16 p0, v11

    move-object/from16 p1, v12

    move-object/from16 v18, v13

    const/4 v6, 0x0

    goto/16 :goto_c

    .line 106
    :cond_2
    :goto_0
    :try_start_4
    iget v0, v6, Landroid/graphics/BitmapFactory$Options;->outWidth:I

    if-ne v0, v2, :cond_11

    iget v0, v6, Landroid/graphics/BitmapFactory$Options;->outHeight:I

    if-ne v0, v1, :cond_11

    .line 109
    :cond_3
    new-instance v0, Landroid/graphics/BitmapFactory$Options;

    invoke-direct {v0}, Landroid/graphics/BitmapFactory$Options;-><init>()V

    .line 110
    sget-object v1, Landroid/graphics/Bitmap$Config;->ARGB_8888:Landroid/graphics/Bitmap$Config;

    iput-object v1, v0, Landroid/graphics/BitmapFactory$Options;->inPreferredConfig:Landroid/graphics/Bitmap$Config;

    .line 111
    sget-object v1, Landroid/graphics/ColorSpace$Named;->SRGB:Landroid/graphics/ColorSpace$Named;

    invoke-static {v1}, Landroid/graphics/ColorSpace;->get(Landroid/graphics/ColorSpace$Named;)Landroid/graphics/ColorSpace;

    move-result-object v1

    iput-object v1, v0, Landroid/graphics/BitmapFactory$Options;->inPreferredColorSpace:Landroid/graphics/ColorSpace;

    .line 112
    const/4 v1, 0x1

    iput-boolean v1, v0, Landroid/graphics/BitmapFactory$Options;->inMutable:Z

    .line 113
    invoke-virtual {v7}, Landroid/os/ParcelFileDescriptor;->getFileDescriptor()Ljava/io/FileDescriptor;

    move-result-object v1
    :try_end_4
    .catchall {:try_start_4 .. :try_end_4} :catchall_11

    const/4 v6, 0x0

    :try_start_5
    invoke-static {v1, v6, v0}, Landroid/graphics/BitmapFactory;->decodeFileDescriptor(Ljava/io/FileDescriptor;Landroid/graphics/Rect;Landroid/graphics/BitmapFactory$Options;)Landroid/graphics/Bitmap;

    move-result-object v6
    :try_end_5
    .catchall {:try_start_5 .. :try_end_5} :catchall_e

    .line 114
    if-eqz v6, :cond_10

    :try_start_6
    invoke-virtual {v6}, Landroid/graphics/Bitmap;->getColorSpace()Landroid/graphics/ColorSpace;

    move-result-object v0

    if-eqz v0, :cond_10

    invoke-virtual {v6}, Landroid/graphics/Bitmap;->getColorSpace()Landroid/graphics/ColorSpace;

    move-result-object v0

    invoke-virtual {v0}, Landroid/graphics/ColorSpace;->isSrgb()Z

    move-result v0

    if-eqz v0, :cond_10

    .line 116
    invoke-static {}, Landroid/os/SystemClock;->elapsedRealtime()J

    move-result-wide v0

    .line 117
    invoke-virtual {v6}, Landroid/graphics/Bitmap;->getWidth()I

    move-result v2

    move-wide/from16 v19, v0

    const/16 v1, 0xc00

    if-ne v2, v1, :cond_4

    const/4 v1, 0x1

    goto :goto_1

    :cond_4
    const/4 v1, 0x0

    .line 118
    :goto_1
    invoke-static {v6, v1}, Llocal/mio/os4camerabridge/LegendaryPixelCodec;->toNv12(Landroid/graphics/Bitmap;Z)[B

    move-result-object v2

    .line 119
    if-eqz v2, :cond_f

    array-length v0, v2

    move/from16 v21, v3

    const/high16 v3, 0x1200000

    if-ne v0, v3, :cond_f

    .line 120
    new-instance v3, Ljava/io/FileOutputStream;

    invoke-direct {v3, v11}, Ljava/io/FileOutputStream;-><init>(Ljava/io/File;)V
    :try_end_6
    .catchall {:try_start_6 .. :try_end_6} :catchall_c

    :try_start_7
    invoke-virtual {v3, v2}, Ljava/io/FileOutputStream;->write([B)V
    :try_end_7
    .catchall {:try_start_7 .. :try_end_7} :catchall_a

    :try_start_8
    invoke-virtual {v3}, Ljava/io/FileOutputStream;->close()V

    .line 121
    nop

    .line 122
    invoke-static {}, Landroid/os/SystemClock;->elapsedRealtime()J

    move-result-wide v2

    .line 123
    new-instance v0, Ljava/lang/ProcessBuilder;

    move-wide/from16 v22, v2

    new-instance v2, Ljava/io/File;

    const-string v3, "liblegend_native_worker.so"

    invoke-direct {v2, v9, v3}, Ljava/io/File;-><init>(Ljava/io/File;Ljava/lang/String;)V

    invoke-virtual {v2}, Ljava/io/File;->getPath()Ljava/lang/String;

    move-result-object v24

    .line 124
    invoke-virtual {v9}, Ljava/io/File;->getPath()Ljava/lang/String;

    move-result-object v25

    invoke-virtual {v10}, Ljava/io/File;->getPath()Ljava/lang/String;

    move-result-object v26

    invoke-virtual {v11}, Ljava/io/File;->getPath()Ljava/lang/String;

    move-result-object v27

    invoke-virtual {v12}, Ljava/io/File;->getPath()Ljava/lang/String;

    move-result-object v28

    .line 125
    invoke-static/range {v21 .. v21}, Ljava/lang/String;->valueOf(I)Ljava/lang/String;

    move-result-object v29

    invoke-static {v4}, Ljava/lang/String;->valueOf(I)Ljava/lang/String;

    move-result-object v30

    invoke-static {v5}, Ljava/lang/String;->valueOf(I)Ljava/lang/String;

    move-result-object v31

    filled-new-array/range {v24 .. v31}, [Ljava/lang/String;

    move-result-object v2

    invoke-direct {v0, v2}, Ljava/lang/ProcessBuilder;-><init>([Ljava/lang/String;)V

    .line 126
    invoke-virtual {v0}, Ljava/lang/ProcessBuilder;->environment()Ljava/util/Map;

    move-result-object v2

    const-string v3, "LD_LIBRARY_PATH"

    invoke-static {v9}, Ljava/lang/String;->valueOf(Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v4

    new-instance v5, Ljava/lang/StringBuilder;

    invoke-direct {v5}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v5, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    const-string v5, ":/system/lib64:/vendor/lib64"

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v4

    invoke-interface {v2, v3, v4}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 127
    invoke-virtual {v0}, Ljava/lang/ProcessBuilder;->environment()Ljava/util/Map;

    move-result-object v2

    const-string v3, "M9_QNN_RUNTIME_DIR"

    invoke-virtual {v9}, Ljava/io/File;->getPath()Ljava/lang/String;

    move-result-object v4

    invoke-interface {v2, v3, v4}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 128
    invoke-virtual {v0}, Ljava/lang/ProcessBuilder;->environment()Ljava/util/Map;

    move-result-object v2

    const-string v3, "M9_ADSP_SKEL_DIR"

    invoke-virtual {v9}, Ljava/io/File;->getPath()Ljava/lang/String;

    move-result-object v4

    invoke-interface {v2, v3, v4}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 129
    invoke-virtual {v0}, Ljava/lang/ProcessBuilder;->environment()Ljava/util/Map;

    move-result-object v2

    const-string v3, "M9_DIPS_ASSET_DIR"

    invoke-virtual {v10}, Ljava/io/File;->getPath()Ljava/lang/String;

    move-result-object v4

    invoke-interface {v2, v3, v4}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 130
    invoke-virtual {v0}, Ljava/lang/ProcessBuilder;->environment()Ljava/util/Map;

    move-result-object v2

    const-string v3, "M9_QNN_CONTEXT_DIR"

    invoke-virtual {v10}, Ljava/io/File;->getPath()Ljava/lang/String;

    move-result-object v4

    invoke-interface {v2, v3, v4}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 131
    invoke-virtual {v0}, Ljava/lang/ProcessBuilder;->environment()Ljava/util/Map;

    move-result-object v2

    const-string v3, "M9_V79_SEGMENT_LIBRARY"

    new-instance v4, Ljava/io/File;

    const-string v5, "libanc_single_bokeh.so"

    invoke-direct {v4, v9, v5}, Ljava/io/File;-><init>(Ljava/io/File;Ljava/lang/String;)V

    invoke-virtual {v4}, Ljava/io/File;->getPath()Ljava/lang/String;

    move-result-object v4

    invoke-interface {v2, v3, v4}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 132
    invoke-virtual {v0}, Ljava/lang/ProcessBuilder;->environment()Ljava/util/Map;

    move-result-object v2

    const-string v3, "M9_V79_SEGMENT_ASSETS_DIR"

    invoke-virtual {v10}, Ljava/io/File;->getPath()Ljava/lang/String;

    move-result-object v4

    invoke-interface {v2, v3, v4}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 133
    const/4 v2, 0x1

    invoke-virtual {v0, v2}, Ljava/lang/ProcessBuilder;->redirectErrorStream(Z)Ljava/lang/ProcessBuilder;

    move-result-object v2

    invoke-virtual {v2, v13}, Ljava/lang/ProcessBuilder;->redirectOutput(Ljava/io/File;)Ljava/lang/ProcessBuilder;

    .line 134
    invoke-virtual {v0}, Ljava/lang/ProcessBuilder;->start()Ljava/lang/Process;

    move-result-object v0

    .line 135
    sget-object v2, Ljava/util/concurrent/TimeUnit;->SECONDS:Ljava/util/concurrent/TimeUnit;

    const-wide/16 v3, 0xc

    invoke-virtual {v0, v3, v4, v2}, Ljava/lang/Process;->waitFor(JLjava/util/concurrent/TimeUnit;)Z

    move-result v2

    if-eqz v2, :cond_e

    .line 140
    invoke-static {}, Landroid/os/SystemClock;->elapsedRealtime()J

    move-result-wide v2

    .line 141
    new-instance v4, Ljava/lang/String;

    invoke-virtual {v13}, Ljava/io/File;->toPath()Ljava/nio/file/Path;

    move-result-object v5

    invoke-static {v5}, Ljava/nio/file/Files;->readAllBytes(Ljava/nio/file/Path;)[B

    move-result-object v5

    sget-object v9, Ljava/nio/charset/StandardCharsets;->UTF_8:Ljava/nio/charset/Charset;

    invoke-direct {v4, v5, v9}, Ljava/lang/String;-><init>([BLjava/nio/charset/Charset;)V

    .line 142
    new-instance v5, Ljava/io/File;

    invoke-virtual/range {p1 .. p1}, Landroid/content/Context;->getFilesDir()Ljava/io/File;

    move-result-object v9

    const-string v10, "legend_worker_last.txt"

    invoke-direct {v5, v9, v10}, Ljava/io/File;-><init>(Ljava/io/File;Ljava/lang/String;)V

    .line 143
    new-instance v9, Ljava/io/FileOutputStream;

    invoke-direct {v9, v5}, Ljava/io/FileOutputStream;-><init>(Ljava/io/File;)V
    :try_end_8
    .catchall {:try_start_8 .. :try_end_8} :catchall_c

    .line 144
    :try_start_9
    sget-object v5, Ljava/nio/charset/StandardCharsets;->UTF_8:Ljava/nio/charset/Charset;

    invoke-virtual {v4, v5}, Ljava/lang/String;->getBytes(Ljava/nio/charset/Charset;)[B

    move-result-object v5

    .line 145
    array-length v10, v5

    move-wide/from16 v24, v2

    const v2, 0x8000

    sub-int/2addr v10, v2

    const/4 v3, 0x0

    invoke-static {v3, v10}, Ljava/lang/Math;->max(II)I

    move-result v10

    array-length v3, v5

    invoke-static {v2, v3}, Ljava/lang/Math;->min(II)I

    move-result v2

    invoke-virtual {v9, v5, v10, v2}, Ljava/io/FileOutputStream;->write([BII)V
    :try_end_9
    .catchall {:try_start_9 .. :try_end_9} :catchall_8

    .line 146
    :try_start_a
    invoke-virtual {v9}, Ljava/io/FileOutputStream;->close()V

    .line 147
    const-string v2, "\n"

    invoke-virtual {v4, v2}, Ljava/lang/String;->split(Ljava/lang/String;)[Ljava/lang/String;

    move-result-object v2

    array-length v3, v2
    :try_end_a
    .catchall {:try_start_a .. :try_end_a} :catchall_c

    const/4 v4, 0x0

    :goto_2
    if-ge v4, v3, :cond_7

    :try_start_b
    aget-object v5, v2, v4

    .line 148
    const-string v9, "LegendWorker"

    invoke-virtual {v5, v9}, Ljava/lang/String;->startsWith(Ljava/lang/String;)Z

    move-result v9

    if-nez v9, :cond_5

    const-string v9, "dlopen:"

    invoke-virtual {v5, v9}, Ljava/lang/String;->contains(Ljava/lang/CharSequence;)Z

    move-result v9

    if-eqz v9, :cond_6

    :cond_5
    const-string v9, "LegendaryNative"

    invoke-static {v9, v5}, Landroid/util/Log;->i(Ljava/lang/String;Ljava/lang/String;)I
    :try_end_b
    .catchall {:try_start_b .. :try_end_b} :catchall_1

    .line 147
    :cond_6
    add-int/lit8 v4, v4, 0x1

    goto :goto_2

    .line 102
    :catchall_1
    move-exception v0

    move-object v1, v0

    move-object/from16 v21, v7

    move-object/from16 v17, v8

    move-object/from16 p0, v11

    move-object/from16 p1, v12

    move-object/from16 v18, v13

    goto/16 :goto_c

    .line 149
    :cond_7
    :try_start_c
    invoke-virtual {v0}, Ljava/lang/Process;->exitValue()I

    move-result v2

    if-nez v2, :cond_d

    invoke-virtual {v12}, Ljava/io/File;->length()J

    move-result-wide v2

    const-wide/32 v4, 0x1200000

    cmp-long v2, v2, v4

    if-nez v2, :cond_d

    .line 151
    invoke-virtual {v12}, Ljava/io/File;->toPath()Ljava/nio/file/Path;

    move-result-object v0

    invoke-static {v0}, Ljava/nio/file/Files;->readAllBytes(Ljava/nio/file/Path;)[B

    move-result-object v0

    .line 152
    invoke-static {v6, v1, v0}, Llocal/mio/os4camerabridge/LegendaryPixelCodec;->fromNv12(Landroid/graphics/Bitmap;Z[B)Z

    move-result v0

    if-eqz v0, :cond_c

    .line 153
    invoke-static {}, Landroid/os/SystemClock;->elapsedRealtime()J

    move-result-wide v0

    .line 154
    new-instance v2, Ljava/io/FileOutputStream;

    invoke-virtual {v8}, Landroid/os/ParcelFileDescriptor;->getFileDescriptor()Ljava/io/FileDescriptor;

    move-result-object v3

    invoke-direct {v2, v3}, Ljava/io/FileOutputStream;-><init>(Ljava/io/FileDescriptor;)V
    :try_end_c
    .catchall {:try_start_c .. :try_end_c} :catchall_c

    .line 155
    :try_start_d
    sget-object v3, Landroid/graphics/Bitmap$CompressFormat;->JPEG:Landroid/graphics/Bitmap$CompressFormat;

    const/16 v4, 0x64

    invoke-virtual {v6, v3, v4, v2}, Landroid/graphics/Bitmap;->compress(Landroid/graphics/Bitmap$CompressFormat;ILjava/io/OutputStream;)Z

    move-result v3

    if-eqz v3, :cond_b

    .line 156
    invoke-virtual {v2}, Ljava/io/FileOutputStream;->flush()V

    .line 157
    invoke-static {}, Landroid/os/SystemClock;->elapsedRealtime()J

    move-result-wide v3
    :try_end_d
    .catchall {:try_start_d .. :try_end_d} :catchall_6

    .line 158
    sub-long v9, v14, v17

    sub-long v14, v19, v14

    move-wide/from16 p0, v0

    sub-long v0, v22, v19

    move-object v5, v2

    move-wide/from16 v19, v3

    sub-long v2, v24, v22

    move-object/from16 v16, v5

    sub-long v4, p0, v24

    move-object/from16 v22, v6

    move-object/from16 v21, v7

    sub-long v6, v19, p0

    move-object/from16 p0, v11

    move-object/from16 p1, v12

    sub-long v11, v19, v17

    move-object/from16 v17, v8

    :try_start_e
    new-instance v8, Ljava/lang/StringBuilder;

    invoke-direct {v8}, Ljava/lang/StringBuilder;-><init>()V
    :try_end_e
    .catchall {:try_start_e .. :try_end_e} :catchall_4

    move-object/from16 v18, v13

    :try_start_f
    const-string v13, "prepare="

    invoke-virtual {v8, v13}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v8

    invoke-virtual {v8, v9, v10}, Ljava/lang/StringBuilder;->append(J)Ljava/lang/StringBuilder;

    move-result-object v8

    const-string v9, " decode="

    invoke-virtual {v8, v9}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v8

    invoke-virtual {v8, v14, v15}, Ljava/lang/StringBuilder;->append(J)Ljava/lang/StringBuilder;

    move-result-object v8

    const-string v9, " rgbToNv12AndWrite="

    invoke-virtual {v8, v9}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v8

    invoke-virtual {v8, v0, v1}, Ljava/lang/StringBuilder;->append(J)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, " worker="

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, v2, v3}, Ljava/lang/StringBuilder;->append(J)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, " readAndNv12ToRgb="

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, v4, v5}, Ljava/lang/StringBuilder;->append(J)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, " jpegEncode="

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, v6, v7}, Ljava/lang/StringBuilder;->append(J)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, " total="

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, v11, v12}, Ljava/lang/StringBuilder;->append(J)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, " ms"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    sput-object v0, Llocal/mio/os4camerabridge/LegendaryProcessingProvider;->lastTiming:Ljava/lang/String;

    .line 162
    invoke-virtual/range {v16 .. v16}, Ljava/io/FileOutputStream;->getChannel()Ljava/nio/channels/FileChannel;

    move-result-object v0

    invoke-virtual {v0}, Ljava/nio/channels/FileChannel;->size()J

    move-result-wide v0
    :try_end_f
    .catchall {:try_start_f .. :try_end_f} :catchall_5

    .line 163
    :try_start_10
    invoke-virtual/range {v16 .. v16}, Ljava/io/FileOutputStream;->close()V
    :try_end_10
    .catchall {:try_start_10 .. :try_end_10} :catchall_d

    .line 164
    if-eqz v17, :cond_8

    :try_start_11
    invoke-virtual/range {v17 .. v17}, Landroid/os/ParcelFileDescriptor;->close()V
    :try_end_11
    .catchall {:try_start_11 .. :try_end_11} :catchall_2

    goto :goto_3

    .line 102
    :catchall_2
    move-exception v0

    move-object v1, v0

    move-object/from16 v6, v22

    goto/16 :goto_e

    .line 164
    :cond_8
    :goto_3
    if-eqz v21, :cond_9

    :try_start_12
    invoke-virtual/range {v21 .. v21}, Landroid/os/ParcelFileDescriptor;->close()V
    :try_end_12
    .catchall {:try_start_12 .. :try_end_12} :catchall_3

    goto :goto_4

    .line 165
    :catchall_3
    move-exception v0

    move-object/from16 v6, v22

    goto/16 :goto_10

    :cond_9
    :goto_4
    if-eqz v22, :cond_a

    invoke-virtual/range {v22 .. v22}, Landroid/graphics/Bitmap;->recycle()V

    .line 167
    :cond_a
    invoke-virtual/range {p0 .. p0}, Ljava/io/File;->delete()Z

    invoke-virtual/range {p1 .. p1}, Ljava/io/File;->delete()Z

    invoke-virtual/range {v18 .. v18}, Ljava/io/File;->delete()Z

    .line 162
    return-wide v0

    .line 154
    :catchall_4
    move-exception v0

    goto :goto_5

    .line 155
    :cond_b
    move-object/from16 v16, v2

    move-object/from16 v22, v6

    move-object/from16 v21, v7

    move-object/from16 v17, v8

    move-object/from16 p0, v11

    move-object/from16 p1, v12

    move-object/from16 v18, v13

    :try_start_13
    new-instance v0, Ljava/io/IOException;

    const-string v1, "JPEG encode failed"

    invoke-direct {v0, v1}, Ljava/io/IOException;-><init>(Ljava/lang/String;)V

    throw v0
    :try_end_13
    .catchall {:try_start_13 .. :try_end_13} :catchall_5

    .line 154
    :catchall_5
    move-exception v0

    goto :goto_6

    :catchall_6
    move-exception v0

    move-object/from16 v16, v2

    move-object/from16 v22, v6

    move-object/from16 v21, v7

    move-object/from16 v17, v8

    move-object/from16 p0, v11

    move-object/from16 p1, v12

    :goto_5
    move-object/from16 v18, v13

    :goto_6
    move-object v1, v0

    :try_start_14
    invoke-virtual/range {v16 .. v16}, Ljava/io/FileOutputStream;->close()V
    :try_end_14
    .catchall {:try_start_14 .. :try_end_14} :catchall_7

    goto :goto_7

    :catchall_7
    move-exception v0

    :try_start_15
    invoke-virtual {v1, v0}, Ljava/lang/Throwable;->addSuppressed(Ljava/lang/Throwable;)V

    :goto_7
    throw v1

    .line 152
    :cond_c
    move-object/from16 v22, v6

    move-object/from16 v21, v7

    move-object/from16 v17, v8

    move-object/from16 p0, v11

    move-object/from16 p1, v12

    move-object/from16 v18, v13

    new-instance v0, Ljava/io/IOException;

    const-string v1, "RGB output conversion failed"

    invoke-direct {v0, v1}, Ljava/io/IOException;-><init>(Ljava/lang/String;)V

    throw v0

    .line 149
    :cond_d
    move-object/from16 v22, v6

    move-object/from16 v21, v7

    move-object/from16 v17, v8

    move-object/from16 p0, v11

    move-object/from16 p1, v12

    move-object/from16 v18, v13

    .line 150
    new-instance v1, Ljava/io/IOException;

    invoke-virtual {v0}, Ljava/lang/Process;->exitValue()I

    move-result v0

    invoke-virtual/range {p1 .. p1}, Ljava/io/File;->length()J

    move-result-wide v2

    new-instance v4, Ljava/lang/StringBuilder;

    invoke-direct {v4}, Ljava/lang/StringBuilder;-><init>()V

    const-string v5, "Native worker exit="

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4, v0}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v4, " bytes="

    invoke-virtual {v0, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, v2, v3}, Ljava/lang/StringBuilder;->append(J)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-direct {v1, v0}, Ljava/io/IOException;-><init>(Ljava/lang/String;)V

    throw v1
    :try_end_15
    .catchall {:try_start_15 .. :try_end_15} :catchall_d

    .line 143
    :catchall_8
    move-exception v0

    move-object/from16 v22, v6

    move-object/from16 v21, v7

    move-object/from16 v17, v8

    move-object/from16 p0, v11

    move-object/from16 p1, v12

    move-object/from16 v18, v13

    move-object v1, v0

    :try_start_16
    invoke-virtual {v9}, Ljava/io/FileOutputStream;->close()V
    :try_end_16
    .catchall {:try_start_16 .. :try_end_16} :catchall_9

    goto :goto_8

    :catchall_9
    move-exception v0

    :try_start_17
    invoke-virtual {v1, v0}, Ljava/lang/Throwable;->addSuppressed(Ljava/lang/Throwable;)V

    :goto_8
    throw v1

    .line 136
    :cond_e
    move-object/from16 v22, v6

    move-object/from16 v21, v7

    move-object/from16 v17, v8

    move-object/from16 p0, v11

    move-object/from16 p1, v12

    move-object/from16 v18, v13

    invoke-virtual {v0}, Ljava/lang/Process;->destroyForcibly()Ljava/lang/Process;

    .line 137
    sget-object v1, Ljava/util/concurrent/TimeUnit;->SECONDS:Ljava/util/concurrent/TimeUnit;

    const-wide/16 v2, 0x2

    invoke-virtual {v0, v2, v3, v1}, Ljava/lang/Process;->waitFor(JLjava/util/concurrent/TimeUnit;)Z

    .line 138
    new-instance v0, Ljava/io/IOException;

    const-string v1, "Native worker timeout; original JPEG retained"

    invoke-direct {v0, v1}, Ljava/io/IOException;-><init>(Ljava/lang/String;)V

    throw v0
    :try_end_17
    .catchall {:try_start_17 .. :try_end_17} :catchall_d

    .line 120
    :catchall_a
    move-exception v0

    move-object/from16 v22, v6

    move-object/from16 v21, v7

    move-object/from16 v17, v8

    move-object/from16 p0, v11

    move-object/from16 p1, v12

    move-object/from16 v18, v13

    move-object v1, v0

    :try_start_18
    invoke-virtual {v3}, Ljava/io/FileOutputStream;->close()V
    :try_end_18
    .catchall {:try_start_18 .. :try_end_18} :catchall_b

    goto :goto_9

    :catchall_b
    move-exception v0

    :try_start_19
    invoke-virtual {v1, v0}, Ljava/lang/Throwable;->addSuppressed(Ljava/lang/Throwable;)V

    :goto_9
    throw v1

    .line 119
    :cond_f
    move-object/from16 v22, v6

    move-object/from16 v21, v7

    move-object/from16 v17, v8

    move-object/from16 p0, v11

    move-object/from16 p1, v12

    move-object/from16 v18, v13

    new-instance v0, Ljava/io/IOException;

    const-string v1, "NV12 conversion failed"

    invoke-direct {v0, v1}, Ljava/io/IOException;-><init>(Ljava/lang/String;)V

    throw v0

    .line 102
    :catchall_c
    move-exception v0

    move-object/from16 v22, v6

    goto :goto_a

    .line 114
    :cond_10
    move-object/from16 v22, v6

    move-object/from16 v21, v7

    move-object/from16 v17, v8

    move-object/from16 p0, v11

    move-object/from16 p1, v12

    move-object/from16 v18, v13

    .line 115
    new-instance v0, Ljava/io/IOException;

    const-string v1, "sRGB bitmap decode failed"

    invoke-direct {v0, v1}, Ljava/io/IOException;-><init>(Ljava/lang/String;)V

    throw v0
    :try_end_19
    .catchall {:try_start_19 .. :try_end_19} :catchall_d

    .line 102
    :catchall_d
    move-exception v0

    move-object v1, v0

    move-object/from16 v6, v22

    goto :goto_c

    :catchall_e
    move-exception v0

    goto :goto_a

    .line 106
    :cond_11
    move-object/from16 v21, v7

    move-object/from16 v17, v8

    move-object/from16 p0, v11

    move-object/from16 p1, v12

    move-object/from16 v18, v13

    const/4 v6, 0x0

    .line 108
    :try_start_1a
    new-instance v0, Ljava/lang/IllegalArgumentException;

    const-string v1, "Only full-size, clean 12 MP input is supported"

    invoke-direct {v0, v1}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw v0
    :try_end_1a
    .catchall {:try_start_1a .. :try_end_1a} :catchall_f

    .line 102
    :catchall_f
    move-exception v0

    goto :goto_b

    :catchall_10
    move-exception v0

    move-object v6, v1

    :goto_a
    move-object/from16 v21, v7

    move-object/from16 v17, v8

    move-object/from16 p0, v11

    move-object/from16 p1, v12

    move-object/from16 v18, v13

    goto :goto_b

    :catchall_11
    move-exception v0

    move-object/from16 v21, v7

    move-object/from16 v17, v8

    move-object/from16 p0, v11

    move-object/from16 p1, v12

    move-object/from16 v18, v13

    const/4 v6, 0x0

    :goto_b
    move-object v1, v0

    :goto_c
    if-eqz v17, :cond_12

    :try_start_1b
    invoke-virtual/range {v17 .. v17}, Landroid/os/ParcelFileDescriptor;->close()V
    :try_end_1b
    .catchall {:try_start_1b .. :try_end_1b} :catchall_12

    goto :goto_d

    :catchall_12
    move-exception v0

    :try_start_1c
    invoke-virtual {v1, v0}, Ljava/lang/Throwable;->addSuppressed(Ljava/lang/Throwable;)V

    :cond_12
    :goto_d
    throw v1
    :try_end_1c
    .catchall {:try_start_1c .. :try_end_1c} :catchall_13

    :catchall_13
    move-exception v0

    move-object v1, v0

    :goto_e
    if-eqz v21, :cond_13

    :try_start_1d
    invoke-virtual/range {v21 .. v21}, Landroid/os/ParcelFileDescriptor;->close()V
    :try_end_1d
    .catchall {:try_start_1d .. :try_end_1d} :catchall_14

    goto :goto_f

    :catchall_14
    move-exception v0

    :try_start_1e
    invoke-virtual {v1, v0}, Ljava/lang/Throwable;->addSuppressed(Ljava/lang/Throwable;)V

    :cond_13
    :goto_f
    throw v1
    :try_end_1e
    .catchall {:try_start_1e .. :try_end_1e} :catchall_15

    .line 165
    :catchall_15
    move-exception v0

    :goto_10
    if-eqz v6, :cond_14

    invoke-virtual {v6}, Landroid/graphics/Bitmap;->recycle()V

    .line 167
    :cond_14
    invoke-virtual/range {p0 .. p0}, Ljava/io/File;->delete()Z

    invoke-virtual/range {p1 .. p1}, Ljava/io/File;->delete()Z

    invoke-virtual/range {v18 .. v18}, Ljava/io/File;->delete()Z

    .line 168
    throw v0

    .line 89
    :cond_15
    new-instance v0, Ljava/lang/IllegalArgumentException;

    const-string v1, "Descriptors missing"

    invoke-direct {v0, v1}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw v0

    .line 86
    :cond_16
    new-instance v0, Ljava/lang/IllegalArgumentException;

    const-string v1, "Invalid same-shot mode/lux/CCT"

    invoke-direct {v0, v1}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw v0
.end method


# virtual methods
.method public call(Ljava/lang/String;Ljava/lang/String;Landroid/os/Bundle;)Landroid/os/Bundle;
    .locals 6

    .line 50
    invoke-direct {p0}, Llocal/mio/os4camerabridge/LegendaryProcessingProvider;->checkCaller()V

    .line 51
    const-string p2, "settings"

    invoke-virtual {p2, p1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result p2

    const/4 v0, 0x0

    if-eqz p2, :cond_0

    .line 52
    new-instance p1, Landroid/os/Bundle;

    invoke-direct {p1}, Landroid/os/Bundle;-><init>()V

    .line 53
    const-string p2, "optional_aisp_gamma"

    invoke-direct {p0}, Llocal/mio/os4camerabridge/LegendaryProcessingProvider;->preferences()Landroid/content/SharedPreferences;

    move-result-object p3

    const-string v1, "optional_aisp_gamma"

    invoke-interface {p3, v1, v0}, Landroid/content/SharedPreferences;->getBoolean(Ljava/lang/String;Z)Z

    move-result p3

    invoke-virtual {p1, p2, p3}, Landroid/os/Bundle;->putBoolean(Ljava/lang/String;Z)V

    .line 54
    const-string p2, "optional_sensor_matrix"

    invoke-direct {p0}, Llocal/mio/os4camerabridge/LegendaryProcessingProvider;->preferences()Landroid/content/SharedPreferences;

    move-result-object p3

    const-string v1, "optional_sensor_matrix"

    invoke-interface {p3, v1, v0}, Landroid/content/SharedPreferences;->getBoolean(Ljava/lang/String;Z)Z

    move-result p3

    invoke-virtual {p1, p2, p3}, Landroid/os/Bundle;->putBoolean(Ljava/lang/String;Z)V

    .line 55
    const-string p2, "status"

    sget-object p3, Llocal/mio/os4camerabridge/LegendaryProcessingProvider;->lastStatus:Ljava/lang/String;

    invoke-virtual {p1, p2, p3}, Landroid/os/Bundle;->putString(Ljava/lang/String;Ljava/lang/String;)V

    .line 56
    const-string p2, "aispAvailable"

    invoke-virtual {p1, p2, v0}, Landroid/os/Bundle;->putBoolean(Ljava/lang/String;Z)V

    .line 57
    return-object p1

    .line 59
    :cond_0
    const-string p2, "render"

    invoke-virtual {p2, p1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result p1

    if-eqz p1, :cond_2

    if-eqz p3, :cond_2

    .line 60
    sget-object p1, Llocal/mio/os4camerabridge/LegendaryProcessingProvider;->RENDER_LOCK:Ljava/lang/Object;

    monitor-enter p1

    .line 61
    :try_start_0
    new-instance p2, Landroid/os/Bundle;

    invoke-direct {p2}, Landroid/os/Bundle;-><init>()V

    .line 62
    invoke-static {}, Landroid/os/SystemClock;->elapsedRealtime()J

    move-result-wide v1

    .line 63
    const-string v3, "incomplete"

    sput-object v3, Llocal/mio/os4camerabridge/LegendaryProcessingProvider;->lastTiming:Ljava/lang/String;
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_1

    .line 65
    :try_start_1
    const-string v3, "bytes"

    invoke-direct {p0, p3}, Llocal/mio/os4camerabridge/LegendaryProcessingProvider;->render(Landroid/os/Bundle;)J

    move-result-wide v4

    invoke-virtual {p2, v3, v4, v5}, Landroid/os/Bundle;->putLong(Ljava/lang/String;J)V

    .line 66
    const-string v3, "ok"

    const/4 v4, 0x1

    invoke-virtual {p2, v3, v4}, Landroid/os/Bundle;->putBoolean(Ljava/lang/String;Z)V

    .line 67
    const-string v3, "mode"

    invoke-virtual {p3, v3}, Landroid/os/Bundle;->getInt(Ljava/lang/String;)I

    move-result p3

    if-ne p3, v4, :cond_1

    const-string p3, "9"

    goto :goto_0

    :cond_1
    const-string p3, "3"

    .line 68
    :goto_0
    invoke-static {}, Landroid/os/SystemClock;->elapsedRealtime()J

    move-result-wide v3

    sub-long/2addr v3, v1

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "M"

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, p3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p3

    const-string v1, " \u672c\u5730\u5904\u7406\u5b8c\u6210\uff0c"

    invoke-virtual {p3, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p3

    invoke-virtual {p3, v3, v4}, Ljava/lang/StringBuilder;->append(J)Ljava/lang/StringBuilder;

    move-result-object p3

    const-string v1, " ms\uff1bBT.601 \u5168\u8303\u56f4\uff1b\u672a\u66ff\u4ee3 Gallery \u5904\u7406\u3002"

    invoke-virtual {p3, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p3

    invoke-virtual {p3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p3

    sput-object p3, Llocal/mio/os4camerabridge/LegendaryProcessingProvider;->lastStatus:Ljava/lang/String;
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    .line 74
    goto :goto_1

    .line 69
    :catchall_0
    move-exception p3

    .line 70
    :try_start_2
    invoke-virtual {p3}, Ljava/lang/Object;->getClass()Ljava/lang/Class;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/Class;->getSimpleName()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {p3}, Ljava/lang/Throwable;->getMessage()Ljava/lang/String;

    move-result-object v2

    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    const-string v4, "\u672c\u5730\u5904\u7406\u672a\u63d0\u4ea4\uff1a"

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v3, ": "

    invoke-virtual {v1, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    sput-object v1, Llocal/mio/os4camerabridge/LegendaryProcessingProvider;->lastStatus:Ljava/lang/String;

    .line 71
    const-string v1, "ok"

    invoke-virtual {p2, v1, v0}, Landroid/os/Bundle;->putBoolean(Ljava/lang/String;Z)V

    .line 72
    const-string v0, "error"

    sget-object v1, Llocal/mio/os4camerabridge/LegendaryProcessingProvider;->lastStatus:Ljava/lang/String;

    invoke-virtual {p2, v0, v1}, Landroid/os/Bundle;->putString(Ljava/lang/String;Ljava/lang/String;)V

    .line 73
    const-string v0, "LegendaryNative"

    sget-object v1, Llocal/mio/os4camerabridge/LegendaryProcessingProvider;->lastStatus:Ljava/lang/String;

    invoke-static {v0, v1, p3}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)I

    .line 75
    :goto_1
    const-string p3, "status"

    sget-object v0, Llocal/mio/os4camerabridge/LegendaryProcessingProvider;->lastStatus:Ljava/lang/String;

    invoke-virtual {p2, p3, v0}, Landroid/os/Bundle;->putString(Ljava/lang/String;Ljava/lang/String;)V

    .line 76
    const-string p3, "timing"

    sget-object v0, Llocal/mio/os4camerabridge/LegendaryProcessingProvider;->lastTiming:Ljava/lang/String;

    invoke-virtual {p2, p3, v0}, Landroid/os/Bundle;->putString(Ljava/lang/String;Ljava/lang/String;)V

    .line 77
    const-string p3, "LegendaryNative"

    sget-object v0, Llocal/mio/os4camerabridge/LegendaryProcessingProvider;->lastStatus:Ljava/lang/String;

    invoke-static {p3, v0}, Landroid/util/Log;->i(Ljava/lang/String;Ljava/lang/String;)I

    .line 78
    monitor-exit p1

    return-object p2

    .line 79
    :catchall_1
    move-exception p2

    monitor-exit p1
    :try_end_2
    .catchall {:try_start_2 .. :try_end_2} :catchall_1

    throw p2

    .line 59
    :cond_2
    new-instance p1, Ljava/lang/IllegalArgumentException;

    const-string p2, "Unknown operation"

    invoke-direct {p1, p2}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw p1
.end method

.method public delete(Landroid/net/Uri;Ljava/lang/String;[Ljava/lang/String;)I
    .locals 0

    .line 194
    new-instance p1, Ljava/lang/UnsupportedOperationException;

    invoke-direct {p1}, Ljava/lang/UnsupportedOperationException;-><init>()V

    throw p1
.end method

.method public getType(Landroid/net/Uri;)Ljava/lang/String;
    .locals 0

    .line 192
    const/4 p1, 0x0

    return-object p1
.end method

.method public insert(Landroid/net/Uri;Landroid/content/ContentValues;)Landroid/net/Uri;
    .locals 0

    .line 193
    new-instance p1, Ljava/lang/UnsupportedOperationException;

    invoke-direct {p1}, Ljava/lang/UnsupportedOperationException;-><init>()V

    throw p1
.end method

.method public onCreate()Z
    .locals 1

    .line 33
    invoke-virtual {p0}, Llocal/mio/os4camerabridge/LegendaryProcessingProvider;->getContext()Landroid/content/Context;

    move-result-object v0

    invoke-static {v0}, Llocal/mio/os4camerabridge/LegendaryProcessingProvider;->grantCameraVisibility(Landroid/content/Context;)V

    const/4 v0, 0x1

    return v0
.end method

.method public query(Landroid/net/Uri;[Ljava/lang/String;Ljava/lang/String;[Ljava/lang/String;Ljava/lang/String;)Landroid/database/Cursor;
    .locals 0

    .line 191
    new-instance p1, Ljava/lang/UnsupportedOperationException;

    invoke-direct {p1}, Ljava/lang/UnsupportedOperationException;-><init>()V

    throw p1
.end method

.method public update(Landroid/net/Uri;Landroid/content/ContentValues;Ljava/lang/String;[Ljava/lang/String;)I
    .locals 0

    .line 195
    new-instance p1, Ljava/lang/UnsupportedOperationException;

    invoke-direct {p1}, Ljava/lang/UnsupportedOperationException;-><init>()V

    throw p1
.end method
