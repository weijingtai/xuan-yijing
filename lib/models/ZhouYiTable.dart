import 'package:moor/moor.dart';

@DataClassName('ZhouYi')
class ZhouYiTable extends Table {
  TextColumn get binary => text()();
  IntColumn get seq => integer()();
  TextColumn get name => text()();
  TextColumn get fullname => text()();
  TextColumn get baguaInner => text()();
  TextColumn get baguaInnerName => text()();
  TextColumn get baguaInnerNickname => text()();
  TextColumn get baguaOuter => text()();
  TextColumn get baguaOuterName => text()();
  TextColumn get baguaOuterNickname => text()();
  TextColumn get xiang => text()();
  TextColumn get tuan => text()();

  @override
  Set<Column> get primaryKey => {binary};
}
