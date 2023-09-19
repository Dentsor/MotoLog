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
    return Container(
      decoration: BoxDecoration(
          border: Border.all(color: Theme.of(context).primaryColor)),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(Icons.location_pin),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                refuel.station,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              Text("${refuel.dateTime}"),
              Text(
                  "${refuel.quantity} ${Refuel.fuelUnit} @ ${(refuel.paid / refuel.quantity).toStringAsFixed(2)} ${Refuel.currency}/${Refuel.fuelUnit}"),
              Text("${refuel.paid} ${Refuel.currency}"),
              Text("${refuel.distance} ${Refuel.distanceUnit}"),
            ],
          ),
        ],
      ),
    );
  }
}
