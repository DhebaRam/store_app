import 'dart:io';
import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

import 'download_audio_table.dart';
part 'app_database.g.dart';

@DriftDatabase(tables: [AudioTable])
class MyDatabase extends _$MyDatabase {

  static const int schemaVersionCode = 1;
  static final MyDatabase _singleton = MyDatabase._internal();

  factory MyDatabase() {
    return _singleton;
  }

  MyDatabase._internal() : super(_openConnection());


  @override
  int get schemaVersion => schemaVersionCode;


  @override
  MigrationStrategy get migration {
    return MigrationStrategy(
      onCreate: (Migrator m) async {
        await m.createAll();
      },
      onUpgrade: (Migrator m, int from, int to) async {
        if (from < schemaVersionCode) {
          // we added the dueDate property in the change from version 1 to
          // version 2
          await m.deleteTable("download_video_table");
          await m.deleteTable("download_music_table");
          // await m.deleteTable("save_audio_data");
          await m.createAll();
        }
      },
    );
  }
  Future insertAudioData(AudioTableCompanion data) async => await into(audioTable).insert(data);
  Future<List<AudioTableData>> getAudioData() async => await select(audioTable).get();
  Future<AudioTableData?>? getAudioById(int productId) async{
    // return await (select(audioTable)
    //   ..where((entry) => entry.productId.equals(productId))).getSingleOrNull();
    final results = await (select(audioTable)
      ..where((entry) => entry.productId.equals(productId))).get();

    return results.isNotEmpty ? results.first : null;
  }
  Future deleteProduct(int productId) async{
    return await transaction(() async{
      return await (delete(audioTable)..where((t) => t.productId.equals(productId))).goAndReturn();
    });
  }
  Future updateAudioData(int productId, AudioTableCompanion data) async{
    return await (update(audioTable)
      ..where((entry) => entry.productId.equals(productId))).write(data);
  }

  Future<void> deleteEverything() {
    return transaction(() async {
      for (final table in allTables) {
        await delete(table).go();
      }
    });
  }
}

LazyDatabase _openConnection() {
  // the LazyDatabase util lets us find the right location for the file async.
  return LazyDatabase(() async {
    // put the database file, called db.sqlite here, into the documents folder
    // for your app.
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'shades_db_01.sqlite'));
    return NativeDatabase.createInBackground(file);
  });
}