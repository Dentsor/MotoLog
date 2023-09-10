import 'package:flutter/material.dart';
import 'package:motolog/models/bike.dart';

class VehicleCard extends StatelessWidget {
  const VehicleCard({
    super.key,
    required this.bikeData,
  });

  final Bike bikeData;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        const Icon(Icons.motorcycle),
        Column(
          children: <Widget>[
            Text("${bikeData.name}"),
            Text(
              "${bikeData.registration}, ${bikeData.year}, ${bikeData.mileage} km",
            ),
          ],
        ),
      ],
    );
  }
}
