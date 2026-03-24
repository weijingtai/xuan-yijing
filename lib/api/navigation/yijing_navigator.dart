import 'package:flutter/material.dart';
import '../../databases/MyDatabase.dart';
import 'yijing_routes.dart';

/// 易经模块导航工具类
/// 提供便捷的页面跳转方法
class YiJingNavigator {
  /// 导航到卦象列表页
  static Future<void> toGuaList(BuildContext context) {
    return Navigator.pushNamed(
      context,
      YiJingRoutes.guaList,
    );
  }

  /// 导航到卦象详情页
  /// [zhouYi] 周易卦象对象
  static Future<void> toGuaDetails(BuildContext context, ZhouYi zhouYi) {
    return Navigator.pushNamed(
      context,
      YiJingRoutes.guaDetails,
      arguments: {'zhouYi': zhouYi},
    );
  }

  /// 导航到卦象详情页（通过二进制编码）
  /// [guaBinary] 卦的二进制编码，如"111111"
  /// [database] 数据库实例，用于查询卦象信息
  static Future<void> toGuaDetailsByBinary(
    BuildContext context,
    String guaBinary,
    MyDatabase database,
  ) async {
    try {
      final zhouYi = await database.getZhouYiByBinary(guaBinary);
      if (context.mounted) {
        await Navigator.pushNamed(
          context,
          YiJingRoutes.guaDetails,
          arguments: {'zhouYi': zhouYi},
        );
      }
    } catch (e) {
      debugPrint('导航到卦象详情页失败: $e');
    }
  }

  /// 导航到卦象命中详情页
  /// [args] 参数，包含卦象信息
  static Future<void> toGuaHitDetails(
    BuildContext context,
    Map<String, dynamic> args,
  ) {
    return Navigator.pushNamed(
      context,
      YiJingRoutes.guaHitDetails,
      arguments: args,
    );
  }

  /// 导航到API测试页
  static Future<void> toApiTest(BuildContext context) {
    return Navigator.pushNamed(
      context,
      YiJingRoutes.apiTest,
    );
  }

  /// 返回上一页
  static void goBack(BuildContext context) {
    Navigator.pop(context);
  }

  /// 替换当前页面
  static Future<void> replaceWithGuaDetails(
    BuildContext context,
    ZhouYi zhouYi,
  ) {
    return Navigator.pushReplacementNamed(
      context,
      YiJingRoutes.guaDetails,
      arguments: {'zhouYi': zhouYi},
    );
  }

  /// 清除导航栈并导航到卦象列表页
  static Future<void> clearAndGoToGuaList(BuildContext context) {
    return Navigator.pushNamedAndRemoveUntil(
      context,
      YiJingRoutes.guaList,
      (route) => false,
    );
  }
}
