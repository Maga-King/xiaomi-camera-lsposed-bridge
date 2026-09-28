.class public final Lcom/oplus/camera/facebeauty/OplusFaceBeautyPreview;
.super Ljava/lang/Object;
.source "OplusFaceBeautyPreview.java"


# static fields
.field private static loaded:Z


# direct methods
.method public constructor <init>()V
    .locals 0

    .line 9
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method public static declared-synchronized load(Ljava/lang/String;)V
    .locals 2
    .param p0, "absolutePath"    # Ljava/lang/String;

    const-class v0, Lcom/oplus/camera/facebeauty/OplusFaceBeautyPreview;

    monitor-enter v0

    .line 13
    :try_start_0
    sget-boolean v1, Lcom/oplus/camera/facebeauty/OplusFaceBeautyPreview;->loaded:Z

    if-nez v1, :cond_0

    .line 14
    invoke-static {p0}, Ljava/lang/System;->load(Ljava/lang/String;)V

    .line 15
    const/4 v1, 0x1

    sput-boolean v1, Lcom/oplus/camera/facebeauty/OplusFaceBeautyPreview;->loaded:Z
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 17
    :cond_0
    monitor-exit v0

    return-void

    .line 12
    .end local p0    # "absolutePath":Ljava/lang/String;
    :catchall_0
    move-exception p0

    :try_start_1
    monitor-exit v0
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    throw p0
.end method


# virtual methods
.method public native destroy()I
.end method

.method public native getTimeStamp()J
.end method

.method public native getZoomScale()F
.end method

.method public native init(IIIILjava/lang/String;Ljava/lang/String;Ljava/lang/String;ZZ[BI)I
.end method

.method public native process(I[I[I[I)I
.end method

.method public native reset()I
.end method

.method public native setPreviewParams(Ljava/lang/String;Ljava/lang/String;)I
.end method

.method public native updataFfd([B)I
.end method

.method public native updataMetaParams([B)I
.end method

.method public native updataPreviewParams(J)I
.end method
