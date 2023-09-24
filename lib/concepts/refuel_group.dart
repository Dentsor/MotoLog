import 'package:motolog/models/refuel.dart';
import 'package:motolog/utils/refuel_utils.dart';

class RefuelGroup {
  const RefuelGroup({
    required this.refuels,
    required this.previousRefuel,
  });

  final List<Refuel> refuels;
  final Refuel? previousRefuel;

  double? averageConsumption() {
    if (previousRefuel == null) {
      return null;
    }
    return refuels.averageConsumption(baseline: previousRefuel);
  }

  /// List refuels must be sorted in ascending order first (oldest first)!
  static List<RefuelGroup> generate(List<Refuel> refuels) {
    List<RefuelGroup> refuelGroups = [];
    List<Refuel> wipGroup = [];
    for (int i = 0; i < refuels.length; i++) {
      var entry = refuels[i];
      wipGroup.add(entry);
      if (entry.filledToCapacity) {
        refuelGroups.add(RefuelGroup(
          refuels: wipGroup,
          previousRefuel: entry.missingPreviousEntry || refuelGroups.isEmpty
              ? null
              : refuelGroups.last.refuels.last,
        ));
        wipGroup = [];
      }
    }
    if (wipGroup.isNotEmpty) {
      refuelGroups.add(RefuelGroup(
        refuels: wipGroup,
        previousRefuel: wipGroup.last.missingPreviousEntry
            ? null
            : refuelGroups.last.refuels.last,
      ));
    }
    return refuelGroups;
  }
}
