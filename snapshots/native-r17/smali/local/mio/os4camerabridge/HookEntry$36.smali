.class Llocal/mio/os4camerabridge/HookEntry$36;
.super Lde/robv/android/xposed/XC_MethodHook;
.source "HookEntry.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Llocal/mio/os4camerabridge/HookEntry;->hookOplusBeautyRequestBridge(Ljava/lang/ClassLoader;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# direct methods
.method constructor <init>()V
    .locals 0

    .line 7523
    invoke-direct {p0}, Lde/robv/android/xposed/XC_MethodHook;-><init>()V

    return-void
.end method


# virtual methods
.method protected beforeHookedMethod(Lde/robv/android/xposed/XC_MethodHook$MethodHookParam;)V
    .locals 7
    .param p1, "param"    # Lde/robv/android/xposed/XC_MethodHook$MethodHookParam;

    .line 7527
    const/16 v0, 0xe

    const/16 v1, 0xd

    const/4 v2, 0x0

    const/4 v3, -0x1

    :try_start_0
    iget-object v4, p1, Lde/robv/android/xposed/XC_MethodHook$MethodHookParam;->thisObject:Ljava/lang/Object;

    const-string v5, "mModuleIndex"

    invoke-static {v4, v5}, Lde/robv/android/xposed/XposedHelpers;->getIntField(Ljava/lang/Object;Ljava/lang/String;)I

    move-result v4

    .line 7529
    .local v4, "module":I
    invoke-static {v4}, Llocal/mio/os4camerabridge/HookEntry;->-$$Nest$sfputactiveCameraModule(I)V

    .line 7530
    const/16 v5, 0xa3

    if-eq v4, v5, :cond_1

    const/16 v5, 0xab

    if-ne v4, v5, :cond_0

    goto :goto_0

    .line 7531
    :cond_0
    move v5, v3

    goto :goto_1

    :cond_1
    :goto_0
    move v5, v4

    :goto_1
    invoke-static {v5}, Llocal/mio/os4camerabridge/HookEntry;->-$$Nest$sfputactiveBeautyModule(I)V

    .line 7532
    invoke-static {v2}, Llocal/mio/os4camerabridge/HookEntry;->-$$Nest$sfputactiveBeautyEnabled(Z)V

    .line 7533
    new-array v5, v1, [I

    invoke-static {v5}, Llocal/mio/os4camerabridge/HookEntry;->-$$Nest$sfputactiveBeautyUi13([I)V

    .line 7534
    new-array v5, v0, [I

    invoke-static {v5}, Llocal/mio/os4camerabridge/HookEntry;->-$$Nest$sfputactiveBeautyPreviewHal14([I)V

    .line 7535
    const-string v5, ""

    invoke-static {v5}, Llocal/mio/os4camerabridge/HookEntry;->-$$Nest$sfputlastBeautyRequestSignature(Ljava/lang/String;)V

    .line 7536
    new-instance v5, Ljava/lang/StringBuilder;

    invoke-direct {v5}, Ljava/lang/StringBuilder;-><init>()V

    const-string v6, "[BeautyBridge] module="

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5, v4}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v5

    const-string v6, " scope="

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-static {}, Llocal/mio/os4camerabridge/HookEntry;->-$$Nest$sfgetactiveBeautyModule()I

    move-result v6

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v5

    invoke-static {v5}, Llocal/mio/os4camerabridge/HookEntry;->-$$Nest$smlog(Ljava/lang/String;)V
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 7545
    .end local v4    # "module":I
    goto :goto_2

    .line 7538
    :catchall_0
    move-exception v4

    .line 7539
    .local v4, "throwable":Ljava/lang/Throwable;
    invoke-static {v3}, Llocal/mio/os4camerabridge/HookEntry;->-$$Nest$sfputactiveCameraModule(I)V

    .line 7540
    invoke-static {v3}, Llocal/mio/os4camerabridge/HookEntry;->-$$Nest$sfputactiveBeautyModule(I)V

    .line 7541
    invoke-static {v2}, Llocal/mio/os4camerabridge/HookEntry;->-$$Nest$sfputactiveBeautyEnabled(Z)V

    .line 7542
    new-array v1, v1, [I

    invoke-static {v1}, Llocal/mio/os4camerabridge/HookEntry;->-$$Nest$sfputactiveBeautyUi13([I)V

    .line 7543
    new-array v0, v0, [I

    invoke-static {v0}, Llocal/mio/os4camerabridge/HookEntry;->-$$Nest$sfputactiveBeautyPreviewHal14([I)V

    .line 7544
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "[BeautyBridge] module scope failed: "

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Llocal/mio/os4camerabridge/HookEntry;->-$$Nest$smlog(Ljava/lang/String;)V

    .line 7546
    .end local v4    # "throwable":Ljava/lang/Throwable;
    :goto_2
    return-void
.end method
