import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:motolog/database/vehicle_db_helper.dart';
import 'package:motolog/database/database_helper.dart';
import 'package:motolog/database/refuel_db_helper.dart';
import 'package:motolog/models/vehicle.dart';
import 'package:motolog/models/database_model.dart';
import 'package:motolog/utils/fuel.dart';
import 'package:motolog/models/refuel.dart';
import 'package:motolog/pages/refuel_add.dart';
import 'package:motolog/pages/refuel_history.dart';
import 'package:motolog/widgets/consumption_widget.dart';
import 'package:motolog/widgets/vehicle_card.dart';

class VehicleOverviewPage extends StatefulWidget {
  const VehicleOverviewPage({super.key, required this.title});

  final String title;

  @override
  State<VehicleOverviewPage> createState() => _VehicleOverviewPageState();
}

class _VehicleOverviewPageState extends State<VehicleOverviewPage> {
  DatabaseHelper dbHelper = DatabaseHelper();

  void onPressed() {
    if (kDebugMode) {
      print("pressed");
    }
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => RefuelHistoryPage(title: widget.title)));
  }

  void onClicked() {
    if (kDebugMode) {
      print("clicked");
    }
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => RefuelAddPage(title: widget.title)));
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Future.wait([dbHelper.retrieveVehicles(), dbHelper.retrieveRefuels()]),
      builder: (BuildContext context,
          AsyncSnapshot<List<List<DatabaseModel>>> snapshot) {
        if (snapshot.hasData) {
          List<Vehicle> vehicles = snapshot.data![0].cast();
          List<Refuel> refuels = snapshot.data![1].cast();
          Fuel fuel = Fuel.calculate(refuels);

          return Scaffold(
            appBar: AppBar(
              backgroundColor: Theme.of(context).colorScheme.inversePrimary,
              title: Text(widget.title),
            ),
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  VehicleCard(vehicle: vehicles.first, latestRefuel: refuels.last),
                  ConsumptionWidget(fuelData: fuel),
                  Row(children: [
                    TextButton.icon(
                      onPressed: onPressed,
                      icon: const Icon(Icons.list),
                      label: const Text("History"),
                    ),
                    TextButton.icon(
                      onPressed: onClicked,
                      icon: const Icon(Icons.add),
                      label: const Text("Add"),
                    ),
                  ]),
                ],
              ),
            ),
          );
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}
