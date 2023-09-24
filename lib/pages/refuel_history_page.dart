import 'package:flutter/material.dart';
import 'package:motolog/database/database_helper.dart';
import 'package:motolog/database/refuel_db_helper.dart';
import 'package:motolog/models/refuel.dart';
import 'package:motolog/models/vehicle.dart';
import 'package:motolog/widgets/refuel_card.dart';

class RefuelHistoryPage extends StatefulWidget {
  const RefuelHistoryPage({super.key, required this.vehicle});

  final Vehicle vehicle;

  @override
  State<RefuelHistoryPage> createState() => _RefuelHistoryPageState();
}

class _RefuelHistoryPageState extends State<RefuelHistoryPage> {
  final DatabaseHelper dbHelper = DatabaseHelper();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: dbHelper.retrieveRefuels(),
        builder: (BuildContext context, AsyncSnapshot<List<Refuel>> snapshot) {
          if (snapshot.connectionState != ConnectionState.done) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Text(snapshot.error.toString()); // TODO
          }
          if (snapshot.hasData) {
            List<Refuel> refuels = snapshot.data!;
            refuels.sort((a, b) => b.dateTime.compareTo(a.dateTime));
            return Scaffold(
              appBar: AppBar(
                backgroundColor: Theme.of(context).colorScheme.secondary,
                title: Text('Refueling History | ${widget.vehicle.name}'),
              ),
              body: Center(
                child: SingleChildScrollView(
                  child: Table(
                    children: refuels
                        .map((e) => TableRow(children: [
                              RefuelCard(
                                vehicle: widget.vehicle,
                                refuel: e,
                                onDelete: () async {
                                  await dbHelper.deleteRefuel(e.id!);
                                  setState(() {});
                                },
                              )
                            ]))
                        .toList(),
                  ),
                ),
              ),
            );
          }
          return const Text("No data"); // TODO
        });
  }
}
