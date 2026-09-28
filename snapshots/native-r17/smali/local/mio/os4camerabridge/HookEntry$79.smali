.class Llocal/mio/os4camerabridge/HookEntry$79;
.super Lde/robv/android/xposed/XC_MethodReplacement;
.source "HookEntry.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Llocal/mio/os4camerabridge/HookEntry;->hookLegacyJpeg(Ljava/lang/ClassLoader;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# direct methods
.method constructor <init>()V
    .locals 0

    .line 13247
    invoke-direct {p0}, Lde/robv/android/xposed/XC_MethodReplacement;-><init>()V

    return-void
.end method


# virtual methods
.method protected replaceHookedMethod(Lde/robv/android/xposed/XC_MethodHook$MethodHookParam;)Ljava/lang/Object;
    .locals 1
    .param p1, "param"    # Lde/robv/android/xposed/XC_MethodHook$MethodHookParam;

    .line 13250
    invoke-static {}, Llocal/mio/os4camerabridge/HookEntry;->-$$Nest$sfgetloggedMivi()Z

    move-result v0

    if-nez v0, :cond_0

    .line 13251
    const/4 v0, 0x1

    invoke-static {v0}, Llocal/mio/os4camerabridge/HookEntry;->-$$Nest$sfputloggedMivi(Z)V

    .line 13252
    const-string v0, "[CaptureRoute] Je.b.b1 MIVI2 -> false"

    invoke-static {v0}, Llocal/mio/os4camerabridge/HookEntry;->-$$Nest$smlog(Ljava/lang/String;)V

    .line 13254
    :cond_0
    const/4 v0, 0x0

    invoke-static {v0}, Ljava/lang/Boolean;->valueOf(Z)Ljava/lang/Boolean;

    move-result-object v0

    return-object v0
.end method
