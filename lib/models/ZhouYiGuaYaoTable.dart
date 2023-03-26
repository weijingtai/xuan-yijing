import 'package:moor/moor.dart';


@DataClassName('ZhouYiGuaYao')
class ZhouYiGuaYaoTable extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get seq => integer()();
  TextColumn get guaBinary => text().withLength(min: 6, max: 6)();
  IntColumn get seqInGua => integer()();
  TextColumn get yaoName => text().withLength(min: 2, max: 2)();
  TextColumn get guaYaoName => text().withLength(min: 4, max: 4)();
  TextColumn get yaoXiang => text()();
  TextColumn get yaoContent => text()();

  @override
  Set<Column> get primaryKey => {id};

  @override
  String get tableName => 'zhouyi_gua_yao';
}
