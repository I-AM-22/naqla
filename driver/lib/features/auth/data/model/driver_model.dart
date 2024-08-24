import 'package:naqla_driver/features/auth/data/model/photo_model.dart';
import 'package:naqla_driver/features/auth/data/model/wallet_model.dart';

class DriverModel {
  final String id;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String firstName;
  final String lastName;
  final String? phone;
  final WalletModel wallet;
  final PhotoModel? photo;

  DriverModel({
    required this.id,
    required this.createdAt,
    required this.updatedAt,
    required this.firstName,
    required this.lastName,
    required this.phone,
    required this.wallet,
    required this.photo,
  });

  DriverModel copyWith({
    String? id,
    DateTime? createdAt,
    DateTime? updatedAt,
    String? firstName,
    String? lastName,
    String? phone,
    WalletModel? wallet,
    PhotoModel? photo,
  }) =>
      DriverModel(
        id: id ?? this.id,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        firstName: firstName ?? this.firstName,
        lastName: lastName ?? this.lastName,
        phone: phone ?? this.phone,
        wallet: wallet ?? this.wallet,
        photo: photo ?? this.photo,
      );

  factory DriverModel.fromJson(Map<String, dynamic> json) => DriverModel(
        id: json["id"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        firstName: json["firstName"],
        lastName: json["lastName"],
        phone: json["phone"],
        wallet: WalletModel.fromJson(json["wallet"]),
        photo: json["photo"] == null ? null : PhotoModel.fromJson(json["photo"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "firstName": firstName,
        "lastName": lastName,
        "phone": phone,
        "wallet": wallet.toJson(),
        "photo": photo?.toJson,
      };
}
