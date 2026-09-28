.class public final synthetic Llocal/mio/os4camerabridge/HookEntry$$ExternalSyntheticLambda55;
.super Ljava/lang/Object;
.source "D8$$SyntheticClass"

# interfaces
.implements Ljava/lang/Runnable;


# annotations
.annotation runtime Lcom/android/tools/r8/annotations/LambdaMethod;
    holder = "Llocal/mio/os4camerabridge/HookEntry;"
    method = "lambda$startFullOplusSessionHandoffProbe$42"
    proto = "(IZ)V"
.end annotation

.annotation build Lcom/android/tools/r8/annotations/SynthesizedClassV2;
    apiLevel = -0x2
    kind = 0x13
    versionHash = "9aaf5f34c4c84da429ef7f8f6217a1817876f2618cfcf539aba3d7d5a0c703e0"
.end annotation


# instance fields
.field public final synthetic f$0:I

.field public final synthetic f$1:Z


# direct methods
.method public synthetic constructor <init>(IZ)V
    .locals 0

    .line 0
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    iput p1, p0, Llocal/mio/os4camerabridge/HookEntry$$ExternalSyntheticLambda55;->f$0:I

    iput-boolean p2, p0, Llocal/mio/os4camerabridge/HookEntry$$ExternalSyntheticLambda55;->f$1:Z

    return-void
.end method


# virtual methods
.method public final run()V
    .locals 2

    .line 0
    iget v0, p0, Llocal/mio/os4camerabridge/HookEntry$$ExternalSyntheticLambda55;->f$0:I

    iget-boolean v1, p0, Llocal/mio/os4camerabridge/HookEntry$$ExternalSyntheticLambda55;->f$1:Z

    invoke-static {v0, v1}, Llocal/mio/os4camerabridge/HookEntry;->lambda$startFullOplusSessionHandoffProbe$42(IZ)V

    return-void
.end method
