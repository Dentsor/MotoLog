import 'package:flutter/material.dart';
import 'package:motolog/models/bike.dart';
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
  var bike = Bike("Ragna", "BMW", "F650GS", "AB1234", 2018, 259783);
  var fuel = Fuel(0.3346, 0.3674, 8.6, "Litre", "Thursday", 22.07);
  var refills = <Refill>[
    Refill("Circle K", "2023-08-28 10:32", 19.67, 4.3, "NOK", "Litre"),
    Refill("Shell", "2023-08-28 18:47", 21.82, 13.5, "NOK", "Litre"),
    Refill("YX", "2023-09-03 16:47", 23.99, 6.33, "NOK", "Litre"),
    Refill("Uno X", "2023-09-05 12:43", 21.07, 7.44, "NOK", "Litre"),
  ];

  void onPressed() {
    print("pressed");
  }

  void onClicked() {
    print("clicked");
    Navigator.push(context, MaterialPageRoute(builder: (context) => AddRefillPage(title: widget.title)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            VehicleCard(bikeData: bike),
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
  }
}
