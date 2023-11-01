import 'package:moor/moor.dart';


@DataClassName('ZhouYiGuaYao')
class ZhouYiGuaYaoTable extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get guaBinary => text().withLength(min: 6, max: 6)();
  IntColumn get seqInGua => integer()();
  TextColumn get yaoName => text().withLength(min: 2, max: 2)();
  TextColumn get guaYaoName => text().withLength(min: 4, max: 4)();
  TextColumn get xiang => text()();
  TextColumn get yao => text()();

  @override
  Set<Column> get primaryKey => {id};


  @override String? get tableName => 't_zy_yao';
}
