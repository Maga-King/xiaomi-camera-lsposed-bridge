.class Llocal/mio/os4camerabridge/JpegWatermarkMetadataBridge$2;
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
.field final synthetic val$rawAttribute:Ljava/lang/reflect/Method;

.field final synthetic val$rawString:Ljava/lang/reflect/Method;

.field final synthetic val$read:Ljava/lang/reflect/Method;

.field final synthetic val$taskExif:Ljava/lang/reflect/Method;

.field final synthetic val$write:Ljava/lang/reflect/Method;


# direct methods
.method constructor <init>(ILjava/lang/reflect/Method;Ljava/lang/reflect/Method;Ljava/lang/reflect/Method;Ljava/lang/reflect/Method;Ljava/lang/reflect/Method;)V
    .locals 0

    .line 108
    iput-object p2, p0, Llocal/mio/os4camerabridge/JpegWatermarkMetadataBridge$2;->val$taskExif:Ljava/lang/reflect/Method;

    iput-object p3, p0, Llocal/mio/os4camerabridge/JpegWatermarkMetadataBridge$2;->val$read:Ljava/lang/reflect/Method;

    iput-object p4, p0, Llocal/mio/os4camerabridge/JpegWatermarkMetadataBridge$2;->val$write:Ljava/lang/reflect/Method;

    iput-object p5, p0, Llocal/mio/os4camerabridge/JpegWatermarkMetadataBridge$2;->val$rawAttribute:Ljava/lang/reflect/Method;

    iput-object p6, p0, Llocal/mio/os4camerabridge/JpegWatermarkMetadataBridge$2;->val$rawString:Ljava/lang/reflect/Method;

    invoke-direct {p0, p1}, Lde/robv/android/xposed/XC_MethodHook;-><init>(I)V

    return-void
.end method


