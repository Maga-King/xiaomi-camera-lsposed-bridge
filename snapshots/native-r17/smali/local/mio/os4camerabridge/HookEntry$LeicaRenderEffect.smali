.class final Llocal/mio/os4camerabridge/HookEntry$LeicaRenderEffect;
.super Ljava/lang/Object;
.source "HookEntry.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Llocal/mio/os4camerabridge/HookEntry;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x1a
    name = "LeicaRenderEffect"
.end annotation


# instance fields
.field final debug:Ljava/lang/String;

.field final lut:Landroid/graphics/Bitmap;

.field final script:Ljava/lang/String;


# direct methods
.method constructor <init>(Landroid/graphics/Bitmap;Ljava/lang/String;Ljava/lang/String;)V
    .locals 0
    .param p1, "lut"    # Landroid/graphics/Bitmap;
    .param p2, "script"    # Ljava/lang/String;
    .param p3, "debug"    # Ljava/lang/String;

    .line 12299
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 12300
    iput-object p1, p0, Llocal/mio/os4camerabridge/HookEntry$LeicaRenderEffect;->lut:Landroid/graphics/Bitmap;

    .line 12301
    iput-object p2, p0, Llocal/mio/os4camerabridge/HookEntry$LeicaRenderEffect;->script:Ljava/lang/String;

    .line 12302
    iput-object p3, p0, Llocal/mio/os4camerabridge/HookEntry$LeicaRenderEffect;->debug:Ljava/lang/String;

    .line 12303
    return-void
.end method
