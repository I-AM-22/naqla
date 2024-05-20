// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:dio/dio.dart' as _i3;
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;
import 'package:internet_connection_checker/internet_connection_checker.dart'
    as _i11;
import 'package:logger/logger.dart' as _i5;
import 'package:shared_preferences/shared_preferences.dart' as _i6;

import '../../features/app/data/prefs_repository_imp.dart' as _i9;
import '../../features/app/domain/repository/prefs_repository.dart' as _i8;
import '../../features/app/presentation/bloc/app_bloc.dart' as _i7;
import '../../features/auth/data/datasources/auth_local_data_source.dart'
    as _i4;
import '../../features/auth/data/datasources/auth_remote_data_source.dart'
    as _i12;
import '../../features/auth/data/repositories/auth_repository_implement.dart'
    as _i14;
import '../../features/auth/domain/repositories/auth_repository.dart' as _i13;
import '../../features/auth/domain/usecases/login_use_case.dart' as _i15;
import '../../features/auth/domain/usecases/signup_use_case.dart' as _i16;
import '../../features/auth/domain/usecases/verification_phone_number_use_case.dart'
    as _i17;
import '../../features/auth/presentation/state/auth_bloc.dart' as _i18;
import '../network_info.dart' as _i10;
import 'di_container.dart' as _i19;

// initializes the registration of main-scope dependencies inside of GetIt
Future<_i1.GetIt> $initGetIt(
  _i1.GetIt getIt, {
  String? environment,
  _i2.EnvironmentFilter? environmentFilter,
}) async {
  final gh = _i2.GetItHelper(
    getIt,
    environment,
    environmentFilter,
  );
  final appModule = _$AppModule();
  gh.factory<_i3.BaseOptions>(() => appModule.dioOption);
  gh.factory<_i4.AuthLocaleDataSource>(() => _i4.AuthLocaleDataSource());
  gh.singleton<_i5.Logger>(() => appModule.logger);
  await gh.singletonAsync<_i6.SharedPreferences>(
    () => appModule.sharedPreferences,
    preResolve: true,
  );
  gh.lazySingleton<_i7.AppCubit>(() => _i7.AppCubit());
  gh.factory<_i8.PrefsRepository>(() =>
      _i9.PrefsRepositoryImpl(sharedPreferences: gh<_i6.SharedPreferences>()));
  gh.lazySingleton<_i3.Dio>(() => appModule.dio(
        gh<_i3.BaseOptions>(),
        gh<_i5.Logger>(),
      ));
  gh.factory<_i10.NetworkInfo>(
      () => _i10.NetworkInfoImplement(gh<_i11.InternetConnectionChecker>()));
  gh.factory<_i12.AuthRemoteDataSource>(
      () => _i12.AuthRemoteDataSource(gh<_i3.Dio>()));
  gh.factory<_i13.AuthRepository>(() => _i14.AuthRepositoryImplement(
        gh<_i12.AuthRemoteDataSource>(),
        gh<_i4.AuthLocaleDataSource>(),
      ));
  gh.factory<_i15.LoginUseCase>(
      () => _i15.LoginUseCase(gh<_i13.AuthRepository>()));
  gh.factory<_i16.SignUpUseCase>(
      () => _i16.SignUpUseCase(gh<_i13.AuthRepository>()));
  gh.factory<_i17.VerificationPhoneNumberUseCase>(
      () => _i17.VerificationPhoneNumberUseCase(gh<_i13.AuthRepository>()));
  gh.factory<_i18.AuthBloc>(() => _i18.AuthBloc(
        gh<_i15.LoginUseCase>(),
        gh<_i16.SignUpUseCase>(),
        gh<_i17.VerificationPhoneNumberUseCase>(),
      ));
  return getIt;
}

class _$AppModule extends _i19.AppModule {}
