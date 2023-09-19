import 'package:motolog/models/refuel.dart';

extension RefuelUtils on List<Refuel> {
  /// Sort by date time
  void sort() {
    this.sort((a, b) => b.dateTime.compareTo(a.dateTime));
  }

  /// NB: List must be sorted!
  double averageConsumption() {
    double quantity = 0;
    double distance = 0;
    for (int i = 1; i < length; i++) {
      Refuel entry = this[i];
      if (!entry.missingPreviousEntry) {
        Refuel previous = this[i-1];
        quantity += entry.quantity;
        distance += entry.distance - previous.distance;
      }
    }
    return quantity/distance;
  }

  double averageRefuelQuantity() {
    double quantity = fold(0.0, (previousValue, element) => previousValue + element.quantity);
    return quantity / length;
  }
}
