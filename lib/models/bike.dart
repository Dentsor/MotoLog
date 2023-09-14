import 'package:motolog/models/database_model.dart';

class Bike extends DatabaseModel {
  int? id;
  String name;
  String manufacturer;
  String model;
  String registration;
  int year;
  int mileage;

  Bike({
    this.id,
    required this.name,
    required this.manufacturer,
    required this.model,
    required this.registration,
    required this.year,
    required this.mileage,
  });

  Bike.fromMap(Map<String, dynamic> res)
    : id = res['id'],
      name = res['name'],
      manufacturer = res['manufacturer'],
      model = res['model'],
      registration = res['registration'],
      year = res['year'],
      mileage = res['mileage'];

  @override
  Map<String, Object?> toMap() {
    return {
      'id': id,
      'name': name,
      'manufacturer': manufacturer,
      'model': model,
      'registration': registration,
      'year': year,
      'mileage': mileage,
    };
  }

  @override
  String toString() {
    return 'Bike${toMap()}';
  }
}
