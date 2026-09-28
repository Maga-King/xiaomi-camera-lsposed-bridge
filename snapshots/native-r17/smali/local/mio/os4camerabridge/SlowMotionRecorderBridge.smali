.class public final Llocal/mio/os4camerabridge/SlowMotionRecorderBridge;
.super Ljava/lang/Object;
.source "SlowMotionRecorderBridge.java"


# static fields
.field private static final FACTORY_DEPTH:Ljava/lang/ThreadLocal;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/lang/ThreadLocal<",
            "Ljava/lang/Integer;",
            ">;"
        }
    .end annotation
.end field

.field private static final RECORDER_INPUTS:Ljava/util/Map;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/Map<",
            "Ljava/lang/Object;",
            "Landroid/view/Surface;",
            ">;"
        }
    .end annotation
.end field

.field private static final SLOW_SETUP:Ljava/lang/ThreadLocal;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/lang/ThreadLocal<",
            "Ljava/lang/Boolean;",
            ">;"
        }
    .end annotation
.end field

.field private static activeModule:Ljava/lang/reflect/Field;

.field private static enabled:Z

.field private static volatile recording:Z


# direct methods
.method static bridge synthetic -$$Nest$sfgetFACTORY_DEPTH()Ljava/lang/ThreadLocal;
    .locals 1

    sget-object v0, Llocal/mio/os4camerabridge/SlowMotionRecorderBridge;->FACTORY_DEPTH:Ljava/lang/ThreadLocal;

    return-object v0
.end method

.method static bridge synthetic -$$Nest$sfgetRECORDER_INPUTS()Ljava/util/Map;
    .locals 1

    sget-object v0, Llocal/mio/os4camerabridge/SlowMotionRecorderBridge;->RECORDER_INPUTS:Ljava/util/Map;

    return-object v0
.end method

.method static bridge synthetic -$$Nest$sfgetSLOW_SETUP()Ljava/lang/ThreadLocal;
    .locals 1

    sget-object v0, Llocal/mio/os4camerabridge/SlowMotionRecorderBridge;->SLOW_SETUP:Ljava/lang/ThreadLocal;

    return-object v0
.end method

.method static bridge synthetic -$$Nest$sfgetactiveModule()Ljava/lang/reflect/Field;
    .locals 1

    sget-object v0, Llocal/mio/os4camerabridge/SlowMotionRecorderBridge;->activeModule:Ljava/lang/reflect/Field;

    return-object v0
.end method

.method static bridge synthetic -$$Nest$sfgetrecording()Z
    .locals 1

    sget-boolean v0, Llocal/mio/os4camerabridge/SlowMotionRecorderBridge;->recording:Z

    return v0
.end method

.method static bridge synthetic -$$Nest$sfputrecording(Z)V
    .locals 0

    sput-boolean p0, Llocal/mio/os4camerabridge/SlowMotionRecorderBridge;->recording:Z

    return-void
.end method

.method static constructor <clinit>()V
    .locals 1

    .line 20
    new-instance v0, Llocal/mio/os4camerabridge/SlowMotionRecorderBridge$$ExternalSyntheticLambda0;

    invoke-direct {v0}, Llocal/mio/os4camerabridge/SlowMotionRecorderBridge$$ExternalSyntheticLambda0;-><init>()V

    invoke-static {v0}, Ljava/lang/ThreadLocal;->withInitial(Ljava/util/function/Supplier;)Ljava/lang/ThreadLocal;

    move-result-object v0

    sput-object v0, Llocal/mio/os4camerabridge/SlowMotionRecorderBridge;->FACTORY_DEPTH:Ljava/lang/ThreadLocal;

    .line 21
    new-instance v0, Llocal/mio/os4camerabridge/SlowMotionRecorderBridge$$ExternalSyntheticLambda1;

    invoke-direct {v0}, Llocal/mio/os4camerabridge/SlowMotionRecorderBridge$$ExternalSyntheticLambda1;-><init>()V

    invoke-static {v0}, Ljava/lang/ThreadLocal;->withInitial(Ljava/util/function/Supplier;)Ljava/lang/ThreadLocal;

    move-result-object v0

    sput-object v0, Llocal/mio/os4camerabridge/SlowMotionRecorderBridge;->SLOW_SETUP:Ljava/lang/ThreadLocal;

    .line 22
    new-instance v0, Ljava/util/WeakHashMap;

    invoke-direct {v0}, Ljava/util/WeakHashMap;-><init>()V

    invoke-static {v0}, Ljava/util/Collections;->synchronizedMap(Ljava/util/Map;)Ljava/util/Map;

    move-result-object v0

    sput-object v0, Llocal/mio/os4camerabridge/SlowMotionRecorderBridge;->RECORDER_INPUTS:Ljava/util/Map;

    return-void
.end method

