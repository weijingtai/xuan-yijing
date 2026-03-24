import '../databases/MyDatabase.dart';
import 'models/gua_data.dart';

/// 易经数据仓库层
/// 封装所有数据库查询操作，提供高层API
class YijingRepository {
  final MyDatabase _database;

  // 缓存
  List<ZhouYi>? _allGuaCache;
  List<ZhouyiZhuBooks>? _allBooksCache;

  YijingRepository(this._database);

  // ==================== 卦象基础数据 ====================

  /// 获取所有卦象列表
  Future<List<ZhouYi>> getAllGua() async {
    _allGuaCache ??= await _database.listAllZhouYi();
    return _allGuaCache!;
  }

  /// 根据二进制编码获取卦象
  Future<ZhouYi?> getGuaByBinary(String binary) async {
    try {
      return await _database.getZhouYiByBinary(binary);
    } catch (e) {
      return null;
    }
  }

  /// 根据名称搜索卦象（支持简称和全名）
  Future<List<ZhouYi>> searchGuaByName(String name) async {
    final allGua = await getAllGua();
    return allGua
        .where((gua) => gua.name.contains(name) || gua.fullname.contains(name))
        .toList();
  }

  /// 根据序号获取卦象
  Future<ZhouYi?> getGuaBySeq(int seq) async {
    final allGua = await getAllGua();
    try {
      return allGua.firstWhere((gua) => gua.seq == seq);
    } catch (e) {
      return null;
    }
  }

  // ==================== 爻辞/彖辞/象辞 ====================

  /// 获取卦的完整爻辞数据
  Future<List<YaoData>> getYaoCi(String guaBinary) async {
    final yaos = await _database.findAllGuaYao(guaBinary);
    final yaoZhus = await _database.findAllYaoZhu(guaBinary);
    final books = await getAllBooks();

    return yaos.map((yao) {
      // 找到该爻的所有注解
      final annotations = yaoZhus.where((yz) => yz.yaoId == yao.id).map((yz) {
        final book = books.cast<ZhouyiZhuBooks?>().firstWhere(
              (b) => b?.id == yz.bookId,
              orElse: () => null,
            );
        return YaoZhuData(
          bookId: yz.bookId,
          bookName: book?.bookname,
          annotation: yz.yaoZhu,
        );
      }).toList();

      return YaoData(
        id: yao.id,
        seqInGua: yao.seqInGua,
        yaoName: yao.yaoName,
        guaYaoName: yao.guaYaoName,
        yaoCi: yao.yao,
        xiangCi: yao.xiang,
        annotations: annotations.isNotEmpty ? annotations : null,
      );
    }).toList();
  }

  /// 获取卦辞注解
  Future<List<GuaZhuData>> getGuaZhu(String guaBinary, {int? bookId}) async {
    var guaZhus = await _database.findAllGuaZhu(guaBinary);
    final books = await getAllBooks();

    if (bookId != null) {
      guaZhus = guaZhus.where((gz) => gz.bookId == bookId).toList();
    }

    return guaZhus.map((gz) {
      final book = books.cast<ZhouyiZhuBooks?>().firstWhere(
            (b) => b?.id == gz.bookId,
            orElse: () => null,
          );
      return GuaZhuData(
        bookId: gz.bookId,
        bookName: book?.bookname,
        isSingle: gz.isSingle,
        guaZhu: gz.guaZhu,
        xiangZhu: gz.xiangZhu,
        tuanZhu: gz.tuanZhu,
      );
    }).toList();
  }

  /// 获取单卦注解（只针对整卦的注解，非爻注解）
  Future<List<GuaZhuData>> getSingleGuaZhu(String guaBinary) async {
    final guaZhus = await _database.findAllSingleGuaZhu(guaBinary);
    final books = await getAllBooks();

    return guaZhus.map((gz) {
      final book = books.cast<ZhouyiZhuBooks?>().firstWhere(
            (b) => b?.id == gz.bookId,
            orElse: () => null,
          );
      return GuaZhuData(
        bookId: gz.bookId,
        bookName: book?.bookname,
        isSingle: gz.isSingle,
        guaZhu: gz.guaZhu,
        xiangZhu: gz.xiangZhu,
        tuanZhu: gz.tuanZhu,
      );
    }).toList();
  }

