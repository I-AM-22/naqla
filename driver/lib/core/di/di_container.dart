import 'dart:io';

import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:logger/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../features/app/domain/repository/prefs_repository.dart';
import '../../features/auth/presentation/pages/login_page.dart';
import '../../features/home/presentation/state/home_bloc.dart';
import '../../features/profile/presentation/state/profile_bloc.dart';
import '../api/log_interceptor.dart';
import '../common/constants/configuration/api_routes.dart';
import '../common/enums/status_code_type.dart';
import '../config/router/router.dart';
import 'di_container.config.dart';

final getIt = GetIt.I;

@InjectableInit(
  initializerName: r'$initGetIt',
  preferRelativeImports: true,
  asExtension: false,
)
Future<GetIt> configureDependencies() async => $initGetIt(getIt);

@module
abstract class AppModule {
  BaseOptions get dioOption => BaseOptions(
      baseUrl: ApiRoutes.baseUrl,
      connectTimeout: const Duration(seconds: 60),
      receiveTimeout: const Duration(seconds: 60),
      sendTimeout: const Duration(seconds: 60),
      headers: <String, String>{HttpHeaders.acceptHeader: 'application/json'});

  @lazySingleton
  Logger get logger => Logger();

  @lazySingleton
  Dio dio(BaseOptions options, Logger logger) {
    final dio = Dio(options);
    dio.interceptors.addAll([
      DioLogInterceptor(),
      InterceptorsWrapper(
        onError: (error, handler) async {
          if (error.response?.statusCode == StatusCode.unAuthorized.code && getIt<PrefsRepository>().registeredUser) {
            await getIt<PrefsRepository>().clearUser();
            await getIt.resetLazySingleton<HomeBloc>();
            await getIt.resetLazySingleton<ProfileBloc>();
            GRouter.router.goNamed(SignInPage.name);
          }
          handler.next(error);
        },
      )
    ]);
    return dio;
  }

  @preResolve
  @singleton
  Future<SharedPreferences> get sharedPreferences => SharedPreferences.getInstance();
}
