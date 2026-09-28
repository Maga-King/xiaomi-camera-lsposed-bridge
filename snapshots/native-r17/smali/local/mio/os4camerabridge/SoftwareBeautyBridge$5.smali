.class Llocal/mio/os4camerabridge/SoftwareBeautyBridge$5;
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
.field final synthetic val$dimensions:Ljava/lang/reflect/Field;

.field final synthetic val$framebuffer:Ljava/lang/reflect/Field;

.field final synthetic val$holder:Ljava/lang/reflect/Field;

.field final synthetic val$input:Ljava/lang/reflect/Field;

.field final synthetic val$out:Ljava/lang/reflect/Field;

.field final synthetic val$texture:Ljava/lang/reflect/Field;


# direct methods
.method constructor <init>(Ljava/lang/reflect/Field;Ljava/lang/reflect/Field;Ljava/lang/reflect/Field;Ljava/lang/reflect/Field;Ljava/lang/reflect/Field;Ljava/lang/reflect/Field;)V
    .locals 0

    .line 146
    iput-object p1, p0, Llocal/mio/os4camerabridge/SoftwareBeautyBridge$5;->val$holder:Ljava/lang/reflect/Field;

    iput-object p2, p0, Llocal/mio/os4camerabridge/SoftwareBeautyBridge$5;->val$input:Ljava/lang/reflect/Field;

    iput-object p3, p0, Llocal/mio/os4camerabridge/SoftwareBeautyBridge$5;->val$out:Ljava/lang/reflect/Field;

    iput-object p4, p0, Llocal/mio/os4camerabridge/SoftwareBeautyBridge$5;->val$texture:Ljava/lang/reflect/Field;

    iput-object p5, p0, Llocal/mio/os4camerabridge/SoftwareBeautyBridge$5;->val$framebuffer:Ljava/lang/reflect/Field;

    iput-object p6, p0, Llocal/mio/os4camerabridge/SoftwareBeautyBridge$5;->val$dimensions:Ljava/lang/reflect/Field;

    invoke-direct {p0}, Lde/robv/android/xposed/XC_MethodHook;-><init>()V

    return-void
.end method


