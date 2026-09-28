.class Llocal/mio/os4camerabridge/DexKitCameraContracts$1;
.super Lde/robv/android/xposed/XC_MethodHook;
.source "DexKitCameraContracts.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Llocal/mio/os4camerabridge/DexKitCameraContracts;->install(Ljava/lang/ClassLoader;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic val$hostLoader:Ljava/lang/ClassLoader;


# direct methods
.method constructor <init>(Ljava/lang/ClassLoader;)V
    .locals 0

    .line 31
    iput-object p1, p0, Llocal/mio/os4camerabridge/DexKitCameraContracts$1;->val$hostLoader:Ljava/lang/ClassLoader;

    invoke-direct {p0}, Lde/robv/android/xposed/XC_MethodHook;-><init>()V

    return-void
.end method


# virtual methods
.method protected afterHookedMethod(Lde/robv/android/xposed/XC_MethodHook$MethodHookParam;)V
    .locals 3

    .line 33
    iget-object p1, p1, Lde/robv/android/xposed/XC_MethodHook$MethodHookParam;->args:[Ljava/lang/Object;

    const/4 v0, 0x0

    aget-object p1, p1, v0

    check-cast p1, Landroid/content/Context;

    .line 34
    const-string v1, "com.android.camera"

    invoke-virtual {p1}, Landroid/content/Context;->getPackageName()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-eqz v1, :cond_1

    invoke-static {}, Llocal/mio/os4camerabridge/DexKitCameraContracts;->-$$Nest$sfgetstarted()Ljava/util/concurrent/atomic/AtomicBoolean;

    move-result-object v1

    const/4 v2, 0x1

    invoke-virtual {v1, v0, v2}, Ljava/util/concurrent/atomic/AtomicBoolean;->compareAndSet(ZZ)Z

    move-result v0

    if-nez v0, :cond_0

    goto :goto_0

    .line 35
    :cond_0
    iget-object v0, p0, Llocal/mio/os4camerabridge/DexKitCameraContracts$1;->val$hostLoader:Ljava/lang/ClassLoader;

    invoke-static {p1, v0}, Llocal/mio/os4camerabridge/DexKitCameraContracts;->-$$Nest$smresolve(Landroid/content/Context;Ljava/lang/ClassLoader;)V

    .line 36
    return-void

    .line 34
    :cond_1
    :goto_0
    return-void
.end method
