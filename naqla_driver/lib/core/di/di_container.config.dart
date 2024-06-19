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
import 'package:logger/logger.dart' as _i7;
import 'package:shared_preferences/shared_preferences.dart' as _i6;

import '../../features/app/data/datasources/app_remote_data_source.dart'
    as _i10;
import '../../features/app/data/repositories/app_repository_implement.dart'
    as _i17;
import '../../features/app/data/repositories/prefs_repository_imp.dart' as _i9;
import '../../features/app/domain/repository/app_repository.dart' as _i16;
import '../../features/app/domain/repository/prefs_repository.dart' as _i8;
import '../../features/app/domain/usecases/upload_image_use_case.dart' as _i22;
import '../../features/app/presentation/state/bloc/app_bloc.dart' as _i4;
import '../../features/app/presentation/state/upload_image_cubit.dart' as _i43;
import '../../features/auth/data/datasources/auth_local_data_source.dart'
    as _i5;
import '../../features/auth/data/datasources/auth_remote_data_source.dart'
    as _i11;
import '../../features/auth/data/repositories/auth_repository_implement.dart'
    as _i38;
import '../../features/auth/domain/repositories/auth_repository.dart' as _i37;
import '../../features/auth/domain/usecases/login_use_case.dart' as _i44;
import '../../features/auth/domain/usecases/signup_use_case.dart' as _i45;
import '../../features/auth/domain/usecases/verification_phone_number_use_case.dart'
    as _i46;
import '../../features/auth/presentation/state/auth_bloc.dart' as _i54;
import '../../features/cars/data/datasources/cars_remote_data_source.dart'
    as _i15;
import '../../features/cars/data/repositories/cars_repository_implement.dart'
    as _i26;
import '../../features/cars/domain/repositories/cars_repository.dart' as _i25;
import '../../features/cars/domain/usecases/delete_car_use_case.dart' as _i40;
import '../../features/cars/domain/usecases/edit_car_use_case.dart' as _i41;
import '../../features/cars/domain/usecases/get_all_cars_use_case.dart' as _i42;
import '../../features/cars/presentation/state/cars_bloc.dart' as _i53;
import '../../features/home/data/datasource/home_remote_data_source.dart'
    as _i12;
import '../../features/home/data/repositories/home_repository_implement.dart'
    as _i19;
import '../../features/home/domain/repositories/home_repository.dart' as _i18;
import '../../features/home/domain/usecase/add_car_use_case.dart' as _i32;
import '../../features/home/domain/usecase/car_advantage_use_case.dart' as _i33;
import '../../features/home/domain/usecase/get_order_car_use_case.dart' as _i34;
import '../../features/home/domain/usecase/get_sub_orders_use_case.dart'
    as _i35;
import '../../features/home/domain/usecase/set_driver_use_case.dart' as _i36;
import '../../features/home/presentation/state/home_bloc.dart' as _i39;
import '../../features/orders/data/datasources/order_remote_data_source.dart'
    as _i13;
import '../../features/orders/data/repositories/order_repository_implement.dart'
    as _i24;
import '../../features/orders/domain/repositories/order_repository.dart'
    as _i23;
import '../../features/orders/domain/usecases/get_orders_done_use_case.dart'
    as _i47;
import '../../features/orders/domain/usecases/get_orders_use_case.dart' as _i48;
import '../../features/orders/domain/usecases/get_sub_order_details.dart'
    as _i49;
import '../../features/orders/domain/usecases/set_delivered_use_case.dart'
    as _i50;
import '../../features/orders/presentation/state/order_bloc.dart' as _i52;
import '../../features/profile/data/datasource/profile_remote_data_source.dart'
    as _i14;
import '../../features/profile/data/repositories/profile_repository_implement.dart'
    as _i21;
import '../../features/profile/domain/repositories/profile_repository.dart'
    as _i20;
import '../../features/profile/domain/usecases/delete_account_use_case.dart'
    as _i27;
import '../../features/profile/domain/usecases/edit_personal_info_use_case.dart'
    as _i28;
