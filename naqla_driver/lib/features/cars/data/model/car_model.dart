import 'package:naqla_driver/features/auth/data/model/photo_model.dart';

import '../../../cars/data/model/car_advantage.dart';

class CarModel {
  final String id;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String model;
  final String brand;
  final String color;
  final List<CarAdvantage> advantages;
  final PhotoModel photo;

  CarModel({
    required this.id,
    required this.createdAt,
    required this.updatedAt,
    required this.model,
    required this.brand,
    required this.color,
    required this.advantages,
    required this.photo,
  });

  CarModel copyWith({
    String? id,
    DateTime? createdAt,
    DateTime? updatedAt,
    String? model,
    String? brand,
    String? color,
    List<String>? photos,
    List<CarAdvantage>? advantages,
    PhotoModel? photo,
    bool? isSelected,
  }) =>
      CarModel(
        id: id ?? this.id,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        model: model ?? this.model,
        brand: brand ?? this.brand,
        color: color ?? this.color,
        advantages: advantages ?? this.advantages,
        photo: photo ?? this.photo,
      );

  factory CarModel.fromJson(Map<String, dynamic> json) => CarModel(
        id: json["id"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        model: json["model"],
        brand: json["brand"],
        color: json["color"],
        advantages: List<CarAdvantage>.from(json["advantages"].map((x) => CarAdvantage.fromJson(x, true))),
        photo: PhotoModel.fromJson(json["photo"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "model": model,
        "brand": brand,
        "color": color,
        "advantages": List<dynamic>.from(advantages.map((x) => x.toJson())),
        "photo": photo.toJson,
      };
}
