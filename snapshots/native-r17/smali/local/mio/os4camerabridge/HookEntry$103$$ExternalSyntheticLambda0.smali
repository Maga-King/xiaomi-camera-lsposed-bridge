.class public final synthetic Llocal/mio/os4camerabridge/HookEntry$103$$ExternalSyntheticLambda0;
.super Ljava/lang/Object;
.source "D8$$SyntheticClass"

# interfaces
.implements Ljava/util/function/Predicate;


# annotations
.annotation runtime Lcom/android/tools/r8/annotations/LambdaMethod;
    holder = "Llocal/mio/os4camerabridge/HookEntry$103;"
    method = "lambda$afterHookedMethod$0"
    proto = "(JLjava/lang/Long;)Z"
.end annotation

.annotation build Lcom/android/tools/r8/annotations/SynthesizedClassV2;
    apiLevel = -0x2
    kind = 0x13
    versionHash = "9aaf5f34c4c84da429ef7f8f6217a1817876f2618cfcf539aba3d7d5a0c703e0"
.end annotation


# instance fields
.field public final synthetic f$0:J


# direct methods
.method public synthetic constructor <init>(J)V
    .locals 0

    .line 0
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    iput-wide p1, p0, Llocal/mio/os4camerabridge/HookEntry$103$$ExternalSyntheticLambda0;->f$0:J

    return-void
.end method


# virtual methods
.method public final test(Ljava/lang/Object;)Z
    .locals 2

    .line 0
    iget-wide v0, p0, Llocal/mio/os4camerabridge/HookEntry$103$$ExternalSyntheticLambda0;->f$0:J

    check-cast p1, Ljava/lang/Long;

    invoke-static {v0, v1, p1}, Llocal/mio/os4camerabridge/HookEntry$103;->lambda$afterHookedMethod$0(JLjava/lang/Long;)Z

    move-result p1

    return p1
.end method
