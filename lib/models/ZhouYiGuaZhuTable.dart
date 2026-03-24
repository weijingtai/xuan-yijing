import 'package:drift/drift.dart';
import 'package:yijing/models/ZhouYiTable.dart';
import 'package:yijing/models/ZhouYiZhuBooksTable.dart';

@DataClassName('ZhouYiGuaZhu')
class ZhouYiGuaZhuTable extends Table {
  IntColumn get id => integer().autoIncrement()();
  BoolColumn get isSingle => boolean()();
  TextColumn get guaBinary => text()
      .withLength(min: 6, max: 6)
      .references(ZhouYiTable, Symbol("binary"))();
  IntColumn get bookId =>
      integer().references(ZhouyiZhuBooksTable, Symbol("id"))();
  TextColumn get guaZhu => text().nullable()();
  TextColumn get xiangZhu => text().nullable()();
  TextColumn get tuanZhu => text().nullable()();

  // @override
  // Set<Column> get primaryKey => {id};

  @override
  String get tableName => 't_zy_gua_zhu';

  // @override
  // List<ForeignKey> get foreignKeys => [bookIdFk, guaBinaryFk];
}
