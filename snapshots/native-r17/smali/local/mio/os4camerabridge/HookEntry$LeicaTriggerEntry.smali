.class final Llocal/mio/os4camerabridge/HookEntry$LeicaTriggerEntry;
.super Ljava/lang/Object;
.source "HookEntry.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Llocal/mio/os4camerabridge/HookEntry;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x1a
    name = "LeicaTriggerEntry"
.end annotation


# instance fields
.field final max:I

.field final min:I

.field final parameterIndex:I


# direct methods
.method constructor <init>(III)V
    .locals 0
    .param p1, "min"    # I
    .param p2, "max"    # I
    .param p3, "parameterIndex"    # I

    .line 12311
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 12312
    iput p1, p0, Llocal/mio/os4camerabridge/HookEntry$LeicaTriggerEntry;->min:I

    .line 12313
    iput p2, p0, Llocal/mio/os4camerabridge/HookEntry$LeicaTriggerEntry;->max:I

    .line 12314
    iput p3, p0, Llocal/mio/os4camerabridge/HookEntry$LeicaTriggerEntry;->parameterIndex:I

    .line 12315
    return-void
.end method
