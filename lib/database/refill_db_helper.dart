import 'package:motolog/database/database_helper.dart';
import 'package:motolog/models/database_model.dart';
import 'package:motolog/models/refill.dart';

extension RefillDBHelper on DatabaseHelper {
  static const tableName = 'refill';
  static const tableSchema = """
              CREATE TABLE $tableName(
                id INTEGER PRIMARY KEY AUTOINCREMENT,
                station TEXT,
                datetime INTEGER,
                quantity REAL,
                paid REAL,
                distance REAL
              )
            """;
  static List<DatabaseModel> sampleData = [
    Refill(station: 'Circle K', datetime: DateTime(2023, 08, 28, 10, 32), quantity: 19.67, paid: 84.58, distance: 128000),
    Refill(station: 'Shell', datetime: DateTime(2023, 08, 28, 18, 47), quantity: 21.82, paid: 294.57, distance: 130000),
    Refill(station: 'YX', datetime: DateTime(2023, 09, 03, 16, 47), quantity: 23.99, paid: 151.86, distance: 131000),
    Refill(station: 'Uno X', datetime: DateTime(2023, 09, 05, 12, 43), quantity: 21.07, paid: 156.76, distance: 132000),
  ];

  Future<int> insertRefill(Refill instance) async {
    int result = await db.insert(tableName, instance.toMap());
    return result;
  }

  Future<int> updateRefill(Refill instance) async {
    int result = await db.update(
      tableName,
      instance.toMap(),
      where: 'id = ?',
      whereArgs: [instance.id],
    );
    return result;
  }

  Future<List<Refill>> retrieveRefills() async {
    final List<Map<String, Object?>> queryResult = await db.query(tableName);
    return queryResult.map((e) => Refill.fromMap(e)).toList();
  }

  Future<void> deleteRefill(int id) async {
    await db.delete(
      tableName,
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}
