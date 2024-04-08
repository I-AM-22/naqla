import 'package:naqla/features/home/data/model/location_model.dart';

import '../../../auth/data/model/photo_model.dart';

class OrderModel {
  final String id;
  final String status;
  final LocationModel locationStart;
  final LocationModel locationEnd;
  final List<dynamic> advantages;
  final List<Photo> photos;

  OrderModel({
    required this.id,
    required this.status,
    required this.locationStart,
    required this.locationEnd,
    required this.advantages,
    required this.photos,
  });

  OrderModel copyWith({
    String? id,
    String? status,
    LocationModel? locationStart,
    LocationModel? locationEnd,
    List<dynamic>? advantages,
    List<Photo>? photos,
  }) =>
      OrderModel(
        id: id ?? this.id,
        status: status ?? this.status,
        locationStart: locationStart ?? this.locationStart,
        locationEnd: locationEnd ?? this.locationEnd,
        advantages: advantages ?? this.advantages,
        photos: photos ?? this.photos,
      );

  factory OrderModel.fromJson(Map<String, dynamic> json) => OrderModel(
        id: json["id"],
        status: json["status"],
        locationStart: LocationModel.fromJson(json["locationStart"]),
        locationEnd: LocationModel.fromJson(json["locationEnd"]),
        advantages: List<dynamic>.from(json["advantages"].map((x) => x)),
        photos: List<Photo>.from(json["photos"].map((x) => Photo.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "status": status,
        "locationStart": locationStart.toJson(),
        "locationEnd": locationEnd.toJson(),
        "advantages": List<dynamic>.from(advantages.map((x) => x)),
        "photos": List<dynamic>.from(photos.map((x) => x.toJson())),
      };
}
