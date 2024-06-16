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
import 'package:logger/logger.dart' as _i6;
import 'package:shared_preferences/shared_preferences.dart' as _i5;

import '../../features/app/data/datasources/app_remote_data_source.dart' as _i9;
import '../../features/app/data/repositories/app_repository_implement.dart'
    as _i15;
import '../../features/app/data/repositories/prefs_repository_imp.dart' as _i8;
import '../../features/app/domain/repository/app_repository.dart' as _i14;
import '../../features/app/domain/repository/prefs_repository.dart' as _i7;
import '../../features/app/domain/usecases/delete_car_use_case.dart' as _i20;
import '../../features/app/domain/usecases/edit_car_use_case.dart' as _i21;
import '../../features/app/domain/usecases/get_all_cars_use_case.dart' as _i22;
import '../../features/app/domain/usecases/upload_image_use_case.dart' as _i23;
import '../../features/app/presentation/state/bloc/app_bloc.dart' as _i50;
import '../../features/app/presentation/state/upload_image_cubit.dart' as _i39;
import '../../features/auth/data/datasources/auth_local_data_source.dart'
    as _i4;
import '../../features/auth/data/datasources/auth_remote_data_source.dart'
    as _i10;
import '../../features/auth/data/repositories/auth_repository_implement.dart'
    as _i37;
import '../../features/auth/domain/repositories/auth_repository.dart' as _i36;
import '../../features/auth/domain/usecases/login_use_case.dart' as _i40;
import '../../features/auth/domain/usecases/signup_use_case.dart' as _i41;
import '../../features/auth/domain/usecases/verification_phone_number_use_case.dart'
    as _i42;
import '../../features/auth/presentation/state/auth_bloc.dart' as _i49;
import '../../features/home/data/datasource/home_remote_data_source.dart'
    as _i11;
import '../../features/home/data/repositories/home_repository_implement.dart'
    as _i17;
import '../../features/home/domain/repositories/home_repository.dart' as _i16;
import '../../features/home/domain/usecase/add_car_use_case.dart' as _i31;
import '../../features/home/domain/usecase/car_advantage_use_case.dart' as _i32;
import '../../features/home/domain/usecase/get_order_car_use_case.dart' as _i33;
import '../../features/home/domain/usecase/get_sub_orders_use_case.dart'
    as _i34;
import '../../features/home/domain/usecase/set_driver_use_case.dart' as _i35;
import '../../features/home/presentation/state/home_bloc.dart' as _i38;
import '../../features/orders/data/datasources/order_remote_data_source.dart'
    as _i12;
import '../../features/orders/data/repositories/order_repository_implement.dart'
    as _i25;
import '../../features/orders/domain/repositories/order_repository.dart'
    as _i24;
import '../../features/orders/domain/usecases/get_orders_done_use_case.dart'
    as _i43;
import '../../features/orders/domain/usecases/get_orders_use_case.dart' as _i44;
import '../../features/orders/domain/usecases/get_sub_order_details.dart'
    as _i45;
import '../../features/orders/domain/usecases/set_delivered_use_case.dart'
    as _i46;
import '../../features/orders/presentation/state/order_bloc.dart' as _i48;
import '../../features/profile/data/datasource/profile_remote_data_source.dart'
    as _i13;
import '../../features/profile/data/repositories/profile_repository_implement.dart'
    as _i19;
import '../../features/profile/domain/repositories/profile_repository.dart'
    as _i18;
import '../../features/profile/domain/usecases/delete_account_use_case.dart'
    as _i26;
import '../../features/profile/domain/usecases/edit_personal_info_use_case.dart'
    as _i27;
import '../../features/profile/domain/usecases/get_profile_use_case.dart'
    as _i28;
import '../../features/profile/domain/usecases/update_phone_number_use_case.dart'
    as _i29;
import '../../features/profile/domain/usecases/upload_single_photo_use_case.dart'
    as _i30;
