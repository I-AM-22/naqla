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
import 'package:logger/logger.dart' as _i5;
import 'package:shared_preferences/shared_preferences.dart' as _i6;

import '../../features/app/data/datasources/app_remote_data_source.dart'
    as _i20;
import '../../features/app/data/repositories/app_repository_implement.dart'
    as _i22;
import '../../features/app/data/repositories/prefs_repository_imp.dart' as _i11;
import '../../features/app/domain/repository/app_repository.dart' as _i21;
import '../../features/app/domain/repository/prefs_repository.dart' as _i10;
import '../../features/app/domain/usecases/upload_image_use_case.dart' as _i36;
import '../../features/app/presentation/state/bloc/app_bloc.dart' as _i3;
import '../../features/app/presentation/state/upload_image_cubit.dart' as _i38;
import '../../features/auth/data/data_sources/auth_remote_data_source.dart'
    as _i23;
import '../../features/auth/data/repositories/auth_repository_implement.dart'
    as _i25;
import '../../features/auth/domain/repositories/auth_repository.dart' as _i24;
import '../../features/auth/domain/use_cases/confirm_use_case.dart' as _i26;
import '../../features/auth/domain/use_cases/login_use_case.dart' as _i33;
import '../../features/auth/domain/use_cases/sign_up_use_case.dart' as _i35;
import '../../features/auth/presentation/state/bloc/auth_bloc.dart' as _i37;
import '../../features/home/data/data_source/home_remote_data_source.dart'
    as _i7;
import '../../features/home/data/repositories/home_repository_implement.dart'
    as _i9;
import '../../features/home/domain/repositories/home_repository.dart' as _i8;
import '../../features/home/domain/use_case/accept_order_use_case.dart' as _i19;
import '../../features/home/domain/use_case/get_car_advantage_use_case.dart'
    as _i29;
import '../../features/home/domain/use_case/get_orders_use_case.dart' as _i30;
import '../../features/home/domain/use_case/set_order_use_case.dart' as _i15;
import '../../features/home/domain/use_case/upload_photos_use_case.dart'
    as _i17;
import '../../features/home/presentation/bloc/home_bloc.dart' as _i32;
import '../../features/profile/data/data_source/profile_remote_data_source.dart'
    as _i12;
import '../../features/profile/data/repositories/profile_repository_implement.dart'
    as _i14;
import '../../features/profile/domain/repositories/profile_repository.dart'
    as _i13;
import '../../features/profile/domain/use_cases/delete_account_use_case.dart'
    as _i27;
import '../../features/profile/domain/use_cases/edit_personal_info_use_case.dart'
    as _i28;
import '../../features/profile/domain/use_cases/get_personal_info_use_case.dart'
    as _i31;
import '../../features/profile/domain/use_cases/update_phone_number_use_case.dart'
    as _i16;
import '../../features/profile/domain/use_cases/upload_single_photo_use_case.dart'
    as _i18;
import '../../features/profile/presentation/state/bloc/profile_bloc.dart'
    as _i34;
