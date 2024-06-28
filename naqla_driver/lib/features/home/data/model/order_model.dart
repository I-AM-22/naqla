import 'location_model.dart';

class OrderModel {
  final String id;
  final DateTime? desiredDate;
  final int? porters;
  final String? userName;
  final LocationModel? locationStart;
  final LocationModel? locationEnd;
  final List<String>? advantages;

  OrderModel({
    required this.id,
    required this.desiredDate,
    required this.porters,
    required this.locationStart,
    required this.locationEnd,
    required this.advantages,
    required this.userName,
  });

  OrderModel copyWith({
    String? id,
    DateTime? desiredDate,
    int? porters,
    LocationModel? locationStart,
    LocationModel? locationEnd,
    List<String>? advantages,
    String? userName,
  }) =>
      OrderModel(
          id: id ?? this.id,
          desiredDate: desiredDate ?? this.desiredDate,
          porters: porters ?? this.porters,
          locationStart: locationStart ?? this.locationStart,
          locationEnd: locationEnd ?? this.locationEnd,
          advantages: advantages ?? this.advantages,
          userName: userName ?? this.userName);

  factory OrderModel.fromJson(Map<String, dynamic> json) => OrderModel(
        id: json["id"] ?? '',
        desiredDate: DateTime.tryParse(json["desiredDate"] ?? ''),
        userName: json['user'] == null ? null : '${json['user']['firstName']} ${json['user']['lastName']}',
        porters: json["porters"],
        locationStart: json["locationStart"] == null ? null : LocationModel.fromJson(json["locationStart"]),
        locationEnd: json["locationEnd"] == null ? null : LocationModel.fromJson(json["locationEnd"]),
        advantages: json["advantages"] == null ? null : List<String>.from(json["advantages"].map((x) => x['name'])),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "desiredDate": desiredDate?.toIso8601String(),
        "porters": porters,
        "locationStart": locationStart?.toJson(),
        "locationEnd": locationEnd?.toJson(),
        "advantages": List<dynamic>.from(advantages?.map((x) => x) ?? []),
      };
}
