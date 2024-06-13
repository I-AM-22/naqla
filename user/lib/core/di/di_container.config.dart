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
    as _i23;
import '../../features/app/data/repositories/app_repository_implement.dart'
    as _i25;
import '../../features/app/data/repositories/prefs_repository_imp.dart' as _i14;
import '../../features/app/domain/repository/app_repository.dart' as _i24;
import '../../features/app/domain/repository/prefs_repository.dart' as _i13;
import '../../features/app/domain/usecases/upload_image_use_case.dart' as _i42;
import '../../features/app/presentation/state/bloc/app_bloc.dart' as _i3;
import '../../features/app/presentation/state/upload_image_cubit.dart' as _i44;
import '../../features/auth/data/data_sources/auth_remote_data_source.dart'
    as _i26;
import '../../features/auth/data/repositories/auth_repository_implement.dart'
    as _i28;
import '../../features/auth/domain/repositories/auth_repository.dart' as _i27;
import '../../features/auth/domain/use_cases/confirm_use_case.dart' as _i29;
import '../../features/auth/domain/use_cases/login_use_case.dart' as _i38;
import '../../features/auth/domain/use_cases/sign_up_use_case.dart' as _i41;
import '../../features/auth/presentation/state/bloc/auth_bloc.dart' as _i43;
import '../../features/home/data/data_source/home_remote_data_source.dart'
    as _i7;
import '../../features/home/data/repositories/home_repository_implement.dart'
    as _i9;
import '../../features/home/domain/repositories/home_repository.dart' as _i8;
import '../../features/home/domain/use_case/accept_order_use_case.dart' as _i22;
import '../../features/home/domain/use_case/get_car_advantage_use_case.dart'
    as _i33;
import '../../features/home/domain/use_case/get_orders_use_case.dart' as _i32;
import '../../features/home/domain/use_case/set_order_use_case.dart' as _i18;
import '../../features/home/domain/use_case/upload_photos_use_case.dart'
    as _i20;
import '../../features/home/presentation/bloc/home_bloc.dart' as _i37;
import '../../features/orders/data/datasources/order_remote_data_source.dart'
    as _i10;
import '../../features/orders/data/repositories/order_repositoru_implement.dart'
    as _i12;
import '../../features/orders/domain/repositories/order_repository.dart'
    as _i11;
import '../../features/orders/domain/usecases/get_orders_use_case.dart' as _i34;
import '../../features/orders/domain/usecases/get_sub_orders_use_case.dart'
    as _i36;
import '../../features/orders/presentation/state/order_bloc.dart' as _i39;
import '../../features/profile/data/data_source/profile_remote_data_source.dart'
    as _i15;
import '../../features/profile/data/repositories/profile_repository_implement.dart'
    as _i17;
import '../../features/profile/domain/repositories/profile_repository.dart'
    as _i16;
import '../../features/profile/domain/use_cases/delete_account_use_case.dart'
    as _i30;
import '../../features/profile/domain/use_cases/edit_personal_info_use_case.dart'
    as _i31;
import '../../features/profile/domain/use_cases/get_personal_info_use_case.dart'
    as _i35;
import '../../features/profile/domain/use_cases/update_phone_number_use_case.dart'
    as _i19;
import '../../features/profile/domain/use_cases/upload_single_photo_use_case.dart'
    as _i21;
import '../../features/profile/presentation/state/bloc/profile_bloc.dart'
    as _i40;
