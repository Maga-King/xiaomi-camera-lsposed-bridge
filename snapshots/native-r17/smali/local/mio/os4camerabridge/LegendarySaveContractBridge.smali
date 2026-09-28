.class public final Llocal/mio/os4camerabridge/LegendarySaveContractBridge;
.super Ljava/lang/Object;
.source "LegendarySaveContractBridge.java"


# static fields
.field private static volatile enabled:Z


# direct methods
.method private constructor <init>()V
    .locals 0

    .line 16
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method public static bind(Lorg/luckypray/dexkit/DexKitBridge;Ljava/lang/ClassLoader;)V
    .locals 8

    .line 22
    :try_start_0
    invoke-static {}, Lorg/luckypray/dexkit/query/FindMethod;->create()Lorg/luckypray/dexkit/query/FindMethod;

    move-result-object v0

    invoke-static {}, Lorg/luckypray/dexkit/query/matchers/MethodMatcher;->create()Lorg/luckypray/dexkit/query/matchers/MethodMatcher;

    move-result-object v1

    const-string v2, "StoImage"

    filled-new-array {v2}, [Ljava/lang/String;

    move-result-object v2

    .line 23
    invoke-virtual {v1, v2}, Lorg/luckypray/dexkit/query/matchers/MethodMatcher;->usingStrings([Ljava/lang/String;)Lorg/luckypray/dexkit/query/matchers/MethodMatcher;

    move-result-object v1

    const-class v2, Ljava/lang/String;

    invoke-virtual {v1, v2}, Lorg/luckypray/dexkit/query/matchers/MethodMatcher;->returnType(Ljava/lang/Class;)Lorg/luckypray/dexkit/query/matchers/MethodMatcher;

    move-result-object v1

    const/4 v2, 0x0

    invoke-virtual {v1, v2}, Lorg/luckypray/dexkit/query/matchers/MethodMatcher;->paramCount(I)Lorg/luckypray/dexkit/query/matchers/MethodMatcher;

    move-result-object v1

    .line 22
    invoke-virtual {v0, v1}, Lorg/luckypray/dexkit/query/FindMethod;->matcher(Lorg/luckypray/dexkit/query/matchers/MethodMatcher;)Lorg/luckypray/dexkit/query/FindMethod;

    move-result-object v0

    invoke-virtual {p0, v0}, Lorg/luckypray/dexkit/DexKitBridge;->findMethod(Lorg/luckypray/dexkit/query/FindMethod;)Lorg/luckypray/dexkit/result/MethodDataList;

    move-result-object v0

    .line 24
    invoke-virtual {v0}, Lorg/luckypray/dexkit/result/MethodDataList;->size()I

    move-result v1

    const/4 v3, 0x1

    if-ne v1, v3, :cond_4

    .line 25
    invoke-virtual {v0, v2}, Lorg/luckypray/dexkit/result/MethodDataList;->get(I)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lorg/luckypray/dexkit/result/MethodData;

    invoke-virtual {v0, p1}, Lorg/luckypray/dexkit/result/MethodData;->getMethodInstance(Ljava/lang/ClassLoader;)Ljava/lang/reflect/Method;

    move-result-object p1

    invoke-virtual {p1}, Ljava/lang/reflect/Method;->getDeclaringClass()Ljava/lang/Class;

    move-result-object p1

    .line 26
    invoke-static {}, Lorg/luckypray/dexkit/query/FindMethod;->create()Lorg/luckypray/dexkit/query/FindMethod;

    move-result-object v0

    invoke-static {}, Lorg/luckypray/dexkit/query/matchers/MethodMatcher;->create()Lorg/luckypray/dexkit/query/matchers/MethodMatcher;

    move-result-object v1

    .line 27
    invoke-virtual {v1, p1}, Lorg/luckypray/dexkit/query/matchers/MethodMatcher;->declaredClass(Ljava/lang/Class;)Lorg/luckypray/dexkit/query/matchers/MethodMatcher;

    move-result-object v1

    const-string v4, "Storage.addImage(writer)"

    const-string v5, "ImageSaveRequest: image save finished"

    filled-new-array {v4, v5}, [Ljava/lang/String;

    move-result-object v4

    invoke-virtual {v1, v4}, Lorg/luckypray/dexkit/query/matchers/MethodMatcher;->usingStrings([Ljava/lang/String;)Lorg/luckypray/dexkit/query/matchers/MethodMatcher;

    move-result-object v1

    sget-object v4, Ljava/lang/Void;->TYPE:Ljava/lang/Class;

    .line 28
    invoke-virtual {v1, v4}, Lorg/luckypray/dexkit/query/matchers/MethodMatcher;->returnType(Ljava/lang/Class;)Lorg/luckypray/dexkit/query/matchers/MethodMatcher;

    move-result-object v1

    invoke-virtual {v1, v3}, Lorg/luckypray/dexkit/query/matchers/MethodMatcher;->paramCount(I)Lorg/luckypray/dexkit/query/matchers/MethodMatcher;

    move-result-object v1

    .line 26
    invoke-virtual {v0, v1}, Lorg/luckypray/dexkit/query/FindMethod;->matcher(Lorg/luckypray/dexkit/query/matchers/MethodMatcher;)Lorg/luckypray/dexkit/query/FindMethod;

    move-result-object v0

    invoke-virtual {p0, v0}, Lorg/luckypray/dexkit/DexKitBridge;->findMethod(Lorg/luckypray/dexkit/query/FindMethod;)Lorg/luckypray/dexkit/result/MethodDataList;

    move-result-object p0

    .line 29
    invoke-virtual {p0}, Lorg/luckypray/dexkit/result/MethodDataList;->size()I

    move-result v0

    if-ne v0, v3, :cond_3

    .line 30
    new-instance v0, Ljava/util/ArrayList;

    invoke-direct {v0}, Ljava/util/ArrayList;-><init>()V

    .line 31
    invoke-virtual {p1}, Ljava/lang/Class;->getDeclaredMethods()[Ljava/lang/reflect/Method;

    move-result-object p1

    array-length v1, p1

    move v4, v2

    :goto_0
    if-ge v4, v1, :cond_1

    aget-object v5, p1, v4

    .line 32
    invoke-virtual {v5}, Ljava/lang/reflect/Method;->getModifiers()I

    move-result v6

    invoke-static {v6}, Ljava/lang/reflect/Modifier;->isStatic(I)Z

    move-result v6

    if-nez v6, :cond_0

    invoke-virtual {v5}, Ljava/lang/reflect/Method;->getReturnType()Ljava/lang/Class;

    move-result-object v6

    sget-object v7, Ljava/lang/Boolean;->TYPE:Ljava/lang/Class;

    if-ne v6, v7, :cond_0

    .line 33
    invoke-virtual {v5}, Ljava/lang/reflect/Method;->getParameterCount()I

    move-result v6

    if-nez v6, :cond_0

    invoke-virtual {v0, v5}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    .line 31
    :cond_0
    add-int/lit8 v4, v4, 0x1

    goto :goto_0

    .line 35
    :cond_1
    invoke-virtual {v0}, Ljava/util/ArrayList;->size()I

    move-result p1

    if-ne p1, v3, :cond_2

    .line 36
    const-string p1, "local.mio.os4camerabridge.HookEntry"

    const-class v1, Llocal/mio/os4camerabridge/LegendarySaveContractBridge;

    .line 37
    invoke-virtual {v1}, Ljava/lang/Class;->getClassLoader()Ljava/lang/ClassLoader;

    move-result-object v1

    .line 36
    invoke-static {p1, v2, v1}, Ljava/lang/Class;->forName(Ljava/lang/String;ZLjava/lang/ClassLoader;)Ljava/lang/Class;

    move-result-object p1

    .line 38
    const-string v1, "activeCameraModule"

    invoke-virtual {p1, v1}, Ljava/lang/Class;->getDeclaredField(Ljava/lang/String;)Ljava/lang/reflect/Field;

    move-result-object p1

    .line 39
    invoke-virtual {p1, v3}, Ljava/lang/reflect/Field;->setAccessible(Z)V

    .line 40
    invoke-virtual {v0, v2}, Ljava/util/ArrayList;->get(I)Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Ljava/lang/reflect/Member;

    new-instance v3, Llocal/mio/os4camerabridge/LegendarySaveContractBridge$1;

    invoke-direct {v3, p1}, Llocal/mio/os4camerabridge/LegendarySaveContractBridge$1;-><init>(Ljava/lang/reflect/Field;)V

    invoke-static {v1, v3}, Lde/robv/android/xposed/XposedBridge;->hookMethod(Ljava/lang/reflect/Member;Lde/robv/android/xposed/XC_MethodHook;)Lde/robv/android/xposed/XC_MethodHook$Unhook;

    .line 53
    invoke-virtual {p0, v2}, Lorg/luckypray/dexkit/result/MethodDataList;->get(I)Ljava/lang/Object;

    move-result-object p0

    invoke-static {p0}, Ljava/lang/String;->valueOf(Ljava/lang/Object;)Ljava/lang/String;

    move-result-object p0

    .line 54
    invoke-virtual {v0, v2}, Ljava/util/ArrayList;->get(I)Ljava/lang/Object;

    move-result-object p1

    invoke-static {p1}, Ljava/lang/String;->valueOf(Ljava/lang/Object;)Ljava/lang/String;

    move-result-object p1

    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "[LegendarySaveContract] validated writer="

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, p0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p0

    const-string v0, " capability="

    invoke-virtual {p0, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p0

    invoke-virtual {p0, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p0

    invoke-virtual {p0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p0

    .line 53
    invoke-static {p0}, Lde/robv/android/xposed/XposedBridge;->log(Ljava/lang/String;)V

    .line 57
    goto :goto_1

    .line 35
    :cond_2
    new-instance p0, Ljava/lang/IllegalStateException;

    invoke-virtual {v0}, Ljava/util/ArrayList;->size()I

    move-result p1

    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "stream capability count="

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, p1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object p1

    invoke-virtual {p1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p1

    invoke-direct {p0, p1}, Ljava/lang/IllegalStateException;-><init>(Ljava/lang/String;)V

    throw p0

    .line 29
    :cond_3
    new-instance p1, Ljava/lang/IllegalStateException;

    invoke-virtual {p0}, Lorg/luckypray/dexkit/result/MethodDataList;->size()I

    move-result p0

    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "store writer count="

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, p0}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object p0

    invoke-virtual {p0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p0

    invoke-direct {p1, p0}, Ljava/lang/IllegalStateException;-><init>(Ljava/lang/String;)V

    throw p1

    .line 24
    :cond_4
    new-instance p0, Ljava/lang/IllegalStateException;

    invoke-virtual {v0}, Lorg/luckypray/dexkit/result/MethodDataList;->size()I

    move-result p1

    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "store tag count="

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

    .line 55
    :catchall_0
    move-exception p0

    .line 56
    invoke-static {p0}, Ljava/lang/String;->valueOf(Ljava/lang/Object;)Ljava/lang/String;

    move-result-object p0

    new-instance p1, Ljava/lang/StringBuilder;

    invoke-direct {p1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v0, "[LegendarySaveContract] binding refused: "

    invoke-virtual {p1, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p1

    invoke-virtual {p1, p0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p0

    invoke-virtual {p0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p0

    invoke-static {p0}, Lde/robv/android/xposed/XposedBridge;->log(Ljava/lang/String;)V

    .line 58
    :goto_1
    return-void
.end method

.method public static enable()V
    .locals 1

    .line 17
    const/4 v0, 0x1

    sput-boolean v0, Llocal/mio/os4camerabridge/LegendarySaveContractBridge;->enabled:Z

    return-void
.end method

.method public static isEnabled()Z
    .locals 1

    .line 18
    sget-boolean v0, Llocal/mio/os4camerabridge/LegendarySaveContractBridge;->enabled:Z

    return v0
.end method
