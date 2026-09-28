.class Llocal/mio/os4camerabridge/LegendaryWatermarkBridge$2;
.super Lde/robv/android/xposed/XC_MethodHook;
.source "LegendaryWatermarkBridge.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Llocal/mio/os4camerabridge/LegendaryWatermarkBridge;->install(Ljava/lang/ClassLoader;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# direct methods
.method constructor <init>()V
    .locals 0

    .line 20
    invoke-direct {p0}, Lde/robv/android/xposed/XC_MethodHook;-><init>()V

    return-void
.end method


# virtual methods
.method protected afterHookedMethod(Lde/robv/android/xposed/XC_MethodHook$MethodHookParam;)V
    .locals 1

    .line 21
    const/4 v0, 0x0

    invoke-static {p1, v0}, Llocal/mio/os4camerabridge/LegendaryWatermarkBridge;->-$$Nest$smpreserve(Lde/robv/android/xposed/XC_MethodHook$MethodHookParam;I)V

    return-void
.end method
