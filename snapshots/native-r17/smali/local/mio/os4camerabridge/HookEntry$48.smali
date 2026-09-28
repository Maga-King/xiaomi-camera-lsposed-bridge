.class Llocal/mio/os4camerabridge/HookEntry$48;
.super Lde/robv/android/xposed/XC_MethodHook;
.source "HookEntry.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Llocal/mio/os4camerabridge/HookEntry;->hookNv21ImageCompatibility(Ljava/lang/ClassLoader;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic val$capabilityUtils:Ljava/lang/Class;

.field final synthetic val$roleFacade:Ljava/lang/Class;


# direct methods
.method constructor <init>(Ljava/lang/Class;Ljava/lang/Class;)V
    .locals 0

    .line 8859
    iput-object p1, p0, Llocal/mio/os4camerabridge/HookEntry$48;->val$roleFacade:Ljava/lang/Class;

    iput-object p2, p0, Llocal/mio/os4camerabridge/HookEntry$48;->val$capabilityUtils:Ljava/lang/Class;

    invoke-direct {p0}, Lde/robv/android/xposed/XC_MethodHook;-><init>()V

    return-void
.end method


# virtual methods
.method protected afterHookedMethod(Lde/robv/android/xposed/XC_MethodHook$MethodHookParam;)V
    .locals 6
    .param p1, "param"    # Lde/robv/android/xposed/XC_MethodHook$MethodHookParam;

    .line 8862
    invoke-virtual {p1}, Lde/robv/android/xposed/XC_MethodHook$MethodHookParam;->hasThrowable()Z

    move-result v0

    if-nez v0, :cond_3

    sget-object v0, Ljava/lang/Boolean;->TRUE:Ljava/lang/Boolean;

    .line 8863
    invoke-virtual {p1}, Lde/robv/android/xposed/XC_MethodHook$MethodHookParam;->getResult()Ljava/lang/Object;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/Boolean;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_0

    goto :goto_1

    .line 8866
    :cond_0
    const/4 v0, -0x1

    .line 8868
    .local v0, "format":I
    :try_start_0
    iget-object v1, p0, Llocal/mio/os4camerabridge/HookEntry$48;->val$roleFacade:Ljava/lang/Class;

    const-string v2, "T"

    const/4 v3, 0x0

    new-array v4, v3, [Ljava/lang/Object;

    invoke-static {v1, v2, v4}, Lde/robv/android/xposed/XposedHelpers;->callStaticMethod(Ljava/lang/Class;Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v1

    .line 8870
    .local v1, "roles":Ljava/lang/Object;
    const-string v2, "P"

    new-array v3, v3, [Ljava/lang/Object;

    invoke-static {v1, v2, v3}, Lde/robv/android/xposed/XposedHelpers;->callMethod(Ljava/lang/Object;Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v2

    .line 8871
    .local v2, "capability":Ljava/lang/Object;
    if-eqz v2, :cond_1

    .line 8872
    iget-object v3, p0, Llocal/mio/os4camerabridge/HookEntry$48;->val$capabilityUtils:Ljava/lang/Class;

    const-string v4, "N0"

    filled-new-array {v2}, [Ljava/lang/Object;

    move-result-object v5

    invoke-static {v3, v4, v5}, Lde/robv/android/xposed/XposedHelpers;->callStaticMethod(Ljava/lang/Class;Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v3

    .line 8874
    .local v3, "value":Ljava/lang/Object;
    instance-of v4, v3, Ljava/lang/Integer;

    if-eqz v4, :cond_1

    .line 8875
    move-object v4, v3

    check-cast v4, Ljava/lang/Integer;

    invoke-virtual {v4}, Ljava/lang/Integer;->intValue()I

    move-result v4
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    move v0, v4

    .line 8881
    .end local v1    # "roles":Ljava/lang/Object;
    .end local v2    # "capability":Ljava/lang/Object;
    .end local v3    # "value":Ljava/lang/Object;
    :cond_1
    goto :goto_0

    .line 8878
    :catchall_0
    move-exception v1

    .line 8882
    :goto_0
    const/4 v1, 0x1

    if-eq v0, v1, :cond_2

    .line 8883
    invoke-static {v1}, Ljava/lang/Boolean;->valueOf(Z)Ljava/lang/Boolean;

    move-result-object v1

    invoke-virtual {p1, v1}, Lde/robv/android/xposed/XC_MethodHook$MethodHookParam;->setResult(Ljava/lang/Object;)V

    .line 8884
    invoke-static {}, Llocal/mio/os4camerabridge/HookEntry;->-$$Nest$sfgetLOGICAL_CAMERA_CONTRACT_LOGGED()Ljava/util/Set;

    move-result-object v1

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "nv21:"

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, v0}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-interface {v1, v2}, Ljava/util/Set;->add(Ljava/lang/Object;)Z

    move-result v1

    if-eqz v1, :cond_2

    .line 8885
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "[LogicalCameraContract] NV21 accepted metadata="

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, v0}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-static {v1}, Llocal/mio/os4camerabridge/HookEntry;->-$$Nest$smlog(Ljava/lang/String;)V

    .line 8889
    :cond_2
    return-void

    .line 8864
    .end local v0    # "format":I
    :cond_3
    :goto_1
    return-void
.end method
