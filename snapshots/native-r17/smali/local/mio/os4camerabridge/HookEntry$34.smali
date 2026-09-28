.class Llocal/mio/os4camerabridge/HookEntry$34;
.super Lde/robv/android/xposed/XC_MethodHook;
.source "HookEntry.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Llocal/mio/os4camerabridge/HookEntry;->hookFrontBeautyTypeCompatibility(Ljava/lang/ClassLoader;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic val$typeElementsBeauty:Ljava/lang/Class;


# direct methods
.method constructor <init>(Ljava/lang/Class;)V
    .locals 0

    .line 7389
    iput-object p1, p0, Llocal/mio/os4camerabridge/HookEntry$34;->val$typeElementsBeauty:Ljava/lang/Class;

    invoke-direct {p0}, Lde/robv/android/xposed/XC_MethodHook;-><init>()V

    return-void
.end method


# virtual methods
.method protected afterHookedMethod(Lde/robv/android/xposed/XC_MethodHook$MethodHookParam;)V
    .locals 12
    .param p1, "param"    # Lde/robv/android/xposed/XC_MethodHook$MethodHookParam;

    .line 7400
    sget-object v0, Ljava/lang/Boolean;->TRUE:Ljava/lang/Boolean;

    const-string v1, "os4OplusBeautyPanel"

    invoke-virtual {p1, v1}, Lde/robv/android/xposed/XC_MethodHook$MethodHookParam;->getObjectExtra(Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/Boolean;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-nez v0, :cond_0

    .line 7402
    return-void

    .line 7405
    :cond_0
    const/16 v0, 0x8

    :try_start_0
    new-array v0, v0, [Ljava/lang/String;

    const-string v1, "pref_beautify_skin_smooth_ratio_key"

    const/4 v2, 0x0

    aput-object v1, v0, v2

    const-string v1, "pref_beautify_slim_face_ratio_key"

    const/4 v3, 0x1

    aput-object v1, v0, v3

    const-string v1, "pref_beautify_enlarge_eye_ratio_key"

    const/4 v4, 0x2

    aput-object v1, v0, v4

    const-string v1, "pref_beautify_down_head_narrow"

    const/4 v4, 0x3

    aput-object v1, v0, v4

    const-string v1, "pref_beautify_slim_nose_ratio_key"

    const/4 v4, 0x4

    aput-object v1, v0, v4

    const-string v1, "pref_beautify_hairline_ratio_key"

    const/4 v4, 0x5

    aput-object v1, v0, v4

    const-string v1, "pref_beautify_temple"

    const/4 v4, 0x6

    aput-object v1, v0, v4

    const-string v1, "pref_beautify_cheekbone"

    const/4 v4, 0x7

    aput-object v1, v0, v4

    .line 7415
    .local v0, "keys":[Ljava/lang/String;
    new-instance v1, Ljava/util/ArrayList;

    array-length v4, v0

    invoke-direct {v1, v4}, Ljava/util/ArrayList;-><init>(I)V

    .line 7416
    .local v1, "controls":Ljava/util/ArrayList;, "Ljava/util/ArrayList<Ljava/lang/Object;>;"
    array-length v4, v0

    move v5, v2

    :goto_0
    if-ge v5, v4, :cond_2

    aget-object v6, v0, v5

    .line 7417
    .local v6, "key":Ljava/lang/String;
    iget-object v7, p0, Llocal/mio/os4camerabridge/HookEntry$34;->val$typeElementsBeauty:Ljava/lang/Class;

    const-string v8, "c"

    const-string v9, "4"

    .line 7419
    invoke-static {v2}, Ljava/lang/Boolean;->valueOf(Z)Ljava/lang/Boolean;

    move-result-object v10

    iget-object v11, p1, Lde/robv/android/xposed/XC_MethodHook$MethodHookParam;->args:[Ljava/lang/Object;

    aget-object v11, v11, v3

    filled-new-array {v9, v6, v10, v11}, [Ljava/lang/Object;

    move-result-object v9

    .line 7417
    invoke-static {v7, v8, v9}, Lde/robv/android/xposed/XposedHelpers;->callStaticMethod(Ljava/lang/Class;Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v7

    .line 7420
    .local v7, "control":Ljava/lang/Object;
    if-eqz v7, :cond_1

    .line 7421
    invoke-virtual {v1, v7}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    .line 7416
    .end local v6    # "key":Ljava/lang/String;
    .end local v7    # "control":Ljava/lang/Object;
    :cond_1
    add-int/lit8 v5, v5, 0x1

    goto :goto_0

    .line 7424
    :cond_2
    invoke-virtual {p1, v1}, Lde/robv/android/xposed/XC_MethodHook$MethodHookParam;->setResult(Ljava/lang/Object;)V

    .line 7425
    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "[BeautyCompat] OPlus mapped controls="

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    .line 7426
    invoke-virtual {v1}, Ljava/util/ArrayList;->size()I

    move-result v3

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    .line 7425
    invoke-static {v2}, Llocal/mio/os4camerabridge/HookEntry;->-$$Nest$smlog(Ljava/lang/String;)V
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 7430
    .end local v0    # "keys":[Ljava/lang/String;
    .end local v1    # "controls":Ljava/util/ArrayList;, "Ljava/util/ArrayList<Ljava/lang/Object;>;"
    goto :goto_1

    .line 7427
    :catchall_0
    move-exception v0

    .line 7428
    .local v0, "throwable":Ljava/lang/Throwable;
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "[BeautyCompat] mapped panel construction failed: "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-static {v1}, Llocal/mio/os4camerabridge/HookEntry;->-$$Nest$smlog(Ljava/lang/String;)V

    .line 7431
    .end local v0    # "throwable":Ljava/lang/Throwable;
    :goto_1
    return-void
.end method

.method protected beforeHookedMethod(Lde/robv/android/xposed/XC_MethodHook$MethodHookParam;)V
    .locals 2
    .param p1, "param"    # Lde/robv/android/xposed/XC_MethodHook$MethodHookParam;

    .line 7392
    iget-object v0, p1, Lde/robv/android/xposed/XC_MethodHook$MethodHookParam;->args:[Ljava/lang/Object;

    if-eqz v0, :cond_0

    iget-object v0, p1, Lde/robv/android/xposed/XC_MethodHook$MethodHookParam;->args:[Ljava/lang/Object;

    array-length v0, v0

    const/4 v1, 0x3

    if-ne v0, v1, :cond_0

    iget-object v0, p1, Lde/robv/android/xposed/XC_MethodHook$MethodHookParam;->args:[Ljava/lang/Object;

    const/4 v1, 0x2

    aget-object v0, v0, v1

    .line 7393
    const-string v1, "4"

    invoke-virtual {v1, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_0

    .line 7394
    const-string v0, "os4OplusBeautyPanel"

    sget-object v1, Ljava/lang/Boolean;->TRUE:Ljava/lang/Boolean;

    invoke-virtual {p1, v0, v1}, Lde/robv/android/xposed/XC_MethodHook$MethodHookParam;->setObjectExtra(Ljava/lang/String;Ljava/lang/Object;)V

    .line 7396
    :cond_0
    return-void
.end method
