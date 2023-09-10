import 'package:flutter/material.dart';
import 'package:motolog/models/refill.dart';

class RefillsWidget extends StatelessWidget {
  const RefillsWidget({
    super.key,
    required this.refillData,
  });

  final List<Refill> refillData;

  @override
  Widget build(BuildContext context) {
    var refillRows = <TableRow>[];
    for (Refill entry in refillData) {
      var t = TableRow(children: [
        Row(children: [
          const Icon(Icons.location_pin),
          Column(children: [
            Text(
              "${entry.station}",
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
                  Text("${entry.datetime}"),
                ]),
                TableRow(children: [
                  const Text(
                    "Unit Price",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text("${entry.unitPrice} ${entry.currency}/${entry.unit}"),
                ]),
                TableRow(children: [
                  const Text(
                    "Quantity",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text("${entry.quantity} ${entry.unit}"),
                ]),
              ],
              defaultColumnWidth: const IntrinsicColumnWidth(),
            ),
          ]),
          Text("${entry.paid?.toStringAsFixed(2)} ${entry.currency}"),
        ])
      ]);
      refillRows.add(t);
    }
    return Table(children: refillRows);
  }
}
