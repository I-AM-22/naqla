import 'package:naqla/features/auth/data/model/photo_model.dart';
import 'package:naqla/features/auth/data/model/wallet_model.dart';

class User {
  final String id;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String firstName;
  final String lastName;
  final String phone;
  final Wallet? wallet;
  final Photo photo;

  User({
    required this.id,
    required this.createdAt,
    required this.updatedAt,
    required this.firstName,
    required this.lastName,
    required this.phone,
    required this.photo,
    required this.wallet,
  });

  User copyWith({
    String? id,
    DateTime? createdAt,
    DateTime? updatedAt,
    String? firstName,
    String? lastName,
    String? phone,
    Wallet? wallet,
    Photo? photo,
  }) =>
      User(
        id: id ?? this.id,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        firstName: firstName ?? this.firstName,
        lastName: lastName ?? this.lastName,
        phone: phone ?? this.phone,
        photo: photo ?? this.photo,
        wallet: wallet ?? this.wallet,
      );

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        firstName: json["firstName"],
        lastName: json["lastName"],
        phone: json["phone"],
        photo: Photo.fromJson(json["photo"]),
        wallet: json['wallet'] == null ? null : Wallet.fromJson(json['wallet']),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "firstName": firstName,
        "lastName": lastName,
        "phone": phone,
        "photo": photo.toJson(),
      };
}
