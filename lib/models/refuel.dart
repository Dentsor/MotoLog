import 'package:motolog/models/data_model.dart';

class Refuel extends DataModel {
  static const currency = 'NOK';
  static const fuelUnit = 'Litre';
  static const distanceUnit = 'km';

  int? id;
  int vehicleId;
  String station;
  DateTime dateTime;
  double quantity;
  double paid;
  double distance;
  bool fullTank;

  Refuel({
    this.id,
    required this.vehicleId,
    required this.station,
    required this.dateTime,
    required this.quantity,
    required this.paid,
    required this.distance,
    required this.fullTank,
  });

  Refuel.fromMap(Map<String, dynamic> res)
    : id = res['id'],
      vehicleId = res['vehicleId'],
      station = res['station'],
      dateTime = DateTime.fromMillisecondsSinceEpoch(res['dateTime'] * Duration.millisecondsPerSecond),
      quantity = res['quantity'],
      paid = res['paid'],
      distance = res['distance'],
      fullTank = res['fullTank'] == 1;

  @override
  Map<String, Object?> toMap() {
    return {
      'id': id,
      'vehicleId': vehicleId,
      'station': station,
      'datetime': dateTime.millisecondsSinceEpoch ~/ Duration.millisecondsPerSecond,
      'quantity': quantity,
      'paid': paid,
      'distance': distance,
      'fullTank': fullTank,
    };
  }

  @override
  String toString() {
    return 'Refuel${toMap()}';
  }
}
