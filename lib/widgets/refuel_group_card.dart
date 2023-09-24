import 'package:flutter/material.dart';
import 'package:motolog/concepts/refuel_group.dart';
import 'package:motolog/models/vehicle.dart';
import 'package:motolog/widgets/dashed_separator.dart';
import 'package:motolog/widgets/rectangle_separator.dart';
import 'package:motolog/widgets/refuel_card.dart';

class RefuelGroupCard extends StatelessWidget {
  const RefuelGroupCard({
    super.key,
    required this.vehicle,
    required this.refuelGroup,
    required this.onDelete,
  });

  final Vehicle vehicle;
  final RefuelGroup refuelGroup;
  final Function(int id) onDelete;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black),
      ),
      child: Column(
        children: <Widget>[
          for (var (index, refuel) in refuelGroup.refuels.indexed) ...[
            if (index != 0) const DashedSeparator(),
            RefuelCard(
              vehicle: vehicle,
              refuel: refuel,
              onDelete: () => onDelete(refuel.id!),
              refuelGroup: refuelGroup,
            ),
            if (refuel.missingPreviousEntry) ...[
              const RectangleSeparator(
                height: 3,
                color: Colors.red,
              ),
              const Text('Missing previous entry'),
              const RectangleSeparator(
                height: 3,
                  color: Colors.red,
              )
            ],
          ],
        ],
      ),
    );
  }
}
