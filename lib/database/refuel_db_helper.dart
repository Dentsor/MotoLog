import 'package:motolog/database/database_helper.dart';
import 'package:motolog/models/refuel.dart';

extension RefuelDBHelper on DatabaseHelper {
  static const tableName = 'refuel';
  static const tableSchema = """
              CREATE TABLE $tableName(
                id INTEGER PRIMARY KEY AUTOINCREMENT,
                vehicleId INTEGER NOT NULL,
                station TEXT NOT NULL,
                dateTime INTEGER NOT NULL,
                quantity REAL NOT NULL,
                paid REAL NOT NULL,
                distance REAL NOT NULL,
                filledToCapacity INTEGER NOT NULL,
                missingPreviousEntry INTEGER NOT NULL
              )
            """;
  static List<Refuel> sampleData = [
    Refuel(vehicleId: 0, station: 'Esso', dateTime: DateTime(2020, 06, 21, 11, 59), quantity: 2.79, paid: 35.68, distance: 60449, filledToCapacity: true, missingPreviousEntry: true),
    Refuel(vehicleId: 0, station: 'YX', dateTime: DateTime(2020, 06, 23, 11, 56), quantity: 6.67, paid: 101.32, distance: 60614, filledToCapacity: true, missingPreviousEntry: false),
    Refuel(vehicleId: 0, station: 'Esso', dateTime: DateTime(2020, 06, 23, 13, 45), quantity: 5.64, paid: 76.08, distance: 60734, filledToCapacity: true, missingPreviousEntry: false),
    Refuel(vehicleId: 0, station: 'YX', dateTime: DateTime(2020, 06, 23, 16, 28), quantity: 4.77, paid: 71.12, distance: 60860, filledToCapacity: true, missingPreviousEntry: false),
    Refuel(vehicleId: 0, station: 'Circle K', dateTime: DateTime(2020, 06, 23, 19, 51), quantity: 7.64, paid: 122.62, distance: 61037, filledToCapacity: true, missingPreviousEntry: false),
    Refuel(vehicleId: 0, station: 'YX', dateTime: DateTime(2020, 07, 20, 17, 50), quantity: 11.56, paid: 162.42, distance: 61270, filledToCapacity: true, missingPreviousEntry: false),
    Refuel(vehicleId: 0, station: 'Esso', dateTime: DateTime(2020, 07, 28, 16, 28), quantity: 10.87, paid: 172.72, distance: 61522, filledToCapacity: true, missingPreviousEntry: false),
    Refuel(vehicleId: 0, station: 'Esso', dateTime: DateTime(2020, 08, 01, 02, 06), quantity: 12.66, paid: 201.17, distance: 61801, filledToCapacity: true, missingPreviousEntry: false),
    Refuel(vehicleId: 0, station: 'Circle K', dateTime: DateTime(2017, 07, 18, 16, 45), quantity: 4.56, paid: 71.32, distance: 47463, filledToCapacity: true, missingPreviousEntry: true),
    Refuel(vehicleId: 0, station: 'Best', dateTime: DateTime(2017, 07, 19, 08, 38), quantity: 3, paid: 44.37, distance: 47703, filledToCapacity: false, missingPreviousEntry: false),
    Refuel(vehicleId: 0, station: 'Circle K', dateTime: DateTime(2017, 07, 19, 09, 13), quantity: 9.13, paid: 121.98, distance: 47737, filledToCapacity: true, missingPreviousEntry: false),
  ];

  Future<int> insertRefuel(Refuel instance) async {
    int result = await db.insert(tableName, instance.toMap());
    return result;
  }

  Future<int> updateRefuel(Refuel instance) async {
    int result = await db.update(
      tableName,
      instance.toMap(),
      where: 'id = ?',
      whereArgs: [instance.id],
    );
    return result;
  }

  Future<List<Refuel>> retrieveRefuels() async {
    final List<Map<String, Object?>> queryResult = await db.query(tableName);
    return queryResult.map((e) => Refuel.fromMap(e)).toList();
  }

  Future<void> deleteRefuel(int id) async {
    await db.delete(
      tableName,
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}
