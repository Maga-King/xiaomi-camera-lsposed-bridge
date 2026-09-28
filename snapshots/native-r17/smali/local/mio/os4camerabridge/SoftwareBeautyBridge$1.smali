.class Llocal/mio/os4camerabridge/SoftwareBeautyBridge$1;
.super Lde/robv/android/xposed/XC_MethodHook;
.source "SoftwareBeautyBridge.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Llocal/mio/os4camerabridge/SoftwareBeautyBridge;->bind(Lorg/luckypray/dexkit/DexKitBridge;Ljava/lang/ClassLoader;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic val$selectedMethod:Ljava/lang/reflect/Method;


# direct methods
.method constructor <init>(Ljava/lang/reflect/Method;)V
    .locals 0

    .line 120
    iput-object p1, p0, Llocal/mio/os4camerabridge/SoftwareBeautyBridge$1;->val$selectedMethod:Ljava/lang/reflect/Method;

    invoke-direct {p0}, Lde/robv/android/xposed/XC_MethodHook;-><init>()V

    return-void
.end method


# virtual methods
.method protected afterHookedMethod(Lde/robv/android/xposed/XC_MethodHook$MethodHookParam;)V
    .locals 4

    .line 123
    invoke-static {}, Llocal/mio/os4camerabridge/SoftwareBeautyBridge;->-$$Nest$sfgetPANEL_READ_DEPTH()Ljava/lang/ThreadLocal;

    move-result-object v0

    invoke-static {}, Llocal/mio/os4camerabridge/SoftwareBeautyBridge;->-$$Nest$sfgetPANEL_READ_DEPTH()Ljava/lang/ThreadLocal;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/ThreadLocal;->get()Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Ljava/lang/Integer;

    invoke-virtual {v1}, Ljava/lang/Integer;->intValue()I

    move-result v1

    add-int/lit8 v1, v1, -0x1

    const/4 v2, 0x0

    invoke-static {v2, v1}, Ljava/lang/Math;->max(II)I

    move-result v1

    invoke-static {v1}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/ThreadLocal;->set(Ljava/lang/Object;)V

    .line 124
    invoke-virtual {p1}, Lde/robv/android/xposed/XC_MethodHook$MethodHookParam;->hasThrowable()Z

    move-result v0

    if-nez v0, :cond_1

    .line 125
    :try_start_0
    sget-object v0, Ljava/lang/Boolean;->TRUE:Ljava/lang/Boolean;

    iget-object v1, p0, Llocal/mio/os4camerabridge/SoftwareBeautyBridge$1;->val$selectedMethod:Ljava/lang/reflect/Method;

    iget-object p1, p1, Lde/robv/android/xposed/XC_MethodHook$MethodHookParam;->thisObject:Ljava/lang/Object;

    new-array v3, v2, [Ljava/lang/Object;

    invoke-virtual {v1, p1, v3}, Ljava/lang/reflect/Method;->invoke(Ljava/lang/Object;[Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object p1

    invoke-virtual {v0, p1}, Ljava/lang/Boolean;->equals(Ljava/lang/Object;)Z

    move-result p1

    invoke-static {p1}, Llocal/mio/os4camerabridge/SoftwareBeautyBridge;->-$$Nest$sfputbeautySelected(Z)V

    .line 126
    invoke-static {}, Llocal/mio/os4camerabridge/SoftwareBeautyBridge;->-$$Nest$sfgetPANEL_READ_DEPTH()Ljava/lang/ThreadLocal;

    move-result-object p1

    invoke-virtual {p1}, Ljava/lang/ThreadLocal;->get()Ljava/lang/Object;

    move-result-object p1

    check-cast p1, Ljava/lang/Integer;

    invoke-virtual {p1}, Ljava/lang/Integer;->intValue()I

    move-result p1

    if-nez p1, :cond_0

    invoke-static {}, Llocal/mio/os4camerabridge/SoftwareBeautyBridge;->-$$Nest$sfgetbeautySelected()Z

    move-result p1

    invoke-static {}, Llocal/mio/os4camerabridge/SoftwareBeautyBridge;->-$$Nest$sfgetlevel()I

    move-result v0

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "[SoftwareBeauty] panel enabled="

    invoke-virtual {v1, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, p1}, Ljava/lang/StringBuilder;->append(Z)Ljava/lang/StringBuilder;

    move-result-object p1

    const-string v1, " level="

    invoke-virtual {p1, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p1

    invoke-virtual {p1, v0}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object p1

    invoke-virtual {p1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p1

    invoke-static {p1}, Lde/robv/android/xposed/XposedBridge;->log(Ljava/lang/String;)V
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 127
    :cond_0
    goto :goto_0

    :catchall_0
    move-exception p1

    invoke-static {v2}, Llocal/mio/os4camerabridge/SoftwareBeautyBridge;->-$$Nest$sfputbeautySelected(Z)V

    .line 128
    :cond_1
    :goto_0
    return-void
.end method

.method protected beforeHookedMethod(Lde/robv/android/xposed/XC_MethodHook$MethodHookParam;)V
    .locals 1

    .line 121
    invoke-static {}, Llocal/mio/os4camerabridge/SoftwareBeautyBridge;->-$$Nest$sfgetPANEL_READ_DEPTH()Ljava/lang/ThreadLocal;

    move-result-object p1

    invoke-static {}, Llocal/mio/os4camerabridge/SoftwareBeautyBridge;->-$$Nest$sfgetPANEL_READ_DEPTH()Ljava/lang/ThreadLocal;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/ThreadLocal;->get()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/lang/Integer;

    invoke-virtual {v0}, Ljava/lang/Integer;->intValue()I

    move-result v0

    add-int/lit8 v0, v0, 0x1

    invoke-static {v0}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v0

    invoke-virtual {p1, v0}, Ljava/lang/ThreadLocal;->set(Ljava/lang/Object;)V

    return-void
.end method
