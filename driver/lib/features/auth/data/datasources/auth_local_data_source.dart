import 'package:injectable/injectable.dart';
import 'package:naqla_driver/core/di/di_container.dart';
import 'package:naqla_driver/features/app/domain/repository/prefs_repository.dart';
import 'package:naqla_driver/features/auth/data/model/login_model.dart';

@injectable
class AuthLocaleDataSource {
  Future<bool> cachedDriverInfo(LoginModel loginModel) async {
    await getIt<PrefsRepository>().setDriver(loginModel.driver);
    return await getIt<PrefsRepository>().setToken(loginModel.token);
  }
}
