.class final Llocal/mio/os4camerabridge/HookEntry$LeicaTriggerGroup;
.super Ljava/lang/Object;
.source "HookEntry.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Llocal/mio/os4camerabridge/HookEntry;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x1a
    name = "LeicaTriggerGroup"
.end annotation


# instance fields
.field final cct:[Llocal/mio/os4camerabridge/HookEntry$LeicaTriggerEntry;

.field final max:I

.field final min:I


# direct methods
.method constructor <init>(II[Llocal/mio/os4camerabridge/HookEntry$LeicaTriggerEntry;)V
    .locals 0
    .param p1, "min"    # I
    .param p2, "max"    # I
    .param p3, "cct"    # [Llocal/mio/os4camerabridge/HookEntry$LeicaTriggerEntry;

    .line 12323
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 12324
    iput p1, p0, Llocal/mio/os4camerabridge/HookEntry$LeicaTriggerGroup;->min:I

    .line 12325
    iput p2, p0, Llocal/mio/os4camerabridge/HookEntry$LeicaTriggerGroup;->max:I

    .line 12326
    iput-object p3, p0, Llocal/mio/os4camerabridge/HookEntry$LeicaTriggerGroup;->cct:[Llocal/mio/os4camerabridge/HookEntry$LeicaTriggerEntry;

    .line 12327
    return-void
.end method
