.class public final synthetic Llocal/mio/os4camerabridge/LegendaryNativeCaptureBridge$$ExternalSyntheticLambda0;
.super Ljava/lang/Object;
.source "D8$$SyntheticClass"

# interfaces
.implements Ljava/util/function/Predicate;


# direct methods
.method public synthetic constructor <init>()V
    .locals 0

    .line 0
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public final test(Ljava/lang/Object;)Z
    .locals 0

    .line 0
    check-cast p1, Llocal/mio/os4camerabridge/LegendaryNativeCaptureBridge$Capture;

    invoke-static {p1}, Llocal/mio/os4camerabridge/LegendaryNativeCaptureBridge;->lambda$prune$0(Llocal/mio/os4camerabridge/LegendaryNativeCaptureBridge$Capture;)Z

    move-result p1

    return p1
.end method
