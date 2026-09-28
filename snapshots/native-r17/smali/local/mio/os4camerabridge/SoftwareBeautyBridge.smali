.class public final Llocal/mio/os4camerabridge/SoftwareBeautyBridge;
.super Ljava/lang/Object;
.source "SoftwareBeautyBridge.java"


# static fields
.field private static final FILTER:Ljava/lang/ThreadLocal;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/lang/ThreadLocal<",
            "Llocal/mio/os4camerabridge/SoftwareSkinSmoothing;",
            ">;"
        }
    .end annotation
.end field

.field private static final KEY:Ljava/lang/String; = "pref_beautify_skin_smooth_ratio_key"

.field private static final PANEL_READ_DEPTH:Ljava/lang/ThreadLocal;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/lang/ThreadLocal<",
            "Ljava/lang/Integer;",
            ">;"
        }
    .end annotation
.end field

.field private static volatile beautySelected:Z

.field private static camera:Ljava/lang/reflect/Field;

.field private static volatile enabled:Z

.field private static lastLog:J

.field private static volatile level:I

.field private static mode:Ljava/lang/reflect/Field;

.field private static volatile ready:Z

.field private static retryAt:J


# direct methods
.method static bridge synthetic -$$Nest$sfgetFILTER()Ljava/lang/ThreadLocal;
    .locals 1

    sget-object v0, Llocal/mio/os4camerabridge/SoftwareBeautyBridge;->FILTER:Ljava/lang/ThreadLocal;

    return-object v0
.end method

.method static bridge synthetic -$$Nest$sfgetPANEL_READ_DEPTH()Ljava/lang/ThreadLocal;
    .locals 1

    sget-object v0, Llocal/mio/os4camerabridge/SoftwareBeautyBridge;->PANEL_READ_DEPTH:Ljava/lang/ThreadLocal;

    return-object v0
.end method

.method static bridge synthetic -$$Nest$sfgetbeautySelected()Z
    .locals 1

    sget-boolean v0, Llocal/mio/os4camerabridge/SoftwareBeautyBridge;->beautySelected:Z

    return v0
.end method

.method static bridge synthetic -$$Nest$sfgetlastLog()J
    .locals 2

    sget-wide v0, Llocal/mio/os4camerabridge/SoftwareBeautyBridge;->lastLog:J

    return-wide v0
.end method

.method static bridge synthetic -$$Nest$sfgetlevel()I
    .locals 1

    sget v0, Llocal/mio/os4camerabridge/SoftwareBeautyBridge;->level:I

    return v0
.end method

.method static bridge synthetic -$$Nest$sfgetretryAt()J
    .locals 2

    sget-wide v0, Llocal/mio/os4camerabridge/SoftwareBeautyBridge;->retryAt:J

    return-wide v0
.end method

.method static bridge synthetic -$$Nest$sfputbeautySelected(Z)V
    .locals 0

    sput-boolean p0, Llocal/mio/os4camerabridge/SoftwareBeautyBridge;->beautySelected:Z

    return-void
.end method

.method static bridge synthetic -$$Nest$sfputlastLog(J)V
    .locals 0

    sput-wide p0, Llocal/mio/os4camerabridge/SoftwareBeautyBridge;->lastLog:J

    return-void
.end method

.method static bridge synthetic -$$Nest$sfputlevel(I)V
    .locals 0

    sput p0, Llocal/mio/os4camerabridge/SoftwareBeautyBridge;->level:I

    return-void
.end method

.method static bridge synthetic -$$Nest$sfputretryAt(J)V
    .locals 0

    sput-wide p0, Llocal/mio/os4camerabridge/SoftwareBeautyBridge;->retryAt:J

    return-void
.end method

.method static bridge synthetic -$$Nest$smclamp(I)I
    .locals 0

    invoke-static {p0}, Llocal/mio/os4camerabridge/SoftwareBeautyBridge;->clamp(I)I

    move-result p0

    return p0
.end method

.method static bridge synthetic -$$Nest$sminScope()Z
    .locals 1

    invoke-static {}, Llocal/mio/os4camerabridge/SoftwareBeautyBridge;->inScope()Z

    move-result v0

    return v0
.end method

.method static bridge synthetic -$$Nest$smstrength()F
    .locals 1

    invoke-static {}, Llocal/mio/os4camerabridge/SoftwareBeautyBridge;->strength()F

    move-result v0

    return v0
.end method

.method static constructor <clinit>()V
    .locals 1

    .line 19
    new-instance v0, Llocal/mio/os4camerabridge/SoftwareBeautyBridge$$ExternalSyntheticLambda0;

    invoke-direct {v0}, Llocal/mio/os4camerabridge/SoftwareBeautyBridge$$ExternalSyntheticLambda0;-><init>()V

    invoke-static {v0}, Ljava/lang/ThreadLocal;->withInitial(Ljava/util/function/Supplier;)Ljava/lang/ThreadLocal;

    move-result-object v0

    sput-object v0, Llocal/mio/os4camerabridge/SoftwareBeautyBridge;->FILTER:Ljava/lang/ThreadLocal;

    .line 20
    new-instance v0, Llocal/mio/os4camerabridge/SoftwareBeautyBridge$$ExternalSyntheticLambda1;

    invoke-direct {v0}, Llocal/mio/os4camerabridge/SoftwareBeautyBridge$$ExternalSyntheticLambda1;-><init>()V

    invoke-static {v0}, Ljava/lang/ThreadLocal;->withInitial(Ljava/util/function/Supplier;)Ljava/lang/ThreadLocal;

    move-result-object v0

    sput-object v0, Llocal/mio/os4camerabridge/SoftwareBeautyBridge;->PANEL_READ_DEPTH:Ljava/lang/ThreadLocal;

    return-void
.end method

