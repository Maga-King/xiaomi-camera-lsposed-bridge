.class Llocal/mio/os4camerabridge/JpegChainProbe$4;
.super Lde/robv/android/xposed/XC_MethodHook;
.source "JpegChainProbe.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Llocal/mio/os4camerabridge/JpegChainProbe;->install(Ljava/lang/ClassLoader;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# direct methods
.method constructor <init>(I)V
    .locals 0

    .line 85
    invoke-direct {p0, p1}, Lde/robv/android/xposed/XC_MethodHook;-><init>(I)V

    return-void
.end method


# virtual methods
.method protected beforeHookedMethod(Lde/robv/android/xposed/XC_MethodHook$MethodHookParam;)V
    .locals 5

    .line 87
    invoke-static {}, Llocal/mio/os4camerabridge/JpegChainProbe;->-$$Nest$sfgetEXIF_TASK()Ljava/lang/ThreadLocal;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/ThreadLocal;->get()Ljava/lang/Object;

    move-result-object v0

    .line 88
    if-nez v0, :cond_0

    return-void

    .line 90
    :cond_0
    :try_start_0
    const-string v1, "f"

    invoke-static {v0, v1}, Llocal/mio/os4camerabridge/JpegChainProbe;->-$$Nest$smfield(Ljava/lang/Object;Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v1

    .line 91
    invoke-static {v0}, Llocal/mio/os4camerabridge/JpegChainProbe;->-$$Nest$smidentity(Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v0

    iget-object p1, p1, Lde/robv/android/xposed/XC_MethodHook$MethodHookParam;->args:[Ljava/lang/Object;

    const/4 v2, 0x0

    aget-object p1, p1, v2

    .line 92
    invoke-static {p1}, Llocal/mio/os4camerabridge/JpegChainProbe;->-$$Nest$smresult(Ljava/lang/Object;)Ljava/lang/String;

    move-result-object p1

    const-string v2, "b"

    .line 93
    invoke-static {v1, v2}, Llocal/mio/os4camerabridge/JpegChainProbe;->-$$Nest$smfield(Ljava/lang/Object;Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v2

    invoke-static {v2}, Llocal/mio/os4camerabridge/JpegChainProbe;->-$$Nest$smresult(Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v2

    const-string v3, "c"

    .line 94
    invoke-static {v1, v3}, Llocal/mio/os4camerabridge/JpegChainProbe;->-$$Nest$smfield(Ljava/lang/Object;Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v1

    invoke-static {v1}, Llocal/mio/os4camerabridge/JpegChainProbe;->-$$Nest$smresult(Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v1

    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    const-string v4, "exif-selected "

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v3, " selected="

    invoke-virtual {v0, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p1

    const-string v0, " taskB="

    invoke-virtual {p1, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p1

    invoke-virtual {p1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p1

    const-string v0, " taskC="

    invoke-virtual {p1, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p1

    invoke-virtual {p1, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p1

    invoke-virtual {p1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p1

    .line 91
    invoke-static {p1}, Llocal/mio/os4camerabridge/JpegChainProbe;->-$$Nest$smlog(Ljava/lang/String;)V
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 95
    goto :goto_0

    :catchall_0
    move-exception p1

    const-string v0, "exif-selected"

    invoke-static {v0, p1}, Llocal/mio/os4camerabridge/JpegChainProbe;->-$$Nest$smerror(Ljava/lang/String;Ljava/lang/Throwable;)V

    .line 96
    :goto_0
    return-void
.end method
