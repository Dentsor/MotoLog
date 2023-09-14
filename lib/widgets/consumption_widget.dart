import 'package:flutter/material.dart';
import 'package:motolog/models/fuel.dart';

class ConsumptionWidget extends StatelessWidget {
  const ConsumptionWidget({
    super.key,
    required this.fuelData,
  });

  final Fuel fuelData;

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
            Text("${fuelData.avgConsumptionAllTime} (all time)"),
            // Text("${fuelData.avgConsumptionLately} (12 months)"),
          ],
        ),
      ]),
      TableRow(children: [
        const Text(
          "Best fueling day on average:",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        Text("${fuelData.avgBestRefuelDay} (${fuelData.avgBestRefuelPrice})")
      ]),
      TableRow(children: [
        const Text(
          "Avg. Refill Amount",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        Text("${fuelData.avgRefillAmount} ${fuelData.refillUnit}"),
      ]),
    ];

    return Table(
      border: TableBorder.all(),
      children: fuelRows,
    );
  }
}
