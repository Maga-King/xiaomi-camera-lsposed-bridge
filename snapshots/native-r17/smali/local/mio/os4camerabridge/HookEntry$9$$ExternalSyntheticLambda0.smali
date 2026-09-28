.class public final synthetic Llocal/mio/os4camerabridge/HookEntry$9$$ExternalSyntheticLambda0;
.super Ljava/lang/Object;
.source "D8$$SyntheticClass"

# interfaces
.implements Ljava/lang/Runnable;


# annotations
.annotation runtime Lcom/android/tools/r8/annotations/LambdaMethod;
    holder = "Llocal/mio/os4camerabridge/HookEntry$9;"
    method = "lambda$onConfigured$0"
    proto = "(I)V"
.end annotation

.annotation build Lcom/android/tools/r8/annotations/SynthesizedClassV2;
    apiLevel = -0x2
    kind = 0x13
    versionHash = "9aaf5f34c4c84da429ef7f8f6217a1817876f2618cfcf539aba3d7d5a0c703e0"
.end annotation


# instance fields
.field public final synthetic f$0:I


# direct methods
.method public synthetic constructor <init>(I)V
    .locals 0

    .line 0
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    iput p1, p0, Llocal/mio/os4camerabridge/HookEntry$9$$ExternalSyntheticLambda0;->f$0:I

    return-void
.end method


# virtual methods
.method public final run()V
    .locals 1

    .line 0
    iget v0, p0, Llocal/mio/os4camerabridge/HookEntry$9$$ExternalSyntheticLambda0;->f$0:I

    invoke-static {v0}, Llocal/mio/os4camerabridge/HookEntry$9;->lambda$onConfigured$0(I)V

    return-void
.end method
