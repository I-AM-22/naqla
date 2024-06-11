import 'package:naqla_driver/features/auth/data/model/photo_model.dart';

import 'order_model.dart';

class SubOrderModel {
  final String id;
  final int weight;
  final int cost;
  final OrderModel order;
  final List<PhotoModel> photos;

  SubOrderModel({
    required this.id,
    required this.weight,
    required this.cost,
    required this.order,
    required this.photos,
  });

  SubOrderModel copyWith({
    String? id,
    int? weight,
    int? cost,
    OrderModel? order,
    List<PhotoModel>? photos,
  }) =>
      SubOrderModel(
        id: id ?? this.id,
        weight: weight ?? this.weight,
        cost: cost ?? this.cost,
        order: order ?? this.order,
        photos: photos ?? this.photos,
      );

  factory SubOrderModel.fromJson(Map<String, dynamic> json) => SubOrderModel(
        id: json["id"],
        weight: json["weight"],
        cost: json["cost"],
        order: OrderModel.fromJson(json["order"]),
        photos: List<PhotoModel>.from(json["photos"].map((x) => PhotoModel.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "weight": weight,
        "cost": cost,
        "order": order.toJson(),
        "photos": List<PhotoModel>.from(photos.map((x) => x.toJson)),
      };
}
