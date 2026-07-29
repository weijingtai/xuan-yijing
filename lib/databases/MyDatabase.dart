import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;

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
  MyDatabase([QueryExecutor? e])
      : super(
          e ?? (kIsWeb ? _openWebDatabase() : _openNativeDatabase()),
        );

  static QueryExecutor _openWebDatabase() {
    print("[MyDatabase] Opening Web Database...");
    return driftDatabase(
      name: 'db',
      web: DriftWebOptions(
        sqlite3Wasm: Uri.parse('https://sqlite.org/2023/sqlite3.wasm'),
        driftWorker: Uri.parse('drift_worker.js'),
        onResult: (result) {
          print("[MyDatabase] Web Drift implementation: ${result.chosenImplementation}");
          if (result.missingFeatures.isNotEmpty) {
            print('[MyDatabase] Missing browser features: ${result.missingFeatures}');
          }
        },
      ),
    );
  }

  static QueryExecutor _openNativeDatabase() {
    print("[MyDatabase] Opening Native Database...");
    return driftDatabase(
      name: 'db',
      native: DriftNativeOptions(
        databaseDirectory: () async {
          final dbFolder = await getApplicationDocumentsDirectory();
          final file = File(p.join(dbFolder.path, 'db.sqlite3'));

          try {
            if (!file.existsSync() || file.lengthSync() == 0) {
              print("[MyDatabase] Copying initial db.sqlite3 from assets...");
              final dbData = await rootBundle.load("assets/db/db.sqlite3");
              final List<int> bytes = dbData.buffer.asUint8List(
                dbData.offsetInBytes,
                dbData.lengthInBytes,
              );
              await file.writeAsBytes(bytes, flush: true);
              print("[MyDatabase] Asset database copied successfully (${bytes.length} bytes)");
            } else {
              print("[MyDatabase] Existing db.sqlite3 found (${file.lengthSync()} bytes)");
            }
          } catch (err, st) {
            print("[MyDatabase] Error copying asset database: $err\n$st");
          }
          return dbFolder;
        },
      ),
    );
  }

  //数据库版本控制
  @override  int get schemaVersion => 1;

  //升级配置
  @override  MigrationStrategy get migration => MigrationStrategy(

      onUpgrade: (migrator, from, to) async {
        },
      beforeOpen: (details) async {
        print("[MyDatabase] Database beforeOpen called, wasCreated: ${details.wasCreated}, version: ${details.versionBefore} -> ${details.versionNow}");
        await customStatement('PRAGMA foreign_keys = ON');
      });

  Future<List<ZhouYi>> listAllZhouYi() async {
    print("[MyDatabase] listAllZhouYi() started...");
    try {
      final res = await select(zhouYiTable).get();
      print("[MyDatabase] listAllZhouYi() success, count: ${res.length}");
      return res;
    } catch (e, st) {
      print("[MyDatabase] listAllZhouYi() error: $e\n$st");
      rethrow;
    }
  }
  Future<ZhouYi> getZhouYiByBinary(String guaBinary) =>  (select(zhouYiTable)..where((tbl) => tbl.binary.equals(guaBinary))).getSingle();

  Future<List<ZhouYiGuaZhu>> findAllGuaZhu(String guaBinary) => (select(zhouYiGuaZhuTable)..where((tbl) => tbl.guaBinary.equals(guaBinary))).get();
  Future<List<ZhouYiGuaZhu>> findAllSingleGuaZhu(String guaBinary) => (select(zhouYiGuaZhuTable)..where((tbl) =>  tbl.isSingle.equals(true))..where((tbl) => tbl.guaBinary.equals(guaBinary))).get();
  Future<List<ZhouYiYaoZhu>> findAllYaoZhu(String guaBinary) => (select(zhouYiYaoZhuTable)..where((tbl) => tbl.guaBinary.equals(guaBinary))).get();

  Future<List<ZhouyiZhuBooks>> findAllZhuBooks() => select(zhouyiZhuBooksTable).get();

  Future<List<JiaoShiYiLin>> findAllSubZhi(String guaBinary) => (select(jiaoShiYiLinTable)..where((tbl) => tbl.guaBinary.equals(guaBinary))).get();
  Future<List<ZhouYiGuaYao>> findAllGuaYao(String guaBinary) => (select(zhouYiGuaYaoTable)..where((tbl) => tbl.guaBinary.equals(guaBinary))).get();
}

