import 'package:motolog/models/refuel.dart';

class Fuel {
  double avgConsumptionAllTime;
  double avgRefuelQuantity;
  String refuelUnit;
  String avgBestRefuelDay;
  double avgBestRefuelPrice;

  Fuel({
    required this.avgConsumptionAllTime,
    required this.avgRefuelQuantity,
    required this.refuelUnit,
    required this.avgBestRefuelDay,
    required this.avgBestRefuelPrice,
  });

  Fuel.calculate(List<Refuel> refuels)
    : avgConsumptionAllTime = (refuels.sublist(1).map((e) => e.quantity).reduce((first, second) => first + second)) / (refuels.last.distance - refuels.first.distance) * 10,
      avgRefuelQuantity = refuels.map((e) => e.quantity).reduce((value, element) => value + element) / refuels.length,
      refuelUnit = Refuel.fuelUnit,
      avgBestRefuelDay = "Tuesday",
      avgBestRefuelPrice = 12.21;
}
