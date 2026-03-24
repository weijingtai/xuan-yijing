import '../interfaces/yijing/i_gua_data.dart';

/// 卦象数据实现类
/// 实现 IGuaData 接口，提供卦象数据的封装
class GuaData implements IGuaData {
  @override
  final String binary;

  @override
  final int seq;

  @override
  final String name;

  @override
  final String fullname;

  @override
  final String? guaCi;

  @override
  final String? tuanCi;

  @override
  final String? xiangCi;

  @override
  final String? innerBaguaName;

  @override
  final String? outerBaguaName;

  const GuaData({
    required this.binary,
    required this.seq,
    required this.name,
    required this.fullname,
    this.guaCi,
    this.tuanCi,
    this.xiangCi,
    this.innerBaguaName,
    this.outerBaguaName,
  });

  /// 从 JSON 创建实例
  factory GuaData.fromJson(Map<String, dynamic> json) {
    return GuaData(
      binary: json['binary'] as String,
      seq: json['seq'] as int,
      name: json['name'] as String,
      fullname: json['fullname'] as String,
      guaCi: json['gua_ci'] as String?,
      tuanCi: json['tuan_ci'] as String?,
      xiangCi: json['xiang_ci'] as String?,
      innerBaguaName: json['inner_bagua_name'] as String?,
      outerBaguaName: json['outer_bagua_name'] as String?,
    );
  }

  /// 转换为 JSON
  Map<String, dynamic> toJson() {
    return {
      'binary': binary,
      'seq': seq,
      'name': name,
      'fullname': fullname,
      'gua_ci': guaCi,
      'tuan_ci': tuanCi,
      'xiang_ci': xiangCi,
      'inner_bagua_name': innerBaguaName,
      'outer_bagua_name': outerBaguaName,
    };
  }

  /// 从 ZhouYi 模型转换
  /// [zhouYi] ZhouYi 数据库模型
  /// [guaCi] 可选的卦辞
  /// [tuanCi] 可选的彖辞
  /// [xiangCi] 可选的象辞
  factory GuaData.fromZhouYi(
    dynamic zhouYi, {
    String? guaCi,
    String? tuanCi,
    String? xiangCi,
  }) {
    return GuaData(
      binary: zhouYi.binary,
      seq: zhouYi.seq,
      name: zhouYi.name,
      fullname: zhouYi.fullname,
      guaCi: guaCi ?? zhouYi.gua,
      tuanCi: tuanCi ?? zhouYi.tuan,
      xiangCi: xiangCi ?? zhouYi.xiang,
      innerBaguaName: zhouYi.baguaInnerName,
      outerBaguaName: zhouYi.baguaOuterName,
    );
  }

  @override
  String toString() {
    return 'GuaData(binary: $binary, seq: $seq, name: $name, fullname: $fullname)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is GuaData && other.binary == binary;
  }

  @override
  int get hashCode => binary.hashCode;
}
