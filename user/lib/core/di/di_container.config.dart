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
    as _i7;
import 'package:logger/logger.dart' as _i5;
import 'package:shared_preferences/shared_preferences.dart' as _i8;

import '../../features/app/data/prefs_repository_imp.dart' as _i13;
import '../../features/app/domain/repository/prefs_repository.dart' as _i12;
import '../../features/app/presentation/bloc/app_bloc.dart' as _i3;
import '../../features/auth/data/data_sources/auth_remote_data_source.dart'
    as _i20;
import '../../features/auth/data/repositories/auth_repository_implement.dart'
    as _i22;
import '../../features/auth/domain/repositories/auth_repository.dart' as _i21;
import '../../features/auth/domain/use_cases/confirm_use_case.dart' as _i23;
import '../../features/auth/domain/use_cases/login_use_case.dart' as _i30;
import '../../features/auth/domain/use_cases/sign_up_use_case.dart' as _i32;
import '../../features/auth/presentation/state/bloc/auth_bloc.dart' as _i33;
import '../../features/home/data/data_source/home_remote_data_source.dart'
    as _i9;
import '../../features/home/data/repositories/home_repository_implement.dart'
    as _i11;
import '../../features/home/domain/repositories/home_repository.dart' as _i10;
import '../../features/home/domain/use_case/get_car_advantage_use_case.dart'
    as _i26;
import '../../features/home/domain/use_case/get_orders_use_case.dart' as _i27;
import '../../features/home/domain/use_case/upload_photos_use_case.dart'
    as _i18;
import '../../features/home/presentation/bloc/home_bloc.dart' as _i29;
import '../../features/profile/data/data_source/profile_remote_data_source.dart'
    as _i14;
import '../../features/profile/data/repositories/profile_repository_implement.dart'
    as _i16;
import '../../features/profile/domain/repositories/profile_repository.dart'
    as _i15;
import '../../features/profile/domain/use_cases/delete_account_use_case.dart'
    as _i24;
import '../../features/profile/domain/use_cases/edit_personal_info_use_case.dart'
    as _i25;
import '../../features/profile/domain/use_cases/get_personal_info_use_case.dart'
    as _i28;
import '../../features/profile/domain/use_cases/update_phone_number_use_case.dart'
    as _i17;
import '../../features/profile/domain/use_cases/upload_single_photo_use_case.dart'
    as _i19;
import '../../features/profile/presentation/state/bloc/profile_bloc.dart'
    as _i31;
import '../network_info.dart' as _i6;
import 'di_container.dart' as _i34;

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
  gh.singleton<_i5.Logger>(appModule.logger);
  gh.factory<_i6.NetworkInfo>(
      () => _i6.NetworkInfoImplement(gh<_i7.InternetConnectionChecker>()));
  await gh.singletonAsync<_i8.SharedPreferences>(
    () => appModule.sharedPreferences,
    preResolve: true,
  );
  gh.lazySingleton<_i4.Dio>(() => appModule.dio(
        gh<_i4.BaseOptions>(),
        gh<_i5.Logger>(),
      ));
  gh.factory<_i9.HomeRemoteDataSource>(
      () => _i9.HomeRemoteDataSource(gh<_i4.Dio>()));
  gh.factory<_i10.HomeRepository>(
      () => _i11.HomeRepositoryImplement(gh<_i9.HomeRemoteDataSource>()));
  gh.factory<_i12.PrefsRepository>(() =>
      _i13.PrefsRepositoryImpl(sharedPreferences: gh<_i8.SharedPreferences>()));
  gh.factory<_i14.ProfileRemoteDataSource>(
      () => _i14.ProfileRemoteDataSource(gh<_i4.Dio>()));
  gh.factory<_i15.ProfileRepository>(() =>
      _i16.ProfileRepositoryImplement(gh<_i14.ProfileRemoteDataSource>()));
  gh.factory<_i17.UpdatePhoneNumberUseCase>(
      () => _i17.UpdatePhoneNumberUseCase(gh<_i15.ProfileRepository>()));
  gh.factory<_i18.UploadPhotosUseCase>(
      () => _i18.UploadPhotosUseCase(gh<_i10.HomeRepository>()));
  gh.factory<_i19.UploadSinglePhotoUseCase>(
      () => _i19.UploadSinglePhotoUseCase(gh<_i15.ProfileRepository>()));
  gh.factory<_i20.AuthRemoteDataSource>(
      () => _i20.AuthRemoteDataSource(gh<_i4.Dio>()));
  gh.factory<_i21.AuthRepository>(
      () => _i22.AuthRepositoryImplement(gh<_i20.AuthRemoteDataSource>()));
  gh.factory<_i23.ConfirmUseCase>(
      () => _i23.ConfirmUseCase(gh<_i21.AuthRepository>()));
  gh.factory<_i24.DeleteAccountUseCase>(
      () => _i24.DeleteAccountUseCase(gh<_i15.ProfileRepository>()));
  gh.factory<_i25.EditPersonalInfoUseCase>(
      () => _i25.EditPersonalInfoUseCase(gh<_i15.ProfileRepository>()));
  gh.factory<_i26.GetCarAdvantageUseCase>(
      () => _i26.GetCarAdvantageUseCase(gh<_i10.HomeRepository>()));
  gh.factory<_i27.GetOrdersUseCase>(
      () => _i27.GetOrdersUseCase(gh<_i10.HomeRepository>()));
  gh.factory<_i28.GetPersonalInfoUseCase>(
      () => _i28.GetPersonalInfoUseCase(gh<_i15.ProfileRepository>()));
  gh.lazySingleton<_i29.HomeBloc>(() => _i29.HomeBloc(
        gh<_i18.UploadPhotosUseCase>(),
        gh<_i26.GetCarAdvantageUseCase>(),
        gh<_i27.GetOrdersUseCase>(),
      ));
  gh.factory<_i30.LoginUseCase>(
      () => _i30.LoginUseCase(gh<_i21.AuthRepository>()));
  gh.factory<_i31.ProfileBloc>(() => _i31.ProfileBloc(
        gh<_i28.GetPersonalInfoUseCase>(),
        gh<_i25.EditPersonalInfoUseCase>(),
        gh<_i19.UploadSinglePhotoUseCase>(),
        gh<_i17.UpdatePhoneNumberUseCase>(),
        gh<_i24.DeleteAccountUseCase>(),
      ));
  gh.factory<_i32.SignUpUseCase>(
      () => _i32.SignUpUseCase(gh<_i21.AuthRepository>()));
  gh.factory<_i33.AuthBloc>(() => _i33.AuthBloc(
        gh<_i30.LoginUseCase>(),
        gh<_i32.SignUpUseCase>(),
        gh<_i23.ConfirmUseCase>(),
      ));
  return getIt;
}

class _$AppModule extends _i34.AppModule {}
