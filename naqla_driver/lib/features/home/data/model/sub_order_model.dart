import 'package:naqla_driver/features/auth/data/model/photo_model.dart';
import 'package:naqla_driver/features/home/data/model/car_model.dart';

import '../../../../core/common/enums/order_status.dart';
import 'order_model.dart';

class SubOrderModel {
  final String id;
  final int weight;
  final int cost;
  final OrderModel? order;
  final int? rating;
  final SubOrderStatus? status;
  final DateTime? acceptedAt;
  final DateTime? arrivedAt;
  final DateTime? deliveredAt;
  final DateTime? driverAssignedAt;
  final DateTime? pickedUpAt;
  final List<PhotoModel> photos;
  final SubOrderCarModel? carModel;

  SubOrderModel({
    required this.id,
    required this.weight,
    required this.cost,
    required this.order,
    required this.rating,
    required this.status,
    required this.acceptedAt,
    required this.arrivedAt,
    required this.deliveredAt,
    required this.driverAssignedAt,
    required this.pickedUpAt,
    required this.photos,
    required this.carModel,
  });

  SubOrderModel copyWith({
    String? id,
    int? weight,
    int? cost,
    OrderModel? order,
    int? rating,
    SubOrderStatus? status,
    DateTime? acceptedAt,
    DateTime? arrivedAt,
    DateTime? deliveredAt,
    DateTime? driverAssignedAt,
    DateTime? pickedUpAt,
    List<PhotoModel>? photos,
    SubOrderCarModel? carModel,
  }) =>
      SubOrderModel(
        id: id ?? this.id,
        weight: weight ?? this.weight,
        cost: cost ?? this.cost,
        order: order ?? this.order,
        photos: photos ?? this.photos,
        status: status ?? this.status,
        acceptedAt: acceptedAt ?? this.acceptedAt,
        arrivedAt: arrivedAt ?? this.arrivedAt,
        deliveredAt: deliveredAt ?? this.deliveredAt,
        driverAssignedAt: driverAssignedAt ?? this.driverAssignedAt,
        pickedUpAt: pickedUpAt ?? this.pickedUpAt,
        rating: rating ?? this.rating,
        carModel: carModel ?? this.carModel,
      );

  factory SubOrderModel.fromJson(Map<String, dynamic> json) => SubOrderModel(
        id: json["id"],
        weight: json["weight"],
        cost: json["cost"],
        order:
            json["order"] == null ? null : OrderModel.fromJson(json["order"]),
        rating: json["rating"],
        status: SubOrderStatus.values
            .byName(json["status"] ?? SubOrderStatus.delivered.name),
        acceptedAt: DateTime.tryParse(json["acceptedAt"] ?? ''),
        arrivedAt: DateTime.tryParse(json["arrivedAt"] ?? ''),
        deliveredAt: DateTime.tryParse(json["deliveredAt"] ?? ''),
        driverAssignedAt: DateTime.tryParse(json["driverAssignedAt"] ?? ''),
        pickedUpAt: DateTime.tryParse(json["pickedUpAt"] ?? ''),
        photos: List<PhotoModel>.from(
            json["photos"].map((x) => PhotoModel.fromJson(x))),
        carModel:
            json['car'] == null ? null : SubOrderCarModel.fromJson(json['car']),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "weight": weight,
        "cost": cost,
        "rating": rating,
        "status": status,
        "acceptedAt": acceptedAt?.toIso8601String(),
        "arrivedAt": arrivedAt?.toIso8601String(),
        "deliveredAt": deliveredAt?.toIso8601String(),
        "driverAssignedAt": driverAssignedAt?.toIso8601String(),
        "pickedUpAt": pickedUpAt?.toIso8601String(),
        "order": order?.toJson(),
        "photos": List<PhotoModel>.from(photos.map((x) => x.toJson)),
      };
}
