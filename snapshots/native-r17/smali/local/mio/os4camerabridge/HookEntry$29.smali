.class Llocal/mio/os4camerabridge/HookEntry$29;
.super Lde/robv/android/xposed/XC_MethodHook;
.source "HookEntry.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Llocal/mio/os4camerabridge/HookEntry;->hookFrontBeautyTypeCompatibility(Ljava/lang/ClassLoader;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# direct methods
.method constructor <init>()V
    .locals 0

    .line 7265
    invoke-direct {p0}, Lde/robv/android/xposed/XC_MethodHook;-><init>()V

    return-void
.end method


# virtual methods
.method protected afterHookedMethod(Lde/robv/android/xposed/XC_MethodHook$MethodHookParam;)V
    .locals 2
    .param p1, "param"    # Lde/robv/android/xposed/XC_MethodHook$MethodHookParam;

    .line 7268
    invoke-virtual {p1}, Lde/robv/android/xposed/XC_MethodHook$MethodHookParam;->getResult()Ljava/lang/Object;

    move-result-object v0

    .line 7269
    .local v0, "item":Ljava/lang/Object;
    invoke-static {v0}, Llocal/mio/os4camerabridge/HookEntry;->-$$Nest$smrewriteLegacyBeautyItem(Ljava/lang/Object;)Z

    move-result v1

    if-eqz v1, :cond_0

    .line 7270
    const-string v1, "[BeautyCompat] legacy item factory 1 -> 2"

    invoke-static {v1}, Llocal/mio/os4camerabridge/HookEntry;->-$$Nest$smlog(Ljava/lang/String;)V

    .line 7272
    :cond_0
    return-void
.end method
