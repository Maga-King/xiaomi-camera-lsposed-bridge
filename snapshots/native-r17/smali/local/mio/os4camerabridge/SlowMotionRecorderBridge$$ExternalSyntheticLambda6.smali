.class public final synthetic Llocal/mio/os4camerabridge/SlowMotionRecorderBridge$$ExternalSyntheticLambda6;
.super Ljava/lang/Object;
.source "D8$$SyntheticClass"

# interfaces
.implements Ljava/util/function/Predicate;


# instance fields
.field public final synthetic f$0:Ljava/lang/String;


# direct methods
.method public synthetic constructor <init>(Ljava/lang/String;)V
    .locals 0

    .line 0
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    iput-object p1, p0, Llocal/mio/os4camerabridge/SlowMotionRecorderBridge$$ExternalSyntheticLambda6;->f$0:Ljava/lang/String;

    return-void
.end method


# virtual methods
.method public final test(Ljava/lang/Object;)Z
    .locals 1

    .line 0
    iget-object v0, p0, Llocal/mio/os4camerabridge/SlowMotionRecorderBridge$$ExternalSyntheticLambda6;->f$0:Ljava/lang/String;

    check-cast p1, Lorg/luckypray/dexkit/result/MethodData;

    invoke-static {v0, p1}, Llocal/mio/os4camerabridge/SlowMotionRecorderBridge;->lambda$bindLockedComponent$6(Ljava/lang/String;Lorg/luckypray/dexkit/result/MethodData;)Z

    move-result p1

    return p1
.end method
