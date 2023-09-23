import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:motolog/database/vehicle_db_helper.dart';
import 'package:motolog/database/database_helper.dart';
import 'package:motolog/database/refuel_db_helper.dart';
import 'package:motolog/models/vehicle.dart';
import 'package:motolog/pages/vehicle_overview_page.dart';

import 'package:flutter/widgets.dart';

void main() async {
  // Avoid errors caused by flutter upgrade.
  // Importing 'package:flutter/widgets.dart' is required.
  WidgetsFlutterBinding.ensureInitialized();
  var dbHelper = DatabaseHelper();
  await dbHelper.initDB(
    version: 1,
    tableSchemas: [
      VehicleDBHelper.tableSchema,
      RefuelDBHelper.tableSchema,
    ],
    sampleData: {
      VehicleDBHelper.tableName: VehicleDBHelper.sampleData,
      RefuelDBHelper.tableName: RefuelDBHelper.sampleData,
    },
  );

  if (kDebugMode) {
    print(await dbHelper.retrieveVehicles());
    print(await dbHelper.retrieveRefuels());
  }

  runApp(const MotoLog());
}

class MotoLog extends StatelessWidget {
  const MotoLog({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MotoLog',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.red),
        useMaterial3: true,
      ),
      home: FutureBuilder(
          future: DatabaseHelper().retrieveVehicles(),
          builder:
              (BuildContext context, AsyncSnapshot<List<Vehicle>> snapshot) {
            if (snapshot.hasData) {
              return VehicleOverviewPage(vehicle: snapshot.data!.first);
            }
            return const CircularProgressIndicator();
          }),
    );
  }
}
