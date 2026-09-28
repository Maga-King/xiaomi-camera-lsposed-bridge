.class Llocal/mio/os4camerabridge/HookEntry$59;
.super Lde/robv/android/xposed/XC_MethodHook;
.source "HookEntry.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Llocal/mio/os4camerabridge/HookEntry;->hookHighPixelModeAvailability(Ljava/lang/ClassLoader;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic val$loader:Ljava/lang/ClassLoader;


# direct methods
.method constructor <init>(Ljava/lang/ClassLoader;)V
    .locals 0

    .line 9221
    iput-object p1, p0, Llocal/mio/os4camerabridge/HookEntry$59;->val$loader:Ljava/lang/ClassLoader;

    invoke-direct {p0}, Lde/robv/android/xposed/XC_MethodHook;-><init>()V

    return-void
.end method


# virtual methods
.method protected afterHookedMethod(Lde/robv/android/xposed/XC_MethodHook$MethodHookParam;)V
    .locals 8
    .param p1, "param"    # Lde/robv/android/xposed/XC_MethodHook$MethodHookParam;

    .line 9224
    invoke-virtual {p1}, Lde/robv/android/xposed/XC_MethodHook$MethodHookParam;->getResult()Ljava/lang/Object;

    move-result-object v0

    .line 9225
    .local v0, "original":Ljava/lang/Object;
    const-string v1, "unavailable"

    .line 9227
    .local v1, "featureDescription":Ljava/lang/String;
    :try_start_0
    invoke-static {}, Llocal/mio/os4camerabridge/DexKitCameraContracts;->describeFeature()Ljava/lang/String;

    move-result-object v6
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 9239
    .end local v1    # "featureDescription":Ljava/lang/String;
    .end local v2
    .end local v3
    .end local v4
    .end local v5
    .local v6, "featureDescription":Ljava/lang/String;
    goto :goto_0

    .line 9237
    .end local v6    # "featureDescription":Ljava/lang/String;
    .restart local v1    # "featureDescription":Ljava/lang/String;
    :catchall_0
    move-exception v2

    .line 9238
    .local v2, "throwable":Ljava/lang/Throwable;
    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    const-string v4, "probe failed: "

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v6

    .line 9240
    .end local v1    # "featureDescription":Ljava/lang/String;
    .end local v2    # "throwable":Ljava/lang/Throwable;
    .restart local v6    # "featureDescription":Ljava/lang/String;
    :goto_0
    const/4 v1, 0x1

    invoke-static {v1}, Ljava/lang/Boolean;->valueOf(Z)Ljava/lang/Boolean;

    move-result-object v1

    invoke-virtual {p1, v1}, Lde/robv/android/xposed/XC_MethodHook$MethodHookParam;->setResult(Ljava/lang/Object;)V

    .line 9241
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "[HighPixelContract] entry original="

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, " forced=true feature="

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-static {v1}, Llocal/mio/os4camerabridge/HookEntry;->-$$Nest$smlog(Ljava/lang/String;)V

    .line 9243
    return-void
.end method