import '../../features/profile/domain/usecases/get_profile_use_case.dart'
    as _i29;
import '../../features/profile/domain/usecases/update_phone_number_use_case.dart'
    as _i30;
import '../../features/profile/domain/usecases/upload_single_photo_use_case.dart'
    as _i31;
import '../../features/profile/presentation/state/profile_bloc.dart' as _i51;
import 'di_container.dart' as _i55;

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
  gh.factory<_i4.AppBloc>(() => _i4.AppBloc());
  gh.factory<_i5.AuthLocaleDataSource>(() => _i5.AuthLocaleDataSource());
  await gh.singletonAsync<_i6.SharedPreferences>(
    () => appModule.sharedPreferences,
    preResolve: true,
  );
  gh.lazySingleton<_i7.Logger>(() => appModule.logger);
  gh.factory<_i8.PrefsRepository>(() =>
      _i9.PrefsRepositoryImpl(sharedPreferences: gh<_i6.SharedPreferences>()));
  gh.lazySingleton<_i3.Dio>(() => appModule.dio(
        gh<_i3.BaseOptions>(),
        gh<_i7.Logger>(),
      ));
  gh.factory<_i10.AppRemoteDataSource>(
      () => _i10.AppRemoteDataSource(gh<_i3.Dio>()));
  gh.factory<_i11.AuthRemoteDataSource>(
      () => _i11.AuthRemoteDataSource(gh<_i3.Dio>()));
  gh.factory<_i12.HomeRemoteDataSource>(
      () => _i12.HomeRemoteDataSource(gh<_i3.Dio>()));
  gh.factory<_i13.OrderRemoteDataSource>(
      () => _i13.OrderRemoteDataSource(gh<_i3.Dio>()));
  gh.factory<_i14.ProfileRemoteDataSource>(
      () => _i14.ProfileRemoteDataSource(gh<_i3.Dio>()));
  gh.factory<_i15.CarsRemoteDataSource>(
      () => _i15.CarsRemoteDataSource(gh<_i3.Dio>()));
  gh.factory<_i16.AppRepository>(
      () => _i17.AppRepositoryImplement(gh<_i10.AppRemoteDataSource>()));
  gh.factory<_i18.HomeRepository>(
      () => _i19.HomeRepositoryImplement(gh<_i12.HomeRemoteDataSource>()));
  gh.factory<_i20.ProfileRepository>(() =>
      _i21.ProfileRepositoryImplement(gh<_i14.ProfileRemoteDataSource>()));
  gh.factory<_i22.UploadImageUseCase>(
      () => _i22.UploadImageUseCase(gh<_i16.AppRepository>()));
  gh.factory<_i23.OrderRepository>(
      () => _i24.OrderRepositoryImplement(gh<_i13.OrderRemoteDataSource>()));
  gh.factory<_i25.CarsRepository>(
      () => _i26.CarsRepositoryImplement(gh<_i15.CarsRemoteDataSource>()));
  gh.factory<_i27.DeleteAccountUseCase>(
      () => _i27.DeleteAccountUseCase(gh<_i20.ProfileRepository>()));
  gh.factory<_i28.EditPersonalInfoUseCase>(
      () => _i28.EditPersonalInfoUseCase(gh<_i20.ProfileRepository>()));
  gh.factory<_i29.GetProfileUseCase>(
      () => _i29.GetProfileUseCase(gh<_i20.ProfileRepository>()));
  gh.factory<_i30.UpdatePhoneNumberUseCase>(
      () => _i30.UpdatePhoneNumberUseCase(gh<_i20.ProfileRepository>()));
  gh.factory<_i31.UploadSinglePhotoUseCase>(
      () => _i31.UploadSinglePhotoUseCase(gh<_i20.ProfileRepository>()));
  gh.factory<_i32.AddCarUseCase>(
      () => _i32.AddCarUseCase(gh<_i18.HomeRepository>()));
  gh.factory<_i33.CarAdvantageUseCase>(
      () => _i33.CarAdvantageUseCase(gh<_i18.HomeRepository>()));
  gh.factory<_i34.GetOrderCarUseCase>(
      () => _i34.GetOrderCarUseCase(gh<_i18.HomeRepository>()));
  gh.factory<_i35.GetSubOrdersUseCase>(
      () => _i35.GetSubOrdersUseCase(gh<_i18.HomeRepository>()));
  gh.factory<_i36.SetDriverUseCase>(
      () => _i36.SetDriverUseCase(gh<_i18.HomeRepository>()));
  gh.factory<_i37.AuthRepository>(() => _i38.AuthRepositoryImplement(
        gh<_i11.AuthRemoteDataSource>(),
        gh<_i5.AuthLocaleDataSource>(),
      ));
  gh.lazySingleton<_i39.HomeBloc>(() => _i39.HomeBloc(
        gh<_i35.GetSubOrdersUseCase>(),
        gh<_i36.SetDriverUseCase>(),
        gh<_i34.GetOrderCarUseCase>(),
      ));
  gh.factory<_i40.DeleteCarUseCase>(
      () => _i40.DeleteCarUseCase(gh<_i25.CarsRepository>()));
  gh.factory<_i41.EditCarUseCase>(
      () => _i41.EditCarUseCase(gh<_i25.CarsRepository>()));
  gh.factory<_i42.GetAllCarsUseCase>(
      () => _i42.GetAllCarsUseCase(gh<_i25.CarsRepository>()));
  gh.factory<_i43.UploadImageCubit>(
      () => _i43.UploadImageCubit(gh<_i22.UploadImageUseCase>()));
  gh.factory<_i44.LoginUseCase>(
      () => _i44.LoginUseCase(gh<_i37.AuthRepository>()));
  gh.factory<_i45.SignUpUseCase>(
      () => _i45.SignUpUseCase(gh<_i37.AuthRepository>()));
  gh.factory<_i46.VerificationPhoneNumberUseCase>(
      () => _i46.VerificationPhoneNumberUseCase(gh<_i37.AuthRepository>()));
  gh.factory<_i47.GetOrdersDoneUseCase>(
      () => _i47.GetOrdersDoneUseCase(gh<_i23.OrderRepository>()));
  gh.factory<_i48.GetOrdersUseCase>(
      () => _i48.GetOrdersUseCase(gh<_i23.OrderRepository>()));
  gh.factory<_i49.GetSubOrderDetailsUseCase>(
      () => _i49.GetSubOrderDetailsUseCase(gh<_i23.OrderRepository>()));
  gh.factory<_i50.SetDeliveredUseCase>(
      () => _i50.SetDeliveredUseCase(gh<_i23.OrderRepository>()));
  gh.lazySingleton<_i51.ProfileBloc>(() => _i51.ProfileBloc(
        gh<_i29.GetProfileUseCase>(),
        gh<_i28.EditPersonalInfoUseCase>(),
        gh<_i31.UploadSinglePhotoUseCase>(),
        gh<_i30.UpdatePhoneNumberUseCase>(),
        gh<_i27.DeleteAccountUseCase>(),
        gh<_i46.VerificationPhoneNumberUseCase>(),
      ));
  gh.factory<_i52.OrderBloc>(() => _i52.OrderBloc(
        gh<_i47.GetOrdersDoneUseCase>(),
        gh<_i48.GetOrdersUseCase>(),
        gh<_i50.SetDeliveredUseCase>(),
        gh<_i49.GetSubOrderDetailsUseCase>(),
      ));
  gh.factory<_i53.CarsBloc>(() => _i53.CarsBloc(
        gh<_i42.GetAllCarsUseCase>(),
        gh<_i40.DeleteCarUseCase>(),
        gh<_i41.EditCarUseCase>(),
        gh<_i32.AddCarUseCase>(),
        gh<_i33.CarAdvantageUseCase>(),
      ));
  gh.factory<_i54.AuthBloc>(() => _i54.AuthBloc(
        gh<_i44.LoginUseCase>(),
        gh<_i45.SignUpUseCase>(),
        gh<_i46.VerificationPhoneNumberUseCase>(),
      ));
  return getIt;
}

class _$AppModule extends _i55.AppModule {}
