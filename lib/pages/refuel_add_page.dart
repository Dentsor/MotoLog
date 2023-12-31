import 'package:flutter/material.dart';
import 'package:motolog/models/refuel.dart';
import 'package:motolog/models/vehicle.dart';
import 'package:motolog/widgets/refuel_form.dart';

class RefuelAddPage extends StatelessWidget {
  const RefuelAddPage({super.key, required this.vehicle, required this.refuels});

  final Vehicle vehicle;
  final List<Refuel> refuels;

  @override
  Widget build(BuildContext context) {
    return RefuelForm(vehicle: vehicle, refuel: null, firstEntry: refuels.isEmpty);
  }
}
