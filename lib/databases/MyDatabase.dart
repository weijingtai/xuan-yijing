import 'dart:io';

import 'package:drift/native.dart';
import 'package:flutter/services.dart';
import 'package:drift/drift.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqlite3/sqlite3.dart';
import 'package:sqlite3_flutter_libs/sqlite3_flutter_libs.dart';

import '../models/JiaoShiYiLin.dart';
import '../models/ZhouYiGuaYaoTable.dart';
import '../models/ZhouYiGuaZhuTable.dart';
import '../models/ZhouYiTable.dart';
import '../models/ZhouYiYaoZhuTable.dart';
import '../models/ZhouYiZhuBooksTable.dart';

part 'MyDatabase.g.dart';

@DriftDatabase(tables: [ZhouYiTable, ZhouYiGuaZhuTable, ZhouYiYaoZhuTable, ZhouYiGuaYaoTable, ZhouyiZhuBooksTable, JiaoShiYiLinTable])
class MyDatabase extends _$MyDatabase {



  //创建数据库实例，开启数据库连接
  MyDatabase() : super(_openConnection());



  //数据库版本控制
  @override  int get schemaVersion => 1;



  //升级配置
  @override  MigrationStrategy get migration => MigrationStrategy(

      onUpgrade: (migrator, from, to) async {
        },
      beforeOpen: (details) async {
        await customStatement('PRAGMA foreign_keys = ON');
      });

  Future<List<ZhouYi>> listAllZhouYi() => select(zhouYiTable).get();
  Future<ZhouYi> getZhouYiByBinary(String guaBinary) =>  (select(zhouYiTable)..where((tbl) => tbl.binary.equals(guaBinary))).getSingle();

  Future<List<ZhouYiGuaZhu>> findAllGuaZhu(String guaBinary) => (select(zhouYiGuaZhuTable)..where((tbl) => tbl.guaBinary.equals(guaBinary))).get();
  Future<List<ZhouYiGuaZhu>> findAllSingleGuaZhu(String guaBinary) => (select(zhouYiGuaZhuTable)..where((tbl) =>  tbl.isSingle.equals(true))..where((tbl) => tbl.guaBinary.equals(guaBinary))).get();
  Future<List<ZhouYiYaoZhu>> findAllYaoZhu(String guaBinary) => (select(zhouYiYaoZhuTable)..where((tbl) => tbl.guaBinary.equals(guaBinary))).get();

  Future<List<ZhouyiZhuBooks>> findAllZhuBooks() => select(zhouyiZhuBooksTable).get();

  Future<List<JiaoShiYiLin>> findAllSubZhi(String guaBinary) => (select(jiaoShiYiLinTable)..where((tbl) => tbl.guaBinary.equals(guaBinary))).get();
  Future<List<ZhouYiGuaYao>> findAllGuaYao(String guaBinary) => (select(zhouYiGuaYaoTable)..where((tbl) => tbl.guaBinary.equals(guaBinary))).get();
}




// 开启数据库连接
LazyDatabase _openConnection() {
    shouldCopy().then((value) {
    if (value){
      copyFile();
    }
  });
  // the LazyDatabase util lets us find the right location for the file async.
  return LazyDatabase(() async {
    // put the database file, called db.sqlite here, into the documents folder
    // for your app.
    final dbFolder = await getApplicationDocumentsDirectory();
    final File file = File("${dbFolder.path}/db.sqlite3");
    // file = File(p.join(dbFolder.path, 'db.sqlite'));

    // Also work around limitations on old Android versions
    if (Platform.isAndroid) {
      await applyWorkaroundToOpenSqlite3OnOldAndroidVersions();
    }

    // Make sqlite3 pick a more suitable location for temporary files - the
    // one from the system may be inaccessible due to sandboxing.
    final cachebase = (await getTemporaryDirectory()).path;
    // We can't access /tmp on Android, which sqlite3 would try by default.
    // Explicitly tell it about the correct temporary directory.
    sqlite3.tempDirectory = cachebase;

    return NativeDatabase.createInBackground(file);
  });
}
Future<bool> shouldCopy() async {
  var dbFolder = await getApplicationDocumentsDirectory();
  File file = File("${dbFolder.path}/db.sqlite3");
  if (!file.existsSync()){
    return true;
  }
  return false;
}
Future<void> copyFile() async {
  var dbFolder = await getApplicationDocumentsDirectory();
  File file = File("${dbFolder.path}/db.sqlite3");
  if (file.existsSync()){
    file.deleteSync();
  }
  // 当前数据库文件不存在，从assets中拷贝
  var dbData = await rootBundle.load("assets/db/db.sqlite3");
  List<int> bytes = dbData.buffer.asUint8List(dbData.offsetInBytes, dbData.lengthInBytes);
  file.writeAsBytes(bytes);
}
