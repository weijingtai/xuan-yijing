import '../interfaces/yijing/i_yao_ci_data.dart';

/// 爻辞数据实现类
/// 实现 IYaoCiData 接口，提供爻辞数据的封装
class YaoCiData implements IYaoCiData {
  @override
  final int id;

  @override
  final int seqInGua;

  @override
  final String yaoName;

  @override
  final String guaYaoName;

  @override
  final String? yaoCi;

  @override
  final String? xiangCi;

  const YaoCiData({
    required this.id,
    required this.seqInGua,
    required this.yaoName,
    required this.guaYaoName,
    this.yaoCi,
    this.xiangCi,
  });

  /// 从 JSON 创建实例
  factory YaoCiData.fromJson(Map<String, dynamic> json) {
    return YaoCiData(
      id: json['id'] as int,
      seqInGua: json['seq_in_gua'] as int,
      yaoName: json['yao_name'] as String,
      guaYaoName: json['gua_yao_name'] as String,
      yaoCi: json['yao_ci'] as String?,
      xiangCi: json['xiang_ci'] as String?,
    );
  }

  /// 转换为 JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'seq_in_gua': seqInGua,
      'yao_name': yaoName,
      'gua_yao_name': guaYaoName,
      'yao_ci': yaoCi,
      'xiang_ci': xiangCi,
    };
  }

  /// 从 ZhouYiGuaYao 模型转换
  /// [guaYao] ZhouYiGuaYao 数据库模型
  factory YaoCiData.fromZhouYiGuaYao(dynamic guaYao) {
    return YaoCiData(
      id: guaYao.id,
      seqInGua: guaYao.seqInGua,
      yaoName: guaYao.yaoName,
      guaYaoName: guaYao.guaYaoName,
      yaoCi: guaYao.yao,
      xiangCi: guaYao.xiang,
    );
  }

  @override
  String toString() {
    return 'YaoCiData(id: $id, seqInGua: $seqInGua, yaoName: $yaoName, guaYaoName: $guaYaoName)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is YaoCiData && other.id == id;
  }

  @override
  int get hashCode => id.hashCode;
}
