import 'package:naqla/core/common/enums/sub_order_status.dart';
import 'package:naqla/features/home/data/model/order_photos_model.dart';
import 'package:naqla/features/orders/data/model/car_model.dart';
import '../../../home/data/model/order_model.dart';

class SubOrderModel {
  final String id;
  final num rating;
  final String? note;
  final num weight;
  final num cost;
  final num realCost;
  final OrderModel? order;
  final SubOrderStatus status;
  final DateTime? acceptedAt;
  final DateTime? arrivedAt;
  final DateTime? deliveredAt;
  final DateTime? driverAssignedAt;
  final DateTime? pickedUpAt;
  final List<OrderPhotosModel> photos;
  final CarModel? carModel;

  SubOrderModel({
    required this.id,
    required this.rating,
    required this.note,
    required this.weight,
    required this.cost,
    required this.realCost,
    required this.status,
    required this.acceptedAt,
    required this.arrivedAt,
    required this.deliveredAt,
    required this.driverAssignedAt,
    required this.pickedUpAt,
    required this.photos,
    required this.order,
    required this.carModel,
  });

  SubOrderModel copyWith({
    String? id,
    num? rating,
    String? note,
    num? weight,
    num? cost,
    num? realCost,
    SubOrderStatus? status,
    DateTime? acceptedAt,
    DateTime? arrivedAt,
    DateTime? deliveredAt,
    DateTime? driverAssignedAt,
    DateTime? pickedUpAt,
    List<OrderPhotosModel>? photos,
    OrderModel? order,
    CarModel? carModel,
  }) =>
      SubOrderModel(
        id: id ?? this.id,
        rating: rating ?? this.rating,
        note: note ?? this.note,
        weight: weight ?? this.weight,
        cost: cost ?? this.cost,
        realCost: realCost ?? this.realCost,
        status: status ?? this.status,
        order: order ?? this.order,
        acceptedAt: acceptedAt ?? this.acceptedAt,
        arrivedAt: arrivedAt ?? this.arrivedAt,
        deliveredAt: deliveredAt ?? this.deliveredAt,
        driverAssignedAt: driverAssignedAt ?? this.driverAssignedAt,
        pickedUpAt: pickedUpAt ?? this.pickedUpAt,
        photos: photos ?? this.photos,
        carModel: carModel ?? this.carModel,
      );

  factory SubOrderModel.fromJson(Map<String, dynamic> json) => SubOrderModel(
        id: json["id"],
        rating: json["rating"] ?? 0,
        note: json["note"],
        weight: json["weight"],
        cost: json["cost"],
        realCost: json["realCost"] ?? 0,
        order: json['order'] == null ? null : OrderModel.fromJson(json['order']),
        status: SubOrderStatus.values.byName(json["status"] ?? SubOrderStatus.waiting.name),
        acceptedAt: DateTime.tryParse(json["acceptedAt"] ?? ''),
        arrivedAt: DateTime.tryParse(json["arrivedAt"] ?? ''),
        deliveredAt: DateTime.tryParse(json["deliveredAt"] ?? ''),
        driverAssignedAt: DateTime.tryParse(json["driverAssignedAt"] ?? ''),
        pickedUpAt: DateTime.tryParse(json["pickedUpAt"] ?? ''),
        carModel: json['car'] == null ? null : CarModel.fromJson(json['car']),
        photos: List<OrderPhotosModel>.from(json["photos"].map((x) => OrderPhotosModel.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "rating": rating,
        "note": note,
        "weight": weight,
        "cost": cost,
        "realCost": realCost,
        "status": status,
        "acceptedAt": acceptedAt?.toIso8601String(),
        "arrivedAt": arrivedAt?.toIso8601String(),
        "deliveredAt": deliveredAt?.toIso8601String(),
        "driverAssignedAt": driverAssignedAt?.toIso8601String(),
        "pickedUpAt": pickedUpAt?.toIso8601String(),
        "photos": List<dynamic>.from(photos.map((x) => x.toJson())),
      };
}
