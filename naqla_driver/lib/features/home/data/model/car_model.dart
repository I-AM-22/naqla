import 'package:naqla_driver/features/home/data/model/driver_info.dart';

class SubOrderCarModel {
  final String? model;
  final String? brand;
  final String? color;
  final DriverInfo? driver;

  SubOrderCarModel({required this.model, required this.brand, required this.color, required this.driver});

  factory SubOrderCarModel.fromJson(Map<String, dynamic> json) => SubOrderCarModel(
      model: json['model'], brand: json['brand'], color: json['color'], driver: json['driver'] == null ? null : DriverInfo.fromJson(json['driver']));
}
