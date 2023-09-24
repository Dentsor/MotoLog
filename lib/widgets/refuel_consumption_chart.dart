import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:motolog/concepts/refuel_group.dart';

class RefuelConsumptionChart extends StatelessWidget {
  const RefuelConsumptionChart({
    super.key,
    required this.refuelGroups,
  });

  final List<RefuelGroup> refuelGroups;

  @override
  Widget build(BuildContext context) {
    var latestDateTime = refuelGroups.last.refuels.last.dateTime;

    return AspectRatio(
      aspectRatio: 2,
      child: LineChart(LineChartData(
        lineBarsData: [
          LineChartBarData(
            spots: refuelGroups
                .where((element) =>
                    latestDateTime
                        .difference(element.refuels.first.dateTime)
                        .inDays <
                    365)
                .map((e) => [e.refuels.last.dateTime, e.averageConsumption()])
                .where((element) => element[1] != null)
                .map((e) => FlSpot(
                    (e[0] as DateTime).millisecondsSinceEpoch.toDouble(),
                    e[1] as double))
                .toList(),
            isCurved: false,
          ),
        ],
        titlesData: const FlTitlesData(
          show: false,
        ),
      )),
    );
  }
}
