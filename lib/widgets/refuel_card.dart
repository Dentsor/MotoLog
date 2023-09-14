import 'package:flutter/material.dart';
import 'package:motolog/models/refuel.dart';

class RefuelCard extends StatelessWidget {
  const RefuelCard({
    super.key,
    required this.refuel,
  });

  final Refuel refuel;

  @override
  Widget build(BuildContext context) {
    return Row(children: [
      const Icon(Icons.location_pin),
      Column(children: [
        Text(
          refuel.station,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        Table(
          border: TableBorder.all(),
          children: [
            TableRow(children: [
              const Text(
                "Time",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Text("${refuel.dateTime}"),
            ]),
            TableRow(children: [
              const Text(
                "Unit Price",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Text(
                  "${(refuel.paid / refuel.quantity).toStringAsFixed(2)} ${Refuel.currency}/${Refuel.fuelUnit}"),
            ]),
            TableRow(children: [
              const Text(
                "Quantity",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Text("${refuel.quantity} ${Refuel.fuelUnit}"),
            ]),
            TableRow(children: [
              const Text(
                'Distance',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Text('${refuel.distance} ${Refuel.distanceUnit}'),
            ]),
          ],
          defaultColumnWidth: const IntrinsicColumnWidth(),
        ),
      ]),
      Text("${refuel.paid} ${Refuel.currency}"),
    ]);
  }
}
