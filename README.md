# 小米相机 LSPosed 修复与徕卡本地处理研究

归档我们在欧加硬件、移植系统上修复小米相机的 Java / C++ / Smali 源码。保留小米 UI，通过 LSPosed、欧加拍摄兼容桥和独立 native worker 接入图像处理。

**找到的最后一轮部署产物：2026-09-09 的 `native-r17`，包名 `local.mio.os4camerabridge`，versionCode 202，versionName `0.4.92-live-photo-r17`。**

它包含徕卡 **M3 本地 Monopan 处理链**，不是只有水印、普通 LUT 或“云处理完成”标记。历史运行记录确认过 mode=2 实际 native 处理完成并提交成片。此结论不等于所有拍摄模式、所有手机或原厂完整算法均已移植。

## 两种代码快照，请勿混淆

| 内容 | 位置 | 用途 |
| --- | --- | --- |
| 可继续研究的 Java / C++ 工程 | `app/`、`native/` | 开发源码；Gradle 版本仍为 0.4.77 / 187 |
| 最后部署模块的自有类 Smali | `snapshots/native-r17/smali/` | r17 实际实现核对，366 个自有命名空间文件 |
| 当时的增量编译、容器与 native patch 脚本 | `historical/native-r17-build/` | 研究构建过程，保留历史路径结构；不是即点即用脚本 |
| 中文复原说明 | `docs/` | 版本差异、本地链、依赖与验证边界 |

最后几个版本采用“稳定 APK 基线 + 指定 Java helper 重编译 + 窄范围 Smali 覆盖”，**没有把整个 Gradle 工程重新构建后当作部署版**。直接运行 Gradle不会逐字节复现 r17；不要仅把版本号改成 202 就声称等价。

## 代码涉及的功能

- 拍照、预览、镜头切换、变焦、欧加 vendor tag 与 APS 兼容。
- 美颜美型、专业/RAW、滤镜/徕卡风格、旋转、图库跳转与水印保存链。
- 徕卡 M3 / M9 原生处理隔离 worker、JPEG/YUV 转换、RAW 附件/容器和同一张照片的元数据一致性。
- DexKit 辅助定位与调用条件校验，减少部分混淆名绑定；并非完全不受 APK 版本影响。
- 部分动态照片、视频/帧率和其他模式修复实验。

这是长期研究的源码归档，不是宣称以上功能全部稳定的发行成品。历史失败分支、机型相关逻辑和探针也可能仍在代码里，刷机前请阅读调用范围及失败回退路径。

## 从哪里看 M3

先读 [最后版本与本地链路](docs/最后版本与M3链路.md)，再看：

- `LegendaryNativeCaptureBridge.java`：拍摄保存链入口、条件和回退。
- `LegendaryProcessingProvider.java`：调用方检查、文件描述符与任务执行。
- `native/legend_native_worker.cpp`：Monopan / M9 native 实际调用。
- `native/legend_pixel_codec.cpp`：JPEG 像素和 NV12 转换。
- `LegendarySaveContractBridge.java`、`LegendM9Container.java`：保存契约、容器和后续水印衔接。
- `snapshots/native-r17/smali/local/mio/os4camerabridge/`：核对最终部署行为。

上述 Java 文件均在 `app/src/main/java/local/mio/os4camerabridge/`。

## 构建与外部依赖

工程使用 Java 17 语言级别、Android SDK 36、arm64、Xposed API 82、DexKit 2.2.0 和 TensorFlow Lite 2.17.0。Gradle/AGP 版本按 wrapper 与根构建文件；native 历史脚本使用 Windows NDK r28c。

**完整闭源依赖已作为独立 Release 材料包提供**，包括 r17 基线内的算法模型、QNN、美颜库、兼容参数和水印资源，另外附带未修补的 M9 runtime、构建用 apktool 和历史 donor 相机 APK。需要的原件及放置位置列在 [外部素材与复原方法](docs/外部素材与复原方法.md)，权利及来源见 [闭源素材说明](docs/闭源素材与来源.md)。不上传个人照片、设备日志、账号凭据或签名私钥。

## Actions 构建完整成品

打开 Actions，运行“构建完整 r17 模块 APK”。它会自动下载 `native-r17-materials` Release 的完整材料、安装 SDK/NDK，重新组装最终 Smali、编译三个自有 native 组件、从未修改原件 patch M9 runtime，再保留其余模型/算法/资源并签名产出完整 APK。

这里的构建真值是最终 r17 Smali，不是未同步的 Gradle 187 工程，也不是改个文件名上传旧 APK。工作流会检查必要闭源资源存在且未意外改变。

主仓库使用 GitHub Secrets 中独立的 CI 签名，私钥不进 Git 或 Release；Fork 未配置签名 Secret 时会生成临时签名，可安装但下次可能不能覆盖。CI 签名与历史本地签名不同，安装方式和设备要求见 [使用说明](docs/使用说明.md)。

历史作用域声明包含 `com.android.camera`、`com.oplus.camera` 和 `com.miui.mediaeditor`，用于不同阶段的研究。发布脚本不会替使用者勾选手机上的作用域；不要无差别全选。复用本研究时必须审计 HookEntry 的实际包名分支与设备条件，一加相机共存也要实机回归。

## 致谢

感谢 **kde_yyds** 的 crDroid / AlphaDroid 欧加相机移植贡献，感谢 **ColorOS陈稀**，以及 Xposed/LSPosed、DexKit、Android 开源项目的维护者。

本仓库与小米、徕卡、OPPO、OnePlus、Qualcomm 无官方关系。第三方算法、模型和反编译接口的权利仍归原权利人；此处公开研究源码不赋予这些材料新的使用或转授权许可。
