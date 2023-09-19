import 'package:flutter/material.dart';
import 'package:motolog/models/refuel.dart';
import 'package:motolog/utils/refuel_utils.dart';

class ConsumptionWidget extends StatelessWidget {
  const ConsumptionWidget({
    super.key,
    required this.refuels,
  });

  final List<Refuel> refuels;

  @override
  Widget build(BuildContext context) {
    var fuelRows = <TableRow>[
      TableRow(children: [
        const Text(
          "Avg. Consumption:",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "${refuels.averageConsumption().toStringAsFixed(2)} (all time)",
            ),
            // Text("${fuelData.avgConsumptionLately.toStringAsFixed(2)} (12 months)"),
          ],
        ),
      ]),
      TableRow(children: [
        const Text(
          "Avg. Refuel Quantity",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        Text(
          "${refuels.averageRefuelQuantity().toStringAsFixed(2)} ${Refuel.fuelUnit}",
        ),
      ]),
    ];

    return Table(
      border: TableBorder.all(),
      children: fuelRows,
    );
  }
}
