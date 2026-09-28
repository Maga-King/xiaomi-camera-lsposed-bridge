.class final Llocal/mio/os4camerabridge/HookEntry$LeicaTriggerTable;
.super Ljava/lang/Object;
.source "HookEntry.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Llocal/mio/os4camerabridge/HookEntry;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x1a
    name = "LeicaTriggerTable"
.end annotation


# instance fields
.field final end:I

.field final groups:[Llocal/mio/os4camerabridge/HookEntry$LeicaTriggerGroup;


# direct methods
.method constructor <init>([Llocal/mio/os4camerabridge/HookEntry$LeicaTriggerGroup;I)V
    .locals 0
    .param p1, "groups"    # [Llocal/mio/os4camerabridge/HookEntry$LeicaTriggerGroup;
    .param p2, "end"    # I

    .line 12334
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 12335
    iput-object p1, p0, Llocal/mio/os4camerabridge/HookEntry$LeicaTriggerTable;->groups:[Llocal/mio/os4camerabridge/HookEntry$LeicaTriggerGroup;

    .line 12336
    iput p2, p0, Llocal/mio/os4camerabridge/HookEntry$LeicaTriggerTable;->end:I

    .line 12337
    return-void
.end method
