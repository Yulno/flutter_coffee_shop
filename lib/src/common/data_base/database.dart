import 'dart:io';
import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;
import 'package:sqlite3/sqlite3.dart';
import 'package:sqlite3_flutter_libs/sqlite3_flutter_libs.dart';

part 'database.g.dart';

class Categories extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get slug => text()();
}

class Items extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text()();
<<<<<<< HEAD:lib/src/features/menu/data/data_base/database.dart
=======
  TextColumn get description => text()();
>>>>>>> feature/lab-4_map_screen:lib/src/common/data_base/database.dart
  TextColumn get icon => text()();
  TextColumn get description => text()();
  RealColumn get price => real()();
  IntColumn get categoryId => integer().references(Categories, #id)();
}

class Locations extends Table {
  TextColumn get address => text()();
  RealColumn get latitude => real()();
  RealColumn get longitude => real()();

  @override
  Set<Column> get primaryKey => {address};
}

@DriftDatabase(tables: [Categories, Items, Locations])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 1;
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'db.sqlite'));
    if (Platform.isAndroid) {
      await applyWorkaroundToOpenSqlite3OnOldAndroidVersions();
    }
    final cachebase = (await getTemporaryDirectory()).path;
    sqlite3.tempDirectory = cachebase;
    return NativeDatabase.createInBackground(file);
  });
}