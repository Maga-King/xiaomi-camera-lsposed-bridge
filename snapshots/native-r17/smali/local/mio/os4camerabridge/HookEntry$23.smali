.class Llocal/mio/os4camerabridge/HookEntry$23;
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

    .line 6506
    invoke-direct {p0}, Lde/robv/android/xposed/XC_MethodHook;-><init>()V

    return-void
.end method


# virtual methods
.method protected beforeHookedMethod(Lde/robv/android/xposed/XC_MethodHook$MethodHookParam;)V
    .locals 2
    .param p1, "param"    # Lde/robv/android/xposed/XC_MethodHook$MethodHookParam;

    .line 6509
    invoke-static {p1}, Llocal/mio/os4camerabridge/HookEntry;->-$$Nest$smisLegendaryComponentCall(Lde/robv/android/xposed/XC_MethodHook$MethodHookParam;)Z

    move-result v0

    if-eqz v0, :cond_0

    iget-object v0, p1, Lde/robv/android/xposed/XC_MethodHook$MethodHookParam;->args:[Ljava/lang/Object;

    array-length v0, v0

    const/4 v1, 0x2

    if-lt v0, v1, :cond_0

    .line 6511
    iget-object v0, p1, Lde/robv/android/xposed/XC_MethodHook$MethodHookParam;->args:[Ljava/lang/Object;

    const/4 v1, 0x1

    aget-object v0, v0, v1

    const-string v1, "component-write"

    invoke-static {v0, v1}, Llocal/mio/os4camerabridge/HookEntry;->-$$Nest$smupdateActiveLegendMode(Ljava/lang/Object;Ljava/lang/String;)V

    .line 6514
    :cond_0
    return-void
.end method
