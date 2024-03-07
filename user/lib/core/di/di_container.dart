import 'dart:io';

import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:logger/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../api/log_interceptor.dart';
import '../common/constants/configuration/api_routes.dart';
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
      connectTimeout: const Duration(seconds: 20),
      receiveTimeout: const Duration(seconds: 20),
      headers: <String, String>{HttpHeaders.acceptHeader: 'application/json'});

  @singleton
  Logger get logger => Logger();

  @lazySingleton
  Dio dio(BaseOptions options, Logger logger) {
    final dio = Dio(options);
    dio.interceptors.addAll([LoggerInterceptor()]);
    return dio;
  }

  @preResolve
  @singleton
  Future<SharedPreferences> get sharedPreferences =>
      SharedPreferences.getInstance();
}
