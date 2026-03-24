# yijing

易经占卜应用 - 基于Flutter开发的周易卦象展示工具

## 功能特性

- 🎯 **周易卦象展示** - 64卦完整数据展示
- 📖 **爻辞/彖辞/象辞** - 详细的卦象解读
- 📚 **注书参考** - 多种易学注解
- 🔮 **焦氏易林** - 焦氏易林占卜系统

## 技术栈

- **框架**: Flutter 3.0+
- **数据库**: Drift (SQLite)
- **状态管理**: GetX
- **UI组件**: Material Design

## 快速开始

### 安装依赖

```bash
flutter pub get
```

### 运行应用

```bash
flutter run -d windows  # Windows
flutter run -d macos    # macOS
flutter run -d linux    # Linux
```

### 生成数据库代码

```bash
flutter pub run build_runner build
```

## 模块化架构

本项目已实现模块化设计，可通过以下方式使用：

### 方式1: 作为子模块引用

```yaml
# 在大项目的pubspec.yaml中
dependencies:
  yijing_module:
    path: ../yijing
```

### 方式2: 使用API

```dart
import 'package:yijing/yijing_api.dart';

final api = YijingApi();
await api.init();
final gua = await api.getFullGuaData('111111');
```

### 方式3: 使用UI组件

```dart
import 'package:yijing/yijing_module.dart';

ZhouYiGuaWidget(
  zhouYi: zhouYi,
  onTap: () => YiJingNavigator.toGuaDetails(context, zhouYi),
)
```

详细使用文档请查看 [YIJING_MODULE_README.md](YIJING_MODULE_README.md)

## 项目结构

```
lib/
├── api/                    # API层
│   ├── models/            # 数据模型
│   ├── navigation/        # 导航配置
│   ├── yijing_api.dart    # API主入口
│   └── yijing_repository.dart  # 数据仓库
├── databases/             # 数据库
├── models/                # 数据表模型
├── pages/                 # 页面
├── widgets/               # 组件
├── yijing_api.dart        # API导出
└── yijing_module.dart     # 模块导出
```

## 开发计划

- [x] 周易卦象展示
- [x] 爻辞/彖辞/象辞查询
- [x] 注书参考系统
- [x] 焦氏易林
- [x] 模块化API设计

## 贡献

欢迎提交Issue和Pull Request！

## 许可证

本项目采用 MIT 许可证。

## 联系方式

- GitHub: [weijingtai](https://github.com/weijingtai)
