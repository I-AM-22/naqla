// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:dio/dio.dart' as _i4;
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;
import 'package:internet_connection_checker/internet_connection_checker.dart'
    as _i8;
import 'package:logger/logger.dart' as _i6;
import 'package:shared_preferences/shared_preferences.dart' as _i9;

import '../../features/app/data/prefs_repository_imp.dart' as _i11;
import '../../features/app/domain/repository/prefs_repository.dart' as _i10;
import '../../features/app/presentation/bloc/app_bloc.dart' as _i3;
import '../../features/auth/data/data_sources/auth_remote_data_source.dart'
    as _i16;
import '../../features/auth/data/repositories/auth_repository_implement.dart'
    as _i18;
import '../../features/auth/domain/repositories/auth_repository.dart' as _i17;
import '../../features/auth/domain/use_cases/confirm_use_case.dart' as _i19;
import '../../features/auth/domain/use_cases/login_use_case.dart' as _i22;
import '../../features/auth/domain/use_cases/sign_up_use_case.dart' as _i24;
import '../../features/auth/presentation/state/bloc/auth_bloc.dart' as _i25;
import '../../features/home/presentation/bloc/home_bloc.dart' as _i5;
import '../../features/profile/data/data_source/profile_remote_data_source.dart'
    as _i12;
import '../../features/profile/data/repositories/profile_repository_implement.dart'
    as _i14;
import '../../features/profile/domain/repositories/profile_repository.dart'
    as _i13;
import '../../features/profile/domain/use_cases/edit_personal_info_use_case.dart'
    as _i20;
import '../../features/profile/domain/use_cases/get_personal_info_use_case.dart'
    as _i21;
import '../../features/profile/domain/use_cases/upload_single_photo_use_case.dart'
    as _i15;
import '../../features/profile/presentation/state/bloc/profile_bloc.dart'
    as _i23;
import '../network_info.dart' as _i7;
import 'di_container.dart' as _i26;

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
  gh.lazySingleton<_i3.AppCubit>(() => _i3.AppCubit());
  gh.factory<_i4.BaseOptions>(() => appModule.dioOption);
  gh.lazySingleton<_i5.HomeBloc>(() => _i5.HomeBloc());
  gh.singleton<_i6.Logger>(appModule.logger);
  gh.factory<_i7.NetworkInfo>(
      () => _i7.NetworkInfoImplement(gh<_i8.InternetConnectionChecker>()));
  await gh.singletonAsync<_i9.SharedPreferences>(
    () => appModule.sharedPreferences,
    preResolve: true,
  );
  gh.lazySingleton<_i4.Dio>(() => appModule.dio(
        gh<_i4.BaseOptions>(),
        gh<_i6.Logger>(),
      ));
  gh.factory<_i10.PrefsRepository>(() =>
      _i11.PrefsRepositoryImpl(sharedPreferences: gh<_i9.SharedPreferences>()));
  gh.factory<_i12.ProfileRemoteDataSource>(
      () => _i12.ProfileRemoteDataSource(gh<_i4.Dio>()));
  gh.factory<_i13.ProfileRepository>(() =>
      _i14.ProfileRepositoryImplement(gh<_i12.ProfileRemoteDataSource>()));
  gh.factory<_i15.UploadSinglePhotoUseCase>(
      () => _i15.UploadSinglePhotoUseCase(gh<_i13.ProfileRepository>()));
  gh.factory<_i16.AuthRemoteDataSource>(
      () => _i16.AuthRemoteDataSource(gh<_i4.Dio>()));
  gh.factory<_i17.AuthRepository>(
      () => _i18.AuthRepositoryImplement(gh<_i16.AuthRemoteDataSource>()));
  gh.factory<_i19.ConfirmUseCase>(
      () => _i19.ConfirmUseCase(gh<_i17.AuthRepository>()));
  gh.factory<_i20.EditPersonalInfoUseCase>(
      () => _i20.EditPersonalInfoUseCase(gh<_i13.ProfileRepository>()));
  gh.factory<_i21.GetPersonalInfoUseCase>(
      () => _i21.GetPersonalInfoUseCase(gh<_i13.ProfileRepository>()));
  gh.factory<_i22.LoginUseCase>(
      () => _i22.LoginUseCase(gh<_i17.AuthRepository>()));
  gh.factory<_i23.ProfileBloc>(() => _i23.ProfileBloc(
        gh<_i21.GetPersonalInfoUseCase>(),
        gh<_i20.EditPersonalInfoUseCase>(),
        gh<_i15.UploadSinglePhotoUseCase>(),
      ));
  gh.factory<_i24.SignUpUseCase>(
      () => _i24.SignUpUseCase(gh<_i17.AuthRepository>()));
  gh.factory<_i25.AuthBloc>(() => _i25.AuthBloc(
        gh<_i22.LoginUseCase>(),
        gh<_i24.SignUpUseCase>(),
        gh<_i19.ConfirmUseCase>(),
      ));
  return getIt;
}

class _$AppModule extends _i26.AppModule {}
