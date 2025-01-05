import 'dart:io';

import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:logger/logger.dart';
import 'package:naqla/features/app/domain/repository/prefs_repository.dart';
import 'package:naqla/features/auth/presentation/pages/welcome_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../features/home/presentation/bloc/home_bloc.dart';
import '../../features/orders/presentation/state/order_bloc.dart';
import '../../features/profile/presentation/state/bloc/profile_bloc.dart';
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
      connectTimeout: const Duration(seconds: 120),
      receiveTimeout: const Duration(seconds: 120),
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
            await getIt.resetLazySingleton<OrderBloc>();
            await getIt.resetLazySingleton<ProfileBloc>();
            router.goNamed(WelcomePage.name);
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
