import 'package:naqla_driver/features/auth/data/model/driver_model.dart';

class LoginModel {
  final String token;
  final DriverModel driver;

  LoginModel({
    required this.token,
    required this.driver,
  });

  LoginModel copyWith({
    String? token,
    DriverModel? driver,
  }) =>
      LoginModel(
        token: token ?? this.token,
        driver: driver ?? this.driver,
      );

  factory LoginModel.fromJson(Map<String, dynamic> json) => LoginModel(
        token: json["token"],
        driver: DriverModel.fromJson(json["driver"]),
      );

  Map<String, dynamic> toJson() => {
        "token": token,
        "driver": driver.toJson(),
      };
}
