.class public final synthetic Llocal/mio/os4camerabridge/HookEntry$$ExternalSyntheticLambda59;
.super Ljava/lang/Object;
.source "D8$$SyntheticClass"

# interfaces
.implements Ljava/lang/reflect/InvocationHandler;


# annotations
.annotation runtime Lcom/android/tools/r8/annotations/LambdaMethod;
    holder = "Llocal/mio/os4camerabridge/HookEntry;"
    method = "lambda$prepareCommonApsClient$57"
    proto = "(ILjava/lang/Object;Ljava/lang/reflect/Method;[Ljava/lang/Object;)Ljava/lang/Object;"
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

    iput p1, p0, Llocal/mio/os4camerabridge/HookEntry$$ExternalSyntheticLambda59;->f$0:I

    return-void
.end method


# virtual methods
.method public final invoke(Ljava/lang/Object;Ljava/lang/reflect/Method;[Ljava/lang/Object;)Ljava/lang/Object;
    .locals 1

    .line 0
    iget v0, p0, Llocal/mio/os4camerabridge/HookEntry$$ExternalSyntheticLambda59;->f$0:I

    invoke-static {v0, p1, p2, p3}, Llocal/mio/os4camerabridge/HookEntry;->lambda$prepareCommonApsClient$57(ILjava/lang/Object;Ljava/lang/reflect/Method;[Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object p1

    return-object p1
.end method
