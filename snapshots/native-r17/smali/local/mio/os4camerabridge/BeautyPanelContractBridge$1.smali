.class Llocal/mio/os4camerabridge/BeautyPanelContractBridge$1;
.super Lde/robv/android/xposed/XC_MethodHook;
.source "BeautyPanelContractBridge.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Llocal/mio/os4camerabridge/BeautyPanelContractBridge;->bind(Lorg/luckypray/dexkit/DexKitBridge;Ljava/lang/ClassLoader;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic val$list:Ljava/lang/reflect/Field;

.field final synthetic val$mode:Ljava/lang/reflect/Field;

.field final synthetic val$sourceItems:Ljava/lang/reflect/Field;

.field final synthetic val$value:Ljava/lang/reflect/Field;


# direct methods
.method constructor <init>(Ljava/lang/reflect/Field;Ljava/lang/reflect/Field;Ljava/lang/reflect/Field;Ljava/lang/reflect/Field;)V
    .locals 0

    .line 72
    iput-object p1, p0, Llocal/mio/os4camerabridge/BeautyPanelContractBridge$1;->val$mode:Ljava/lang/reflect/Field;

    iput-object p2, p0, Llocal/mio/os4camerabridge/BeautyPanelContractBridge$1;->val$list:Ljava/lang/reflect/Field;

    iput-object p3, p0, Llocal/mio/os4camerabridge/BeautyPanelContractBridge$1;->val$value:Ljava/lang/reflect/Field;

    iput-object p4, p0, Llocal/mio/os4camerabridge/BeautyPanelContractBridge$1;->val$sourceItems:Ljava/lang/reflect/Field;

    invoke-direct {p0}, Lde/robv/android/xposed/XC_MethodHook;-><init>()V

    return-void
.end method