.method private constructor <init>()V
    .locals 0

    .line 22
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method public static bind(Lorg/luckypray/dexkit/DexKitBridge;Ljava/lang/ClassLoader;)V
    .locals 26

    .line 28
    move-object/from16 v0, p0

    move-object/from16 v1, p1

    const-class v2, [B

    const/4 v3, 0x0

    :try_start_0
    const-string v4, "local.mio.os4camerabridge.HookEntry"

    const-class v5, Llocal/mio/os4camerabridge/SoftwareBeautyBridge;

    invoke-virtual {v5}, Ljava/lang/Class;->getClassLoader()Ljava/lang/ClassLoader;

    move-result-object v5

    invoke-static {v4, v3, v5}, Ljava/lang/Class;->forName(Ljava/lang/String;ZLjava/lang/ClassLoader;)Ljava/lang/Class;

    move-result-object v4

    .line 29
    const-string v5, "activeCameraId"

    invoke-virtual {v4, v5}, Ljava/lang/Class;->getDeclaredField(Ljava/lang/String;)Ljava/lang/reflect/Field;

    move-result-object v5

    sput-object v5, Llocal/mio/os4camerabridge/SoftwareBeautyBridge;->camera:Ljava/lang/reflect/Field;

    const-string v5, "activeBeautyModule"

    invoke-virtual {v4, v5}, Ljava/lang/Class;->getDeclaredField(Ljava/lang/String;)Ljava/lang/reflect/Field;

    move-result-object v4

    sput-object v4, Llocal/mio/os4camerabridge/SoftwareBeautyBridge;->mode:Ljava/lang/reflect/Field;

    .line 30
    sget-object v4, Llocal/mio/os4camerabridge/SoftwareBeautyBridge;->camera:Ljava/lang/reflect/Field;

    const/4 v5, 0x1

    invoke-virtual {v4, v5}, Ljava/lang/reflect/Field;->setAccessible(Z)V

    sget-object v4, Llocal/mio/os4camerabridge/SoftwareBeautyBridge;->mode:Ljava/lang/reflect/Field;

    invoke-virtual {v4, v5}, Ljava/lang/reflect/Field;->setAccessible(Z)V

    .line 31
    invoke-static {}, Lorg/luckypray/dexkit/query/FindMethod;->create()Lorg/luckypray/dexkit/query/FindMethod;

    move-result-object v4

    invoke-static {}, Lorg/luckypray/dexkit/query/matchers/MethodMatcher;->create()Lorg/luckypray/dexkit/query/matchers/MethodMatcher;

    move-result-object v6

    const-string v7, "BeautySmoothLevelFragment"

    filled-new-array {v7}, [Ljava/lang/String;

    move-result-object v7

    .line 32
    invoke-virtual {v6, v7}, Lorg/luckypray/dexkit/query/matchers/MethodMatcher;->usingStrings([Ljava/lang/String;)Lorg/luckypray/dexkit/query/matchers/MethodMatcher;

    move-result-object v6

    const-class v7, Ljava/lang/String;

    invoke-virtual {v6, v7}, Lorg/luckypray/dexkit/query/matchers/MethodMatcher;->returnType(Ljava/lang/Class;)Lorg/luckypray/dexkit/query/matchers/MethodMatcher;

    move-result-object v6

    invoke-virtual {v6, v3}, Lorg/luckypray/dexkit/query/matchers/MethodMatcher;->paramCount(I)Lorg/luckypray/dexkit/query/matchers/MethodMatcher;

    move-result-object v6

    .line 31
    invoke-virtual {v4, v6}, Lorg/luckypray/dexkit/query/FindMethod;->matcher(Lorg/luckypray/dexkit/query/matchers/MethodMatcher;)Lorg/luckypray/dexkit/query/FindMethod;

    move-result-object v4

    invoke-virtual {v0, v4}, Lorg/luckypray/dexkit/DexKitBridge;->findMethod(Lorg/luckypray/dexkit/query/FindMethod;)Lorg/luckypray/dexkit/result/MethodDataList;

    move-result-object v4

    .line 33
    invoke-virtual {v4}, Lorg/luckypray/dexkit/result/MethodDataList;->size()I

    move-result v6

    if-ne v6, v5, :cond_35

    .line 34
    invoke-virtual {v4, v3}, Lorg/luckypray/dexkit/result/MethodDataList;->get(I)Ljava/lang/Object;

    move-result-object v4

    check-cast v4, Lorg/luckypray/dexkit/result/MethodData;

    invoke-virtual {v4, v1}, Lorg/luckypray/dexkit/result/MethodData;->getClassInstance(Ljava/lang/ClassLoader;)Ljava/lang/Class;

    move-result-object v4

    .line 35
    invoke-static {}, Lorg/luckypray/dexkit/query/FindMethod;->create()Lorg/luckypray/dexkit/query/FindMethod;

    move-result-object v6

    invoke-static {}, Lorg/luckypray/dexkit/query/matchers/MethodMatcher;->create()Lorg/luckypray/dexkit/query/matchers/MethodMatcher;

    move-result-object v7

    .line 36
    invoke-virtual {v7, v4}, Lorg/luckypray/dexkit/query/matchers/MethodMatcher;->declaredClass(Ljava/lang/Class;)Lorg/luckypray/dexkit/query/matchers/MethodMatcher;

    move-result-object v7

    sget-object v8, Ljava/lang/Boolean;->TYPE:Ljava/lang/Class;

    invoke-virtual {v7, v8}, Lorg/luckypray/dexkit/query/matchers/MethodMatcher;->returnType(Ljava/lang/Class;)Lorg/luckypray/dexkit/query/matchers/MethodMatcher;

    move-result-object v7

    invoke-virtual {v7, v3}, Lorg/luckypray/dexkit/query/matchers/MethodMatcher;->paramCount(I)Lorg/luckypray/dexkit/query/matchers/MethodMatcher;

    move-result-object v7

    .line 35
    invoke-virtual {v6, v7}, Lorg/luckypray/dexkit/query/FindMethod;->matcher(Lorg/luckypray/dexkit/query/matchers/MethodMatcher;)Lorg/luckypray/dexkit/query/FindMethod;

    move-result-object v6

    invoke-virtual {v0, v6}, Lorg/luckypray/dexkit/DexKitBridge;->findMethod(Lorg/luckypray/dexkit/query/FindMethod;)Lorg/luckypray/dexkit/result/MethodDataList;

    move-result-object v6

    .line 37
    invoke-virtual {v6}, Lorg/luckypray/dexkit/result/MethodDataList;->size()I

    move-result v7

    if-ne v7, v5, :cond_34

    .line 38
    invoke-virtual {v6, v3}, Lorg/luckypray/dexkit/result/MethodDataList;->get(I)Ljava/lang/Object;

    move-result-object v6

    check-cast v6, Lorg/luckypray/dexkit/result/MethodData;

    invoke-virtual {v6, v1}, Lorg/luckypray/dexkit/result/MethodData;->getMethodInstance(Ljava/lang/ClassLoader;)Ljava/lang/reflect/Method;

    move-result-object v6

    .line 39
    invoke-virtual {v6, v5}, Ljava/lang/reflect/Method;->setAccessible(Z)V

    .line 40
    invoke-static {}, Lorg/luckypray/dexkit/query/FindMethod;->create()Lorg/luckypray/dexkit/query/FindMethod;

    move-result-object v7

    invoke-static {}, Lorg/luckypray/dexkit/query/matchers/MethodMatcher;->create()Lorg/luckypray/dexkit/query/matchers/MethodMatcher;

    move-result-object v8

    invoke-virtual {v8, v4}, Lorg/luckypray/dexkit/query/matchers/MethodMatcher;->declaredClass(Ljava/lang/Class;)Lorg/luckypray/dexkit/query/matchers/MethodMatcher;

    move-result-object v4

    const-string v8, "pref_beautify_skin_smooth_ratio_key"

    filled-new-array {v8}, [Ljava/lang/String;

    move-result-object v8

    invoke-virtual {v4, v8}, Lorg/luckypray/dexkit/query/matchers/MethodMatcher;->usingStrings([Ljava/lang/String;)Lorg/luckypray/dexkit/query/matchers/MethodMatcher;

    move-result-object v4

    invoke-virtual {v7, v4}, Lorg/luckypray/dexkit/query/FindMethod;->matcher(Lorg/luckypray/dexkit/query/matchers/MethodMatcher;)Lorg/luckypray/dexkit/query/FindMethod;

    move-result-object v4

    invoke-virtual {v0, v4}, Lorg/luckypray/dexkit/DexKitBridge;->findMethod(Lorg/luckypray/dexkit/query/FindMethod;)Lorg/luckypray/dexkit/result/MethodDataList;

    move-result-object v4

    .line 41
    new-instance v7, Ljava/util/LinkedHashSet;

    invoke-direct {v7}, Ljava/util/LinkedHashSet;-><init>()V

    new-instance v8, Ljava/util/LinkedHashSet;

    invoke-direct {v8}, Ljava/util/LinkedHashSet;-><init>()V

    .line 42
    invoke-virtual {v4}, Lorg/luckypray/dexkit/result/MethodDataList;->iterator()Ljava/util/Iterator;

    move-result-object v9

    :cond_0
    invoke-interface {v9}, Ljava/util/Iterator;->hasNext()Z

    move-result v10

    const/4 v11, 0x2

    if-eqz v10, :cond_6

    invoke-interface {v9}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v10

    check-cast v10, Lorg/luckypray/dexkit/result/MethodData;

    invoke-virtual {v10}, Lorg/luckypray/dexkit/result/MethodData;->getInvokes()Lorg/luckypray/dexkit/result/MethodDataList;

    move-result-object v10

    invoke-virtual {v10}, Lorg/luckypray/dexkit/result/MethodDataList;->iterator()Ljava/util/Iterator;

    move-result-object v10

    :cond_1
    :goto_0
    invoke-interface {v10}, Ljava/util/Iterator;->hasNext()Z

    move-result v12

    if-eqz v12, :cond_0

    invoke-interface {v10}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v12

    check-cast v12, Lorg/luckypray/dexkit/result/MethodData;

    .line 43
    invoke-virtual {v12}, Lorg/luckypray/dexkit/result/MethodData;->isMethod()Z

    move-result v13

    if-nez v13, :cond_2

    goto :goto_0

    .line 44
    :cond_2
    invoke-virtual {v12, v1}, Lorg/luckypray/dexkit/result/MethodData;->getMethodInstance(Ljava/lang/ClassLoader;)Ljava/lang/reflect/Method;

    move-result-object v12

    invoke-virtual {v12}, Ljava/lang/reflect/Method;->getParameterTypes()[Ljava/lang/Class;

    move-result-object v13

    .line 45
    invoke-virtual {v12}, Ljava/lang/reflect/Method;->getModifiers()I

    move-result v14

    invoke-static {v14}, Ljava/lang/reflect/Modifier;->isStatic(I)Z

    move-result v14

    if-eqz v14, :cond_1

    array-length v14, v13

    if-eq v14, v11, :cond_3

    goto :goto_0

    .line 46
    :cond_3
    invoke-virtual {v12}, Ljava/lang/reflect/Method;->getReturnType()Ljava/lang/Class;

    move-result-object v14

    sget-object v15, Ljava/lang/Integer;->TYPE:Ljava/lang/Class;

    if-ne v14, v15, :cond_4

    aget-object v14, v13, v3

    const-class v15, Ljava/lang/String;

    if-ne v14, v15, :cond_4

    aget-object v14, v13, v5

    invoke-virtual {v14}, Ljava/lang/Class;->isPrimitive()Z

    move-result v14

    if-nez v14, :cond_4

    invoke-interface {v7, v12}, Ljava/util/Set;->add(Ljava/lang/Object;)Z

    .line 47
    :cond_4
    invoke-virtual {v12}, Ljava/lang/reflect/Method;->getReturnType()Ljava/lang/Class;

    move-result-object v14

    sget-object v15, Ljava/lang/Void;->TYPE:Ljava/lang/Class;

    if-ne v14, v15, :cond_5

    aget-object v14, v13, v3

    sget-object v15, Ljava/lang/Integer;->TYPE:Ljava/lang/Class;

    if-ne v14, v15, :cond_5

    aget-object v13, v13, v5

    const-class v14, Ljava/lang/String;

    if-ne v13, v14, :cond_5

    invoke-interface {v8, v12}, Ljava/util/Set;->add(Ljava/lang/Object;)Z

    .line 48
    :cond_5
    goto :goto_0

    .line 49
    :cond_6
    invoke-interface {v7}, Ljava/util/Set;->isEmpty()Z

    move-result v9
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    const-string v10, " writers="

    if-nez v9, :cond_33

    :try_start_1
    invoke-interface {v7}, Ljava/util/Set;->size()I

    move-result v9

    if-gt v9, v11, :cond_33

    invoke-interface {v8}, Ljava/util/Set;->size()I

    move-result v9

    if-ne v9, v5, :cond_33

    .line 53
    new-instance v9, Ljava/util/LinkedHashSet;

    invoke-direct {v9}, Ljava/util/LinkedHashSet;-><init>()V

    .line 54
    invoke-virtual {v4}, Lorg/luckypray/dexkit/result/MethodDataList;->iterator()Ljava/util/Iterator;

    move-result-object v12

    :goto_1
    invoke-interface {v12}, Ljava/util/Iterator;->hasNext()Z

    move-result v13

    if-eqz v13, :cond_c

    invoke-interface {v12}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v13

    check-cast v13, Lorg/luckypray/dexkit/result/MethodData;

    invoke-virtual {v13}, Lorg/luckypray/dexkit/result/MethodData;->getInvokes()Lorg/luckypray/dexkit/result/MethodDataList;

    move-result-object v13

    invoke-virtual {v13}, Lorg/luckypray/dexkit/result/MethodDataList;->iterator()Ljava/util/Iterator;

    move-result-object v13

    :goto_2
    invoke-interface {v13}, Ljava/util/Iterator;->hasNext()Z

    move-result v14

    if-eqz v14, :cond_b

    invoke-interface {v13}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v14

    check-cast v14, Lorg/luckypray/dexkit/result/MethodData;

    .line 55
    invoke-virtual {v14}, Lorg/luckypray/dexkit/result/MethodData;->isMethod()Z

    move-result v15

    if-eqz v15, :cond_a

    invoke-virtual {v14, v1}, Lorg/luckypray/dexkit/result/MethodData;->getMethodInstance(Ljava/lang/ClassLoader;)Ljava/lang/reflect/Method;

    move-result-object v15

    invoke-interface {v7, v15}, Ljava/util/Set;->contains(Ljava/lang/Object;)Z

    move-result v15

    if-nez v15, :cond_7

    goto :goto_2

    .line 56
    :cond_7
    invoke-virtual {v14}, Lorg/luckypray/dexkit/result/MethodData;->getInvokes()Lorg/luckypray/dexkit/result/MethodDataList;

    move-result-object v15

    invoke-virtual {v15}, Lorg/luckypray/dexkit/result/MethodDataList;->iterator()Ljava/util/Iterator;

    move-result-object v15

    :goto_3
    invoke-interface {v15}, Ljava/util/Iterator;->hasNext()Z

    move-result v16

    if-eqz v16, :cond_9

    invoke-interface {v15}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v16

    move-object/from16 v11, v16

    check-cast v11, Lorg/luckypray/dexkit/result/MethodData;

    invoke-virtual {v11}, Lorg/luckypray/dexkit/result/MethodData;->isMethod()Z

    move-result v16

    if-eqz v16, :cond_8

    .line 57
    invoke-virtual {v11, v1}, Lorg/luckypray/dexkit/result/MethodData;->getMethodInstance(Ljava/lang/ClassLoader;)Ljava/lang/reflect/Method;

    move-result-object v11

    .line 58
    invoke-interface {v7, v11}, Ljava/util/Set;->contains(Ljava/lang/Object;)Z

    move-result v16

    if-eqz v16, :cond_8

    invoke-virtual {v14, v1}, Lorg/luckypray/dexkit/result/MethodData;->getMethodInstance(Ljava/lang/ClassLoader;)Ljava/lang/reflect/Method;

    move-result-object v3

    invoke-virtual {v11, v3}, Ljava/lang/reflect/Method;->equals(Ljava/lang/Object;)Z

    move-result v3

    if-nez v3, :cond_8

    invoke-interface {v9, v11}, Ljava/util/Set;->add(Ljava/lang/Object;)Z

    .line 56
    :cond_8
    const/4 v3, 0x0

    const/4 v11, 0x2

    goto :goto_3

    .line 60
    :cond_9
    const/4 v3, 0x0

    const/4 v11, 0x2

    goto :goto_2

    .line 55
    :cond_a
    const/4 v3, 0x0

    const/4 v11, 0x2

    goto :goto_2

    .line 54
    :cond_b
    const/4 v3, 0x0

    const/4 v11, 0x2

    goto :goto_1

    .line 61
    :cond_c
    invoke-interface {v7, v9}, Ljava/util/Set;->removeAll(Ljava/util/Collection;)Z

    .line 62
    invoke-interface {v7}, Ljava/util/Set;->size()I

    move-result v3

    if-ne v3, v5, :cond_32

    .line 65
    invoke-static {}, Lorg/luckypray/dexkit/query/FindMethod;->create()Lorg/luckypray/dexkit/query/FindMethod;

    move-result-object v3

    invoke-static {}, Lorg/luckypray/dexkit/query/matchers/MethodMatcher;->create()Lorg/luckypray/dexkit/query/matchers/MethodMatcher;

    move-result-object v9

    const-string v11, "New PreviewRenderEngine instance isSupport10Bit: "

    filled-new-array {v11}, [Ljava/lang/String;

    move-result-object v11

    .line 66
    invoke-virtual {v9, v11}, Lorg/luckypray/dexkit/query/matchers/MethodMatcher;->usingStrings([Ljava/lang/String;)Lorg/luckypray/dexkit/query/matchers/MethodMatcher;

    move-result-object v9

    .line 65
    invoke-virtual {v3, v9}, Lorg/luckypray/dexkit/query/FindMethod;->matcher(Lorg/luckypray/dexkit/query/matchers/MethodMatcher;)Lorg/luckypray/dexkit/query/FindMethod;

    move-result-object v3

    invoke-virtual {v0, v3}, Lorg/luckypray/dexkit/DexKitBridge;->findMethod(Lorg/luckypray/dexkit/query/FindMethod;)Lorg/luckypray/dexkit/result/MethodDataList;

    move-result-object v3

    .line 67
    invoke-static {}, Lorg/luckypray/dexkit/query/FindMethod;->create()Lorg/luckypray/dexkit/query/FindMethod;

    move-result-object v9

    invoke-static {}, Lorg/luckypray/dexkit/query/matchers/MethodMatcher;->create()Lorg/luckypray/dexkit/query/matchers/MethodMatcher;

    move-result-object v11

    const-string v12, "New DoubleBuffer"

    filled-new-array {v12}, [Ljava/lang/String;

    move-result-object v12

    invoke-virtual {v11, v12}, Lorg/luckypray/dexkit/query/matchers/MethodMatcher;->usingStrings([Ljava/lang/String;)Lorg/luckypray/dexkit/query/matchers/MethodMatcher;

    move-result-object v11

    invoke-virtual {v9, v11}, Lorg/luckypray/dexkit/query/FindMethod;->matcher(Lorg/luckypray/dexkit/query/matchers/MethodMatcher;)Lorg/luckypray/dexkit/query/FindMethod;

    move-result-object v9

    invoke-virtual {v0, v9}, Lorg/luckypray/dexkit/DexKitBridge;->findMethod(Lorg/luckypray/dexkit/query/FindMethod;)Lorg/luckypray/dexkit/result/MethodDataList;

    move-result-object v9

    .line 68
    new-instance v11, Ljava/util/LinkedHashSet;

    invoke-direct {v11}, Ljava/util/LinkedHashSet;-><init>()V

    new-instance v12, Ljava/util/LinkedHashSet;

    invoke-direct {v12}, Ljava/util/LinkedHashSet;-><init>()V

    .line 69
    invoke-virtual {v3}, Lorg/luckypray/dexkit/result/MethodDataList;->iterator()Ljava/util/Iterator;

    move-result-object v3

    :goto_4
    invoke-interface {v3}, Ljava/util/Iterator;->hasNext()Z

    move-result v13

    if-eqz v13, :cond_d

    invoke-interface {v3}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v13

    check-cast v13, Lorg/luckypray/dexkit/result/MethodData;

    invoke-virtual {v13, v1}, Lorg/luckypray/dexkit/result/MethodData;->getClassInstance(Ljava/lang/ClassLoader;)Ljava/lang/Class;

    move-result-object v13

    invoke-interface {v11, v13}, Ljava/util/Set;->add(Ljava/lang/Object;)Z

    goto :goto_4

    .line 70
    :cond_d
    invoke-virtual {v9}, Lorg/luckypray/dexkit/result/MethodDataList;->iterator()Ljava/util/Iterator;

    move-result-object v3

    :goto_5
    invoke-interface {v3}, Ljava/util/Iterator;->hasNext()Z

    move-result v9

    if-eqz v9, :cond_e

    invoke-interface {v3}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v9

    check-cast v9, Lorg/luckypray/dexkit/result/MethodData;

    invoke-virtual {v9, v1}, Lorg/luckypray/dexkit/result/MethodData;->getClassInstance(Ljava/lang/ClassLoader;)Ljava/lang/Class;

    move-result-object v9

    invoke-interface {v12, v9}, Ljava/util/Set;->add(Ljava/lang/Object;)Z

    goto :goto_5

    .line 73
    :cond_e
    new-instance v3, Ljava/util/LinkedHashSet;

    invoke-direct {v3}, Ljava/util/LinkedHashSet;-><init>()V

    .line 74
    invoke-interface {v11}, Ljava/util/Set;->iterator()Ljava/util/Iterator;

    move-result-object v9

    :goto_6
    invoke-interface {v9}, Ljava/util/Iterator;->hasNext()Z

    move-result v13

    if-eqz v13, :cond_11

    invoke-interface {v9}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v13

    check-cast v13, Ljava/lang/Class;

    invoke-virtual {v13}, Ljava/lang/Class;->getDeclaredFields()[Ljava/lang/reflect/Field;

    move-result-object v13

    array-length v14, v13

    const/4 v15, 0x0

    :goto_7
    if-ge v15, v14, :cond_10

    aget-object v17, v13, v15

    .line 75
    invoke-virtual/range {v17 .. v17}, Ljava/lang/reflect/Field;->getModifiers()I

    move-result v18

    invoke-static/range {v18 .. v18}, Ljava/lang/reflect/Modifier;->isStatic(I)Z

    move-result v18

    if-nez v18, :cond_f

    invoke-virtual/range {v17 .. v17}, Ljava/lang/reflect/Field;->getType()Ljava/lang/Class;

    move-result-object v5

    invoke-interface {v12, v5}, Ljava/util/Set;->contains(Ljava/lang/Object;)Z

    move-result v5

    if-eqz v5, :cond_f

    invoke-virtual/range {v17 .. v17}, Ljava/lang/reflect/Field;->getType()Ljava/lang/Class;

    move-result-object v5

    invoke-interface {v3, v5}, Ljava/util/Set;->add(Ljava/lang/Object;)Z

    .line 74
    :cond_f
    add-int/lit8 v15, v15, 0x1

    const/4 v5, 0x1

    goto :goto_7

    :cond_10
    const/4 v5, 0x1

    goto :goto_6

    .line 76
    :cond_11
    invoke-interface {v12, v3}, Ljava/util/Set;->retainAll(Ljava/util/Collection;)Z

    .line 77
    invoke-interface {v11}, Ljava/util/Set;->size()I

    move-result v3

    const/4 v5, 0x1

    if-ne v3, v5, :cond_31

    invoke-interface {v12}, Ljava/util/Set;->size()I

    move-result v3

    if-ne v3, v5, :cond_31

    .line 79
    invoke-interface {v11}, Ljava/util/Set;->iterator()Ljava/util/Iterator;

    move-result-object v3

    invoke-interface {v3}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v3

    check-cast v3, Ljava/lang/Class;

    invoke-interface {v12}, Ljava/util/Set;->iterator()Ljava/util/Iterator;

    move-result-object v5

    invoke-interface {v5}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v5

    check-cast v5, Ljava/lang/Class;

    .line 80
    invoke-static {}, Lorg/luckypray/dexkit/query/FindMethod;->create()Lorg/luckypray/dexkit/query/FindMethod;

    move-result-object v9

    invoke-static {}, Lorg/luckypray/dexkit/query/matchers/MethodMatcher;->create()Lorg/luckypray/dexkit/query/matchers/MethodMatcher;

    move-result-object v11

    invoke-virtual {v11, v3}, Lorg/luckypray/dexkit/query/matchers/MethodMatcher;->declaredClass(Ljava/lang/Class;)Lorg/luckypray/dexkit/query/matchers/MethodMatcher;

    move-result-object v11

    sget-object v12, Ljava/lang/Void;->TYPE:Ljava/lang/Class;

    .line 81
    invoke-virtual {v11, v12}, Lorg/luckypray/dexkit/query/matchers/MethodMatcher;->returnType(Ljava/lang/Class;)Lorg/luckypray/dexkit/query/matchers/MethodMatcher;

    move-result-object v11

    sget-object v12, Ljava/lang/Integer;->TYPE:Ljava/lang/Class;

    sget-object v13, Ljava/lang/Boolean;->TYPE:Ljava/lang/Class;

    filled-new-array {v12, v13}, [Ljava/lang/Class;

    move-result-object v12

    invoke-virtual {v11, v12}, Lorg/luckypray/dexkit/query/matchers/MethodMatcher;->paramTypes([Ljava/lang/Class;)Lorg/luckypray/dexkit/query/matchers/MethodMatcher;

    move-result-object v11

    .line 80
    invoke-virtual {v9, v11}, Lorg/luckypray/dexkit/query/FindMethod;->matcher(Lorg/luckypray/dexkit/query/matchers/MethodMatcher;)Lorg/luckypray/dexkit/query/FindMethod;

    move-result-object v9

    invoke-virtual {v0, v9}, Lorg/luckypray/dexkit/DexKitBridge;->findMethod(Lorg/luckypray/dexkit/query/FindMethod;)Lorg/luckypray/dexkit/result/MethodDataList;

    move-result-object v9

    .line 82
    invoke-virtual {v9}, Lorg/luckypray/dexkit/result/MethodDataList;->size()I

    move-result v11

    const/4 v12, 0x1

    if-ne v11, v12, :cond_30

    .line 83
    const/4 v11, 0x0

    invoke-virtual {v9, v11}, Lorg/luckypray/dexkit/result/MethodDataList;->get(I)Ljava/lang/Object;

    move-result-object v12

    check-cast v12, Lorg/luckypray/dexkit/result/MethodData;

    invoke-virtual {v12, v1}, Lorg/luckypray/dexkit/result/MethodData;->getMethodInstance(Ljava/lang/ClassLoader;)Ljava/lang/reflect/Method;

    move-result-object v11

    .line 84
    new-instance v12, Ljava/util/LinkedHashSet;

    invoke-direct {v12}, Ljava/util/LinkedHashSet;-><init>()V

    new-instance v13, Ljava/util/LinkedHashSet;

    invoke-direct {v13}, Ljava/util/LinkedHashSet;-><init>()V

    .line 85
    const/4 v14, 0x0

    invoke-virtual {v9, v14}, Lorg/luckypray/dexkit/result/MethodDataList;->get(I)Ljava/lang/Object;

    move-result-object v9

    check-cast v9, Lorg/luckypray/dexkit/result/MethodData;

    invoke-virtual {v9}, Lorg/luckypray/dexkit/result/MethodData;->getUsingFields()Ljava/util/List;

    move-result-object v9

    invoke-interface {v9}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object v9

    :goto_8
    invoke-interface {v9}, Ljava/util/Iterator;->hasNext()Z

    move-result v14

    if-eqz v14, :cond_14

    invoke-interface {v9}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v14

    check-cast v14, Lorg/luckypray/dexkit/result/UsingFieldData;

    .line 86
    invoke-virtual {v14}, Lorg/luckypray/dexkit/result/UsingFieldData;->getField()Lorg/luckypray/dexkit/result/FieldData;

    move-result-object v14

    invoke-virtual {v14, v1}, Lorg/luckypray/dexkit/result/FieldData;->getFieldInstance(Ljava/lang/ClassLoader;)Ljava/lang/reflect/Field;

    move-result-object v14

    .line 87
    invoke-virtual {v14}, Ljava/lang/reflect/Field;->getDeclaringClass()Ljava/lang/Class;

    move-result-object v15

    if-ne v15, v3, :cond_12

    invoke-virtual {v14}, Ljava/lang/reflect/Field;->getType()Ljava/lang/Class;

    move-result-object v15

    if-ne v15, v5, :cond_12

    invoke-interface {v12, v14}, Ljava/util/Set;->add(Ljava/lang/Object;)Z

    .line 88
    :cond_12
    invoke-virtual {v14}, Ljava/lang/reflect/Field;->getDeclaringClass()Ljava/lang/Class;

    move-result-object v15

    if-ne v15, v5, :cond_13

    invoke-virtual {v14}, Ljava/lang/reflect/Field;->getModifiers()I

    move-result v15

    invoke-static {v15}, Ljava/lang/reflect/Modifier;->isStatic(I)Z

    move-result v15

    if-nez v15, :cond_13

    invoke-interface {v13, v14}, Ljava/util/Set;->add(Ljava/lang/Object;)Z

    .line 89
    :cond_13
    goto :goto_8

    .line 90
    :cond_14
    invoke-interface {v12}, Ljava/util/Set;->size()I

    move-result v9

    const/4 v14, 0x1

    if-ne v9, v14, :cond_2f

    invoke-interface {v13}, Ljava/util/Set;->size()I

    move-result v9

    if-ne v9, v14, :cond_2f

    .line 91
    invoke-interface {v12}, Ljava/util/Set;->iterator()Ljava/util/Iterator;

    move-result-object v9

    invoke-interface {v9}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v9

    move-object/from16 v19, v9

    check-cast v19, Ljava/lang/reflect/Field;

    invoke-interface {v13}, Ljava/util/Set;->iterator()Ljava/util/Iterator;

    move-result-object v9

    invoke-interface {v9}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v9

    check-cast v9, Ljava/lang/reflect/Field;

    .line 92
    invoke-virtual {v5}, Ljava/lang/Class;->getDeclaredFields()[Ljava/lang/reflect/Field;

    move-result-object v5

    array-length v12, v5

    const/4 v14, 0x0

    const/16 v21, 0x0

    :goto_9
    if-ge v14, v12, :cond_18

    aget-object v15, v5, v14

    invoke-virtual {v15, v9}, Ljava/lang/reflect/Field;->equals(Ljava/lang/Object;)Z

    move-result v17

    if-nez v17, :cond_16

    invoke-virtual {v15}, Ljava/lang/reflect/Field;->getType()Ljava/lang/Class;

    move-result-object v13

    move-object/from16 v25, v4

    invoke-virtual {v9}, Ljava/lang/reflect/Field;->getType()Ljava/lang/Class;

    move-result-object v4

    if-ne v13, v4, :cond_17

    .line 93
    if-nez v21, :cond_15

    move-object/from16 v21, v15

    goto :goto_a

    :cond_15
    new-instance v0, Ljava/lang/IllegalStateException;

    const-string v1, "multiple output buffers"

    invoke-direct {v0, v1}, Ljava/lang/IllegalStateException;-><init>(Ljava/lang/String;)V

    throw v0

    .line 92
    :cond_16
    move-object/from16 v25, v4

    :cond_17
    :goto_a
    add-int/lit8 v14, v14, 0x1

    move-object/from16 v4, v25

    goto :goto_9

    .line 95
    :cond_18
    move-object/from16 v25, v4

    if-eqz v21, :cond_2e

    .line 98
    invoke-virtual {v9}, Ljava/lang/reflect/Field;->getType()Ljava/lang/Class;

    move-result-object v4

    .line 99
    const-string v5, "b"

    invoke-virtual {v4, v5}, Ljava/lang/Class;->getDeclaredField(Ljava/lang/String;)Ljava/lang/reflect/Field;

    move-result-object v22

    const-string v5, "c"

    invoke-virtual {v4, v5}, Ljava/lang/Class;->getDeclaredField(Ljava/lang/String;)Ljava/lang/reflect/Field;

    move-result-object v23

    .line 100
    invoke-virtual/range {v22 .. v22}, Ljava/lang/reflect/Field;->getType()Ljava/lang/Class;

    move-result-object v5
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    const-class v12, [I

    if-ne v5, v12, :cond_2d

    :try_start_2
    invoke-virtual/range {v23 .. v23}, Ljava/lang/reflect/Field;->getType()Ljava/lang/Class;

    move-result-object v5

    if-ne v5, v12, :cond_2d

    .line 101
    nop

    .line 102
    invoke-virtual {v4}, Ljava/lang/Class;->getDeclaredFields()[Ljava/lang/reflect/Field;

    move-result-object v4

    array-length v5, v4

    const/4 v12, 0x0

    const/16 v24, 0x0

    :goto_b
    if-ge v12, v5, :cond_1b

    aget-object v13, v4, v12

    invoke-virtual {v13}, Ljava/lang/reflect/Field;->getType()Ljava/lang/Class;

    move-result-object v14

    const-class v15, Landroid/util/Size;

    if-ne v14, v15, :cond_1a

    .line 103
    if-nez v24, :cond_19

    move-object/from16 v24, v13

    goto :goto_c

    :cond_19
    new-instance v0, Ljava/lang/IllegalStateException;

    const-string v1, "ambiguous size"

    invoke-direct {v0, v1}, Ljava/lang/IllegalStateException;-><init>(Ljava/lang/String;)V

    throw v0

    .line 102
    :cond_1a
    :goto_c
    add-int/lit8 v12, v12, 0x1

    goto :goto_b

    .line 105
    :cond_1b
    if-eqz v24, :cond_2c

    .line 106
    new-instance v4, Ljava/util/LinkedHashSet;

    invoke-direct {v4}, Ljava/util/LinkedHashSet;-><init>()V

    .line 107
    invoke-static {}, Lorg/luckypray/dexkit/query/FindMethod;->create()Lorg/luckypray/dexkit/query/FindMethod;

    move-result-object v5

    invoke-static {}, Lorg/luckypray/dexkit/query/matchers/MethodMatcher;->create()Lorg/luckypray/dexkit/query/matchers/MethodMatcher;

    move-result-object v12

    invoke-virtual {v12, v3}, Lorg/luckypray/dexkit/query/matchers/MethodMatcher;->declaredClass(Ljava/lang/Class;)Lorg/luckypray/dexkit/query/matchers/MethodMatcher;

    move-result-object v12

    sget-object v13, Ljava/lang/Boolean;->TYPE:Ljava/lang/Class;

    .line 108
    invoke-virtual {v12, v13}, Lorg/luckypray/dexkit/query/matchers/MethodMatcher;->returnType(Ljava/lang/Class;)Lorg/luckypray/dexkit/query/matchers/MethodMatcher;

    move-result-object v12

    const/4 v14, 0x0

    invoke-virtual {v12, v14}, Lorg/luckypray/dexkit/query/matchers/MethodMatcher;->paramCount(I)Lorg/luckypray/dexkit/query/matchers/MethodMatcher;

    move-result-object v12

    .line 107
    invoke-virtual {v5, v12}, Lorg/luckypray/dexkit/query/FindMethod;->matcher(Lorg/luckypray/dexkit/query/matchers/MethodMatcher;)Lorg/luckypray/dexkit/query/FindMethod;

    move-result-object v5

    invoke-virtual {v0, v5}, Lorg/luckypray/dexkit/DexKitBridge;->findMethod(Lorg/luckypray/dexkit/query/FindMethod;)Lorg/luckypray/dexkit/result/MethodDataList;

    move-result-object v5

    .line 109
    invoke-virtual {v5}, Lorg/luckypray/dexkit/result/MethodDataList;->iterator()Ljava/util/Iterator;

    move-result-object v5

    :goto_d
    invoke-interface {v5}, Ljava/util/Iterator;->hasNext()Z

    move-result v12

    if-eqz v12, :cond_20

    invoke-interface {v5}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v12

    check-cast v12, Lorg/luckypray/dexkit/result/MethodData;

    .line 110
    new-instance v13, Ljava/util/LinkedHashSet;

    invoke-direct {v13}, Ljava/util/LinkedHashSet;-><init>()V

    .line 111
    invoke-virtual {v12}, Lorg/luckypray/dexkit/result/MethodData;->getUsingFields()Ljava/util/List;

    move-result-object v14

    invoke-interface {v14}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object v14

    :goto_e
    invoke-interface {v14}, Ljava/util/Iterator;->hasNext()Z

    move-result v15

    if-eqz v15, :cond_1e

    invoke-interface {v14}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v15

    check-cast v15, Lorg/luckypray/dexkit/result/UsingFieldData;

    .line 112
    invoke-virtual {v15}, Lorg/luckypray/dexkit/result/UsingFieldData;->getField()Lorg/luckypray/dexkit/result/FieldData;

    move-result-object v15

    invoke-virtual {v15, v1}, Lorg/luckypray/dexkit/result/FieldData;->getFieldInstance(Ljava/lang/ClassLoader;)Ljava/lang/reflect/Field;

    move-result-object v15

    .line 113
    move-object/from16 v17, v5

    invoke-virtual {v15}, Ljava/lang/reflect/Field;->getDeclaringClass()Ljava/lang/Class;

    move-result-object v5

    if-ne v5, v3, :cond_1c

    invoke-virtual {v15}, Ljava/lang/reflect/Field;->getType()Ljava/lang/Class;

    move-result-object v5

    move-object/from16 v20, v3

    const-class v3, Ljava/util/ArrayList;

    if-ne v5, v3, :cond_1d

    invoke-interface {v13, v15}, Ljava/util/Set;->add(Ljava/lang/Object;)Z

    goto :goto_f

    :cond_1c
    move-object/from16 v20, v3

    .line 114
    :cond_1d
    :goto_f
    move-object/from16 v5, v17

    move-object/from16 v3, v20

    goto :goto_e

    .line 115
    :cond_1e
    move-object/from16 v20, v3

    move-object/from16 v17, v5

    invoke-interface {v13}, Ljava/util/Set;->size()I

    move-result v3

    const/4 v5, 0x2

    if-ne v3, v5, :cond_1f

    invoke-virtual {v12, v1}, Lorg/luckypray/dexkit/result/MethodData;->getMethodInstance(Ljava/lang/ClassLoader;)Ljava/lang/reflect/Method;

    move-result-object v3

    invoke-interface {v4, v3}, Ljava/util/Set;->add(Ljava/lang/Object;)Z

    .line 116
    :cond_1f
    move-object/from16 v5, v17

    move-object/from16 v3, v20

    goto :goto_d

    .line 117
    :cond_20
    invoke-interface {v4}, Ljava/util/Set;->size()I

    move-result v3

    const/4 v14, 0x1

    if-ne v3, v14, :cond_2b

    .line 118
    move-object/from16 v20, v9

    filled-new-array/range {v19 .. v24}, [Ljava/lang/reflect/Field;

    move-result-object v3

    const/4 v5, 0x0

    :goto_10
    const/4 v9, 0x6

    if-ge v5, v9, :cond_21

    aget-object v9, v3, v5

    const/4 v14, 0x1

    invoke-virtual {v9, v14}, Ljava/lang/reflect/Field;->setAccessible(Z)V

    add-int/lit8 v5, v5, 0x1

    goto :goto_10

    .line 119
    :cond_21
    nop

    .line 120
    invoke-virtual/range {v25 .. v25}, Lorg/luckypray/dexkit/result/MethodDataList;->iterator()Ljava/util/Iterator;

    move-result-object v3

    :cond_22
    :goto_11
    invoke-interface {v3}, Ljava/util/Iterator;->hasNext()Z

    move-result v5

    if-eqz v5, :cond_23

    invoke-interface {v3}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v5

    check-cast v5, Lorg/luckypray/dexkit/result/MethodData;

    invoke-virtual {v5}, Lorg/luckypray/dexkit/result/MethodData;->isMethod()Z

    move-result v9

    if-eqz v9, :cond_22

    invoke-virtual {v5, v1}, Lorg/luckypray/dexkit/result/MethodData;->getMethodInstance(Ljava/lang/ClassLoader;)Ljava/lang/reflect/Method;

    move-result-object v5

    new-instance v9, Llocal/mio/os4camerabridge/SoftwareBeautyBridge$1;

    invoke-direct {v9, v6}, Llocal/mio/os4camerabridge/SoftwareBeautyBridge$1;-><init>(Ljava/lang/reflect/Method;)V

    invoke-static {v5, v9}, Lde/robv/android/xposed/XposedBridge;->hookMethod(Ljava/lang/reflect/Member;Lde/robv/android/xposed/XC_MethodHook;)Lde/robv/android/xposed/XC_MethodHook$Unhook;

    goto :goto_11

    .line 130
    :cond_23
    invoke-interface {v7}, Ljava/util/Set;->iterator()Ljava/util/Iterator;

    move-result-object v3

    :goto_12
    invoke-interface {v3}, Ljava/util/Iterator;->hasNext()Z

    move-result v5

    if-eqz v5, :cond_24

    invoke-interface {v3}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v5

    check-cast v5, Ljava/lang/reflect/Method;

    new-instance v6, Llocal/mio/os4camerabridge/SoftwareBeautyBridge$2;

    invoke-direct {v6}, Llocal/mio/os4camerabridge/SoftwareBeautyBridge$2;-><init>()V

    invoke-static {v5, v6}, Lde/robv/android/xposed/XposedBridge;->hookMethod(Ljava/lang/reflect/Member;Lde/robv/android/xposed/XC_MethodHook;)Lde/robv/android/xposed/XC_MethodHook$Unhook;

    goto :goto_12

    .line 136
    :cond_24
    invoke-interface {v8}, Ljava/util/Set;->iterator()Ljava/util/Iterator;

    move-result-object v3

    invoke-interface {v3}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v3

    check-cast v3, Ljava/lang/reflect/Member;

    new-instance v5, Llocal/mio/os4camerabridge/SoftwareBeautyBridge$3;

    invoke-direct {v5}, Llocal/mio/os4camerabridge/SoftwareBeautyBridge$3;-><init>()V

    invoke-static {v3, v5}, Lde/robv/android/xposed/XposedBridge;->hookMethod(Ljava/lang/reflect/Member;Lde/robv/android/xposed/XC_MethodHook;)Lde/robv/android/xposed/XC_MethodHook$Unhook;

    .line 143
    invoke-interface {v4}, Ljava/util/Set;->iterator()Ljava/util/Iterator;

    move-result-object v3

    invoke-interface {v3}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v3

    check-cast v3, Ljava/lang/reflect/Member;

    new-instance v5, Llocal/mio/os4camerabridge/SoftwareBeautyBridge$4;

    invoke-direct {v5}, Llocal/mio/os4camerabridge/SoftwareBeautyBridge$4;-><init>()V

    invoke-static {v3, v5}, Lde/robv/android/xposed/XposedBridge;->hookMethod(Ljava/lang/reflect/Member;Lde/robv/android/xposed/XC_MethodHook;)Lde/robv/android/xposed/XC_MethodHook$Unhook;

    .line 146
    move-object/from16 v9, v19

    new-instance v19, Llocal/mio/os4camerabridge/SoftwareBeautyBridge$5;

    move-object/from16 v25, v24

    move-object/from16 v24, v23

    move-object/from16 v23, v22

    move-object/from16 v22, v21

    move-object/from16 v21, v20

    move-object/from16 v20, v9

    invoke-direct/range {v19 .. v25}, Llocal/mio/os4camerabridge/SoftwareBeautyBridge$5;-><init>(Ljava/lang/reflect/Field;Ljava/lang/reflect/Field;Ljava/lang/reflect/Field;Ljava/lang/reflect/Field;Ljava/lang/reflect/Field;Ljava/lang/reflect/Field;)V

    move-object/from16 v3, v19

    invoke-static {v11, v3}, Lde/robv/android/xposed/XposedBridge;->hookMethod(Ljava/lang/reflect/Member;Lde/robv/android/xposed/XC_MethodHook;)Lde/robv/android/xposed/XC_MethodHook$Unhook;

    .line 163
    const/16 v18, 0x1

    sput-boolean v18, Llocal/mio/os4camerabridge/SoftwareBeautyBridge;->ready:Z

    .line 164
    invoke-static {}, Lorg/luckypray/dexkit/query/FindMethod;->create()Lorg/luckypray/dexkit/query/FindMethod;

    move-result-object v3

    invoke-static {}, Lorg/luckypray/dexkit/query/matchers/MethodMatcher;->create()Lorg/luckypray/dexkit/query/matchers/MethodMatcher;

    move-result-object v5

    const-string v6, "fillJpegData: dataLen="

    filled-new-array {v6}, [Ljava/lang/String;

    move-result-object v6

    .line 165
    invoke-virtual {v5, v6}, Lorg/luckypray/dexkit/query/matchers/MethodMatcher;->usingStrings([Ljava/lang/String;)Lorg/luckypray/dexkit/query/matchers/MethodMatcher;

    move-result-object v5

    sget-object v6, Ljava/lang/Integer;->TYPE:Ljava/lang/Class;

    filled-new-array {v6, v2}, [Ljava/lang/Class;

    move-result-object v6

    invoke-virtual {v5, v6}, Lorg/luckypray/dexkit/query/matchers/MethodMatcher;->paramTypes([Ljava/lang/Class;)Lorg/luckypray/dexkit/query/matchers/MethodMatcher;

    move-result-object v5

    sget-object v6, Ljava/lang/Void;->TYPE:Ljava/lang/Class;

    invoke-virtual {v5, v6}, Lorg/luckypray/dexkit/query/matchers/MethodMatcher;->returnType(Ljava/lang/Class;)Lorg/luckypray/dexkit/query/matchers/MethodMatcher;

    move-result-object v5

    .line 164
    invoke-virtual {v3, v5}, Lorg/luckypray/dexkit/query/FindMethod;->matcher(Lorg/luckypray/dexkit/query/matchers/MethodMatcher;)Lorg/luckypray/dexkit/query/FindMethod;

    move-result-object v3

    invoke-virtual {v0, v3}, Lorg/luckypray/dexkit/DexKitBridge;->findMethod(Lorg/luckypray/dexkit/query/FindMethod;)Lorg/luckypray/dexkit/result/MethodDataList;

    move-result-object v0

    .line 166
    invoke-virtual {v0}, Lorg/luckypray/dexkit/result/MethodDataList;->size()I

    move-result v3

    const/4 v14, 0x1

    if-ne v3, v14, :cond_2a

    .line 167
    const/4 v3, 0x0

    invoke-virtual {v0, v3}, Lorg/luckypray/dexkit/result/MethodDataList;->get(I)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lorg/luckypray/dexkit/result/MethodData;

    invoke-virtual {v0, v1}, Lorg/luckypray/dexkit/result/MethodData;->getClassInstance(Ljava/lang/ClassLoader;)Ljava/lang/Class;

    move-result-object v0

    .line 168
    invoke-virtual {v0}, Ljava/lang/Class;->getDeclaredMethods()[Ljava/lang/reflect/Method;

    move-result-object v0

    array-length v1, v0

    const/4 v3, 0x0

    :goto_13
    if-ge v3, v1, :cond_2a

    aget-object v5, v0, v3

    .line 169
    invoke-virtual {v5}, Ljava/lang/reflect/Method;->getParameterTypes()[Ljava/lang/Class;

    move-result-object v6

    .line 170
    invoke-virtual {v5}, Ljava/lang/reflect/Method;->getReturnType()Ljava/lang/Class;

    move-result-object v9

    sget-object v12, Ljava/lang/Void;->TYPE:Ljava/lang/Class;

    if-ne v9, v12, :cond_29

    array-length v9, v6

    if-nez v9, :cond_25

    goto :goto_15

    .line 171
    :cond_25
    nop

    .line 172
    array-length v9, v6

    const/4 v12, 0x0

    const/4 v13, 0x0

    :goto_14
    if-ge v13, v9, :cond_27

    aget-object v15, v6, v13

    if-ne v15, v2, :cond_26

    move v12, v14

    :cond_26
    add-int/lit8 v13, v13, 0x1

    goto :goto_14

    .line 173
    :cond_27
    if-nez v12, :cond_28

    goto :goto_15

    .line 174
    :cond_28
    new-instance v6, Llocal/mio/os4camerabridge/SoftwareBeautyBridge$6;

    invoke-direct {v6}, Llocal/mio/os4camerabridge/SoftwareBeautyBridge$6;-><init>()V

    invoke-static {v5, v6}, Lde/robv/android/xposed/XposedBridge;->hookMethod(Ljava/lang/reflect/Member;Lde/robv/android/xposed/XC_MethodHook;)Lde/robv/android/xposed/XC_MethodHook$Unhook;

    .line 168
    :cond_29
    :goto_15
    add-int/lit8 v3, v3, 0x1

    goto :goto_13

    .line 186
    :cond_2a
    invoke-static {v11}, Ljava/lang/String;->valueOf(Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v0

    invoke-static {v4}, Ljava/lang/String;->valueOf(Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v1

    invoke-static {v7}, Ljava/lang/String;->valueOf(Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v2

    invoke-static {v8}, Ljava/lang/String;->valueOf(Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v3

    new-instance v4, Ljava/lang/StringBuilder;

    invoke-direct {v4}, Ljava/lang/StringBuilder;-><init>()V

    const-string v5, "[SoftwareBeauty] bound draw="

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v4, " gate="

    invoke-virtual {v0, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, " readers="

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, v10}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, "; front Photo only"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Lde/robv/android/xposed/XposedBridge;->log(Ljava/lang/String;)V

    .line 187
    goto/16 :goto_16

    .line 117
    :cond_2b
    new-instance v0, Ljava/lang/IllegalStateException;

    invoke-interface {v4}, Ljava/util/Set;->size()I

    move-result v1

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "materialization gate count="

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, v1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-direct {v0, v1}, Ljava/lang/IllegalStateException;-><init>(Ljava/lang/String;)V

    throw v0

    .line 105
    :cond_2c
    new-instance v0, Ljava/lang/IllegalStateException;

    const-string v1, "missing size"

    invoke-direct {v0, v1}, Ljava/lang/IllegalStateException;-><init>(Ljava/lang/String;)V

    throw v0

    .line 100
    :cond_2d
    new-instance v0, Ljava/lang/IllegalStateException;

    const-string v1, "buffer array mismatch"

    invoke-direct {v0, v1}, Ljava/lang/IllegalStateException;-><init>(Ljava/lang/String;)V

    throw v0

    .line 95
    :cond_2e
    new-instance v0, Ljava/lang/IllegalStateException;

    const-string v1, "no output buffer"

    invoke-direct {v0, v1}, Ljava/lang/IllegalStateException;-><init>(Ljava/lang/String;)V

    throw v0

    .line 90
    :cond_2f
    new-instance v0, Ljava/lang/IllegalStateException;

    const-string v1, "double-buffer contract ambiguous"

    invoke-direct {v0, v1}, Ljava/lang/IllegalStateException;-><init>(Ljava/lang/String;)V

    throw v0

    .line 82
    :cond_30
    new-instance v0, Ljava/lang/IllegalStateException;

    invoke-virtual {v9}, Lorg/luckypray/dexkit/result/MethodDataList;->size()I

    move-result v1

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "OES materialize count="

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, v1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-direct {v0, v1}, Ljava/lang/IllegalStateException;-><init>(Ljava/lang/String;)V

    throw v0

    .line 78
    :cond_31
    new-instance v0, Ljava/lang/IllegalStateException;

    invoke-static {v11}, Ljava/lang/String;->valueOf(Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v1

    invoke-static {v12}, Ljava/lang/String;->valueOf(Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v2

    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    const-string v4, "preview owners engines="

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v3, " doubles="

    invoke-virtual {v1, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-direct {v0, v1}, Ljava/lang/IllegalStateException;-><init>(Ljava/lang/String;)V

    throw v0

    .line 62
    :cond_32
    new-instance v0, Ljava/lang/IllegalStateException;

    invoke-static {v7}, Ljava/lang/String;->valueOf(Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v1

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "stored beauty reader ambiguous: "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-direct {v0, v1}, Ljava/lang/IllegalStateException;-><init>(Ljava/lang/String;)V

    throw v0

    .line 50
    :cond_33
    new-instance v0, Ljava/lang/IllegalStateException;

    invoke-static {v7}, Ljava/lang/String;->valueOf(Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v1

    invoke-static {v8}, Ljava/lang/String;->valueOf(Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v2

    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    const-string v4, "beauty value boundary readers="

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, v10}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-direct {v0, v1}, Ljava/lang/IllegalStateException;-><init>(Ljava/lang/String;)V

    throw v0

    .line 37
    :cond_34
    new-instance v0, Ljava/lang/IllegalStateException;

    invoke-virtual {v6}, Lorg/luckypray/dexkit/result/MethodDataList;->size()I

    move-result v1

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "beauty enabled selector count="

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, v1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-direct {v0, v1}, Ljava/lang/IllegalStateException;-><init>(Ljava/lang/String;)V

    throw v0

    .line 33
    :cond_35
    new-instance v0, Ljava/lang/IllegalStateException;

    invoke-virtual {v4}, Lorg/luckypray/dexkit/result/MethodDataList;->size()I

    move-result v1

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "smooth panel count="

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, v1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-direct {v0, v1}, Ljava/lang/IllegalStateException;-><init>(Ljava/lang/String;)V

    throw v0
    :try_end_2
    .catchall {:try_start_2 .. :try_end_2} :catchall_0

    .line 187
    :catchall_0
    move-exception v0

    const/16 v16, 0x0

    sput-boolean v16, Llocal/mio/os4camerabridge/SoftwareBeautyBridge;->ready:Z

    invoke-static {v0}, Ljava/lang/String;->valueOf(Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v0

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "[SoftwareBeauty] not activated: "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Lde/robv/android/xposed/XposedBridge;->log(Ljava/lang/String;)V

    .line 188
    :goto_16
    return-void
.end method

.method private static clamp(I)I
    .locals 1

    .line 189
    const/16 v0, 0x64

    invoke-static {v0, p0}, Ljava/lang/Math;->min(II)I

    move-result p0

    const/4 v0, 0x0

    invoke-static {v0, p0}, Ljava/lang/Math;->max(II)I

    move-result p0

    return p0
.end method

.method public static enable()V
    .locals 1

    .line 23
    const/4 v0, 0x1

    sput-boolean v0, Llocal/mio/os4camerabridge/SoftwareBeautyBridge;->enabled:Z

    return-void
.end method

.method private static inScope()Z
    .locals 4

    .line 195
    const/4 v0, 0x0

    :try_start_0
    sget-object v1, Llocal/mio/os4camerabridge/SoftwareBeautyBridge;->camera:Ljava/lang/reflect/Field;

    const/4 v2, 0x0

    invoke-virtual {v1, v2}, Ljava/lang/reflect/Field;->getInt(Ljava/lang/Object;)I

    move-result v1

    const/4 v3, 0x1

    if-ne v1, v3, :cond_0

    sget-object v1, Llocal/mio/os4camerabridge/SoftwareBeautyBridge;->mode:Ljava/lang/reflect/Field;

    invoke-virtual {v1, v2}, Ljava/lang/reflect/Field;->getInt(Ljava/lang/Object;)I

    move-result v1
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    const/16 v2, 0xa3

    if-ne v1, v2, :cond_0

    move v0, v3

    :cond_0
    return v0

    .line 196
    :catchall_0
    move-exception v1

    return v0
.end method

.method public static isEnabled()Z
    .locals 1

    .line 24
    sget-boolean v0, Llocal/mio/os4camerabridge/SoftwareBeautyBridge;->enabled:Z

    return v0
.end method

.method static synthetic lambda$static$0()Ljava/lang/Integer;
    .locals 1

    .line 20
    const/4 v0, 0x0

    invoke-static {v0}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v0

    return-object v0
.end method

.method public static processBitmap(Landroid/graphics/Bitmap;)Z
    .locals 8

    .line 199
    invoke-static {}, Llocal/mio/os4camerabridge/SoftwareBeautyBridge;->strength()F

    move-result v0

    const/4 v1, 0x0

    cmpg-float v1, v0, v1

    const/4 v2, 0x0

    if-gtz v1, :cond_0

    return v2

    .line 200
    :cond_0
    invoke-static {}, Landroid/os/SystemClock;->elapsedRealtime()J

    move-result-wide v3

    .line 202
    :try_start_0
    invoke-static {p0, v0}, Llocal/mio/os4camerabridge/SoftwareSkinSmoothing;->apply(Landroid/graphics/Bitmap;F)Z

    move-result v1

    .line 203
    invoke-virtual {p0}, Landroid/graphics/Bitmap;->getWidth()I

    move-result v5

    invoke-virtual {p0}, Landroid/graphics/Bitmap;->getHeight()I

    move-result p0

    .line 204
    invoke-static {}, Landroid/os/SystemClock;->elapsedRealtime()J

    move-result-wide v6

    sub-long/2addr v6, v3

    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    const-string v4, "[SoftwareBeauty] still changed="

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3, v1}, Ljava/lang/StringBuilder;->append(Z)Ljava/lang/StringBuilder;

    move-result-object v3

    const-string v4, " size="

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3, v5}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v3

    const-string v4, "x"

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3, p0}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object p0

    const-string v3, " amount="

    invoke-virtual {p0, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p0

    invoke-virtual {p0, v0}, Ljava/lang/StringBuilder;->append(F)Ljava/lang/StringBuilder;

    move-result-object p0

    const-string v0, " elapsedMs="

    invoke-virtual {p0, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p0

    invoke-virtual {p0, v6, v7}, Ljava/lang/StringBuilder;->append(J)Ljava/lang/StringBuilder;

    move-result-object p0

    const-string v0, "; same Bitmap, no extra JPEG encode"

    invoke-virtual {p0, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p0

    invoke-virtual {p0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p0

    .line 203
    invoke-static {p0}, Lde/robv/android/xposed/XposedBridge;->log(Ljava/lang/String;)V
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 205
    return v1

    .line 206
    :catchall_0
    move-exception p0

    invoke-static {p0}, Ljava/lang/String;->valueOf(Ljava/lang/Object;)Ljava/lang/String;

    move-result-object p0

    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "[SoftwareBeauty] still retained: "

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, p0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p0

    invoke-virtual {p0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p0

    invoke-static {p0}, Lde/robv/android/xposed/XposedBridge;->log(Ljava/lang/String;)V

    return v2
.end method

.method private static strength()F
    .locals 2

    .line 191
    sget-boolean v0, Llocal/mio/os4camerabridge/SoftwareBeautyBridge;->ready:Z

    const/4 v1, 0x0

    if-eqz v0, :cond_2

    sget-boolean v0, Llocal/mio/os4camerabridge/SoftwareBeautyBridge;->enabled:Z

    if-eqz v0, :cond_2

    sget-boolean v0, Llocal/mio/os4camerabridge/SoftwareBeautyBridge;->beautySelected:Z

    if-nez v0, :cond_0

    goto :goto_0

    .line 192
    :cond_0
    invoke-static {}, Llocal/mio/os4camerabridge/SoftwareBeautyBridge;->inScope()Z

    move-result v0

    if-eqz v0, :cond_1

    sget v0, Llocal/mio/os4camerabridge/SoftwareBeautyBridge;->level:I

    int-to-float v0, v0

    const/high16 v1, 0x42c80000    # 100.0f

    div-float v1, v0, v1

    :cond_1
    return v1

    .line 191
    :cond_2
    :goto_0
    return v1
.end method
