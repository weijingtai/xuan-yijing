import 'dart:convert';
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
        sqlite3Wasm: Uri.parse('sqlite3.wasm'),
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
          // Drift automatically appends .sqlite to `name` ('db' -> 'db.sqlite')
          final file = File(p.join(dbFolder.path, 'db.sqlite'));
          print("[MyDatabase] Native database file path: ${file.path}");

          try {
            if (!file.existsSync() || file.lengthSync() < 1000000) {
              print("[MyDatabase] Copying initial db.sqlite3 from assets to ${file.path}...");
              final dbData =
                  await rootBundle.load('packages/yijing/assets/db/db.sqlite3');
              final List<int> bytes = dbData.buffer.asUint8List(
                dbData.offsetInBytes,
                dbData.lengthInBytes,
              );
              await file.parent.create(recursive: true);
              await file.writeAsBytes(bytes, flush: true);
              print("[MyDatabase] Asset database copied successfully (${bytes.length} bytes)");
            } else {
              print("[MyDatabase] Existing database verified (${file.lengthSync()} bytes)");
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
  @override
  MigrationStrategy get migration => MigrationStrategy(
        onCreate: (migrator) async {
          print("[MyDatabase] onCreate triggered, creating all tables...");
          await migrator.createAll();
        },
        onUpgrade: (migrator, from, to) async {},
        beforeOpen: (details) async {
          print("[MyDatabase] Database beforeOpen called, wasCreated: ${details.wasCreated}, version: ${details.versionBefore} -> ${details.versionNow}");
          await customStatement('PRAGMA foreign_keys = ON');

          if (kIsWeb) {
            final countSelect = await customSelect('SELECT COUNT(*) as c FROM t_zy').getSingle();
            final count = countSelect.read<int>('c');
            print("[MyDatabase] Web platform detected. Current t_zy count: $count, wasCreated: ${details.wasCreated}");

            if (count == 0) {
              print("[MyDatabase] Web t_zy table is empty. Seeding data from assets...");
              try {
                final jsonStr = await rootBundle
                    .loadString('packages/yijing/resources/db/all_gua_v1.json');
                final indexStr = await rootBundle.loadString(
                    'packages/yijing/resources/db/gua_fullname_binary_index.json');
                final List<dynamic> list = jsonDecode(jsonStr);
                final Map<String, dynamic> binaryIndexMap = jsonDecode(indexStr);

                print("[MyDatabase] Loaded ${list.length} items from resources/db/all_gua_v1.json for Web seeding");
                
                final entries = <ZhouYiTableCompanion>[];
                int autoSeq = 1;
                for (final item in list) {
                  final map = item as Map<String, dynamic>;
                  
                  String extractString(dynamic val) {
                    if (val == null) return '';
                    if (val is String) return val;
                    if (val is Map) return val['content']?.toString() ?? val.toString();
                    return val.toString();
                  }

                  final name = extractString(map['name']);
                  String binary = extractString(map['binary']);
                  if (binary.isEmpty) {
                    final fullNameKey = map['fullname'] ?? map['name'];
                    if (fullNameKey != null && binaryIndexMap.containsKey(fullNameKey)) {
                      binary = binaryIndexMap[fullNameKey].toString();
                    } else {
                      for (final entry in binaryIndexMap.entries) {
                        if (entry.key.contains(name)) {
                          binary = entry.value.toString();
                          break;
                        }
                      }
                    }
                  }
                  if (binary.isEmpty) continue;

                  entries.add(ZhouYiTableCompanion.insert(
                    binary: binary,
                    seq: map['seq'] is int ? map['seq'] : (int.tryParse(map['seq']?.toString() ?? '') ?? autoSeq),
                    name: name,
                    fullname: extractString(map['fullname'] ?? name),
                    baguaInner: extractString(map['bagua_inner'] ?? map['baguaInner']),
                    baguaInnerName: extractString(map['bagua_inner_name'] ?? map['baguaInnerName']),
                    baguaInnerNickname: extractString(map['bagua_inner_nickname'] ?? map['baguaInnerNickname']),
                    baguaOuter: extractString(map['bagua_outer'] ?? map['baguaOuter']),
                    baguaOuterName: extractString(map['bagua_outer_name'] ?? map['baguaOuterName']),
                    baguaOuterNickname: extractString(map['bagua_outer_nickname'] ?? map['baguaOuterNickname']),
                    xiang: extractString(map['xiang']),
                    tuan: extractString(map['tuan']),
                    gua: extractString(map['gua'] ?? map['content']),
                  ));
                  autoSeq++;
                }

                await batch((batch) {
                  batch.insertAllOnConflictUpdate(zhouYiTable, entries);
                });
                print("[MyDatabase] Successfully seeded ${entries.length} ZhouYi items into Web database");
              } catch (err, st) {
                print("[MyDatabase] Error seeding Web database: $err\n$st");
              }
            }
          }
        },
      );

  Future<List<ZhouYi>> listAllZhouYi() async {
    print("[MyDatabase] listAllZhouYi() started...");
    try {
      final res = await select(zhouYiTable).get();
      print("[MyDatabase] listAllZhouYi() success, count: ${res.length}");
      if (res.isNotEmpty) {
        print("[MyDatabase] First item sample: binary=${res.first.binary}, name=${res.first.name}, fullname=${res.first.fullname}");
      }
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

