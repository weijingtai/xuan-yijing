import 'package:moor/moor.dart';

import 'ZhouYiTable.dart';

@DataClassName('JiaoShiYiLin')
class JiaoShiYiLinTable extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get guaBinary => text().references(ZhouYiTable, Symbol("binary"))();
  IntColumn get zhiSeq => integer()();
  TextColumn get zhiName => text()();
  TextColumn get zhiBinary => text()();
  TextColumn get zhiContent => text()();

  @override
  Set<Column> get primaryKey => {id};

  @override String? get tableName => 't_zy_jiao_lin';


}