  // ==================== 注书数据 ====================

  /// 获取所有注书列表
  Future<List<ZhouyiZhuBooks>> getAllBooks() async {
    _allBooksCache ??= await _database.findAllZhuBooks();
    return _allBooksCache!;
  }

  /// 获取注书信息列表（简化版）
  Future<List<BookInfo>> getBookInfoList() async {
    final books = await getAllBooks();
    return books
        .map((b) => BookInfo(
              id: b.id,
              name: b.bookname,
              author: b.bookauth,
              age: b.bookage,
            ))
        .toList();
  }

  // ==================== 焦氏易林 ====================

  /// 获取卦的焦氏易林数据
  Future<List<JiaoLinData>> getJiaoShiYiLin(String guaBinary) async {
    final list = await _database.findAllSubZhi(guaBinary);
    return list
        .map((j) => JiaoLinData(
              id: j.id,
              guaBinary: j.guaBinary,
              zhiSeq: j.zhiSeq,
              zhiName: j.zhiName,
              zhiBinary: j.zhiBinary,
              content: j.zhiContent,
            ))
        .toList();
  }

  // ==================== 完整数据获取 ====================

  /// 获取卦象完整数据（包含所有信息）
  Future<GuaData?> getFullGuaData(String guaBinary) async {
    final gua = await getGuaByBinary(guaBinary);
    if (gua == null) return null;

    // 并行获取相关数据
    final results = await Future.wait([
      getYaoCi(guaBinary),
      getGuaZhu(guaBinary),
    ]);

    final yaoCi = results[0] as List<YaoData>;
    final guaZhus = results[1] as List<GuaZhuData>;

    // 从卦辞注解中提取彖辞和象辞（取第一个有内容的注解）
    String? tuanCi;
    String? xiangCi;
    for (final gz in guaZhus) {
      tuanCi ??= gz.tuanZhu;
      xiangCi ??= gz.xiangZhu;
    }

    return GuaData(
      binary: gua.binary,
      seq: gua.seq,
      name: gua.name,
      fullname: gua.fullname,
      guaCi: gua.gua,
      tuanCi: tuanCi ?? gua.tuan,
      xiangCi: xiangCi ?? gua.xiang,
      yaoCi: yaoCi,
      innerBagua: BaguaInfo(
        binary: gua.baguaInner,
        name: gua.baguaInnerName,
        nickname: gua.baguaInnerNickname,
      ),
      outerBagua: BaguaInfo(
        binary: gua.baguaOuter,
        name: gua.baguaOuterName,
        nickname: gua.baguaOuterNickname,
      ),
    );
  }

  /// 批量获取卦象数据
  Future<List<GuaData>> getMultipleGuaData(List<String> guaBinaries) async {
    final results =
        await Future.wait(guaBinaries.map((binary) => getFullGuaData(binary)));
    return results.whereType<GuaData>().toList();
  }

  /// 获取所有卦象的完整数据
  Future<List<GuaData>> getAllGuaData() async {
    final allGua = await getAllGua();
    final binaries = allGua.map((g) => g.binary).toList();
    return getMultipleGuaData(binaries);
  }

  // ==================== 工具方法 ====================

  /// 清除缓存
  void clearCache() {
    _allGuaCache = null;
    _allBooksCache = null;
  }

  /// 获取卦象数量
  Future<int> getGuaCount() async {
    final allGua = await getAllGua();
    return allGua.length;
  }

  /// 验证二进制编码是否有效
  Future<bool> isValidBinary(String binary) async {
    if (binary.length != 6) return false;
    if (!RegExp(r'^[01]+$').hasMatch(binary)) return false;
    final gua = await getGuaByBinary(binary);
    return gua != null;
  }
}
