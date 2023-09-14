import 'package:motolog/database/database_helper.dart';
import 'package:motolog/models/vehicle.dart';

extension VehicleDBHelper on DatabaseHelper {
  static const tableName = 'vehicles';
  static const tableSchema = """
              CREATE TABLE $tableName(
                id INTEGER PRIMARY KEY AUTOINCREMENT,
                type TEXT,
                name TEXT,
                manufacturer TEXT,
                model TEXT,
                registration TEXT,
                year INTEGER
              )
            """;
  static List<Vehicle> sampleData = [
    Vehicle(type: 'motorcycle', name: 'Ragna', manufacturer: 'BMW', model: 'F650GS', registration: 'AB1234', year: 2018),
  ];

  Future<int> insertVehicle(Vehicle instance) async {
    int result = await db.insert(tableName, instance.toMap());
    return result;
  }

  Future<int> updateVehicle(Vehicle instance) async {
    int result = await db.update(
      tableName,
      instance.toMap(),
      where: 'id = ?',
      whereArgs: [instance.id],
    );
    return result;
  }

  Future<List<Vehicle>> retrieveVehicles() async {
    final List<Map<String, Object?>> queryResult = await db.query(tableName);
    return queryResult.map((e) => Vehicle.fromMap(e)).toList();
  }

  Future<void> deleteVehicle(int id) async {
    await db.delete(
      tableName,
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}
