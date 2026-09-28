.class public final Llocal/mio/os4camerabridge/DexKitCameraContracts;
.super Ljava/lang/Object;
.source "DexKitCameraContracts.java"


# static fields
.field private static volatile featureDescription:Ljava/lang/String;

.field private static final started:Ljava/util/concurrent/atomic/AtomicBoolean;


# direct methods
.method static bridge synthetic -$$Nest$sfgetstarted()Ljava/util/concurrent/atomic/AtomicBoolean;
    .locals 1

    sget-object v0, Llocal/mio/os4camerabridge/DexKitCameraContracts;->started:Ljava/util/concurrent/atomic/AtomicBoolean;

    return-object v0
.end method

.method static bridge synthetic -$$Nest$smresolve(Landroid/content/Context;Ljava/lang/ClassLoader;)V
    .locals 0

    invoke-static {p0, p1}, Llocal/mio/os4camerabridge/DexKitCameraContracts;->resolve(Landroid/content/Context;Ljava/lang/ClassLoader;)V

    return-void
.end method

.method static constructor <clinit>()V
    .locals 1

    .line 24
    new-instance v0, Ljava/util/concurrent/atomic/AtomicBoolean;

    invoke-direct {v0}, Ljava/util/concurrent/atomic/AtomicBoolean;-><init>()V

    sput-object v0, Llocal/mio/os4camerabridge/DexKitCameraContracts;->started:Ljava/util/concurrent/atomic/AtomicBoolean;

    .line 25
    const-string v0, "contract scan pending"

    sput-object v0, Llocal/mio/os4camerabridge/DexKitCameraContracts;->featureDescription:Ljava/lang/String;

    return-void
.end method

.method private constructor <init>()V
    .locals 0

    .line 26
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method public static describeFeature()Ljava/lang/String;
    .locals 1

    .line 28
    sget-object v0, Llocal/mio/os4camerabridge/DexKitCameraContracts;->featureDescription:Ljava/lang/String;

    return-object v0
.end method

