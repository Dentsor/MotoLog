import 'package:motolog/database/database_helper.dart';
import 'package:motolog/models/bike.dart';
import 'package:motolog/models/database_model.dart';

extension BikeDBHelper on DatabaseHelper {
  static const tableName = 'bikes';
  static const tableSchema = """
              CREATE TABLE $tableName(
                id INTEGER PRIMARY KEY,
                name TEXT,
                manufacturer TEXT,
                model TEXT,
                registration TEXT,
                year INTEGER,
                mileage INTEGER
              )
            """;
  static List<DatabaseModel> sampleData = [
    Bike(name: 'Ragna', manufacturer: 'BMW', model: 'F650GS', registration: 'AB1234', year: 2018, mileage: 259783),
  ];

  Future<int> insertBike(Bike instance) async {
    int result = await db.insert(tableName, instance.toMap());
    return result;
  }

  Future<int> updateBike(Bike instance) async {
    int result = await db.update(
      tableName,
      instance.toMap(),
      where: 'id = ?',
      whereArgs: [instance.id],
    );
    return result;
  }

  Future<List<Bike>> retrieveBikes() async {
    final List<Map<String, Object?>> queryResult = await db.query(tableName);
    return queryResult.map((e) => Bike.fromMap(e)).toList();
  }

  Future<void> deleteBike(int id) async {
    await db.delete(
      tableName,
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}
