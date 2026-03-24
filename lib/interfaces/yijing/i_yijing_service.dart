import 'i_gua_data.dart';
import 'i_yao_ci_data.dart';

/// 易经服务接口
abstract class IYijingService {
  // ==================== 卦象查询方法 ====================

  /// 获取所有卦象
  Future<List<IGuaData>> getAllGua();

  /// 根据二进制获取卦象
  Future<IGuaData?> getGuaByBinary(String binary);

  /// 按名称搜索卦象
  Future<List<IGuaData>> searchGuaByName(String name);

  /// 按序号获取卦象
  Future<IGuaData?> getGuaBySeq(int seq);

  // ==================== 爻辞/彖辞/象辞方法 ====================

  /// 获取爻辞列表
  Future<List<IYaoCiData>> getYaoCi(String guaBinary);

  /// 获取彖辞
  Future<String?> getTuanCi(String guaBinary);

  /// 获取象辞
  Future<String?> getXiangCi(String guaBinary);

  /// 获取卦辞
  Future<String?> getGuaCi(String guaBinary);

  // ==================== 工具方法 ====================

  /// 验证二进制编码是否有效
  Future<bool> isValidBinary(String binary);

  /// 获取卦象数量
  Future<int> getGuaCount();
}
