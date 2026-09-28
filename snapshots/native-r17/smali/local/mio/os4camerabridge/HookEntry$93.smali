.class Llocal/mio/os4camerabridge/HookEntry$93;
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

    .line 13827
    invoke-direct {p0}, Lde/robv/android/xposed/XC_MethodHook;-><init>()V

    return-void
.end method


# virtual methods
.method protected afterHookedMethod(Lde/robv/android/xposed/XC_MethodHook$MethodHookParam;)V
    .locals 2
    .param p1, "param"    # Lde/robv/android/xposed/XC_MethodHook$MethodHookParam;

    .line 13831
    iget-object v0, p1, Lde/robv/android/xposed/XC_MethodHook$MethodHookParam;->thisObject:Ljava/lang/Object;

    invoke-static {v0}, Llocal/mio/os4camerabridge/HookEntry;->-$$Nest$smzoomManagerModule(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0

    .line 13833
    .local v0, "module":Ljava/lang/Object;
    invoke-static {v0}, Llocal/mio/os4camerabridge/HookEntry;->-$$Nest$smmoduleKeepsOplusLogicalSat(Ljava/lang/Object;)Z

    move-result v1

    if-eqz v1, :cond_0

    .line 13834
    const/4 v1, 0x0

    invoke-static {v1}, Ljava/lang/Boolean;->valueOf(Z)Ljava/lang/Boolean;

    move-result-object v1

    invoke-virtual {p1, v1}, Lde/robv/android/xposed/XC_MethodHook$MethodHookParam;->setResult(Ljava/lang/Object;)V

    .line 13836
    :cond_0
    return-void
.end method
