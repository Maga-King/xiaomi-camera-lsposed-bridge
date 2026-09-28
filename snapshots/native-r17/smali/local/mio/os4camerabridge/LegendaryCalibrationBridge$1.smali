.class Llocal/mio/os4camerabridge/LegendaryCalibrationBridge$1;
.super Lde/robv/android/xposed/XC_MethodHook;
.source "LegendaryCalibrationBridge.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Llocal/mio/os4camerabridge/LegendaryCalibrationBridge;->install()V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# direct methods
.method constructor <init>()V
    .locals 0

    .line 27
    invoke-direct {p0}, Lde/robv/android/xposed/XC_MethodHook;-><init>()V

    return-void
.end method


# virtual methods
.method protected afterHookedMethod(Lde/robv/android/xposed/XC_MethodHook$MethodHookParam;)V
    .locals 0

    .line 33
    invoke-static {}, Llocal/mio/os4camerabridge/LegendaryCalibrationBridge;->-$$Nest$sfgetCCT()Ljava/lang/ThreadLocal;

    move-result-object p1

    invoke-virtual {p1}, Ljava/lang/ThreadLocal;->remove()V

    return-void
.end method

.method protected beforeHookedMethod(Lde/robv/android/xposed/XC_MethodHook$MethodHookParam;)V
    .locals 2

    .line 29
    invoke-static {}, Llocal/mio/os4camerabridge/LegendaryCalibrationBridge;->-$$Nest$sfgetCCT()Ljava/lang/ThreadLocal;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/ThreadLocal;->remove()V

    .line 30
    invoke-static {}, Llocal/mio/os4camerabridge/LegendaryNativeCaptureBridge;->matrixEnabledForContainer()Z

    move-result v0

    if-eqz v0, :cond_0

    .line 31
    invoke-static {}, Llocal/mio/os4camerabridge/LegendaryCalibrationBridge;->-$$Nest$sfgetCCT()Ljava/lang/ThreadLocal;

    move-result-object v0

    iget-object p1, p1, Lde/robv/android/xposed/XC_MethodHook$MethodHookParam;->args:[Ljava/lang/Object;

    const/4 v1, 0x4

    aget-object p1, p1, v1

    const-string v1, "cct"

    invoke-static {p1, v1}, Lde/robv/android/xposed/XposedHelpers;->getIntField(Ljava/lang/Object;Ljava/lang/String;)I

    move-result p1

    invoke-static {p1}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object p1

    invoke-virtual {v0, p1}, Ljava/lang/ThreadLocal;->set(Ljava/lang/Object;)V

    .line 32
    :cond_0
    return-void
.end method
