.class Llocal/mio/os4camerabridge/HookEntry$3;
.super Lde/robv/android/xposed/XC_MethodHook;
.source "HookEntry.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Llocal/mio/os4camerabridge/HookEntry;->hookOplusCommonPhotoBridge(Ljava/lang/ClassLoader;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# direct methods
.method constructor <init>()V
    .locals 0

    .line 1339
    invoke-direct {p0}, Lde/robv/android/xposed/XC_MethodHook;-><init>()V

    return-void
.end method


# virtual methods
.method protected afterHookedMethod(Lde/robv/android/xposed/XC_MethodHook$MethodHookParam;)V
    .locals 1
    .param p1, "param"    # Lde/robv/android/xposed/XC_MethodHook$MethodHookParam;

    .line 1342
    iget-object v0, p1, Lde/robv/android/xposed/XC_MethodHook$MethodHookParam;->thisObject:Ljava/lang/Object;

    instance-of v0, v0, Landroid/app/Application;

    if-nez v0, :cond_0

    .line 1343
    return-void

    .line 1345
    :cond_0
    iget-object v0, p1, Lde/robv/android/xposed/XC_MethodHook$MethodHookParam;->thisObject:Ljava/lang/Object;

    check-cast v0, Landroid/app/Application;

    invoke-static {v0}, Llocal/mio/os4camerabridge/HookEntry;->-$$Nest$sfputxiaomiCameraApplication(Landroid/app/Application;)V

    .line 1347
    invoke-static {}, Llocal/mio/os4camerabridge/HookEntry;->-$$Nest$smensureCommonApsInfrastructure()Z

    move-result v0

    if-eqz v0, :cond_1

    .line 1348
    invoke-static {}, Llocal/mio/os4camerabridge/HookEntry;->-$$Nest$smscheduleCommonApsInitialization()V

    .line 1350
    :cond_1
    return-void
.end method
