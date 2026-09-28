.class public final synthetic Llocal/mio/os4camerabridge/HookEntry$$ExternalSyntheticLambda68;
.super Ljava/lang/Object;
.source "D8$$SyntheticClass"

# interfaces
.implements Ljava/lang/Runnable;


# annotations
.annotation runtime Lcom/android/tools/r8/annotations/LambdaMethod;
    holder = "Llocal/mio/os4camerabridge/HookEntry;"
    method = "lambda$invalidateCommonApsClient$58"
    proto = "(Ljava/lang/Object;Ljava/lang/String;I)V"
.end annotation

.annotation build Lcom/android/tools/r8/annotations/SynthesizedClassV2;
    apiLevel = -0x2
    kind = 0x13
    versionHash = "9aaf5f34c4c84da429ef7f8f6217a1817876f2618cfcf539aba3d7d5a0c703e0"
.end annotation


# instance fields
.field public final synthetic f$0:Ljava/lang/Object;

.field public final synthetic f$1:Ljava/lang/String;

.field public final synthetic f$2:I


# direct methods
.method public synthetic constructor <init>(Ljava/lang/Object;Ljava/lang/String;I)V
    .locals 0

    .line 0
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    iput-object p1, p0, Llocal/mio/os4camerabridge/HookEntry$$ExternalSyntheticLambda68;->f$0:Ljava/lang/Object;

    iput-object p2, p0, Llocal/mio/os4camerabridge/HookEntry$$ExternalSyntheticLambda68;->f$1:Ljava/lang/String;

    iput p3, p0, Llocal/mio/os4camerabridge/HookEntry$$ExternalSyntheticLambda68;->f$2:I

    return-void
.end method


# virtual methods
.method public final run()V
    .locals 3

    .line 0
    iget-object v0, p0, Llocal/mio/os4camerabridge/HookEntry$$ExternalSyntheticLambda68;->f$0:Ljava/lang/Object;

    iget-object v1, p0, Llocal/mio/os4camerabridge/HookEntry$$ExternalSyntheticLambda68;->f$1:Ljava/lang/String;

    iget v2, p0, Llocal/mio/os4camerabridge/HookEntry$$ExternalSyntheticLambda68;->f$2:I

    invoke-static {v0, v1, v2}, Llocal/mio/os4camerabridge/HookEntry;->lambda$invalidateCommonApsClient$58(Ljava/lang/Object;Ljava/lang/String;I)V

    return-void
.end method
