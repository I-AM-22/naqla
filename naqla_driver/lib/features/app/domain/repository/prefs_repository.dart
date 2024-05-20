import 'package:naqla_driver/features/auth/data/model/driver_model.dart';

abstract class PrefsRepository {
  String? get token;
  Future<bool> setToken(String token);
  Future<bool> clearUser();
  bool get registeredUser;
  DriverModel? get driver;
  Future<bool> setDriver(DriverModel driverModel);
}
