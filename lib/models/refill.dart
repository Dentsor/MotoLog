import 'package:motolog/models/database_model.dart';

class Refill extends DatabaseModel {
  int? id;
  String station;
  String datetime;
  double quantity;
  double paid;
  String currency;
  String unit;
  int mileage;

  Refill({
    this.id,
    required this.station,
    required this.datetime,
    required this.quantity,
    required this.paid,
    required this.currency,
    required this.unit,
    required this.mileage,
  });

  Refill.fromMap(Map<String, dynamic> res)
    : id = res['id'],
      station = res['station'],
      datetime = res['datetime'],
      quantity = res['quantity'],
      paid = res['paid'],
      currency = res['currency'],
      unit = res['unit'],
      mileage = res['mileage'];

  @override
  Map<String, Object?> toMap() {
    return {
      'id': id,
      'station': station,
      'datetime': datetime,
      'quantity': quantity,
      'paid': paid,
      'currency': currency,
      'unit': unit,
      'mileage': mileage,
    };
  }

  @override
  String toString() {
    return 'Refill${toMap()}';
  }
}
