package local.mio.os4camerabridge;
import android.app.Activity;
import android.content.SharedPreferences;
import android.os.Bundle;
import android.graphics.Color;
import android.widget.LinearLayout;
import android.widget.ScrollView;
import android.widget.Switch;
import android.widget.TextView;

/** Two independent donor adaptation options; all native model decisions stay independent. */
public final class LegendarySettingsActivity extends Activity {
    @Override public void onCreate(Bundle state) {
        setTheme(android.R.style.Theme_Material_Light_NoActionBar);
        super.onCreate(state);
        LegendaryProcessingProvider.grantCameraVisibility(this);
        setTitle("徕卡处理设置");
        SharedPreferences prefs = getSharedPreferences(LegendaryProcessingProvider.PREFS, MODE_PRIVATE);
        LinearLayout layout = new LinearLayout(this);
        layout.setOrientation(LinearLayout.VERTICAL);
        int pad = (int)(24 * getResources().getDisplayMetrics().density);
        layout.setPadding(pad, pad * 2, pad, pad);
        ScrollView scroll = new ScrollView(this); scroll.addView(layout); setContentView(scroll);
        scroll.setOnApplyWindowInsetsListener((view, insets) -> {
            android.graphics.Insets system=insets.getInsets(android.view.WindowInsets.Type.systemBars());
            view.setPadding(system.left,system.top,system.right,system.bottom);return insets;
        });
        text(layout, "只控制额外适配，不关闭原生徕卡模型", 23);
        text(layout, "M3 / M9 使用各自处理流程。主模型、colorfix、曝光与原生条件判断不受下面两个开关控制。开关只影响新拍的照片，不改已有照片，也不改相册手动处理入口。", 16);
        option(layout, prefs, LegendaryProcessingProvider.GAMMA, "额外 AISP Gamma", 
                "当前 APS 路径没有小米 AISP 曲线接口：此选项可保存，但尚不作用于照片。不会用 JPEG 亮度调整冒充原生 Gamma。", false);
        option(layout, prefs, LegendaryProcessingProvider.MATRIX, "额外传感器颜色矩阵（实验）", 
                "仅 M9 主摄云输入：使用参考移植包的色卡校准矩阵。并非一加 13 标定；默认关闭。与本地 colorfix AI 模型无关。", true);
        text(layout, "Gamma 与矩阵互相独立。已启用不等于当前帧满足处理条件。", 14);
        try {
            Bundle result = getContentResolver().call(LegendaryProcessingProvider.URI, "settings", null, null);
            if (result != null) text(layout, result.getString("status", ""), 14);
        } catch (Exception error) { text(layout, "处理状态暂不可读", 14); }
    }
    private void option(LinearLayout layout, SharedPreferences prefs, String key, String title, String description, boolean available) {
        Switch control = new Switch(this);
        control.setText(title); control.setTextSize(18); control.setPadding(0, 28, 0, 12);
        control.setChecked(prefs.getBoolean(key, false));
        control.setOnCheckedChangeListener((button, checked) -> prefs.edit().putBoolean(key, checked).apply());
        layout.addView(control);
        TextView details = text(layout, description, 14);
        if (!available) details.setTextColor(Color.rgb(160, 90, 0));
    }
    private TextView text(LinearLayout layout, String value, int size) {
        TextView text = new TextView(this); text.setText(value); text.setTextSize(size); text.setPadding(0, 12, 0, 16);
        layout.addView(text); return text;
    }
}
