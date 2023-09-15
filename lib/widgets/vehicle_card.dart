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
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        border: Border.all(color: Theme.of(context).primaryColor),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Icon(
            switch (vehicle.type) {
              'motorcycle' => Icons.motorcycle,
              'car' => Icons.directions_car,
              'electric_bike' => Icons.electric_bike,
              'bike' => Icons.pedal_bike,
              'skateboard' => Icons.skateboarding,
              String() => Icons.navigation,
            },
            size: 48,
          ),
          Column(
            children: <Widget>[
              Text(
                vehicle.name,
                style: const TextStyle(fontWeight: FontWeight.bold),
                textScaleFactor: 1.4,
              ),
              Text(
                "${vehicle.registration}, ${vehicle.year}, ${latestRefuel.distance} ${Refuel.distanceUnit}",
              ),
            ],
          ),
        ],
      ),
    );
  }
}
