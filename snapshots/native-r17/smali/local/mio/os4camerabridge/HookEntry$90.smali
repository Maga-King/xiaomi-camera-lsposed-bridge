.class Llocal/mio/os4camerabridge/HookEntry$90;
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

    .line 13782
    invoke-direct {p0}, Lde/robv/android/xposed/XC_MethodHook;-><init>()V

    return-void
.end method


# virtual methods
.method protected beforeHookedMethod(Lde/robv/android/xposed/XC_MethodHook$MethodHookParam;)V
    .locals 2
    .param p1, "param"    # Lde/robv/android/xposed/XC_MethodHook$MethodHookParam;

    .line 13785
    iget-object v0, p1, Lde/robv/android/xposed/XC_MethodHook$MethodHookParam;->args:[Ljava/lang/Object;

    if-eqz v0, :cond_0

    iget-object v0, p1, Lde/robv/android/xposed/XC_MethodHook$MethodHookParam;->args:[Ljava/lang/Object;

    array-length v0, v0

    const/4 v1, 0x3

    if-lt v0, v1, :cond_0

    .line 13786
    iget-object v0, p1, Lde/robv/android/xposed/XC_MethodHook$MethodHookParam;->args:[Ljava/lang/Object;

    const/4 v1, 0x2

    aget-object v0, v0, v1

    goto :goto_0

    :cond_0
    const/4 v0, 0x0

    .line 13787
    .local v0, "module":Ljava/lang/Object;
    :goto_0
    invoke-static {v0}, Llocal/mio/os4camerabridge/HookEntry;->-$$Nest$smmoduleKeepsOplusLogicalSat(Ljava/lang/Object;)Z

    move-result v1

    if-eqz v1, :cond_1

    .line 13788
    const-string v1, "continuous"

    invoke-static {v0, v1}, Llocal/mio/os4camerabridge/HookEntry;->-$$Nest$smlogLogicalLensOwnership(Ljava/lang/Object;Ljava/lang/String;)V

    .line 13789
    const/4 v1, 0x0

    invoke-static {v1}, Ljava/lang/Boolean;->valueOf(Z)Ljava/lang/Boolean;

    move-result-object v1

    invoke-virtual {p1, v1}, Lde/robv/android/xposed/XC_MethodHook$MethodHookParam;->setResult(Ljava/lang/Object;)V

    .line 13791
    :cond_1
    return-void
.end method