import 'di_container.dart' as _i39;

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
  gh.lazySingleton<_i5.Logger>(() => appModule.logger);
  await gh.singletonAsync<_i6.SharedPreferences>(
    () => appModule.sharedPreferences,
    preResolve: true,
  );
  gh.lazySingleton<_i4.Dio>(() => appModule.dio(
        gh<_i4.BaseOptions>(),
        gh<_i5.Logger>(),
      ));
  gh.factory<_i7.HomeRemoteDataSource>(
      () => _i7.HomeRemoteDataSource(gh<_i4.Dio>()));
  gh.factory<_i8.HomeRepository>(
      () => _i9.HomeRepositoryImplement(gh<_i7.HomeRemoteDataSource>()));
  gh.factory<_i10.PrefsRepository>(() =>
      _i11.PrefsRepositoryImpl(sharedPreferences: gh<_i6.SharedPreferences>()));
  gh.factory<_i12.ProfileRemoteDataSource>(
      () => _i12.ProfileRemoteDataSource(gh<_i4.Dio>()));
  gh.factory<_i13.ProfileRepository>(() =>
      _i14.ProfileRepositoryImplement(gh<_i12.ProfileRemoteDataSource>()));
  gh.factory<_i15.SetOrderUseCase>(
      () => _i15.SetOrderUseCase(gh<_i8.HomeRepository>()));
  gh.factory<_i16.UpdatePhoneNumberUseCase>(
      () => _i16.UpdatePhoneNumberUseCase(gh<_i13.ProfileRepository>()));
  gh.factory<_i17.UploadPhotosUseCase>(
      () => _i17.UploadPhotosUseCase(gh<_i8.HomeRepository>()));
  gh.factory<_i18.UploadSinglePhotoUseCase>(
      () => _i18.UploadSinglePhotoUseCase(gh<_i13.ProfileRepository>()));
  gh.factory<_i19.AcceptOrderUseCase>(
      () => _i19.AcceptOrderUseCase(gh<_i8.HomeRepository>()));
  gh.factory<_i20.AppRemoteDataSource>(
      () => _i20.AppRemoteDataSource(gh<_i4.Dio>()));
  gh.factory<_i21.AppRepository>(
      () => _i22.AppRepositoryImplement(gh<_i20.AppRemoteDataSource>()));
  gh.factory<_i23.AuthRemoteDataSource>(
      () => _i23.AuthRemoteDataSource(gh<_i4.Dio>()));
  gh.factory<_i24.AuthRepository>(
      () => _i25.AuthRepositoryImplement(gh<_i23.AuthRemoteDataSource>()));
  gh.factory<_i26.ConfirmUseCase>(
      () => _i26.ConfirmUseCase(gh<_i24.AuthRepository>()));
  gh.factory<_i27.DeleteAccountUseCase>(
      () => _i27.DeleteAccountUseCase(gh<_i13.ProfileRepository>()));
  gh.factory<_i28.EditPersonalInfoUseCase>(
      () => _i28.EditPersonalInfoUseCase(gh<_i13.ProfileRepository>()));
  gh.factory<_i29.GetCarAdvantageUseCase>(
      () => _i29.GetCarAdvantageUseCase(gh<_i8.HomeRepository>()));
  gh.factory<_i30.GetOrdersUseCase>(
      () => _i30.GetOrdersUseCase(gh<_i8.HomeRepository>()));
  gh.factory<_i31.GetPersonalInfoUseCase>(
      () => _i31.GetPersonalInfoUseCase(gh<_i13.ProfileRepository>()));
  gh.lazySingleton<_i32.HomeBloc>(() => _i32.HomeBloc(
        gh<_i17.UploadPhotosUseCase>(),
        gh<_i29.GetCarAdvantageUseCase>(),
        gh<_i30.GetOrdersUseCase>(),
        gh<_i15.SetOrderUseCase>(),
        gh<_i19.AcceptOrderUseCase>(),
      ));
  gh.factory<_i33.LoginUseCase>(
      () => _i33.LoginUseCase(gh<_i24.AuthRepository>()));
  gh.factory<_i34.ProfileBloc>(() => _i34.ProfileBloc(
        gh<_i31.GetPersonalInfoUseCase>(),
        gh<_i28.EditPersonalInfoUseCase>(),
        gh<_i18.UploadSinglePhotoUseCase>(),
        gh<_i16.UpdatePhoneNumberUseCase>(),
        gh<_i27.DeleteAccountUseCase>(),
      ));
  gh.factory<_i35.SignUpUseCase>(
      () => _i35.SignUpUseCase(gh<_i24.AuthRepository>()));
  gh.factory<_i36.UploadImageUseCase>(
      () => _i36.UploadImageUseCase(gh<_i21.AppRepository>()));
  gh.factory<_i37.AuthBloc>(() => _i37.AuthBloc(
        gh<_i33.LoginUseCase>(),
        gh<_i35.SignUpUseCase>(),
        gh<_i26.ConfirmUseCase>(),
      ));
  gh.factory<_i38.UploadImageCubit>(
      () => _i38.UploadImageCubit(gh<_i36.UploadImageUseCase>()));
  return getIt;
}

class _$AppModule extends _i39.AppModule {}