.method private constructor <init>()V
    .locals 0

    .line 23
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method public static bind(Lorg/luckypray/dexkit/DexKitBridge;Ljava/lang/ClassLoader;)V
    .locals 12

    .line 29
    :try_start_0
    const-string v0, "local.mio.os4camerabridge.HookEntry"

    const-class v1, Llocal/mio/os4camerabridge/SlowMotionRecorderBridge;

    .line 30
    invoke-virtual {v1}, Ljava/lang/Class;->getClassLoader()Ljava/lang/ClassLoader;

    move-result-object v1

    .line 29
    const/4 v2, 0x0

    invoke-static {v0, v2, v1}, Ljava/lang/Class;->forName(Ljava/lang/String;ZLjava/lang/ClassLoader;)Ljava/lang/Class;

    move-result-object v0

    .line 31
    const-string v1, "activeCameraModule"

    invoke-virtual {v0, v1}, Ljava/lang/Class;->getDeclaredField(Ljava/lang/String;)Ljava/lang/reflect/Field;

    move-result-object v0

    sput-object v0, Llocal/mio/os4camerabridge/SlowMotionRecorderBridge;->activeModule:Ljava/lang/reflect/Field;

    .line 32
    sget-object v0, Llocal/mio/os4camerabridge/SlowMotionRecorderBridge;->activeModule:Ljava/lang/reflect/Field;

    const/4 v1, 0x1

    invoke-virtual {v0, v1}, Ljava/lang/reflect/Field;->setAccessible(Z)V

    .line 33
    invoke-static {p1}, Llocal/mio/os4camerabridge/SlowMotionRecorderBridge;->bindRecordState(Ljava/lang/ClassLoader;)V

    .line 34
    const-string v0, "ComponentConfigSlowMotion"

    const-string v3, "slow_motion_240"

    invoke-static {p0, p1, v0, v3}, Llocal/mio/os4camerabridge/SlowMotionRecorderBridge;->bindLockedComponent(Lorg/luckypray/dexkit/DexKitBridge;Ljava/lang/ClassLoader;Ljava/lang/String;Ljava/lang/String;)V

    .line 35
    const-string v0, "ComponentConfigSlowMotionQuality"

    const-string v3, "6"

    invoke-static {p0, p1, v0, v3}, Llocal/mio/os4camerabridge/SlowMotionRecorderBridge;->bindLockedComponent(Lorg/luckypray/dexkit/DexKitBridge;Ljava/lang/ClassLoader;Ljava/lang/String;Ljava/lang/String;)V

    .line 36
    invoke-static {}, Lorg/luckypray/dexkit/query/FindMethod;->create()Lorg/luckypray/dexkit/query/FindMethod;

    move-result-object v0

    invoke-static {}, Lorg/luckypray/dexkit/query/matchers/MethodMatcher;->create()Lorg/luckypray/dexkit/query/matchers/MethodMatcher;

    move-result-object v3

    const-string v4, "setupMediaRecorder: null parameter"

    const-string v5, "setupMediaRecorder: null MediaRecorder"

    filled-new-array {v4, v5}, [Ljava/lang/String;

    move-result-object v4

    .line 37
    invoke-virtual {v3, v4}, Lorg/luckypray/dexkit/query/matchers/MethodMatcher;->usingStrings([Ljava/lang/String;)Lorg/luckypray/dexkit/query/matchers/MethodMatcher;

    move-result-object v3

    sget-object v4, Ljava/lang/Void;->TYPE:Ljava/lang/Class;

    .line 38
    invoke-virtual {v3, v4}, Lorg/luckypray/dexkit/query/matchers/MethodMatcher;->returnType(Ljava/lang/Class;)Lorg/luckypray/dexkit/query/matchers/MethodMatcher;

    move-result-object v3

    invoke-virtual {v3, v1}, Lorg/luckypray/dexkit/query/matchers/MethodMatcher;->paramCount(I)Lorg/luckypray/dexkit/query/matchers/MethodMatcher;

    move-result-object v3

    .line 36
    invoke-virtual {v0, v3}, Lorg/luckypray/dexkit/query/FindMethod;->matcher(Lorg/luckypray/dexkit/query/matchers/MethodMatcher;)Lorg/luckypray/dexkit/query/FindMethod;

    move-result-object v0

    invoke-virtual {p0, v0}, Lorg/luckypray/dexkit/DexKitBridge;->findMethod(Lorg/luckypray/dexkit/query/FindMethod;)Lorg/luckypray/dexkit/result/MethodDataList;

    move-result-object v0

    .line 39
    invoke-virtual {v0}, Lorg/luckypray/dexkit/result/MethodDataList;->size()I

    move-result v3

    if-ne v3, v1, :cond_11

    .line 40
    invoke-virtual {v0, v2}, Lorg/luckypray/dexkit/result/MethodDataList;->get(I)Ljava/lang/Object;

    move-result-object v3

    check-cast v3, Lorg/luckypray/dexkit/result/MethodData;

    invoke-virtual {v3, p1}, Lorg/luckypray/dexkit/result/MethodData;->getClassInstance(Ljava/lang/ClassLoader;)Ljava/lang/Class;

    move-result-object v3

    .line 41
    new-instance v4, Ljava/util/LinkedHashSet;

    invoke-direct {v4}, Ljava/util/LinkedHashSet;-><init>()V

    .line 42
    const-string v5, "com.android.camera.module.VideoModule"

    invoke-static {v5, v2, p1}, Ljava/lang/Class;->forName(Ljava/lang/String;ZLjava/lang/ClassLoader;)Ljava/lang/Class;

    move-result-object v5

    .line 43
    :goto_0
    if-eqz v5, :cond_2

    .line 44
    invoke-virtual {v5}, Ljava/lang/Class;->getDeclaredFields()[Ljava/lang/reflect/Field;

    move-result-object v6

    array-length v7, v6

    move v8, v2

    :goto_1
    if-ge v8, v7, :cond_1

    aget-object v9, v6, v8

    invoke-virtual {v9}, Ljava/lang/reflect/Field;->getModifiers()I

    move-result v10

    invoke-static {v10}, Ljava/lang/reflect/Modifier;->isStatic(I)Z

    move-result v10

    if-nez v10, :cond_0

    .line 45
    invoke-virtual {v9}, Ljava/lang/reflect/Field;->getType()Ljava/lang/Class;

    move-result-object v9

    invoke-interface {v4, v9}, Ljava/util/Set;->add(Ljava/lang/Object;)Z

    .line 44
    :cond_0
    add-int/lit8 v8, v8, 0x1

    goto :goto_1

    .line 43
    :cond_1
    invoke-virtual {v5}, Ljava/lang/Class;->getSuperclass()Ljava/lang/Class;

    move-result-object v5

    goto :goto_0

    .line 46
    :cond_2
    invoke-static {}, Lorg/luckypray/dexkit/query/FindMethod;->create()Lorg/luckypray/dexkit/query/FindMethod;

    move-result-object v5

    invoke-static {}, Lorg/luckypray/dexkit/query/matchers/MethodMatcher;->create()Lorg/luckypray/dexkit/query/matchers/MethodMatcher;

    move-result-object v6

    const-string v7, "createRecorder: reset cost: "

    const-string v8, "initializeRecorder: createRecorder "

    filled-new-array {v7, v8}, [Ljava/lang/String;

    move-result-object v7

    .line 47
    invoke-virtual {v6, v7}, Lorg/luckypray/dexkit/query/matchers/MethodMatcher;->usingStrings([Ljava/lang/String;)Lorg/luckypray/dexkit/query/matchers/MethodMatcher;

    move-result-object v6

    sget-object v7, Ljava/lang/Void;->TYPE:Ljava/lang/Class;

    .line 48
    invoke-virtual {v6, v7}, Lorg/luckypray/dexkit/query/matchers/MethodMatcher;->returnType(Ljava/lang/Class;)Lorg/luckypray/dexkit/query/matchers/MethodMatcher;

    move-result-object v6

    invoke-virtual {v6, v2}, Lorg/luckypray/dexkit/query/matchers/MethodMatcher;->paramCount(I)Lorg/luckypray/dexkit/query/matchers/MethodMatcher;

    move-result-object v6

    .line 46
    invoke-virtual {v5, v6}, Lorg/luckypray/dexkit/query/FindMethod;->matcher(Lorg/luckypray/dexkit/query/matchers/MethodMatcher;)Lorg/luckypray/dexkit/query/FindMethod;

    move-result-object v5

    invoke-virtual {p0, v5}, Lorg/luckypray/dexkit/DexKitBridge;->findMethod(Lorg/luckypray/dexkit/query/FindMethod;)Lorg/luckypray/dexkit/result/MethodDataList;

    move-result-object p0

    .line 49
    new-instance v5, Llocal/mio/os4camerabridge/SlowMotionRecorderBridge$$ExternalSyntheticLambda2;

    invoke-direct {v5, v4, p1, v3}, Llocal/mio/os4camerabridge/SlowMotionRecorderBridge$$ExternalSyntheticLambda2;-><init>(Ljava/util/Set;Ljava/lang/ClassLoader;Ljava/lang/Class;)V

    invoke-virtual {p0, v5}, Lorg/luckypray/dexkit/result/MethodDataList;->removeIf(Ljava/util/function/Predicate;)Z

    .line 68
    invoke-virtual {p0}, Lorg/luckypray/dexkit/result/MethodDataList;->size()I

    move-result v4

    if-ne v4, v1, :cond_10

    .line 69
    invoke-virtual {p0, v2}, Lorg/luckypray/dexkit/result/MethodDataList;->get(I)Ljava/lang/Object;

    move-result-object v4

    check-cast v4, Lorg/luckypray/dexkit/result/MethodData;

    invoke-virtual {v4, p1}, Lorg/luckypray/dexkit/result/MethodData;->getMethodInstance(Ljava/lang/ClassLoader;)Ljava/lang/reflect/Method;

    move-result-object v4

    .line 70
    new-instance v5, Ljava/util/LinkedHashMap;

    invoke-direct {v5}, Ljava/util/LinkedHashMap;-><init>()V

    .line 71
    invoke-virtual {p0, v2}, Lorg/luckypray/dexkit/result/MethodDataList;->get(I)Ljava/lang/Object;

    move-result-object p0

    check-cast p0, Lorg/luckypray/dexkit/result/MethodData;

    invoke-virtual {p0}, Lorg/luckypray/dexkit/result/MethodData;->getInvokes()Lorg/luckypray/dexkit/result/MethodDataList;

    move-result-object p0

    invoke-virtual {p0}, Lorg/luckypray/dexkit/result/MethodDataList;->iterator()Ljava/util/Iterator;

    move-result-object p0

    :goto_2
    invoke-interface {p0}, Ljava/util/Iterator;->hasNext()Z

    move-result v6

    if-eqz v6, :cond_5

    invoke-interface {p0}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v6

    check-cast v6, Lorg/luckypray/dexkit/result/MethodData;

    .line 72
    invoke-virtual {v6}, Lorg/luckypray/dexkit/result/MethodData;->isMethod()Z

    move-result v7

    if-nez v7, :cond_3

    goto :goto_2

    .line 73
    :cond_3
    invoke-virtual {v6, p1}, Lorg/luckypray/dexkit/result/MethodData;->getMethodInstance(Ljava/lang/ClassLoader;)Ljava/lang/reflect/Method;

    move-result-object v6

    .line 74
    invoke-virtual {v6}, Ljava/lang/reflect/Method;->getModifiers()I

    move-result v7

    invoke-static {v7}, Ljava/lang/reflect/Modifier;->isStatic(I)Z

    move-result v7

    if-nez v7, :cond_4

    invoke-virtual {v6}, Ljava/lang/reflect/Method;->getReturnType()Ljava/lang/Class;

    move-result-object v7

    sget-object v8, Ljava/lang/Boolean;->TYPE:Ljava/lang/Class;

    if-ne v7, v8, :cond_4

    .line 75
    invoke-virtual {v6}, Ljava/lang/reflect/Method;->getParameterCount()I

    move-result v7

    if-nez v7, :cond_4

    .line 76
    invoke-virtual {v6}, Ljava/lang/reflect/Method;->getDeclaringClass()Ljava/lang/Class;

    move-result-object v7

    new-instance v8, Llocal/mio/os4camerabridge/SlowMotionRecorderBridge$$ExternalSyntheticLambda3;

    invoke-direct {v8}, Llocal/mio/os4camerabridge/SlowMotionRecorderBridge$$ExternalSyntheticLambda3;-><init>()V

    invoke-interface {v5, v7, v8}, Ljava/util/Map;->computeIfAbsent(Ljava/lang/Object;Ljava/util/function/Function;)Ljava/lang/Object;

    move-result-object v7

    check-cast v7, Ljava/util/Set;

    invoke-interface {v7, v6}, Ljava/util/Set;->add(Ljava/lang/Object;)Z

    .line 77
    :cond_4
    goto :goto_2

    .line 78
    :cond_5
    new-instance p0, Ljava/util/ArrayList;

    invoke-direct {p0}, Ljava/util/ArrayList;-><init>()V

    .line 79
    invoke-interface {v5}, Ljava/util/Map;->values()Ljava/util/Collection;

    move-result-object v5

    invoke-interface {v5}, Ljava/util/Collection;->iterator()Ljava/util/Iterator;

    move-result-object v5

    :cond_6
    :goto_3
    invoke-interface {v5}, Ljava/util/Iterator;->hasNext()Z

    move-result v6

    if-eqz v6, :cond_7

    invoke-interface {v5}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v6

    check-cast v6, Ljava/util/Set;

    invoke-interface {v6}, Ljava/util/Set;->size()I

    move-result v7

    const/4 v8, 0x2

    if-ne v7, v8, :cond_6

    invoke-interface {p0, v6}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    goto :goto_3

    .line 80
    :cond_7
    invoke-interface {p0}, Ljava/util/List;->size()I

    move-result v5

    if-ne v5, v1, :cond_f

    .line 81
    nop

    .line 82
    invoke-virtual {v3}, Ljava/lang/Class;->getDeclaredFields()[Ljava/lang/reflect/Field;

    move-result-object v5

    array-length v6, v5

    move v7, v2

    move v8, v7

    :goto_4
    if-ge v7, v6, :cond_9

    aget-object v9, v5, v7

    invoke-virtual {v9}, Ljava/lang/reflect/Field;->getType()Ljava/lang/Class;

    move-result-object v9

    const-class v10, Landroid/media/MediaRecorder;

    if-ne v9, v10, :cond_8

    move v8, v1

    :cond_8
    add-int/lit8 v7, v7, 0x1

    goto :goto_4

    .line 83
    :cond_9
    invoke-virtual {v4}, Ljava/lang/reflect/Method;->getDeclaringClass()Ljava/lang/Class;

    move-result-object v5

    invoke-virtual {v5}, Ljava/lang/Class;->getDeclaredFields()[Ljava/lang/reflect/Field;

    move-result-object v5

    array-length v6, v5

    move v7, v2

    move v9, v7

    :goto_5
    if-ge v7, v6, :cond_b

    aget-object v10, v5, v7

    .line 84
    invoke-virtual {v10}, Ljava/lang/reflect/Field;->getType()Ljava/lang/Class;

    move-result-object v11

    invoke-virtual {v11}, Ljava/lang/Class;->isInterface()Z

    move-result v11

    if-eqz v11, :cond_a

    invoke-virtual {v10}, Ljava/lang/reflect/Field;->getType()Ljava/lang/Class;

    move-result-object v10

    invoke-virtual {v10, v3}, Ljava/lang/Class;->isAssignableFrom(Ljava/lang/Class;)Z

    move-result v10

    if-eqz v10, :cond_a

    move v9, v1

    .line 83
    :cond_a
    add-int/lit8 v7, v7, 0x1

    goto :goto_5

    .line 85
    :cond_b
    if-eqz v8, :cond_e

    if-eqz v9, :cond_e

    .line 86
    const-class v1, Landroid/media/MediaRecorder;

    const-string v5, "setInputSurface"

    const-class v6, Landroid/view/Surface;

    new-instance v7, Llocal/mio/os4camerabridge/SlowMotionRecorderBridge$1;

    invoke-direct {v7}, Llocal/mio/os4camerabridge/SlowMotionRecorderBridge$1;-><init>()V

    filled-new-array {v6, v7}, [Ljava/lang/Object;

    move-result-object v6

    invoke-static {v1, v5, v6}, Lde/robv/android/xposed/XposedHelpers;->findAndHookMethod(Ljava/lang/Class;Ljava/lang/String;[Ljava/lang/Object;)Lde/robv/android/xposed/XC_MethodHook$Unhook;

    .line 94
    const-class v1, Landroid/media/MediaRecorder;

    const-string v5, "prepare"

    new-instance v6, Llocal/mio/os4camerabridge/SlowMotionRecorderBridge$2;

    invoke-direct {v6}, Llocal/mio/os4camerabridge/SlowMotionRecorderBridge$2;-><init>()V

    filled-new-array {v6}, [Ljava/lang/Object;

    move-result-object v6

    invoke-static {v1, v5, v6}, Lde/robv/android/xposed/XposedHelpers;->findAndHookMethod(Ljava/lang/Class;Ljava/lang/String;[Ljava/lang/Object;)Lde/robv/android/xposed/XC_MethodHook$Unhook;

    .line 113
    invoke-virtual {v0, v2}, Lorg/luckypray/dexkit/result/MethodDataList;->get(I)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lorg/luckypray/dexkit/result/MethodData;

    invoke-virtual {v0, p1}, Lorg/luckypray/dexkit/result/MethodData;->getMethodInstance(Ljava/lang/ClassLoader;)Ljava/lang/reflect/Method;

    move-result-object p1

    new-instance v0, Llocal/mio/os4camerabridge/SlowMotionRecorderBridge$3;

    invoke-direct {v0}, Llocal/mio/os4camerabridge/SlowMotionRecorderBridge$3;-><init>()V

    invoke-static {p1, v0}, Lde/robv/android/xposed/XposedBridge;->hookMethod(Ljava/lang/reflect/Member;Lde/robv/android/xposed/XC_MethodHook;)Lde/robv/android/xposed/XC_MethodHook$Unhook;

    .line 122
    const-class p1, Landroid/media/MediaRecorder;

    const-string v0, "setVideoFrameRate"

    sget-object v1, Ljava/lang/Integer;->TYPE:Ljava/lang/Class;

    new-instance v5, Llocal/mio/os4camerabridge/SlowMotionRecorderBridge$4;

    invoke-direct {v5}, Llocal/mio/os4camerabridge/SlowMotionRecorderBridge$4;-><init>()V

    filled-new-array {v1, v5}, [Ljava/lang/Object;

    move-result-object v1

    invoke-static {p1, v0, v1}, Lde/robv/android/xposed/XposedHelpers;->findAndHookMethod(Ljava/lang/Class;Ljava/lang/String;[Ljava/lang/Object;)Lde/robv/android/xposed/XC_MethodHook$Unhook;

    .line 130
    const-class p1, Landroid/media/MediaRecorder;

    const-string v0, "setVideoEncoder"

    sget-object v1, Ljava/lang/Integer;->TYPE:Ljava/lang/Class;

    new-instance v5, Llocal/mio/os4camerabridge/SlowMotionRecorderBridge$5;

    invoke-direct {v5}, Llocal/mio/os4camerabridge/SlowMotionRecorderBridge$5;-><init>()V

    filled-new-array {v1, v5}, [Ljava/lang/Object;

    move-result-object v1

    invoke-static {p1, v0, v1}, Lde/robv/android/xposed/XposedHelpers;->findAndHookMethod(Ljava/lang/Class;Ljava/lang/String;[Ljava/lang/Object;)Lde/robv/android/xposed/XC_MethodHook$Unhook;

    .line 139
    const-class p1, Landroid/media/MediaRecorder;

    const-string v0, "setVideoEncodingBitRate"

    sget-object v1, Ljava/lang/Integer;->TYPE:Ljava/lang/Class;

    new-instance v5, Llocal/mio/os4camerabridge/SlowMotionRecorderBridge$6;

    invoke-direct {v5}, Llocal/mio/os4camerabridge/SlowMotionRecorderBridge$6;-><init>()V

    filled-new-array {v1, v5}, [Ljava/lang/Object;

    move-result-object v1

    invoke-static {p1, v0, v1}, Lde/robv/android/xposed/XposedHelpers;->findAndHookMethod(Ljava/lang/Class;Ljava/lang/String;[Ljava/lang/Object;)Lde/robv/android/xposed/XC_MethodHook$Unhook;

    .line 144
    const-string p1, "setAudioSource"

    const-string v0, "setAudioEncoder"

    const-string v1, "setAudioChannels"

    const-string v5, "setAudioEncodingBitRate"

    const-string v6, "setAudioSamplingRate"

    filled-new-array {p1, v0, v1, v5, v6}, [Ljava/lang/String;

    move-result-object p1

    move v0, v2

    :goto_6
    const/4 v1, 0x5

    if-ge v0, v1, :cond_c

    aget-object v1, p1, v0

    .line 146
    const-class v5, Landroid/media/MediaRecorder;

    sget-object v6, Ljava/lang/Integer;->TYPE:Ljava/lang/Class;

    new-instance v7, Llocal/mio/os4camerabridge/SlowMotionRecorderBridge$7;

    invoke-direct {v7}, Llocal/mio/os4camerabridge/SlowMotionRecorderBridge$7;-><init>()V

    filled-new-array {v6, v7}, [Ljava/lang/Object;

    move-result-object v6

    invoke-static {v5, v1, v6}, Lde/robv/android/xposed/XposedHelpers;->findAndHookMethod(Ljava/lang/Class;Ljava/lang/String;[Ljava/lang/Object;)Lde/robv/android/xposed/XC_MethodHook$Unhook;

    .line 144
    add-int/lit8 v0, v0, 0x1

    goto :goto_6

    .line 151
    :cond_c
    invoke-interface {p0, v2}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object p1

    check-cast p1, Ljava/util/Set;

    invoke-interface {p1}, Ljava/util/Set;->iterator()Ljava/util/Iterator;

    move-result-object p1

    :goto_7
    invoke-interface {p1}, Ljava/util/Iterator;->hasNext()Z

    move-result v0

    if-eqz v0, :cond_d

    invoke-interface {p1}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/lang/reflect/Method;

    new-instance v1, Llocal/mio/os4camerabridge/SlowMotionRecorderBridge$8;

    invoke-direct {v1}, Llocal/mio/os4camerabridge/SlowMotionRecorderBridge$8;-><init>()V

    invoke-static {v0, v1}, Lde/robv/android/xposed/XposedBridge;->hookMethod(Ljava/lang/reflect/Member;Lde/robv/android/xposed/XC_MethodHook;)Lde/robv/android/xposed/XC_MethodHook$Unhook;

    goto :goto_7

    .line 156
    :cond_d
    new-instance p1, Llocal/mio/os4camerabridge/SlowMotionRecorderBridge$9;

    invoke-direct {p1}, Llocal/mio/os4camerabridge/SlowMotionRecorderBridge$9;-><init>()V

    invoke-static {v4, p1}, Lde/robv/android/xposed/XposedBridge;->hookMethod(Ljava/lang/reflect/Member;Lde/robv/android/xposed/XC_MethodHook;)Lde/robv/android/xposed/XC_MethodHook$Unhook;

    .line 168
    invoke-static {v4}, Ljava/lang/String;->valueOf(Ljava/lang/Object;)Ljava/lang/String;

    move-result-object p1

    invoke-interface {p0, v2}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object p0

    invoke-static {p0}, Ljava/lang/String;->valueOf(Ljava/lang/Object;)Ljava/lang/String;

    move-result-object p0

    .line 169
    invoke-virtual {v3}, Ljava/lang/Class;->getName()Ljava/lang/String;

    move-result-object v0

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "[SlowMotionRecorder] bound factory="

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p1

    const-string v1, " selectors="

    invoke-virtual {p1, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p1

    invoke-virtual {p1, p0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p0

    const-string p1, " standard="

    invoke-virtual {p0, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p0

    invoke-virtual {p0, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p0

    invoke-virtual {p0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p0

    .line 168
    invoke-static {p0}, Lde/robv/android/xposed/XposedBridge;->log(Ljava/lang/String;)V

    .line 172
    goto :goto_8

    .line 85
    :cond_e
    new-instance p0, Ljava/lang/IllegalStateException;

    const-string p1, "standard recorder contract mismatch"

    invoke-direct {p0, p1}, Ljava/lang/IllegalStateException;-><init>(Ljava/lang/String;)V

    throw p0

    .line 80
    :cond_f
    new-instance p1, Ljava/lang/IllegalStateException;

    invoke-interface {p0}, Ljava/util/List;->size()I

    move-result p0

    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "recorder selector pairs="

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, p0}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object p0

    invoke-virtual {p0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p0

    invoke-direct {p1, p0}, Ljava/lang/IllegalStateException;-><init>(Ljava/lang/String;)V

    throw p1

    .line 68
    :cond_10
    new-instance p1, Ljava/lang/IllegalStateException;

    invoke-virtual {p0}, Lorg/luckypray/dexkit/result/MethodDataList;->size()I

    move-result p0

    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "typed factory count="

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, p0}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object p0

    invoke-virtual {p0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p0

    invoke-direct {p1, p0}, Ljava/lang/IllegalStateException;-><init>(Ljava/lang/String;)V

    throw p1

    .line 39
    :cond_11
    new-instance p0, Ljava/lang/IllegalStateException;

    invoke-virtual {v0}, Lorg/luckypray/dexkit/result/MethodDataList;->size()I

    move-result p1

    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "standard recorder count="

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, p1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object p1

    invoke-virtual {p1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p1

    invoke-direct {p0, p1}, Ljava/lang/IllegalStateException;-><init>(Ljava/lang/String;)V

    throw p0
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 170
    :catchall_0
    move-exception p0

    .line 171
    invoke-static {p0}, Ljava/lang/String;->valueOf(Ljava/lang/Object;)Ljava/lang/String;

    move-result-object p0

    new-instance p1, Ljava/lang/StringBuilder;

    invoke-direct {p1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v0, "[SlowMotionRecorder] not bound: "

    invoke-virtual {p1, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p1

    invoke-virtual {p1, p0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p0

    invoke-virtual {p0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p0

    invoke-static {p0}, Lde/robv/android/xposed/XposedBridge;->log(Ljava/lang/String;)V

    .line 173
    :goto_8
    return-void
.end method

.method private static bindLockedComponent(Lorg/luckypray/dexkit/DexKitBridge;Ljava/lang/ClassLoader;Ljava/lang/String;Ljava/lang/String;)V
    .locals 7
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/lang/Throwable;
        }
    .end annotation

    .line 209
    invoke-static {}, Lorg/luckypray/dexkit/query/FindMethod;->create()Lorg/luckypray/dexkit/query/FindMethod;

    move-result-object v0

    invoke-static {}, Lorg/luckypray/dexkit/query/matchers/MethodMatcher;->create()Lorg/luckypray/dexkit/query/matchers/MethodMatcher;

    move-result-object v1

    .line 210
    const-string v2, "getTag"

    invoke-virtual {v1, v2}, Lorg/luckypray/dexkit/query/matchers/MethodMatcher;->name(Ljava/lang/String;)Lorg/luckypray/dexkit/query/matchers/MethodMatcher;

    move-result-object v1

    filled-new-array {p2}, [Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2}, Lorg/luckypray/dexkit/query/matchers/MethodMatcher;->usingStrings([Ljava/lang/String;)Lorg/luckypray/dexkit/query/matchers/MethodMatcher;

    move-result-object v1

    const-class v2, Ljava/lang/String;

    invoke-virtual {v1, v2}, Lorg/luckypray/dexkit/query/matchers/MethodMatcher;->returnType(Ljava/lang/Class;)Lorg/luckypray/dexkit/query/matchers/MethodMatcher;

    move-result-object v1

    const/4 v2, 0x0

    invoke-virtual {v1, v2}, Lorg/luckypray/dexkit/query/matchers/MethodMatcher;->paramCount(I)Lorg/luckypray/dexkit/query/matchers/MethodMatcher;

    move-result-object v1

    .line 209
    invoke-virtual {v0, v1}, Lorg/luckypray/dexkit/query/FindMethod;->matcher(Lorg/luckypray/dexkit/query/matchers/MethodMatcher;)Lorg/luckypray/dexkit/query/FindMethod;

    move-result-object v0

    invoke-virtual {p0, v0}, Lorg/luckypray/dexkit/DexKitBridge;->findMethod(Lorg/luckypray/dexkit/query/FindMethod;)Lorg/luckypray/dexkit/result/MethodDataList;

    move-result-object p0

    .line 212
    new-instance v0, Llocal/mio/os4camerabridge/SlowMotionRecorderBridge$$ExternalSyntheticLambda6;

    invoke-direct {v0, p2}, Llocal/mio/os4camerabridge/SlowMotionRecorderBridge$$ExternalSyntheticLambda6;-><init>(Ljava/lang/String;)V

    invoke-virtual {p0, v0}, Lorg/luckypray/dexkit/result/MethodDataList;->removeIf(Ljava/util/function/Predicate;)Z

    .line 213
    invoke-virtual {p0}, Lorg/luckypray/dexkit/result/MethodDataList;->size()I

    move-result v0

    const/4 v1, 0x1

    if-ne v0, v1, :cond_6

    .line 214
    invoke-virtual {p0, v2}, Lorg/luckypray/dexkit/result/MethodDataList;->get(I)Ljava/lang/Object;

    move-result-object p0

    check-cast p0, Lorg/luckypray/dexkit/result/MethodData;

    invoke-virtual {p0, p1}, Lorg/luckypray/dexkit/result/MethodData;->getClassInstance(Ljava/lang/ClassLoader;)Ljava/lang/Class;

    move-result-object p0

    .line 215
    nop

    .line 216
    move-object p1, p0

    :goto_0
    if-eqz p1, :cond_0

    .line 217
    :try_start_0
    const-string p2, "mItems"

    invoke-virtual {p1, p2}, Ljava/lang/Class;->getDeclaredField(Ljava/lang/String;)Ljava/lang/reflect/Field;

    move-result-object p1
    :try_end_0
    .catch Ljava/lang/NoSuchFieldException; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_1

    :catch_0
    move-exception p2

    .line 216
    invoke-virtual {p1}, Ljava/lang/Class;->getSuperclass()Ljava/lang/Class;

    move-result-object p1

    goto :goto_0

    :cond_0
    const/4 p1, 0x0

    .line 219
    :goto_1
    if-eqz p1, :cond_5

    const-class p2, Ljava/util/List;

    invoke-virtual {p1}, Ljava/lang/reflect/Field;->getType()Ljava/lang/Class;

    move-result-object v0

    invoke-virtual {p2, v0}, Ljava/lang/Class;->isAssignableFrom(Ljava/lang/Class;)Z

    move-result p2

    if-eqz p2, :cond_5

    .line 220
    invoke-virtual {p1, v1}, Ljava/lang/reflect/Field;->setAccessible(Z)V

    .line 221
    new-instance p2, Llocal/mio/os4camerabridge/SlowMotionRecorderBridge$14;

    invoke-direct {p2, p1, p3}, Llocal/mio/os4camerabridge/SlowMotionRecorderBridge$14;-><init>(Ljava/lang/reflect/Field;Ljava/lang/String;)V

    .line 238
    invoke-virtual {p0}, Ljava/lang/Class;->getDeclaredMethods()[Ljava/lang/reflect/Method;

    move-result-object p1

    array-length v0, p1

    move v3, v2

    :goto_2
    if-ge v3, v0, :cond_3

    aget-object v4, p1, v3

    .line 239
    invoke-virtual {v4}, Ljava/lang/reflect/Method;->getName()Ljava/lang/String;

    move-result-object v5

    const-string v6, "getItems"

    invoke-virtual {v5, v6}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v5

    if-nez v5, :cond_1

    invoke-virtual {v4}, Ljava/lang/reflect/Method;->getReturnType()Ljava/lang/Class;

    move-result-object v5

    sget-object v6, Ljava/lang/Void;->TYPE:Ljava/lang/Class;

    if-ne v5, v6, :cond_2

    invoke-virtual {v4}, Ljava/lang/reflect/Method;->getParameterCount()I

    move-result v5

    if-ne v5, v1, :cond_2

    .line 240
    :cond_1
    invoke-static {v4, p2}, Lde/robv/android/xposed/XposedBridge;->hookMethod(Ljava/lang/reflect/Member;Lde/robv/android/xposed/XC_MethodHook;)Lde/robv/android/xposed/XC_MethodHook$Unhook;

    .line 238
    :cond_2
    add-int/lit8 v3, v3, 0x1

    goto :goto_2

    .line 242
    :cond_3
    const-string p1, "getComponentValue"

    const-string p2, "getDefaultValue"

    filled-new-array {p1, p2}, [Ljava/lang/String;

    move-result-object p1

    :goto_3
    const/4 p2, 0x2

    if-ge v2, p2, :cond_4

    aget-object p2, p1, v2

    .line 243
    sget-object v0, Ljava/lang/Integer;->TYPE:Ljava/lang/Class;

    new-instance v1, Llocal/mio/os4camerabridge/SlowMotionRecorderBridge$15;

    invoke-direct {v1, p3}, Llocal/mio/os4camerabridge/SlowMotionRecorderBridge$15;-><init>(Ljava/lang/String;)V

    filled-new-array {v0, v1}, [Ljava/lang/Object;

    move-result-object v0

    invoke-static {p0, p2, v0}, Lde/robv/android/xposed/XposedHelpers;->findAndHookMethod(Ljava/lang/Class;Ljava/lang/String;[Ljava/lang/Object;)Lde/robv/android/xposed/XC_MethodHook$Unhook;

    .line 242
    add-int/lit8 v2, v2, 0x1

    goto :goto_3

    .line 249
    :cond_4
    sget-object p1, Ljava/lang/Integer;->TYPE:Ljava/lang/Class;

    const-class p2, Ljava/lang/String;

    filled-new-array {p1, p2}, [Ljava/lang/Class;

    move-result-object p1

    const-string p2, "setComponentValue"

    invoke-virtual {p0, p2, p1}, Ljava/lang/Class;->getMethod(Ljava/lang/String;[Ljava/lang/Class;)Ljava/lang/reflect/Method;

    move-result-object p1

    .line 250
    new-instance p2, Llocal/mio/os4camerabridge/SlowMotionRecorderBridge$16;

    invoke-direct {p2, p0, p3}, Llocal/mio/os4camerabridge/SlowMotionRecorderBridge$16;-><init>(Ljava/lang/Class;Ljava/lang/String;)V

    invoke-static {p1, p2}, Lde/robv/android/xposed/XposedBridge;->hookMethod(Ljava/lang/reflect/Member;Lde/robv/android/xposed/XC_MethodHook;)Lde/robv/android/xposed/XC_MethodHook$Unhook;

    .line 255
    invoke-virtual {p0}, Ljava/lang/Class;->getName()Ljava/lang/String;

    move-result-object p0

    new-instance p1, Ljava/lang/StringBuilder;

    invoke-direct {p1}, Ljava/lang/StringBuilder;-><init>()V

    const-string p2, "[SlowMotionRecorder] component locked "

    invoke-virtual {p1, p2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p1

    invoke-virtual {p1, p0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p0

    const-string p1, "="

    invoke-virtual {p0, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p0

    invoke-virtual {p0, p3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p0

    invoke-virtual {p0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p0

    invoke-static {p0}, Lde/robv/android/xposed/XposedBridge;->log(Ljava/lang/String;)V

    .line 256
    return-void

    .line 219
    :cond_5
    new-instance p0, Ljava/lang/IllegalStateException;

    const-string p1, "component item list missing"

    invoke-direct {p0, p1}, Ljava/lang/IllegalStateException;-><init>(Ljava/lang/String;)V

    throw p0

    .line 213
    :cond_6
    new-instance p1, Ljava/lang/IllegalStateException;

    invoke-virtual {p0}, Lorg/luckypray/dexkit/result/MethodDataList;->size()I

    move-result p0

    new-instance p3, Ljava/lang/StringBuilder;

    invoke-direct {p3}, Ljava/lang/StringBuilder;-><init>()V

    const-string v0, "component "

    invoke-virtual {p3, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p3

    invoke-virtual {p3, p2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p2

    const-string p3, " count="

    invoke-virtual {p2, p3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p2

    invoke-virtual {p2, p0}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object p0

    invoke-virtual {p0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p0

    invoke-direct {p1, p0}, Ljava/lang/IllegalStateException;-><init>(Ljava/lang/String;)V

    throw p1
.end method

.method private static bindRecordState(Ljava/lang/ClassLoader;)V
    .locals 6

    .line 176
    new-instance v0, Landroid/hardware/camera2/CaptureRequest$Key;

    const-string v1, "com.oplus.camera.mode"

    const-class v2, [B

    invoke-direct {v0, v1, v2}, Landroid/hardware/camera2/CaptureRequest$Key;-><init>(Ljava/lang/String;Ljava/lang/Class;)V

    .line 177
    new-instance v1, Landroid/hardware/camera2/CaptureRequest$Key;

    const-string v2, "com.oplus.video.record.state"

    const-class v3, Ljava/lang/Integer;

    invoke-direct {v1, v2, v3}, Landroid/hardware/camera2/CaptureRequest$Key;-><init>(Ljava/lang/String;Ljava/lang/Class;)V

    .line 178
    new-instance v2, Landroid/hardware/camera2/CaptureRequest$Key;

    const-string v3, "com.oplus.eis.record.state"

    const-class v4, Ljava/lang/Integer;

    invoke-direct {v2, v3, v4}, Landroid/hardware/camera2/CaptureRequest$Key;-><init>(Ljava/lang/String;Ljava/lang/Class;)V

    .line 179
    new-instance v3, Landroid/hardware/camera2/CaptureRequest$Key;

    const-string v4, "org.quic.camera.recording.endOfStream"

    const-class v5, Ljava/lang/Byte;

    invoke-direct {v3, v4, v5}, Landroid/hardware/camera2/CaptureRequest$Key;-><init>(Ljava/lang/String;Ljava/lang/Class;)V

    .line 180
    const-class v4, Landroid/hardware/camera2/CaptureRequest$Builder;

    new-instance v5, Llocal/mio/os4camerabridge/SlowMotionRecorderBridge$10;

    invoke-direct {v5, v0, v1, v2, v3}, Llocal/mio/os4camerabridge/SlowMotionRecorderBridge$10;-><init>(Landroid/hardware/camera2/CaptureRequest$Key;Landroid/hardware/camera2/CaptureRequest$Key;Landroid/hardware/camera2/CaptureRequest$Key;Landroid/hardware/camera2/CaptureRequest$Key;)V

    filled-new-array {v5}, [Ljava/lang/Object;

    move-result-object v0

    const-string v1, "build"

    invoke-static {v4, v1, v0}, Lde/robv/android/xposed/XposedHelpers;->findAndHookMethod(Ljava/lang/Class;Ljava/lang/String;[Ljava/lang/Object;)Lde/robv/android/xposed/XC_MethodHook$Unhook;

    .line 190
    const-class v0, Landroid/media/MediaRecorder;

    new-instance v1, Llocal/mio/os4camerabridge/SlowMotionRecorderBridge$11;

    invoke-direct {v1}, Llocal/mio/os4camerabridge/SlowMotionRecorderBridge$11;-><init>()V

    filled-new-array {v1}, [Ljava/lang/Object;

    move-result-object v1

    const-string v2, "start"

    invoke-static {v0, v2, v1}, Lde/robv/android/xposed/XposedHelpers;->findAndHookMethod(Ljava/lang/Class;Ljava/lang/String;[Ljava/lang/Object;)Lde/robv/android/xposed/XC_MethodHook$Unhook;

    .line 198
    const-string v0, "com.android.camera.module.VideoModule"

    invoke-static {v0, p0}, Lde/robv/android/xposed/XposedHelpers;->findClass(Ljava/lang/String;Ljava/lang/ClassLoader;)Ljava/lang/Class;

    move-result-object p0

    new-instance v0, Llocal/mio/os4camerabridge/SlowMotionRecorderBridge$12;

    invoke-direct {v0}, Llocal/mio/os4camerabridge/SlowMotionRecorderBridge$12;-><init>()V

    const-string v1, "stopVideoRecording"

    invoke-static {p0, v1, v0}, Lde/robv/android/xposed/XposedBridge;->hookAllMethods(Ljava/lang/Class;Ljava/lang/String;Lde/robv/android/xposed/XC_MethodHook;)Ljava/util/Set;

    .line 202
    const-string p0, "reset"

    const-string v0, "release"

    filled-new-array {p0, v0}, [Ljava/lang/String;

    move-result-object p0

    const/4 v0, 0x0

    :goto_0
    const/4 v1, 0x2

    if-ge v0, v1, :cond_0

    aget-object v1, p0, v0

    const-class v2, Landroid/media/MediaRecorder;

    new-instance v3, Llocal/mio/os4camerabridge/SlowMotionRecorderBridge$13;

    invoke-direct {v3}, Llocal/mio/os4camerabridge/SlowMotionRecorderBridge$13;-><init>()V

    filled-new-array {v3}, [Ljava/lang/Object;

    move-result-object v3

    invoke-static {v2, v1, v3}, Lde/robv/android/xposed/XposedHelpers;->findAndHookMethod(Ljava/lang/Class;Ljava/lang/String;[Ljava/lang/Object;)Lde/robv/android/xposed/XC_MethodHook$Unhook;

    add-int/lit8 v0, v0, 0x1

    goto :goto_0

    .line 206
    :cond_0
    return-void
.end method

.method public static enable()V
    .locals 1

    .line 24
    const/4 v0, 0x1

    sput-boolean v0, Llocal/mio/os4camerabridge/SlowMotionRecorderBridge;->enabled:Z

    return-void
.end method

.method public static isEnabled()Z
    .locals 1

    .line 25
    sget-boolean v0, Llocal/mio/os4camerabridge/SlowMotionRecorderBridge;->enabled:Z

    return v0
.end method

.method static synthetic lambda$bind$2(Ljava/lang/Class;)Ljava/util/Set;
    .locals 0

    .line 57
    new-instance p0, Ljava/util/LinkedHashSet;

    invoke-direct {p0}, Ljava/util/LinkedHashSet;-><init>()V

    return-object p0
.end method

.method static synthetic lambda$bind$3(Ljava/util/Set;)Z
    .locals 1

    .line 59
    invoke-interface {p0}, Ljava/util/Set;->size()I

    move-result p0

    const/4 v0, 0x2

    if-ne p0, v0, :cond_0

    const/4 p0, 0x1

    goto :goto_0

    :cond_0
    const/4 p0, 0x0

    :goto_0
    return p0
.end method

.method static synthetic lambda$bind$4(Ljava/util/Set;Ljava/lang/ClassLoader;Ljava/lang/Class;Lorg/luckypray/dexkit/result/MethodData;)Z
    .locals 5

    .line 51
    const/4 v0, 0x1

    :try_start_0
    invoke-virtual {p3, p1}, Lorg/luckypray/dexkit/result/MethodData;->getClassInstance(Ljava/lang/ClassLoader;)Ljava/lang/Class;

    move-result-object v1

    invoke-interface {p0, v1}, Ljava/util/Set;->contains(Ljava/lang/Object;)Z

    move-result p0

    if-nez p0, :cond_0

    return v0

    .line 52
    :cond_0
    new-instance p0, Ljava/util/LinkedHashMap;

    invoke-direct {p0}, Ljava/util/LinkedHashMap;-><init>()V

    .line 53
    invoke-virtual {p3}, Lorg/luckypray/dexkit/result/MethodData;->getInvokes()Lorg/luckypray/dexkit/result/MethodDataList;

    move-result-object v1

    invoke-virtual {v1}, Lorg/luckypray/dexkit/result/MethodDataList;->iterator()Ljava/util/Iterator;

    move-result-object v1

    :cond_1
    :goto_0
    invoke-interface {v1}, Ljava/util/Iterator;->hasNext()Z

    move-result v2

    if-eqz v2, :cond_2

    invoke-interface {v1}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v2

    check-cast v2, Lorg/luckypray/dexkit/result/MethodData;

    invoke-virtual {v2}, Lorg/luckypray/dexkit/result/MethodData;->isMethod()Z

    move-result v3

    if-eqz v3, :cond_1

    .line 54
    invoke-virtual {v2, p1}, Lorg/luckypray/dexkit/result/MethodData;->getMethodInstance(Ljava/lang/ClassLoader;)Ljava/lang/reflect/Method;

    move-result-object v2

    .line 55
    invoke-virtual {v2}, Ljava/lang/reflect/Method;->getModifiers()I

    move-result v3

    invoke-static {v3}, Ljava/lang/reflect/Modifier;->isStatic(I)Z

    move-result v3

    if-nez v3, :cond_1

    invoke-virtual {v2}, Ljava/lang/reflect/Method;->getReturnType()Ljava/lang/Class;

    move-result-object v3

    sget-object v4, Ljava/lang/Boolean;->TYPE:Ljava/lang/Class;

    if-ne v3, v4, :cond_1

    .line 56
    invoke-virtual {v2}, Ljava/lang/reflect/Method;->getParameterCount()I

    move-result v3

    if-nez v3, :cond_1

    .line 57
    invoke-virtual {v2}, Ljava/lang/reflect/Method;->getDeclaringClass()Ljava/lang/Class;

    move-result-object v3

    new-instance v4, Llocal/mio/os4camerabridge/SlowMotionRecorderBridge$$ExternalSyntheticLambda4;

    invoke-direct {v4}, Llocal/mio/os4camerabridge/SlowMotionRecorderBridge$$ExternalSyntheticLambda4;-><init>()V

    invoke-interface {p0, v3, v4}, Ljava/util/Map;->computeIfAbsent(Ljava/lang/Object;Ljava/util/function/Function;)Ljava/lang/Object;

    move-result-object v3

    check-cast v3, Ljava/util/Set;

    invoke-interface {v3, v2}, Ljava/util/Set;->add(Ljava/lang/Object;)Z

    goto :goto_0

    .line 59
    :cond_2
    invoke-interface {p0}, Ljava/util/Map;->values()Ljava/util/Collection;

    move-result-object p0

    invoke-interface {p0}, Ljava/util/Collection;->stream()Ljava/util/stream/Stream;

    move-result-object p0

    new-instance v1, Llocal/mio/os4camerabridge/SlowMotionRecorderBridge$$ExternalSyntheticLambda5;

    invoke-direct {v1}, Llocal/mio/os4camerabridge/SlowMotionRecorderBridge$$ExternalSyntheticLambda5;-><init>()V

    invoke-interface {p0, v1}, Ljava/util/stream/Stream;->filter(Ljava/util/function/Predicate;)Ljava/util/stream/Stream;

    move-result-object p0

    invoke-interface {p0}, Ljava/util/stream/Stream;->count()J

    move-result-wide v1

    .line 60
    invoke-virtual {p3, p1}, Lorg/luckypray/dexkit/result/MethodData;->getMethodInstance(Ljava/lang/ClassLoader;)Ljava/lang/reflect/Method;

    move-result-object p0

    invoke-static {p0}, Ljava/lang/String;->valueOf(Ljava/lang/Object;)Ljava/lang/String;

    move-result-object p0

    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    const-string v4, "[SlowMotionRecorder] candidate="

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3, p0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p0

    const-string v3, " selectorPairs="

    invoke-virtual {p0, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p0

    invoke-virtual {p0, v1, v2}, Ljava/lang/StringBuilder;->append(J)Ljava/lang/StringBuilder;

    move-result-object p0

    invoke-virtual {p0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p0

    invoke-static {p0}, Lde/robv/android/xposed/XposedBridge;->log(Ljava/lang/String;)V

    .line 62
    const-wide/16 v3, 0x1

    cmp-long p0, v1, v3

    if-eqz p0, :cond_3

    return v0

    .line 63
    :cond_3
    invoke-virtual {p3, p1}, Lorg/luckypray/dexkit/result/MethodData;->getClassInstance(Ljava/lang/ClassLoader;)Ljava/lang/Class;

    move-result-object p0

    invoke-virtual {p0}, Ljava/lang/Class;->getDeclaredFields()[Ljava/lang/reflect/Field;

    move-result-object p0

    array-length p1, p0

    const/4 p3, 0x0

    move v1, p3

    :goto_1
    if-ge v1, p1, :cond_5

    aget-object v2, p0, v1

    .line 64
    invoke-virtual {v2}, Ljava/lang/reflect/Field;->getType()Ljava/lang/Class;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/Class;->isInterface()Z

    move-result v3

    if-eqz v3, :cond_4

    invoke-virtual {v2}, Ljava/lang/reflect/Field;->getType()Ljava/lang/Class;

    move-result-object v2

    invoke-virtual {v2, p2}, Ljava/lang/Class;->isAssignableFrom(Ljava/lang/Class;)Z

    move-result v2
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    if-eqz v2, :cond_4

    return p3

    .line 63
    :cond_4
    add-int/lit8 v1, v1, 0x1

    goto :goto_1

    .line 65
    :catchall_0
    move-exception p0

    :cond_5
    nop

    .line 66
    return v0
.end method

.method static synthetic lambda$bind$5(Ljava/lang/Class;)Ljava/util/Set;
    .locals 0

    .line 76
    new-instance p0, Ljava/util/LinkedHashSet;

    invoke-direct {p0}, Ljava/util/LinkedHashSet;-><init>()V

    return-object p0
.end method

.method static synthetic lambda$bindLockedComponent$6(Ljava/lang/String;Lorg/luckypray/dexkit/result/MethodData;)Z
    .locals 0

    .line 212
    invoke-virtual {p1}, Lorg/luckypray/dexkit/result/MethodData;->getUsingStrings()Ljava/util/List;

    move-result-object p1

    invoke-interface {p1, p0}, Ljava/util/List;->contains(Ljava/lang/Object;)Z

    move-result p0

    xor-int/lit8 p0, p0, 0x1

    return p0
.end method

.method static synthetic lambda$static$0()Ljava/lang/Integer;
    .locals 1

    .line 20
    const/4 v0, 0x0

    invoke-static {v0}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v0

    return-object v0
.end method

.method static synthetic lambda$static$1()Ljava/lang/Boolean;
    .locals 1

    .line 21
    const/4 v0, 0x0

    invoke-static {v0}, Ljava/lang/Boolean;->valueOf(Z)Ljava/lang/Boolean;

    move-result-object v0

    return-object v0
.end method
