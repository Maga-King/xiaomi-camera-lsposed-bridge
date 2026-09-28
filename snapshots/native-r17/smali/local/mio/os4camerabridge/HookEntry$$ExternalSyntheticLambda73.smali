.class public final synthetic Llocal/mio/os4camerabridge/HookEntry$$ExternalSyntheticLambda73;
.super Ljava/lang/Object;
.source "D8$$SyntheticClass"

# interfaces
.implements Ljava/lang/Runnable;


# annotations
.annotation runtime Lcom/android/tools/r8/annotations/LambdaMethod;
    holder = "Llocal/mio/os4camerabridge/HookEntry;"
    method = "lambda$startCommonApsHandoffCapture$43"
    proto = "(ILjava/util/concurrent/atomic/AtomicBoolean;[I)V"
.end annotation

.annotation build Lcom/android/tools/r8/annotations/SynthesizedClassV2;
    apiLevel = -0x2
    kind = 0x13
    versionHash = "9aaf5f34c4c84da429ef7f8f6217a1817876f2618cfcf539aba3d7d5a0c703e0"
.end annotation


# instance fields
.field public final synthetic f$0:I

.field public final synthetic f$1:Ljava/util/concurrent/atomic/AtomicBoolean;

.field public final synthetic f$2:[I


# direct methods
.method public synthetic constructor <init>(ILjava/util/concurrent/atomic/AtomicBoolean;[I)V
    .locals 0

    .line 0
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    iput p1, p0, Llocal/mio/os4camerabridge/HookEntry$$ExternalSyntheticLambda73;->f$0:I

    iput-object p2, p0, Llocal/mio/os4camerabridge/HookEntry$$ExternalSyntheticLambda73;->f$1:Ljava/util/concurrent/atomic/AtomicBoolean;

    iput-object p3, p0, Llocal/mio/os4camerabridge/HookEntry$$ExternalSyntheticLambda73;->f$2:[I

    return-void
.end method


# virtual methods
.method public final run()V
    .locals 3

    .line 0
    iget v0, p0, Llocal/mio/os4camerabridge/HookEntry$$ExternalSyntheticLambda73;->f$0:I

    iget-object v1, p0, Llocal/mio/os4camerabridge/HookEntry$$ExternalSyntheticLambda73;->f$1:Ljava/util/concurrent/atomic/AtomicBoolean;

    iget-object v2, p0, Llocal/mio/os4camerabridge/HookEntry$$ExternalSyntheticLambda73;->f$2:[I

    invoke-static {v0, v1, v2}, Llocal/mio/os4camerabridge/HookEntry;->lambda$startCommonApsHandoffCapture$43(ILjava/util/concurrent/atomic/AtomicBoolean;[I)V

    return-void
.end method
