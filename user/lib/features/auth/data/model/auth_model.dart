import 'package:naqla/features/auth/data/model/user_model.dart';

class AuthModel {
  final String? token;
  final User user;

  AuthModel({
    this.token,
    required this.user,
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
        "user": user.toJson(),
      };
}
