import 'package:flutter/material.dart';
import 'package:motolog/database/bike_db_helper.dart';
import 'package:motolog/database/database_helper.dart';
import 'package:motolog/database/refill_db_helper.dart';
import 'package:motolog/pages/vehicle_overview.dart';

import 'package:flutter/widgets.dart';

void main() async {
  // Avoid errors caused by flutter upgrade.
  // Importing 'package:flutter/widgets.dart' is required.
  WidgetsFlutterBinding.ensureInitialized();
  var dbHelper = DatabaseHelper();
  await dbHelper.initDB(
    version: 1,
    tableSchemas: [
      BikeDBHelper.tableSchema,
      RefillDBHelper.tableSchema,
    ],
    sampleData: {
      BikeDBHelper.tableName: BikeDBHelper.sampleData,
      RefillDBHelper.tableName: RefillDBHelper.sampleData,
    },
  );

  print(await dbHelper.retrieveBikes());

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
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const VehicleOverviewPage(title: 'Vehicle Overview'),
    );
  }
}
