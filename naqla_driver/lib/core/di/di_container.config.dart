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
    as _i14;
import '../../features/app/data/repositories/prefs_repository_imp.dart' as _i8;
import '../../features/app/domain/repository/app_repository.dart' as _i13;
import '../../features/app/domain/repository/prefs_repository.dart' as _i7;
import '../../features/app/domain/usecases/get_all_cars_use_case.dart' as _i17;
import '../../features/app/domain/usecases/upload_image_use_case.dart' as _i18;
import '../../features/app/presentation/state/bloc/app_bloc.dart' as _i29;
import '../../features/app/presentation/state/upload_image_cubit.dart' as _i28;
import '../../features/auth/data/datasources/auth_local_data_source.dart'
    as _i4;
import '../../features/auth/data/datasources/auth_remote_data_source.dart'
    as _i10;
import '../../features/auth/data/repositories/auth_repository_implement.dart'
    as _i26;
import '../../features/auth/domain/repositories/auth_repository.dart' as _i25;
import '../../features/auth/domain/usecases/login_use_case.dart' as _i30;
import '../../features/auth/domain/usecases/signup_use_case.dart' as _i31;
import '../../features/auth/domain/usecases/verification_phone_number_use_case.dart'
    as _i32;
import '../../features/auth/presentation/state/auth_bloc.dart' as _i36;
import '../../features/home/data/datasource/home_remote_data_source.dart'
    as _i11;
import '../../features/home/data/repositories/home_repository_implement.dart'
    as _i16;
import '../../features/home/domain/repositories/home_repository.dart' as _i15;
import '../../features/home/domain/usecase/add_car_use_case.dart' as _i21;
import '../../features/home/domain/usecase/car_advantage_use_case.dart' as _i22;
import '../../features/home/domain/usecase/get_sub_orders_use_case.dart'
    as _i23;
import '../../features/home/domain/usecase/set_driver_use_case.dart' as _i24;
import '../../features/home/presentation/state/home_bloc.dart' as _i27;
import '../../features/orders/data/datasources/order_remote_data_source.dart'
    as _i12;
import '../../features/orders/data/repositories/order_repository_implement.dart'
    as _i20;
import '../../features/orders/domain/repositories/order_repository.dart'
    as _i19;
import '../../features/orders/domain/usecases/get_orders_done_use_case.dart'
    as _i33;
import '../../features/orders/domain/usecases/get_orders_use_case.dart' as _i34;
import '../../features/orders/presentation/state/order_bloc.dart' as _i35;
import 'di_container.dart' as _i37;

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
  gh.factory<_i13.AppRepository>(
      () => _i14.AppRepositoryImplement(gh<_i9.AppRemoteDataSource>()));
  gh.factory<_i15.HomeRepository>(
      () => _i16.HomeRepositoryImplement(gh<_i11.HomeRemoteDataSource>()));
  gh.factory<_i17.GetAllCarsUseCase>(
      () => _i17.GetAllCarsUseCase(gh<_i13.AppRepository>()));
  gh.factory<_i18.UploadImageUseCase>(
      () => _i18.UploadImageUseCase(gh<_i13.AppRepository>()));
  gh.factory<_i19.OrderRepository>(
      () => _i20.OrderRepositoryImplement(gh<_i12.OrderRemoteDataSource>()));
  gh.factory<_i21.AddCarUseCase>(
      () => _i21.AddCarUseCase(gh<_i15.HomeRepository>()));
  gh.factory<_i22.CarAdvantageUseCase>(
      () => _i22.CarAdvantageUseCase(gh<_i15.HomeRepository>()));
  gh.factory<_i23.GetSubOrdersUseCase>(
      () => _i23.GetSubOrdersUseCase(gh<_i15.HomeRepository>()));
  gh.factory<_i24.SetDriverUseCase>(
      () => _i24.SetDriverUseCase(gh<_i15.HomeRepository>()));
  gh.factory<_i25.AuthRepository>(() => _i26.AuthRepositoryImplement(
        gh<_i10.AuthRemoteDataSource>(),
        gh<_i4.AuthLocaleDataSource>(),
      ));
  gh.lazySingleton<_i27.HomeBloc>(() => _i27.HomeBloc(
        gh<_i21.AddCarUseCase>(),
        gh<_i22.CarAdvantageUseCase>(),
        gh<_i23.GetSubOrdersUseCase>(),
        gh<_i17.GetAllCarsUseCase>(),
        gh<_i24.SetDriverUseCase>(),
      ));
  gh.factory<_i28.UploadImageCubit>(
      () => _i28.UploadImageCubit(gh<_i18.UploadImageUseCase>()));
  gh.factory<_i29.AppBloc>(() => _i29.AppBloc(gh<_i17.GetAllCarsUseCase>()));
  gh.factory<_i30.LoginUseCase>(
      () => _i30.LoginUseCase(gh<_i25.AuthRepository>()));
  gh.factory<_i31.SignUpUseCase>(
      () => _i31.SignUpUseCase(gh<_i25.AuthRepository>()));
  gh.factory<_i32.VerificationPhoneNumberUseCase>(
      () => _i32.VerificationPhoneNumberUseCase(gh<_i25.AuthRepository>()));
  gh.factory<_i33.GetOrdersDoneUseCase>(
      () => _i33.GetOrdersDoneUseCase(gh<_i19.OrderRepository>()));
  gh.factory<_i34.GetOrdersUseCase>(
      () => _i34.GetOrdersUseCase(gh<_i19.OrderRepository>()));
  gh.factory<_i35.OrderBloc>(() => _i35.OrderBloc(
        gh<_i33.GetOrdersDoneUseCase>(),
        gh<_i34.GetOrdersUseCase>(),
      ));
  gh.factory<_i36.AuthBloc>(() => _i36.AuthBloc(
        gh<_i30.LoginUseCase>(),
        gh<_i31.SignUpUseCase>(),
        gh<_i32.VerificationPhoneNumberUseCase>(),
      ));
  return getIt;
}

class _$AppModule extends _i37.AppModule {}