import 'di_container.dart' as _i45;

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
  gh.factory<_i10.OrderRemoteDataSource>(
      () => _i10.OrderRemoteDataSource(gh<_i4.Dio>()));
  gh.factory<_i11.OrderRepository>(
      () => _i12.OrderRepositoryImplement(gh<_i10.OrderRemoteDataSource>()));
  gh.factory<_i13.PrefsRepository>(() =>
      _i14.PrefsRepositoryImpl(sharedPreferences: gh<_i6.SharedPreferences>()));
  gh.factory<_i15.ProfileRemoteDataSource>(
      () => _i15.ProfileRemoteDataSource(gh<_i4.Dio>()));
  gh.factory<_i16.ProfileRepository>(() =>
      _i17.ProfileRepositoryImplement(gh<_i15.ProfileRemoteDataSource>()));
  gh.factory<_i18.SetOrderUseCase>(
      () => _i18.SetOrderUseCase(gh<_i8.HomeRepository>()));
  gh.factory<_i19.UpdatePhoneNumberUseCase>(
      () => _i19.UpdatePhoneNumberUseCase(gh<_i16.ProfileRepository>()));
  gh.factory<_i20.UploadPhotosUseCase>(
      () => _i20.UploadPhotosUseCase(gh<_i8.HomeRepository>()));
  gh.factory<_i21.UploadSinglePhotoUseCase>(
      () => _i21.UploadSinglePhotoUseCase(gh<_i16.ProfileRepository>()));
  gh.factory<_i22.AcceptOrderUseCase>(
      () => _i22.AcceptOrderUseCase(gh<_i8.HomeRepository>()));
  gh.factory<_i23.AppRemoteDataSource>(
      () => _i23.AppRemoteDataSource(gh<_i4.Dio>()));
  gh.factory<_i24.AppRepository>(
      () => _i25.AppRepositoryImplement(gh<_i23.AppRemoteDataSource>()));
  gh.factory<_i26.AuthRemoteDataSource>(
      () => _i26.AuthRemoteDataSource(gh<_i4.Dio>()));
  gh.factory<_i27.AuthRepository>(
      () => _i28.AuthRepositoryImplement(gh<_i26.AuthRemoteDataSource>()));
  gh.factory<_i29.ConfirmUseCase>(
      () => _i29.ConfirmUseCase(gh<_i27.AuthRepository>()));
  gh.factory<_i30.DeleteAccountUseCase>(
      () => _i30.DeleteAccountUseCase(gh<_i16.ProfileRepository>()));
  gh.factory<_i31.EditPersonalInfoUseCase>(
      () => _i31.EditPersonalInfoUseCase(gh<_i16.ProfileRepository>()));
  gh.factory<_i32.GetAcceptOrdersUseCase>(
      () => _i32.GetAcceptOrdersUseCase(gh<_i8.HomeRepository>()));
  gh.factory<_i33.GetCarAdvantageUseCase>(
      () => _i33.GetCarAdvantageUseCase(gh<_i8.HomeRepository>()));
  gh.factory<_i34.GetOrdersUseCase>(
      () => _i34.GetOrdersUseCase(gh<_i11.OrderRepository>()));
  gh.factory<_i35.GetPersonalInfoUseCase>(
      () => _i35.GetPersonalInfoUseCase(gh<_i16.ProfileRepository>()));
  gh.factory<_i36.GetSubOrdersUseCase>(
      () => _i36.GetSubOrdersUseCase(gh<_i11.OrderRepository>()));
  gh.lazySingleton<_i37.HomeBloc>(() => _i37.HomeBloc(
        gh<_i20.UploadPhotosUseCase>(),
        gh<_i33.GetCarAdvantageUseCase>(),
        gh<_i32.GetAcceptOrdersUseCase>(),
        gh<_i18.SetOrderUseCase>(),
        gh<_i22.AcceptOrderUseCase>(),
      ));
  gh.factory<_i38.LoginUseCase>(
      () => _i38.LoginUseCase(gh<_i27.AuthRepository>()));
  gh.lazySingleton<_i39.OrderBloc>(() => _i39.OrderBloc(
        gh<_i34.GetOrdersUseCase>(),
        gh<_i36.GetSubOrdersUseCase>(),
      ));
  gh.factory<_i40.ProfileBloc>(() => _i40.ProfileBloc(
        gh<_i35.GetPersonalInfoUseCase>(),
        gh<_i31.EditPersonalInfoUseCase>(),
        gh<_i21.UploadSinglePhotoUseCase>(),
        gh<_i19.UpdatePhoneNumberUseCase>(),
        gh<_i30.DeleteAccountUseCase>(),
      ));
  gh.factory<_i41.SignUpUseCase>(
      () => _i41.SignUpUseCase(gh<_i27.AuthRepository>()));
  gh.factory<_i42.UploadImageUseCase>(
      () => _i42.UploadImageUseCase(gh<_i24.AppRepository>()));
  gh.factory<_i43.AuthBloc>(() => _i43.AuthBloc(
        gh<_i38.LoginUseCase>(),
        gh<_i41.SignUpUseCase>(),
        gh<_i29.ConfirmUseCase>(),
      ));
  gh.factory<_i44.UploadImageCubit>(
      () => _i44.UploadImageCubit(gh<_i42.UploadImageUseCase>()));
  return getIt;
}

class _$AppModule extends _i45.AppModule {}
