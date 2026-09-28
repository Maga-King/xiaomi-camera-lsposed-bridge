.class Llocal/mio/os4camerabridge/SoftwareBeautyBridge$6;
.super Lde/robv/android/xposed/XC_MethodHook;
.source "SoftwareBeautyBridge.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Llocal/mio/os4camerabridge/SoftwareBeautyBridge;->bind(Lorg/luckypray/dexkit/DexKitBridge;Ljava/lang/ClassLoader;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# direct methods
.method constructor <init>()V
    .locals 0

    .line 174
    invoke-direct {p0}, Lde/robv/android/xposed/XC_MethodHook;-><init>()V

    return-void
.end method


# virtual methods
.method protected beforeHookedMethod(Lde/robv/android/xposed/XC_MethodHook$MethodHookParam;)V
    .locals 10

    .line 176
    invoke-static {}, Llocal/mio/os4camerabridge/SoftwareBeautyBridge;->-$$Nest$sminScope()Z

    move-result v0

    if-nez v0, :cond_0

    return-void

    .line 177
    :cond_0
    iget-object v0, p1, Lde/robv/android/xposed/XC_MethodHook$MethodHookParam;->args:[Ljava/lang/Object;

    array-length v1, v0

    const/4 v2, 0x0

    move v3, v2

    :goto_0
    if-ge v3, v1, :cond_3

    aget-object v4, v0, v3

    instance-of v5, v4, [B

    if-eqz v5, :cond_2

    .line 178
    check-cast v4, [B

    .line 179
    iget-object v5, p1, Lde/robv/android/xposed/XC_MethodHook$MethodHookParam;->method:Ljava/lang/reflect/Member;

    invoke-static {v5}, Ljava/lang/String;->valueOf(Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v5

    array-length v6, v4

    array-length v7, v4

    const/4 v8, 0x2

    if-le v7, v8, :cond_1

    aget-byte v7, v4, v2

    const/16 v8, 0xff

    and-int/2addr v7, v8

    if-ne v7, v8, :cond_1

    const/4 v7, 0x1

    aget-byte v4, v4, v7

    and-int/2addr v4, v8

    const/16 v8, 0xd8

    if-ne v4, v8, :cond_1

    goto :goto_1

    :cond_1
    move v7, v2

    :goto_1
    invoke-static {}, Llocal/mio/os4camerabridge/SoftwareBeautyBridge;->-$$Nest$sfgetlevel()I

    move-result v4

    new-instance v8, Ljava/lang/StringBuilder;

    invoke-direct {v8}, Ljava/lang/StringBuilder;-><init>()V

    const-string v9, "[SoftwareBeauty] JPEG boundary="

    invoke-virtual {v8, v9}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v8

    invoke-virtual {v8, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    const-string v8, " length="

    invoke-virtual {v5, v8}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v5

    const-string v6, " jpeg="

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5, v7}, Ljava/lang/StringBuilder;->append(Z)Ljava/lang/StringBuilder;

    move-result-object v5

    const-string v6, " level="

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5, v4}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v4

    invoke-static {v4}, Lde/robv/android/xposed/XposedBridge;->log(Ljava/lang/String;)V

    .line 177
    :cond_2
    add-int/lit8 v3, v3, 0x1

    goto :goto_0

    .line 182
    :cond_3
    return-void
.end method
