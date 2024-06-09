import 'dart:convert';

import 'package:injectable/injectable.dart';
import 'package:naqla_driver/features/auth/data/model/driver_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/common/constants/configuration/prefs_key.dart';
import '../../domain/repository/prefs_repository.dart';

@Injectable(as: PrefsRepository)
class PrefsRepositoryImpl extends PrefsRepository {
  final SharedPreferences sharedPreferences;

  PrefsRepositoryImpl({required this.sharedPreferences});
  @override
  Future<bool> clearUser() async {
    return (await Future.wait([sharedPreferences.remove(PrefsKey.token), sharedPreferences.remove(PrefsKey.driver), sharedPreferences.clear()]))
        .reduce((value, element) => value && element);
  }

  @override
  bool get registeredUser => token != null;

  @override
  Future<bool> setToken(String token) => sharedPreferences.setString(PrefsKey.token, token);

  @override
  String? get token => sharedPreferences.getString(PrefsKey.token);

  @override
  DriverModel? get driver {
    final result = sharedPreferences.getString(PrefsKey.driver);
    return DriverModel.fromJson(json.decode(result ?? ''));
  }

  @override
  Future<bool> setDriver(DriverModel driverModel) {
    return sharedPreferences.setString(PrefsKey.driver, json.encode(driverModel.toJson()));
  }
}
