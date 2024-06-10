import 'dart:convert';

import 'package:naqla_driver/core/common/enums/order_status.dart';
import 'package:naqla_driver/features/auth/data/model/photo_model.dart';

class SubOrderModel {
  final String id;
  final DateTime createdAt;
  final DateTime updatedAt;
  final int rating;
  final int weight;
  final int cost;
  final SubOrderStatus status;
  final String? acceptedAt;
  final String? arrivedAt;
  final String? deliveredAt;
  final String? driverAssignedAt;
  final String? pickedUpAt;
  final String orderId;
  final String? carId;
  final List<PhotoModel> photos;

  SubOrderModel({
    required this.id,
    required this.createdAt,
    required this.updatedAt,
    required this.rating,
    required this.weight,
    required this.cost,
    required this.status,
    required this.acceptedAt,
    required this.arrivedAt,
    required this.deliveredAt,
    required this.driverAssignedAt,
    required this.pickedUpAt,
    required this.orderId,
    required this.carId,
    required this.photos,
  });

  SubOrderModel copyWith({
    String? id,
    DateTime? createdAt,
    DateTime? updatedAt,
    int? rating,
    int? weight,
    int? cost,
    SubOrderStatus? status,
    String? acceptedAt,
    String? arrivedAt,
    String? deliveredAt,
    String? driverAssignedAt,
    String? pickedUpAt,
    String? orderId,
    dynamic carId,
    List<PhotoModel>? photos,
  }) =>
      SubOrderModel(
        id: id ?? this.id,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        rating: rating ?? this.rating,
        weight: weight ?? this.weight,
        cost: cost ?? this.cost,
        status: status ?? this.status,
        acceptedAt: acceptedAt ?? this.acceptedAt,
        arrivedAt: arrivedAt ?? this.arrivedAt,
        deliveredAt: deliveredAt ?? this.deliveredAt,
        driverAssignedAt: driverAssignedAt ?? this.driverAssignedAt,
        pickedUpAt: pickedUpAt ?? this.pickedUpAt,
        orderId: orderId ?? this.orderId,
        carId: carId ?? this.carId,
        photos: photos ?? this.photos,
      );

  factory SubOrderModel.fromJson(Map<String, dynamic> json) => SubOrderModel(
        id: json["id"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        rating: json["rating"],
        weight: json["weight"],
        cost: json["cost"],
        status: SubOrderStatus.values.byName(json["status"]),
        acceptedAt: json["acceptedAt"],
        arrivedAt: json["arrivedAt"],
        deliveredAt: json["deliveredAt"],
        driverAssignedAt: json["driverAssignedAt"],
        pickedUpAt: json["pickedUpAt"],
        orderId: json["orderId"],
        carId: json["carId"],
        photos: List<PhotoModel>.from(json["photos"].map((x) => PhotoModel.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "rating": rating.toString(),
        "weight": weight.toString(),
        "cost": cost.toString(),
        "status": status.name,
        "acceptedAt": acceptedAt,
        "arrivedAt": arrivedAt,
        "deliveredAt": deliveredAt,
        "driverAssignedAt": driverAssignedAt,
        "pickedUpAt": pickedUpAt,
        "orderId": orderId,
        "carId": carId,
        "photos": List<dynamic>.from(photos.map((x) => x.toJson)).toList(),
      };
}
