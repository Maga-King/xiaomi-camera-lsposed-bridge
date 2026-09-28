.class public final Llocal/mio/os4camerabridge/LegendaryWatermarkResources;
.super Ljava/lang/Object;
.source "LegendaryWatermarkResources.java"


# direct methods
.method static bridge synthetic -$$Nest$smensure(Ljava/io/File;)V
    .locals 0

    invoke-static {p0}, Llocal/mio/os4camerabridge/LegendaryWatermarkResources;->ensure(Ljava/io/File;)V

    return-void
.end method

.method private constructor <init>()V
    .locals 0

    .line 18
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method private static declared-synchronized ensure(Ljava/io/File;)V
    .locals 13
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/lang/Exception;
        }
    .end annotation

    const-class v0, Llocal/mio/os4camerabridge/LegendaryWatermarkResources;

    monitor-enter v0

    .line 32
    :try_start_0
    const-string v1, "android.app.ActivityThread"

    .line 33
    invoke-static {v1}, Ljava/lang/Class;->forName(Ljava/lang/String;)Ljava/lang/Class;

    move-result-object v1

    const-string v2, "currentApplication"

    const/4 v3, 0x0

    new-array v4, v3, [Ljava/lang/Object;

    .line 32
    invoke-static {v1, v2, v4}, Lde/robv/android/xposed/XposedHelpers;->callStaticMethod(Ljava/lang/Class;Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Landroid/app/Application;

    .line 34
    if-eqz v1, :cond_c

    const-string v2, "com.android.camera"

    invoke-virtual {v1}, Landroid/app/Application;->getPackageName()Ljava/lang/String;

    move-result-object v4

    invoke-virtual {v2, v4}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v2

    if-nez v2, :cond_0

    goto/16 :goto_6

    .line 35
    :cond_0
    new-instance v2, Ljava/io/File;

    invoke-virtual {v1}, Landroid/app/Application;->getFilesDir()Ljava/io/File;

    move-result-object v4

    const-string v5, "watermarks"

    invoke-direct {v2, v4, v5}, Ljava/io/File;-><init>(Ljava/io/File;Ljava/lang/String;)V

    invoke-virtual {v2}, Ljava/io/File;->getCanonicalFile()Ljava/io/File;

    move-result-object v2

    .line 36
    invoke-virtual {p0}, Ljava/io/File;->getCanonicalFile()Ljava/io/File;

    move-result-object p0

    invoke-virtual {v2, p0}, Ljava/io/File;->equals(Ljava/lang/Object;)Z

    move-result p0
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_6

    if-nez p0, :cond_1

    monitor-exit v0

    return-void

    .line 37
    :cond_1
    :try_start_1
    new-instance p0, Ljava/io/File;

    const-string v4, "leica"

    invoke-direct {p0, v2, v4}, Ljava/io/File;-><init>(Ljava/io/File;Ljava/lang/String;)V

    new-instance v2, Ljava/io/File;

    const-string v4, "135"

    invoke-direct {v2, p0, v4}, Ljava/io/File;-><init>(Ljava/io/File;Ljava/lang/String;)V

    .line 38
    invoke-virtual {p0}, Ljava/io/File;->isDirectory()Z

    move-result p0

    if-eqz p0, :cond_b

    invoke-virtual {v2}, Ljava/io/File;->exists()Z

    move-result p0

    if-eqz p0, :cond_2

    goto/16 :goto_5

    .line 39
    :cond_2
    const-string p0, "local.mio.os4camerabridge"

    const/4 v4, 0x2

    invoke-virtual {v1, p0, v4}, Landroid/app/Application;->createPackageContext(Ljava/lang/String;I)Landroid/content/Context;

    move-result-object p0

    .line 40
    invoke-virtual {v1}, Landroid/app/Application;->getCacheDir()Ljava/io/File;

    move-result-object v1

    invoke-virtual {v1}, Ljava/io/File;->toPath()Ljava/nio/file/Path;

    move-result-object v1

    const-string v4, "legend-watermark-135-"

    new-array v5, v3, [Ljava/nio/file/attribute/FileAttribute;

    invoke-static {v1, v4, v5}, Ljava/nio/file/Files;->createTempDirectory(Ljava/nio/file/Path;Ljava/lang/String;[Ljava/nio/file/attribute/FileAttribute;)Ljava/nio/file/Path;

    move-result-object v1

    invoke-interface {v1}, Ljava/nio/file/Path;->toFile()Ljava/io/File;

    move-result-object v1

    .line 41
    nop

    .line 42
    invoke-virtual {p0}, Landroid/content/Context;->getAssets()Landroid/content/res/AssetManager;

    move-result-object p0

    const-string v4, "legendary/watermarks/leica-135.zip"

    invoke-virtual {p0, v4}, Landroid/content/res/AssetManager;->open(Ljava/lang/String;)Ljava/io/InputStream;

    move-result-object p0
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_6

    .line 43
    :try_start_2
    new-instance v4, Ljava/util/zip/ZipInputStream;

    invoke-direct {v4, p0}, Ljava/util/zip/ZipInputStream;-><init>(Ljava/io/InputStream;)V
    :try_end_2
    .catchall {:try_start_2 .. :try_end_2} :catchall_4

    .line 44
    const/16 v5, 0x4000

    :try_start_3
    new-array v5, v5, [B

    const-wide/16 v6, 0x0

    move v8, v3

    .line 45
    :goto_0
    invoke-virtual {v4}, Ljava/util/zip/ZipInputStream;->getNextEntry()Ljava/util/zip/ZipEntry;

    move-result-object v9

    if-eqz v9, :cond_7

    .line 46
    invoke-virtual {v9}, Ljava/util/zip/ZipEntry;->getName()Ljava/lang/String;

    move-result-object v10

    .line 47
    invoke-virtual {v9}, Ljava/util/zip/ZipEntry;->isDirectory()Z

    move-result v9

    if-nez v9, :cond_6

    const-string v9, "[A-Za-z0-9_]+\\.(json|webp)"

    invoke-virtual {v10, v9}, Ljava/lang/String;->matches(Ljava/lang/String;)Z

    move-result v9

    if-eqz v9, :cond_6

    add-int/lit8 v8, v8, 0x1

    const/16 v9, 0x20

    if-gt v8, v9, :cond_6

    .line 49
    new-instance v9, Ljava/io/File;

    invoke-direct {v9, v1, v10}, Ljava/io/File;-><init>(Ljava/io/File;Ljava/lang/String;)V

    .line 50
    invoke-virtual {v9}, Ljava/io/File;->createNewFile()Z

    move-result v10

    if-eqz v10, :cond_5

    .line 51
    new-instance v10, Ljava/io/FileOutputStream;

    invoke-direct {v10, v9}, Ljava/io/FileOutputStream;-><init>(Ljava/io/File;)V
    :try_end_3
    .catchall {:try_start_3 .. :try_end_3} :catchall_2

    .line 52
    :goto_1
    :try_start_4
    invoke-virtual {v4, v5}, Ljava/util/zip/ZipInputStream;->read([B)I

    move-result v9

    const/4 v11, -0x1

    if-eq v9, v11, :cond_4

    .line 53
    int-to-long v11, v9

    add-long/2addr v6, v11

    const-wide/32 v11, 0x400000

    cmp-long v11, v6, v11

    if-gtz v11, :cond_3

    .line 54
    invoke-virtual {v10, v5, v3, v9}, Ljava/io/FileOutputStream;->write([BII)V

    goto :goto_1

    .line 53
    :cond_3
    new-instance v1, Ljava/lang/IllegalArgumentException;

    const-string v2, "template size limit"

    invoke-direct {v1, v2}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw v1
    :try_end_4
    .catchall {:try_start_4 .. :try_end_4} :catchall_0

    .line 56
    :cond_4
    :try_start_5
    invoke-virtual {v10}, Ljava/io/FileOutputStream;->close()V

    .line 57
    invoke-virtual {v4}, Ljava/util/zip/ZipInputStream;->closeEntry()V
    :try_end_5
    .catchall {:try_start_5 .. :try_end_5} :catchall_2

    .line 58
    goto :goto_0

    .line 51
    :catchall_0
    move-exception v1

    :try_start_6
    invoke-virtual {v10}, Ljava/io/FileOutputStream;->close()V
    :try_end_6
    .catchall {:try_start_6 .. :try_end_6} :catchall_1

    goto :goto_2

    :catchall_1
    move-exception v2

    :try_start_7
    invoke-virtual {v1, v2}, Ljava/lang/Throwable;->addSuppressed(Ljava/lang/Throwable;)V

    :goto_2
    throw v1

    .line 50
    :cond_5
    new-instance v1, Ljava/lang/IllegalArgumentException;

    const-string v2, "duplicate template entry"

    invoke-direct {v1, v2}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw v1

    .line 48
    :cond_6
    new-instance v1, Ljava/lang/IllegalArgumentException;

    const-string v2, "unexpected template entry"

    invoke-direct {v1, v2}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw v1
    :try_end_7
    .catchall {:try_start_7 .. :try_end_7} :catchall_2

    .line 59
    :cond_7
    :try_start_8
    invoke-virtual {v4}, Ljava/util/zip/ZipInputStream;->close()V
    :try_end_8
    .catchall {:try_start_8 .. :try_end_8} :catchall_4

    if-eqz p0, :cond_8

    :try_start_9
    invoke-virtual {p0}, Ljava/io/InputStream;->close()V

    .line 60
    :cond_8
    const/16 p0, 0xd

    if-ne v8, p0, :cond_9

    new-instance p0, Ljava/io/File;

    const-string v4, "config.json"

    invoke-direct {p0, v1, v4}, Ljava/io/File;-><init>(Ljava/io/File;Ljava/lang/String;)V

    invoke-virtual {p0}, Ljava/io/File;->isFile()Z

    move-result p0

    if-eqz p0, :cond_9

    new-instance p0, Ljava/io/File;

    const-string v4, "leica.webp"

    invoke-direct {p0, v1, v4}, Ljava/io/File;-><init>(Ljava/io/File;Ljava/lang/String;)V

    invoke-virtual {p0}, Ljava/io/File;->isFile()Z

    move-result p0

    if-eqz p0, :cond_9

    .line 62
    invoke-virtual {v1}, Ljava/io/File;->toPath()Ljava/nio/file/Path;

    move-result-object p0

    invoke-virtual {v2}, Ljava/io/File;->toPath()Ljava/nio/file/Path;

    move-result-object v1

    const/4 v2, 0x1

    new-array v2, v2, [Ljava/nio/file/CopyOption;

    sget-object v4, Ljava/nio/file/StandardCopyOption;->ATOMIC_MOVE:Ljava/nio/file/StandardCopyOption;

    aput-object v4, v2, v3

    invoke-static {p0, v1, v2}, Ljava/nio/file/Files;->move(Ljava/nio/file/Path;Ljava/nio/file/Path;[Ljava/nio/file/CopyOption;)Ljava/nio/file/Path;

    .line 63
    new-instance p0, Ljava/lang/StringBuilder;

    invoke-direct {p0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "[LegendaryWatermark] Live Moment135 installed from module assets files="

    invoke-virtual {p0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p0

    invoke-virtual {p0, v8}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object p0

    const-string v1, " bytes="

    invoke-virtual {p0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p0

    invoke-virtual {p0, v6, v7}, Ljava/lang/StringBuilder;->append(J)Ljava/lang/StringBuilder;

    move-result-object p0

    const-string v1, " selectionUnchanged=true noExternalDataDependency=true"

    invoke-virtual {p0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p0

    invoke-virtual {p0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p0

    invoke-static {p0}, Lde/robv/android/xposed/XposedBridge;->log(Ljava/lang/String;)V
    :try_end_9
    .catchall {:try_start_9 .. :try_end_9} :catchall_6

    .line 65
    monitor-exit v0

    return-void

    .line 61
    :cond_9
    :try_start_a
    new-instance p0, Ljava/lang/IllegalArgumentException;

    const-string v1, "incomplete native template"

    invoke-direct {p0, v1}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw p0
    :try_end_a
    .catchall {:try_start_a .. :try_end_a} :catchall_6

    .line 42
    :catchall_2
    move-exception v1

    :try_start_b
    invoke-virtual {v4}, Ljava/util/zip/ZipInputStream;->close()V
    :try_end_b
    .catchall {:try_start_b .. :try_end_b} :catchall_3

    goto :goto_3

    :catchall_3
    move-exception v2

    :try_start_c
    invoke-virtual {v1, v2}, Ljava/lang/Throwable;->addSuppressed(Ljava/lang/Throwable;)V

    :goto_3
    throw v1
    :try_end_c
    .catchall {:try_start_c .. :try_end_c} :catchall_4

    :catchall_4
    move-exception v1

    if-eqz p0, :cond_a

    :try_start_d
    invoke-virtual {p0}, Ljava/io/InputStream;->close()V
    :try_end_d
    .catchall {:try_start_d .. :try_end_d} :catchall_5

    goto :goto_4

    :catchall_5
    move-exception p0

    :try_start_e
    invoke-virtual {v1, p0}, Ljava/lang/Throwable;->addSuppressed(Ljava/lang/Throwable;)V

    :cond_a
    :goto_4
    throw v1
    :try_end_e
    .catchall {:try_start_e .. :try_end_e} :catchall_6

    .line 38
    :cond_b
    :goto_5
    monitor-exit v0

    return-void

    .line 34
    :cond_c
    :goto_6
    monitor-exit v0

    return-void

    .line 31
    :catchall_6
    move-exception p0

    :try_start_f
    monitor-exit v0
    :try_end_f
    .catchall {:try_start_f .. :try_end_f} :catchall_6

    throw p0
.end method

.method static install(Ljava/lang/ClassLoader;)V
    .locals 3
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/lang/Exception;
        }
    .end annotation

    .line 21
    const-string v0, "Gg.s"

    invoke-static {v0, p0}, Lde/robv/android/xposed/XposedHelpers;->findClass(Ljava/lang/String;Ljava/lang/ClassLoader;)Ljava/lang/Class;

    move-result-object p0

    .line 22
    const-class v0, Ljava/io/File;

    const-class v1, Ljava/util/ArrayList;

    sget-object v2, Ljava/lang/Boolean;->TYPE:Ljava/lang/Class;

    filled-new-array {v0, v1, v2}, [Ljava/lang/Class;

    move-result-object v0

    const-string v1, "g"

    invoke-virtual {p0, v1, v0}, Ljava/lang/Class;->getDeclaredMethod(Ljava/lang/String;[Ljava/lang/Class;)Ljava/lang/reflect/Method;

    move-result-object p0

    .line 23
    invoke-virtual {p0}, Ljava/lang/reflect/Method;->getReturnType()Ljava/lang/Class;

    move-result-object v0

    const-class v1, Ljava/util/ArrayList;

    if-ne v0, v1, :cond_0

    .line 24
    new-instance v0, Llocal/mio/os4camerabridge/LegendaryWatermarkResources$1;

    invoke-direct {v0}, Llocal/mio/os4camerabridge/LegendaryWatermarkResources$1;-><init>()V

    invoke-static {p0, v0}, Lde/robv/android/xposed/XposedBridge;->hookMethod(Ljava/lang/reflect/Member;Lde/robv/android/xposed/XC_MethodHook;)Lde/robv/android/xposed/XC_MethodHook$Unhook;

    .line 30
    return-void

    .line 23
    :cond_0
    new-instance p0, Ljava/lang/IllegalStateException;

    const-string v0, "watermark scan signature"

    invoke-direct {p0, v0}, Ljava/lang/IllegalStateException;-><init>(Ljava/lang/String;)V

    throw p0
.end method