# virtual methods
.method protected beforeHookedMethod(Lde/robv/android/xposed/XC_MethodHook$MethodHookParam;)V
    .locals 11

    .line 110
    iget-object p1, p1, Lde/robv/android/xposed/XC_MethodHook$MethodHookParam;->args:[Ljava/lang/Object;

    const/4 v0, 0x0

    aget-object p1, p1, v0

    .line 112
    invoke-static {}, Llocal/mio/os4camerabridge/JpegWatermarkMetadataBridge;->-$$Nest$sfgetPENDING()Ljava/util/Map;

    move-result-object v1

    monitor-enter v1

    :try_start_0
    invoke-static {}, Llocal/mio/os4camerabridge/JpegWatermarkMetadataBridge;->-$$Nest$sfgetPENDING()Ljava/util/Map;

    move-result-object v2

    invoke-interface {v2, p1}, Ljava/util/Map;->remove(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v2

    check-cast v2, Llocal/mio/os4camerabridge/JpegWatermarkMetadataBridge$Pending;

    monitor-exit v1
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_1

    .line 113
    if-nez v2, :cond_0

    return-void

    .line 115
    :cond_0
    :try_start_1
    const-string v1, "a"

    invoke-static {p1, v1}, Llocal/mio/os4camerabridge/JpegWatermarkMetadataBridge;->-$$Nest$smfield(Ljava/lang/Object;Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v1

    .line 116
    const-string v3, "f"

    invoke-static {v1, v3}, Lde/robv/android/xposed/XposedHelpers;->getLongField(Ljava/lang/Object;Ljava/lang/String;)J

    move-result-wide v3

    iget-wide v5, v2, Llocal/mio/os4camerabridge/JpegWatermarkMetadataBridge$Pending;->timestamp:J

    cmp-long v3, v3, v5

    if-eqz v3, :cond_1

    return-void

    .line 117
    :cond_1
    const-string v3, "i"

    invoke-static {v1, v3}, Llocal/mio/os4camerabridge/JpegWatermarkMetadataBridge;->-$$Nest$smfield(Ljava/lang/Object;Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v1

    check-cast v1, [B

    .line 118
    invoke-static {v1}, Llocal/mio/os4camerabridge/JpegWatermarkMetadataPolicy;->dimensions([B)[I

    move-result-object v3

    .line 119
    if-nez v3, :cond_2

    return-void

    .line 122
    :cond_2
    iget-object v4, p0, Llocal/mio/os4camerabridge/JpegWatermarkMetadataBridge$2;->val$taskExif:Ljava/lang/reflect/Method;

    filled-new-array {v1}, [Ljava/lang/Object;

    move-result-object v1

    invoke-virtual {v4, p1, v1}, Ljava/lang/reflect/Method;->invoke(Ljava/lang/Object;[Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object p1

    .line 123
    nop

    .line 124
    iget-object v1, v2, Llocal/mio/os4camerabridge/JpegWatermarkMetadataBridge$Pending;->values:Ljava/util/Map;

    invoke-interface {v1}, Ljava/util/Map;->entrySet()Ljava/util/Set;

    move-result-object v1

    invoke-interface {v1}, Ljava/util/Set;->iterator()Ljava/util/Iterator;

    move-result-object v1

    move v4, v0

    :goto_0
    invoke-interface {v1}, Ljava/util/Iterator;->hasNext()Z

    move-result v5

    if-eqz v5, :cond_5

    invoke-interface {v1}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v5

    check-cast v5, Ljava/util/Map$Entry;

    .line 125
    iget-object v6, p0, Llocal/mio/os4camerabridge/JpegWatermarkMetadataBridge$2;->val$read:Ljava/lang/reflect/Method;

    invoke-interface {v5}, Ljava/util/Map$Entry;->getKey()Ljava/lang/Object;

    move-result-object v7

    filled-new-array {v7}, [Ljava/lang/Object;

    move-result-object v7

    invoke-virtual {v6, p1, v7}, Ljava/lang/reflect/Method;->invoke(Ljava/lang/Object;[Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v6

    check-cast v6, Ljava/lang/String;

    .line 126
    invoke-interface {v5}, Ljava/util/Map$Entry;->getValue()Ljava/lang/Object;

    move-result-object v7

    check-cast v7, Ljava/lang/String;

    invoke-static {v7, v6}, Llocal/mio/os4camerabridge/JpegWatermarkMetadataPolicy;->needsRestore(Ljava/lang/String;Ljava/lang/String;)Z

    move-result v6

    if-eqz v6, :cond_4

    .line 127
    iget-object v6, p0, Llocal/mio/os4camerabridge/JpegWatermarkMetadataBridge$2;->val$write:Ljava/lang/reflect/Method;

    invoke-interface {v5}, Ljava/util/Map$Entry;->getKey()Ljava/lang/Object;

    move-result-object v7

    invoke-interface {v5}, Ljava/util/Map$Entry;->getValue()Ljava/lang/Object;

    move-result-object v8

    filled-new-array {v7, v8}, [Ljava/lang/Object;

    move-result-object v7

    invoke-virtual {v6, p1, v7}, Ljava/lang/reflect/Method;->invoke(Ljava/lang/Object;[Ljava/lang/Object;)Ljava/lang/Object;

    .line 128
    iget-object v6, p0, Llocal/mio/os4camerabridge/JpegWatermarkMetadataBridge$2;->val$read:Ljava/lang/reflect/Method;

    invoke-interface {v5}, Ljava/util/Map$Entry;->getKey()Ljava/lang/Object;

    move-result-object v7

    filled-new-array {v7}, [Ljava/lang/Object;

    move-result-object v7

    invoke-virtual {v6, p1, v7}, Ljava/lang/reflect/Method;->invoke(Ljava/lang/Object;[Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v6

    if-eqz v6, :cond_3

    add-int/lit8 v4, v4, 0x1

    goto :goto_1

    .line 129
    :cond_3
    invoke-interface {v5}, Ljava/util/Map$Entry;->getKey()Ljava/lang/Object;

    move-result-object v5

    check-cast v5, Ljava/lang/String;

    new-instance v6, Ljava/lang/StringBuilder;

    invoke-direct {v6}, Ljava/lang/StringBuilder;-><init>()V

    const-string v7, "[WatermarkMetadata] writer rejected "

    invoke-virtual {v6, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    invoke-virtual {v6, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v5

    invoke-static {v5}, Lde/robv/android/xposed/XposedBridge;->log(Ljava/lang/String;)V

    .line 131
    :cond_4
    :goto_1
    goto :goto_0

    .line 132
    :cond_5
    const-string v1, "PixelXDimension"

    const-string v5, "PixelYDimension"

    filled-new-array {v1, v5}, [Ljava/lang/String;

    move-result-object v1

    .line 133
    move v5, v0

    :goto_2
    const/4 v6, 0x2

    if-ge v5, v6, :cond_7

    .line 134
    iget-object v6, p0, Llocal/mio/os4camerabridge/JpegWatermarkMetadataBridge$2;->val$read:Ljava/lang/reflect/Method;

    aget-object v7, v1, v5

    filled-new-array {v7}, [Ljava/lang/Object;

    move-result-object v7

    invoke-virtual {v6, p1, v7}, Ljava/lang/reflect/Method;->invoke(Ljava/lang/Object;[Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v6

    check-cast v6, Ljava/lang/String;

    .line 135
    aget v7, v3, v5

    invoke-static {v7}, Ljava/lang/Integer;->toString(I)Ljava/lang/String;

    move-result-object v7

    .line 136
    invoke-static {v7, v6}, Llocal/mio/os4camerabridge/JpegWatermarkMetadataPolicy;->needsRestore(Ljava/lang/String;Ljava/lang/String;)Z

    move-result v6

    if-eqz v6, :cond_6

    .line 137
    iget-object v6, p0, Llocal/mio/os4camerabridge/JpegWatermarkMetadataBridge$2;->val$write:Ljava/lang/reflect/Method;

    aget-object v8, v1, v5

    filled-new-array {v8, v7}, [Ljava/lang/Object;

    move-result-object v7

    invoke-virtual {v6, p1, v7}, Ljava/lang/reflect/Method;->invoke(Ljava/lang/Object;[Ljava/lang/Object;)Ljava/lang/Object;

    .line 138
    iget-object v6, p0, Llocal/mio/os4camerabridge/JpegWatermarkMetadataBridge$2;->val$read:Ljava/lang/reflect/Method;

    aget-object v7, v1, v5

    filled-new-array {v7}, [Ljava/lang/Object;

    move-result-object v7

    invoke-virtual {v6, p1, v7}, Ljava/lang/reflect/Method;->invoke(Ljava/lang/Object;[Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v6

    if-eqz v6, :cond_6

    add-int/lit8 v4, v4, 0x1

    .line 133
    :cond_6
    add-int/lit8 v5, v5, 0x1

    goto :goto_2

    .line 141
    :cond_7
    iget v1, v2, Llocal/mio/os4camerabridge/JpegWatermarkMetadataBridge$Pending;->module:I

    iget-wide v5, v2, Llocal/mio/os4camerabridge/JpegWatermarkMetadataBridge$Pending;->timestamp:J

    aget v0, v3, v0

    const/4 v7, 0x1

    aget v3, v3, v7

    iget-object v7, p0, Llocal/mio/os4camerabridge/JpegWatermarkMetadataBridge$2;->val$read:Ljava/lang/reflect/Method;

    const-string v8, "ISOSpeedRatings"

    filled-new-array {v8}, [Ljava/lang/Object;

    move-result-object v8

    .line 145
    invoke-virtual {v7, p1, v8}, Ljava/lang/reflect/Method;->invoke(Ljava/lang/Object;[Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v7

    invoke-static {v7}, Ljava/lang/String;->valueOf(Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v7

    iget-object v8, p0, Llocal/mio/os4camerabridge/JpegWatermarkMetadataBridge$2;->val$read:Ljava/lang/reflect/Method;

    const-string v9, "ExposureTime"

    filled-new-array {v9}, [Ljava/lang/Object;

    move-result-object v9

    .line 146
    invoke-virtual {v8, p1, v9}, Ljava/lang/reflect/Method;->invoke(Ljava/lang/Object;[Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v8

    invoke-static {v8}, Ljava/lang/String;->valueOf(Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v8

    new-instance v9, Ljava/lang/StringBuilder;

    invoke-direct {v9}, Ljava/lang/StringBuilder;-><init>()V

    const-string v10, "[WatermarkMetadata] restored="

    invoke-virtual {v9, v10}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v9

    invoke-virtual {v9, v4}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v4

    const-string v9, " module="

    invoke-virtual {v4, v9}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4, v1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v4, " ts="

    invoke-virtual {v1, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, v5, v6}, Ljava/lang/StringBuilder;->append(J)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v4, " encoded="

    invoke-virtual {v1, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, v0}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, "x"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, v3}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, " orientationUnchanged=true cachedExifOnly=true afterEffect=true iso="

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, " exposure="

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, v8}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    .line 141
    invoke-static {v0}, Lde/robv/android/xposed/XposedBridge;->log(Ljava/lang/String;)V

    .line 147
    iget-object v0, p0, Llocal/mio/os4camerabridge/JpegWatermarkMetadataBridge$2;->val$rawAttribute:Ljava/lang/reflect/Method;

    const-string v1, "ExposureTime"

    filled-new-array {v1}, [Ljava/lang/Object;

    move-result-object v1

    invoke-virtual {v0, p1, v1}, Ljava/lang/reflect/Method;->invoke(Ljava/lang/Object;[Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0

    .line 148
    if-eqz v0, :cond_8

    iget-object v1, p0, Llocal/mio/os4camerabridge/JpegWatermarkMetadataBridge$2;->val$rawString:Ljava/lang/reflect/Method;

    const-string v3, "m"

    .line 149
    invoke-static {p1, v3}, Lde/robv/android/xposed/XposedHelpers;->getObjectField(Ljava/lang/Object;Ljava/lang/String;)Ljava/lang/Object;

    move-result-object p1

    filled-new-array {p1}, [Ljava/lang/Object;

    move-result-object p1

    invoke-virtual {v1, v0, p1}, Ljava/lang/reflect/Method;->invoke(Ljava/lang/Object;[Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object p1

    invoke-static {p1}, Ljava/lang/String;->valueOf(Ljava/lang/Object;)Ljava/lang/String;

    move-result-object p1

    iget-object v0, v2, Llocal/mio/os4camerabridge/JpegWatermarkMetadataBridge$Pending;->values:Ljava/util/Map;

    const-string v1, "ExposureTime"

    .line 150
    invoke-interface {v0, v1}, Ljava/util/Map;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/lang/String;

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "[WatermarkMetadata] exposure rational="

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p1

    const-string v1, " expected="

    invoke-virtual {p1, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p1

    invoke-virtual {p1, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p1

    invoke-virtual {p1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p1

    .line 148
    invoke-static {p1}, Lde/robv/android/xposed/XposedBridge;->log(Ljava/lang/String;)V
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    .line 151
    :cond_8
    goto :goto_3

    :catchall_0
    move-exception p1

    const-string v0, "preservation incomplete"

    invoke-static {v0, p1}, Llocal/mio/os4camerabridge/JpegWatermarkMetadataBridge;->-$$Nest$smreport(Ljava/lang/String;Ljava/lang/Throwable;)V

    .line 152
    :goto_3
    return-void

    .line 112
    :catchall_1
    move-exception p1

    :try_start_2
    monitor-exit v1
    :try_end_2
    .catchall {:try_start_2 .. :try_end_2} :catchall_1

    throw p1
.end method
