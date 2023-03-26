import 'package:moor/moor.dart';
import 'package:my_flutter/models/ZhouYiTable.dart';
import 'package:my_flutter/models/ZhouYiZhuBooksTable.dart';

@DataClassName('ZhouYiGuaZhu')
class ZhouYiGuaZhuTable extends Table {
  IntColumn get id => integer().autoIncrement()();
  BoolColumn get isSingle => boolean()();
  TextColumn get guaBinary => text().withLength(min: 6, max: 6).references(ZhouYiTable, Symbol("binary"))();
  IntColumn get bookId => integer().references(ZhouyiZhuBooksTable, Symbol("id"))();
  TextColumn get guaZhu => text()();
  TextColumn get xiangZhu => text()();
  TextColumn get tuanZhu => text()();

  @override
  Set<Column> get primaryKey => {id};

  @override
  String get tableName => 'zhouyi_gua_zhu';


  // @override
  // List<ForeignKey> get foreignKeys => [bookIdFk, guaBinaryFk];
}
