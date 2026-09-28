.class Llocal/mio/os4camerabridge/SlowMotionRecorderBridge$14;
.super Lde/robv/android/xposed/XC_MethodHook;
.source "SlowMotionRecorderBridge.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Llocal/mio/os4camerabridge/SlowMotionRecorderBridge;->bindLockedComponent(Lorg/luckypray/dexkit/DexKitBridge;Ljava/lang/ClassLoader;Ljava/lang/String;Ljava/lang/String;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic val$itemField:Ljava/lang/reflect/Field;

.field final synthetic val$value:Ljava/lang/String;


# direct methods
.method constructor <init>(Ljava/lang/reflect/Field;Ljava/lang/String;)V
    .locals 0

    .line 221
    iput-object p1, p0, Llocal/mio/os4camerabridge/SlowMotionRecorderBridge$14;->val$itemField:Ljava/lang/reflect/Field;

    iput-object p2, p0, Llocal/mio/os4camerabridge/SlowMotionRecorderBridge$14;->val$value:Ljava/lang/String;

    invoke-direct {p0}, Lde/robv/android/xposed/XC_MethodHook;-><init>()V

    return-void
.end method


# virtual methods
.method protected afterHookedMethod(Lde/robv/android/xposed/XC_MethodHook$MethodHookParam;)V
    .locals 11
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/lang/Throwable;
        }
    .end annotation

    .line 223
    iget-object v0, p0, Llocal/mio/os4camerabridge/SlowMotionRecorderBridge$14;->val$itemField:Ljava/lang/reflect/Field;

    iget-object v1, p1, Lde/robv/android/xposed/XC_MethodHook$MethodHookParam;->thisObject:Ljava/lang/Object;

    invoke-virtual {v0, v1}, Ljava/lang/reflect/Field;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0

    .line 224
    instance-of v1, v0, Ljava/util/List;

    if-nez v1, :cond_0

    return-void

    .line 225
    :cond_0
    new-instance v1, Ljava/util/ArrayList;

    invoke-direct {v1}, Ljava/util/ArrayList;-><init>()V

    .line 226
    check-cast v0, Ljava/util/List;

    invoke-interface {v0}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object v2

    :goto_0
    invoke-interface {v2}, Ljava/util/Iterator;->hasNext()Z

    move-result v3

    if-eqz v3, :cond_5

    invoke-interface {v2}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v3

    .line 227
    if-nez v3, :cond_1

    goto :goto_0

    .line 228
    :cond_1
    nop

    .line 229
    invoke-virtual {v3}, Ljava/lang/Object;->getClass()Ljava/lang/Class;

    move-result-object v4

    invoke-virtual {v4}, Ljava/lang/Class;->getDeclaredFields()[Ljava/lang/reflect/Field;

    move-result-object v4

    array-length v5, v4

    const/4 v6, 0x0

    move v7, v6

    :goto_1
    if-ge v6, v5, :cond_3

    aget-object v8, v4, v6

    invoke-virtual {v8}, Ljava/lang/reflect/Field;->getType()Ljava/lang/Class;

    move-result-object v9

    const-class v10, Ljava/lang/String;

    if-ne v9, v10, :cond_2

    invoke-virtual {v8}, Ljava/lang/reflect/Field;->getModifiers()I

    move-result v9

    invoke-static {v9}, Ljava/lang/reflect/Modifier;->isStatic(I)Z

    move-result v9

    if-nez v9, :cond_2

    .line 230
    const/4 v9, 0x1

    invoke-virtual {v8, v9}, Ljava/lang/reflect/Field;->setAccessible(Z)V

    iget-object v10, p0, Llocal/mio/os4camerabridge/SlowMotionRecorderBridge$14;->val$value:Ljava/lang/String;

    invoke-virtual {v8, v3}, Ljava/lang/reflect/Field;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v8

    invoke-virtual {v10, v8}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v8

    if-eqz v8, :cond_2

    move v7, v9

    .line 229
    :cond_2
    add-int/lit8 v6, v6, 0x1

    goto :goto_1

    .line 232
    :cond_3
    if-eqz v7, :cond_4

    invoke-interface {v1, v3}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    .line 233
    :cond_4
    goto :goto_0

    .line 234
    :cond_5
    invoke-interface {v0}, Ljava/util/List;->size()I

    move-result v0

    invoke-interface {v1}, Ljava/util/List;->size()I

    move-result v2

    if-eq v0, v2, :cond_6

    iget-object v0, p0, Llocal/mio/os4camerabridge/SlowMotionRecorderBridge$14;->val$itemField:Ljava/lang/reflect/Field;

    iget-object v2, p1, Lde/robv/android/xposed/XC_MethodHook$MethodHookParam;->thisObject:Ljava/lang/Object;

    invoke-virtual {v0, v2, v1}, Ljava/lang/reflect/Field;->set(Ljava/lang/Object;Ljava/lang/Object;)V

    .line 235
    :cond_6
    iget-object v0, p1, Lde/robv/android/xposed/XC_MethodHook$MethodHookParam;->method:Ljava/lang/reflect/Member;

    instance-of v0, v0, Ljava/lang/reflect/Method;

    if-eqz v0, :cond_7

    iget-object v0, p1, Lde/robv/android/xposed/XC_MethodHook$MethodHookParam;->method:Ljava/lang/reflect/Member;

    check-cast v0, Ljava/lang/reflect/Method;

    invoke-virtual {v0}, Ljava/lang/reflect/Method;->getName()Ljava/lang/String;

    move-result-object v0

    const-string v2, "getItems"

    invoke-virtual {v0, v2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_7

    invoke-virtual {p1, v1}, Lde/robv/android/xposed/XC_MethodHook$MethodHookParam;->setResult(Ljava/lang/Object;)V

    .line 236
    :cond_7
    return-void
.end method
