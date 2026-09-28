.class Llocal/mio/os4camerabridge/SlowMotionRecorderBridge$16;
.super Lde/robv/android/xposed/XC_MethodHook;
.source "SlowMotionRecorderBridge.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Llocal/mio/os4camerabridge/SlowMotionRecorderBridge;->bindLockedComponent(Lorg/luckypray/dexkit/DexKitBridge;Ljava/lang/ClassLoader;Ljava/lang/String;Ljava/lang/String;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic val$owner:Ljava/lang/Class;

.field final synthetic val$value:Ljava/lang/String;


# direct methods
.method constructor <init>(Ljava/lang/Class;Ljava/lang/String;)V
    .locals 0

    .line 250
    iput-object p1, p0, Llocal/mio/os4camerabridge/SlowMotionRecorderBridge$16;->val$owner:Ljava/lang/Class;

    iput-object p2, p0, Llocal/mio/os4camerabridge/SlowMotionRecorderBridge$16;->val$value:Ljava/lang/String;

    invoke-direct {p0}, Lde/robv/android/xposed/XC_MethodHook;-><init>()V

    return-void
.end method


# virtual methods
.method protected beforeHookedMethod(Lde/robv/android/xposed/XC_MethodHook$MethodHookParam;)V
    .locals 2

    .line 252
    iget-object v0, p0, Llocal/mio/os4camerabridge/SlowMotionRecorderBridge$16;->val$owner:Ljava/lang/Class;

    iget-object v1, p1, Lde/robv/android/xposed/XC_MethodHook$MethodHookParam;->thisObject:Ljava/lang/Object;

    invoke-virtual {v0, v1}, Ljava/lang/Class;->isInstance(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_0

    iget-object v0, p1, Lde/robv/android/xposed/XC_MethodHook$MethodHookParam;->args:[Ljava/lang/Object;

    const/4 v1, 0x0

    aget-object v0, v0, v1

    check-cast v0, Ljava/lang/Integer;

    invoke-virtual {v0}, Ljava/lang/Integer;->intValue()I

    move-result v0

    const/16 v1, 0xac

    if-ne v0, v1, :cond_0

    iget-object p1, p1, Lde/robv/android/xposed/XC_MethodHook$MethodHookParam;->args:[Ljava/lang/Object;

    const/4 v0, 0x1

    iget-object v1, p0, Llocal/mio/os4camerabridge/SlowMotionRecorderBridge$16;->val$value:Ljava/lang/String;

    aput-object v1, p1, v0

    .line 253
    :cond_0
    return-void
.end method
