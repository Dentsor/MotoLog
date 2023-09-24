import 'package:flutter/material.dart';
import 'package:motolog/models/refuel.dart';
import 'package:motolog/models/vehicle.dart';
import 'package:motolog/widgets/refuel_form.dart';

class RefuelEditPage extends StatelessWidget {
  const RefuelEditPage({super.key, required this.vehicle, required this.refuel});

  final Vehicle vehicle;
  final Refuel refuel;

  @override
  Widget build(BuildContext context) {
    return RefuelForm(vehicle: vehicle, refuel: refuel, firstEntry: false);
  }
}