.method private static findSingletonByType(Ljava/lang/Class;)Ljava/lang/Object;
    .locals 8
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/lang/Class<",
            "*>;)",
            "Ljava/lang/Object;"
        }
    .end annotation

    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/lang/IllegalAccessException;
        }
    .end annotation

    .line 116
    new-instance v0, Ljava/util/ArrayList;

    invoke-direct {v0}, Ljava/util/ArrayList;-><init>()V

    .line 117
    new-instance v1, Ljava/util/ArrayList;

    invoke-direct {v1}, Ljava/util/ArrayList;-><init>()V

    .line 118
    invoke-virtual {v1, p0}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    .line 119
    invoke-virtual {p0}, Ljava/lang/Class;->getDeclaredClasses()[Ljava/lang/Class;

    move-result-object v2

    array-length v3, v2

    const/4 v4, 0x0

    move v5, v4

    :goto_0
    if-ge v5, v3, :cond_0

    aget-object v6, v2, v5

    invoke-virtual {v1, v6}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    add-int/lit8 v5, v5, 0x1

    goto :goto_0

    .line 120
    :cond_0
    invoke-virtual {v1}, Ljava/util/ArrayList;->iterator()Ljava/util/Iterator;

    move-result-object v1

    :cond_1
    invoke-interface {v1}, Ljava/util/Iterator;->hasNext()Z

    move-result v2

    if-eqz v2, :cond_3

    invoke-interface {v1}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v2

    check-cast v2, Ljava/lang/Class;

    invoke-virtual {v2}, Ljava/lang/Class;->getDeclaredFields()[Ljava/lang/reflect/Field;

    move-result-object v2

    array-length v3, v2

    move v5, v4

    :goto_1
    if-ge v5, v3, :cond_1

    aget-object v6, v2, v5

    .line 121
    invoke-virtual {v6}, Ljava/lang/reflect/Field;->getModifiers()I

    move-result v7

    invoke-static {v7}, Ljava/lang/reflect/Modifier;->isStatic(I)Z

    move-result v7

    if-eqz v7, :cond_2

    invoke-virtual {v6}, Ljava/lang/reflect/Field;->getType()Ljava/lang/Class;

    move-result-object v7

    if-ne v7, p0, :cond_2

    invoke-virtual {v0, v6}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    .line 120
    :cond_2
    add-int/lit8 v5, v5, 0x1

    goto :goto_1

    .line 122
    :cond_3
    invoke-virtual {v0}, Ljava/util/ArrayList;->size()I

    move-result p0

    const/4 v1, 0x0

    const/4 v2, 0x1

    if-eq p0, v2, :cond_4

    return-object v1

    .line 123
    :cond_4
    invoke-virtual {v0, v4}, Ljava/util/ArrayList;->get(I)Ljava/lang/Object;

    move-result-object p0

    check-cast p0, Ljava/lang/reflect/Field;

    .line 124
    invoke-virtual {p0, v2}, Ljava/lang/reflect/Field;->setAccessible(Z)V

    .line 125
    invoke-virtual {p0, v1}, Ljava/lang/reflect/Field;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object p0

    return-object p0
.end method

.method private static hasCameraModuleAncestor(Ljava/lang/Class;)Z
    .locals 2
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/lang/Class<",
            "*>;)Z"
        }
    .end annotation

    .line 110
    :cond_0
    invoke-virtual {p0}, Ljava/lang/Class;->getSuperclass()Ljava/lang/Class;

    move-result-object p0

    if-eqz p0, :cond_1

    .line 111
    const-string v0, "com.android.camera.module.Camera2Module"

    invoke-virtual {p0}, Ljava/lang/Class;->getName()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_0

    const/4 p0, 0x1

    return p0

    .line 112
    :cond_1
    const/4 p0, 0x0

    return p0
.end method

.method public static install(Ljava/lang/ClassLoader;)V
    .locals 3

    .line 31
    const-class v0, Landroid/app/Application;

    const-class v1, Landroid/content/Context;

    new-instance v2, Llocal/mio/os4camerabridge/DexKitCameraContracts$1;

    invoke-direct {v2, p0}, Llocal/mio/os4camerabridge/DexKitCameraContracts$1;-><init>(Ljava/lang/ClassLoader;)V

    filled-new-array {v1, v2}, [Ljava/lang/Object;

    move-result-object p0

    const-string v1, "attach"

    invoke-static {v0, v1, p0}, Lde/robv/android/xposed/XposedHelpers;->findAndHookMethod(Ljava/lang/Class;Ljava/lang/String;[Ljava/lang/Object;)Lde/robv/android/xposed/XC_MethodHook$Unhook;

    .line 38
    return-void
.end method

.method private static resolve(Landroid/content/Context;Ljava/lang/ClassLoader;)V
    .locals 12

    .line 41
    invoke-static {}, Landroid/os/SystemClock;->elapsedRealtime()J

    move-result-wide v0

    .line 43
    :try_start_0
    const-string v2, "dexkit"

    invoke-static {v2}, Ljava/lang/System;->loadLibrary(Ljava/lang/String;)V

    .line 44
    invoke-virtual {p0}, Landroid/content/Context;->getApplicationInfo()Landroid/content/pm/ApplicationInfo;

    move-result-object v2

    iget-object v2, v2, Landroid/content/pm/ApplicationInfo;->sourceDir:Ljava/lang/String;

    invoke-static {v2}, Lorg/luckypray/dexkit/DexKitBridge;->create(Ljava/lang/String;)Lorg/luckypray/dexkit/DexKitBridge;

    move-result-object v2
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_2

    .line 45
    :try_start_1
    invoke-static {v2, p1}, Llocal/mio/os4camerabridge/BeautyPanelContractBridge;->bind(Lorg/luckypray/dexkit/DexKitBridge;Ljava/lang/ClassLoader;)V

    .line 46
    invoke-static {}, Llocal/mio/os4camerabridge/SoftwareBeautyBridge;->isEnabled()Z

    move-result v3

    if-eqz v3, :cond_0

    invoke-static {v2, p1}, Llocal/mio/os4camerabridge/SoftwareBeautyBridge;->bind(Lorg/luckypray/dexkit/DexKitBridge;Ljava/lang/ClassLoader;)V

    .line 47
    :cond_0
    invoke-static {}, Llocal/mio/os4camerabridge/SlowMotionRecorderBridge;->isEnabled()Z

    move-result v3

    if-eqz v3, :cond_1

    invoke-static {v2, p1}, Llocal/mio/os4camerabridge/SlowMotionRecorderBridge;->bind(Lorg/luckypray/dexkit/DexKitBridge;Ljava/lang/ClassLoader;)V

    .line 48
    :cond_1
    invoke-static {}, Llocal/mio/os4camerabridge/LegendarySaveContractBridge;->isEnabled()Z

    move-result v3

    if-eqz v3, :cond_2

    invoke-static {v2, p1}, Llocal/mio/os4camerabridge/LegendarySaveContractBridge;->bind(Lorg/luckypray/dexkit/DexKitBridge;Ljava/lang/ClassLoader;)V

    .line 50
    :cond_2
    invoke-static {}, Lorg/luckypray/dexkit/query/FindMethod;->create()Lorg/luckypray/dexkit/query/FindMethod;

    move-result-object v3

    .line 51
    invoke-static {}, Lorg/luckypray/dexkit/query/matchers/MethodMatcher;->create()Lorg/luckypray/dexkit/query/matchers/MethodMatcher;

    move-result-object v4

    const-string v5, "NO_PIXEL"

    filled-new-array {v5}, [Ljava/lang/String;

    move-result-object v5

    invoke-virtual {v4, v5}, Lorg/luckypray/dexkit/query/matchers/MethodMatcher;->usingStrings([Ljava/lang/String;)Lorg/luckypray/dexkit/query/matchers/MethodMatcher;

    move-result-object v4

    sget-object v5, Ljava/lang/Boolean;->TYPE:Ljava/lang/Class;

    invoke-virtual {v4, v5}, Lorg/luckypray/dexkit/query/matchers/MethodMatcher;->returnType(Ljava/lang/Class;)Lorg/luckypray/dexkit/query/matchers/MethodMatcher;

    move-result-object v4

    const/4 v5, 0x0

    invoke-virtual {v4, v5}, Lorg/luckypray/dexkit/query/matchers/MethodMatcher;->paramCount(I)Lorg/luckypray/dexkit/query/matchers/MethodMatcher;

    move-result-object v4

    .line 50
    invoke-virtual {v3, v4}, Lorg/luckypray/dexkit/query/FindMethod;->matcher(Lorg/luckypray/dexkit/query/matchers/MethodMatcher;)Lorg/luckypray/dexkit/query/FindMethod;

    move-result-object v3

    invoke-virtual {v2, v3}, Lorg/luckypray/dexkit/DexKitBridge;->findMethod(Lorg/luckypray/dexkit/query/FindMethod;)Lorg/luckypray/dexkit/result/MethodDataList;

    move-result-object v3

    .line 52
    new-instance v4, Ljava/util/ArrayList;

    invoke-direct {v4}, Ljava/util/ArrayList;-><init>()V

    .line 53
    invoke-virtual {v3}, Lorg/luckypray/dexkit/result/MethodDataList;->iterator()Ljava/util/Iterator;

    move-result-object v3

    :cond_3
    :goto_0
    invoke-interface {v3}, Ljava/util/Iterator;->hasNext()Z

    move-result v6

    const/4 v7, 0x1

    if-eqz v6, :cond_6

    invoke-interface {v3}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v6

    check-cast v6, Lorg/luckypray/dexkit/result/MethodData;

    .line 54
    invoke-virtual {v6, p1}, Lorg/luckypray/dexkit/result/MethodData;->getMethodInstance(Ljava/lang/ClassLoader;)Ljava/lang/reflect/Method;

    move-result-object v6

    .line 55
    invoke-virtual {v6}, Ljava/lang/reflect/Method;->getDeclaringClass()Ljava/lang/Class;

    move-result-object v8

    .line 56
    invoke-virtual {v6}, Ljava/lang/reflect/Method;->getModifiers()I

    move-result v9

    invoke-static {v9}, Ljava/lang/reflect/Modifier;->isStatic(I)Z

    move-result v9

    if-nez v9, :cond_3

    invoke-static {v8}, Llocal/mio/os4camerabridge/DexKitCameraContracts;->hasCameraModuleAncestor(Ljava/lang/Class;)Z

    move-result v9

    if-nez v9, :cond_4

    goto :goto_0

    .line 58
    :cond_4
    invoke-static {}, Lorg/luckypray/dexkit/query/FindMethod;->create()Lorg/luckypray/dexkit/query/FindMethod;

    move-result-object v9

    invoke-static {}, Lorg/luckypray/dexkit/query/matchers/MethodMatcher;->create()Lorg/luckypray/dexkit/query/matchers/MethodMatcher;

    move-result-object v10

    .line 59
    invoke-virtual {v10, v8}, Lorg/luckypray/dexkit/query/matchers/MethodMatcher;->declaredClass(Ljava/lang/Class;)Lorg/luckypray/dexkit/query/matchers/MethodMatcher;

    move-result-object v8

    const-string v10, "PixelModule@"

    filled-new-array {v10}, [Ljava/lang/String;

    move-result-object v10

    invoke-virtual {v8, v10}, Lorg/luckypray/dexkit/query/matchers/MethodMatcher;->usingStrings([Ljava/lang/String;)Lorg/luckypray/dexkit/query/matchers/MethodMatcher;

    move-result-object v8

    .line 58
    invoke-virtual {v9, v8}, Lorg/luckypray/dexkit/query/FindMethod;->matcher(Lorg/luckypray/dexkit/query/matchers/MethodMatcher;)Lorg/luckypray/dexkit/query/FindMethod;

    move-result-object v8

    invoke-virtual {v2, v8}, Lorg/luckypray/dexkit/DexKitBridge;->findMethod(Lorg/luckypray/dexkit/query/FindMethod;)Lorg/luckypray/dexkit/result/MethodDataList;

    move-result-object v8

    .line 60
    invoke-virtual {v8}, Lorg/luckypray/dexkit/result/MethodDataList;->size()I

    move-result v8

    if-ne v8, v7, :cond_5

    invoke-virtual {v4, v6}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    .line 61
    :cond_5
    goto :goto_0

    .line 62
    :cond_6
    invoke-virtual {v4}, Ljava/util/ArrayList;->size()I

    move-result v3

    if-ne v3, v7, :cond_7

    .line 63
    invoke-virtual {v4, v5}, Ljava/util/ArrayList;->get(I)Ljava/lang/Object;

    move-result-object v3

    check-cast v3, Ljava/lang/reflect/Method;

    .line 64
    new-instance v4, Llocal/mio/os4camerabridge/DexKitCameraContracts$2;

    invoke-direct {v4}, Llocal/mio/os4camerabridge/DexKitCameraContracts$2;-><init>()V

    invoke-static {v3, v4}, Lde/robv/android/xposed/XposedBridge;->hookMethod(Ljava/lang/reflect/Member;Lde/robv/android/xposed/XC_MethodHook;)Lde/robv/android/xposed/XC_MethodHook$Unhook;

    .line 67
    invoke-static {v3}, Ljava/lang/String;->valueOf(Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v3

    new-instance v4, Ljava/lang/StringBuilder;

    invoke-direct {v4}, Ljava/lang/StringBuilder;-><init>()V

    const-string v6, "[CameraContracts] pixel parallel bound "

    invoke-virtual {v4, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    invoke-static {v3}, Lde/robv/android/xposed/XposedBridge;->log(Ljava/lang/String;)V

    goto :goto_1

    .line 68
    :cond_7
    invoke-virtual {v4}, Ljava/util/ArrayList;->size()I

    move-result v3

    new-instance v4, Ljava/lang/StringBuilder;

    invoke-direct {v4}, Ljava/lang/StringBuilder;-><init>()V

    const-string v6, "[CameraContracts] pixel ambiguous/missing count="

    invoke-virtual {v4, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4, v3}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    invoke-static {v3}, Lde/robv/android/xposed/XposedBridge;->log(Ljava/lang/String;)V

    :goto_1
    nop

    .line 70
    invoke-static {}, Lorg/luckypray/dexkit/query/FindMethod;->create()Lorg/luckypray/dexkit/query/FindMethod;

    move-result-object v3

    invoke-static {}, Lorg/luckypray/dexkit/query/matchers/MethodMatcher;->create()Lorg/luckypray/dexkit/query/matchers/MethodMatcher;

    move-result-object v4

    const-string v6, "putPictureSize pictureSize = "

    const-string v8, "LoadStreamSizeBase"

    filled-new-array {v6, v8}, [Ljava/lang/String;

    move-result-object v6

    .line 71
    invoke-virtual {v4, v6}, Lorg/luckypray/dexkit/query/matchers/MethodMatcher;->usingStrings([Ljava/lang/String;)Lorg/luckypray/dexkit/query/matchers/MethodMatcher;

    move-result-object v4

    sget-object v6, Ljava/lang/Void;->TYPE:Ljava/lang/Class;

    .line 72
    invoke-virtual {v4, v6}, Lorg/luckypray/dexkit/query/matchers/MethodMatcher;->returnType(Ljava/lang/Class;)Lorg/luckypray/dexkit/query/matchers/MethodMatcher;

    move-result-object v4

    const-class v6, Landroid/util/Size;

    filled-new-array {v6}, [Ljava/lang/Class;

    move-result-object v6

    invoke-virtual {v4, v6}, Lorg/luckypray/dexkit/query/matchers/MethodMatcher;->paramTypes([Ljava/lang/Class;)Lorg/luckypray/dexkit/query/matchers/MethodMatcher;

    move-result-object v4

    .line 70
    invoke-virtual {v3, v4}, Lorg/luckypray/dexkit/query/FindMethod;->matcher(Lorg/luckypray/dexkit/query/matchers/MethodMatcher;)Lorg/luckypray/dexkit/query/FindMethod;

    move-result-object v3

    invoke-virtual {v2, v3}, Lorg/luckypray/dexkit/DexKitBridge;->findMethod(Lorg/luckypray/dexkit/query/FindMethod;)Lorg/luckypray/dexkit/result/MethodDataList;

    move-result-object v3

    .line 73
    invoke-virtual {v3}, Lorg/luckypray/dexkit/result/MethodDataList;->size()I

    move-result v4

    if-ne v4, v7, :cond_9

    .line 74
    invoke-virtual {v3, v5}, Lorg/luckypray/dexkit/result/MethodDataList;->get(I)Ljava/lang/Object;

    move-result-object v3

    check-cast v3, Lorg/luckypray/dexkit/result/MethodData;

    invoke-virtual {v3, p1}, Lorg/luckypray/dexkit/result/MethodData;->getMethodInstance(Ljava/lang/ClassLoader;)Ljava/lang/reflect/Method;

    move-result-object v3

    .line 75
    invoke-virtual {v3}, Ljava/lang/reflect/Method;->getModifiers()I

    move-result v4

    invoke-static {v4}, Ljava/lang/reflect/Modifier;->isStatic(I)Z

    move-result v4

    if-nez v4, :cond_8

    .line 76
    invoke-static {v3}, Ljava/lang/String;->valueOf(Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v3

    new-instance v4, Ljava/lang/StringBuilder;

    invoke-direct {v4}, Ljava/lang/StringBuilder;-><init>()V

    const-string v6, "[CameraContracts] size setter validated "

    invoke-virtual {v4, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    invoke-static {v3}, Lde/robv/android/xposed/XposedBridge;->log(Ljava/lang/String;)V

    goto :goto_2

    .line 75
    :cond_8
    new-instance p0, Ljava/lang/IllegalStateException;

    const-string p1, "Picture-size setter is static"

    invoke-direct {p0, p1}, Ljava/lang/IllegalStateException;-><init>(Ljava/lang/String;)V

    throw p0

    .line 77
    :cond_9
    invoke-virtual {v3}, Lorg/luckypray/dexkit/result/MethodDataList;->size()I

    move-result v3

    new-instance v4, Ljava/lang/StringBuilder;

    invoke-direct {v4}, Ljava/lang/StringBuilder;-><init>()V

    const-string v6, "[CameraContracts] size setter ambiguous/missing count="

    invoke-virtual {v4, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4, v3}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    invoke-static {v3}, Lde/robv/android/xposed/XposedBridge;->log(Ljava/lang/String;)V

    :goto_2
    nop

    .line 79
    invoke-static {}, Lorg/luckypray/dexkit/query/FindClass;->create()Lorg/luckypray/dexkit/query/FindClass;

    move-result-object v3

    invoke-static {}, Lorg/luckypray/dexkit/query/matchers/ClassMatcher;->create()Lorg/luckypray/dexkit/query/matchers/ClassMatcher;

    move-result-object v4

    const-string v6, "DataItemFeature"

    filled-new-array {v6}, [Ljava/lang/String;

    move-result-object v6

    .line 80
    invoke-virtual {v4, v6}, Lorg/luckypray/dexkit/query/matchers/ClassMatcher;->usingStrings([Ljava/lang/String;)Lorg/luckypray/dexkit/query/matchers/ClassMatcher;

    move-result-object v4

    .line 79
    invoke-virtual {v3, v4}, Lorg/luckypray/dexkit/query/FindClass;->matcher(Lorg/luckypray/dexkit/query/matchers/ClassMatcher;)Lorg/luckypray/dexkit/query/FindClass;

    move-result-object v3

    invoke-virtual {v2, v3}, Lorg/luckypray/dexkit/DexKitBridge;->findClass(Lorg/luckypray/dexkit/query/FindClass;)Lorg/luckypray/dexkit/result/ClassDataList;

    move-result-object v3

    .line 81
    invoke-virtual {v3}, Lorg/luckypray/dexkit/result/ClassDataList;->size()I

    move-result v4

    if-ne v4, v7, :cond_d

    .line 82
    invoke-virtual {v3, v5}, Lorg/luckypray/dexkit/result/ClassDataList;->get(I)Ljava/lang/Object;

    move-result-object v3

    check-cast v3, Lorg/luckypray/dexkit/result/ClassData;

    invoke-virtual {v3, p1}, Lorg/luckypray/dexkit/result/ClassData;->getInstance(Ljava/lang/ClassLoader;)Ljava/lang/Class;

    move-result-object p1

    .line 83
    invoke-static {p1}, Llocal/mio/os4camerabridge/DexKitCameraContracts;->findSingletonByType(Ljava/lang/Class;)Ljava/lang/Object;

    move-result-object v3

    .line 84
    new-instance v4, Ljava/lang/StringBuilder;

    invoke-virtual {p1}, Ljava/lang/Class;->getName()Ljava/lang/String;

    move-result-object v6

    invoke-direct {v4, v6}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    .line 85
    if-eqz v3, :cond_c

    .line 86
    invoke-virtual {p1}, Ljava/lang/Class;->getDeclaredFields()[Ljava/lang/reflect/Field;

    move-result-object p1

    array-length v6, p1

    move v8, v5

    :goto_3
    if-ge v8, v6, :cond_c

    aget-object v9, p1, v8

    .line 87
    invoke-virtual {v9}, Ljava/lang/reflect/Field;->getModifiers()I

    move-result v10

    invoke-static {v10}, Ljava/lang/reflect/Modifier;->isStatic(I)Z

    move-result v10

    if-nez v10, :cond_b

    invoke-virtual {v9}, Ljava/lang/reflect/Field;->getType()Ljava/lang/Class;

    move-result-object v10

    invoke-virtual {v10}, Ljava/lang/Class;->isPrimitive()Z

    move-result v10

    if-nez v10, :cond_b

    .line 88
    invoke-virtual {v9}, Ljava/lang/reflect/Field;->getType()Ljava/lang/Class;

    move-result-object v10

    invoke-virtual {v10}, Ljava/lang/Class;->getName()Ljava/lang/String;

    move-result-object v10

    const-string v11, "java."

    invoke-virtual {v10, v11}, Ljava/lang/String;->startsWith(Ljava/lang/String;)Z

    move-result v10

    if-nez v10, :cond_b

    .line 89
    invoke-virtual {v9}, Ljava/lang/reflect/Field;->getType()Ljava/lang/Class;

    move-result-object v10

    invoke-virtual {v10}, Ljava/lang/Class;->getName()Ljava/lang/String;

    move-result-object v10

    const-string v11, "android."

    invoke-virtual {v10, v11}, Ljava/lang/String;->startsWith(Ljava/lang/String;)Z

    move-result v10

    if-eqz v10, :cond_a

    goto :goto_4

    .line 90
    :cond_a
    invoke-virtual {v9, v7}, Ljava/lang/reflect/Field;->setAccessible(Z)V

    .line 91
    invoke-virtual {v9, v3}, Ljava/lang/reflect/Field;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v10

    .line 92
    if-eqz v10, :cond_b

    const/16 v11, 0x20

    invoke-virtual {v4, v11}, Ljava/lang/StringBuilder;->append(C)Ljava/lang/StringBuilder;

    move-result-object v11

    invoke-virtual {v9}, Ljava/lang/reflect/Field;->getName()Ljava/lang/String;

    move-result-object v9

    invoke-virtual {v11, v9}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v9

    const/16 v11, 0x3a

    invoke-virtual {v9, v11}, Ljava/lang/StringBuilder;->append(C)Ljava/lang/StringBuilder;

    move-result-object v9

    invoke-virtual {v10}, Ljava/lang/Object;->getClass()Ljava/lang/Class;

    move-result-object v10

    invoke-virtual {v10}, Ljava/lang/Class;->getName()Ljava/lang/String;

    move-result-object v10

    invoke-virtual {v9, v10}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 86
    :cond_b
    :goto_4
    add-int/lit8 v8, v8, 0x1

    goto :goto_3

    .line 95
    :cond_c
    invoke-virtual {v4}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p1

    sput-object p1, Llocal/mio/os4camerabridge/DexKitCameraContracts;->featureDescription:Ljava/lang/String;

    goto :goto_5

    .line 96
    :cond_d
    invoke-virtual {v3}, Lorg/luckypray/dexkit/result/ClassDataList;->size()I

    move-result p1

    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    const-string v4, "feature matcher count="

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3, p1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object p1

    invoke-virtual {p1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p1

    sput-object p1, Llocal/mio/os4camerabridge/DexKitCameraContracts;->featureDescription:Ljava/lang/String;

    :goto_5
    nop

    .line 97
    sget-object p1, Llocal/mio/os4camerabridge/DexKitCameraContracts;->featureDescription:Ljava/lang/String;

    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    const-string v4, "[CameraContracts] feature="

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p1

    invoke-virtual {p1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p1

    invoke-static {p1}, Lde/robv/android/xposed/XposedBridge;->log(Ljava/lang/String;)V
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    .line 98
    if-eqz v2, :cond_e

    :try_start_2
    invoke-virtual {v2}, Lorg/luckypray/dexkit/DexKitBridge;->close()V

    .line 99
    :cond_e
    invoke-virtual {p0}, Landroid/content/Context;->getPackageManager()Landroid/content/pm/PackageManager;

    move-result-object p1

    invoke-virtual {p0}, Landroid/content/Context;->getPackageName()Ljava/lang/String;

    move-result-object p0

    invoke-virtual {p1, p0, v5}, Landroid/content/pm/PackageManager;->getPackageInfo(Ljava/lang/String;I)Landroid/content/pm/PackageInfo;

    move-result-object p0

    .line 100
    invoke-virtual {p0}, Landroid/content/pm/PackageInfo;->getLongVersionCode()J

    move-result-wide v2

    iget-wide p0, p0, Landroid/content/pm/PackageInfo;->lastUpdateTime:J

    .line 102
    invoke-static {}, Landroid/os/SystemClock;->elapsedRealtime()J

    move-result-wide v4

    sub-long/2addr v4, v0

    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "[CameraContracts] hostVersion="

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, v2, v3}, Ljava/lang/StringBuilder;->append(J)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, " updated="

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, p0, p1}, Ljava/lang/StringBuilder;->append(J)Ljava/lang/StringBuilder;

    move-result-object p0

    const-string p1, " process-local scanMs="

    invoke-virtual {p0, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p0

    invoke-virtual {p0, v4, v5}, Ljava/lang/StringBuilder;->append(J)Ljava/lang/StringBuilder;

    move-result-object p0

    const-string p1, "; no frame/shutter scanning"

    invoke-virtual {p0, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p0

    invoke-virtual {p0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p0

    .line 100
    invoke-static {p0}, Lde/robv/android/xposed/XposedBridge;->log(Ljava/lang/String;)V
    :try_end_2
    .catchall {:try_start_2 .. :try_end_2} :catchall_2

    .line 106
    goto :goto_7

    .line 44
    :catchall_0
    move-exception p0

    if-eqz v2, :cond_f

    :try_start_3
    invoke-virtual {v2}, Lorg/luckypray/dexkit/DexKitBridge;->close()V
    :try_end_3
    .catchall {:try_start_3 .. :try_end_3} :catchall_1

    goto :goto_6

    :catchall_1
    move-exception p1

    :try_start_4
    invoke-virtual {p0, p1}, Ljava/lang/Throwable;->addSuppressed(Ljava/lang/Throwable;)V

    :cond_f
    :goto_6
    throw p0
    :try_end_4
    .catchall {:try_start_4 .. :try_end_4} :catchall_2

    .line 103
    :catchall_2
    move-exception p0

    .line 104
    invoke-static {p0}, Ljava/lang/String;->valueOf(Ljava/lang/Object;)Ljava/lang/String;

    move-result-object p0

    new-instance p1, Ljava/lang/StringBuilder;

    invoke-direct {p1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v0, "contract resolver unavailable: "

    invoke-virtual {p1, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p1

    invoke-virtual {p1, p0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p0

    invoke-virtual {p0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p0

    sput-object p0, Llocal/mio/os4camerabridge/DexKitCameraContracts;->featureDescription:Ljava/lang/String;

    .line 105
    sget-object p0, Llocal/mio/os4camerabridge/DexKitCameraContracts;->featureDescription:Ljava/lang/String;

    new-instance p1, Ljava/lang/StringBuilder;

    invoke-direct {p1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v0, "[CameraContracts] "

    invoke-virtual {p1, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p1

    invoke-virtual {p1, p0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p0

    invoke-virtual {p0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p0

    invoke-static {p0}, Lde/robv/android/xposed/XposedBridge;->log(Ljava/lang/String;)V

    .line 107
    :goto_7
    return-void
.end method
