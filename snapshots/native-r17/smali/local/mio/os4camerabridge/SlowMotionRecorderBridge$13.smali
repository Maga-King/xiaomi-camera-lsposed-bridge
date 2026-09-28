.class Llocal/mio/os4camerabridge/SlowMotionRecorderBridge$13;
.super Lde/robv/android/xposed/XC_MethodHook;
.source "SlowMotionRecorderBridge.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Llocal/mio/os4camerabridge/SlowMotionRecorderBridge;->bindRecordState(Ljava/lang/ClassLoader;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# direct methods
.method constructor <init>()V
    .locals 0

    .line 203
    invoke-direct {p0}, Lde/robv/android/xposed/XC_MethodHook;-><init>()V

    return-void
.end method


# virtual methods
.method protected beforeHookedMethod(Lde/robv/android/xposed/XC_MethodHook$MethodHookParam;)V
    .locals 1

    .line 204
    invoke-static {}, Llocal/mio/os4camerabridge/SlowMotionRecorderBridge;->-$$Nest$sfgetRECORDER_INPUTS()Ljava/util/Map;

    move-result-object v0

    iget-object p1, p1, Lde/robv/android/xposed/XC_MethodHook$MethodHookParam;->thisObject:Ljava/lang/Object;

    invoke-interface {v0, p1}, Ljava/util/Map;->containsKey(Ljava/lang/Object;)Z

    move-result p1

    if-eqz p1, :cond_0

    const/4 p1, 0x0

    invoke-static {p1}, Llocal/mio/os4camerabridge/SlowMotionRecorderBridge;->-$$Nest$sfputrecording(Z)V

    :cond_0
    return-void
.end method
