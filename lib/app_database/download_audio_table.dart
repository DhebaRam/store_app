import 'package:drift/drift.dart';

class AudioTable extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get productQuantity => integer()();
  TextColumn get imagePath => text()();
  IntColumn get productId => integer()();
  TextColumn get modelJson => text()();
  // BoolColumn get value  => boolean()();
}