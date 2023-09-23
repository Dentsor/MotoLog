import 'package:flutter/material.dart';
import 'package:motolog/models/refuel.dart';

class RefuelCard extends StatelessWidget {
  const RefuelCard({
    super.key,
    required this.refuel,
    required this.onDelete,
  });

  final Refuel refuel;
  final VoidCallback onDelete;

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
          const Spacer(),
          IconButton(
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: const Text('Please confirm deletion'),
                        content: Text(
                            "Are you sure you want to delete the refueling at ${refuel.station} on ${refuel.dateTime} for ${refuel.paid} ${Refuel.currency}?"),
                        actions: [
                          IconButton(
                              onPressed: () {
                                onDelete();
                                Navigator.pop(context);
                              },
                              icon: const Icon(Icons.check)),
                          IconButton(
                              onPressed: () => Navigator.pop(context),
                              icon: const Icon(Icons.cancel)),
                        ],
                      );
                    });
              },
              icon: const Icon(Icons.delete)),
        ],
      ),
    );
  }
}
