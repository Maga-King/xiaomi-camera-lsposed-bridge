.class Llocal/mio/os4camerabridge/RearLivePhotoBridge$1;
.super Lde/robv/android/xposed/XC_MethodHook;
.source "RearLivePhotoBridge.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Llocal/mio/os4camerabridge/RearLivePhotoBridge;->install(Ljava/lang/ClassLoader;)V
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

    .line 33
    iput-object p1, p0, Llocal/mio/os4camerabridge/RearLivePhotoBridge$1;->val$loader:Ljava/lang/ClassLoader;

    invoke-direct {p0}, Lde/robv/android/xposed/XC_MethodHook;-><init>()V

    return-void
.end method


# virtual methods
.method protected afterHookedMethod(Lde/robv/android/xposed/XC_MethodHook$MethodHookParam;)V
    .locals 2

    .line 35
    iget-object p1, p1, Lde/robv/android/xposed/XC_MethodHook$MethodHookParam;->args:[Ljava/lang/Object;

    const/4 v0, 0x0

    aget-object p1, p1, v0

    check-cast p1, Landroid/content/Context;

    .line 36
    const-string v0, "com.android.camera"

    invoke-virtual {p1}, Landroid/content/Context;->getPackageName()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_0

    iget-object v0, p0, Llocal/mio/os4camerabridge/RearLivePhotoBridge$1;->val$loader:Ljava/lang/ClassLoader;

    invoke-static {p1, v0}, Llocal/mio/os4camerabridge/RearLivePhotoBridge;->-$$Nest$smresolve(Landroid/content/Context;Ljava/lang/ClassLoader;)V

    .line 37
    :cond_0
    return-void
.end method
