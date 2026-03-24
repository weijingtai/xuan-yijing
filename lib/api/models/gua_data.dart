/// 卦象完整数据模型（用于API返回）
class GuaData {
  final String binary;
  final int seq;
  final String name;
  final String fullname;
  final String? guaCi; // 卦辞
  final String? tuanCi; // 彖辞
  final String? xiangCi; // 象辞
  final List<YaoData>? yaoCi; // 爻辞列表
  final BaguaInfo? innerBagua; // 内卦
  final BaguaInfo? outerBagua; // 外卦

  GuaData({
    required this.binary,
    required this.seq,
    required this.name,
    required this.fullname,
    this.guaCi,
    this.tuanCi,
    this.xiangCi,
    this.yaoCi,
    this.innerBagua,
    this.outerBagua,
  });

  Map<String, dynamic> toJson() => {
        'binary': binary,
        'seq': seq,
        'name': name,
        'fullname': fullname,
        'gua_ci': guaCi,
        'tuan_ci': tuanCi,
        'xiang_ci': xiangCi,
        'yao_ci': yaoCi?.map((y) => y.toJson()).toList(),
        'inner_bagua': innerBagua?.toJson(),
        'outer_bagua': outerBagua?.toJson(),
      };
}

/// 爻数据模型
class YaoData {
  final int id;
  final int seqInGua;
  final String yaoName; // 如 "初九"
  final String guaYaoName; // 如 "乾·初九"
  final String? yaoCi; // 爻辞
  final String? xiangCi; // 爻象辞
  final List<YaoZhuData>? annotations; // 注解

  YaoData({
    required this.id,
    required this.seqInGua,
    required this.yaoName,
    required this.guaYaoName,
    this.yaoCi,
    this.xiangCi,
    this.annotations,
  });

  Map<String, dynamic> toJson() => {
        'id': id,
        'seq_in_gua': seqInGua,
        'yao_name': yaoName,
        'gua_yao_name': guaYaoName,
        'yao_ci': yaoCi,
        'xiang_ci': xiangCi,
        'annotations': annotations?.map((a) => a.toJson()).toList(),
      };
}

/// 爻辞注解数据
class YaoZhuData {
  final int bookId;
  final String? bookName;
  final String? annotation;

  YaoZhuData({
    required this.bookId,
    this.bookName,
    this.annotation,
  });

  Map<String, dynamic> toJson() => {
        'book_id': bookId,
        'book_name': bookName,
        'annotation': annotation,
      };
}

/// 卦辞注解数据
class GuaZhuData {
  final int bookId;
  final String? bookName;
  final bool isSingle;
  final String? guaZhu; // 卦辞注解
  final String? xiangZhu; // 象辞注解
  final String? tuanZhu; // 彖辞注解

  GuaZhuData({
    required this.bookId,
    this.bookName,
    required this.isSingle,
    this.guaZhu,
    this.xiangZhu,
    this.tuanZhu,
  });

  Map<String, dynamic> toJson() => {
        'book_id': bookId,
        'book_name': bookName,
        'is_single': isSingle,
        'gua_zhu': guaZhu,
        'xiang_zhu': xiangZhu,
        'tuan_zhu': tuanZhu,
      };
}

/// 八卦信息
class BaguaInfo {
  final String binary;
  final String name;
  final String? nickname;

  BaguaInfo({
    required this.binary,
    required this.name,
    this.nickname,
  });

  Map<String, dynamic> toJson() => {
        'binary': binary,
        'name': name,
        'nickname': nickname,
      };
}

/// 注书信息
class BookInfo {
  final int id;
  final String name;
  final String author;
  final String age;

  BookInfo({
    required this.id,
    required this.name,
    required this.author,
    required this.age,
  });

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'author': author,
        'age': age,
      };
}

/// 焦氏易林数据
class JiaoLinData {
  final int id;
  final String guaBinary;
  final int zhiSeq;
  final String zhiName;
  final String zhiBinary;
  final String? content;

  JiaoLinData({
    required this.id,
    required this.guaBinary,
    required this.zhiSeq,
    required this.zhiName,
    required this.zhiBinary,
    this.content,
  });

  Map<String, dynamic> toJson() => {
        'id': id,
        'gua_binary': guaBinary,
        'zhi_seq': zhiSeq,
        'zhi_name': zhiName,
        'zhi_binary': zhiBinary,
        'content': content,
      };
}

/// API 响应包装
class ApiResponse<T> {
  final int code;
  final String message;
  final T? data;
  final String? error;

  ApiResponse({
    required this.code,
    required this.message,
    this.data,
    this.error,
  });

  factory ApiResponse.success(T data) => ApiResponse(
        code: 200,
        message: 'success',
        data: data,
      );

  factory ApiResponse.error(String error, {int code = 500}) => ApiResponse(
        code: code,
        message: 'error',
        error: error,
      );

  Map<String, dynamic> toJson() => {
        'code': code,
        'message': message,
        'data': data,
        'error': error,
      };
}
