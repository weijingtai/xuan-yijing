# 易经模块使用指南

## 概述

易经模块提供完整的易经功能，包括：
- **数据API** - 查询卦象、爻辞、彖辞、象辞等
- **UI组件** - 可复用的卦象展示组件
- **页面导航** - 预制的页面和路由配置

## 快速开始

### 1. 引入模块

```dart
import 'package:my_flutter/yijing_module.dart';
```

### 2. 初始化数据库

```dart
void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Get.put<MyDatabase>(MyDatabase());
  runApp(const MyApp());
}
```

### 3. 集成路由

```dart
MaterialApp(
  // 方式1: 合并路由表
  routes: {
    ...YiJingRoutes.routes,
    '/other': (context) => OtherPage(),
  },
  
  // 方式2: 使用路由生成器
  onGenerateRoute: (settings) {
    if (YiJingRoutes.isYiJingRoute(settings.name)) {
      return YiJingRoutes.onGenerateRoute(settings);
    }
    // 处理其他路由...
  },
)
```

## 使用方式

### 方式1: 使用API获取数据

```dart
import 'package:my_flutter/yijing_api.dart';

// 初始化API
final api = YijingApi();
await api.init();

// 获取所有卦象
final allGua = await api.getAllGua();

// 获取乾卦详情
final gua = await api.getFullGuaData('111111');
print(gua?.data?.fullname);  // 输出: 乾为天

// 获取爻辞
final yaos = await api.getYaoCi('111111');
for (final yao in yaos.data ?? []) {
  print('${yao.yaoName}: ${yao.yaoCi}');
}

// 搜索卦象
final results = await api.searchGuaByName('乾');
```

### 方式2: 使用预制页面

```dart
import 'package:my_flutter/yijing_module.dart';

// 导航到卦象列表页
YiJingNavigator.toGuaList(context);

// 导航到卦象详情页
final database = Get.find<MyDatabase>();
final zhouYi = await database.getZhouYiByBinary('111111');
YiJingNavigator.toGuaDetails(context, zhouYi);

// 通过二进制编码导航
YiJingNavigator.toGuaDetailsByBinary(context, '111111', database);

// 导航到API测试页
YiJingNavigator.toApiTest(context);
```

### 方式3: 使用UI组件

```dart
import 'package:my_flutter/yijing_module.dart';

// 使用卦象组件
ZhouYiGuaWidget(
  zhouYi: zhouYi,
  width: 256,
  height: 256,
  onTap: () {
    YiJingNavigator.toGuaDetails(context, zhouYi);
  },
)

// 使用小型卦象组件
SmallZhouYiGuaWidget(
  zhouYi: zhouYi,
  width: 128,
  height: 128,
)

// 使用迷你卦象组件
MiniZhouYiGuaWidget(
  zhouYi: zhouYi,
  width: 64,
  height: 64,
)
```

## API参考

### YijingApi 类

| 方法 | 说明 | 返回类型 |
|------|------|----------|
| `init()` | 初始化API | `Future<void>` |
| `getAllGua()` | 获取所有卦象 | `Future<ApiResponse<List<ZhouYi>>>` |
| `getGuaByBinary(binary)` | 根据二进制获取卦象 | `Future<ApiResponse<ZhouYi?>>` |
| `searchGuaByName(name)` | 按名称搜索卦象 | `Future<ApiResponse<List<ZhouYi>>>` |
| `getGuaBySeq(seq)` | 根据序号获取卦象 | `Future<ApiResponse<ZhouYi?>>` |
| `getYaoCi(binary)` | 获取爻辞 | `Future<ApiResponse<List<YaoData>>>` |
| `getTuanCi(binary)` | 获取彖辞 | `Future<ApiResponse<String?>>` |
| `getXiangCi(binary)` | 获取象辞 | `Future<ApiResponse<String?>>` |
| `getGuaCi(binary)` | 获取卦辞 | `Future<ApiResponse<String?>>` |
| `getGuaZhu(binary)` | 获取卦辞注解 | `Future<ApiResponse<List<GuaZhuData>>>` |
| `getAllBooks()` | 获取所有注书 | `Future<ApiResponse<List<BookInfo>>>` |
| `getFullGuaData(binary)` | 获取完整数据 | `Future<ApiResponse<GuaData?>>` |
| `dispose()` | 释放资源 | `Future<void>` |

### YiJingRoutes 类

| 路由常量 | 说明 |
|----------|------|
| `guaList` | 卦象列表页 |
| `guaDetails` | 卦象详情页 |
| `guaHitDetails` | 卦象命中详情页 |
| `apiTest` | API测试页 |

### YiJingNavigator 类

| 方法 | 说明 |
|------|------|
| `toGuaList(context)` | 导航到卦象列表页 |
| `toGuaDetails(context, zhouYi)` | 导航到卦象详情页 |
| `toGuaDetailsByBinary(context, binary, database)` | 通过二进制导航到详情页 |
| `toGuaHitDetails(context, args)` | 导航到卦象命中详情页 |
| `toApiTest(context)` | 导航到API测试页 |
| `goBack(context)` | 返回上一页 |

## 数据模型

### GuaData

```dart
class GuaData {
  final String binary;      // 二进制编码
  final int seq;            // 卦序号
  final String name;        // 卦名
  final String fullname;    // 卦全名
  final String? guaCi;      // 卦辞
  final String? tuanCi;     // 彖辞
  final String? xiangCi;    // 象辞
  final List<YaoData>? yaoCi;  // 爻辞列表
  final BaguaInfo? innerBagua; // 内卦
  final BaguaInfo? outerBagua; // 外卦
}
```

### YaoData

```dart
class YaoData {
  final int id;
  final int seqInGua;       // 爻在卦中的序号
  final String yaoName;     // 爻名（如"初九"）
  final String guaYaoName;  // 卦爻名（如"乾·初九"）
  final String? yaoCi;      // 爻辞
  final String? xiangCi;    // 爻象辞
  final List<YaoZhuData>? annotations; // 注解
}
```

## 示例

### 完整示例: 创建一个卦象展示页面

```dart
import 'package:flutter/material.dart';
import 'package:my_flutter/yijing_module.dart';

class MyGuaPage extends StatefulWidget {
  @override
  State<MyGuaPage> createState() => _MyGuaPageState();
}

class _MyGuaPageState extends State<MyGuaPage> {
  final YijingApi _api = YijingApi();
  List<ZhouYi> _guaList = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    await _api.init();
    final response = await _api.getAllGua();
    if (response.code == 200) {
      setState(() {
        _guaList = response.data ?? [];
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return Center(child: CircularProgressIndicator());
    }

    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 4,
        childAspectRatio: 0.8,
      ),
      itemCount: _guaList.length,
      itemBuilder: (context, index) {
        final gua = _guaList[index];
        return SmallZhouYiGuaWidget(
          zhouYi: gua,
          onTap: () => YiJingNavigator.toGuaDetails(context, gua),
        );
      },
    );
  }

  @override
  void dispose() {
    _api.dispose();
    super.dispose();
  }
}
```

## 注意事项

1. **数据库初始化**: 使用前必须先初始化数据库
2. **资源释放**: 使用完API后调用`dispose()`释放资源
3. **异步操作**: 所有API方法都是异步的，需要使用`await`
4. **错误处理**: 建议检查`ApiResponse.code`和`error`字段

## 测试

访问 `/yijing-api-test` 路由可以打开API测试页面，验证所有功能是否正常。
