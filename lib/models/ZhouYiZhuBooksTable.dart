import 'package:moor/moor.dart';

@DataClassName('ZhouyiZhuBooks')
class ZhouyiZhuBooksTable extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get bookname => text().withLength(max: 16)();
  TextColumn get bookauth => text().withLength(max: 16)();
  TextColumn get bookage => text().withLength(max: 16)();

  @override
  Set<Column> get primaryKey => {id};

  @override
  String get tableName => 't_zy_zhu_book';
}
