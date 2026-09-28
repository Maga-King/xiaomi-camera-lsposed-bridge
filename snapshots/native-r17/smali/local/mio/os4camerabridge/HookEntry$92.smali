.class Llocal/mio/os4camerabridge/HookEntry$92;
.super Lde/robv/android/xposed/XC_MethodHook;
.source "HookEntry.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Llocal/mio/os4camerabridge/HookEntry;->hookOnePlusLensOwnership(Ljava/lang/ClassLoader;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# direct methods
.method constructor <init>()V
    .locals 0

    .line 13804
    invoke-direct {p0}, Lde/robv/android/xposed/XC_MethodHook;-><init>()V

    return-void
.end method


# virtual methods
.method protected beforeHookedMethod(Lde/robv/android/xposed/XC_MethodHook$MethodHookParam;)V
    .locals 3
    .param p1, "param"    # Lde/robv/android/xposed/XC_MethodHook$MethodHookParam;

    .line 13807
    iget-object v0, p1, Lde/robv/android/xposed/XC_MethodHook$MethodHookParam;->args:[Ljava/lang/Object;

    const/4 v1, 0x0

    if-eqz v0, :cond_0

    iget-object v0, p1, Lde/robv/android/xposed/XC_MethodHook$MethodHookParam;->args:[Ljava/lang/Object;

    array-length v0, v0

    const/4 v2, 0x1

    if-lt v0, v2, :cond_0

    .line 13808
    iget-object v0, p1, Lde/robv/android/xposed/XC_MethodHook$MethodHookParam;->args:[Ljava/lang/Object;

    const/4 v2, 0x0

    aget-object v0, v0, v2

    goto :goto_0

    :cond_0
    move-object v0, v1

    .line 13809
    .local v0, "module":Ljava/lang/Object;
    :goto_0
    invoke-static {v0}, Llocal/mio/os4camerabridge/HookEntry;->-$$Nest$smmoduleKeepsOplusLogicalSat(Ljava/lang/Object;)Z

    move-result v2

    if-eqz v2, :cond_1

    .line 13810
    const-string v2, "physical reopen"

    invoke-static {v0, v2}, Llocal/mio/os4camerabridge/HookEntry;->-$$Nest$smlogLogicalLensOwnership(Ljava/lang/Object;Ljava/lang/String;)V

    .line 13812
    invoke-virtual {p1, v1}, Lde/robv/android/xposed/XC_MethodHook$MethodHookParam;->setResult(Ljava/lang/Object;)V

    .line 13814
    :cond_1
    return-void
.end method
