import 'package:naqla/core/common/enums/sub_order_status.dart';
import 'package:naqla/features/home/data/model/order_photos_model.dart';

class SubOrderModel {
  final String id;
  final DateTime createdAt;
  final DateTime updatedAt;
  final int rating;
  final int weight;
  final int cost;
  final SubOrderStatus status;
  final DateTime acceptedAt;
  final DateTime? arrivedAt;
  final DateTime? deliveredAt;
  final DateTime? driverAssignedAt;
  final DateTime? pickedUpAt;
  final List<OrderPhotosModel> photos;

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
    DateTime? acceptedAt,
    DateTime? arrivedAt,
    DateTime? deliveredAt,
    DateTime? driverAssignedAt,
    DateTime? pickedUpAt,
    List<OrderPhotosModel>? photos,
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
        photos: photos ?? this.photos,
      );

  factory SubOrderModel.fromJson(Map<String, dynamic> json) => SubOrderModel(
        id: json["id"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        rating: json["rating"],
        weight: json["weight"],
        cost: json["cost"],
        status: SubOrderStatus.values.byName(json["status"] ?? SubOrderStatus.waiting.name),
        acceptedAt: DateTime.parse(json["acceptedAt"]),
        arrivedAt: DateTime.tryParse(json["arrivedAt"] ?? ''),
        deliveredAt: DateTime.tryParse(json["deliveredAt"] ?? ''),
        driverAssignedAt: DateTime.tryParse(json["driverAssignedAt"] ?? ''),
        pickedUpAt: DateTime.tryParse(json["pickedUpAt"] ?? ''),
        photos: List<OrderPhotosModel>.from(json["photos"].map((x) => OrderPhotosModel.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "rating": rating,
        "weight": weight,
        "cost": cost,
        "status": status,
        "acceptedAt": acceptedAt.toIso8601String(),
        "arrivedAt": arrivedAt?.toIso8601String(),
        "deliveredAt": deliveredAt?.toIso8601String(),
        "driverAssignedAt": driverAssignedAt?.toIso8601String(),
        "pickedUpAt": pickedUpAt?.toIso8601String(),
        "photos": List<dynamic>.from(photos.map((x) => x.toJson())),
      };
}
