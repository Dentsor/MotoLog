import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:motolog/database/vehicle_db_helper.dart';
import 'package:motolog/database/database_helper.dart';
import 'package:motolog/database/refill_db_helper.dart';
import 'package:motolog/models/vehicle.dart';
import 'package:motolog/models/database_model.dart';
import 'package:motolog/models/fuel.dart';
import 'package:motolog/models/refill.dart';
import 'package:motolog/pages/add_refill.dart';
import 'package:motolog/widgets/consumption_widget.dart';
import 'package:motolog/widgets/refill_widget.dart';
import 'package:motolog/widgets/vehicle_card.dart';

class VehicleOverviewPage extends StatefulWidget {
  const VehicleOverviewPage({super.key, required this.title});

  final String title;

  @override
  State<VehicleOverviewPage> createState() => _VehicleOverviewPageState();
}

class _VehicleOverviewPageState extends State<VehicleOverviewPage> {
  late DatabaseHelper dbHelper = DatabaseHelper();

  // Fuel fuel = Fuel(0.3346, 0.3674, 8.6, "Litre", "Thursday", 22.07);

  void onPressed() {
    if (kDebugMode) {
      print("pressed");
    }
  }

  void onClicked() {
    if (kDebugMode) {
      print("clicked");
    }
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => AddRefillPage(title: widget.title)));
  }

  @override
  void initState() {
    super.initState();
    dbHelper = DatabaseHelper();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Future.wait([dbHelper.retrieveVehicles(), dbHelper.retrieveRefills()]),
      builder: (BuildContext context,
          AsyncSnapshot<List<List<DatabaseModel>>> snapshot) {
        if (snapshot.hasData) {
          List<Vehicle> vehicles = snapshot.data![0].cast();
          List<Refill> refills = snapshot.data![1].cast();
          Fuel fuel = Fuel.calculate(refills);
          return Scaffold(
            appBar: AppBar(
              backgroundColor: Theme.of(context).colorScheme.inversePrimary,
              title: Text(widget.title),
            ),
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  VehicleCard(vehicle: vehicles.first, latestRefill: refills.last),
                  ConsumptionWidget(fuelData: fuel),
                  RefillsWidget(refillData: refills),
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
