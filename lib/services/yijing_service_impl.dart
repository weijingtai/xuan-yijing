import '../interfaces/yijing/i_yijing_service.dart';
import '../interfaces/yijing/i_gua_data.dart';
import '../interfaces/yijing/i_yao_ci_data.dart';
import '../api/yijing_api.dart';
import '../models/gua_data_impl.dart';
import '../models/yao_ci_data_impl.dart';

/// 易经服务实现类
/// 实现 IYijingService 接口，提供完整的易经卦象数据访问能力
class YijingServiceImpl implements IYijingService {
  final YijingApi _api = YijingApi();

  /// 确保 API 已初始化
  Future<void> _ensureInitialized() async {
    await _api.init();
  }

  @override
  Future<List<IGuaData>> getAllGua() async {
    await _ensureInitialized();
    final response = await _api.getAllGuaData();
    if (response.code == 200 && response.data != null) {
      return response.data!
          .map((data) => GuaData(
                binary: data.binary,
                seq: data.seq,
                name: data.name,
                fullname: data.fullname,
                guaCi: data.guaCi,
                tuanCi: data.tuanCi,
                xiangCi: data.xiangCi,
                innerBaguaName: data.innerBagua?.name,
                outerBaguaName: data.outerBagua?.name,
              ))
          .toList();
    }
    return [];
  }

  @override
  Future<IGuaData?> getGuaByBinary(String binary) async {
    await _ensureInitialized();
    final response = await _api.getGuaByBinary(binary);
    if (response.code == 200 && response.data != null) {
      // 获取完整数据
      final fullResponse = await _api.getFullGuaData(binary);
      if (fullResponse.code == 200 && fullResponse.data != null) {
        final fullData = fullResponse.data!;
        return GuaData(
          binary: fullData.binary,
          seq: fullData.seq,
          name: fullData.name,
          fullname: fullData.fullname,
          guaCi: fullData.guaCi,
          tuanCi: fullData.tuanCi,
          xiangCi: fullData.xiangCi,
          innerBaguaName: fullData.innerBagua?.name,
          outerBaguaName: fullData.outerBagua?.name,
        );
      }
    }
    return null;
  }

  @override
  Future<List<IGuaData>> searchGuaByName(String name) async {
    await _ensureInitialized();
    final response = await _api.searchGuaByName(name);
    if (response.code == 200 && response.data != null) {
      return response.data!.map((gua) => GuaData.fromZhouYi(gua)).toList();
    }
    return [];
  }

  @override
  Future<IGuaData?> getGuaBySeq(int seq) async {
    await _ensureInitialized();
    final response = await _api.getGuaBySeq(seq);
    if (response.code == 200 && response.data != null) {
      final gua = response.data!;
      return GuaData.fromZhouYi(gua);
    }
    return null;
  }

  @override
  Future<List<IYaoCiData>> getYaoCi(String guaBinary) async {
    await _ensureInitialized();
    final response = await _api.getYaoCi(guaBinary);
    if (response.code == 200 && response.data != null) {
      return response.data!
          .map((yao) => YaoCiData(
                id: yao.id,
                seqInGua: yao.seqInGua,
                yaoName: yao.yaoName,
                guaYaoName: yao.guaYaoName,
                yaoCi: yao.yaoCi,
                xiangCi: yao.xiangCi,
              ))
          .toList();
    }
    return [];
  }

  @override
  Future<String?> getTuanCi(String guaBinary) async {
    await _ensureInitialized();
    final response = await _api.getTuanCi(guaBinary);
    if (response.code == 200) {
      return response.data;
    }
    return null;
  }

  @override
  Future<String?> getXiangCi(String guaBinary) async {
    await _ensureInitialized();
    final response = await _api.getXiangCi(guaBinary);
    if (response.code == 200) {
      return response.data;
    }
    return null;
  }

  @override
  Future<String?> getGuaCi(String guaBinary) async {
    await _ensureInitialized();
    final response = await _api.getGuaCi(guaBinary);
    if (response.code == 200) {
      return response.data;
    }
    return null;
  }

  @override
  Future<bool> isValidBinary(String binary) async {
    await _ensureInitialized();
    final response = await _api.isValidBinary(binary);
    if (response.code == 200) {
      return response.data ?? false;
    }
    return false;
  }

  @override
  Future<int> getGuaCount() async {
    await _ensureInitialized();
    final response = await _api.getGuaCount();
    if (response.code == 200) {
      return response.data ?? 0;
    }
    return 0;
  }
}
