.class public final Llocal/mio/os4camerabridge/LegendarySettingsActivity;
.super Landroid/app/Activity;
.source "LegendarySettingsActivity.java"


# direct methods
.method public constructor <init>()V
    .locals 0

    .line 12
    invoke-direct {p0}, Landroid/app/Activity;-><init>()V

    return-void
.end method

.method static synthetic lambda$onCreate$0(Landroid/view/View;Landroid/view/WindowInsets;)Landroid/view/WindowInsets;
    .locals 4

    .line 25
    invoke-static {}, Landroid/view/WindowInsets$Type;->systemBars()I

    move-result v0

    invoke-virtual {p1, v0}, Landroid/view/WindowInsets;->getInsets(I)Landroid/graphics/Insets;

    move-result-object v0

    .line 26
    iget v1, v0, Landroid/graphics/Insets;->left:I

    iget v2, v0, Landroid/graphics/Insets;->top:I

    iget v3, v0, Landroid/graphics/Insets;->right:I

    iget v0, v0, Landroid/graphics/Insets;->bottom:I

    invoke-virtual {p0, v1, v2, v3, v0}, Landroid/view/View;->setPadding(IIII)V

    return-object p1
.end method

.method static synthetic lambda$option$1(Landroid/content/SharedPreferences;Ljava/lang/String;Landroid/widget/CompoundButton;Z)V
    .locals 0

    .line 44
    invoke-interface {p0}, Landroid/content/SharedPreferences;->edit()Landroid/content/SharedPreferences$Editor;

    move-result-object p0

    invoke-interface {p0, p1, p3}, Landroid/content/SharedPreferences$Editor;->putBoolean(Ljava/lang/String;Z)Landroid/content/SharedPreferences$Editor;

    move-result-object p0

    invoke-interface {p0}, Landroid/content/SharedPreferences$Editor;->apply()V

    return-void
.end method

.method private option(Landroid/widget/LinearLayout;Landroid/content/SharedPreferences;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Z)V
    .locals 3

    .line 41
    new-instance v0, Landroid/widget/Switch;

    invoke-direct {v0, p0}, Landroid/widget/Switch;-><init>(Landroid/content/Context;)V

    .line 42
    invoke-virtual {v0, p4}, Landroid/widget/Switch;->setText(Ljava/lang/CharSequence;)V

    const/high16 p4, 0x41900000    # 18.0f

    invoke-virtual {v0, p4}, Landroid/widget/Switch;->setTextSize(F)V

    const/16 p4, 0x1c

    const/16 v1, 0xc

    const/4 v2, 0x0

    invoke-virtual {v0, v2, p4, v2, v1}, Landroid/widget/Switch;->setPadding(IIII)V

    .line 43
    invoke-interface {p2, p3, v2}, Landroid/content/SharedPreferences;->getBoolean(Ljava/lang/String;Z)Z

    move-result p4

    invoke-virtual {v0, p4}, Landroid/widget/Switch;->setChecked(Z)V

    .line 44
    new-instance p4, Llocal/mio/os4camerabridge/LegendarySettingsActivity$$ExternalSyntheticLambda1;

    invoke-direct {p4, p2, p3}, Llocal/mio/os4camerabridge/LegendarySettingsActivity$$ExternalSyntheticLambda1;-><init>(Landroid/content/SharedPreferences;Ljava/lang/String;)V

    invoke-virtual {v0, p4}, Landroid/widget/Switch;->setOnCheckedChangeListener(Landroid/widget/CompoundButton$OnCheckedChangeListener;)V

    .line 45
    invoke-virtual {p1, v0}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;)V

    .line 46
    const/16 p2, 0xe

    invoke-direct {p0, p1, p5, p2}, Llocal/mio/os4camerabridge/LegendarySettingsActivity;->text(Landroid/widget/LinearLayout;Ljava/lang/String;I)Landroid/widget/TextView;

    move-result-object p1

    .line 47
    if-nez p6, :cond_0

    const/16 p2, 0xa0

    const/16 p3, 0x5a

    invoke-static {p2, p3, v2}, Landroid/graphics/Color;->rgb(III)I

    move-result p2

    invoke-virtual {p1, p2}, Landroid/widget/TextView;->setTextColor(I)V

    .line 48
    :cond_0
    return-void
.end method

.method private text(Landroid/widget/LinearLayout;Ljava/lang/String;I)Landroid/widget/TextView;
    .locals 2

    .line 50
    new-instance v0, Landroid/widget/TextView;

    invoke-direct {v0, p0}, Landroid/widget/TextView;-><init>(Landroid/content/Context;)V

    invoke-virtual {v0, p2}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    int-to-float p2, p3

    invoke-virtual {v0, p2}, Landroid/widget/TextView;->setTextSize(F)V

    const/16 p2, 0xc

    const/16 p3, 0x10

    const/4 v1, 0x0

    invoke-virtual {v0, v1, p2, v1, p3}, Landroid/widget/TextView;->setPadding(IIII)V

    .line 51
    invoke-virtual {p1, v0}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;)V

    return-object v0
