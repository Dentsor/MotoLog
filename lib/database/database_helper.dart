import 'package:motolog/models/data_model.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static final DatabaseHelper _databaseHelper = DatabaseHelper._();

  DatabaseHelper._();

  late Database db;

  factory DatabaseHelper() {
    return _databaseHelper;
  }

  Future<void> initDB({required int version, required List<String> tableSchemas, required Map<String, List<DataModel>> sampleData}) async {
    String path = await getDatabasesPath();
    db = await openDatabase(
      join(path, 'motolog_database.db'),
      onCreate: (db, version) {
        for (String tableSchema in tableSchemas) {
          db.execute(tableSchema);
        }

        for(var tableSamples in sampleData.entries) {
          for(var model in tableSamples.value) {
            db.insert(tableSamples.key, model.toMap());
          }
        }
      },
      version: version,
    );
  }
}
