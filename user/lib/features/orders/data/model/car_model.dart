import 'package:naqla/features/orders/data/model/driver_model.dart';

class CarModel {
  final String model;
  final String brand;
  final String color;
  final DriverModel driver;

  CarModel(
      {required this.model,
      required this.brand,
      required this.color,
      required this.driver});

  factory CarModel.fromJson(Map<String, dynamic> json) => CarModel(
      model: json['model'],
      brand: json['brand'],
      color: json['color'],
      driver: DriverModel.fromJson(json['driver']));
}
