import 'package:motolog/models/refuel.dart';

extension RefuelUtils on List<Refuel> {
  /// Sort by date time
  void sortByDateTime({required oldestFirst}) {
    if (oldestFirst) {
      sort((a, b) => a.dateTime.compareTo(b.dateTime));
    } else {
      sort((a, b) => b.dateTime.compareTo(a.dateTime));
    }
  }

  /// NB: List must be sorted first (oldest first)!
  double averageConsumption({Refuel? baseline}) {
    if (baseline != null && first.missingPreviousEntry) {
      throw Exception(// TODO
          'First item in grouped refuels is missing previous, but requested computation with baseline => Incompatible!');
    }
    double quantity = baseline == null ? 0 : first.quantity;
    double distance = baseline == null ? 0 : first.distance - baseline.distance;
    for (int i = 1; i < length; i++) {
      Refuel entry = this[i];
      if (!entry.missingPreviousEntry) {
        Refuel previous = this[i - 1];
        quantity += entry.quantity;
        distance += entry.distance - previous.distance;
      }
    }
    return quantity / distance;
  }

  double averageRefuelQuantity() {
    double quantity =
        fold(0.0, (previousValue, element) => previousValue + element.quantity);
    return quantity / length;
  }
}
