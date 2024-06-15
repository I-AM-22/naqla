import 'location_model.dart';

class OrderModel {
  final DateTime desiredDate;
  final int porters;
  final LocationModel locationStart;
  final LocationModel locationEnd;
  final List<String>? advantages;

  OrderModel({
    required this.desiredDate,
    required this.porters,
    required this.locationStart,
    required this.locationEnd,
    required this.advantages,
  });

  OrderModel copyWith({
    DateTime? desiredDate,
    int? porters,
    LocationModel? locationStart,
    LocationModel? locationEnd,
    List<String>? advantages,
  }) =>
      OrderModel(
        desiredDate: desiredDate ?? this.desiredDate,
        porters: porters ?? this.porters,
        locationStart: locationStart ?? this.locationStart,
        locationEnd: locationEnd ?? this.locationEnd,
        advantages: advantages ?? this.advantages,
      );

  factory OrderModel.fromJson(Map<String, dynamic> json) => OrderModel(
        desiredDate: DateTime.parse(json["desiredDate"]),
        porters: json["porters"],
        locationStart: LocationModel.fromJson(json["locationStart"]),
        locationEnd: LocationModel.fromJson(json["locationEnd"]),
        advantages: json["advantages"] == null ? null : List<String>.from(json["advantages"].map((x) => x['name'])),
      );

  Map<String, dynamic> toJson() => {
        "desiredDate": desiredDate.toIso8601String(),
        "porters": porters,
        "locationStart": locationStart.toJson(),
        "locationEnd": locationEnd.toJson(),
        "advantages": List<dynamic>.from(advantages?.map((x) => x) ?? []),
      };
}
