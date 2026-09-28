.class Llocal/mio/os4camerabridge/JpegWatermarkMetadataBridge$1;
.super Lde/robv/android/xposed/XC_MethodHook;
.source "JpegWatermarkMetadataBridge.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Llocal/mio/os4camerabridge/JpegWatermarkMetadataBridge;->install(Ljava/lang/ClassLoader;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic val$parse:Ljava/lang/reflect/Constructor;

.field final synthetic val$rawAttribute:Ljava/lang/reflect/Method;

.field final synthetic val$rawString:Ljava/lang/reflect/Method;


# direct methods
.method constructor <init>(ILjava/lang/reflect/Constructor;Ljava/lang/reflect/Method;Ljava/lang/reflect/Method;)V
    .locals 0

    .line 46
    iput-object p2, p0, Llocal/mio/os4camerabridge/JpegWatermarkMetadataBridge$1;->val$parse:Ljava/lang/reflect/Constructor;

    iput-object p3, p0, Llocal/mio/os4camerabridge/JpegWatermarkMetadataBridge$1;->val$rawAttribute:Ljava/lang/reflect/Method;

    iput-object p4, p0, Llocal/mio/os4camerabridge/JpegWatermarkMetadataBridge$1;->val$rawString:Ljava/lang/reflect/Method;

    invoke-direct {p0, p1}, Lde/robv/android/xposed/XC_MethodHook;-><init>(I)V

    return-void
.end method


