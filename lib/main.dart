import 'package:flutter/material.dart';
import 'package:motolog/pages/vehicle_overview.dart';

void main() {
  runApp(const MotoLog());
}

class MotoLog extends StatelessWidget {
  const MotoLog({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MotoLog',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const VehicleOverviewPage(title: 'Vehicle Overview'),
    );
  }
}