# virtual methods
.method protected afterHookedMethod(Lde/robv/android/xposed/XC_MethodHook$MethodHookParam;)V
    .locals 12

    .line 148
    invoke-static {}, Llocal/mio/os4camerabridge/SoftwareBeautyBridge;->-$$Nest$smstrength()F

    move-result v5

    invoke-static {}, Landroid/os/SystemClock;->elapsedRealtime()J

    move-result-wide v6

    .line 149
    const/4 v0, 0x0

    cmpg-float v0, v5, v0

    if-lez v0, :cond_6

    sget-object v0, Ljava/lang/Boolean;->TRUE:Ljava/lang/Boolean;

    iget-object v1, p1, Lde/robv/android/xposed/XC_MethodHook$MethodHookParam;->args:[Ljava/lang/Object;

    const/4 v2, 0x1

    aget-object v1, v1, v2

    invoke-virtual {v0, v1}, Ljava/lang/Boolean;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_6

    invoke-virtual {p1}, Lde/robv/android/xposed/XC_MethodHook$MethodHookParam;->hasThrowable()Z

    move-result v0

    if-nez v0, :cond_6

    invoke-static {}, Llocal/mio/os4camerabridge/SoftwareBeautyBridge;->-$$Nest$sfgetretryAt()J

    move-result-wide v0

    cmp-long v0, v6, v0

    if-gez v0, :cond_0

    goto/16 :goto_2

    .line 151
    :cond_0
    :try_start_0
    iget-object v0, p0, Llocal/mio/os4camerabridge/SoftwareBeautyBridge$5;->val$holder:Ljava/lang/reflect/Field;

    iget-object p1, p1, Lde/robv/android/xposed/XC_MethodHook$MethodHookParam;->thisObject:Ljava/lang/Object;

    invoke-virtual {v0, p1}, Ljava/lang/reflect/Field;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object p1

    if-nez p1, :cond_1

    return-void

    .line 152
    :cond_1
    iget-object v0, p0, Llocal/mio/os4camerabridge/SoftwareBeautyBridge$5;->val$input:Ljava/lang/reflect/Field;

    invoke-virtual {v0, p1}, Ljava/lang/reflect/Field;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v8

    iget-object v0, p0, Llocal/mio/os4camerabridge/SoftwareBeautyBridge$5;->val$out:Ljava/lang/reflect/Field;

    invoke-virtual {v0, p1}, Ljava/lang/reflect/Field;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v9

    if-eqz v8, :cond_5

    if-nez v9, :cond_2

    goto/16 :goto_0

    .line 153
    :cond_2
    iget-object v0, p0, Llocal/mio/os4camerabridge/SoftwareBeautyBridge$5;->val$texture:Ljava/lang/reflect/Field;

    invoke-virtual {v0, v8}, Ljava/lang/reflect/Field;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, [I

    const/4 v1, 0x0

    aget v0, v0, v1

    iget-object v2, p0, Llocal/mio/os4camerabridge/SoftwareBeautyBridge$5;->val$framebuffer:Ljava/lang/reflect/Field;

    invoke-virtual {v2, v9}, Ljava/lang/reflect/Field;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v2

    check-cast v2, [I

    aget v2, v2, v1

    .line 154
    iget-object v1, p0, Llocal/mio/os4camerabridge/SoftwareBeautyBridge$5;->val$dimensions:Ljava/lang/reflect/Field;

    invoke-virtual {v1, v8}, Ljava/lang/reflect/Field;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v1

    move-object v10, v1

    check-cast v10, Landroid/util/Size;

    iget-object v1, p0, Llocal/mio/os4camerabridge/SoftwareBeautyBridge$5;->val$dimensions:Ljava/lang/reflect/Field;

    invoke-virtual {v1, v9}, Ljava/lang/reflect/Field;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Landroid/util/Size;

    .line 155
    invoke-virtual {v10, v1}, Landroid/util/Size;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-nez v1, :cond_3

    return-void

    .line 156
    :cond_3
    invoke-static {}, Llocal/mio/os4camerabridge/SoftwareBeautyBridge;->-$$Nest$sfgetFILTER()Ljava/lang/ThreadLocal;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/ThreadLocal;->get()Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Llocal/mio/os4camerabridge/SoftwareSkinSmoothing;

    invoke-virtual {v10}, Landroid/util/Size;->getWidth()I

    move-result v3

    invoke-virtual {v10}, Landroid/util/Size;->getHeight()I

    move-result v4

    move-object v11, v1

    move v1, v0

    move-object v0, v11

    invoke-virtual/range {v0 .. v5}, Llocal/mio/os4camerabridge/SoftwareSkinSmoothing;->draw(IIIIF)Z

    move-result v0

    if-eqz v0, :cond_4

    .line 157
    iget-object v0, p0, Llocal/mio/os4camerabridge/SoftwareBeautyBridge$5;->val$input:Ljava/lang/reflect/Field;

    invoke-virtual {v0, p1, v9}, Ljava/lang/reflect/Field;->set(Ljava/lang/Object;Ljava/lang/Object;)V

    iget-object v0, p0, Llocal/mio/os4camerabridge/SoftwareBeautyBridge$5;->val$out:Ljava/lang/reflect/Field;

    invoke-virtual {v0, p1, v8}, Ljava/lang/reflect/Field;->set(Ljava/lang/Object;Ljava/lang/Object;)V

    .line 158
    invoke-static {}, Llocal/mio/os4camerabridge/SoftwareBeautyBridge;->-$$Nest$sfgetlastLog()J

    move-result-wide v2

    sub-long v2, v6, v2

    const-wide/16 v8, 0x2710

    cmp-long p1, v2, v8

    if-lez p1, :cond_4

    invoke-static {v6, v7}, Llocal/mio/os4camerabridge/SoftwareBeautyBridge;->-$$Nest$sfputlastLog(J)V

    invoke-static {v10}, Ljava/lang/String;->valueOf(Ljava/lang/Object;)Ljava/lang/String;

    move-result-object p1

    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "[SoftwareBeauty] preview texture="

    invoke-virtual {v0, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, " size="

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p1

    const-string v0, " amount="

    invoke-virtual {p1, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p1

    invoke-virtual {p1, v5}, Ljava/lang/StringBuilder;->append(F)Ljava/lang/StringBuilder;

    move-result-object p1

    invoke-virtual {p1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p1

    invoke-static {p1}, Lde/robv/android/xposed/XposedBridge;->log(Ljava/lang/String;)V
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 160
    :cond_4
    goto :goto_1

    .line 152
    :cond_5
    :goto_0
    return-void

    .line 160
    :catchall_0
    move-exception v0

    move-object p1, v0

    const-wide/16 v0, 0x1388

    add-long/2addr v6, v0

    invoke-static {v6, v7}, Llocal/mio/os4camerabridge/SoftwareBeautyBridge;->-$$Nest$sfputretryAt(J)V

    invoke-static {p1}, Ljava/lang/String;->valueOf(Ljava/lang/Object;)Ljava/lang/String;

    move-result-object p1

    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "[SoftwareBeauty] preview retained: "

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p1

    invoke-virtual {p1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p1

    invoke-static {p1}, Lde/robv/android/xposed/XposedBridge;->log(Ljava/lang/String;)V

    .line 161
    :goto_1
    return-void

    .line 149
    :cond_6
    :goto_2
    return-void
.end method
