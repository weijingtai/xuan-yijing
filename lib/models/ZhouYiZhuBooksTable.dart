import 'package:moor/moor.dart';

@DataClassName('ZhouyiZhuBooks')
class ZhouyiZhuBooksTable extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get bookName => text().withLength(max: 16)();
  TextColumn get bookAuth => text().withLength(max: 16)();
  TextColumn get bookAge => text().withLength(max: 16)();

  @override
  Set<Column> get primaryKey => {id};

  @override
  String get tableName => 'zhouyi_zhu_book';
}