# virtual methods
.method protected afterHookedMethod(Lde/robv/android/xposed/XC_MethodHook$MethodHookParam;)V
    .locals 4

    .line 85
    const-string v0, "2"

    :try_start_0
    iget-object v1, p0, Llocal/mio/os4camerabridge/BeautyPanelContractBridge$1;->val$mode:Ljava/lang/reflect/Field;

    iget-object v2, p1, Lde/robv/android/xposed/XC_MethodHook$MethodHookParam;->thisObject:Ljava/lang/Object;

    invoke-virtual {v1, v2}, Ljava/lang/reflect/Field;->getInt(Ljava/lang/Object;)I

    move-result v1

    .line 86
    const/16 v2, 0xa3

    if-eq v1, v2, :cond_0

    const/16 v2, 0xab

    if-ne v1, v2, :cond_3

    :cond_0
    invoke-virtual {p1}, Lde/robv/android/xposed/XC_MethodHook$MethodHookParam;->hasThrowable()Z

    move-result v1

    if-nez v1, :cond_3

    const-string v1, "1"

    .line 87
    invoke-virtual {p1}, Lde/robv/android/xposed/XC_MethodHook$MethodHookParam;->getResult()Ljava/lang/Object;

    move-result-object v2

    invoke-virtual {v1, v2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-nez v1, :cond_1

    const-string v1, "4"

    invoke-virtual {p1}, Lde/robv/android/xposed/XC_MethodHook$MethodHookParam;->getResult()Ljava/lang/Object;

    move-result-object v2

    invoke-virtual {v1, v2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-eqz v1, :cond_3

    .line 88
    :cond_1
    iget-object v1, p0, Llocal/mio/os4camerabridge/BeautyPanelContractBridge$1;->val$list:Ljava/lang/reflect/Field;

    iget-object v2, p1, Lde/robv/android/xposed/XC_MethodHook$MethodHookParam;->thisObject:Ljava/lang/Object;

    invoke-virtual {v1, v2}, Ljava/lang/reflect/Field;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v1

    .line 89
    instance-of v2, v1, Ljava/util/List;

    if-eqz v2, :cond_3

    check-cast v1, Ljava/util/List;

    invoke-interface {v1}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object v1

    :cond_2
    invoke-interface {v1}, Ljava/util/Iterator;->hasNext()Z

    move-result v2

    if-eqz v2, :cond_3

    invoke-interface {v1}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v2

    .line 90
    iget-object v3, p0, Llocal/mio/os4camerabridge/BeautyPanelContractBridge$1;->val$value:Ljava/lang/reflect/Field;

    invoke-virtual {v3}, Ljava/lang/reflect/Field;->getDeclaringClass()Ljava/lang/Class;

    move-result-object v3

    invoke-virtual {v3, v2}, Ljava/lang/Class;->isInstance(Ljava/lang/Object;)Z

    move-result v3

    if-eqz v3, :cond_2

    iget-object v3, p0, Llocal/mio/os4camerabridge/BeautyPanelContractBridge$1;->val$value:Ljava/lang/reflect/Field;

    invoke-virtual {v3, v2}, Ljava/lang/reflect/Field;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v2

    invoke-virtual {v0, v2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v2

    if-eqz v2, :cond_2

    .line 91
    invoke-virtual {p1, v0}, Lde/robv/android/xposed/XC_MethodHook$MethodHookParam;->setResult(Ljava/lang/Object;)V
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 92
    nop

    .line 95
    :cond_3
    goto :goto_0

    :catchall_0
    move-exception p1

    invoke-static {p1}, Ljava/lang/String;->valueOf(Ljava/lang/Object;)Ljava/lang/String;

    move-result-object p1

    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "[BeautyPanelContract] selection unavailable: "

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p1

    invoke-virtual {p1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p1

    invoke-static {p1}, Lde/robv/android/xposed/XposedBridge;->log(Ljava/lang/String;)V

    .line 96
    :goto_0
    return-void
.end method

.method protected beforeHookedMethod(Lde/robv/android/xposed/XC_MethodHook$MethodHookParam;)V
    .locals 4

    .line 75
    :try_start_0
    iget-object v0, p0, Llocal/mio/os4camerabridge/BeautyPanelContractBridge$1;->val$mode:Ljava/lang/reflect/Field;

    iget-object v1, p1, Lde/robv/android/xposed/XC_MethodHook$MethodHookParam;->thisObject:Ljava/lang/Object;

    invoke-virtual {v0, v1}, Ljava/lang/reflect/Field;->getInt(Ljava/lang/Object;)I

    move-result v0

    .line 76
    const/16 v1, 0xa3

    if-eq v0, v1, :cond_0

    const/16 v1, 0xab

    if-eq v0, v1, :cond_0

    return-void

    .line 77
    :cond_0
    iget-object v1, p1, Lde/robv/android/xposed/XC_MethodHook$MethodHookParam;->thisObject:Ljava/lang/Object;

    iget-object v2, p0, Llocal/mio/os4camerabridge/BeautyPanelContractBridge$1;->val$list:Ljava/lang/reflect/Field;

    iget-object v3, p0, Llocal/mio/os4camerabridge/BeautyPanelContractBridge$1;->val$value:Ljava/lang/reflect/Field;

    invoke-static {v1, v2, v3}, Llocal/mio/os4camerabridge/BeautyPanelContractBridge;->-$$Nest$smnormalizeItems(Ljava/lang/Object;Ljava/lang/reflect/Field;Ljava/lang/reflect/Field;)I

    move-result v1

    .line 78
    iget-object p1, p1, Lde/robv/android/xposed/XC_MethodHook$MethodHookParam;->thisObject:Ljava/lang/Object;

    iget-object v2, p0, Llocal/mio/os4camerabridge/BeautyPanelContractBridge$1;->val$sourceItems:Ljava/lang/reflect/Field;

    iget-object v3, p0, Llocal/mio/os4camerabridge/BeautyPanelContractBridge$1;->val$value:Ljava/lang/reflect/Field;

    invoke-static {p1, v2, v3}, Llocal/mio/os4camerabridge/BeautyPanelContractBridge;->-$$Nest$smnormalizeItems(Ljava/lang/Object;Ljava/lang/reflect/Field;Ljava/lang/reflect/Field;)I

    move-result p1

    add-int/2addr v1, p1

    .line 79
    if-eqz v1, :cond_1

    new-instance p1, Ljava/lang/StringBuilder;

    invoke-direct {p1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "[BeautyPanelContract] mode="

    invoke-virtual {p1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p1

    invoke-virtual {p1, v0}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object p1

    const-string v0, " normalized legacy 1 -> smooth 2, unsupported reshape 4 hidden; changes="

    invoke-virtual {p1, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p1

    invoke-virtual {p1, v1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object p1

    invoke-virtual {p1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p1

    invoke-static {p1}, Lde/robv/android/xposed/XposedBridge;->log(Ljava/lang/String;)V
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 81
    :cond_1
    goto :goto_0

    :catchall_0
    move-exception p1

    invoke-static {p1}, Ljava/lang/String;->valueOf(Ljava/lang/Object;)Ljava/lang/String;

    move-result-object p1

    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "[BeautyPanelContract] list unavailable: "

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p1

    invoke-virtual {p1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p1

    invoke-static {p1}, Lde/robv/android/xposed/XposedBridge;->log(Ljava/lang/String;)V

    .line 82
    :goto_0
    return-void
.end method
