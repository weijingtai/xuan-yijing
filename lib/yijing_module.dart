/// 易经模块
/// 提供完整的易经功能，包括数据API、UI组件和页面导航
library yijing_module;

// ==================== 数据层 ====================
// 导出数据库和表模型
export 'databases/MyDatabase.dart';
export 'models/ZhouYiTable.dart';
export 'models/ZhouYiGuaZhuTable.dart';
export 'models/ZhouYiYaoZhuTable.dart';
export 'models/ZhouYiGuaYaoTable.dart';
export 'models/ZhouYiZhuBooksTable.dart';
export 'models/JiaoShiYiLin.dart';

// 导出API层
export 'api/models/gua_data.dart';
export 'api/yijing_repository.dart';
export 'api/yijing_api.dart';

// ==================== 导航层 ====================
export 'api/navigation/yijing_routes.dart';
export 'api/navigation/yijing_navigator.dart';

// ==================== UI层 ====================
// 导出页面
export 'pages/zhou_yi_gua_list.dart';
export 'pages/zhou_yi_gua_details_page.dart';
export 'pages/gua_details_page.dart' hide GuaSizeType;
export 'pages/yijing_api_test_page.dart';

// 导出组件
export 'widgets/zhou_yi_gua_widget.dart';
export 'widgets/tiny_zhou_yi_gua_widget.dart';
export 'widgets/small_zhou_yi_gua_widget.dart';
export 'widgets/mini_zhou_yi_gua_widget.dart';
export 'widgets/polygonal.dart';
