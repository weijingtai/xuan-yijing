// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'MyDatabase.dart';

// **************************************************************************
// MoorGenerator
// **************************************************************************

// ignore_for_file: type=lint
class ZhouYi extends DataClass implements Insertable<ZhouYi> {
  final String binary;
  final int seq;
  final String name;
  final String fullname;
  final String baguaInner;
  final String baguaInnerName;
  final String baguaInnerNickname;
  final String baguaOuter;
  final String baguaOuterName;
  final String baguaOuterNickname;
  final String xiang;
  final String tuan;
  final String gua;
  ZhouYi(
      {required this.binary,
      required this.seq,
      required this.name,
      required this.fullname,
      required this.baguaInner,
      required this.baguaInnerName,
      required this.baguaInnerNickname,
      required this.baguaOuter,
      required this.baguaOuterName,
      required this.baguaOuterNickname,
      required this.xiang,
      required this.tuan,
      required this.gua});
  factory ZhouYi.fromData(Map<String, dynamic> data, GeneratedDatabase db,
      {String? prefix}) {
    final effectivePrefix = prefix ?? '';
    return ZhouYi(
      binary: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}binary'])!,
      seq: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}seq'])!,
      name: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}name'])!,
      fullname: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}fullname'])!,
      baguaInner: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}bagua_inner'])!,
      baguaInnerName: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}bagua_inner_name'])!,
      baguaInnerNickname: const StringType().mapFromDatabaseResponse(
          data['${effectivePrefix}bagua_inner_nickname'])!,
      baguaOuter: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}bagua_outer'])!,
      baguaOuterName: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}bagua_outer_name'])!,
      baguaOuterNickname: const StringType().mapFromDatabaseResponse(
          data['${effectivePrefix}bagua_outer_nickname'])!,
      xiang: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}xiang'])!,
      tuan: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}tuan'])!,
      gua: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}gua'])!,
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['binary'] = Variable<String>(binary);
    map['seq'] = Variable<int>(seq);
    map['name'] = Variable<String>(name);
    map['fullname'] = Variable<String>(fullname);
    map['bagua_inner'] = Variable<String>(baguaInner);
    map['bagua_inner_name'] = Variable<String>(baguaInnerName);
    map['bagua_inner_nickname'] = Variable<String>(baguaInnerNickname);
    map['bagua_outer'] = Variable<String>(baguaOuter);
    map['bagua_outer_name'] = Variable<String>(baguaOuterName);
    map['bagua_outer_nickname'] = Variable<String>(baguaOuterNickname);
    map['xiang'] = Variable<String>(xiang);
    map['tuan'] = Variable<String>(tuan);
    map['gua'] = Variable<String>(gua);
    return map;
  }

  ZhouYiTableCompanion toCompanion(bool nullToAbsent) {
    return ZhouYiTableCompanion(
      binary: Value(binary),
      seq: Value(seq),
      name: Value(name),
      fullname: Value(fullname),
      baguaInner: Value(baguaInner),
      baguaInnerName: Value(baguaInnerName),
      baguaInnerNickname: Value(baguaInnerNickname),
      baguaOuter: Value(baguaOuter),
      baguaOuterName: Value(baguaOuterName),
      baguaOuterNickname: Value(baguaOuterNickname),
      xiang: Value(xiang),
      tuan: Value(tuan),
      gua: Value(gua),
    );
  }

  factory ZhouYi.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return ZhouYi(
      binary: serializer.fromJson<String>(json['binary']),
      seq: serializer.fromJson<int>(json['seq']),
      name: serializer.fromJson<String>(json['name']),
      fullname: serializer.fromJson<String>(json['fullname']),
      baguaInner: serializer.fromJson<String>(json['baguaInner']),
      baguaInnerName: serializer.fromJson<String>(json['baguaInnerName']),
      baguaInnerNickname:
          serializer.fromJson<String>(json['baguaInnerNickname']),
      baguaOuter: serializer.fromJson<String>(json['baguaOuter']),
      baguaOuterName: serializer.fromJson<String>(json['baguaOuterName']),
      baguaOuterNickname:
          serializer.fromJson<String>(json['baguaOuterNickname']),
      xiang: serializer.fromJson<String>(json['xiang']),
      tuan: serializer.fromJson<String>(json['tuan']),
      gua: serializer.fromJson<String>(json['gua']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'binary': serializer.toJson<String>(binary),
      'seq': serializer.toJson<int>(seq),
      'name': serializer.toJson<String>(name),
      'fullname': serializer.toJson<String>(fullname),
      'baguaInner': serializer.toJson<String>(baguaInner),
      'baguaInnerName': serializer.toJson<String>(baguaInnerName),
      'baguaInnerNickname': serializer.toJson<String>(baguaInnerNickname),
      'baguaOuter': serializer.toJson<String>(baguaOuter),
      'baguaOuterName': serializer.toJson<String>(baguaOuterName),
      'baguaOuterNickname': serializer.toJson<String>(baguaOuterNickname),
      'xiang': serializer.toJson<String>(xiang),
      'tuan': serializer.toJson<String>(tuan),
      'gua': serializer.toJson<String>(gua),
    };
  }

  ZhouYi copyWith(
          {String? binary,
          int? seq,
          String? name,
          String? fullname,
          String? baguaInner,
          String? baguaInnerName,
          String? baguaInnerNickname,
          String? baguaOuter,
          String? baguaOuterName,
          String? baguaOuterNickname,
          String? xiang,
          String? tuan,
          String? gua}) =>
      ZhouYi(
        binary: binary ?? this.binary,
        seq: seq ?? this.seq,
        name: name ?? this.name,
        fullname: fullname ?? this.fullname,
        baguaInner: baguaInner ?? this.baguaInner,
        baguaInnerName: baguaInnerName ?? this.baguaInnerName,
        baguaInnerNickname: baguaInnerNickname ?? this.baguaInnerNickname,
        baguaOuter: baguaOuter ?? this.baguaOuter,
        baguaOuterName: baguaOuterName ?? this.baguaOuterName,
        baguaOuterNickname: baguaOuterNickname ?? this.baguaOuterNickname,
        xiang: xiang ?? this.xiang,
        tuan: tuan ?? this.tuan,
        gua: gua ?? this.gua,
      );
  @override
  String toString() {
    return (StringBuffer('ZhouYi(')
          ..write('binary: $binary, ')
          ..write('seq: $seq, ')
          ..write('name: $name, ')
          ..write('fullname: $fullname, ')
          ..write('baguaInner: $baguaInner, ')
          ..write('baguaInnerName: $baguaInnerName, ')
          ..write('baguaInnerNickname: $baguaInnerNickname, ')
          ..write('baguaOuter: $baguaOuter, ')
          ..write('baguaOuterName: $baguaOuterName, ')
          ..write('baguaOuterNickname: $baguaOuterNickname, ')
          ..write('xiang: $xiang, ')
          ..write('tuan: $tuan, ')
          ..write('gua: $gua')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      binary,
      seq,
      name,
      fullname,
      baguaInner,
      baguaInnerName,
      baguaInnerNickname,
      baguaOuter,
      baguaOuterName,
      baguaOuterNickname,
      xiang,
      tuan,
      gua);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ZhouYi &&
          other.binary == this.binary &&
          other.seq == this.seq &&
          other.name == this.name &&
          other.fullname == this.fullname &&
          other.baguaInner == this.baguaInner &&
          other.baguaInnerName == this.baguaInnerName &&
          other.baguaInnerNickname == this.baguaInnerNickname &&
          other.baguaOuter == this.baguaOuter &&
          other.baguaOuterName == this.baguaOuterName &&
          other.baguaOuterNickname == this.baguaOuterNickname &&
          other.xiang == this.xiang &&
          other.tuan == this.tuan &&
          other.gua == this.gua);
}

class ZhouYiTableCompanion extends UpdateCompanion<ZhouYi> {
  final Value<String> binary;
  final Value<int> seq;
  final Value<String> name;
  final Value<String> fullname;
  final Value<String> baguaInner;
  final Value<String> baguaInnerName;
  final Value<String> baguaInnerNickname;
  final Value<String> baguaOuter;
  final Value<String> baguaOuterName;
  final Value<String> baguaOuterNickname;
  final Value<String> xiang;
  final Value<String> tuan;
  final Value<String> gua;
  const ZhouYiTableCompanion({
    this.binary = const Value.absent(),
    this.seq = const Value.absent(),
    this.name = const Value.absent(),
    this.fullname = const Value.absent(),
    this.baguaInner = const Value.absent(),
    this.baguaInnerName = const Value.absent(),
    this.baguaInnerNickname = const Value.absent(),
    this.baguaOuter = const Value.absent(),
    this.baguaOuterName = const Value.absent(),
    this.baguaOuterNickname = const Value.absent(),
    this.xiang = const Value.absent(),
    this.tuan = const Value.absent(),
    this.gua = const Value.absent(),
  });
  ZhouYiTableCompanion.insert({
    required String binary,
    required int seq,
    required String name,
    required String fullname,
    required String baguaInner,
    required String baguaInnerName,
    required String baguaInnerNickname,
    required String baguaOuter,
    required String baguaOuterName,
    required String baguaOuterNickname,
    required String xiang,
    required String tuan,
    required String gua,
  })  : binary = Value(binary),
        seq = Value(seq),
        name = Value(name),
        fullname = Value(fullname),
        baguaInner = Value(baguaInner),
        baguaInnerName = Value(baguaInnerName),
        baguaInnerNickname = Value(baguaInnerNickname),
        baguaOuter = Value(baguaOuter),
        baguaOuterName = Value(baguaOuterName),
        baguaOuterNickname = Value(baguaOuterNickname),
        xiang = Value(xiang),
        tuan = Value(tuan),
        gua = Value(gua);
  static Insertable<ZhouYi> custom({
    Expression<String>? binary,
    Expression<int>? seq,
    Expression<String>? name,
    Expression<String>? fullname,
    Expression<String>? baguaInner,
    Expression<String>? baguaInnerName,
    Expression<String>? baguaInnerNickname,
    Expression<String>? baguaOuter,
    Expression<String>? baguaOuterName,
    Expression<String>? baguaOuterNickname,
    Expression<String>? xiang,
    Expression<String>? tuan,
    Expression<String>? gua,
  }) {
    return RawValuesInsertable({
      if (binary != null) 'binary': binary,
      if (seq != null) 'seq': seq,
      if (name != null) 'name': name,
      if (fullname != null) 'fullname': fullname,
      if (baguaInner != null) 'bagua_inner': baguaInner,
      if (baguaInnerName != null) 'bagua_inner_name': baguaInnerName,
      if (baguaInnerNickname != null)
        'bagua_inner_nickname': baguaInnerNickname,
      if (baguaOuter != null) 'bagua_outer': baguaOuter,
      if (baguaOuterName != null) 'bagua_outer_name': baguaOuterName,
      if (baguaOuterNickname != null)
        'bagua_outer_nickname': baguaOuterNickname,
      if (xiang != null) 'xiang': xiang,
      if (tuan != null) 'tuan': tuan,
      if (gua != null) 'gua': gua,
    });
  }

