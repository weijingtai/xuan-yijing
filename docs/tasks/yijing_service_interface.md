# 易经服务接口实现任务

## 📋 任务概述

为 xuan-yijing 项目实现 xuan-common 中定义的易经服务接口，提供完整的易经卦象数据访问能力。

## 🎯 目标

让 xuan-yijing 成为 xuan-common 生态中易经功能的业务实现层，其他子项目可以通过 common 的接口调用易经功能。

## 📦 需要实现的接口

### 1. IGuaData 接口

**文件位置:** `lib/interfaces/yijing/i_gua_data.dart`

**实现要求:**
```dart
class GuaData implements IGuaData {
  @override
  final String binary;      // 卦的二进制编码（6位）
  
  @override
  final int seq;            // 卦序号（1-64）
  
  @override
  final String name;        // 卦名（简称）
  
  @override
  final String fullname;    // 卦全名
  
  @override
  final String? guaCi;      // 卦辞
  
  @override
  final String? tuanCi;     // 彖辞
  
  @override
  final String? xiangCi;    // 象辞
  
  @override
  final String? innerBaguaName;  // 内卦名称
  
  @override
  final String? outerBaguaName;  // 外卦名称
}
```

**任务清单:**
- [ ] 创建 `lib/models/gua_data_impl.dart`
- [ ] 实现 IGuaData 接口的所有属性
- [ ] 添加 fromJson/toJson 方法
- [ ] 添加从现有 ZhouYi 模型转换的方法

---

### 2. IYaoCiData 接口

**文件位置:** `lib/interfaces/yijing/i_yao_ci_data.dart`

**实现要求:**
```dart
class YaoCiData implements IYaoCiData {
  @override
  final int id;             // 爻ID
  
  @override
  final int seqInGua;       // 爻在卦中的序号（1-6）
  
  @override
  final String yaoName;     // 爻名（如"初九"、"六二"）
  
  @override
  final String guaYaoName;  // 卦爻名（如"乾·初九"）
  
  @override
  final String? yaoCi;      // 爻辞内容
  
  @override
  final String? xiangCi;    // 爻象辞
}
```

**任务清单:**
- [ ] 创建 `lib/models/yao_ci_data_impl.dart`
- [ ] 实现 IYaoCiData 接口的所有属性
- [ ] 添加 fromJson/toJson 方法
- [ ] 添加从现有 ZhouYiGuaYao 模型转换的方法

---

### 3. IYijingService 接口

**文件位置:** `lib/interfaces/yijing/i_yijing_service.dart`

**实现要求:**

#### 3.1 卦象查询方法

```dart
class YijingServiceImpl implements IYijingService {
  final YijingApi _api = YijingApi();
  
  @override
  Future<List<IGuaData>> getAllGua() async {
    // 实现获取所有卦象
  }
  
  @override
  Future<IGuaData?> getGuaByBinary(String binary) async {
    // 实现根据二进制获取卦象
  }
  
  @override
  Future<List<IGuaData>> searchGuaByName(String name) async {
    // 实现按名称搜索
  }
  
  @override
  Future<IGuaData?> getGuaBySeq(int seq) async {
    // 实现按序号获取
  }
}
```

**任务清单:**
- [ ] 创建 `lib/services/yijing_service_impl.dart`
- [ ] 实现 `getAllGua()` 方法
- [ ] 实现 `getGuaByBinary(binary)` 方法
- [ ] 实现 `searchGuaByName(name)` 方法
- [ ] 实现 `getGuaBySeq(seq)` 方法

#### 3.2 爻辞/彖辞/象辞方法

```dart
@override
Future<List<IYaoCiData>> getYaoCi(String guaBinary) async {
  // 实现获取爻辞列表
}

@override
Future<String?> getTuanCi(String guaBinary) async {
  // 实现获取彖辞
}

@override
Future<String?> getXiangCi(String guaBinary) async {
  // 实现获取象辞
}

@override
Future<String?> getGuaCi(String guaBinary) async {
  // 实现获取卦辞
}
```

**任务清单:**
- [ ] 实现 `getYaoCi(guaBinary)` 方法
- [ ] 实现 `getTuanCi(guaBinary)` 方法
- [ ] 实现 `getXiangCi(guaBinary)` 方法
- [ ] 实现 `getGuaCi(guaBinary)` 方法

#### 3.3 工具方法

```dart
@override
Future<bool> isValidBinary(String binary) async {
  // 实现验证二进制编码
}

@override
Future<int> getGuaCount() async {
  // 实现获取卦象数量
}
```

**任务清单:**
- [ ] 实现 `isValidBinary(binary)` 方法
- [ ] 实现 `getGuaCount()` 方法

---

## 🔗 依赖关系

### 需要依赖的 xuan-common 接口

```yaml
dependencies:
  common:
    git:
      url: https://github.com/weijingtai/xuan-common.git
      ref: feature/xuan-yijing-integration
```

### 导入路径

```dart
import 'package:common/interfaces/yijing/i_gua_data.dart';
import 'package:common/interfaces/yijing/i_yao_ci_data.dart';
import 'package:common/interfaces/yijing/i_yijing_service.dart';
```

---

## 📁 建议的文件结构

```
lib/
├── models/
│   ├── gua_data_impl.dart          # IGuaData 实现
│   └── yao_ci_data_impl.dart       # IYaoCiData 实现
├── services/
│   └── yijing_service_impl.dart    # IYijingService 实现
└── yijing_module.dart              # 导出实现类
```

---

## ✅ 验收标准

1. **接口完整性**: 所有接口方法都已实现
2. **类型安全**: 实现类正确实现接口，无类型错误
3. **数据转换**: 能够从现有数据模型正确转换
4. **可测试性**: 实现类可以被单元测试覆盖
5. **文档完整**: 添加必要的代码注释

---

## 🚀 实施步骤

### 第一阶段: 数据模型实现 (预计 1 小时)

1. 创建 `gua_data_impl.dart`
2. 创建 `yao_ci_data_impl.dart`
3. 实现数据转换逻辑

### 第二阶段: 服务实现 (预计 2 小时)

1. 创建 `yijing_service_impl.dart`
2. 实现卦象查询方法
3. 实现爻辞/彖辞/象辞方法
4. 实现工具方法

### 第三阶段: 集成测试 (预计 1 小时)

1. 编写单元测试
2. 验证接口调用
3. 修复问题

### 第四阶段: 文档和提交 (预计 30 分钟)

1. 更新 README
2. 添加使用示例
3. 提交代码并创建 PR

---

## 📝 备注

- 现有的 `YijingApi` 类已经包含了大部分业务逻辑，实现时可以直接复用
- 注意保持与 xuan-common 接口定义的一致性
- 实现类应该在 `yijing_module.dart` 中导出，供其他项目使用

---

## 🔗 相关链接

- xuan-common 仓库: https://github.com/weijingtai/xuan-common
- 分支: feature/xuan-yijing-integration
- 接口定义: lib/interfaces/yijing/
