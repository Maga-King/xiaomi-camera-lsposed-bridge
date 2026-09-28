.class public final Llocal/mio/os4camerabridge/RearLivePhotoBridge;
.super Ljava/lang/Object;
.source "RearLivePhotoBridge.java"


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Llocal/mio/os4camerabridge/RearLivePhotoBridge$PendingPath;
    }
.end annotation


# static fields
.field private static final AUDIO_SCOPE:Ljava/lang/ThreadLocal;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/lang/ThreadLocal<",
            "Ljava/lang/Integer;",
            ">;"
        }
    .end annotation
.end field

.field private static final LOGS:Ljava/util/concurrent/atomic/AtomicInteger;

.field private static final PENDING_PATH:Ljava/lang/ThreadLocal;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/lang/ThreadLocal<",
            "Llocal/mio/os4camerabridge/RearLivePhotoBridge$PendingPath;",
            ">;"
        }
    .end annotation
.end field

.field private static installed:Z


# direct methods
.method static bridge synthetic -$$Nest$sfgetAUDIO_SCOPE()Ljava/lang/ThreadLocal;
    .locals 1

    sget-object v0, Llocal/mio/os4camerabridge/RearLivePhotoBridge;->AUDIO_SCOPE:Ljava/lang/ThreadLocal;

    return-object v0
.end method

.method static bridge synthetic -$$Nest$sfgetPENDING_PATH()Ljava/lang/ThreadLocal;
    .locals 1

    sget-object v0, Llocal/mio/os4camerabridge/RearLivePhotoBridge;->PENDING_PATH:Ljava/lang/ThreadLocal;

    return-object v0
.end method

.method static bridge synthetic -$$Nest$smeligible(Ljava/lang/reflect/Field;Ljava/lang/reflect/Field;Ljava/lang/reflect/Field;)Z
    .locals 0

    invoke-static {p0, p1, p2}, Llocal/mio/os4camerabridge/RearLivePhotoBridge;->eligible(Ljava/lang/reflect/Field;Ljava/lang/reflect/Field;Ljava/lang/reflect/Field;)Z

    move-result p0

    return p0
.end method

.method static bridge synthetic -$$Nest$smlog(Ljava/lang/String;)V
    .locals 0

    invoke-static {p0}, Llocal/mio/os4camerabridge/RearLivePhotoBridge;->log(Ljava/lang/String;)V

    return-void
.end method

.method static bridge synthetic -$$Nest$smresolve(Landroid/content/Context;Ljava/lang/ClassLoader;)V
    .locals 0

    invoke-static {p0, p1}, Llocal/mio/os4camerabridge/RearLivePhotoBridge;->resolve(Landroid/content/Context;Ljava/lang/ClassLoader;)V

    return-void
.end method

.method static constructor <clinit>()V
    .locals 1

    .line 22
    new-instance v0, Ljava/lang/ThreadLocal;

    invoke-direct {v0}, Ljava/lang/ThreadLocal;-><init>()V

    sput-object v0, Llocal/mio/os4camerabridge/RearLivePhotoBridge;->AUDIO_SCOPE:Ljava/lang/ThreadLocal;

    .line 23
    new-instance v0, Ljava/lang/ThreadLocal;

    invoke-direct {v0}, Ljava/lang/ThreadLocal;-><init>()V

    sput-object v0, Llocal/mio/os4camerabridge/RearLivePhotoBridge;->PENDING_PATH:Ljava/lang/ThreadLocal;

    .line 24
    new-instance v0, Ljava/util/concurrent/atomic/AtomicInteger;

    invoke-direct {v0}, Ljava/util/concurrent/atomic/AtomicInteger;-><init>()V

    sput-object v0, Llocal/mio/os4camerabridge/RearLivePhotoBridge;->LOGS:Ljava/util/concurrent/atomic/AtomicInteger;

    return-void
.end method

