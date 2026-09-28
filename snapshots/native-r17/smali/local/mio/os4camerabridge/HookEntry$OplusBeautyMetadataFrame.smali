.class final Llocal/mio/os4camerabridge/HookEntry$OplusBeautyMetadataFrame;
.super Ljava/lang/Object;
.source "HookEntry.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Llocal/mio/os4camerabridge/HookEntry;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x1a
    name = "OplusBeautyMetadataFrame"
.end annotation


# instance fields
.field final faceCount:I

.field final faceIntCount:I

.field final facePayload:[B

.field final ffdIntCount:I

.field final ffdPayload:[B

.field final observedElapsed:J

.field final timestamp:J


# direct methods
.method constructor <init>(J[B[BIIIJ)V
    .locals 0
    .param p1, "timestamp"    # J
    .param p3, "facePayload"    # [B
    .param p4, "ffdPayload"    # [B
    .param p5, "faceIntCount"    # I
    .param p6, "ffdIntCount"    # I
    .param p7, "faceCount"    # I
    .param p8, "observedElapsed"    # J

    .line 8284
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 8285
    iput-wide p1, p0, Llocal/mio/os4camerabridge/HookEntry$OplusBeautyMetadataFrame;->timestamp:J

    .line 8286
    iput-object p3, p0, Llocal/mio/os4camerabridge/HookEntry$OplusBeautyMetadataFrame;->facePayload:[B

    .line 8287
    iput-object p4, p0, Llocal/mio/os4camerabridge/HookEntry$OplusBeautyMetadataFrame;->ffdPayload:[B

    .line 8288
    iput p5, p0, Llocal/mio/os4camerabridge/HookEntry$OplusBeautyMetadataFrame;->faceIntCount:I

    .line 8289
    iput p6, p0, Llocal/mio/os4camerabridge/HookEntry$OplusBeautyMetadataFrame;->ffdIntCount:I

    .line 8290
    iput p7, p0, Llocal/mio/os4camerabridge/HookEntry$OplusBeautyMetadataFrame;->faceCount:I

    .line 8291
    iput-wide p8, p0, Llocal/mio/os4camerabridge/HookEntry$OplusBeautyMetadataFrame;->observedElapsed:J

    .line 8292
    return-void
.end method
