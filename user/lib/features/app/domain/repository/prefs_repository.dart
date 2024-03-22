import '../../../auth/data/model/user_model.dart';

abstract class PrefsRepository {
  String? get token;
  Future<bool> setToken(String token);
  //Future<bool> setTheme(ThemeMode themeMode);
  // ThemeMode get getTheme;
  Future<bool> clearUser();
  bool get registeredUser;
  User? get user;
  Future<bool> setUser(User user);
}
