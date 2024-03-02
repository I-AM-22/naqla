class AuthModel {
  final String? token;
  final User? user;

  AuthModel({
    this.token,
    this.user,
  });

  AuthModel copyWith({
    String? token,
    User? user,
  }) =>
      AuthModel(
        token: token ?? this.token,
        user: user ?? this.user,
      );

  factory AuthModel.fromJson(Map<String, dynamic> json) => AuthModel(
        token: json["token"],
        user: User.fromJson(json["user"]),
      );

  Map<String, dynamic> toJson() => {
        "token": token,
        "user": user?.toJson(),
      };
}

class User {
  final String id;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String firstName;
  final String lastName;
  final String phone;
  final Wallet wallet;
  final Photo photo;

  User({
    required this.id,
    required this.createdAt,
    required this.updatedAt,
    required this.firstName,
    required this.lastName,
    required this.phone,
    required this.wallet,
    required this.photo,
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
        wallet: wallet ?? this.wallet,
        photo: photo ?? this.photo,
      );

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        firstName: json["firstName"],
        lastName: json["lastName"],
        phone: json["phone"],
        wallet: Wallet.fromJson(json["wallet"]),
        photo: Photo.fromJson(json["photo"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "firstName": firstName,
        "lastName": lastName,
        "phone": phone,
        "wallet": wallet.toJson(),
        "photo": photo.toJson(),
      };
}

class Photo {
  final String id;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String blurHash;
  final String profileUrl;
  final String mobileUrl;
  final String webUrl;

  Photo({
    required this.id,
    required this.createdAt,
    required this.updatedAt,
    required this.blurHash,
    required this.profileUrl,
    required this.mobileUrl,
    required this.webUrl,
  });

  Photo copyWith({
    String? id,
    DateTime? createdAt,
    DateTime? updatedAt,
    String? blurHash,
    String? profileUrl,
    String? mobileUrl,
    String? webUrl,
  }) =>
      Photo(
        id: id ?? this.id,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        blurHash: blurHash ?? this.blurHash,
        profileUrl: profileUrl ?? this.profileUrl,
        mobileUrl: mobileUrl ?? this.mobileUrl,
        webUrl: webUrl ?? this.webUrl,
      );

  factory Photo.fromJson(Map<String, dynamic> json) => Photo(
        id: json["id"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        blurHash: json["blurHash"],
        profileUrl: json["profileUrl"],
        mobileUrl: json["mobileUrl"],
        webUrl: json["webUrl"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "blurHash": blurHash,
        "profileUrl": profileUrl,
        "mobileUrl": mobileUrl,
        "webUrl": webUrl,
      };
}

class Wallet {
  final String id;
  final int total;
  final int pending;
  final int available;

  Wallet({
    required this.id,
    required this.total,
    required this.pending,
    required this.available,
  });

  Wallet copyWith({
    String? id,
    int? total,
    int? pending,
    int? available,
  }) =>
      Wallet(
        id: id ?? this.id,
        total: total ?? this.total,
        pending: pending ?? this.pending,
        available: available ?? this.available,
      );

  factory Wallet.fromJson(Map<String, dynamic> json) => Wallet(
        id: json["id"],
        total: json["total"],
        pending: json["pending"],
        available: json["available"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "total": total,
        "pending": pending,
        "available": available,
      };
}
