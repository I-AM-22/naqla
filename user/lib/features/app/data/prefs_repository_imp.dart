import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:user/core/common/constants/configuration/prefs_key.dart';
import 'package:user/features/app/domain/repository/prefs_repository.dart';

@Injectable(as: PrefsRepository)
class PrefsRepositoryImpl extends PrefsRepository {
  final SharedPreferences sharedPreferences;

  PrefsRepositoryImpl({required this.sharedPreferences});
  @override
  Future<bool> clearUser() async {
    return (await Future.wait([
      sharedPreferences.remove(PrefsKey.token),
      sharedPreferences.remove(PrefsKey.user),
      sharedPreferences.clear()
    ]))
        .reduce((value, element) => value && element);
  }

  // @override
  // ThemeMode get getTheme {
  //   final res = sharedPreferences.getString(PrefsKey.theme);
  //   if (res == null) {
  //     setTheme(ThemeMode.light);
  //     return ThemeMode.light;
  //   }
  //   return mapAppThemeMode[res]!;
  // }

  @override
  bool get registeredUser => token != null;
  //
  // @override
  // Future<bool> setTheme(ThemeMode themeMode) =>
  //     sharedPreferences.setString(PrefsKey.theme, themeMode.name);

  @override
  Future<bool> setToken(String token) =>
      sharedPreferences.setString(PrefsKey.token, token);

  // @override
  // Future<bool> setUser(UserModel user) =>
  //     sharedPreferences.setString(PrefsKey.user, jsonEncode(user.toJson()));

  @override
  String? get token => sharedPreferences.getString(PrefsKey.token);

  // @override
  // UserModel? get user {
  //   final user = sharedPreferences.getString(PrefsKey.user);
  //   if (user == null) return null;
  //
  //   return UserModel.fromJson(json.decode(user));
  // }
}
