import '../databases/MyDatabase.dart';
import 'models/gua_data.dart';
import 'yijing_repository.dart';

/// 易经API主入口类
/// 提供给外部程序使用的统一接口
class YijingApi {
  late final MyDatabase _database;
  late final YijingRepository _repository;
  bool _initialized = false;

  /// 单例模式
  static final YijingApi _instance = YijingApi._internal();
  factory YijingApi() => _instance;
  YijingApi._internal();

  /// 初始化API（必须在使用前调用）
  Future<void> init() async {
    if (_initialized) return;

    _database = MyDatabase();
    _repository = YijingRepository(_database);
    _initialized = true;
  }

  /// 检查是否已初始化
  void _checkInitialized() {
    if (!_initialized) {
      throw StateError('YijingApi not initialized. Call init() first.');
    }
  }

  // ==================== 卦象查询 ====================

  /// 获取所有卦象列表
  /// 返回: List<ZhouYi> 包含所有64卦的基本信息
  Future<ApiResponse<List<ZhouYi>>> getAllGua() async {
    _checkInitialized();
    try {
      final guaList = await _repository.getAllGua();
      return ApiResponse.success(guaList);
    } catch (e) {
      return ApiResponse.error('Failed to get all gua: $e');
    }
  }

  /// 根据二进制编码获取卦象
  /// [binary] 6位二进制字符串，如"111111"代表乾卦
  /// 返回: ZhouYi? 卦象信息，未找到返回null
  Future<ApiResponse<ZhouYi?>> getGuaByBinary(String binary) async {
    _checkInitialized();
    try {
      if (binary.length != 6) {
        return ApiResponse.error('Binary must be 6 characters', code: 400);
      }
      final gua = await _repository.getGuaByBinary(binary);
      return ApiResponse.success(gua);
    } catch (e) {
      return ApiResponse.error('Failed to get gua: $e');
    }
  }

  /// 根据名称搜索卦象
  /// [name] 卦名（支持简称如"乾"或全名如"乾为天"）
  /// 返回: List<ZhouYi> 匹配的卦象列表
  Future<ApiResponse<List<ZhouYi>>> searchGuaByName(String name) async {
    _checkInitialized();
    try {
      if (name.isEmpty) {
        return ApiResponse.error('Name cannot be empty', code: 400);
      }
      final guaList = await _repository.searchGuaByName(name);
      return ApiResponse.success(guaList);
    } catch (e) {
      return ApiResponse.error('Failed to search gua: $e');
    }
  }

  /// 根据序号获取卦象
  /// [seq] 卦序号（1-64）
  /// 返回: ZhouYi? 卦象信息
  Future<ApiResponse<ZhouYi?>> getGuaBySeq(int seq) async {
    _checkInitialized();
    try {
      if (seq < 1 || seq > 64) {
        return ApiResponse.error('Sequence must be between 1 and 64',
            code: 400);
      }
      final gua = await _repository.getGuaBySeq(seq);
      return ApiResponse.success(gua);
    } catch (e) {
      return ApiResponse.error('Failed to get gua by sequence: $e');
    }
  }

  // ==================== 爻辞/彖辞/象辞 ====================

  /// 获取卦的所有爻辞
  /// [guaBinary] 卦的二进制编码
  /// 返回: List<YaoData> 包含6爻的完整信息
  Future<ApiResponse<List<YaoData>>> getYaoCi(String guaBinary) async {
    _checkInitialized();
    try {
      final yaoList = await _repository.getYaoCi(guaBinary);
      return ApiResponse.success(yaoList);
    } catch (e) {
      return ApiResponse.error('Failed to get yao ci: $e');
    }
  }

  /// 获取卦的彖辞
  /// [guaBinary] 卦的二进制编码
  /// 返回: String? 彖辞内容
  Future<ApiResponse<String?>> getTuanCi(String guaBinary) async {
    _checkInitialized();
    try {
      final gua = await _repository.getGuaByBinary(guaBinary);
      if (gua == null) {
        return ApiResponse.error('Gua not found', code: 404);
      }
      return ApiResponse.success(gua.tuan);
    } catch (e) {
      return ApiResponse.error('Failed to get tuan ci: $e');
    }
  }

  /// 获取卦的象辞
  /// [guaBinary] 卦的二进制编码
  /// 返回: String? 象辞内容
  Future<ApiResponse<String?>> getXiangCi(String guaBinary) async {
    _checkInitialized();
    try {
      final gua = await _repository.getGuaByBinary(guaBinary);
      if (gua == null) {
        return ApiResponse.error('Gua not found', code: 404);
      }
      return ApiResponse.success(gua.xiang);
    } catch (e) {
      return ApiResponse.error('Failed to get xiang ci: $e');
    }
  }

