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



}



// 开启数据库连接

LazyDatabase _openConnection() {
  getApplicationDocumentsDirectory()
      .then((dbFolder){
    File file = File("${dbFolder.path}/db.sqlite3");
    if (!file.existsSync()){
      // 当前数据库文件不存在，从assets中拷贝
      rootBundle.load("assets/db.sqlite3").then((dbData){
        List<int> bytes = dbData.buffer.asUint8List(dbData.offsetInBytes, dbData.lengthInBytes);
        file.writeAsBytes(bytes);
      });
    }
  });
  return LazyDatabase(() async {

    // check file isExist
    final dbFolder = await getApplicationDocumentsDirectory();
    File file = File("${dbFolder.path}/db.sqlite3");
    return VmDatabase(file, logStatements: true);

  });

}
