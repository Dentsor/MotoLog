import 'package:motolog/database/database_helper.dart';
import 'package:motolog/models/database_model.dart';
import 'package:motolog/models/refill.dart';

extension RefillDBHelper on DatabaseHelper {
  static const tableName = 'refill';
  static const tableSchema = """
              CREATE TABLE $tableName(
                id INTEGER PRIMARY KEY,
                station TEXT,
                datetime TEXT,
                quantity REAL,
                paid REAL,
                currency TEXT,
                unit TEXT,
                mileage INTEGER
              )
            """;
  static List<DatabaseModel> sampleData = [
    Refill(station: 'Circle K', datetime: '2023-08-28 10:32', quantity: 19.67, paid: 84.58, currency: 'NOK', unit: 'Litre', mileage: 128000),
    Refill(station: 'Shell', datetime: '2023-08-28 18:47', quantity: 21.82, paid: 294.57, currency: 'NOK', unit: 'Litre', mileage: 130000),
    Refill(station: 'YX', datetime: '2023-09-03 16:47', quantity: 23.99, paid: 151.86, currency: 'NOK', unit: 'Litre', mileage: 131000),
    Refill(station: 'Uno X', datetime: '2023-09-05 12:43', quantity: 21.07, paid: 156.76, currency: 'NOK', unit: 'Litre', mileage: 132000),
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
