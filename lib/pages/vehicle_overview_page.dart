import 'package:flutter/material.dart';
import 'package:motolog/database/database_helper.dart';
import 'package:motolog/database/refuel_db_helper.dart';
import 'package:motolog/models/vehicle.dart';
import 'package:motolog/models/refuel.dart';
import 'package:motolog/pages/refuel_add_page.dart';
import 'package:motolog/pages/refuel_history_page.dart';
import 'package:motolog/utils/refuel_utils.dart';
import 'package:motolog/widgets/consumption_widget.dart';
import 'package:motolog/widgets/vehicle_card.dart';

class VehicleOverviewPage extends StatefulWidget {
  const VehicleOverviewPage({super.key, required this.vehicle});

  final Vehicle vehicle;

  @override
  State<VehicleOverviewPage> createState() => _VehicleOverviewPageState();
}

class _VehicleOverviewPageState extends State<VehicleOverviewPage> {
  DatabaseHelper dbHelper = DatabaseHelper();
  late List<Refuel> refuels;

  void onPressed() {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => RefuelHistoryPage(vehicle: widget.vehicle)));
  }

  void onClicked() {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => RefuelAddPage(vehicle: widget.vehicle, refuels: refuels)));
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: dbHelper.retrieveRefuels(),
      builder: (BuildContext context, AsyncSnapshot<List<Refuel>> snapshot) {
        if (snapshot.hasData) {
          refuels = snapshot.data!;
          refuels.sortByDateTime(oldestFirst: true);

          return Scaffold(
            appBar: AppBar(
              backgroundColor: Theme.of(context).colorScheme.inversePrimary,
              title: Text(widget.vehicle.name),
            ),
            body: Padding(
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  VehicleCard(
                      vehicle: widget.vehicle, latestRefuel: refuels.isEmpty ? null : refuels.last),
                  ConsumptionWidget(refuels: refuels),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        ElevatedButton.icon(
                          onPressed: onPressed,
                          icon: const Icon(Icons.list),
                          label: const Text("History"),
                        ),
                        ElevatedButton.icon(
                          onPressed: onClicked,
                          icon: const Icon(Icons.add),
                          label: const Text("Add"),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        }
        return const Center(child: CircularProgressIndicator());
      },
    );
  }
}
