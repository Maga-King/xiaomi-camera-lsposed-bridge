.class public final synthetic Llocal/mio/os4camerabridge/BeautyPanelContractBridge$$ExternalSyntheticLambda0;
.super Ljava/lang/Object;
.source "D8$$SyntheticClass"

# interfaces
.implements Ljava/util/function/Predicate;


# instance fields
.field public final synthetic f$0:Ljava/lang/reflect/Field;


# direct methods
.method public synthetic constructor <init>(Ljava/lang/reflect/Field;)V
    .locals 0

    .line 0
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    iput-object p1, p0, Llocal/mio/os4camerabridge/BeautyPanelContractBridge$$ExternalSyntheticLambda0;->f$0:Ljava/lang/reflect/Field;

    return-void
.end method


# virtual methods
.method public final test(Ljava/lang/Object;)Z
    .locals 1

    .line 0
    iget-object v0, p0, Llocal/mio/os4camerabridge/BeautyPanelContractBridge$$ExternalSyntheticLambda0;->f$0:Ljava/lang/reflect/Field;

    check-cast p1, Lorg/luckypray/dexkit/result/UsingFieldData;

    invoke-static {v0, p1}, Llocal/mio/os4camerabridge/BeautyPanelContractBridge;->lambda$bind$0(Ljava/lang/reflect/Field;Lorg/luckypray/dexkit/result/UsingFieldData;)Z

    move-result p1

    return p1
.end method
