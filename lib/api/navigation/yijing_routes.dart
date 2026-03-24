import 'package:flutter/material.dart';
import '../../pages/zhou_yi_gua_list.dart';
import '../../pages/zhou_yi_gua_details_page.dart';
import '../../pages/gua_details_page.dart';
import '../../pages/yijing_api_test_page.dart';
import '../../databases/MyDatabase.dart';
import '../../yijing_api.dart';

/// 易经模块路由配置
/// 提供给大项目集成使用的路由表
class YiJingRoutes {
  // 路由常量
  static const String prefix = '/yijing';
  static const String guaList = '$prefix/gua-list';
  static const String guaDetails = '$prefix/gua-details';
  static const String guaHitDetails = '$prefix/gua-hit-details';
  static const String apiTest = '$prefix/api-test';

  /// 获取路由表
  /// 可以直接合并到大项目的路由表中
  static Map<String, WidgetBuilder> get routes => {
        guaList: (context) => const ZhouYiGuaListPage(),
        guaDetails: (context) {
          final args = ModalRoute.of(context)?.settings.arguments;
          if (args is Map<String, dynamic>) {
            return ZhouYiGuaDetailsPage(args);
          }
          return const ZhouYiGuaListPage(); // 回退到列表页
        },
        guaHitDetails: (context) => const GuaDetailsPage(),
        apiTest: (context) => const YijingApiTestPage(),
      };

  /// 获取路由生成器
  /// 用于 onGenerateRoute
  static Route<dynamic>? onGenerateRoute(RouteSettings settings) {
    final routeBuilder = routes[settings.name];
    if (routeBuilder != null) {
      return MaterialPageRoute(
        builder: routeBuilder,
        settings: settings,
      );
    }
    return null;
  }

  /// 检查路由是否属于易经模块
  static bool isYiJingRoute(String? routeName) {
    return routeName != null && routeName.startsWith(prefix);
  }

  /// 导航到卦象详情页（便捷方法）
  static Route<dynamic> toGuaDetails(RouteSettings settings) {
    final args = settings.arguments;
    if (args is Map<String, dynamic>) {
      return MaterialPageRoute(
        builder: (context) => ZhouYiGuaDetailsPage(args),
        settings: settings,
      );
    } else if (args is ZhouYi) {
      // 支持直接传入ZhouYi对象
      return MaterialPageRoute(
        builder: (context) => ZhouYiGuaDetailsPage({'zhouYi': args}),
        settings: settings,
      );
    }
    // 回退到列表页
    return MaterialPageRoute(
      builder: (context) => const ZhouYiGuaListPage(),
      settings: settings,
    );
  }
}
