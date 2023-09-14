import 'package:flutter/material.dart';
import 'package:motolog/database/database_helper.dart';
import 'package:motolog/database/refuel_db_helper.dart';
import 'package:motolog/models/refuel.dart';
import 'package:motolog/widgets/refuel_card.dart';

class RefuelHistoryPage extends StatefulWidget {
  const RefuelHistoryPage({super.key, required this.title});

  final String title;

  @override
  State<RefuelHistoryPage> createState() => _RefuelHistoryPageState();
}

class _RefuelHistoryPageState extends State<RefuelHistoryPage> {
  DatabaseHelper dbHelper = DatabaseHelper();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: dbHelper.retrieveRefuels(),
        builder: (BuildContext context, AsyncSnapshot<List<Refuel>> snapshot) {
          if (snapshot.hasData) {
            var refuels = snapshot.data!;
            return Scaffold(
              appBar: AppBar(
                backgroundColor: Theme.of(context).colorScheme.secondary,
                title: Text(widget.title),
              ),
              body: Center(
                child: SingleChildScrollView(
                  child: Table(
                    children: [
                      for (var refuel in refuels)
                        TableRow(children: [RefuelCard(refuel: refuel)])
                    ],
                  ),
                ),
              ),
            );
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        });
  }
}
