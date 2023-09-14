import 'package:motolog/models/refill.dart';

class Fuel {
  double avgConsumptionAllTime;
  double avgRefillAmount;
  String refillUnit;
  String avgBestRefuelDay;
  double avgBestRefuelPrice;

  Fuel({
    required this.avgConsumptionAllTime,
    required this.avgRefillAmount,
    required this.refillUnit,
    required this.avgBestRefuelDay,
    required this.avgBestRefuelPrice,
  });

  Fuel.calculate(List<Refill> refills)
    : avgConsumptionAllTime = (refills.sublist(1).map((e) => e.quantity).reduce((first, second) => first + second)) / (refills.last.distance - refills.first.distance),
      avgRefillAmount = refills.map((e) => e.quantity).reduce((value, element) => value + element) / refills.length,
      refillUnit = Refill.fuelUnit,
      avgBestRefuelDay = "Tuesday",
      avgBestRefuelPrice = 12.21;
}
