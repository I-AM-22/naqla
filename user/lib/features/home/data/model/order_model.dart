import 'package:naqla/core/common/enums/order_status.dart';
import 'package:naqla/features/home/data/model/location_model.dart';
import 'package:naqla/features/home/data/model/order_photos_model.dart';
import 'package:naqla/features/home/data/model/payment_model.dart';

class OrderModel {
  final String id;
  final DateTime createdAt;
  final DateTime desiredDate;
  final OrderStatus status;
  final LocationModel locationStart;
  final LocationModel locationEnd;
  final List<String> advantages;
  final List<OrderPhotosModel> photos;
  final PaymentModel paymentModel;

  OrderModel({
    required this.id,
    required this.createdAt,
    required this.desiredDate,
    required this.status,
    required this.locationStart,
    required this.locationEnd,
    required this.advantages,
    required this.photos,
    required this.paymentModel,
  });

  OrderModel copyWith({
    String? id,
    DateTime? createdAt,
    DateTime? desiredDate,
    OrderStatus? status,
    LocationModel? locationStart,
    LocationModel? locationEnd,
    List<String>? advantages,
    List<OrderPhotosModel>? photos,
    PaymentModel? paymentModel,
  }) =>
      OrderModel(
        id: id ?? this.id,
        createdAt: createdAt ?? this.createdAt,
        desiredDate: desiredDate ?? this.desiredDate,
        status: status ?? this.status,
        locationStart: locationStart ?? this.locationStart,
        locationEnd: locationEnd ?? this.locationEnd,
        advantages: advantages ?? this.advantages,
        photos: photos ?? this.photos,
        paymentModel: paymentModel ?? this.paymentModel,
      );

  factory OrderModel.fromJson(Map<String, dynamic> json) => OrderModel(
        id: json["id"],
        desiredDate: json['desiredDate'] == null ? DateTime.now() : DateTime.parse(json['desiredDate']),
        createdAt: json['createdAt'] == null ? DateTime.now() : DateTime.parse(json['createdAt']),
        status: OrderStatus.values.byName(json["status"]),
        locationStart: LocationModel.fromJson(json["locationStart"]),
        locationEnd: LocationModel.fromJson(json["locationEnd"]),
        advantages: List<String>.from(json["advantages"].map((x) => x['name'])),
        photos: List<OrderPhotosModel>.from(json["photos"].map((x) => OrderPhotosModel.fromJson(x))),
        paymentModel: PaymentModel.fromJson(json["payment"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "status": status,
        "locationStart": locationStart.toJson(),
        "locationEnd": locationEnd.toJson(),
        "advantages": List<dynamic>.from(advantages.map((x) => x)),
        "photos": List<dynamic>.from(photos.map((x) => x.toJson())),
        "createdAt": createdAt.toIso8601String(),
        "desiredDate": desiredDate.toIso8601String(),
        "payment": paymentModel.toJson(),
      };
}
