.class Llocal/mio/os4camerabridge/HookEntry$28;
.super Lde/robv/android/xposed/XC_MethodHook;
.source "HookEntry.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Llocal/mio/os4camerabridge/HookEntry;->hookLegendaryRawPipeline(Ljava/lang/ClassLoader;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic val$parallelTask:Ljava/lang/Class;


# direct methods
.method constructor <init>(Ljava/lang/Class;)V
    .locals 0

    .line 6679
    iput-object p1, p0, Llocal/mio/os4camerabridge/HookEntry$28;->val$parallelTask:Ljava/lang/Class;

    invoke-direct {p0}, Lde/robv/android/xposed/XC_MethodHook;-><init>()V

    return-void
.end method


# virtual methods
.method protected beforeHookedMethod(Lde/robv/android/xposed/XC_MethodHook$MethodHookParam;)V
    .locals 4
    .param p1, "param"    # Lde/robv/android/xposed/XC_MethodHook$MethodHookParam;

    .line 6682
    invoke-static {}, Llocal/mio/os4camerabridge/HookEntry;->-$$Nest$sfgetactiveCameraModule()I

    move-result v0

    const/16 v1, 0x100

    if-ne v0, v1, :cond_4

    iget-object v0, p1, Lde/robv/android/xposed/XC_MethodHook$MethodHookParam;->args:[Ljava/lang/Object;

    if-eqz v0, :cond_4

    iget-object v0, p1, Lde/robv/android/xposed/XC_MethodHook$MethodHookParam;->args:[Ljava/lang/Object;

    array-length v0, v0

    const/4 v1, 0x1

    if-ne v0, v1, :cond_4

    iget-object v0, p0, Llocal/mio/os4camerabridge/HookEntry$28;->val$parallelTask:Ljava/lang/Class;

    iget-object v2, p1, Lde/robv/android/xposed/XC_MethodHook$MethodHookParam;->args:[Ljava/lang/Object;

    const/4 v3, 0x0

    aget-object v2, v2, v3

    .line 6684
    invoke-virtual {v0, v2}, Ljava/lang/Class;->isInstance(Ljava/lang/Object;)Z

    move-result v0

    if-nez v0, :cond_0

    goto :goto_1

    .line 6687
    :cond_0
    invoke-static {}, Llocal/mio/os4camerabridge/HookEntry;->-$$Nest$sfgetactiveLegendMode()I

    move-result v0

    if-ne v0, v1, :cond_2

    .line 6688
    invoke-static {}, Llocal/mio/os4camerabridge/HookEntry;->-$$Nest$sfgetlegendRawSessionActive()Z

    move-result v0

    if-eqz v0, :cond_1

    .line 6689
    iget-object v0, p1, Lde/robv/android/xposed/XC_MethodHook$MethodHookParam;->args:[Ljava/lang/Object;

    aget-object v0, v0, v3

    invoke-static {v0}, Llocal/mio/os4camerabridge/HookEntry;->-$$Nest$smwrapLegendaryStoreTask(Ljava/lang/Object;)V

    goto :goto_0

    .line 6691
    :cond_1
    iget-object v0, p1, Lde/robv/android/xposed/XC_MethodHook$MethodHookParam;->args:[Ljava/lang/Object;

    aget-object v0, v0, v3

    invoke-static {v0, v1}, Llocal/mio/os4camerabridge/HookEntry;->-$$Nest$smtagLegendaryStoreTask(Ljava/lang/Object;I)V

    goto :goto_0

    .line 6693
    :cond_2
    invoke-static {}, Llocal/mio/os4camerabridge/HookEntry;->-$$Nest$sfgetactiveLegendMode()I

    move-result v0

    const/4 v1, 0x2

    if-ne v0, v1, :cond_3

    .line 6694
    iget-object v0, p1, Lde/robv/android/xposed/XC_MethodHook$MethodHookParam;->args:[Ljava/lang/Object;

    aget-object v0, v0, v3

    invoke-static {v0, v1}, Llocal/mio/os4camerabridge/HookEntry;->-$$Nest$smtagLegendaryStoreTask(Ljava/lang/Object;I)V

    .line 6696
    :cond_3
    :goto_0
    return-void

    .line 6685
    :cond_4
    :goto_1
    return-void
.end method
