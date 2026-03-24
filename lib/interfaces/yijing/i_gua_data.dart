/// 卦象数据接口
abstract class IGuaData {
  /// 卦的二进制编码（6位）
  String get binary;

  /// 卦序号（1-64）
  int get seq;

  /// 卦名（简称）
  String get name;

  /// 卦全名
  String get fullname;

  /// 卦辞
  String? get guaCi;

  /// 彖辞
  String? get tuanCi;

  /// 象辞
  String? get xiangCi;

  /// 内卦名称
  String? get innerBaguaName;

  /// 外卦名称
  String? get outerBaguaName;
}