.method private constructor <init>()V
    .locals 0

    .line 27
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method private static bind(Ljava/lang/reflect/Constructor;Ljava/lang/reflect/Method;)V
    .locals 2
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/lang/reflect/Constructor<",
            "*>;",
            "Ljava/lang/reflect/Method;",
            ")V"
        }
    .end annotation

    .line 73
    :try_start_0
    invoke-virtual {p1}, Ljava/lang/reflect/Method;->getReturnType()Ljava/lang/Class;

    move-result-object v0

    sget-object v1, Ljava/lang/Boolean;->TYPE:Ljava/lang/Class;

    if-ne v0, v1, :cond_0

    .line 74
    invoke-virtual {p1}, Ljava/lang/reflect/Method;->getModifiers()I

    move-result v0

    invoke-static {v0}, Ljava/lang/reflect/Modifier;->isStatic(I)Z

    move-result v0

    if-eqz v0, :cond_0

    .line 77
    new-instance v0, Llocal/mio/os4camerabridge/RearLivePhotoBridge$2;

    invoke-direct {v0}, Llocal/mio/os4camerabridge/RearLivePhotoBridge$2;-><init>()V

    invoke-static {p1, v0}, Lde/robv/android/xposed/XposedBridge;->hookMethod(Ljava/lang/reflect/Member;Lde/robv/android/xposed/XC_MethodHook;)Lde/robv/android/xposed/XC_MethodHook$Unhook;

    .line 87
    new-instance v0, Llocal/mio/os4camerabridge/RearLivePhotoBridge$3;

    invoke-direct {v0}, Llocal/mio/os4camerabridge/RearLivePhotoBridge$3;-><init>()V

    invoke-static {p0, v0}, Lde/robv/android/xposed/XposedBridge;->hookMethod(Ljava/lang/reflect/Member;Lde/robv/android/xposed/XC_MethodHook;)Lde/robv/android/xposed/XC_MethodHook$Unhook;

    .line 99
    invoke-static {p0}, Ljava/lang/String;->valueOf(Ljava/lang/Object;)Ljava/lang/String;

    move-result-object p0

    invoke-static {p1}, Ljava/lang/String;->valueOf(Ljava/lang/Object;)Ljava/lang/String;

    move-result-object p1

    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "bound circular constructor="

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, p0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p0

    const-string v0, " capability="

    invoke-virtual {p0, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p0

    invoke-virtual {p0, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p0

    const-string p1, "; movie recorder unchanged"

    invoke-virtual {p0, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p0

    invoke-virtual {p0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p0

    invoke-static {p0}, Llocal/mio/os4camerabridge/RearLivePhotoBridge;->log(Ljava/lang/String;)V

    .line 103
    goto :goto_0

    .line 75
    :cond_0
    new-instance p0, Ljava/lang/IllegalStateException;

    const-string p1, "Compressed-audio signature changed"

    invoke-direct {p0, p1}, Ljava/lang/IllegalStateException;-><init>(Ljava/lang/String;)V

    throw p0
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 101
    :catchall_0
    move-exception p0

    .line 102
    invoke-static {p0}, Ljava/lang/String;->valueOf(Ljava/lang/Object;)Ljava/lang/String;

    move-result-object p0

    new-instance p1, Ljava/lang/StringBuilder;

    invoke-direct {p1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v0, "binding rejected, native behavior retained: "

    invoke-virtual {p1, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p1

    invoke-virtual {p1, p0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p0

    invoke-virtual {p0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p0

    invoke-static {p0}, Llocal/mio/os4camerabridge/RearLivePhotoBridge;->log(Ljava/lang/String;)V

    .line 104
    :goto_0
    return-void
.end method

.method private static bindCapturePath(Lorg/luckypray/dexkit/DexKitBridge;Ljava/lang/ClassLoader;)V
    .locals 13
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/lang/Exception;
        }
    .end annotation

    .line 111
    invoke-static {}, Lorg/luckypray/dexkit/query/FindMethod;->create()Lorg/luckypray/dexkit/query/FindMethod;

    move-result-object v0

    invoke-static {}, Lorg/luckypray/dexkit/query/matchers/MethodMatcher;->create()Lorg/luckypray/dexkit/query/matchers/MethodMatcher;

    move-result-object v1

    const-string v2, "setShotSavePath: "

    const-string v3, "CameraConfigManager"

    filled-new-array {v2, v3}, [Ljava/lang/String;

    move-result-object v2

    .line 112
    invoke-virtual {v1, v2}, Lorg/luckypray/dexkit/query/matchers/MethodMatcher;->usingStrings([Ljava/lang/String;)Lorg/luckypray/dexkit/query/matchers/MethodMatcher;

    move-result-object v1

    sget-object v2, Ljava/lang/Void;->TYPE:Ljava/lang/Class;

    .line 113
    invoke-virtual {v1, v2}, Lorg/luckypray/dexkit/query/matchers/MethodMatcher;->returnType(Ljava/lang/Class;)Lorg/luckypray/dexkit/query/matchers/MethodMatcher;

    move-result-object v1

    const-class v2, Ljava/lang/String;

    sget-object v3, Ljava/lang/Boolean;->TYPE:Ljava/lang/Class;

    sget-object v4, Ljava/lang/Boolean;->TYPE:Ljava/lang/Class;

    sget-object v5, Ljava/lang/Boolean;->TYPE:Ljava/lang/Class;

    filled-new-array {v2, v3, v4, v5}, [Ljava/lang/Class;

    move-result-object v2

    invoke-virtual {v1, v2}, Lorg/luckypray/dexkit/query/matchers/MethodMatcher;->paramTypes([Ljava/lang/Class;)Lorg/luckypray/dexkit/query/matchers/MethodMatcher;

    move-result-object v1

    .line 111
    invoke-virtual {v0, v1}, Lorg/luckypray/dexkit/query/FindMethod;->matcher(Lorg/luckypray/dexkit/query/matchers/MethodMatcher;)Lorg/luckypray/dexkit/query/FindMethod;

    move-result-object v0

    invoke-virtual {p0, v0}, Lorg/luckypray/dexkit/DexKitBridge;->findMethod(Lorg/luckypray/dexkit/query/FindMethod;)Lorg/luckypray/dexkit/result/MethodDataList;

    move-result-object v0

    .line 114
    invoke-static {}, Lorg/luckypray/dexkit/query/FindMethod;->create()Lorg/luckypray/dexkit/query/FindMethod;

    move-result-object v1

    invoke-static {}, Lorg/luckypray/dexkit/query/matchers/MethodMatcher;->create()Lorg/luckypray/dexkit/query/matchers/MethodMatcher;

    move-result-object v2

    const-string v3, "onCaptureStart: isLiveShot = "

    const-string v4, " onlyPreDuration = "

    filled-new-array {v3, v4}, [Ljava/lang/String;

    move-result-object v3

    .line 115
    invoke-virtual {v2, v3}, Lorg/luckypray/dexkit/query/matchers/MethodMatcher;->usingStrings([Ljava/lang/String;)Lorg/luckypray/dexkit/query/matchers/MethodMatcher;

    move-result-object v2

    sget-object v3, Ljava/lang/Void;->TYPE:Ljava/lang/Class;

    .line 116
    invoke-virtual {v2, v3}, Lorg/luckypray/dexkit/query/matchers/MethodMatcher;->returnType(Ljava/lang/Class;)Lorg/luckypray/dexkit/query/matchers/MethodMatcher;

    move-result-object v2

    const/4 v3, 0x5

    invoke-virtual {v2, v3}, Lorg/luckypray/dexkit/query/matchers/MethodMatcher;->paramCount(I)Lorg/luckypray/dexkit/query/matchers/MethodMatcher;

    move-result-object v2

    .line 114
    invoke-virtual {v1, v2}, Lorg/luckypray/dexkit/query/FindMethod;->matcher(Lorg/luckypray/dexkit/query/matchers/MethodMatcher;)Lorg/luckypray/dexkit/query/FindMethod;

    move-result-object v1

    invoke-virtual {p0, v1}, Lorg/luckypray/dexkit/DexKitBridge;->findMethod(Lorg/luckypray/dexkit/query/FindMethod;)Lorg/luckypray/dexkit/result/MethodDataList;

    move-result-object v1

    .line 117
    invoke-virtual {v0}, Lorg/luckypray/dexkit/result/MethodDataList;->size()I

    move-result v2

    const/4 v3, 0x1

    if-ne v2, v3, :cond_d

    invoke-virtual {v1}, Lorg/luckypray/dexkit/result/MethodDataList;->size()I

    move-result v2

    if-ne v2, v3, :cond_d

    .line 120
    const/4 v2, 0x0

    invoke-virtual {v0, v2}, Lorg/luckypray/dexkit/result/MethodDataList;->get(I)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lorg/luckypray/dexkit/result/MethodData;

    invoke-virtual {v0, p1}, Lorg/luckypray/dexkit/result/MethodData;->getMethodInstance(Ljava/lang/ClassLoader;)Ljava/lang/reflect/Method;

    move-result-object v0

    .line 121
    invoke-virtual {v1, v2}, Lorg/luckypray/dexkit/result/MethodDataList;->get(I)Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Lorg/luckypray/dexkit/result/MethodData;

    invoke-virtual {v1, p1}, Lorg/luckypray/dexkit/result/MethodData;->getMethodInstance(Ljava/lang/ClassLoader;)Ljava/lang/reflect/Method;

    move-result-object v1

    .line 122
    invoke-virtual {v1}, Ljava/lang/reflect/Method;->getParameterTypes()[Ljava/lang/Class;

    move-result-object v4

    .line 123
    invoke-virtual {v1}, Ljava/lang/reflect/Method;->getModifiers()I

    move-result v5

    invoke-static {v5}, Ljava/lang/reflect/Modifier;->isStatic(I)Z

    move-result v5

    if-nez v5, :cond_c

    invoke-virtual {v0}, Ljava/lang/reflect/Method;->getModifiers()I

    move-result v5

    invoke-static {v5}, Ljava/lang/reflect/Modifier;->isStatic(I)Z

    move-result v5

    if-nez v5, :cond_c

    const/4 v5, 0x3

    aget-object v5, v4, v5

    sget-object v6, Ljava/lang/Boolean;->TYPE:Ljava/lang/Class;

    if-ne v5, v6, :cond_c

    const/4 v5, 0x4

    aget-object v5, v4, v5

    sget-object v6, Ljava/lang/Integer;->TYPE:Ljava/lang/Class;

    if-ne v5, v6, :cond_c

    .line 127
    aget-object v4, v4, v2

    .line 128
    invoke-static {}, Lorg/luckypray/dexkit/query/FindMethod;->create()Lorg/luckypray/dexkit/query/FindMethod;

    move-result-object v5

    invoke-static {}, Lorg/luckypray/dexkit/query/matchers/MethodMatcher;->create()Lorg/luckypray/dexkit/query/matchers/MethodMatcher;

    move-result-object v6

    .line 129
    invoke-virtual {v6, v4}, Lorg/luckypray/dexkit/query/matchers/MethodMatcher;->declaredClass(Ljava/lang/Class;)Lorg/luckypray/dexkit/query/matchers/MethodMatcher;

    move-result-object v6

    const-string v7, "ParallelTaskData:{mTimestamp="

    const-string v8, ",mSavePath="

    filled-new-array {v7, v8}, [Ljava/lang/String;

    move-result-object v7

    invoke-virtual {v6, v7}, Lorg/luckypray/dexkit/query/matchers/MethodMatcher;->usingStrings([Ljava/lang/String;)Lorg/luckypray/dexkit/query/matchers/MethodMatcher;

    move-result-object v6

    const-class v7, Ljava/lang/String;

    .line 130
    invoke-virtual {v6, v7}, Lorg/luckypray/dexkit/query/matchers/MethodMatcher;->returnType(Ljava/lang/Class;)Lorg/luckypray/dexkit/query/matchers/MethodMatcher;

    move-result-object v6

    invoke-virtual {v6, v2}, Lorg/luckypray/dexkit/query/matchers/MethodMatcher;->paramCount(I)Lorg/luckypray/dexkit/query/matchers/MethodMatcher;

    move-result-object v6

    .line 128
    invoke-virtual {v5, v6}, Lorg/luckypray/dexkit/query/FindMethod;->matcher(Lorg/luckypray/dexkit/query/matchers/MethodMatcher;)Lorg/luckypray/dexkit/query/FindMethod;

    move-result-object v5

    invoke-virtual {p0, v5}, Lorg/luckypray/dexkit/DexKitBridge;->findMethod(Lorg/luckypray/dexkit/query/FindMethod;)Lorg/luckypray/dexkit/result/MethodDataList;

    move-result-object p0

    .line 131
    invoke-virtual {p0}, Lorg/luckypray/dexkit/result/MethodDataList;->size()I

    move-result v5

    if-ne v5, v3, :cond_b

    .line 132
    nop

    .line 133
    invoke-virtual {p0, v2}, Lorg/luckypray/dexkit/result/MethodDataList;->get(I)Ljava/lang/Object;

    move-result-object p0

    check-cast p0, Lorg/luckypray/dexkit/result/MethodData;

    invoke-virtual {p0}, Lorg/luckypray/dexkit/result/MethodData;->getUsingFields()Ljava/util/List;

    move-result-object p0

    invoke-interface {p0}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object p0

    const/4 v5, 0x0

    move-object v11, v5

    :cond_0
    :goto_0
    invoke-interface {p0}, Ljava/util/Iterator;->hasNext()Z

    move-result v6

    if-eqz v6, :cond_4

    invoke-interface {p0}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v6

    check-cast v6, Lorg/luckypray/dexkit/result/UsingFieldData;

    .line 134
    invoke-virtual {v6}, Lorg/luckypray/dexkit/result/UsingFieldData;->getField()Lorg/luckypray/dexkit/result/FieldData;

    move-result-object v6

    invoke-virtual {v6, p1}, Lorg/luckypray/dexkit/result/FieldData;->getFieldInstance(Ljava/lang/ClassLoader;)Ljava/lang/reflect/Field;

    move-result-object v6

    .line 135
    invoke-virtual {v6}, Ljava/lang/reflect/Field;->getType()Ljava/lang/Class;

    move-result-object v7

    const-class v8, Ljava/lang/String;

    if-ne v7, v8, :cond_0

    invoke-virtual {v6}, Ljava/lang/reflect/Field;->getModifiers()I

    move-result v7

    invoke-static {v7}, Ljava/lang/reflect/Modifier;->isStatic(I)Z

    move-result v7

    if-eqz v7, :cond_1

    goto :goto_0

    .line 136
    :cond_1
    if-eqz v11, :cond_3

    invoke-virtual {v11, v6}, Ljava/lang/reflect/Field;->equals(Ljava/lang/Object;)Z

    move-result v7

    if-eqz v7, :cond_2

    goto :goto_1

    :cond_2
    new-instance p0, Ljava/lang/IllegalStateException;

    const-string p1, "Task path field ambiguous"

    invoke-direct {p0, p1}, Ljava/lang/IllegalStateException;-><init>(Ljava/lang/String;)V

    throw p0

    .line 137
    :cond_3
    :goto_1
    nop

    .line 138
    move-object v11, v6

    goto :goto_0

    .line 139
    :cond_4
    if-eqz v11, :cond_a

    invoke-virtual {v11}, Ljava/lang/reflect/Field;->getDeclaringClass()Ljava/lang/Class;

    move-result-object p0

    if-eq p0, v4, :cond_a

    .line 140
    nop

    .line 141
    invoke-virtual {v4}, Ljava/lang/Class;->getDeclaredFields()[Ljava/lang/reflect/Field;

    move-result-object p0

    array-length p1, p0

    move v4, v2

    move-object v10, v5

    :goto_2
    if-ge v4, p1, :cond_8

    aget-object v5, p0, v4

    .line 142
    invoke-virtual {v5}, Ljava/lang/reflect/Field;->getModifiers()I

    move-result v6

    invoke-static {v6}, Ljava/lang/reflect/Modifier;->isStatic(I)Z

    move-result v6

    if-nez v6, :cond_7

    invoke-virtual {v5}, Ljava/lang/reflect/Field;->getType()Ljava/lang/Class;

    move-result-object v6

    invoke-virtual {v11}, Ljava/lang/reflect/Field;->getDeclaringClass()Ljava/lang/Class;

    move-result-object v7

    if-eq v6, v7, :cond_5

    goto :goto_3

    .line 143
    :cond_5
    if-nez v10, :cond_6

    .line 144
    move-object v10, v5

    goto :goto_3

    .line 143
    :cond_6
    new-instance p0, Ljava/lang/IllegalStateException;

    const-string p1, "Storage field ambiguous"

    invoke-direct {p0, p1}, Ljava/lang/IllegalStateException;-><init>(Ljava/lang/String;)V

    throw p0

    .line 141
    :cond_7
    :goto_3
    add-int/lit8 v4, v4, 0x1

    goto :goto_2

    .line 146
    :cond_8
    if-eqz v10, :cond_9

    .line 147
    nop

    .line 148
    invoke-virtual {v11, v3}, Ljava/lang/reflect/Field;->setAccessible(Z)V

    invoke-virtual {v10, v3}, Ljava/lang/reflect/Field;->setAccessible(Z)V

    .line 149
    const-class p0, Llocal/mio/os4camerabridge/RearLivePhotoBridge;

    invoke-virtual {p0}, Ljava/lang/Class;->getClassLoader()Ljava/lang/ClassLoader;

    move-result-object p0

    const-string p1, "local.mio.os4camerabridge.HookEntry"

    invoke-static {p1, v2, p0}, Ljava/lang/Class;->forName(Ljava/lang/String;ZLjava/lang/ClassLoader;)Ljava/lang/Class;

    move-result-object p0

    .line 150
    const-string p1, "commonApsUnifiedSessionActive"

    invoke-static {p0, p1}, Llocal/mio/os4camerabridge/RearLivePhotoBridge;->field(Ljava/lang/Class;Ljava/lang/String;)Ljava/lang/reflect/Field;

    move-result-object v7

    .line 151
    const-string p1, "activeCameraModule"

    invoke-static {p0, p1}, Llocal/mio/os4camerabridge/RearLivePhotoBridge;->field(Ljava/lang/Class;Ljava/lang/String;)Ljava/lang/reflect/Field;

    move-result-object v8

    .line 152
    const-string p1, "activeCameraId"

    invoke-static {p0, p1}, Llocal/mio/os4camerabridge/RearLivePhotoBridge;->field(Ljava/lang/Class;Ljava/lang/String;)Ljava/lang/reflect/Field;

    move-result-object v9

    .line 153
    const-string p1, "commonApsUnifiedSessionGeneration"

    invoke-static {p0, p1}, Llocal/mio/os4camerabridge/RearLivePhotoBridge;->field(Ljava/lang/Class;Ljava/lang/String;)Ljava/lang/reflect/Field;

    move-result-object v12

    .line 154
    new-instance p0, Llocal/mio/os4camerabridge/RearLivePhotoBridge$4;

    invoke-direct {p0, v7, v8, v9, v12}, Llocal/mio/os4camerabridge/RearLivePhotoBridge$4;-><init>(Ljava/lang/reflect/Field;Ljava/lang/reflect/Field;Ljava/lang/reflect/Field;Ljava/lang/reflect/Field;)V

    invoke-static {v0, p0}, Lde/robv/android/xposed/XposedBridge;->hookMethod(Ljava/lang/reflect/Member;Lde/robv/android/xposed/XC_MethodHook;)Lde/robv/android/xposed/XC_MethodHook$Unhook;

    .line 167
    new-instance v6, Llocal/mio/os4camerabridge/RearLivePhotoBridge$5;

    invoke-direct/range {v6 .. v12}, Llocal/mio/os4camerabridge/RearLivePhotoBridge$5;-><init>(Ljava/lang/reflect/Field;Ljava/lang/reflect/Field;Ljava/lang/reflect/Field;Ljava/lang/reflect/Field;Ljava/lang/reflect/Field;Ljava/lang/reflect/Field;)V

    invoke-static {v1, v6}, Lde/robv/android/xposed/XposedBridge;->hookMethod(Ljava/lang/reflect/Member;Lde/robv/android/xposed/XC_MethodHook;)Lde/robv/android/xposed/XC_MethodHook$Unhook;

    .line 191
    invoke-static {v0}, Ljava/lang/String;->valueOf(Ljava/lang/Object;)Ljava/lang/String;

    move-result-object p0

    invoke-static {v1}, Ljava/lang/String;->valueOf(Ljava/lang/Object;)Ljava/lang/String;

    move-result-object p1

    invoke-static {v10}, Ljava/lang/String;->valueOf(Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v0

    invoke-static {v11}, Ljava/lang/String;->valueOf(Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v1

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "bound path setter="

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, p0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p0

    const-string v2, " capture="

    invoke-virtual {p0, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p0

    invoke-virtual {p0, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p0

    const-string p1, " storage="

    invoke-virtual {p0, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p0

    invoke-virtual {p0, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p0

    const-string p1, " path="

    invoke-virtual {p0, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p0

    invoke-virtual {p0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p0

    invoke-virtual {p0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p0

    invoke-static {p0}, Llocal/mio/os4camerabridge/RearLivePhotoBridge;->log(Ljava/lang/String;)V

    .line 192
    return-void

    .line 146
    :cond_9
    new-instance p0, Ljava/lang/IllegalStateException;

    const-string p1, "Task storage absent"

    invoke-direct {p0, p1}, Ljava/lang/IllegalStateException;-><init>(Ljava/lang/String;)V

    throw p0

    .line 139
    :cond_a
    new-instance p0, Ljava/lang/IllegalStateException;

    const-string p1, "Nested task path absent"

    invoke-direct {p0, p1}, Ljava/lang/IllegalStateException;-><init>(Ljava/lang/String;)V

    throw p0

    .line 131
    :cond_b
    new-instance p0, Ljava/lang/IllegalStateException;

    const-string p1, "Task identity descriptor not unique"

    invoke-direct {p0, p1}, Ljava/lang/IllegalStateException;-><init>(Ljava/lang/String;)V

    throw p0

    .line 125
    :cond_c
    new-instance p0, Ljava/lang/IllegalStateException;

    const-string p1, "Live path method structure changed"

    invoke-direct {p0, p1}, Ljava/lang/IllegalStateException;-><init>(Ljava/lang/String;)V

    throw p0

    .line 118
    :cond_d
    new-instance p0, Ljava/lang/IllegalStateException;

    invoke-virtual {v0}, Lorg/luckypray/dexkit/result/MethodDataList;->size()I

    move-result p1

    invoke-virtual {v1}, Lorg/luckypray/dexkit/result/MethodDataList;->size()I

    move-result v0

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "Live path methods ambiguous: "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, p1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object p1

    const-string v1, "/"

    invoke-virtual {p1, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p1

    invoke-virtual {p1, v0}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object p1

    invoke-virtual {p1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p1

    invoke-direct {p0, p1}, Ljava/lang/IllegalStateException;-><init>(Ljava/lang/String;)V

    throw p0
.end method

.method private static eligible(Ljava/lang/reflect/Field;Ljava/lang/reflect/Field;Ljava/lang/reflect/Field;)Z
    .locals 1
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/lang/IllegalAccessException;
        }
    .end annotation

    .line 195
    const/4 v0, 0x0

    invoke-virtual {p0, v0}, Ljava/lang/reflect/Field;->getBoolean(Ljava/lang/Object;)Z

    move-result p0

    if-eqz p0, :cond_0

    invoke-virtual {p1, v0}, Ljava/lang/reflect/Field;->getInt(Ljava/lang/Object;)I

    move-result p0

    const/16 p1, 0xa3

    if-ne p0, p1, :cond_0

    invoke-virtual {p2, v0}, Ljava/lang/reflect/Field;->getInt(Ljava/lang/Object;)I

    move-result p0

    if-nez p0, :cond_0

    const/4 p0, 0x1

    goto :goto_0

    :cond_0
    const/4 p0, 0x0

    :goto_0
    return p0
.end method

.method private static field(Ljava/lang/Class;Ljava/lang/String;)Ljava/lang/reflect/Field;
    .locals 0
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

    .line 198
    invoke-virtual {p0, p1}, Ljava/lang/Class;->getDeclaredField(Ljava/lang/String;)Ljava/lang/reflect/Field;

    move-result-object p0

    const/4 p1, 0x1

    invoke-virtual {p0, p1}, Ljava/lang/reflect/Field;->setAccessible(Z)V

    return-object p0
.end method

.method public static declared-synchronized install(Ljava/lang/ClassLoader;)V
    .locals 5

    const-class v0, Llocal/mio/os4camerabridge/RearLivePhotoBridge;

    monitor-enter v0

    .line 30
    :try_start_0
    sget-boolean v1, Llocal/mio/os4camerabridge/RearLivePhotoBridge;->installed:Z
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_1

    if-eqz v1, :cond_0

    monitor-exit v0

    return-void

    .line 32
    :cond_0
    :try_start_1
    const-class v1, Landroid/app/Application;

    const-string v2, "attach"

    const-class v3, Landroid/content/Context;

    new-instance v4, Llocal/mio/os4camerabridge/RearLivePhotoBridge$1;

    invoke-direct {v4, p0}, Llocal/mio/os4camerabridge/RearLivePhotoBridge$1;-><init>(Ljava/lang/ClassLoader;)V

    filled-new-array {v3, v4}, [Ljava/lang/Object;

    move-result-object p0

    invoke-static {v1, v2, p0}, Lde/robv/android/xposed/XposedHelpers;->findAndHookMethod(Ljava/lang/Class;Ljava/lang/String;[Ljava/lang/Object;)Lde/robv/android/xposed/XC_MethodHook$Unhook;

    .line 39
    const/4 p0, 0x1

    sput-boolean p0, Llocal/mio/os4camerabridge/RearLivePhotoBridge;->installed:Z

    .line 40
    const-string p0, "r17 contract resolver scheduled; no fixed obfuscated encoder/task class"

    invoke-static {p0}, Llocal/mio/os4camerabridge/RearLivePhotoBridge;->log(Ljava/lang/String;)V
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    goto :goto_0

    .line 41
    :catchall_0
    move-exception p0

    :try_start_2
    invoke-static {p0}, Ljava/lang/String;->valueOf(Ljava/lang/Object;)Ljava/lang/String;

    move-result-object p0

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "bootstrap rejected: "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, p0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p0

    invoke-virtual {p0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p0

    invoke-static {p0}, Llocal/mio/os4camerabridge/RearLivePhotoBridge;->log(Ljava/lang/String;)V
    :try_end_2
    .catchall {:try_start_2 .. :try_end_2} :catchall_1

    :goto_0
    nop

    .line 42
    monitor-exit v0

    return-void

    .line 29
    :catchall_1
    move-exception p0

    :try_start_3
    monitor-exit v0
    :try_end_3
    .catchall {:try_start_3 .. :try_end_3} :catchall_1

    throw p0
.end method

.method private static log(Ljava/lang/String;)V
    .locals 2

    .line 107
    sget-object v0, Llocal/mio/os4camerabridge/RearLivePhotoBridge;->LOGS:Ljava/util/concurrent/atomic/AtomicInteger;

    invoke-virtual {v0}, Ljava/util/concurrent/atomic/AtomicInteger;->getAndIncrement()I

    move-result v0

    const/16 v1, 0x3c

    if-ge v0, v1, :cond_0

    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "[RearLivePhoto] "

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, p0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p0

    invoke-virtual {p0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p0

    invoke-static {p0}, Lde/robv/android/xposed/XposedBridge;->log(Ljava/lang/String;)V

    .line 108
    :cond_0
    return-void
.end method

.method private static resolve(Landroid/content/Context;Ljava/lang/ClassLoader;)V
    .locals 8

    .line 46
    :try_start_0
    const-string v0, "dexkit"

    invoke-static {v0}, Ljava/lang/System;->loadLibrary(Ljava/lang/String;)V

    .line 47
    invoke-virtual {p0}, Landroid/content/Context;->getApplicationInfo()Landroid/content/pm/ApplicationInfo;

    move-result-object p0

    iget-object p0, p0, Landroid/content/pm/ApplicationInfo;->sourceDir:Ljava/lang/String;

    invoke-static {p0}, Lorg/luckypray/dexkit/DexKitBridge;->create(Ljava/lang/String;)Lorg/luckypray/dexkit/DexKitBridge;

    move-result-object p0
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_2

    .line 48
    :try_start_1
    invoke-static {}, Lorg/luckypray/dexkit/query/FindMethod;->create()Lorg/luckypray/dexkit/query/FindMethod;

    move-result-object v0

    invoke-static {}, Lorg/luckypray/dexkit/query/matchers/MethodMatcher;->create()Lorg/luckypray/dexkit/query/matchers/MethodMatcher;

    move-result-object v1

    const-string v2, "<init>"

    .line 49
    invoke-virtual {v1, v2}, Lorg/luckypray/dexkit/query/matchers/MethodMatcher;->name(Ljava/lang/String;)Lorg/luckypray/dexkit/query/matchers/MethodMatcher;

    move-result-object v1

    const-string v2, "CircularAudioEncoder"

    const-string v3, "createDirectAACAudioFormat"

    filled-new-array {v2, v3}, [Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2}, Lorg/luckypray/dexkit/query/matchers/MethodMatcher;->usingStrings([Ljava/lang/String;)Lorg/luckypray/dexkit/query/matchers/MethodMatcher;

    move-result-object v1

    const-class v2, Landroid/media/MediaFormat;

    sget-object v3, Ljava/lang/Long;->TYPE:Ljava/lang/Class;

    sget-object v4, Ljava/lang/Long;->TYPE:Ljava/lang/Class;

    const-class v5, Ljava/util/concurrent/LinkedBlockingQueue;

    filled-new-array {v2, v3, v4, v5}, [Ljava/lang/Class;

    move-result-object v2

    .line 50
    invoke-virtual {v1, v2}, Lorg/luckypray/dexkit/query/matchers/MethodMatcher;->paramTypes([Ljava/lang/Class;)Lorg/luckypray/dexkit/query/matchers/MethodMatcher;

    move-result-object v1

    .line 48
    invoke-virtual {v0, v1}, Lorg/luckypray/dexkit/query/FindMethod;->matcher(Lorg/luckypray/dexkit/query/matchers/MethodMatcher;)Lorg/luckypray/dexkit/query/FindMethod;

    move-result-object v0

    invoke-virtual {p0, v0}, Lorg/luckypray/dexkit/DexKitBridge;->findMethod(Lorg/luckypray/dexkit/query/FindMethod;)Lorg/luckypray/dexkit/result/MethodDataList;

    move-result-object v0

    .line 51
    invoke-static {}, Lorg/luckypray/dexkit/query/FindMethod;->create()Lorg/luckypray/dexkit/query/FindMethod;

    move-result-object v1

    invoke-static {}, Lorg/luckypray/dexkit/query/matchers/MethodMatcher;->create()Lorg/luckypray/dexkit/query/matchers/MethodMatcher;

    move-result-object v2

    const-string v3, "ro.miui.support_audiorecord_compress"

    filled-new-array {v3}, [Ljava/lang/String;

    move-result-object v3

    .line 52
    invoke-virtual {v2, v3}, Lorg/luckypray/dexkit/query/matchers/MethodMatcher;->usingStrings([Ljava/lang/String;)Lorg/luckypray/dexkit/query/matchers/MethodMatcher;

    move-result-object v2

    sget-object v3, Ljava/lang/Integer;->TYPE:Ljava/lang/Class;

    sget-object v4, Ljava/lang/Integer;->TYPE:Ljava/lang/Class;

    filled-new-array {v3, v4}, [Ljava/lang/Class;

    move-result-object v3

    .line 53
    invoke-virtual {v2, v3}, Lorg/luckypray/dexkit/query/matchers/MethodMatcher;->paramTypes([Ljava/lang/Class;)Lorg/luckypray/dexkit/query/matchers/MethodMatcher;

    move-result-object v2

    sget-object v3, Ljava/lang/Boolean;->TYPE:Ljava/lang/Class;

    invoke-virtual {v2, v3}, Lorg/luckypray/dexkit/query/matchers/MethodMatcher;->returnType(Ljava/lang/Class;)Lorg/luckypray/dexkit/query/matchers/MethodMatcher;

    move-result-object v2

    .line 51
    invoke-virtual {v1, v2}, Lorg/luckypray/dexkit/query/FindMethod;->matcher(Lorg/luckypray/dexkit/query/matchers/MethodMatcher;)Lorg/luckypray/dexkit/query/FindMethod;

    move-result-object v1

    invoke-virtual {p0, v1}, Lorg/luckypray/dexkit/DexKitBridge;->findMethod(Lorg/luckypray/dexkit/query/FindMethod;)Lorg/luckypray/dexkit/result/MethodDataList;

    move-result-object v1

    .line 54
    invoke-virtual {v0}, Lorg/luckypray/dexkit/result/MethodDataList;->size()I

    move-result v2

    const/4 v3, 0x1

    if-ne v2, v3, :cond_4

    invoke-virtual {v1}, Lorg/luckypray/dexkit/result/MethodDataList;->size()I

    move-result v2

    if-ne v2, v3, :cond_4

    .line 58
    nop

    .line 59
    const/4 v2, 0x0

    invoke-virtual {v0, v2}, Lorg/luckypray/dexkit/result/MethodDataList;->get(I)Ljava/lang/Object;

    move-result-object v4

    check-cast v4, Lorg/luckypray/dexkit/result/MethodData;

    invoke-virtual {v4}, Lorg/luckypray/dexkit/result/MethodData;->getInvokes()Lorg/luckypray/dexkit/result/MethodDataList;

    move-result-object v4

    invoke-virtual {v4}, Lorg/luckypray/dexkit/result/MethodDataList;->iterator()Ljava/util/Iterator;

    move-result-object v4

    move v5, v2

    :goto_0
    invoke-interface {v4}, Ljava/util/Iterator;->hasNext()Z

    move-result v6

    if-eqz v6, :cond_1

    invoke-interface {v4}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v6

    check-cast v6, Lorg/luckypray/dexkit/result/MethodData;

    .line 60
    invoke-virtual {v6}, Lorg/luckypray/dexkit/result/MethodData;->getDescriptor()Ljava/lang/String;

    move-result-object v6

    invoke-virtual {v1, v2}, Lorg/luckypray/dexkit/result/MethodDataList;->get(I)Ljava/lang/Object;

    move-result-object v7

    check-cast v7, Lorg/luckypray/dexkit/result/MethodData;

    invoke-virtual {v7}, Lorg/luckypray/dexkit/result/MethodData;->getDescriptor()Ljava/lang/String;

    move-result-object v7

    invoke-virtual {v6, v7}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v6

    if-eqz v6, :cond_0

    move v5, v3

    .line 61
    :cond_0
    goto :goto_0

    .line 62
    :cond_1
    if-eqz v5, :cond_3

    .line 63
    invoke-virtual {v0, v2}, Lorg/luckypray/dexkit/result/MethodDataList;->get(I)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lorg/luckypray/dexkit/result/MethodData;

    invoke-virtual {v0, p1}, Lorg/luckypray/dexkit/result/MethodData;->getConstructorInstance(Ljava/lang/ClassLoader;)Ljava/lang/reflect/Constructor;

    move-result-object v0

    .line 64
    invoke-virtual {v1, v2}, Lorg/luckypray/dexkit/result/MethodDataList;->get(I)Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Lorg/luckypray/dexkit/result/MethodData;

    invoke-virtual {v1, p1}, Lorg/luckypray/dexkit/result/MethodData;->getMethodInstance(Ljava/lang/ClassLoader;)Ljava/lang/reflect/Method;

    move-result-object v1

    .line 65
    invoke-static {v0, v1}, Llocal/mio/os4camerabridge/RearLivePhotoBridge;->bind(Ljava/lang/reflect/Constructor;Ljava/lang/reflect/Method;)V

    .line 66
    invoke-static {p0, p1}, Llocal/mio/os4camerabridge/RearLivePhotoBridge;->bindCapturePath(Lorg/luckypray/dexkit/DexKitBridge;Ljava/lang/ClassLoader;)V
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    .line 67
    if-eqz p0, :cond_2

    :try_start_2
    invoke-virtual {p0}, Lorg/luckypray/dexkit/DexKitBridge;->close()V
    :try_end_2
    .catchall {:try_start_2 .. :try_end_2} :catchall_2

    .line 68
    :cond_2
    goto :goto_2

    .line 62
    :cond_3
    :try_start_3
    new-instance p1, Ljava/lang/IllegalStateException;

    const-string v0, "Audio constructor/capability edge absent"

    invoke-direct {p1, v0}, Ljava/lang/IllegalStateException;-><init>(Ljava/lang/String;)V

    throw p1

    .line 55
    :cond_4
    new-instance p1, Ljava/lang/IllegalStateException;

    invoke-virtual {v0}, Lorg/luckypray/dexkit/result/MethodDataList;->size()I

    move-result v0

    .line 56
    invoke-virtual {v1}, Lorg/luckypray/dexkit/result/MethodDataList;->size()I

    move-result v1

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "Audio candidates constructor="

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, v0}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v2, " capability="

    invoke-virtual {v0, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-direct {p1, v0}, Ljava/lang/IllegalStateException;-><init>(Ljava/lang/String;)V

    throw p1
    :try_end_3
    .catchall {:try_start_3 .. :try_end_3} :catchall_0

    .line 47
    :catchall_0
    move-exception p1

    if-eqz p0, :cond_5

    :try_start_4
    invoke-virtual {p0}, Lorg/luckypray/dexkit/DexKitBridge;->close()V
    :try_end_4
    .catchall {:try_start_4 .. :try_end_4} :catchall_1

    goto :goto_1

    :catchall_1
    move-exception p0

    :try_start_5
    invoke-virtual {p1, p0}, Ljava/lang/Throwable;->addSuppressed(Ljava/lang/Throwable;)V

    :cond_5
    :goto_1
    throw p1
    :try_end_5
    .catchall {:try_start_5 .. :try_end_5} :catchall_2

    .line 68
    :catchall_2
    move-exception p0

    invoke-static {p0}, Ljava/lang/String;->valueOf(Ljava/lang/Object;)Ljava/lang/String;

    move-result-object p0

    new-instance p1, Ljava/lang/StringBuilder;

    invoke-direct {p1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v0, "binding rejected, native behavior retained: "

    invoke-virtual {p1, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p1

    invoke-virtual {p1, p0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p0

    invoke-virtual {p0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p0

    invoke-static {p0}, Llocal/mio/os4camerabridge/RearLivePhotoBridge;->log(Ljava/lang/String;)V

    .line 69
    :goto_2
    return-void
.end method
