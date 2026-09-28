.class Llocal/mio/os4camerabridge/LegendaryRawCfaBridge$2;
.super Lde/robv/android/xposed/XC_MethodHook;
.source "LegendaryRawCfaBridge.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Llocal/mio/os4camerabridge/LegendaryRawCfaBridge;->install(Ljava/lang/ClassLoader;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# direct methods
.method constructor <init>(I)V
    .locals 0

    .line 58
    invoke-direct {p0, p1}, Lde/robv/android/xposed/XC_MethodHook;-><init>(I)V

    return-void
.end method


# virtual methods
.method protected beforeHookedMethod(Lde/robv/android/xposed/XC_MethodHook$MethodHookParam;)V
    .locals 6

    .line 60
    invoke-static {}, Llocal/mio/os4camerabridge/LegendaryRawCfaBridge;->-$$Nest$sfgetFRAMES()Ljava/util/Map;

    move-result-object v0

    iget-object v1, p1, Lde/robv/android/xposed/XC_MethodHook$MethodHookParam;->args:[Ljava/lang/Object;

    const/4 v2, 0x4

    aget-object v1, v1, v2

    invoke-interface {v0, v1}, Ljava/util/Map;->remove(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Llocal/mio/os4camerabridge/LegendaryRawCfaBridge$Frame;

    .line 61
    if-nez v0, :cond_0

    const-string p1, "no bound CFA; original packer retained"

    invoke-static {p1}, Llocal/mio/os4camerabridge/LegendaryRawCfaBridge;->-$$Nest$smlog(Ljava/lang/String;)V

    return-void

    .line 63
    :cond_0
    :try_start_0
    iget-object v1, p1, Lde/robv/android/xposed/XC_MethodHook$MethodHookParam;->args:[Ljava/lang/Object;

    const/4 v2, 0x1

    aget-object v1, v1, v2

    check-cast v1, [B

    .line 64
    invoke-static {v0}, Llocal/mio/os4camerabridge/LegendaryRawCfaBridge$Frame;->-$$Nest$fgetcfa(Llocal/mio/os4camerabridge/LegendaryRawCfaBridge$Frame;)I

    move-result v3

    const/16 v4, 0x1000

    const/16 v5, 0xc00

    invoke-static {v1, v4, v5, v3}, Llocal/mio/os4camerabridge/LegendaryRawCfaLayout;->toRggb([BIII)[B

    move-result-object v3

    .line 65
    iget-object p1, p1, Lde/robv/android/xposed/XC_MethodHook$MethodHookParam;->args:[Ljava/lang/Object;

    aput-object v3, p1, v2

    .line 66
    invoke-static {v0}, Llocal/mio/os4camerabridge/LegendaryRawCfaBridge$Frame;->-$$Nest$fgettimestamp(Llocal/mio/os4camerabridge/LegendaryRawCfaBridge$Frame;)J

    move-result-wide v4

    invoke-static {v0}, Llocal/mio/os4camerabridge/LegendaryRawCfaBridge$Frame;->-$$Nest$fgetcamera(Llocal/mio/os4camerabridge/LegendaryRawCfaBridge$Frame;)I

    move-result p1

    invoke-static {v0}, Llocal/mio/os4camerabridge/LegendaryRawCfaBridge$Frame;->-$$Nest$fgetcfa(Llocal/mio/os4camerabridge/LegendaryRawCfaBridge$Frame;)I

    move-result v0

    if-eq v3, v1, :cond_1

    goto :goto_0

    :cond_1
    const/4 v2, 0x0

    :goto_0
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "ts="

    invoke-virtual {v1, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, v4, v5}, Ljava/lang/StringBuilder;->append(J)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v3, " camera="

    invoke-virtual {v1, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, p1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object p1

    const-string v1, " sourceCfa="

    invoke-virtual {p1, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p1

    invoke-virtual {p1, v0}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object p1

    const-string v0, " -> legacyRGGB changed="

    invoke-virtual {p1, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p1

    invoke-virtual {p1, v2}, Ljava/lang/StringBuilder;->append(Z)Ljava/lang/StringBuilder;

    move-result-object p1

    const-string v0, " JPEG/LSC/orientation unchanged"

    invoke-virtual {p1, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p1

    invoke-virtual {p1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p1

    invoke-static {p1}, Llocal/mio/os4camerabridge/LegendaryRawCfaBridge;->-$$Nest$smlog(Ljava/lang/String;)V
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 68
    goto :goto_1

    :catchall_0
    move-exception p1

    invoke-static {p1}, Ljava/lang/String;->valueOf(Ljava/lang/Object;)Ljava/lang/String;

    move-result-object p1

    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "RAW canonicalization rejected "

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p1

    invoke-virtual {p1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p1

    invoke-static {p1}, Llocal/mio/os4camerabridge/LegendaryRawCfaBridge;->-$$Nest$smlog(Ljava/lang/String;)V

    .line 69
    :goto_1
    return-void
.end method
