.class Llocal/mio/os4camerabridge/LegendaryWatermarkBridge$1;
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

    .line 15
    invoke-direct {p0}, Lde/robv/android/xposed/XC_MethodHook;-><init>()V

    return-void
.end method


# virtual methods
.method protected afterHookedMethod(Lde/robv/android/xposed/XC_MethodHook$MethodHookParam;)V
    .locals 3

    .line 17
    iget-object v0, p1, Lde/robv/android/xposed/XC_MethodHook$MethodHookParam;->args:[Ljava/lang/Object;

    const/4 v1, 0x1

    aget-object v0, v0, v1

    check-cast v0, [B

    array-length v0, v0

    iget-object v1, p1, Lde/robv/android/xposed/XC_MethodHook$MethodHookParam;->args:[Ljava/lang/Object;

    const/4 v2, 0x2

    aget-object v1, v1, v2

    check-cast v1, [B

    array-length v1, v1

    add-int/2addr v0, v1

    invoke-static {p1, v0}, Llocal/mio/os4camerabridge/LegendaryWatermarkBridge;->-$$Nest$smpreserve(Lde/robv/android/xposed/XC_MethodHook$MethodHookParam;I)V

    .line 18
    return-void
.end method
