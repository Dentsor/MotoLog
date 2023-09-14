import 'package:motolog/models/database_model.dart';

class Vehicle extends DatabaseModel {
  int? id;
  String type;
  String name;
  String manufacturer;
  String model;
  String registration;
  int year;

  Vehicle({
    this.id,
    required this.type,
    required this.name,
    required this.manufacturer,
    required this.model,
    required this.registration,
    required this.year,
  });

  Vehicle.fromMap(Map<String, dynamic> res)
    : id = res['id'],
      type = res['type'],
      name = res['name'],
      manufacturer = res['manufacturer'],
      model = res['model'],
      registration = res['registration'],
      year = res['year'];

  @override
  Map<String, Object?> toMap() {
    return {
      'id': id,
      'type': type,
      'name': name,
      'manufacturer': manufacturer,
      'model': model,
      'registration': registration,
      'year': year,
    };
  }

  @override
  String toString() {
    return 'Vehicle${toMap()}';
  }
}
