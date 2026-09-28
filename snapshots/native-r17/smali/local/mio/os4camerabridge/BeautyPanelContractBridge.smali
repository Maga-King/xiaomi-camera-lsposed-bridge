.class public final Llocal/mio/os4camerabridge/BeautyPanelContractBridge;
.super Ljava/lang/Object;
.source "BeautyPanelContractBridge.java"


# direct methods
.method static bridge synthetic -$$Nest$smnormalizeItems(Ljava/lang/Object;Ljava/lang/reflect/Field;Ljava/lang/reflect/Field;)I
    .locals 0

    invoke-static {p0, p1, p2}, Llocal/mio/os4camerabridge/BeautyPanelContractBridge;->normalizeItems(Ljava/lang/Object;Ljava/lang/reflect/Field;Ljava/lang/reflect/Field;)I

    move-result p0

    return p0
.end method

.method private constructor <init>()V
    .locals 0

    .line 19
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method public static bind(Lorg/luckypray/dexkit/DexKitBridge;Ljava/lang/ClassLoader;)V
    .locals 11

    .line 23
    :try_start_0
    invoke-static {}, Lorg/luckypray/dexkit/query/FindMethod;->create()Lorg/luckypray/dexkit/query/FindMethod;

    move-result-object v0

    invoke-static {}, Lorg/luckypray/dexkit/query/matchers/MethodMatcher;->create()Lorg/luckypray/dexkit/query/matchers/MethodMatcher;

    move-result-object v1

    const-string v2, "unknown beauty type"

    const-string v3, "shineType: "

    const-string v4, "2"

    filled-new-array {v2, v3, v4}, [Ljava/lang/String;

    move-result-object v2

    .line 24
    invoke-virtual {v1, v2}, Lorg/luckypray/dexkit/query/matchers/MethodMatcher;->usingStrings([Ljava/lang/String;)Lorg/luckypray/dexkit/query/matchers/MethodMatcher;

    move-result-object v1

    sget-object v2, Ljava/lang/Void;->TYPE:Ljava/lang/Class;

    .line 25
    invoke-virtual {v1, v2}, Lorg/luckypray/dexkit/query/matchers/MethodMatcher;->returnType(Ljava/lang/Class;)Lorg/luckypray/dexkit/query/matchers/MethodMatcher;

    move-result-object v1

    const-class v2, Landroid/view/View;

    filled-new-array {v2}, [Ljava/lang/Class;

    move-result-object v2

    invoke-virtual {v1, v2}, Lorg/luckypray/dexkit/query/matchers/MethodMatcher;->paramTypes([Ljava/lang/Class;)Lorg/luckypray/dexkit/query/matchers/MethodMatcher;

    move-result-object v1

    .line 23
    invoke-virtual {v0, v1}, Lorg/luckypray/dexkit/query/FindMethod;->matcher(Lorg/luckypray/dexkit/query/matchers/MethodMatcher;)Lorg/luckypray/dexkit/query/FindMethod;

    move-result-object v0

    invoke-virtual {p0, v0}, Lorg/luckypray/dexkit/DexKitBridge;->findMethod(Lorg/luckypray/dexkit/query/FindMethod;)Lorg/luckypray/dexkit/result/MethodDataList;

    move-result-object v0

    .line 26
    invoke-virtual {v0}, Lorg/luckypray/dexkit/result/MethodDataList;->size()I

    move-result v1

    const/4 v2, 0x1

    if-ne v1, v2, :cond_f

    .line 27
    const/4 v1, 0x0

    invoke-virtual {v0, v1}, Lorg/luckypray/dexkit/result/MethodDataList;->get(I)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lorg/luckypray/dexkit/result/MethodData;

    .line 28
    invoke-virtual {v0, p1}, Lorg/luckypray/dexkit/result/MethodData;->getMethodInstance(Ljava/lang/ClassLoader;)Ljava/lang/reflect/Method;

    move-result-object v3

    .line 29
    invoke-virtual {v3}, Ljava/lang/reflect/Method;->getModifiers()I

    move-result v4

    invoke-static {v4}, Ljava/lang/reflect/Modifier;->isStatic(I)Z

    move-result v4

    if-nez v4, :cond_e

    .line 30
    new-instance v4, Ljava/util/LinkedHashSet;

    invoke-direct {v4}, Ljava/util/LinkedHashSet;-><init>()V

    .line 31
    new-instance v5, Ljava/util/LinkedHashSet;

    invoke-direct {v5}, Ljava/util/LinkedHashSet;-><init>()V

    .line 32
    invoke-virtual {v0}, Lorg/luckypray/dexkit/result/MethodData;->getUsingFields()Ljava/util/List;

    move-result-object v6

    invoke-interface {v6}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object v6

    :goto_0
    invoke-interface {v6}, Ljava/util/Iterator;->hasNext()Z

    move-result v7

    if-eqz v7, :cond_3

    invoke-interface {v6}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v7

    check-cast v7, Lorg/luckypray/dexkit/result/UsingFieldData;

    .line 33
    invoke-virtual {v7}, Lorg/luckypray/dexkit/result/UsingFieldData;->getField()Lorg/luckypray/dexkit/result/FieldData;

    move-result-object v7

    invoke-virtual {v7, p1}, Lorg/luckypray/dexkit/result/FieldData;->getFieldInstance(Ljava/lang/ClassLoader;)Ljava/lang/reflect/Field;

    move-result-object v7

    .line 34
    invoke-virtual {v7}, Ljava/lang/reflect/Field;->getModifiers()I

    move-result v8

    invoke-static {v8}, Ljava/lang/reflect/Modifier;->isStatic(I)Z

    move-result v8

    if-eqz v8, :cond_0

    goto :goto_0

    .line 35
    :cond_0
    invoke-virtual {v7}, Ljava/lang/reflect/Field;->getType()Ljava/lang/Class;

    move-result-object v8

    const-class v9, Ljava/util/List;

    if-ne v8, v9, :cond_1

    invoke-virtual {v4, v7}, Ljava/util/LinkedHashSet;->add(Ljava/lang/Object;)Z

    .line 36
    :cond_1
    invoke-virtual {v7}, Ljava/lang/reflect/Field;->getType()Ljava/lang/Class;

    move-result-object v8

    const-class v9, Ljava/lang/String;

    if-ne v8, v9, :cond_2

    invoke-virtual {v7}, Ljava/lang/reflect/Field;->getDeclaringClass()Ljava/lang/Class;

    move-result-object v8

    invoke-virtual {v8}, Ljava/lang/Class;->getName()Ljava/lang/String;

    move-result-object v8

    const-string v9, "com.android.camera.data.data."

    .line 37
    invoke-virtual {v8, v9}, Ljava/lang/String;->startsWith(Ljava/lang/String;)Z

    move-result v8

    if-eqz v8, :cond_2

    invoke-virtual {v5, v7}, Ljava/util/LinkedHashSet;->add(Ljava/lang/Object;)Z

    .line 38
    :cond_2
    goto :goto_0

    .line 39
    :cond_3
    invoke-virtual {v4}, Ljava/util/LinkedHashSet;->size()I

    move-result v6

    if-ne v6, v2, :cond_d

    invoke-virtual {v5}, Ljava/util/LinkedHashSet;->size()I

    move-result v6

    if-ne v6, v2, :cond_d

    .line 41
    invoke-virtual {v4}, Ljava/util/LinkedHashSet;->iterator()Ljava/util/Iterator;

    move-result-object v4

    invoke-interface {v4}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v4

    check-cast v4, Ljava/lang/reflect/Field;

    .line 42
    invoke-virtual {v5}, Ljava/util/LinkedHashSet;->iterator()Ljava/util/Iterator;

    move-result-object v5

    invoke-interface {v5}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v5

    check-cast v5, Ljava/lang/reflect/Field;

    .line 43
    invoke-virtual {v4}, Ljava/lang/reflect/Field;->getDeclaringClass()Ljava/lang/Class;

    move-result-object v6

    .line 44
    new-instance v7, Ljava/util/LinkedHashSet;

    invoke-direct {v7}, Ljava/util/LinkedHashSet;-><init>()V

    .line 45
    invoke-virtual {v0}, Lorg/luckypray/dexkit/result/MethodData;->getInvokes()Lorg/luckypray/dexkit/result/MethodDataList;

    move-result-object v0

    invoke-virtual {v0}, Lorg/luckypray/dexkit/result/MethodDataList;->iterator()Ljava/util/Iterator;

    move-result-object v0

    :cond_4
    :goto_1
    invoke-interface {v0}, Ljava/util/Iterator;->hasNext()Z

    move-result v8

    if-eqz v8, :cond_7

    invoke-interface {v0}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v8

    check-cast v8, Lorg/luckypray/dexkit/result/MethodData;

    .line 46
    invoke-virtual {v8}, Lorg/luckypray/dexkit/result/MethodData;->isMethod()Z

    move-result v9

    if-eqz v9, :cond_4

    invoke-virtual {v8}, Lorg/luckypray/dexkit/result/MethodData;->getDeclaredClassName()Ljava/lang/String;

    move-result-object v9

    invoke-virtual {v6}, Ljava/lang/Class;->getName()Ljava/lang/String;

    move-result-object v10

    invoke-virtual {v9, v10}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v9

    if-eqz v9, :cond_4

    .line 47
    invoke-virtual {v8}, Lorg/luckypray/dexkit/result/MethodData;->getParamCount()I

    move-result v9

    if-nez v9, :cond_4

    invoke-virtual {v8}, Lorg/luckypray/dexkit/result/MethodData;->getReturnTypeName()Ljava/lang/String;

    move-result-object v9

    const-string v10, "java.lang.String"

    invoke-virtual {v9, v10}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v9

    if-nez v9, :cond_5

    goto :goto_1

    .line 48
    :cond_5
    invoke-virtual {v8, p1}, Lorg/luckypray/dexkit/result/MethodData;->getMethodInstance(Ljava/lang/ClassLoader;)Ljava/lang/reflect/Method;

    move-result-object v8

    .line 49
    invoke-virtual {v8}, Ljava/lang/reflect/Method;->getModifiers()I

    move-result v9

    invoke-static {v9}, Ljava/lang/reflect/Modifier;->isStatic(I)Z

    move-result v9

    if-nez v9, :cond_6

    invoke-virtual {v7, v8}, Ljava/util/LinkedHashSet;->add(Ljava/lang/Object;)Z

    .line 50
    :cond_6
    goto :goto_1

    .line 51
    :cond_7
    invoke-virtual {v7}, Ljava/util/LinkedHashSet;->size()I

    move-result p1

    if-ne p1, v2, :cond_c

    .line 53
    invoke-static {}, Lorg/luckypray/dexkit/query/FindMethod;->create()Lorg/luckypray/dexkit/query/FindMethod;

    move-result-object p1

    invoke-static {}, Lorg/luckypray/dexkit/query/matchers/MethodMatcher;->create()Lorg/luckypray/dexkit/query/matchers/MethodMatcher;

    move-result-object v0

    .line 54
    invoke-virtual {v0, v6}, Lorg/luckypray/dexkit/query/matchers/MethodMatcher;->declaredClass(Ljava/lang/Class;)Lorg/luckypray/dexkit/query/matchers/MethodMatcher;

    move-result-object v0

    const-string v8, "1"

    sget-object v9, Lorg/luckypray/dexkit/query/enums/StringMatchType;->Equals:Lorg/luckypray/dexkit/query/enums/StringMatchType;

    invoke-virtual {v0, v8, v9}, Lorg/luckypray/dexkit/query/matchers/MethodMatcher;->addUsingString(Ljava/lang/String;Lorg/luckypray/dexkit/query/enums/StringMatchType;)Lorg/luckypray/dexkit/query/matchers/MethodMatcher;

    move-result-object v0

    .line 55
    invoke-virtual {v0, v1}, Lorg/luckypray/dexkit/query/matchers/MethodMatcher;->paramCount(I)Lorg/luckypray/dexkit/query/matchers/MethodMatcher;

    move-result-object v0

    invoke-virtual {v5}, Ljava/lang/reflect/Field;->getDeclaringClass()Ljava/lang/Class;

    move-result-object v8

    invoke-virtual {v0, v8}, Lorg/luckypray/dexkit/query/matchers/MethodMatcher;->returnType(Ljava/lang/Class;)Lorg/luckypray/dexkit/query/matchers/MethodMatcher;

    move-result-object v0

    .line 53
    invoke-virtual {p1, v0}, Lorg/luckypray/dexkit/query/FindMethod;->matcher(Lorg/luckypray/dexkit/query/matchers/MethodMatcher;)Lorg/luckypray/dexkit/query/FindMethod;

    move-result-object p1

    invoke-virtual {p0, p1}, Lorg/luckypray/dexkit/DexKitBridge;->findMethod(Lorg/luckypray/dexkit/query/FindMethod;)Lorg/luckypray/dexkit/result/MethodDataList;

    move-result-object p0

    .line 56
    invoke-virtual {p0}, Lorg/luckypray/dexkit/result/MethodDataList;->size()I

    move-result p1

    if-ne p1, v2, :cond_b

    invoke-virtual {p0, v1}, Lorg/luckypray/dexkit/result/MethodDataList;->get(I)Ljava/lang/Object;

    move-result-object p1

    check-cast p1, Lorg/luckypray/dexkit/result/MethodData;

    invoke-virtual {p1}, Lorg/luckypray/dexkit/result/MethodData;->getModifiers()I

    move-result p1

    invoke-static {p1}, Ljava/lang/reflect/Modifier;->isStatic(I)Z

    move-result p1

    if-eqz p1, :cond_b

    .line 58
    invoke-virtual {p0, v1}, Lorg/luckypray/dexkit/result/MethodDataList;->get(I)Ljava/lang/Object;

    move-result-object p0

    check-cast p0, Lorg/luckypray/dexkit/result/MethodData;

    invoke-virtual {p0}, Lorg/luckypray/dexkit/result/MethodData;->getUsingFields()Ljava/util/List;

    move-result-object p0

    invoke-interface {p0}, Ljava/util/List;->stream()Ljava/util/stream/Stream;

    move-result-object p0

    new-instance p1, Llocal/mio/os4camerabridge/BeautyPanelContractBridge$$ExternalSyntheticLambda0;

    invoke-direct {p1, v5}, Llocal/mio/os4camerabridge/BeautyPanelContractBridge$$ExternalSyntheticLambda0;-><init>(Ljava/lang/reflect/Field;)V

    .line 59
    invoke-interface {p0, p1}, Ljava/util/stream/Stream;->anyMatch(Ljava/util/function/Predicate;)Z

    move-result p0

    .line 60
    if-eqz p0, :cond_a

    .line 61
    const-string p0, "mCurrentMode"

    invoke-static {v6, p0}, Llocal/mio/os4camerabridge/BeautyPanelContractBridge;->inheritedField(Ljava/lang/Class;Ljava/lang/String;)Ljava/lang/reflect/Field;

    move-result-object p0

    .line 62
    invoke-virtual {p0}, Ljava/lang/reflect/Field;->getType()Ljava/lang/Class;

    move-result-object p1

    sget-object v0, Ljava/lang/Integer;->TYPE:Ljava/lang/Class;

    if-ne p1, v0, :cond_9

    invoke-virtual {p0}, Ljava/lang/reflect/Field;->getModifiers()I

    move-result p1

    invoke-static {p1}, Ljava/lang/reflect/Modifier;->isStatic(I)Z

    move-result p1

    if-nez p1, :cond_9

    .line 64
    invoke-virtual {v4, v2}, Ljava/lang/reflect/Field;->setAccessible(Z)V

    .line 65
    invoke-virtual {v5, v2}, Ljava/lang/reflect/Field;->setAccessible(Z)V

    .line 66
    invoke-virtual {p0, v2}, Ljava/lang/reflect/Field;->setAccessible(Z)V

    .line 67
    const-string p1, "mItems"

    invoke-static {v6, p1}, Llocal/mio/os4camerabridge/BeautyPanelContractBridge;->inheritedField(Ljava/lang/Class;Ljava/lang/String;)Ljava/lang/reflect/Field;

    move-result-object p1

    .line 68
    invoke-virtual {p1}, Ljava/lang/reflect/Field;->getType()Ljava/lang/Class;

    move-result-object v0

    const-class v1, Ljava/util/List;

    if-ne v0, v1, :cond_8

    invoke-virtual {p1}, Ljava/lang/reflect/Field;->getModifiers()I

    move-result v0

    invoke-static {v0}, Ljava/lang/reflect/Modifier;->isStatic(I)Z

    move-result v0

    if-nez v0, :cond_8

    .line 70
    invoke-virtual {p1, v2}, Ljava/lang/reflect/Field;->setAccessible(Z)V

    .line 71
    invoke-virtual {v7}, Ljava/util/LinkedHashSet;->iterator()Ljava/util/Iterator;

    move-result-object v0

    invoke-interface {v0}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/lang/reflect/Method;

    .line 72
    new-instance v1, Llocal/mio/os4camerabridge/BeautyPanelContractBridge$1;

    invoke-direct {v1, p0, v4, v5, p1}, Llocal/mio/os4camerabridge/BeautyPanelContractBridge$1;-><init>(Ljava/lang/reflect/Field;Ljava/lang/reflect/Field;Ljava/lang/reflect/Field;Ljava/lang/reflect/Field;)V

    invoke-static {v0, v1}, Lde/robv/android/xposed/XposedBridge;->hookMethod(Ljava/lang/reflect/Member;Lde/robv/android/xposed/XC_MethodHook;)Lde/robv/android/xposed/XC_MethodHook$Unhook;

    .line 98
    invoke-static {v3}, Ljava/lang/String;->valueOf(Ljava/lang/Object;)Ljava/lang/String;

    move-result-object p0

    invoke-static {v0}, Ljava/lang/String;->valueOf(Ljava/lang/Object;)Ljava/lang/String;

    move-result-object p1

    invoke-static {v4}, Ljava/lang/String;->valueOf(Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v0

    invoke-static {v5}, Ljava/lang/String;->valueOf(Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v1

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "[BeautyPanelContract] bound consumer="

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, p0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p0

    const-string v2, " selected="

    invoke-virtual {p0, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p0

    invoke-virtual {p0, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p0

    const-string p1, " list="

    invoke-virtual {p0, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p0

    invoke-virtual {p0, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p0

    const-string p1, " value="

    invoke-virtual {p0, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p0

    invoke-virtual {p0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p0

    const-string p1, "; UI only, no pixel-effect claim"

    invoke-virtual {p0, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p0

    invoke-virtual {p0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p0

    invoke-static {p0}, Lde/robv/android/xposed/XposedBridge;->log(Ljava/lang/String;)V

    .line 100
    goto/16 :goto_2

    .line 69
    :cond_8
    new-instance p0, Ljava/lang/IllegalStateException;

    const-string p1, "invalid source items"

    invoke-direct {p0, p1}, Ljava/lang/IllegalStateException;-><init>(Ljava/lang/String;)V

    throw p0

    .line 63
    :cond_9
    new-instance p0, Ljava/lang/IllegalStateException;

    const-string p1, "invalid component mode"

    invoke-direct {p0, p1}, Ljava/lang/IllegalStateException;-><init>(Ljava/lang/String;)V

    throw p0

    .line 60
    :cond_a
    new-instance p0, Ljava/lang/IllegalStateException;

    const-string p1, "legacy item field not used by factory"

    invoke-direct {p0, p1}, Ljava/lang/IllegalStateException;-><init>(Ljava/lang/String;)V

    throw p0

    .line 57
    :cond_b
    new-instance p1, Ljava/lang/IllegalStateException;

    invoke-virtual {p0}, Lorg/luckypray/dexkit/result/MethodDataList;->size()I

    move-result p0

    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "beauty legacy factory count="

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, p0}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object p0

    invoke-virtual {p0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p0

    invoke-direct {p1, p0}, Ljava/lang/IllegalStateException;-><init>(Ljava/lang/String;)V

    throw p1

    .line 51
    :cond_c
    new-instance p0, Ljava/lang/IllegalStateException;

    invoke-static {v7}, Ljava/lang/String;->valueOf(Ljava/lang/Object;)Ljava/lang/String;

    move-result-object p1

    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "beauty selection="

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p1

    invoke-virtual {p1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p1

    invoke-direct {p0, p1}, Ljava/lang/IllegalStateException;-><init>(Ljava/lang/String;)V

    throw p0

    .line 40
    :cond_d
    new-instance p0, Ljava/lang/IllegalStateException;

    invoke-static {v4}, Ljava/lang/String;->valueOf(Ljava/lang/Object;)Ljava/lang/String;

    move-result-object p1

    invoke-static {v5}, Ljava/lang/String;->valueOf(Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v0

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "beauty fields lists="

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p1

    const-string v1, " values="

    invoke-virtual {p1, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p1

    invoke-virtual {p1, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p1

    invoke-virtual {p1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p1

    invoke-direct {p0, p1}, Ljava/lang/IllegalStateException;-><init>(Ljava/lang/String;)V

    throw p0

    .line 29
    :cond_e
    new-instance p0, Ljava/lang/IllegalStateException;

    const-string p1, "static beauty consumer"

    invoke-direct {p0, p1}, Ljava/lang/IllegalStateException;-><init>(Ljava/lang/String;)V

    throw p0

    .line 26
    :cond_f
    new-instance p0, Ljava/lang/IllegalStateException;

    invoke-virtual {v0}, Lorg/luckypray/dexkit/result/MethodDataList;->size()I

    move-result p1

    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "beauty consumer count="

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

    .line 100
    :catchall_0
    move-exception p0

    invoke-static {p0}, Ljava/lang/String;->valueOf(Ljava/lang/Object;)Ljava/lang/String;

    move-result-object p0

    new-instance p1, Ljava/lang/StringBuilder;

    invoke-direct {p1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v0, "[BeautyPanelContract] skipped: "

    invoke-virtual {p1, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p1

    invoke-virtual {p1, p0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p0

    invoke-virtual {p0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p0

    invoke-static {p0}, Lde/robv/android/xposed/XposedBridge;->log(Ljava/lang/String;)V

    .line 101
    :goto_2
    return-void
.end method

.method private static inheritedField(Ljava/lang/Class;Ljava/lang/String;)Ljava/lang/reflect/Field;
    .locals 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/lang/Class<",
            "*>;",
            "Ljava/lang/String;",
            ")",
            "Ljava/lang/reflect/Field;"
        }
    .end annotation

    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/lang/NoSuchFieldException;
        }
    .end annotation

    .line 125
    nop

    :goto_0
    if-eqz p0, :cond_0

    .line 126
    :try_start_0
    invoke-virtual {p0, p1}, Ljava/lang/Class;->getDeclaredField(Ljava/lang/String;)Ljava/lang/reflect/Field;

    move-result-object p0
    :try_end_0
    .catch Ljava/lang/NoSuchFieldException; {:try_start_0 .. :try_end_0} :catch_0

    return-object p0

    :catch_0
    move-exception v0

    .line 125
    invoke-virtual {p0}, Ljava/lang/Class;->getSuperclass()Ljava/lang/Class;

    move-result-object p0

    goto :goto_0

    .line 128
    :cond_0
    new-instance p0, Ljava/lang/NoSuchFieldException;

    invoke-direct {p0, p1}, Ljava/lang/NoSuchFieldException;-><init>(Ljava/lang/String;)V

    throw p0
.end method

.method static synthetic lambda$bind$0(Ljava/lang/reflect/Field;Lorg/luckypray/dexkit/result/UsingFieldData;)Z
    .locals 0

    .line 59
    invoke-virtual {p1}, Lorg/luckypray/dexkit/result/UsingFieldData;->getField()Lorg/luckypray/dexkit/result/FieldData;

    move-result-object p1

    invoke-virtual {p1}, Lorg/luckypray/dexkit/result/FieldData;->getDescriptor()Ljava/lang/String;

    move-result-object p1

    invoke-static {p0}, Llocal/mio/os4camerabridge/BeautyPanelContractBridge;->valueDescriptor(Ljava/lang/reflect/Field;)Ljava/lang/String;

    move-result-object p0

    invoke-virtual {p1, p0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result p0

    return p0
.end method

.method private static normalizeItems(Ljava/lang/Object;Ljava/lang/reflect/Field;Ljava/lang/reflect/Field;)I
    .locals 6
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/lang/IllegalAccessException;
        }
    .end annotation

    .line 104
    invoke-virtual {p1, p0}, Ljava/lang/reflect/Field;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0

    .line 105
    instance-of v1, v0, Ljava/util/List;

    const/4 v2, 0x0

    if-nez v1, :cond_0

    return v2

    .line 106
    :cond_0
    new-instance v1, Ljava/util/ArrayList;

    invoke-direct {v1}, Ljava/util/ArrayList;-><init>()V

    .line 107
    nop

    .line 108
    check-cast v0, Ljava/util/List;

    invoke-interface {v0}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object v0

    :goto_0
    invoke-interface {v0}, Ljava/util/Iterator;->hasNext()Z

    move-result v3

    if-eqz v3, :cond_3

    invoke-interface {v0}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v3

    .line 109
    invoke-virtual {p2}, Ljava/lang/reflect/Field;->getDeclaringClass()Ljava/lang/Class;

    move-result-object v4

    invoke-virtual {v4, v3}, Ljava/lang/Class;->isInstance(Ljava/lang/Object;)Z

    move-result v4

    if-eqz v4, :cond_2

    .line 110
    invoke-virtual {p2, v3}, Ljava/lang/reflect/Field;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v4

    .line 111
    const-string v5, "4"

    invoke-virtual {v5, v4}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v5

    if-eqz v5, :cond_1

    add-int/lit8 v2, v2, 0x1

    goto :goto_0

    .line 112
    :cond_1
    const-string v5, "1"

    invoke-virtual {v5, v4}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v4

    if-eqz v4, :cond_2

    const-string v4, "2"

    invoke-virtual {p2, v3, v4}, Ljava/lang/reflect/Field;->set(Ljava/lang/Object;Ljava/lang/Object;)V

    add-int/lit8 v2, v2, 0x1

    .line 114
    :cond_2
    invoke-virtual {v1, v3}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    .line 115
    goto :goto_0

    .line 116
    :cond_3
    if-eqz v2, :cond_4

    invoke-virtual {p1, p0, v1}, Ljava/lang/reflect/Field;->set(Ljava/lang/Object;Ljava/lang/Object;)V

    .line 117
    :cond_4
    return v2
.end method

.method private static valueDescriptor(Ljava/lang/reflect/Field;)Ljava/lang/String;
    .locals 3

    .line 121
    invoke-virtual {p0}, Ljava/lang/reflect/Field;->getDeclaringClass()Ljava/lang/Class;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/Class;->getName()Ljava/lang/String;

    move-result-object v0

    const/16 v1, 0x2e

    const/16 v2, 0x2f

    invoke-virtual {v0, v1, v2}, Ljava/lang/String;->replace(CC)Ljava/lang/String;

    move-result-object v0

    invoke-virtual {p0}, Ljava/lang/reflect/Field;->getName()Ljava/lang/String;

    move-result-object p0

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "L"

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, ";->"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, p0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p0

    const-string v0, ":Ljava/lang/String;"

    invoke-virtual {p0, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p0

    invoke-virtual {p0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p0

    return-object p0
.end method
