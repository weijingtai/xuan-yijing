import 'dart:io';

import 'package:flutter/services.dart';
import 'package:moor/ffi.dart';
import 'package:moor/moor.dart';
import 'package:path_provider/path_provider.dart';

import '../models/JiaoShiYiLin.dart';
import '../models/ZhouYiGuaYaoTable.dart';
import '../models/ZhouYiGuaZhuTable.dart';
import '../models/ZhouYiTable.dart';
import '../models/ZhouYiYaoZhuTable.dart';
import '../models/ZhouYiZhuBooksTable.dart';

part 'MyDatabase.g.dart';

@UseMoor(tables: [ZhouYiTable, ZhouYiGuaZhuTable, ZhouYiYaoZhuTable, ZhouYiGuaYaoTable, ZhouyiZhuBooksTable, JiaoShiYiLinTable])
class MyDatabase extends _$MyDatabase {



  //创建数据库实例，开启数据库连接
  MyDatabase() : super(_openConnection());



  //数据库版本控制
  @override  int get schemaVersion => 1;



  //升级配置
  @override  MigrationStrategy get migration => MigrationStrategy(

      onUpgrade: (migrator, from, to) async {
        // if (from == 1) {
        //   migrator.deleteTable(zhouYiTable.actualTableName);
        //   migrator.createTable(zhouYiTable);
        // }
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

  return LazyDatabase(() async {
    // check file isExist
    // await copyFile();
    final dbFolder = await getApplicationDocumentsDirectory();
    File file = File("${dbFolder.path}/db.sqlite3");
    return VmDatabase(file, logStatements: true);

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
