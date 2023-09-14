import 'package:motolog/models/database_model.dart';

class Refill extends DatabaseModel {
  static const currency = 'NOK';
  static const fuelUnit = 'Litre';
  static const distanceUnit = 'km';

  int? id;
  String station;
  DateTime datetime;
  double quantity;
  double paid;
  double distance;

  Refill({
    this.id,
    required this.station,
    required this.datetime,
    required this.quantity,
    required this.paid,
    required this.distance,
  });

  Refill.fromMap(Map<String, dynamic> res)
    : id = res['id'],
      station = res['station'],
      datetime = DateTime.fromMillisecondsSinceEpoch(res['datetime'] * Duration.millisecondsPerSecond),
      quantity = res['quantity'],
      paid = res['paid'],
      distance = res['distance'];

  @override
  Map<String, Object?> toMap() {
    return {
      'id': id,
      'station': station,
      'datetime': datetime.millisecondsSinceEpoch ~/ Duration.millisecondsPerSecond,
      'quantity': quantity,
      'paid': paid,
      'distance': distance,
    };
  }

  @override
  String toString() {
    return 'Refill${toMap()}';
  }
}