  ZhouYiTableCompanion copyWith(
      {Value<String>? binary,
      Value<int>? seq,
      Value<String>? name,
      Value<String>? fullname,
      Value<String>? baguaInner,
      Value<String>? baguaInnerName,
      Value<String>? baguaInnerNickname,
      Value<String>? baguaOuter,
      Value<String>? baguaOuterName,
      Value<String>? baguaOuterNickname,
      Value<String>? xiang,
      Value<String>? tuan,
      Value<String>? gua}) {
    return ZhouYiTableCompanion(
      binary: binary ?? this.binary,
      seq: seq ?? this.seq,
      name: name ?? this.name,
      fullname: fullname ?? this.fullname,
      baguaInner: baguaInner ?? this.baguaInner,
      baguaInnerName: baguaInnerName ?? this.baguaInnerName,
      baguaInnerNickname: baguaInnerNickname ?? this.baguaInnerNickname,
      baguaOuter: baguaOuter ?? this.baguaOuter,
      baguaOuterName: baguaOuterName ?? this.baguaOuterName,
      baguaOuterNickname: baguaOuterNickname ?? this.baguaOuterNickname,
      xiang: xiang ?? this.xiang,
      tuan: tuan ?? this.tuan,
      gua: gua ?? this.gua,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (binary.present) {
      map['binary'] = Variable<String>(binary.value);
    }
    if (seq.present) {
      map['seq'] = Variable<int>(seq.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (fullname.present) {
      map['fullname'] = Variable<String>(fullname.value);
    }
    if (baguaInner.present) {
      map['bagua_inner'] = Variable<String>(baguaInner.value);
    }
    if (baguaInnerName.present) {
      map['bagua_inner_name'] = Variable<String>(baguaInnerName.value);
    }
    if (baguaInnerNickname.present) {
      map['bagua_inner_nickname'] = Variable<String>(baguaInnerNickname.value);
    }
    if (baguaOuter.present) {
      map['bagua_outer'] = Variable<String>(baguaOuter.value);
    }
    if (baguaOuterName.present) {
      map['bagua_outer_name'] = Variable<String>(baguaOuterName.value);
    }
    if (baguaOuterNickname.present) {
      map['bagua_outer_nickname'] = Variable<String>(baguaOuterNickname.value);
    }
    if (xiang.present) {
      map['xiang'] = Variable<String>(xiang.value);
    }
    if (tuan.present) {
      map['tuan'] = Variable<String>(tuan.value);
    }
    if (gua.present) {
      map['gua'] = Variable<String>(gua.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ZhouYiTableCompanion(')
          ..write('binary: $binary, ')
          ..write('seq: $seq, ')
          ..write('name: $name, ')
          ..write('fullname: $fullname, ')
          ..write('baguaInner: $baguaInner, ')
          ..write('baguaInnerName: $baguaInnerName, ')
          ..write('baguaInnerNickname: $baguaInnerNickname, ')
          ..write('baguaOuter: $baguaOuter, ')
          ..write('baguaOuterName: $baguaOuterName, ')
          ..write('baguaOuterNickname: $baguaOuterNickname, ')
          ..write('xiang: $xiang, ')
          ..write('tuan: $tuan, ')
          ..write('gua: $gua')
          ..write(')'))
        .toString();
  }
}

class $ZhouYiTableTable extends ZhouYiTable
    with TableInfo<$ZhouYiTableTable, ZhouYi> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ZhouYiTableTable(this.attachedDatabase, [this._alias]);
  final VerificationMeta _binaryMeta = const VerificationMeta('binary');
  @override
  late final GeneratedColumn<String?> binary = GeneratedColumn<String?>(
      'binary', aliasedName, false,
      type: const StringType(), requiredDuringInsert: true);
  final VerificationMeta _seqMeta = const VerificationMeta('seq');
  @override
  late final GeneratedColumn<int?> seq = GeneratedColumn<int?>(
      'seq', aliasedName, false,
      type: const IntType(), requiredDuringInsert: true);
  final VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String?> name = GeneratedColumn<String?>(
      'name', aliasedName, false,
      type: const StringType(), requiredDuringInsert: true);
  final VerificationMeta _fullnameMeta = const VerificationMeta('fullname');
  @override
  late final GeneratedColumn<String?> fullname = GeneratedColumn<String?>(
      'fullname', aliasedName, false,
      type: const StringType(), requiredDuringInsert: true);
  final VerificationMeta _baguaInnerMeta = const VerificationMeta('baguaInner');
  @override
  late final GeneratedColumn<String?> baguaInner = GeneratedColumn<String?>(
      'bagua_inner', aliasedName, false,
      type: const StringType(), requiredDuringInsert: true);
  final VerificationMeta _baguaInnerNameMeta =
      const VerificationMeta('baguaInnerName');
  @override
  late final GeneratedColumn<String?> baguaInnerName = GeneratedColumn<String?>(
      'bagua_inner_name', aliasedName, false,
      type: const StringType(), requiredDuringInsert: true);
  final VerificationMeta _baguaInnerNicknameMeta =
      const VerificationMeta('baguaInnerNickname');
  @override
  late final GeneratedColumn<String?> baguaInnerNickname =
      GeneratedColumn<String?>('bagua_inner_nickname', aliasedName, false,
          type: const StringType(), requiredDuringInsert: true);
  final VerificationMeta _baguaOuterMeta = const VerificationMeta('baguaOuter');
  @override
  late final GeneratedColumn<String?> baguaOuter = GeneratedColumn<String?>(
      'bagua_outer', aliasedName, false,
      type: const StringType(), requiredDuringInsert: true);
  final VerificationMeta _baguaOuterNameMeta =
      const VerificationMeta('baguaOuterName');
  @override
  late final GeneratedColumn<String?> baguaOuterName = GeneratedColumn<String?>(
      'bagua_outer_name', aliasedName, false,
      type: const StringType(), requiredDuringInsert: true);
  final VerificationMeta _baguaOuterNicknameMeta =
      const VerificationMeta('baguaOuterNickname');
  @override
  late final GeneratedColumn<String?> baguaOuterNickname =
      GeneratedColumn<String?>('bagua_outer_nickname', aliasedName, false,
          type: const StringType(), requiredDuringInsert: true);
  final VerificationMeta _xiangMeta = const VerificationMeta('xiang');
  @override
  late final GeneratedColumn<String?> xiang = GeneratedColumn<String?>(
      'xiang', aliasedName, false,
      type: const StringType(), requiredDuringInsert: true);
  final VerificationMeta _tuanMeta = const VerificationMeta('tuan');
  @override
  late final GeneratedColumn<String?> tuan = GeneratedColumn<String?>(
      'tuan', aliasedName, false,
      type: const StringType(), requiredDuringInsert: true);
  final VerificationMeta _guaMeta = const VerificationMeta('gua');
  @override
  late final GeneratedColumn<String?> gua = GeneratedColumn<String?>(
      'gua', aliasedName, false,
      type: const StringType(), requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [
        binary,
        seq,
        name,
        fullname,
        baguaInner,
        baguaInnerName,
        baguaInnerNickname,
        baguaOuter,
        baguaOuterName,
        baguaOuterNickname,
        xiang,
        tuan,
        gua
      ];
  @override
  String get aliasedName => _alias ?? 't_zy';
  @override
  String get actualTableName => 't_zy';
  @override
  VerificationContext validateIntegrity(Insertable<ZhouYi> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('binary')) {
      context.handle(_binaryMeta,
          binary.isAcceptableOrUnknown(data['binary']!, _binaryMeta));
    } else if (isInserting) {
      context.missing(_binaryMeta);
    }
    if (data.containsKey('seq')) {
      context.handle(
          _seqMeta, seq.isAcceptableOrUnknown(data['seq']!, _seqMeta));
    } else if (isInserting) {
      context.missing(_seqMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('fullname')) {
      context.handle(_fullnameMeta,
          fullname.isAcceptableOrUnknown(data['fullname']!, _fullnameMeta));
    } else if (isInserting) {
      context.missing(_fullnameMeta);
    }
    if (data.containsKey('bagua_inner')) {
      context.handle(
          _baguaInnerMeta,
          baguaInner.isAcceptableOrUnknown(
              data['bagua_inner']!, _baguaInnerMeta));
    } else if (isInserting) {
      context.missing(_baguaInnerMeta);
    }
    if (data.containsKey('bagua_inner_name')) {
      context.handle(
          _baguaInnerNameMeta,
          baguaInnerName.isAcceptableOrUnknown(
              data['bagua_inner_name']!, _baguaInnerNameMeta));
    } else if (isInserting) {
      context.missing(_baguaInnerNameMeta);
    }
    if (data.containsKey('bagua_inner_nickname')) {
      context.handle(
          _baguaInnerNicknameMeta,
          baguaInnerNickname.isAcceptableOrUnknown(
              data['bagua_inner_nickname']!, _baguaInnerNicknameMeta));
    } else if (isInserting) {
      context.missing(_baguaInnerNicknameMeta);
    }
    if (data.containsKey('bagua_outer')) {
      context.handle(
          _baguaOuterMeta,
          baguaOuter.isAcceptableOrUnknown(
              data['bagua_outer']!, _baguaOuterMeta));
    } else if (isInserting) {
      context.missing(_baguaOuterMeta);
    }
    if (data.containsKey('bagua_outer_name')) {
      context.handle(
          _baguaOuterNameMeta,
          baguaOuterName.isAcceptableOrUnknown(
              data['bagua_outer_name']!, _baguaOuterNameMeta));
    } else if (isInserting) {
      context.missing(_baguaOuterNameMeta);
    }
    if (data.containsKey('bagua_outer_nickname')) {
      context.handle(
          _baguaOuterNicknameMeta,
          baguaOuterNickname.isAcceptableOrUnknown(
              data['bagua_outer_nickname']!, _baguaOuterNicknameMeta));
    } else if (isInserting) {
      context.missing(_baguaOuterNicknameMeta);
    }
    if (data.containsKey('xiang')) {
      context.handle(
          _xiangMeta, xiang.isAcceptableOrUnknown(data['xiang']!, _xiangMeta));
    } else if (isInserting) {
      context.missing(_xiangMeta);
    }
    if (data.containsKey('tuan')) {
      context.handle(
          _tuanMeta, tuan.isAcceptableOrUnknown(data['tuan']!, _tuanMeta));
    } else if (isInserting) {
      context.missing(_tuanMeta);
    }
    if (data.containsKey('gua')) {
      context.handle(
          _guaMeta, gua.isAcceptableOrUnknown(data['gua']!, _guaMeta));
    } else if (isInserting) {
      context.missing(_guaMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {binary};
  @override
  ZhouYi map(Map<String, dynamic> data, {String? tablePrefix}) {
    return ZhouYi.fromData(data, attachedDatabase,
        prefix: tablePrefix != null ? '$tablePrefix.' : null);
  }

  @override
  $ZhouYiTableTable createAlias(String alias) {
    return $ZhouYiTableTable(attachedDatabase, alias);
  }
}

class ZhouYiGuaZhu extends DataClass implements Insertable<ZhouYiGuaZhu> {
  final int id;
  final bool isSingle;
  final String guaBinary;
  final int bookId;
  final String? guaZhu;
  final String? xiangZhu;
  final String? tuanZhu;
  ZhouYiGuaZhu(
      {required this.id,
      required this.isSingle,
      required this.guaBinary,
      required this.bookId,
      this.guaZhu,
      this.xiangZhu,
      this.tuanZhu});
  factory ZhouYiGuaZhu.fromData(Map<String, dynamic> data, GeneratedDatabase db,
      {String? prefix}) {
    final effectivePrefix = prefix ?? '';
    return ZhouYiGuaZhu(
      id: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}id'])!,
      isSingle: const BoolType()
          .mapFromDatabaseResponse(data['${effectivePrefix}is_single'])!,
      guaBinary: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}gua_binary'])!,
      bookId: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}book_id'])!,
      guaZhu: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}gua_zhu']),
      xiangZhu: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}xiang_zhu']),
      tuanZhu: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}tuan_zhu']),
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['is_single'] = Variable<bool>(isSingle);
    map['gua_binary'] = Variable<String>(guaBinary);
    map['book_id'] = Variable<int>(bookId);
    if (!nullToAbsent || guaZhu != null) {
      map['gua_zhu'] = Variable<String?>(guaZhu);
    }
    if (!nullToAbsent || xiangZhu != null) {
      map['xiang_zhu'] = Variable<String?>(xiangZhu);
    }
    if (!nullToAbsent || tuanZhu != null) {
      map['tuan_zhu'] = Variable<String?>(tuanZhu);
    }
    return map;
  }

  ZhouYiGuaZhuTableCompanion toCompanion(bool nullToAbsent) {
    return ZhouYiGuaZhuTableCompanion(
      id: Value(id),
      isSingle: Value(isSingle),
      guaBinary: Value(guaBinary),
      bookId: Value(bookId),
      guaZhu:
          guaZhu == null && nullToAbsent ? const Value.absent() : Value(guaZhu),
      xiangZhu: xiangZhu == null && nullToAbsent
          ? const Value.absent()
          : Value(xiangZhu),
      tuanZhu: tuanZhu == null && nullToAbsent
          ? const Value.absent()
          : Value(tuanZhu),
    );
  }

  factory ZhouYiGuaZhu.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return ZhouYiGuaZhu(
      id: serializer.fromJson<int>(json['id']),
      isSingle: serializer.fromJson<bool>(json['isSingle']),
      guaBinary: serializer.fromJson<String>(json['guaBinary']),
      bookId: serializer.fromJson<int>(json['bookId']),
      guaZhu: serializer.fromJson<String?>(json['guaZhu']),
      xiangZhu: serializer.fromJson<String?>(json['xiangZhu']),
      tuanZhu: serializer.fromJson<String?>(json['tuanZhu']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'isSingle': serializer.toJson<bool>(isSingle),
      'guaBinary': serializer.toJson<String>(guaBinary),
      'bookId': serializer.toJson<int>(bookId),
      'guaZhu': serializer.toJson<String?>(guaZhu),
      'xiangZhu': serializer.toJson<String?>(xiangZhu),
      'tuanZhu': serializer.toJson<String?>(tuanZhu),
    };
  }

  ZhouYiGuaZhu copyWith(
          {int? id,
          bool? isSingle,
          String? guaBinary,
          int? bookId,
          String? guaZhu,
          String? xiangZhu,
          String? tuanZhu}) =>
      ZhouYiGuaZhu(
        id: id ?? this.id,
        isSingle: isSingle ?? this.isSingle,
        guaBinary: guaBinary ?? this.guaBinary,
        bookId: bookId ?? this.bookId,
        guaZhu: guaZhu ?? this.guaZhu,
        xiangZhu: xiangZhu ?? this.xiangZhu,
        tuanZhu: tuanZhu ?? this.tuanZhu,
      );
  @override
  String toString() {
    return (StringBuffer('ZhouYiGuaZhu(')
          ..write('id: $id, ')
          ..write('isSingle: $isSingle, ')
          ..write('guaBinary: $guaBinary, ')
          ..write('bookId: $bookId, ')
          ..write('guaZhu: $guaZhu, ')
          ..write('xiangZhu: $xiangZhu, ')
          ..write('tuanZhu: $tuanZhu')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, isSingle, guaBinary, bookId, guaZhu, xiangZhu, tuanZhu);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ZhouYiGuaZhu &&
          other.id == this.id &&
          other.isSingle == this.isSingle &&
          other.guaBinary == this.guaBinary &&
          other.bookId == this.bookId &&
          other.guaZhu == this.guaZhu &&
          other.xiangZhu == this.xiangZhu &&
          other.tuanZhu == this.tuanZhu);
}

class ZhouYiGuaZhuTableCompanion extends UpdateCompanion<ZhouYiGuaZhu> {
  final Value<int> id;
  final Value<bool> isSingle;
  final Value<String> guaBinary;
  final Value<int> bookId;
  final Value<String?> guaZhu;
  final Value<String?> xiangZhu;
  final Value<String?> tuanZhu;
  const ZhouYiGuaZhuTableCompanion({
    this.id = const Value.absent(),
    this.isSingle = const Value.absent(),
    this.guaBinary = const Value.absent(),
    this.bookId = const Value.absent(),
    this.guaZhu = const Value.absent(),
    this.xiangZhu = const Value.absent(),
    this.tuanZhu = const Value.absent(),
  });
  ZhouYiGuaZhuTableCompanion.insert({
    this.id = const Value.absent(),
    required bool isSingle,
    required String guaBinary,
    required int bookId,
    this.guaZhu = const Value.absent(),
    this.xiangZhu = const Value.absent(),
    this.tuanZhu = const Value.absent(),
  })  : isSingle = Value(isSingle),
        guaBinary = Value(guaBinary),
        bookId = Value(bookId);
  static Insertable<ZhouYiGuaZhu> custom({
    Expression<int>? id,
    Expression<bool>? isSingle,
    Expression<String>? guaBinary,
    Expression<int>? bookId,
    Expression<String?>? guaZhu,
    Expression<String?>? xiangZhu,
    Expression<String?>? tuanZhu,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (isSingle != null) 'is_single': isSingle,
      if (guaBinary != null) 'gua_binary': guaBinary,
      if (bookId != null) 'book_id': bookId,
      if (guaZhu != null) 'gua_zhu': guaZhu,
      if (xiangZhu != null) 'xiang_zhu': xiangZhu,
      if (tuanZhu != null) 'tuan_zhu': tuanZhu,
    });
  }

  ZhouYiGuaZhuTableCompanion copyWith(
      {Value<int>? id,
      Value<bool>? isSingle,
      Value<String>? guaBinary,
      Value<int>? bookId,
      Value<String?>? guaZhu,
      Value<String?>? xiangZhu,
      Value<String?>? tuanZhu}) {
    return ZhouYiGuaZhuTableCompanion(
      id: id ?? this.id,
      isSingle: isSingle ?? this.isSingle,
      guaBinary: guaBinary ?? this.guaBinary,
      bookId: bookId ?? this.bookId,
      guaZhu: guaZhu ?? this.guaZhu,
      xiangZhu: xiangZhu ?? this.xiangZhu,
      tuanZhu: tuanZhu ?? this.tuanZhu,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (isSingle.present) {
      map['is_single'] = Variable<bool>(isSingle.value);
    }
    if (guaBinary.present) {
      map['gua_binary'] = Variable<String>(guaBinary.value);
    }
    if (bookId.present) {
      map['book_id'] = Variable<int>(bookId.value);
    }
    if (guaZhu.present) {
      map['gua_zhu'] = Variable<String?>(guaZhu.value);
    }
    if (xiangZhu.present) {
      map['xiang_zhu'] = Variable<String?>(xiangZhu.value);
    }
    if (tuanZhu.present) {
      map['tuan_zhu'] = Variable<String?>(tuanZhu.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ZhouYiGuaZhuTableCompanion(')
          ..write('id: $id, ')
          ..write('isSingle: $isSingle, ')
          ..write('guaBinary: $guaBinary, ')
          ..write('bookId: $bookId, ')
          ..write('guaZhu: $guaZhu, ')
          ..write('xiangZhu: $xiangZhu, ')
          ..write('tuanZhu: $tuanZhu')
          ..write(')'))
        .toString();
  }
}

class $ZhouYiGuaZhuTableTable extends ZhouYiGuaZhuTable
    with TableInfo<$ZhouYiGuaZhuTableTable, ZhouYiGuaZhu> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ZhouYiGuaZhuTableTable(this.attachedDatabase, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int?> id = GeneratedColumn<int?>(
      'id', aliasedName, false,
      type: const IntType(),
      requiredDuringInsert: false,
      defaultConstraints: 'PRIMARY KEY AUTOINCREMENT');
  final VerificationMeta _isSingleMeta = const VerificationMeta('isSingle');
  @override
  late final GeneratedColumn<bool?> isSingle = GeneratedColumn<bool?>(
      'is_single', aliasedName, false,
      type: const BoolType(),
      requiredDuringInsert: true,
      defaultConstraints: 'CHECK (is_single IN (0, 1))');
  final VerificationMeta _guaBinaryMeta = const VerificationMeta('guaBinary');
  @override
  late final GeneratedColumn<String?> guaBinary = GeneratedColumn<String?>(
      'gua_binary', aliasedName, false,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 6, maxTextLength: 6),
      type: const StringType(),
      requiredDuringInsert: true);
  final VerificationMeta _bookIdMeta = const VerificationMeta('bookId');
  @override
  late final GeneratedColumn<int?> bookId = GeneratedColumn<int?>(
      'book_id', aliasedName, false,
      type: const IntType(), requiredDuringInsert: true);
  final VerificationMeta _guaZhuMeta = const VerificationMeta('guaZhu');
  @override
  late final GeneratedColumn<String?> guaZhu = GeneratedColumn<String?>(
      'gua_zhu', aliasedName, true,
      type: const StringType(), requiredDuringInsert: false);
  final VerificationMeta _xiangZhuMeta = const VerificationMeta('xiangZhu');
  @override
  late final GeneratedColumn<String?> xiangZhu = GeneratedColumn<String?>(
      'xiang_zhu', aliasedName, true,
      type: const StringType(), requiredDuringInsert: false);
  final VerificationMeta _tuanZhuMeta = const VerificationMeta('tuanZhu');
  @override
  late final GeneratedColumn<String?> tuanZhu = GeneratedColumn<String?>(
      'tuan_zhu', aliasedName, true,
      type: const StringType(), requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns =>
      [id, isSingle, guaBinary, bookId, guaZhu, xiangZhu, tuanZhu];
  @override
  String get aliasedName => _alias ?? 't_zy_gua_zhu';
  @override
  String get actualTableName => 't_zy_gua_zhu';
  @override
  VerificationContext validateIntegrity(Insertable<ZhouYiGuaZhu> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('is_single')) {
      context.handle(_isSingleMeta,
          isSingle.isAcceptableOrUnknown(data['is_single']!, _isSingleMeta));
    } else if (isInserting) {
      context.missing(_isSingleMeta);
    }
    if (data.containsKey('gua_binary')) {
      context.handle(_guaBinaryMeta,
          guaBinary.isAcceptableOrUnknown(data['gua_binary']!, _guaBinaryMeta));
    } else if (isInserting) {
      context.missing(_guaBinaryMeta);
    }
    if (data.containsKey('book_id')) {
      context.handle(_bookIdMeta,
          bookId.isAcceptableOrUnknown(data['book_id']!, _bookIdMeta));
    } else if (isInserting) {
      context.missing(_bookIdMeta);
    }
    if (data.containsKey('gua_zhu')) {
      context.handle(_guaZhuMeta,
          guaZhu.isAcceptableOrUnknown(data['gua_zhu']!, _guaZhuMeta));
    }
    if (data.containsKey('xiang_zhu')) {
      context.handle(_xiangZhuMeta,
          xiangZhu.isAcceptableOrUnknown(data['xiang_zhu']!, _xiangZhuMeta));
    }
    if (data.containsKey('tuan_zhu')) {
      context.handle(_tuanZhuMeta,
          tuanZhu.isAcceptableOrUnknown(data['tuan_zhu']!, _tuanZhuMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ZhouYiGuaZhu map(Map<String, dynamic> data, {String? tablePrefix}) {
    return ZhouYiGuaZhu.fromData(data, attachedDatabase,
        prefix: tablePrefix != null ? '$tablePrefix.' : null);
  }

  @override
  $ZhouYiGuaZhuTableTable createAlias(String alias) {
    return $ZhouYiGuaZhuTableTable(attachedDatabase, alias);
  }
}

class ZhouYiYaoZhu extends DataClass implements Insertable<ZhouYiYaoZhu> {
  final int id;
  final String guaBinary;
  final int yaoId;
  final int bookId;
  final String? yaoZhu;
  ZhouYiYaoZhu(
      {required this.id,
      required this.guaBinary,
      required this.yaoId,
      required this.bookId,
      this.yaoZhu});
  factory ZhouYiYaoZhu.fromData(Map<String, dynamic> data, GeneratedDatabase db,
      {String? prefix}) {
    final effectivePrefix = prefix ?? '';
    return ZhouYiYaoZhu(
      id: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}id'])!,
      guaBinary: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}gua_binary'])!,
      yaoId: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}yao_id'])!,
      bookId: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}book_id'])!,
      yaoZhu: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}yao_zhu']),
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['gua_binary'] = Variable<String>(guaBinary);
    map['yao_id'] = Variable<int>(yaoId);
    map['book_id'] = Variable<int>(bookId);
    if (!nullToAbsent || yaoZhu != null) {
      map['yao_zhu'] = Variable<String?>(yaoZhu);
    }
    return map;
  }

  ZhouYiYaoZhuTableCompanion toCompanion(bool nullToAbsent) {
    return ZhouYiYaoZhuTableCompanion(
      id: Value(id),
      guaBinary: Value(guaBinary),
      yaoId: Value(yaoId),
      bookId: Value(bookId),
      yaoZhu:
          yaoZhu == null && nullToAbsent ? const Value.absent() : Value(yaoZhu),
    );
  }

  factory ZhouYiYaoZhu.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return ZhouYiYaoZhu(
      id: serializer.fromJson<int>(json['id']),
      guaBinary: serializer.fromJson<String>(json['guaBinary']),
      yaoId: serializer.fromJson<int>(json['yaoId']),
      bookId: serializer.fromJson<int>(json['bookId']),
      yaoZhu: serializer.fromJson<String?>(json['yaoZhu']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'guaBinary': serializer.toJson<String>(guaBinary),
      'yaoId': serializer.toJson<int>(yaoId),
      'bookId': serializer.toJson<int>(bookId),
      'yaoZhu': serializer.toJson<String?>(yaoZhu),
    };
  }

  ZhouYiYaoZhu copyWith(
          {int? id,
          String? guaBinary,
          int? yaoId,
          int? bookId,
          String? yaoZhu}) =>
      ZhouYiYaoZhu(
        id: id ?? this.id,
        guaBinary: guaBinary ?? this.guaBinary,
        yaoId: yaoId ?? this.yaoId,
        bookId: bookId ?? this.bookId,
        yaoZhu: yaoZhu ?? this.yaoZhu,
      );
  @override
  String toString() {
    return (StringBuffer('ZhouYiYaoZhu(')
          ..write('id: $id, ')
          ..write('guaBinary: $guaBinary, ')
          ..write('yaoId: $yaoId, ')
          ..write('bookId: $bookId, ')
          ..write('yaoZhu: $yaoZhu')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, guaBinary, yaoId, bookId, yaoZhu);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ZhouYiYaoZhu &&
          other.id == this.id &&
          other.guaBinary == this.guaBinary &&
          other.yaoId == this.yaoId &&
          other.bookId == this.bookId &&
          other.yaoZhu == this.yaoZhu);
}

class ZhouYiYaoZhuTableCompanion extends UpdateCompanion<ZhouYiYaoZhu> {
  final Value<int> id;
  final Value<String> guaBinary;
  final Value<int> yaoId;
  final Value<int> bookId;
  final Value<String?> yaoZhu;
  const ZhouYiYaoZhuTableCompanion({
    this.id = const Value.absent(),
    this.guaBinary = const Value.absent(),
    this.yaoId = const Value.absent(),
    this.bookId = const Value.absent(),
    this.yaoZhu = const Value.absent(),
  });
  ZhouYiYaoZhuTableCompanion.insert({
    this.id = const Value.absent(),
    required String guaBinary,
    required int yaoId,
    required int bookId,
    this.yaoZhu = const Value.absent(),
  })  : guaBinary = Value(guaBinary),
        yaoId = Value(yaoId),
        bookId = Value(bookId);
  static Insertable<ZhouYiYaoZhu> custom({
    Expression<int>? id,
    Expression<String>? guaBinary,
    Expression<int>? yaoId,
    Expression<int>? bookId,
    Expression<String?>? yaoZhu,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (guaBinary != null) 'gua_binary': guaBinary,
      if (yaoId != null) 'yao_id': yaoId,
      if (bookId != null) 'book_id': bookId,
      if (yaoZhu != null) 'yao_zhu': yaoZhu,
    });
  }

  ZhouYiYaoZhuTableCompanion copyWith(
      {Value<int>? id,
      Value<String>? guaBinary,
      Value<int>? yaoId,
      Value<int>? bookId,
      Value<String?>? yaoZhu}) {
    return ZhouYiYaoZhuTableCompanion(
      id: id ?? this.id,
      guaBinary: guaBinary ?? this.guaBinary,
      yaoId: yaoId ?? this.yaoId,
      bookId: bookId ?? this.bookId,
      yaoZhu: yaoZhu ?? this.yaoZhu,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (guaBinary.present) {
      map['gua_binary'] = Variable<String>(guaBinary.value);
    }
    if (yaoId.present) {
      map['yao_id'] = Variable<int>(yaoId.value);
    }
    if (bookId.present) {
      map['book_id'] = Variable<int>(bookId.value);
    }
    if (yaoZhu.present) {
      map['yao_zhu'] = Variable<String?>(yaoZhu.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ZhouYiYaoZhuTableCompanion(')
          ..write('id: $id, ')
          ..write('guaBinary: $guaBinary, ')
          ..write('yaoId: $yaoId, ')
          ..write('bookId: $bookId, ')
          ..write('yaoZhu: $yaoZhu')
          ..write(')'))
        .toString();
  }
}

class $ZhouYiYaoZhuTableTable extends ZhouYiYaoZhuTable
    with TableInfo<$ZhouYiYaoZhuTableTable, ZhouYiYaoZhu> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ZhouYiYaoZhuTableTable(this.attachedDatabase, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int?> id = GeneratedColumn<int?>(
      'id', aliasedName, false,
      type: const IntType(),
      requiredDuringInsert: false,
      defaultConstraints: 'PRIMARY KEY AUTOINCREMENT');
  final VerificationMeta _guaBinaryMeta = const VerificationMeta('guaBinary');
  @override
  late final GeneratedColumn<String?> guaBinary = GeneratedColumn<String?>(
      'gua_binary', aliasedName, false,
      type: const StringType(), requiredDuringInsert: true);
  final VerificationMeta _yaoIdMeta = const VerificationMeta('yaoId');
  @override
  late final GeneratedColumn<int?> yaoId = GeneratedColumn<int?>(
      'yao_id', aliasedName, false,
      type: const IntType(), requiredDuringInsert: true);
  final VerificationMeta _bookIdMeta = const VerificationMeta('bookId');
  @override
  late final GeneratedColumn<int?> bookId = GeneratedColumn<int?>(
      'book_id', aliasedName, false,
      type: const IntType(), requiredDuringInsert: true);
  final VerificationMeta _yaoZhuMeta = const VerificationMeta('yaoZhu');
  @override
  late final GeneratedColumn<String?> yaoZhu = GeneratedColumn<String?>(
      'yao_zhu', aliasedName, true,
      type: const StringType(), requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns => [id, guaBinary, yaoId, bookId, yaoZhu];
  @override
  String get aliasedName => _alias ?? 't_zy_yao_zhu';
  @override
  String get actualTableName => 't_zy_yao_zhu';
  @override
  VerificationContext validateIntegrity(Insertable<ZhouYiYaoZhu> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('gua_binary')) {
      context.handle(_guaBinaryMeta,
          guaBinary.isAcceptableOrUnknown(data['gua_binary']!, _guaBinaryMeta));
    } else if (isInserting) {
      context.missing(_guaBinaryMeta);
    }
    if (data.containsKey('yao_id')) {
      context.handle(
          _yaoIdMeta, yaoId.isAcceptableOrUnknown(data['yao_id']!, _yaoIdMeta));
    } else if (isInserting) {
      context.missing(_yaoIdMeta);
    }
    if (data.containsKey('book_id')) {
      context.handle(_bookIdMeta,
          bookId.isAcceptableOrUnknown(data['book_id']!, _bookIdMeta));
    } else if (isInserting) {
      context.missing(_bookIdMeta);
    }
    if (data.containsKey('yao_zhu')) {
      context.handle(_yaoZhuMeta,
          yaoZhu.isAcceptableOrUnknown(data['yao_zhu']!, _yaoZhuMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ZhouYiYaoZhu map(Map<String, dynamic> data, {String? tablePrefix}) {
    return ZhouYiYaoZhu.fromData(data, attachedDatabase,
        prefix: tablePrefix != null ? '$tablePrefix.' : null);
  }

  @override
  $ZhouYiYaoZhuTableTable createAlias(String alias) {
    return $ZhouYiYaoZhuTableTable(attachedDatabase, alias);
  }
}

class ZhouYiGuaYao extends DataClass implements Insertable<ZhouYiGuaYao> {
  final int id;
  final String guaBinary;
  final int seqInGua;
  final String yaoName;
  final String guaYaoName;
  final String xiang;
  final String yao;
  ZhouYiGuaYao(
      {required this.id,
      required this.guaBinary,
      required this.seqInGua,
      required this.yaoName,
      required this.guaYaoName,
      required this.xiang,
      required this.yao});
  factory ZhouYiGuaYao.fromData(Map<String, dynamic> data, GeneratedDatabase db,
      {String? prefix}) {
    final effectivePrefix = prefix ?? '';
    return ZhouYiGuaYao(
      id: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}id'])!,
      guaBinary: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}gua_binary'])!,
      seqInGua: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}seq_in_gua'])!,
      yaoName: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}yao_name'])!,
      guaYaoName: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}gua_yao_name'])!,
      xiang: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}xiang'])!,
      yao: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}yao'])!,
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['gua_binary'] = Variable<String>(guaBinary);
    map['seq_in_gua'] = Variable<int>(seqInGua);
    map['yao_name'] = Variable<String>(yaoName);
    map['gua_yao_name'] = Variable<String>(guaYaoName);
    map['xiang'] = Variable<String>(xiang);
    map['yao'] = Variable<String>(yao);
    return map;
  }

  ZhouYiGuaYaoTableCompanion toCompanion(bool nullToAbsent) {
    return ZhouYiGuaYaoTableCompanion(
      id: Value(id),
      guaBinary: Value(guaBinary),
      seqInGua: Value(seqInGua),
      yaoName: Value(yaoName),
      guaYaoName: Value(guaYaoName),
      xiang: Value(xiang),
      yao: Value(yao),
    );
  }

  factory ZhouYiGuaYao.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return ZhouYiGuaYao(
      id: serializer.fromJson<int>(json['id']),
      guaBinary: serializer.fromJson<String>(json['guaBinary']),
      seqInGua: serializer.fromJson<int>(json['seqInGua']),
      yaoName: serializer.fromJson<String>(json['yaoName']),
      guaYaoName: serializer.fromJson<String>(json['guaYaoName']),
      xiang: serializer.fromJson<String>(json['xiang']),
      yao: serializer.fromJson<String>(json['yao']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'guaBinary': serializer.toJson<String>(guaBinary),
      'seqInGua': serializer.toJson<int>(seqInGua),
      'yaoName': serializer.toJson<String>(yaoName),
      'guaYaoName': serializer.toJson<String>(guaYaoName),
      'xiang': serializer.toJson<String>(xiang),
      'yao': serializer.toJson<String>(yao),
    };
  }

  ZhouYiGuaYao copyWith(
          {int? id,
          String? guaBinary,
          int? seqInGua,
          String? yaoName,
          String? guaYaoName,
          String? xiang,
          String? yao}) =>
      ZhouYiGuaYao(
        id: id ?? this.id,
        guaBinary: guaBinary ?? this.guaBinary,
        seqInGua: seqInGua ?? this.seqInGua,
        yaoName: yaoName ?? this.yaoName,
        guaYaoName: guaYaoName ?? this.guaYaoName,
        xiang: xiang ?? this.xiang,
        yao: yao ?? this.yao,
      );
  @override
  String toString() {
    return (StringBuffer('ZhouYiGuaYao(')
          ..write('id: $id, ')
          ..write('guaBinary: $guaBinary, ')
          ..write('seqInGua: $seqInGua, ')
          ..write('yaoName: $yaoName, ')
          ..write('guaYaoName: $guaYaoName, ')
          ..write('xiang: $xiang, ')
          ..write('yao: $yao')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, guaBinary, seqInGua, yaoName, guaYaoName, xiang, yao);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ZhouYiGuaYao &&
          other.id == this.id &&
          other.guaBinary == this.guaBinary &&
          other.seqInGua == this.seqInGua &&
          other.yaoName == this.yaoName &&
          other.guaYaoName == this.guaYaoName &&
          other.xiang == this.xiang &&
          other.yao == this.yao);
}

class ZhouYiGuaYaoTableCompanion extends UpdateCompanion<ZhouYiGuaYao> {
  final Value<int> id;
  final Value<String> guaBinary;
  final Value<int> seqInGua;
  final Value<String> yaoName;
  final Value<String> guaYaoName;
  final Value<String> xiang;
  final Value<String> yao;
  const ZhouYiGuaYaoTableCompanion({
    this.id = const Value.absent(),
    this.guaBinary = const Value.absent(),
    this.seqInGua = const Value.absent(),
    this.yaoName = const Value.absent(),
    this.guaYaoName = const Value.absent(),
    this.xiang = const Value.absent(),
    this.yao = const Value.absent(),
  });
  ZhouYiGuaYaoTableCompanion.insert({
    this.id = const Value.absent(),
    required String guaBinary,
    required int seqInGua,
    required String yaoName,
    required String guaYaoName,
    required String xiang,
    required String yao,
  })  : guaBinary = Value(guaBinary),
        seqInGua = Value(seqInGua),
        yaoName = Value(yaoName),
        guaYaoName = Value(guaYaoName),
        xiang = Value(xiang),
        yao = Value(yao);
  static Insertable<ZhouYiGuaYao> custom({
    Expression<int>? id,
    Expression<String>? guaBinary,
    Expression<int>? seqInGua,
    Expression<String>? yaoName,
    Expression<String>? guaYaoName,
    Expression<String>? xiang,
    Expression<String>? yao,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (guaBinary != null) 'gua_binary': guaBinary,
      if (seqInGua != null) 'seq_in_gua': seqInGua,
      if (yaoName != null) 'yao_name': yaoName,
      if (guaYaoName != null) 'gua_yao_name': guaYaoName,
      if (xiang != null) 'xiang': xiang,
      if (yao != null) 'yao': yao,
    });
  }

  ZhouYiGuaYaoTableCompanion copyWith(
      {Value<int>? id,
      Value<String>? guaBinary,
      Value<int>? seqInGua,
      Value<String>? yaoName,
      Value<String>? guaYaoName,
      Value<String>? xiang,
      Value<String>? yao}) {
    return ZhouYiGuaYaoTableCompanion(
      id: id ?? this.id,
      guaBinary: guaBinary ?? this.guaBinary,
      seqInGua: seqInGua ?? this.seqInGua,
      yaoName: yaoName ?? this.yaoName,
      guaYaoName: guaYaoName ?? this.guaYaoName,
      xiang: xiang ?? this.xiang,
      yao: yao ?? this.yao,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (guaBinary.present) {
      map['gua_binary'] = Variable<String>(guaBinary.value);
    }
    if (seqInGua.present) {
      map['seq_in_gua'] = Variable<int>(seqInGua.value);
    }
    if (yaoName.present) {
      map['yao_name'] = Variable<String>(yaoName.value);
    }
    if (guaYaoName.present) {
      map['gua_yao_name'] = Variable<String>(guaYaoName.value);
    }
    if (xiang.present) {
      map['xiang'] = Variable<String>(xiang.value);
    }
    if (yao.present) {
      map['yao'] = Variable<String>(yao.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ZhouYiGuaYaoTableCompanion(')
          ..write('id: $id, ')
          ..write('guaBinary: $guaBinary, ')
          ..write('seqInGua: $seqInGua, ')
          ..write('yaoName: $yaoName, ')
          ..write('guaYaoName: $guaYaoName, ')
          ..write('xiang: $xiang, ')
          ..write('yao: $yao')
          ..write(')'))
        .toString();
  }
}

class $ZhouYiGuaYaoTableTable extends ZhouYiGuaYaoTable
    with TableInfo<$ZhouYiGuaYaoTableTable, ZhouYiGuaYao> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ZhouYiGuaYaoTableTable(this.attachedDatabase, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int?> id = GeneratedColumn<int?>(
      'id', aliasedName, false,
      type: const IntType(),
      requiredDuringInsert: false,
      defaultConstraints: 'PRIMARY KEY AUTOINCREMENT');
  final VerificationMeta _guaBinaryMeta = const VerificationMeta('guaBinary');
  @override
  late final GeneratedColumn<String?> guaBinary = GeneratedColumn<String?>(
      'gua_binary', aliasedName, false,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 6, maxTextLength: 6),
      type: const StringType(),
      requiredDuringInsert: true);
  final VerificationMeta _seqInGuaMeta = const VerificationMeta('seqInGua');
  @override
  late final GeneratedColumn<int?> seqInGua = GeneratedColumn<int?>(
      'seq_in_gua', aliasedName, false,
      type: const IntType(), requiredDuringInsert: true);
  final VerificationMeta _yaoNameMeta = const VerificationMeta('yaoName');
  @override
  late final GeneratedColumn<String?> yaoName = GeneratedColumn<String?>(
      'yao_name', aliasedName, false,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 2, maxTextLength: 2),
      type: const StringType(),
      requiredDuringInsert: true);
  final VerificationMeta _guaYaoNameMeta = const VerificationMeta('guaYaoName');
  @override
  late final GeneratedColumn<String?> guaYaoName = GeneratedColumn<String?>(
      'gua_yao_name', aliasedName, false,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 4, maxTextLength: 4),
      type: const StringType(),
      requiredDuringInsert: true);
  final VerificationMeta _xiangMeta = const VerificationMeta('xiang');
  @override
  late final GeneratedColumn<String?> xiang = GeneratedColumn<String?>(
      'xiang', aliasedName, false,
      type: const StringType(), requiredDuringInsert: true);
  final VerificationMeta _yaoMeta = const VerificationMeta('yao');
  @override
  late final GeneratedColumn<String?> yao = GeneratedColumn<String?>(
      'yao', aliasedName, false,
      type: const StringType(), requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns =>
      [id, guaBinary, seqInGua, yaoName, guaYaoName, xiang, yao];
  @override
  String get aliasedName => _alias ?? 't_zy_yao';
  @override
  String get actualTableName => 't_zy_yao';
  @override
  VerificationContext validateIntegrity(Insertable<ZhouYiGuaYao> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('gua_binary')) {
      context.handle(_guaBinaryMeta,
          guaBinary.isAcceptableOrUnknown(data['gua_binary']!, _guaBinaryMeta));
    } else if (isInserting) {
      context.missing(_guaBinaryMeta);
    }
    if (data.containsKey('seq_in_gua')) {
      context.handle(_seqInGuaMeta,
          seqInGua.isAcceptableOrUnknown(data['seq_in_gua']!, _seqInGuaMeta));
    } else if (isInserting) {
      context.missing(_seqInGuaMeta);
    }
    if (data.containsKey('yao_name')) {
      context.handle(_yaoNameMeta,
          yaoName.isAcceptableOrUnknown(data['yao_name']!, _yaoNameMeta));
    } else if (isInserting) {
      context.missing(_yaoNameMeta);
    }
    if (data.containsKey('gua_yao_name')) {
      context.handle(
          _guaYaoNameMeta,
          guaYaoName.isAcceptableOrUnknown(
              data['gua_yao_name']!, _guaYaoNameMeta));
    } else if (isInserting) {
      context.missing(_guaYaoNameMeta);
    }
    if (data.containsKey('xiang')) {
      context.handle(
          _xiangMeta, xiang.isAcceptableOrUnknown(data['xiang']!, _xiangMeta));
    } else if (isInserting) {
      context.missing(_xiangMeta);
    }
    if (data.containsKey('yao')) {
      context.handle(
          _yaoMeta, yao.isAcceptableOrUnknown(data['yao']!, _yaoMeta));
    } else if (isInserting) {
      context.missing(_yaoMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ZhouYiGuaYao map(Map<String, dynamic> data, {String? tablePrefix}) {
    return ZhouYiGuaYao.fromData(data, attachedDatabase,
        prefix: tablePrefix != null ? '$tablePrefix.' : null);
  }

  @override
  $ZhouYiGuaYaoTableTable createAlias(String alias) {
    return $ZhouYiGuaYaoTableTable(attachedDatabase, alias);
  }
}

class ZhouyiZhuBooks extends DataClass implements Insertable<ZhouyiZhuBooks> {
  final int id;
  final String bookname;
  final String bookauth;
  final String bookage;
  ZhouyiZhuBooks(
      {required this.id,
      required this.bookname,
      required this.bookauth,
      required this.bookage});
  factory ZhouyiZhuBooks.fromData(
      Map<String, dynamic> data, GeneratedDatabase db,
      {String? prefix}) {
    final effectivePrefix = prefix ?? '';
    return ZhouyiZhuBooks(
      id: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}id'])!,
      bookname: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}bookname'])!,
      bookauth: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}bookauth'])!,
      bookage: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}bookage'])!,
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['bookname'] = Variable<String>(bookname);
    map['bookauth'] = Variable<String>(bookauth);
    map['bookage'] = Variable<String>(bookage);
    return map;
  }

  ZhouyiZhuBooksTableCompanion toCompanion(bool nullToAbsent) {
    return ZhouyiZhuBooksTableCompanion(
      id: Value(id),
      bookname: Value(bookname),
      bookauth: Value(bookauth),
      bookage: Value(bookage),
    );
  }

  factory ZhouyiZhuBooks.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return ZhouyiZhuBooks(
      id: serializer.fromJson<int>(json['id']),
      bookname: serializer.fromJson<String>(json['bookname']),
      bookauth: serializer.fromJson<String>(json['bookauth']),
      bookage: serializer.fromJson<String>(json['bookage']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'bookname': serializer.toJson<String>(bookname),
      'bookauth': serializer.toJson<String>(bookauth),
      'bookage': serializer.toJson<String>(bookage),
    };
  }

  ZhouyiZhuBooks copyWith(
          {int? id, String? bookname, String? bookauth, String? bookage}) =>
      ZhouyiZhuBooks(
        id: id ?? this.id,
        bookname: bookname ?? this.bookname,
        bookauth: bookauth ?? this.bookauth,
        bookage: bookage ?? this.bookage,
      );
  @override
  String toString() {
    return (StringBuffer('ZhouyiZhuBooks(')
          ..write('id: $id, ')
          ..write('bookname: $bookname, ')
          ..write('bookauth: $bookauth, ')
          ..write('bookage: $bookage')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, bookname, bookauth, bookage);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ZhouyiZhuBooks &&
          other.id == this.id &&
          other.bookname == this.bookname &&
          other.bookauth == this.bookauth &&
          other.bookage == this.bookage);
}

class ZhouyiZhuBooksTableCompanion extends UpdateCompanion<ZhouyiZhuBooks> {
  final Value<int> id;
  final Value<String> bookname;
  final Value<String> bookauth;
  final Value<String> bookage;
  const ZhouyiZhuBooksTableCompanion({
    this.id = const Value.absent(),
    this.bookname = const Value.absent(),
    this.bookauth = const Value.absent(),
    this.bookage = const Value.absent(),
  });
  ZhouyiZhuBooksTableCompanion.insert({
    this.id = const Value.absent(),
    required String bookname,
    required String bookauth,
    required String bookage,
  })  : bookname = Value(bookname),
        bookauth = Value(bookauth),
        bookage = Value(bookage);
  static Insertable<ZhouyiZhuBooks> custom({
    Expression<int>? id,
    Expression<String>? bookname,
    Expression<String>? bookauth,
    Expression<String>? bookage,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (bookname != null) 'bookname': bookname,
      if (bookauth != null) 'bookauth': bookauth,
      if (bookage != null) 'bookage': bookage,
    });
  }

  ZhouyiZhuBooksTableCompanion copyWith(
      {Value<int>? id,
      Value<String>? bookname,
      Value<String>? bookauth,
      Value<String>? bookage}) {
    return ZhouyiZhuBooksTableCompanion(
      id: id ?? this.id,
      bookname: bookname ?? this.bookname,
      bookauth: bookauth ?? this.bookauth,
      bookage: bookage ?? this.bookage,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (bookname.present) {
      map['bookname'] = Variable<String>(bookname.value);
    }
    if (bookauth.present) {
      map['bookauth'] = Variable<String>(bookauth.value);
    }
    if (bookage.present) {
      map['bookage'] = Variable<String>(bookage.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ZhouyiZhuBooksTableCompanion(')
          ..write('id: $id, ')
          ..write('bookname: $bookname, ')
          ..write('bookauth: $bookauth, ')
          ..write('bookage: $bookage')
          ..write(')'))
        .toString();
  }
}

class $ZhouyiZhuBooksTableTable extends ZhouyiZhuBooksTable
    with TableInfo<$ZhouyiZhuBooksTableTable, ZhouyiZhuBooks> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ZhouyiZhuBooksTableTable(this.attachedDatabase, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int?> id = GeneratedColumn<int?>(
      'id', aliasedName, false,
      type: const IntType(),
      requiredDuringInsert: false,
      defaultConstraints: 'PRIMARY KEY AUTOINCREMENT');
  final VerificationMeta _booknameMeta = const VerificationMeta('bookname');
  @override
  late final GeneratedColumn<String?> bookname = GeneratedColumn<String?>(
      'bookname', aliasedName, false,
      additionalChecks: GeneratedColumn.checkTextLength(maxTextLength: 16),
      type: const StringType(),
      requiredDuringInsert: true);
  final VerificationMeta _bookauthMeta = const VerificationMeta('bookauth');
  @override
  late final GeneratedColumn<String?> bookauth = GeneratedColumn<String?>(
      'bookauth', aliasedName, false,
      additionalChecks: GeneratedColumn.checkTextLength(maxTextLength: 16),
      type: const StringType(),
      requiredDuringInsert: true);
  final VerificationMeta _bookageMeta = const VerificationMeta('bookage');
  @override
  late final GeneratedColumn<String?> bookage = GeneratedColumn<String?>(
      'bookage', aliasedName, false,
      additionalChecks: GeneratedColumn.checkTextLength(maxTextLength: 16),
      type: const StringType(),
      requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [id, bookname, bookauth, bookage];
  @override
  String get aliasedName => _alias ?? 't_zy_zhu_book';
  @override
  String get actualTableName => 't_zy_zhu_book';
  @override
  VerificationContext validateIntegrity(Insertable<ZhouyiZhuBooks> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('bookname')) {
      context.handle(_booknameMeta,
          bookname.isAcceptableOrUnknown(data['bookname']!, _booknameMeta));
    } else if (isInserting) {
      context.missing(_booknameMeta);
    }
    if (data.containsKey('bookauth')) {
      context.handle(_bookauthMeta,
          bookauth.isAcceptableOrUnknown(data['bookauth']!, _bookauthMeta));
    } else if (isInserting) {
      context.missing(_bookauthMeta);
    }
    if (data.containsKey('bookage')) {
      context.handle(_bookageMeta,
          bookage.isAcceptableOrUnknown(data['bookage']!, _bookageMeta));
    } else if (isInserting) {
      context.missing(_bookageMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ZhouyiZhuBooks map(Map<String, dynamic> data, {String? tablePrefix}) {
    return ZhouyiZhuBooks.fromData(data, attachedDatabase,
        prefix: tablePrefix != null ? '$tablePrefix.' : null);
  }

  @override
  $ZhouyiZhuBooksTableTable createAlias(String alias) {
    return $ZhouyiZhuBooksTableTable(attachedDatabase, alias);
  }
}

class JiaoShiYiLin extends DataClass implements Insertable<JiaoShiYiLin> {
  final int id;
  final String guaBinary;
  final int zhiSeq;
  final String zhiName;
  final String zhiBinary;
  final String zhiContent;
  JiaoShiYiLin(
      {required this.id,
      required this.guaBinary,
      required this.zhiSeq,
      required this.zhiName,
      required this.zhiBinary,
      required this.zhiContent});
  factory JiaoShiYiLin.fromData(Map<String, dynamic> data, GeneratedDatabase db,
      {String? prefix}) {
    final effectivePrefix = prefix ?? '';
    return JiaoShiYiLin(
      id: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}id'])!,
      guaBinary: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}gua_binary'])!,
      zhiSeq: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}zhi_seq'])!,
      zhiName: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}zhi_name'])!,
      zhiBinary: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}zhi_binary'])!,
      zhiContent: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}zhi_content'])!,
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['gua_binary'] = Variable<String>(guaBinary);
    map['zhi_seq'] = Variable<int>(zhiSeq);
    map['zhi_name'] = Variable<String>(zhiName);
    map['zhi_binary'] = Variable<String>(zhiBinary);
    map['zhi_content'] = Variable<String>(zhiContent);
    return map;
  }

  JiaoShiYiLinTableCompanion toCompanion(bool nullToAbsent) {
    return JiaoShiYiLinTableCompanion(
      id: Value(id),
      guaBinary: Value(guaBinary),
      zhiSeq: Value(zhiSeq),
      zhiName: Value(zhiName),
      zhiBinary: Value(zhiBinary),
      zhiContent: Value(zhiContent),
    );
  }

  factory JiaoShiYiLin.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return JiaoShiYiLin(
      id: serializer.fromJson<int>(json['id']),
      guaBinary: serializer.fromJson<String>(json['guaBinary']),
      zhiSeq: serializer.fromJson<int>(json['zhiSeq']),
      zhiName: serializer.fromJson<String>(json['zhiName']),
      zhiBinary: serializer.fromJson<String>(json['zhiBinary']),
      zhiContent: serializer.fromJson<String>(json['zhiContent']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'guaBinary': serializer.toJson<String>(guaBinary),
      'zhiSeq': serializer.toJson<int>(zhiSeq),
      'zhiName': serializer.toJson<String>(zhiName),
      'zhiBinary': serializer.toJson<String>(zhiBinary),
      'zhiContent': serializer.toJson<String>(zhiContent),
    };
  }

  JiaoShiYiLin copyWith(
          {int? id,
          String? guaBinary,
          int? zhiSeq,
          String? zhiName,
          String? zhiBinary,
          String? zhiContent}) =>
      JiaoShiYiLin(
        id: id ?? this.id,
        guaBinary: guaBinary ?? this.guaBinary,
        zhiSeq: zhiSeq ?? this.zhiSeq,
        zhiName: zhiName ?? this.zhiName,
        zhiBinary: zhiBinary ?? this.zhiBinary,
        zhiContent: zhiContent ?? this.zhiContent,
      );
  @override
  String toString() {
    return (StringBuffer('JiaoShiYiLin(')
          ..write('id: $id, ')
          ..write('guaBinary: $guaBinary, ')
          ..write('zhiSeq: $zhiSeq, ')
          ..write('zhiName: $zhiName, ')
          ..write('zhiBinary: $zhiBinary, ')
          ..write('zhiContent: $zhiContent')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, guaBinary, zhiSeq, zhiName, zhiBinary, zhiContent);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is JiaoShiYiLin &&
          other.id == this.id &&
          other.guaBinary == this.guaBinary &&
          other.zhiSeq == this.zhiSeq &&
          other.zhiName == this.zhiName &&
          other.zhiBinary == this.zhiBinary &&
          other.zhiContent == this.zhiContent);
}

class JiaoShiYiLinTableCompanion extends UpdateCompanion<JiaoShiYiLin> {
  final Value<int> id;
  final Value<String> guaBinary;
  final Value<int> zhiSeq;
  final Value<String> zhiName;
  final Value<String> zhiBinary;
  final Value<String> zhiContent;
  const JiaoShiYiLinTableCompanion({
    this.id = const Value.absent(),
    this.guaBinary = const Value.absent(),
    this.zhiSeq = const Value.absent(),
    this.zhiName = const Value.absent(),
    this.zhiBinary = const Value.absent(),
    this.zhiContent = const Value.absent(),
  });
  JiaoShiYiLinTableCompanion.insert({
    this.id = const Value.absent(),
    required String guaBinary,
    required int zhiSeq,
    required String zhiName,
    required String zhiBinary,
    required String zhiContent,
  })  : guaBinary = Value(guaBinary),
        zhiSeq = Value(zhiSeq),
        zhiName = Value(zhiName),
        zhiBinary = Value(zhiBinary),
        zhiContent = Value(zhiContent);
  static Insertable<JiaoShiYiLin> custom({
    Expression<int>? id,
    Expression<String>? guaBinary,
    Expression<int>? zhiSeq,
    Expression<String>? zhiName,
    Expression<String>? zhiBinary,
    Expression<String>? zhiContent,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (guaBinary != null) 'gua_binary': guaBinary,
      if (zhiSeq != null) 'zhi_seq': zhiSeq,
      if (zhiName != null) 'zhi_name': zhiName,
      if (zhiBinary != null) 'zhi_binary': zhiBinary,
      if (zhiContent != null) 'zhi_content': zhiContent,
    });
  }

  JiaoShiYiLinTableCompanion copyWith(
      {Value<int>? id,
      Value<String>? guaBinary,
      Value<int>? zhiSeq,
      Value<String>? zhiName,
      Value<String>? zhiBinary,
      Value<String>? zhiContent}) {
    return JiaoShiYiLinTableCompanion(
      id: id ?? this.id,
      guaBinary: guaBinary ?? this.guaBinary,
      zhiSeq: zhiSeq ?? this.zhiSeq,
      zhiName: zhiName ?? this.zhiName,
      zhiBinary: zhiBinary ?? this.zhiBinary,
      zhiContent: zhiContent ?? this.zhiContent,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (guaBinary.present) {
      map['gua_binary'] = Variable<String>(guaBinary.value);
    }
    if (zhiSeq.present) {
      map['zhi_seq'] = Variable<int>(zhiSeq.value);
    }
    if (zhiName.present) {
      map['zhi_name'] = Variable<String>(zhiName.value);
    }
    if (zhiBinary.present) {
      map['zhi_binary'] = Variable<String>(zhiBinary.value);
    }
    if (zhiContent.present) {
      map['zhi_content'] = Variable<String>(zhiContent.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('JiaoShiYiLinTableCompanion(')
          ..write('id: $id, ')
          ..write('guaBinary: $guaBinary, ')
          ..write('zhiSeq: $zhiSeq, ')
          ..write('zhiName: $zhiName, ')
          ..write('zhiBinary: $zhiBinary, ')
          ..write('zhiContent: $zhiContent')
          ..write(')'))
        .toString();
  }
}

class $JiaoShiYiLinTableTable extends JiaoShiYiLinTable
    with TableInfo<$JiaoShiYiLinTableTable, JiaoShiYiLin> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $JiaoShiYiLinTableTable(this.attachedDatabase, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int?> id = GeneratedColumn<int?>(
      'id', aliasedName, false,
      type: const IntType(),
      requiredDuringInsert: false,
      defaultConstraints: 'PRIMARY KEY AUTOINCREMENT');
  final VerificationMeta _guaBinaryMeta = const VerificationMeta('guaBinary');
  @override
  late final GeneratedColumn<String?> guaBinary = GeneratedColumn<String?>(
      'gua_binary', aliasedName, false,
      type: const StringType(), requiredDuringInsert: true);
  final VerificationMeta _zhiSeqMeta = const VerificationMeta('zhiSeq');
  @override
  late final GeneratedColumn<int?> zhiSeq = GeneratedColumn<int?>(
      'zhi_seq', aliasedName, false,
      type: const IntType(), requiredDuringInsert: true);
  final VerificationMeta _zhiNameMeta = const VerificationMeta('zhiName');
  @override
  late final GeneratedColumn<String?> zhiName = GeneratedColumn<String?>(
      'zhi_name', aliasedName, false,
      type: const StringType(), requiredDuringInsert: true);
  final VerificationMeta _zhiBinaryMeta = const VerificationMeta('zhiBinary');
  @override
  late final GeneratedColumn<String?> zhiBinary = GeneratedColumn<String?>(
      'zhi_binary', aliasedName, false,
      type: const StringType(), requiredDuringInsert: true);
  final VerificationMeta _zhiContentMeta = const VerificationMeta('zhiContent');
  @override
  late final GeneratedColumn<String?> zhiContent = GeneratedColumn<String?>(
      'zhi_content', aliasedName, false,
      type: const StringType(), requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns =>
      [id, guaBinary, zhiSeq, zhiName, zhiBinary, zhiContent];
  @override
  String get aliasedName => _alias ?? 't_zy_jiao_lin';
  @override
  String get actualTableName => 't_zy_jiao_lin';
  @override
  VerificationContext validateIntegrity(Insertable<JiaoShiYiLin> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('gua_binary')) {
      context.handle(_guaBinaryMeta,
          guaBinary.isAcceptableOrUnknown(data['gua_binary']!, _guaBinaryMeta));
    } else if (isInserting) {
      context.missing(_guaBinaryMeta);
    }
    if (data.containsKey('zhi_seq')) {
      context.handle(_zhiSeqMeta,
          zhiSeq.isAcceptableOrUnknown(data['zhi_seq']!, _zhiSeqMeta));
    } else if (isInserting) {
      context.missing(_zhiSeqMeta);
    }
    if (data.containsKey('zhi_name')) {
      context.handle(_zhiNameMeta,
          zhiName.isAcceptableOrUnknown(data['zhi_name']!, _zhiNameMeta));
    } else if (isInserting) {
      context.missing(_zhiNameMeta);
    }
    if (data.containsKey('zhi_binary')) {
      context.handle(_zhiBinaryMeta,
          zhiBinary.isAcceptableOrUnknown(data['zhi_binary']!, _zhiBinaryMeta));
    } else if (isInserting) {
      context.missing(_zhiBinaryMeta);
    }
    if (data.containsKey('zhi_content')) {
      context.handle(
          _zhiContentMeta,
          zhiContent.isAcceptableOrUnknown(
              data['zhi_content']!, _zhiContentMeta));
    } else if (isInserting) {
      context.missing(_zhiContentMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  JiaoShiYiLin map(Map<String, dynamic> data, {String? tablePrefix}) {
    return JiaoShiYiLin.fromData(data, attachedDatabase,
        prefix: tablePrefix != null ? '$tablePrefix.' : null);
  }

  @override
  $JiaoShiYiLinTableTable createAlias(String alias) {
    return $JiaoShiYiLinTableTable(attachedDatabase, alias);
  }
}

abstract class _$MyDatabase extends GeneratedDatabase {
  _$MyDatabase(QueryExecutor e) : super(SqlTypeSystem.defaultInstance, e);
  late final $ZhouYiTableTable zhouYiTable = $ZhouYiTableTable(this);
  late final $ZhouYiGuaZhuTableTable zhouYiGuaZhuTable =
      $ZhouYiGuaZhuTableTable(this);
  late final $ZhouYiYaoZhuTableTable zhouYiYaoZhuTable =
      $ZhouYiYaoZhuTableTable(this);
  late final $ZhouYiGuaYaoTableTable zhouYiGuaYaoTable =
      $ZhouYiGuaYaoTableTable(this);
  late final $ZhouyiZhuBooksTableTable zhouyiZhuBooksTable =
      $ZhouyiZhuBooksTableTable(this);
  late final $JiaoShiYiLinTableTable jiaoShiYiLinTable =
      $JiaoShiYiLinTableTable(this);
  @override
  Iterable<TableInfo> get allTables => allSchemaEntities.whereType<TableInfo>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
        zhouYiTable,
        zhouYiGuaZhuTable,
        zhouYiYaoZhuTable,
        zhouYiGuaYaoTable,
        zhouyiZhuBooksTable,
        jiaoShiYiLinTable
      ];
}
