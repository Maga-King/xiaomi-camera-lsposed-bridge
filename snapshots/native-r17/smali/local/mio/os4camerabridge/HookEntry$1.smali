.class Llocal/mio/os4camerabridge/HookEntry$1;
.super Lde/robv/android/xposed/XC_MethodHook;
.source "HookEntry.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Llocal/mio/os4camerabridge/HookEntry;->hookMediaEditorLegendCapability(Ljava/lang/ClassLoader;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# direct methods
.method constructor <init>()V
    .locals 0

    .line 1001
    invoke-direct {p0}, Lde/robv/android/xposed/XC_MethodHook;-><init>()V

    return-void
.end method


# virtual methods
.method protected afterHookedMethod(Lde/robv/android/xposed/XC_MethodHook$MethodHookParam;)V
    .locals 8
    .param p1, "param"    # Lde/robv/android/xposed/XC_MethodHook$MethodHookParam;

    .line 1004
    iget-object v0, p1, Lde/robv/android/xposed/XC_MethodHook$MethodHookParam;->args:[Ljava/lang/Object;

    if-eqz v0, :cond_6

    iget-object v0, p1, Lde/robv/android/xposed/XC_MethodHook$MethodHookParam;->args:[Ljava/lang/Object;

    array-length v0, v0

    const/4 v1, 0x1

    if-ge v0, v1, :cond_0

    goto :goto_1

    .line 1007
    :cond_0
    iget-object v0, p1, Lde/robv/android/xposed/XC_MethodHook$MethodHookParam;->args:[Ljava/lang/Object;

    const/4 v2, 0x0

    aget-object v0, v0, v2

    invoke-static {v0}, Ljava/lang/String;->valueOf(Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v0

    .line 1008
    .local v0, "method":Ljava/lang/String;
    nop

    .line 1009
    const-string v3, "method_is_legend_available"

    invoke-virtual {v3, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v4

    const-string v5, "method_is_xm_legend_available"

    if-nez v4, :cond_1

    .line 1010
    invoke-virtual {v5, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v4

    if-eqz v4, :cond_2

    :cond_1
    move v2, v1

    .line 1012
    .local v2, "legacyLegend":Z
    :cond_2
    nop

    .line 1013
    const-string v4, "method_is_device_support_capabilities"

    invoke-virtual {v4, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v4

    .line 1015
    .local v4, "unifiedCapabilities":Z
    if-nez v2, :cond_3

    if-nez v4, :cond_3

    .line 1016
    return-void

    .line 1018
    :cond_3
    invoke-virtual {p1}, Lde/robv/android/xposed/XC_MethodHook$MethodHookParam;->getResult()Ljava/lang/Object;

    move-result-object v6

    instance-of v6, v6, Landroid/os/Bundle;

    if-eqz v6, :cond_4

    .line 1019
    invoke-virtual {p1}, Lde/robv/android/xposed/XC_MethodHook$MethodHookParam;->getResult()Ljava/lang/Object;

    move-result-object v6

    check-cast v6, Landroid/os/Bundle;

    goto :goto_0

    :cond_4
    new-instance v6, Landroid/os/Bundle;

    invoke-direct {v6}, Landroid/os/Bundle;-><init>()V

    .line 1020
    .local v6, "result":Landroid/os/Bundle;
    :goto_0
    if-eqz v2, :cond_5

    .line 1021
    const-string v7, "key_common_is_available"

    invoke-virtual {v6, v7, v1}, Landroid/os/Bundle;->putBoolean(Ljava/lang/String;Z)V

    .line 1027
    :cond_5
    invoke-virtual {v6, v3, v1}, Landroid/os/Bundle;->putBoolean(Ljava/lang/String;Z)V

    .line 1028
    invoke-virtual {v6, v5, v1}, Landroid/os/Bundle;->putBoolean(Ljava/lang/String;Z)V

    .line 1029
    invoke-virtual {p1, v6}, Lde/robv/android/xposed/XC_MethodHook$MethodHookParam;->setResult(Ljava/lang/Object;)V

    .line 1030
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "[LegendM9] MediaEditor provider capability=true method="

    invoke-virtual {v1, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-static {v1}, Llocal/mio/os4camerabridge/HookEntry;->-$$Nest$smlog(Ljava/lang/String;)V

    .line 1032
    return-void

    .line 1005
    .end local v0    # "method":Ljava/lang/String;
    .end local v2    # "legacyLegend":Z
    .end local v4    # "unifiedCapabilities":Z
    .end local v6    # "result":Landroid/os/Bundle;
    :cond_6
    :goto_1
    return-void
.end method
