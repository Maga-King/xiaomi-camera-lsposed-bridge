.class final Llocal/mio/os4camerabridge/HookEntry$LeicaTriggerBlend;
.super Ljava/lang/Object;
.source "HookEntry.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Llocal/mio/os4camerabridge/HookEntry;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x1a
    name = "LeicaTriggerBlend"
.end annotation


# instance fields
.field final indices:[I

.field final weights:[F


# direct methods
.method constructor <init>([I[F)V
    .locals 0
    .param p1, "indices"    # [I
    .param p2, "weights"    # [F

    .line 12344
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 12345
    iput-object p1, p0, Llocal/mio/os4camerabridge/HookEntry$LeicaTriggerBlend;->indices:[I

    .line 12346
    iput-object p2, p0, Llocal/mio/os4camerabridge/HookEntry$LeicaTriggerBlend;->weights:[F

    .line 12347
    return-void
.end method