  /// 获取卦的卦辞
  /// [guaBinary] 卦的二进制编码
  /// 返回: String? 卦辞内容
  Future<ApiResponse<String?>> getGuaCi(String guaBinary) async {
    _checkInitialized();
    try {
      final gua = await _repository.getGuaByBinary(guaBinary);
      if (gua == null) {
        return ApiResponse.error('Gua not found', code: 404);
      }
      return ApiResponse.success(gua.gua);
    } catch (e) {
      return ApiResponse.error('Failed to get gua ci: $e');
    }
  }

  // ==================== 注解数据 ====================

  /// 获取卦的注解
  /// [guaBinary] 卦的二进制编码
  /// [bookId] 可选，指定注书ID过滤
  /// 返回: List<GuaZhuData> 注解列表
  Future<ApiResponse<List<GuaZhuData>>> getGuaZhu(
    String guaBinary, {
    int? bookId,
  }) async {
    _checkInitialized();
    try {
      final zhuList = await _repository.getGuaZhu(guaBinary, bookId: bookId);
      return ApiResponse.success(zhuList);
    } catch (e) {
      return ApiResponse.error('Failed to get gua zhu: $e');
    }
  }

  /// 获取所有注书列表
  /// 返回: List<BookInfo> 注书信息列表
  Future<ApiResponse<List<BookInfo>>> getAllBooks() async {
    _checkInitialized();
    try {
      final books = await _repository.getBookInfoList();
      return ApiResponse.success(books);
    } catch (e) {
      return ApiResponse.error('Failed to get books: $e');
    }
  }

  // ==================== 焦氏易林 ====================

  /// 获取卦的焦氏易林数据
  /// [guaBinary] 卦的二进制编码
  /// 返回: List<JiaoLinData> 焦氏易林内容
  Future<ApiResponse<List<JiaoLinData>>> getJiaoShiYiLin(
      String guaBinary) async {
    _checkInitialized();
    try {
      final jiaoLinList = await _repository.getJiaoShiYiLin(guaBinary);
      return ApiResponse.success(jiaoLinList);
    } catch (e) {
      return ApiResponse.error('Failed to get jiao shi yi lin: $e');
    }
  }

  // ==================== 完整数据 ====================

  /// 获取卦象完整数据
  /// [guaBinary] 卦的二进制编码
  /// 返回: GuaData? 包含卦辞、彖辞、象辞、爻辞等完整信息
  Future<ApiResponse<GuaData?>> getFullGuaData(String guaBinary) async {
    _checkInitialized();
    try {
      final data = await _repository.getFullGuaData(guaBinary);
      return ApiResponse.success(data);
    } catch (e) {
      return ApiResponse.error('Failed to get full gua data: $e');
    }
  }

  /// 批量获取卦象完整数据
  /// [guaBinaries] 卦的二进制编码列表
  /// 返回: List<GuaData> 完整数据列表
  Future<ApiResponse<List<GuaData>>> getMultipleGuaData(
    List<String> guaBinaries,
  ) async {
    _checkInitialized();
    try {
      final dataList = await _repository.getMultipleGuaData(guaBinaries);
      return ApiResponse.success(dataList);
    } catch (e) {
      return ApiResponse.error('Failed to get multiple gua data: $e');
    }
  }

  /// 获取所有卦象的完整数据
  /// 返回: List<GuaData> 64卦完整数据
  Future<ApiResponse<List<GuaData>>> getAllGuaData() async {
    _checkInitialized();
    try {
      final dataList = await _repository.getAllGuaData();
      return ApiResponse.success(dataList);
    } catch (e) {
      return ApiResponse.error('Failed to get all gua data: $e');
    }
  }

  // ==================== 工具方法 ====================

  /// 验证二进制编码是否有效
  /// [binary] 6位二进制字符串
  /// 返回: bool 是否有效
  Future<ApiResponse<bool>> isValidBinary(String binary) async {
    _checkInitialized();
    try {
      final isValid = await _repository.isValidBinary(binary);
      return ApiResponse.success(isValid);
    } catch (e) {
      return ApiResponse.error('Failed to validate binary: $e');
    }
  }

  /// 获取卦象数量
  /// 返回: int 卦象总数（应为64）
  Future<ApiResponse<int>> getGuaCount() async {
    _checkInitialized();
    try {
      final count = await _repository.getGuaCount();
      return ApiResponse.success(count);
    } catch (e) {
      return ApiResponse.error('Failed to get gua count: $e');
    }
  }

  /// 清除缓存
  void clearCache() {
    _checkInitialized();
    _repository.clearCache();
  }

  /// 释放资源
  Future<void> dispose() async {
    if (_initialized) {
      _repository.clearCache();
      await _database.close();
      _initialized = false;
    }
  }
}
