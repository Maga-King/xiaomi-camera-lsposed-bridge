.class public final synthetic Llocal/mio/os4camerabridge/HookEntry$7$$ExternalSyntheticLambda2;
.super Ljava/lang/Object;
.source "D8$$SyntheticClass"

# interfaces
.implements Ljava/lang/Runnable;


# annotations
.annotation runtime Lcom/android/tools/r8/annotations/LambdaMethod;
    holder = "Llocal/mio/os4camerabridge/HookEntry$7;"
    method = "lambda$afterHookedMethod$3"
    proto = "(Lde/robv/android/xposed/XC_MethodHook$MethodHookParam;[Ljava/lang/Object;Landroid/os/Handler;)V"
.end annotation

.annotation build Lcom/android/tools/r8/annotations/SynthesizedClassV2;
    apiLevel = -0x2
    kind = 0x13
    versionHash = "9aaf5f34c4c84da429ef7f8f6217a1817876f2618cfcf539aba3d7d5a0c703e0"
.end annotation


# instance fields
.field public final synthetic f$0:Lde/robv/android/xposed/XC_MethodHook$MethodHookParam;

.field public final synthetic f$1:[Ljava/lang/Object;

.field public final synthetic f$2:Landroid/os/Handler;


# direct methods
.method public synthetic constructor <init>(Lde/robv/android/xposed/XC_MethodHook$MethodHookParam;[Ljava/lang/Object;Landroid/os/Handler;)V
    .locals 0

    .line 0
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    iput-object p1, p0, Llocal/mio/os4camerabridge/HookEntry$7$$ExternalSyntheticLambda2;->f$0:Lde/robv/android/xposed/XC_MethodHook$MethodHookParam;

    iput-object p2, p0, Llocal/mio/os4camerabridge/HookEntry$7$$ExternalSyntheticLambda2;->f$1:[Ljava/lang/Object;

    iput-object p3, p0, Llocal/mio/os4camerabridge/HookEntry$7$$ExternalSyntheticLambda2;->f$2:Landroid/os/Handler;

    return-void
.end method


# virtual methods
.method public final run()V
    .locals 3

    .line 0
    iget-object v0, p0, Llocal/mio/os4camerabridge/HookEntry$7$$ExternalSyntheticLambda2;->f$0:Lde/robv/android/xposed/XC_MethodHook$MethodHookParam;

    iget-object v1, p0, Llocal/mio/os4camerabridge/HookEntry$7$$ExternalSyntheticLambda2;->f$1:[Ljava/lang/Object;

    iget-object v2, p0, Llocal/mio/os4camerabridge/HookEntry$7$$ExternalSyntheticLambda2;->f$2:Landroid/os/Handler;

    invoke-static {v0, v1, v2}, Llocal/mio/os4camerabridge/HookEntry$7;->lambda$afterHookedMethod$3(Lde/robv/android/xposed/XC_MethodHook$MethodHookParam;[Ljava/lang/Object;Landroid/os/Handler;)V

    return-void
.end method
