.class public final synthetic Llocal/mio/os4camerabridge/SlowMotionRecorderBridge$$ExternalSyntheticLambda2;
.super Ljava/lang/Object;
.source "D8$$SyntheticClass"

# interfaces
.implements Ljava/util/function/Predicate;


# instance fields
.field public final synthetic f$0:Ljava/util/Set;

.field public final synthetic f$1:Ljava/lang/ClassLoader;

.field public final synthetic f$2:Ljava/lang/Class;


# direct methods
.method public synthetic constructor <init>(Ljava/util/Set;Ljava/lang/ClassLoader;Ljava/lang/Class;)V
    .locals 0

    .line 0
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    iput-object p1, p0, Llocal/mio/os4camerabridge/SlowMotionRecorderBridge$$ExternalSyntheticLambda2;->f$0:Ljava/util/Set;

    iput-object p2, p0, Llocal/mio/os4camerabridge/SlowMotionRecorderBridge$$ExternalSyntheticLambda2;->f$1:Ljava/lang/ClassLoader;

    iput-object p3, p0, Llocal/mio/os4camerabridge/SlowMotionRecorderBridge$$ExternalSyntheticLambda2;->f$2:Ljava/lang/Class;

    return-void
.end method


# virtual methods
.method public final test(Ljava/lang/Object;)Z
    .locals 3

    .line 0
    iget-object v0, p0, Llocal/mio/os4camerabridge/SlowMotionRecorderBridge$$ExternalSyntheticLambda2;->f$0:Ljava/util/Set;

    iget-object v1, p0, Llocal/mio/os4camerabridge/SlowMotionRecorderBridge$$ExternalSyntheticLambda2;->f$1:Ljava/lang/ClassLoader;

    iget-object v2, p0, Llocal/mio/os4camerabridge/SlowMotionRecorderBridge$$ExternalSyntheticLambda2;->f$2:Ljava/lang/Class;

    check-cast p1, Lorg/luckypray/dexkit/result/MethodData;

    invoke-static {v0, v1, v2, p1}, Llocal/mio/os4camerabridge/SlowMotionRecorderBridge;->lambda$bind$4(Ljava/util/Set;Ljava/lang/ClassLoader;Ljava/lang/Class;Lorg/luckypray/dexkit/result/MethodData;)Z

    move-result p1

    return p1
.end method