.end method


# virtual methods
.method public onCreate(Landroid/os/Bundle;)V
    .locals 8

    .line 14
    const v0, 0x1030241

    invoke-virtual {p0, v0}, Llocal/mio/os4camerabridge/LegendarySettingsActivity;->setTheme(I)V

    .line 15
    invoke-super {p0, p1}, Landroid/app/Activity;->onCreate(Landroid/os/Bundle;)V

    .line 16
    invoke-static {p0}, Llocal/mio/os4camerabridge/LegendaryProcessingProvider;->grantCameraVisibility(Landroid/content/Context;)V

    .line 17
    const-string p1, "\u5f95\u5361\u5904\u7406\u8bbe\u7f6e"

    invoke-virtual {p0, p1}, Llocal/mio/os4camerabridge/LegendarySettingsActivity;->setTitle(Ljava/lang/CharSequence;)V

    .line 18
    const-string p1, "legendary_processing"

    const/4 v0, 0x0

    invoke-virtual {p0, p1, v0}, Llocal/mio/os4camerabridge/LegendarySettingsActivity;->getSharedPreferences(Ljava/lang/String;I)Landroid/content/SharedPreferences;

    move-result-object v3

    .line 19
    new-instance v2, Landroid/widget/LinearLayout;

    invoke-direct {v2, p0}, Landroid/widget/LinearLayout;-><init>(Landroid/content/Context;)V

    .line 20
    const/4 p1, 0x1

    invoke-virtual {v2, p1}, Landroid/widget/LinearLayout;->setOrientation(I)V

    .line 21
    invoke-virtual {p0}, Llocal/mio/os4camerabridge/LegendarySettingsActivity;->getResources()Landroid/content/res/Resources;

    move-result-object p1

    invoke-virtual {p1}, Landroid/content/res/Resources;->getDisplayMetrics()Landroid/util/DisplayMetrics;

    move-result-object p1

    iget p1, p1, Landroid/util/DisplayMetrics;->density:F

    const/high16 v0, 0x41c00000    # 24.0f

    mul-float/2addr p1, v0

    float-to-int p1, p1

    .line 22
    mul-int/lit8 v0, p1, 0x2

    invoke-virtual {v2, p1, v0, p1, p1}, Landroid/widget/LinearLayout;->setPadding(IIII)V

    .line 23
    new-instance p1, Landroid/widget/ScrollView;

    invoke-direct {p1, p0}, Landroid/widget/ScrollView;-><init>(Landroid/content/Context;)V

    invoke-virtual {p1, v2}, Landroid/widget/ScrollView;->addView(Landroid/view/View;)V

    invoke-virtual {p0, p1}, Llocal/mio/os4camerabridge/LegendarySettingsActivity;->setContentView(Landroid/view/View;)V

    .line 24
    new-instance v0, Llocal/mio/os4camerabridge/LegendarySettingsActivity$$ExternalSyntheticLambda0;

    invoke-direct {v0}, Llocal/mio/os4camerabridge/LegendarySettingsActivity$$ExternalSyntheticLambda0;-><init>()V

    invoke-virtual {p1, v0}, Landroid/widget/ScrollView;->setOnApplyWindowInsetsListener(Landroid/view/View$OnApplyWindowInsetsListener;)V

    .line 28
    const-string p1, "\u53ea\u63a7\u5236\u989d\u5916\u9002\u914d\uff0c\u4e0d\u5173\u95ed\u539f\u751f\u5f95\u5361\u6a21\u578b"

    const/16 v0, 0x17

    invoke-direct {p0, v2, p1, v0}, Llocal/mio/os4camerabridge/LegendarySettingsActivity;->text(Landroid/widget/LinearLayout;Ljava/lang/String;I)Landroid/widget/TextView;

    .line 29
    const-string p1, "M3 / M9 \u4f7f\u7528\u5404\u81ea\u5904\u7406\u6d41\u7a0b\u3002\u4e3b\u6a21\u578b\u3001colorfix\u3001\u66dd\u5149\u4e0e\u539f\u751f\u6761\u4ef6\u5224\u65ad\u4e0d\u53d7\u4e0b\u9762\u4e24\u4e2a\u5f00\u5173\u63a7\u5236\u3002\u5f00\u5173\u53ea\u5f71\u54cd\u65b0\u62cd\u7684\u7167\u7247\uff0c\u4e0d\u6539\u5df2\u6709\u7167\u7247\uff0c\u4e5f\u4e0d\u6539\u76f8\u518c\u624b\u52a8\u5904\u7406\u5165\u53e3\u3002"

    const/16 v0, 0x10

    invoke-direct {p0, v2, p1, v0}, Llocal/mio/os4camerabridge/LegendarySettingsActivity;->text(Landroid/widget/LinearLayout;Ljava/lang/String;I)Landroid/widget/TextView;

    .line 30
    const-string v6, "\u5f53\u524d APS \u8def\u5f84\u6ca1\u6709\u5c0f\u7c73 AISP \u66f2\u7ebf\u63a5\u53e3\uff1a\u6b64\u9009\u9879\u53ef\u4fdd\u5b58\uff0c\u4f46\u5c1a\u4e0d\u4f5c\u7528\u4e8e\u7167\u7247\u3002\u4e0d\u4f1a\u7528 JPEG \u4eae\u5ea6\u8c03\u6574\u5192\u5145\u539f\u751f Gamma\u3002"

    const/4 v7, 0x0

    const-string v4, "optional_aisp_gamma"

    const-string v5, "\u989d\u5916 AISP Gamma"

    move-object v1, p0

    invoke-direct/range {v1 .. v7}, Llocal/mio/os4camerabridge/LegendarySettingsActivity;->option(Landroid/widget/LinearLayout;Landroid/content/SharedPreferences;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Z)V

    .line 32
    const-string v6, "\u4ec5 M9 \u4e3b\u6444\u4e91\u8f93\u5165\uff1a\u4f7f\u7528\u53c2\u8003\u79fb\u690d\u5305\u7684\u8272\u5361\u6821\u51c6\u77e9\u9635\u3002\u5e76\u975e\u4e00\u52a0 13 \u6807\u5b9a\uff1b\u9ed8\u8ba4\u5173\u95ed\u3002\u4e0e\u672c\u5730 colorfix AI \u6a21\u578b\u65e0\u5173\u3002"

    const/4 v7, 0x1

    const-string v4, "optional_sensor_matrix"

    const-string v5, "\u989d\u5916\u4f20\u611f\u5668\u989c\u8272\u77e9\u9635\uff08\u5b9e\u9a8c\uff09"

    invoke-direct/range {v1 .. v7}, Llocal/mio/os4camerabridge/LegendarySettingsActivity;->option(Landroid/widget/LinearLayout;Landroid/content/SharedPreferences;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Z)V

    .line 34
    const-string p1, "Gamma \u4e0e\u77e9\u9635\u4e92\u76f8\u72ec\u7acb\u3002\u5df2\u542f\u7528\u4e0d\u7b49\u4e8e\u5f53\u524d\u5e27\u6ee1\u8db3\u5904\u7406\u6761\u4ef6\u3002"

    const/16 v3, 0xe

    invoke-direct {p0, v2, p1, v3}, Llocal/mio/os4camerabridge/LegendarySettingsActivity;->text(Landroid/widget/LinearLayout;Ljava/lang/String;I)Landroid/widget/TextView;

    .line 36
    :try_start_0
    invoke-virtual {p0}, Llocal/mio/os4camerabridge/LegendarySettingsActivity;->getContentResolver()Landroid/content/ContentResolver;

    move-result-object p1

    sget-object v0, Llocal/mio/os4camerabridge/LegendaryProcessingProvider;->URI:Landroid/net/Uri;

    const-string v4, "settings"

    const/4 v5, 0x0

    invoke-virtual {p1, v0, v4, v5, v5}, Landroid/content/ContentResolver;->call(Landroid/net/Uri;Ljava/lang/String;Ljava/lang/String;Landroid/os/Bundle;)Landroid/os/Bundle;

    move-result-object p1

    .line 37
    if-eqz p1, :cond_0

    const-string v0, "status"

    const-string v4, ""

    invoke-virtual {p1, v0, v4}, Landroid/os/Bundle;->getString(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object p1

    invoke-direct {p0, v2, p1, v3}, Llocal/mio/os4camerabridge/LegendarySettingsActivity;->text(Landroid/widget/LinearLayout;Ljava/lang/String;I)Landroid/widget/TextView;
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    .line 38
    :cond_0
    goto :goto_0

    :catch_0
    move-exception v0

    const-string p1, "\u5904\u7406\u72b6\u6001\u6682\u4e0d\u53ef\u8bfb"

    invoke-direct {p0, v2, p1, v3}, Llocal/mio/os4camerabridge/LegendarySettingsActivity;->text(Landroid/widget/LinearLayout;Ljava/lang/String;I)Landroid/widget/TextView;

    .line 39
    :goto_0
    return-void
.end method
