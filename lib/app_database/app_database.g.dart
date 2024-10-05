// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint
class $AudioTableTable extends AudioTable
    with TableInfo<$AudioTableTable, AudioTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $AudioTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _productQuantity =
      const VerificationMeta('productQuantity');
  @override
  late final GeneratedColumn<int> productQuantity = GeneratedColumn<int>(
      'product_quantity', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _imagePathMeta =
  const VerificationMeta('imagePath');
  @override
  late final GeneratedColumn<String> imagePath = GeneratedColumn<String>(
      'image_path', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _productIdMeta =
      const VerificationMeta('productId');
  @override
  late final GeneratedColumn<int> productId = GeneratedColumn<int>(
      'product_id', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _modelJsonMeta =
      const VerificationMeta('modelJson');
  @override
  late final GeneratedColumn<String> modelJson = GeneratedColumn<String>(
      'model_json', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns =>
      [id, productQuantity, imagePath, productId, modelJson];
      // [id, audioPath, imagePath, productId, modelJson];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'audio_table';
  @override
  VerificationContext validateIntegrity(Insertable<AudioTableData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('product_quantity')) {
      context.handle(_productQuantity,
          productQuantity.isAcceptableOrUnknown(data['product_quantity']!, _productQuantity));
    } else if (isInserting) {
      context.missing(_productQuantity);
    }
    if (data.containsKey('image_path')) {
      context.handle(_imagePathMeta,
          imagePath.isAcceptableOrUnknown(data['image_path']!, _imagePathMeta));
    } else if (isInserting) {
      context.missing(_imagePathMeta);
    }
    if (data.containsKey('product_id')) {
      context.handle(_productIdMeta,
          productId.isAcceptableOrUnknown(data['product_id']!, _productIdMeta));
    } else if (isInserting) {
      context.missing(_productIdMeta);
    }
    if (data.containsKey('model_json')) {
      context.handle(_modelJsonMeta,
          modelJson.isAcceptableOrUnknown(data['model_json']!, _modelJsonMeta));
    } else if (isInserting) {
      context.missing(_modelJsonMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  AudioTableData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return AudioTableData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      productQuantity: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}product_quantity'])!,
      imagePath: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}image_path'])!,
      productId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}product_id'])!,
      modelJson: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}model_json'])!,
    );
  }

  @override
  $AudioTableTable createAlias(String alias) {
    return $AudioTableTable(attachedDatabase, alias);
  }
}

class AudioTableData extends DataClass implements Insertable<AudioTableData> {
  final int id;
  final int productQuantity;
  final String imagePath;
  final int productId;
  final String modelJson;
  const AudioTableData(
      {required this.id,
      required this.productQuantity,
      required this.imagePath,
      required this.productId,
      required this.modelJson});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['product_quantity'] = Variable<int>(productQuantity);
    map['image_path'] = Variable<String>(imagePath);
    map['product_id'] = Variable<int>(productId);
    map['model_json'] = Variable<String>(modelJson);
    return map;
  }

  AudioTableCompanion toCompanion(bool nullToAbsent) {
    return AudioTableCompanion(
      id: Value(id),
      productQuantity: Value(productQuantity),
      imagePath: Value(imagePath),
      productId: Value(productId),
      modelJson: Value(modelJson),
    );
  }

  factory AudioTableData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return AudioTableData(
      id: serializer.fromJson<int>(json['id']),
      productQuantity: serializer.fromJson<int>(json['productQuantity']),
      imagePath: serializer.fromJson<String>(json['imagePath']),
      productId: serializer.fromJson<int>(json['productId']),
      modelJson: serializer.fromJson<String>(json['modelJson']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'productQuantity': serializer.toJson<int>(productQuantity),
      'imagePath': serializer.toJson<String>(imagePath),
      'productId': serializer.toJson<int>(productId),
      'modelJson': serializer.toJson<String>(modelJson),
    };
  }

  AudioTableData copyWith(
          {int? id,
          int? productQuantity,
          String? imagePath,
          int? productId,
          String? modelJson}) =>
      AudioTableData(
        id: id ?? this.id,
        productQuantity: productQuantity ?? this.productQuantity,
        imagePath: imagePath ?? this.imagePath,
        productId: productId ?? this.productId,
        modelJson: modelJson ?? this.modelJson,
      );
  @override
  String toString() {
    return (StringBuffer('AudioTableData(')
          ..write('id: $id, ')
          ..write('productQuantity: $productQuantity, ')
          ..write('imagePath: $imagePath, ')
          ..write('productId: $productId, ')
          ..write('modelJson: $modelJson')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, productQuantity, imagePath, productId, modelJson);
      // Object.hash(id, audioPath, imagePath, productId, modelJson);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is AudioTableData &&
          other.id == this.id &&
          other.productQuantity == this.productQuantity &&
          other.imagePath == this.imagePath &&
          other.productId == this.productId &&
          other.modelJson == this.modelJson);
}

class AudioTableCompanion extends UpdateCompanion<AudioTableData> {
  final Value<int> id;
  final Value<int> productQuantity;
  final Value<String> imagePath;
  final Value<int> productId;
  final Value<String> modelJson;
  const AudioTableCompanion({
    this.id = const Value.absent(),
    this.productQuantity = const Value.absent(),
    this.imagePath = const Value.absent(),
    this.productId = const Value.absent(),
    this.modelJson = const Value.absent(),
  });
  AudioTableCompanion.insert({
    this.id = const Value.absent(),
    required int productQuantity,
    required String imagePath,
    required int productId,
    required String modelJson,
  })  : productQuantity = Value(productQuantity),
        imagePath = Value(imagePath),
        productId = Value(productId),
        modelJson = Value(modelJson);
  static Insertable<AudioTableData> custom({
    Expression<int>? id,
    Expression<int>? productQuantity,
    Expression<String>? imagePath,
    Expression<int>? productId,
    Expression<String>? modelJson,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (productQuantity != null) 'product_quantity': productQuantity,
      if (imagePath != null) 'image_path': imagePath,
      if (productId != null) 'product_id': productId,
      if (modelJson != null) 'model_json': modelJson,
    });
  }

  AudioTableCompanion copyWith(
      {Value<int>? id,
      Value<int>? productQuantity,
      Value<String>? imagePath,
      Value<int>? productId,
      Value<String>? modelJson}) {
    return AudioTableCompanion(
      id: id ?? this.id,
      productQuantity: productQuantity ?? this.productQuantity,
      imagePath: imagePath ?? this.imagePath,
      productId: productId ?? this.productId,
      modelJson: modelJson ?? this.modelJson,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (productQuantity.present) {
      map['product_quantity'] = Variable<int>(productQuantity.value);
    }
    if (imagePath.present) {
      map['image_path'] = Variable<String>(imagePath.value);
    }
    if (productId.present) {
      map['product_id'] = Variable<int>(productId.value);
    }
    if (modelJson.present) {
      map['model_json'] = Variable<String>(modelJson.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('AudioTableCompanion(')
          ..write('id: $id, ')
          ..write('productQuantity: $productQuantity, ')
          ..write('imagePath: $imagePath, ')
          ..write('productId: $productId, ')
          ..write('modelJson: $modelJson')
          ..write(')'))
        .toString();
  }
}

abstract class _$MyDatabase extends GeneratedDatabase {
  _$MyDatabase(QueryExecutor e) : super(e);
  late final $AudioTableTable audioTable = $AudioTableTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [audioTable];
}
