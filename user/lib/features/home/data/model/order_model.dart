import 'package:naqla/core/common/enums/order_status.dart';
import 'package:naqla/features/home/data/model/location_model.dart';
import 'package:naqla/features/home/data/model/order_photos_model.dart';
import 'package:naqla/features/home/data/model/payment_model.dart';
import 'package:naqla/features/orders/data/model/sub_order_model.dart';

class OrderModel {
  final String id;
  final DateTime createdAt;
  final DateTime desiredDate;
  final OrderStatus status;
  final int? porters;
  final LocationModel? locationStart;
  final LocationModel? locationEnd;
  final List<String>? advantages;
  final List<OrderPhotosModel> photos;
  List<SubOrderModel>? subOrders;
  final PaymentModel? paymentModel;
  final String? userName;

  OrderModel({
    required this.id,
    required this.createdAt,
    required this.desiredDate,
    required this.status,
    required this.locationStart,
    required this.locationEnd,
    required this.advantages,
    required this.photos,
    required this.porters,
    required this.paymentModel,
    required this.userName,
    required this.subOrders,
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
    List<SubOrderModel>? subOrders,
    int? porters,
    PaymentModel? paymentModel,
    String? userName,
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
        porters: porters ?? this.porters,
        subOrders: subOrders ?? this.subOrders,
        userName: userName ?? this.userName,
      );

  factory OrderModel.fromJson(Map<String, dynamic> json) => OrderModel(
        id: json["id"],
        desiredDate: json['desiredDate'] == null ? DateTime.now() : DateTime.parse(json['desiredDate']),
        createdAt: json['createdAt'] == null ? DateTime.now() : DateTime.parse(json['createdAt']),
        status: OrderStatus.values.byName(json["status"] ?? OrderStatus.waiting.name),
        locationStart: json["locationStart"] == null ? null : LocationModel.fromJson(json["locationStart"]),
        locationEnd: json["locationEnd"] == null ? null : LocationModel.fromJson(json["locationEnd"]),
        porters: json['porters'],
        subOrders: json["subOrders"] == null ? null : List<SubOrderModel>.from(json["subOrders"].map((x) => SubOrderModel.fromJson(x))),
        advantages: json["advantages"] == null ? null : List<String>.from(json["advantages"].map((x) => x['name'])),
        photos: json["photos"] == null ? [] : List<OrderPhotosModel>.from(json["photos"].map((x) => OrderPhotosModel.fromJson(x))),
        paymentModel: json["payment"] == null ? null : PaymentModel.fromJson(json["payment"]),
        userName: json['user'] == null ? null : "${json["user"]["firstName"]} ${json["user"]["lastName"]}",
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "status": status,
        "locationStart": locationStart?.toJson(),
        "locationEnd": locationEnd?.toJson(),
        "advantages": List<dynamic>.from(advantages?.map((x) => x) ?? []),
        "photos": List<dynamic>.from(photos.map((x) => x.toJson())),
        "createdAt": createdAt.toIso8601String(),
        "desiredDate": desiredDate.toIso8601String(),
        "payment": paymentModel?.toJson(),
      };
}