# virtual methods
.method protected afterHookedMethod(Lde/robv/android/xposed/XC_MethodHook$MethodHookParam;)V
    .locals 7

    .line 87
    const-string v0, "local.mio.watermarkShootingMetadata"

    invoke-virtual {p1, v0}, Lde/robv/android/xposed/XC_MethodHook$MethodHookParam;->getObjectExtra(Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v0

    .line 88
    instance-of v1, v0, Llocal/mio/os4camerabridge/JpegWatermarkMetadataBridge$Snapshot;

    if-eqz v1, :cond_6

    invoke-virtual {p1}, Lde/robv/android/xposed/XC_MethodHook$MethodHookParam;->hasThrowable()Z

    move-result v1

    if-eqz v1, :cond_0

    goto :goto_1

    .line 89
    :cond_0
    check-cast v0, Llocal/mio/os4camerabridge/JpegWatermarkMetadataBridge$Snapshot;

    .line 91
    :try_start_0
    iget-object p1, p1, Lde/robv/android/xposed/XC_MethodHook$MethodHookParam;->args:[Ljava/lang/Object;

    const/4 v1, 0x0

    aget-object p1, p1, v1

    iget-object v1, v0, Llocal/mio/os4camerabridge/JpegWatermarkMetadataBridge$Snapshot;->task:Ljava/lang/Object;

    if-eq p1, v1, :cond_1

    return-void

    .line 92
    :cond_1
    iget-object p1, v0, Llocal/mio/os4camerabridge/JpegWatermarkMetadataBridge$Snapshot;->task:Ljava/lang/Object;

    const-string v1, "a"

    invoke-static {p1, v1}, Llocal/mio/os4camerabridge/JpegWatermarkMetadataBridge;->-$$Nest$smfield(Ljava/lang/Object;Ljava/lang/String;)Ljava/lang/Object;

    move-result-object p1

    .line 93
    const-string v1, "f"

    invoke-static {p1, v1}, Lde/robv/android/xposed/XposedHelpers;->getLongField(Ljava/lang/Object;Ljava/lang/String;)J

    move-result-wide v1

    iget-wide v3, v0, Llocal/mio/os4camerabridge/JpegWatermarkMetadataBridge$Snapshot;->timestamp:J

    cmp-long v1, v1, v3

    if-eqz v1, :cond_2

    return-void

    .line 94
    :cond_2
    const-string v1, "i"

    invoke-static {p1, v1}, Llocal/mio/os4camerabridge/JpegWatermarkMetadataBridge;->-$$Nest$smfield(Ljava/lang/Object;Ljava/lang/String;)Ljava/lang/Object;

    move-result-object p1

    check-cast p1, [B

    .line 95
    iget-object v1, v0, Llocal/mio/os4camerabridge/JpegWatermarkMetadataBridge$Snapshot;->jpeg:[B

    if-ne p1, v1, :cond_3

    return-void

    .line 96
    :cond_3
    invoke-static {p1}, Llocal/mio/os4camerabridge/JpegWatermarkMetadataPolicy;->dimensions([B)[I

    move-result-object p1

    if-nez p1, :cond_4

    return-void

    .line 97
    :cond_4
    invoke-static {}, Llocal/mio/os4camerabridge/JpegWatermarkMetadataBridge;->-$$Nest$sfgetPENDING()Ljava/util/Map;

    move-result-object p1

    monitor-enter p1
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_1

    .line 98
    :try_start_1
    invoke-static {}, Llocal/mio/os4camerabridge/JpegWatermarkMetadataBridge;->-$$Nest$sfgetPENDING()Ljava/util/Map;

    move-result-object v1

    invoke-interface {v1}, Ljava/util/Map;->size()I

    move-result v1

    const/16 v2, 0x40

    if-lt v1, v2, :cond_5

    .line 99
    const-string v0, "[WatermarkMetadata] pending capacity reached; not retained"

    invoke-static {v0}, Lde/robv/android/xposed/XposedBridge;->log(Ljava/lang/String;)V

    .line 100
    monitor-exit p1

    return-void

    .line 102
    :cond_5
    invoke-static {}, Llocal/mio/os4camerabridge/JpegWatermarkMetadataBridge;->-$$Nest$sfgetPENDING()Ljava/util/Map;

    move-result-object v1

    iget-object v2, v0, Llocal/mio/os4camerabridge/JpegWatermarkMetadataBridge$Snapshot;->task:Ljava/lang/Object;

    new-instance v3, Llocal/mio/os4camerabridge/JpegWatermarkMetadataBridge$Pending;

    iget-wide v4, v0, Llocal/mio/os4camerabridge/JpegWatermarkMetadataBridge$Snapshot;->timestamp:J

    iget-object v6, v0, Llocal/mio/os4camerabridge/JpegWatermarkMetadataBridge$Snapshot;->values:Ljava/util/Map;

    iget v0, v0, Llocal/mio/os4camerabridge/JpegWatermarkMetadataBridge$Snapshot;->module:I

    invoke-direct {v3, v4, v5, v6, v0}, Llocal/mio/os4camerabridge/JpegWatermarkMetadataBridge$Pending;-><init>(JLjava/util/Map;I)V

    invoke-interface {v1, v2, v3}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 104
    monitor-exit p1

    .line 105
    goto :goto_0

    .line 104
    :catchall_0
    move-exception v0

    monitor-exit p1
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    :try_start_2
    throw v0
    :try_end_2
    .catchall {:try_start_2 .. :try_end_2} :catchall_1

    .line 105
    :catchall_1
    move-exception p1

    const-string v0, "water handoff failed"

    invoke-static {v0, p1}, Llocal/mio/os4camerabridge/JpegWatermarkMetadataBridge;->-$$Nest$smreport(Ljava/lang/String;Ljava/lang/Throwable;)V

    .line 106
    :goto_0
    return-void

    .line 88
    :cond_6
    :goto_1
    return-void
.end method

.method protected beforeHookedMethod(Lde/robv/android/xposed/XC_MethodHook$MethodHookParam;)V
    .locals 16

    .line 49
    move-object/from16 v0, p0

    move-object/from16 v1, p1

    const-string v2, "f"

    :try_start_0
    iget-object v3, v1, Lde/robv/android/xposed/XC_MethodHook$MethodHookParam;->args:[Ljava/lang/Object;

    const/4 v4, 0x0

    aget-object v6, v3, v4

    .line 50
    const-string v3, "b"

    invoke-static {v6, v3}, Llocal/mio/os4camerabridge/JpegWatermarkMetadataBridge;->-$$Nest$smfield(Ljava/lang/Object;Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v3

    .line 51
    const-string v5, "g"

    invoke-static {v3, v5}, Lde/robv/android/xposed/XposedHelpers;->getIntField(Ljava/lang/Object;Ljava/lang/String;)I

    move-result v11

    .line 54
    const-string v5, "d"

    invoke-static {v3, v5}, Lde/robv/android/xposed/XposedHelpers;->getBooleanField(Ljava/lang/Object;Ljava/lang/String;)Z

    move-result v5

    const/4 v7, 0x1

    if-eqz v5, :cond_0

    move v5, v7

    goto :goto_0

    :cond_0
    move v5, v4

    .line 55
    :goto_0
    invoke-static {v3, v2}, Lde/robv/android/xposed/XposedHelpers;->getIntField(Ljava/lang/Object;Ljava/lang/String;)I

    move-result v3

    .line 56
    const-string v8, "l"

    invoke-static {v6, v8}, Llocal/mio/os4camerabridge/JpegWatermarkMetadataBridge;->-$$Nest$smfield(Ljava/lang/Object;Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v8

    const-string v9, "e"

    invoke-static {v8, v9}, Lde/robv/android/xposed/XposedHelpers;->getBooleanField(Ljava/lang/Object;Ljava/lang/String;)Z

    move-result v8

    .line 57
    invoke-static {v11, v5, v3, v8}, Llocal/mio/os4camerabridge/JpegWatermarkMetadataPolicy;->eligible(IIIZ)Z

    move-result v9

    if-nez v9, :cond_4

    .line 58
    const/16 v0, 0xa3

    if-eq v11, v0, :cond_1

    const/16 v0, 0xa7

    if-ne v11, v0, :cond_3

    .line 59
    :cond_1
    if-ne v5, v7, :cond_2

    move v4, v7

    :cond_2
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "[WatermarkMetadata] gate module="

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, v11}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, " front="

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, v4}, Ljava/lang/StringBuilder;->append(Z)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, " type="

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, v3}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, " water="

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, v8}, Ljava/lang/StringBuilder;->append(Z)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Lde/robv/android/xposed/XposedBridge;->log(Ljava/lang/String;)V

    .line 61
    :cond_3
    return-void

    .line 63
    :cond_4
    const-string v3, "a"

    invoke-static {v6, v3}, Llocal/mio/os4camerabridge/JpegWatermarkMetadataBridge;->-$$Nest$smfield(Ljava/lang/Object;Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v3

    .line 64
    const-string v5, "i"

    invoke-static {v3, v5}, Llocal/mio/os4camerabridge/JpegWatermarkMetadataBridge;->-$$Nest$smfield(Ljava/lang/Object;Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v5

    move-object v9, v5

    check-cast v9, [B

    .line 65
    invoke-static {v9}, Llocal/mio/os4camerabridge/JpegWatermarkMetadataPolicy;->dimensions([B)[I

    move-result-object v5

    if-nez v5, :cond_5

    .line 66
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "[WatermarkMetadata] invalid input SOF module="

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, v11}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Lde/robv/android/xposed/XposedBridge;->log(Ljava/lang/String;)V

    .line 67
    return-void

    .line 69
    :cond_5
    iget-object v5, v0, Llocal/mio/os4camerabridge/JpegWatermarkMetadataBridge$1;->val$parse:Ljava/lang/reflect/Constructor;

    new-instance v7, Ljava/io/ByteArrayInputStream;

    invoke-direct {v7, v9}, Ljava/io/ByteArrayInputStream;-><init>([B)V

    filled-new-array {v7}, [Ljava/lang/Object;

    move-result-object v7

    invoke-virtual {v5, v7}, Ljava/lang/reflect/Constructor;->newInstance([Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v5

    .line 70
    new-instance v10, Ljava/util/LinkedHashMap;

    invoke-direct {v10}, Ljava/util/LinkedHashMap;-><init>()V

    .line 71
    sget-object v7, Llocal/mio/os4camerabridge/JpegWatermarkMetadataPolicy;->SHOOTING_TAGS:[Ljava/lang/String;

    array-length v8, v7

    :goto_1
    if-ge v4, v8, :cond_8

    aget-object v12, v7, v4

    .line 74
    iget-object v13, v0, Llocal/mio/os4camerabridge/JpegWatermarkMetadataBridge$1;->val$rawAttribute:Ljava/lang/reflect/Method;

    filled-new-array {v12}, [Ljava/lang/Object;

    move-result-object v14

    invoke-virtual {v13, v5, v14}, Ljava/lang/reflect/Method;->invoke(Ljava/lang/Object;[Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v13

    .line 75
    if-nez v13, :cond_6

    const/4 v13, 0x0

    goto :goto_2

    :cond_6
    iget-object v15, v0, Llocal/mio/os4camerabridge/JpegWatermarkMetadataBridge$1;->val$rawString:Ljava/lang/reflect/Method;

    const-string v14, "m"

    .line 76
    invoke-static {v5, v14}, Lde/robv/android/xposed/XposedHelpers;->getObjectField(Ljava/lang/Object;Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v14

    filled-new-array {v14}, [Ljava/lang/Object;

    move-result-object v14

    .line 75
    invoke-virtual {v15, v13, v14}, Ljava/lang/reflect/Method;->invoke(Ljava/lang/Object;[Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v13

    check-cast v13, Ljava/lang/String;

    .line 77
    :goto_2
    const/4 v14, 0x0

    invoke-static {v13, v14}, Llocal/mio/os4camerabridge/JpegWatermarkMetadataPolicy;->needsRestore(Ljava/lang/String;Ljava/lang/String;)Z

    move-result v14

    if-eqz v14, :cond_7

    invoke-interface {v10, v12, v13}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 71
    :cond_7
    add-int/lit8 v4, v4, 0x1

    goto :goto_1

    .line 79
    :cond_8
    const-string v0, "local.mio.watermarkShootingMetadata"

    new-instance v5, Llocal/mio/os4camerabridge/JpegWatermarkMetadataBridge$Snapshot;

    .line 80
    invoke-static {v3, v2}, Lde/robv/android/xposed/XposedHelpers;->getLongField(Ljava/lang/Object;Ljava/lang/String;)J

    move-result-wide v7

    invoke-direct/range {v5 .. v11}, Llocal/mio/os4camerabridge/JpegWatermarkMetadataBridge$Snapshot;-><init>(Ljava/lang/Object;J[BLjava/util/Map;I)V

    .line 79
    invoke-virtual {v1, v0, v5}, Lde/robv/android/xposed/XC_MethodHook$MethodHookParam;->setObjectExtra(Ljava/lang/String;Ljava/lang/Object;)V

    .line 81
    nop

    .line 82
    invoke-interface {v10}, Ljava/util/Map;->size()I

    move-result v0

    const-string v1, "ExposureTime"

    invoke-interface {v10, v1}, Ljava/util/Map;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Ljava/lang/String;

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "[WatermarkMetadata] snapshot module="

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, v11}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v2

    const-string v3, " tags="

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, v0}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v2, " rawExposure="

    invoke-virtual {v0, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    .line 81
    invoke-static {v0}, Lde/robv/android/xposed/XposedBridge;->log(Ljava/lang/String;)V
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 83
    goto :goto_3

    :catchall_0
    move-exception v0

    const-string v1, "input retained"

    invoke-static {v1, v0}, Llocal/mio/os4camerabridge/JpegWatermarkMetadataBridge;->-$$Nest$smreport(Ljava/lang/String;Ljava/lang/Throwable;)V

    .line 84
    :goto_3
    return-void
.end method
