import 'package:flutter/material.dart';
import 'package:motolog/models/vehicle.dart';
import 'package:motolog/models/refill.dart';

class VehicleCard extends StatelessWidget {
  const VehicleCard({
    super.key,
    required this.vehicle,
    required this.latestRefill,
  });

  final Vehicle vehicle;
  final Refill latestRefill;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        const Icon(Icons.motorcycle),
        Column(
          children: <Widget>[
            Text("${vehicle.name}"),
            Text(
              "${vehicle.registration}, ${vehicle.year}, ${latestRefill.distance} ${Refill.distanceUnit}",
            ),
          ],
        ),
      ],
    );
  }
}
