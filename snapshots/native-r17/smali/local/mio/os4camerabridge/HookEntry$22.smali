.class Llocal/mio/os4camerabridge/HookEntry$22;
.super Lde/robv/android/xposed/XC_MethodHook;
.source "HookEntry.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Llocal/mio/os4camerabridge/HookEntry;->hookLegendaryMode(Ljava/lang/ClassLoader;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# direct methods
.method constructor <init>()V
    .locals 0

    .line 6496
    invoke-direct {p0}, Lde/robv/android/xposed/XC_MethodHook;-><init>()V

    return-void
.end method


# virtual methods
.method protected afterHookedMethod(Lde/robv/android/xposed/XC_MethodHook$MethodHookParam;)V
    .locals 2
    .param p1, "param"    # Lde/robv/android/xposed/XC_MethodHook$MethodHookParam;

    .line 6499
    invoke-static {p1}, Llocal/mio/os4camerabridge/HookEntry;->-$$Nest$smisLegendaryComponentCall(Lde/robv/android/xposed/XC_MethodHook$MethodHookParam;)Z

    move-result v0

    if-eqz v0, :cond_0

    .line 6500
    invoke-virtual {p1}, Lde/robv/android/xposed/XC_MethodHook$MethodHookParam;->getResult()Ljava/lang/Object;

    move-result-object v0

    const-string v1, "component-read"

    invoke-static {v0, v1}, Llocal/mio/os4camerabridge/HookEntry;->-$$Nest$smupdateActiveLegendMode(Ljava/lang/Object;Ljava/lang/String;)V

    .line 6503
    :cond_0
    return-void
.end method
