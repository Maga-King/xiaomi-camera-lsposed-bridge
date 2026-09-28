.class Llocal/mio/os4camerabridge/HookEntry$42;
.super Lde/robv/android/xposed/XC_MethodHook;
.source "HookEntry.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Llocal/mio/os4camerabridge/HookEntry;->hookFrameworkRoleTags()V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# direct methods
.method constructor <init>()V
    .locals 0

    .line 8570
    invoke-direct {p0}, Lde/robv/android/xposed/XC_MethodHook;-><init>()V

    return-void
.end method


# virtual methods
.method protected beforeHookedMethod(Lde/robv/android/xposed/XC_MethodHook$MethodHookParam;)V
    .locals 4
    .param p1, "param"    # Lde/robv/android/xposed/XC_MethodHook$MethodHookParam;

    .line 8573
    iget-object v0, p1, Lde/robv/android/xposed/XC_MethodHook$MethodHookParam;->args:[Ljava/lang/Object;

    const/4 v1, 0x0

    aget-object v0, v0, v1

    instance-of v0, v0, Landroid/hardware/camera2/CameraCharacteristics$Key;

    if-nez v0, :cond_0

    .line 8574
    return-void

    .line 8576
    :cond_0
    invoke-static {}, Llocal/mio/os4camerabridge/HookEntry;->-$$Nest$sfgetCAMERA_IDS()Ljava/util/Map;

    move-result-object v0

    iget-object v2, p1, Lde/robv/android/xposed/XC_MethodHook$MethodHookParam;->thisObject:Ljava/lang/Object;

    check-cast v2, Landroid/hardware/camera2/CameraCharacteristics;

    invoke-interface {v0, v2}, Ljava/util/Map;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/lang/String;

    .line 8577
    .local v0, "cameraId":Ljava/lang/String;
    if-nez v0, :cond_1

    .line 8578
    return-void

    .line 8580
    :cond_1
    iget-object v2, p1, Lde/robv/android/xposed/XC_MethodHook$MethodHookParam;->args:[Ljava/lang/Object;

    aget-object v1, v2, v1

    check-cast v1, Landroid/hardware/camera2/CameraCharacteristics$Key;

    invoke-virtual {v1}, Landroid/hardware/camera2/CameraCharacteristics$Key;->getName()Ljava/lang/String;

    move-result-object v1

    .line 8581
    .local v1, "name":Ljava/lang/String;
    invoke-static {v1}, Llocal/mio/os4camerabridge/HookEntry;->-$$Nest$smisRoleIdsKey(Ljava/lang/String;)Z

    move-result v2

    if-eqz v2, :cond_2

    .line 8582
    invoke-static {v0}, Llocal/mio/os4camerabridge/HookEntry;->-$$Nest$smrolesFor(Ljava/lang/String;)[I

    move-result-object v2

    .line 8583
    .local v2, "roles":[I
    if-eqz v2, :cond_3

    .line 8584
    invoke-virtual {v2}, [I->clone()Ljava/lang/Object;

    move-result-object v3

    invoke-virtual {p1, v3}, Lde/robv/android/xposed/XC_MethodHook$MethodHookParam;->setResult(Ljava/lang/Object;)V

    .line 8585
    const-string v3, "framework metadata"

    invoke-static {v3, v0, v2}, Llocal/mio/os4camerabridge/HookEntry;->-$$Nest$smlogRolesOnce(Ljava/lang/String;Ljava/lang/String;[I)V

    goto :goto_0

    .line 8587
    .end local v2    # "roles":[I
    :cond_2
    invoke-static {v1}, Llocal/mio/os4camerabridge/HookEntry;->-$$Nest$smisRoleIdKey(Ljava/lang/String;)Z

    move-result v2

    if-eqz v2, :cond_3

    .line 8588
    invoke-static {v0}, Llocal/mio/os4camerabridge/HookEntry;->-$$Nest$smprimaryRoleFor(Ljava/lang/String;)Ljava/lang/Integer;

    move-result-object v2

    .line 8589
    .local v2, "role":Ljava/lang/Integer;
    if-eqz v2, :cond_4

    .line 8590
    invoke-virtual {p1, v2}, Lde/robv/android/xposed/XC_MethodHook$MethodHookParam;->setResult(Ljava/lang/Object;)V

    goto :goto_1

    .line 8587
    .end local v2    # "role":Ljava/lang/Integer;
    :cond_3
    :goto_0
    nop

    .line 8593
    :cond_4
    :goto_1
    return-void
.end method
