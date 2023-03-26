import 'package:moor/moor.dart';

import 'ZhouYiGuaYaoTable.dart';
import 'ZhouYiTable.dart';

import 'package:moor/moor.dart';

import 'ZhouYiZhuBooksTable.dart';
@DataClassName('ZhouYiYaoZhu')
class ZhouYiYaoZhuTable extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get guaBinary => text().references(ZhouYiTable, Symbol('binary'))();
  IntColumn get yaoId => integer().references(ZhouYiGuaYaoTable,  Symbol('id'))();
  IntColumn get bookId => integer().references(ZhouyiZhuBooksTable,  Symbol('id'))();
  TextColumn get yaoZhu => text()();
  @override
  Set<Column> get primaryKey => {id};
}
