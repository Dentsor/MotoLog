import 'package:flutter/material.dart';
import 'package:motolog/models/vehicle.dart';
import 'package:motolog/models/refuel.dart';

class VehicleCard extends StatelessWidget {
  const VehicleCard({
    super.key,
    required this.vehicle,
    required this.latestRefuel,
  });

  final Vehicle vehicle;
  final Refuel latestRefuel;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        const Icon(Icons.motorcycle),
        Column(
          children: <Widget>[
            Text(vehicle.name),
            Text(
              "${vehicle.registration}, ${vehicle.year}, ${latestRefuel.distance} ${Refuel.distanceUnit}",
            ),
          ],
        ),
      ],
    );
  }
}