import '../../features/profile/presentation/state/profile_bloc.dart' as _i47;
import 'di_container.dart' as _i51;

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
  await gh.singletonAsync<_i5.SharedPreferences>(
    () => appModule.sharedPreferences,
    preResolve: true,
  );
  gh.lazySingleton<_i6.Logger>(() => appModule.logger);
  gh.factory<_i7.PrefsRepository>(() =>
      _i8.PrefsRepositoryImpl(sharedPreferences: gh<_i5.SharedPreferences>()));
  gh.lazySingleton<_i3.Dio>(() => appModule.dio(
        gh<_i3.BaseOptions>(),
        gh<_i6.Logger>(),
      ));
  gh.factory<_i9.AppRemoteDataSource>(
      () => _i9.AppRemoteDataSource(gh<_i3.Dio>()));
  gh.factory<_i10.AuthRemoteDataSource>(
      () => _i10.AuthRemoteDataSource(gh<_i3.Dio>()));
  gh.factory<_i11.HomeRemoteDataSource>(
      () => _i11.HomeRemoteDataSource(gh<_i3.Dio>()));
  gh.factory<_i12.OrderRemoteDataSource>(
      () => _i12.OrderRemoteDataSource(gh<_i3.Dio>()));
  gh.factory<_i13.ProfileRemoteDataSource>(
      () => _i13.ProfileRemoteDataSource(gh<_i3.Dio>()));
  gh.factory<_i14.AppRepository>(
      () => _i15.AppRepositoryImplement(gh<_i9.AppRemoteDataSource>()));
  gh.factory<_i16.HomeRepository>(
      () => _i17.HomeRepositoryImplement(gh<_i11.HomeRemoteDataSource>()));
  gh.factory<_i18.ProfileRepository>(() =>
      _i19.ProfileRepositoryImplement(gh<_i13.ProfileRemoteDataSource>()));
  gh.factory<_i20.DeleteCarUseCase>(
      () => _i20.DeleteCarUseCase(gh<_i14.AppRepository>()));
  gh.factory<_i21.EditCarUseCase>(
      () => _i21.EditCarUseCase(gh<_i14.AppRepository>()));
  gh.factory<_i22.GetAllCarsUseCase>(
      () => _i22.GetAllCarsUseCase(gh<_i14.AppRepository>()));
  gh.factory<_i23.UploadImageUseCase>(
      () => _i23.UploadImageUseCase(gh<_i14.AppRepository>()));
  gh.factory<_i24.OrderRepository>(
      () => _i25.OrderRepositoryImplement(gh<_i12.OrderRemoteDataSource>()));
  gh.factory<_i26.DeleteAccountUseCase>(
      () => _i26.DeleteAccountUseCase(gh<_i18.ProfileRepository>()));
  gh.factory<_i27.EditPersonalInfoUseCase>(
      () => _i27.EditPersonalInfoUseCase(gh<_i18.ProfileRepository>()));
  gh.factory<_i28.GetProfileUseCase>(
      () => _i28.GetProfileUseCase(gh<_i18.ProfileRepository>()));
  gh.factory<_i29.UpdatePhoneNumberUseCase>(
      () => _i29.UpdatePhoneNumberUseCase(gh<_i18.ProfileRepository>()));
  gh.factory<_i30.UploadSinglePhotoUseCase>(
      () => _i30.UploadSinglePhotoUseCase(gh<_i18.ProfileRepository>()));
  gh.factory<_i31.AddCarUseCase>(
      () => _i31.AddCarUseCase(gh<_i16.HomeRepository>()));
  gh.factory<_i32.CarAdvantageUseCase>(
      () => _i32.CarAdvantageUseCase(gh<_i16.HomeRepository>()));
  gh.factory<_i33.GetOrderCarUseCase>(
      () => _i33.GetOrderCarUseCase(gh<_i16.HomeRepository>()));
  gh.factory<_i34.GetSubOrdersUseCase>(
      () => _i34.GetSubOrdersUseCase(gh<_i16.HomeRepository>()));
  gh.factory<_i35.SetDriverUseCase>(
      () => _i35.SetDriverUseCase(gh<_i16.HomeRepository>()));
  gh.factory<_i36.AuthRepository>(() => _i37.AuthRepositoryImplement(
        gh<_i10.AuthRemoteDataSource>(),
        gh<_i4.AuthLocaleDataSource>(),
      ));
  gh.lazySingleton<_i38.HomeBloc>(() => _i38.HomeBloc(
        gh<_i34.GetSubOrdersUseCase>(),
        gh<_i22.GetAllCarsUseCase>(),
        gh<_i35.SetDriverUseCase>(),
        gh<_i33.GetOrderCarUseCase>(),
      ));
  gh.factory<_i39.UploadImageCubit>(
      () => _i39.UploadImageCubit(gh<_i23.UploadImageUseCase>()));
  gh.factory<_i40.LoginUseCase>(
      () => _i40.LoginUseCase(gh<_i36.AuthRepository>()));
  gh.factory<_i41.SignUpUseCase>(
      () => _i41.SignUpUseCase(gh<_i36.AuthRepository>()));
  gh.factory<_i42.VerificationPhoneNumberUseCase>(
      () => _i42.VerificationPhoneNumberUseCase(gh<_i36.AuthRepository>()));
  gh.factory<_i43.GetOrdersDoneUseCase>(
      () => _i43.GetOrdersDoneUseCase(gh<_i24.OrderRepository>()));
  gh.factory<_i44.GetOrdersUseCase>(
      () => _i44.GetOrdersUseCase(gh<_i24.OrderRepository>()));
  gh.factory<_i45.GetSubOrderDetailsUseCase>(
      () => _i45.GetSubOrderDetailsUseCase(gh<_i24.OrderRepository>()));
  gh.factory<_i46.SetDeliveredUseCase>(
      () => _i46.SetDeliveredUseCase(gh<_i24.OrderRepository>()));
  gh.lazySingleton<_i47.ProfileBloc>(() => _i47.ProfileBloc(
        gh<_i28.GetProfileUseCase>(),
        gh<_i27.EditPersonalInfoUseCase>(),
        gh<_i30.UploadSinglePhotoUseCase>(),
        gh<_i29.UpdatePhoneNumberUseCase>(),
        gh<_i26.DeleteAccountUseCase>(),
        gh<_i42.VerificationPhoneNumberUseCase>(),
      ));
  gh.factory<_i48.OrderBloc>(() => _i48.OrderBloc(
        gh<_i43.GetOrdersDoneUseCase>(),
        gh<_i44.GetOrdersUseCase>(),
        gh<_i46.SetDeliveredUseCase>(),
        gh<_i45.GetSubOrderDetailsUseCase>(),
      ));
  gh.factory<_i49.AuthBloc>(() => _i49.AuthBloc(
        gh<_i40.LoginUseCase>(),
        gh<_i41.SignUpUseCase>(),
        gh<_i42.VerificationPhoneNumberUseCase>(),
      ));
  gh.factory<_i50.AppBloc>(() => _i50.AppBloc(
        gh<_i22.GetAllCarsUseCase>(),
        gh<_i20.DeleteCarUseCase>(),
        gh<_i21.EditCarUseCase>(),
        gh<_i31.AddCarUseCase>(),
        gh<_i32.CarAdvantageUseCase>(),
      ));
  return getIt;
}

class _$AppModule extends _i51.AppModule {}
