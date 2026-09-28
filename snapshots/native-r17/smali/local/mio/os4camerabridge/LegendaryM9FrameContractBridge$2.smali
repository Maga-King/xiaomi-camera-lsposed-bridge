.class Llocal/mio/os4camerabridge/LegendaryM9FrameContractBridge$2;
.super Lde/robv/android/xposed/XC_MethodHook;
.source "LegendaryM9FrameContractBridge.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Llocal/mio/os4camerabridge/LegendaryM9FrameContractBridge;->install()V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# direct methods
.method constructor <init>()V
    .locals 0

    .line 52
    invoke-direct {p0}, Lde/robv/android/xposed/XC_MethodHook;-><init>()V

    return-void
.end method


# virtual methods
.method protected afterHookedMethod(Lde/robv/android/xposed/XC_MethodHook$MethodHookParam;)V
    .locals 7

    .line 54
    invoke-virtual {p1}, Lde/robv/android/xposed/XC_MethodHook$MethodHookParam;->hasThrowable()Z

    move-result v0

    if-nez v0, :cond_2

    invoke-virtual {p1}, Lde/robv/android/xposed/XC_MethodHook$MethodHookParam;->getResult()Ljava/lang/Object;

    move-result-object v0

    instance-of v0, v0, [B

    if-eqz v0, :cond_2

    iget-object v0, p1, Lde/robv/android/xposed/XC_MethodHook$MethodHookParam;->args:[Ljava/lang/Object;

    array-length v0, v0

    const/4 v1, 0x3

    if-eq v0, v1, :cond_0

    goto/16 :goto_1

    .line 55
    :cond_0
    invoke-static {}, Llocal/mio/os4camerabridge/LegendaryM9FrameContractBridge;->-$$Nest$sfgetFRAMES()Ljava/util/Map;

    move-result-object v0

    iget-object v1, p1, Lde/robv/android/xposed/XC_MethodHook$MethodHookParam;->args:[Ljava/lang/Object;

    const/4 v2, 0x1

    aget-object v1, v1, v2

    invoke-interface {v0, v1}, Ljava/util/Map;->remove(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Llocal/mio/os4camerabridge/LegendaryM9FrameContractBridge$Frame;

    .line 56
    if-nez v0, :cond_1

    return-void

    .line 58
    :cond_1
    :try_start_0
    invoke-virtual {p1}, Lde/robv/android/xposed/XC_MethodHook$MethodHookParam;->getResult()Ljava/lang/Object;

    move-result-object v1

    check-cast v1, [B

    .line 59
    invoke-static {v0}, Llocal/mio/os4camerabridge/LegendaryM9FrameContractBridge$Frame;->-$$Nest$fgetzoom(Llocal/mio/os4camerabridge/LegendaryM9FrameContractBridge$Frame;)F

    move-result v2

    invoke-static {v0}, Llocal/mio/os4camerabridge/LegendaryM9FrameContractBridge$Frame;->-$$Nest$fgetgain(Llocal/mio/os4camerabridge/LegendaryM9FrameContractBridge$Frame;)F

    move-result v3

    invoke-static {v0}, Llocal/mio/os4camerabridge/LegendaryM9FrameContractBridge$Frame;->-$$Nest$fgetccm(Llocal/mio/os4camerabridge/LegendaryM9FrameContractBridge$Frame;)[F

    move-result-object v4

    invoke-static {v1, v2, v3, v4}, Llocal/mio/os4camerabridge/LegendaryM9MessagePolicy;->correct([BFF[F)[B

    move-result-object v2

    .line 60
    invoke-virtual {p1, v2}, Lde/robv/android/xposed/XC_MethodHook$MethodHookParam;->setResult(Ljava/lang/Object;)V

    .line 61
    invoke-static {v0}, Llocal/mio/os4camerabridge/LegendaryM9FrameContractBridge$Frame;->-$$Nest$fgettimestamp(Llocal/mio/os4camerabridge/LegendaryM9FrameContractBridge$Frame;)J

    move-result-wide v2

    invoke-static {v0}, Llocal/mio/os4camerabridge/LegendaryM9FrameContractBridge$Frame;->-$$Nest$fgetzoom(Llocal/mio/os4camerabridge/LegendaryM9FrameContractBridge$Frame;)F

    move-result p1

    invoke-static {v0}, Llocal/mio/os4camerabridge/LegendaryM9FrameContractBridge$Frame;->-$$Nest$fgetgain(Llocal/mio/os4camerabridge/LegendaryM9FrameContractBridge$Frame;)F

    move-result v4

    invoke-static {v0}, Llocal/mio/os4camerabridge/LegendaryM9FrameContractBridge$Frame;->-$$Nest$fgetccm(Llocal/mio/os4camerabridge/LegendaryM9FrameContractBridge$Frame;)[F

    move-result-object v0

    .line 62
    invoke-static {v0}, Ljava/util/Arrays;->toString([F)Ljava/lang/String;

    move-result-object v0

    array-length v1, v1

    new-instance v5, Ljava/lang/StringBuilder;

    invoke-direct {v5}, Ljava/lang/StringBuilder;-><init>()V

    const-string v6, "main1x packet fields5/9/18 corrected ts="

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5, v2, v3}, Ljava/lang/StringBuilder;->append(J)Ljava/lang/StringBuilder;

    move-result-object v2

    const-string v3, " zoom="

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, p1}, Ljava/lang/StringBuilder;->append(F)Ljava/lang/StringBuilder;

    move-result-object p1

    const-string v2, " bpsGain="

    invoke-virtual {p1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p1

    invoke-virtual {p1, v4}, Ljava/lang/StringBuilder;->append(F)Ljava/lang/StringBuilder;

    move-result-object p1

    const-string v2, " ccm="

    invoke-virtual {p1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p1

    invoke-virtual {p1, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p1

    const-string v0, " bytes="

    invoke-virtual {p1, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p1

    invoke-virtual {p1, v1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object p1

    const-string v0, "; RAW/JPEG untouched"

    invoke-virtual {p1, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p1

    invoke-virtual {p1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p1

    .line 61
    invoke-static {p1}, Llocal/mio/os4camerabridge/LegendaryM9FrameContractBridge;->-$$Nest$smlog(Ljava/lang/String;)V
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 64
    goto :goto_0

    :catchall_0
    move-exception p1

    invoke-static {p1}, Ljava/lang/String;->valueOf(Ljava/lang/Object;)Ljava/lang/String;

    move-result-object p1

    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "original packet retained: "

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p1

    invoke-virtual {p1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p1

    invoke-static {p1}, Llocal/mio/os4camerabridge/LegendaryM9FrameContractBridge;->-$$Nest$smlog(Ljava/lang/String;)V

    .line 65
    :goto_0
    return-void

    .line 54
    :cond_2
    :goto_1
    return-void
.end method
