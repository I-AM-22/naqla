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
    as _i25;
import '../../features/app/data/repositories/app_repository_implement.dart'
    as _i27;
import '../../features/app/data/repositories/prefs_repository_imp.dart' as _i14;
import '../../features/app/domain/repository/app_repository.dart' as _i26;
import '../../features/app/domain/repository/prefs_repository.dart' as _i13;
import '../../features/app/domain/usecases/upload_image_use_case.dart' as _i45;
import '../../features/app/presentation/state/bloc/app_bloc.dart' as _i3;
import '../../features/app/presentation/state/upload_image_cubit.dart' as _i47;
import '../../features/auth/data/data_sources/auth_remote_data_source.dart'
    as _i28;
import '../../features/auth/data/repositories/auth_repository_implement.dart'
    as _i30;
import '../../features/auth/domain/repositories/auth_repository.dart' as _i29;
import '../../features/auth/domain/use_cases/confirm_use_case.dart' as _i31;
import '../../features/auth/domain/use_cases/login_use_case.dart' as _i41;
import '../../features/auth/domain/use_cases/sign_up_use_case.dart' as _i44;
import '../../features/auth/presentation/state/bloc/auth_bloc.dart' as _i46;
import '../../features/home/data/data_source/home_remote_data_source.dart'
    as _i7;
import '../../features/home/data/repositories/home_repository_implement.dart'
    as _i9;
import '../../features/home/domain/repositories/home_repository.dart' as _i8;
import '../../features/home/domain/use_case/accept_order_use_case.dart' as _i24;
import '../../features/home/domain/use_case/get_car_advantage_use_case.dart'
    as _i35;
import '../../features/home/domain/use_case/get_orders_use_case.dart' as _i34;
import '../../features/home/domain/use_case/set_order_use_case.dart' as _i19;
import '../../features/home/domain/use_case/upload_photos_use_case.dart'
    as _i22;
import '../../features/home/presentation/bloc/home_bloc.dart' as _i40;
import '../../features/orders/data/datasources/order_remote_data_source.dart'
    as _i10;
import '../../features/orders/data/repositories/order_repositoru_implement.dart'
    as _i12;
import '../../features/orders/domain/repositories/order_repository.dart'
    as _i11;
import '../../features/orders/domain/usecases/get_orders_use_case.dart' as _i36;
import '../../features/orders/domain/usecases/get_sub_order_details_use_case.dart'
    as _i38;
import '../../features/orders/domain/usecases/get_sub_orders_use_case.dart'
    as _i39;
import '../../features/orders/domain/usecases/set_arrived_use_case.dart'
    as _i18;
import '../../features/orders/domain/usecases/set_picked_up_use_case.dart'
    as _i20;
import '../../features/orders/presentation/state/order_bloc.dart' as _i42;
import '../../features/profile/data/data_source/profile_remote_data_source.dart'
    as _i15;
import '../../features/profile/data/repositories/profile_repository_implement.dart'
    as _i17;
import '../../features/profile/domain/repositories/profile_repository.dart'
    as _i16;
import '../../features/profile/domain/use_cases/delete_account_use_case.dart'
    as _i32;
import '../../features/profile/domain/use_cases/edit_personal_info_use_case.dart'
    as _i33;
import '../../features/profile/domain/use_cases/get_personal_info_use_case.dart'
    as _i37;
import '../../features/profile/domain/use_cases/update_phone_number_use_case.dart'
    as _i21;
import '../../features/profile/domain/use_cases/upload_single_photo_use_case.dart'
    as _i23;
import '../../features/profile/presentation/state/bloc/profile_bloc.dart'
    as _i43;
import 'di_container.dart' as _i48;

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
  gh.factory<_i18.SetArrivedUseCase>(
      () => _i18.SetArrivedUseCase(gh<_i11.OrderRepository>()));
  gh.factory<_i19.SetOrderUseCase>(
      () => _i19.SetOrderUseCase(gh<_i8.HomeRepository>()));
  gh.factory<_i20.SetPickedUpUseCase>(
      () => _i20.SetPickedUpUseCase(gh<_i11.OrderRepository>()));
  gh.factory<_i21.UpdatePhoneNumberUseCase>(
      () => _i21.UpdatePhoneNumberUseCase(gh<_i16.ProfileRepository>()));
  gh.factory<_i22.UploadPhotosUseCase>(
      () => _i22.UploadPhotosUseCase(gh<_i8.HomeRepository>()));
  gh.factory<_i23.UploadSinglePhotoUseCase>(
      () => _i23.UploadSinglePhotoUseCase(gh<_i16.ProfileRepository>()));
  gh.factory<_i24.AcceptOrderUseCase>(
      () => _i24.AcceptOrderUseCase(gh<_i8.HomeRepository>()));
  gh.factory<_i25.AppRemoteDataSource>(
      () => _i25.AppRemoteDataSource(gh<_i4.Dio>()));
  gh.factory<_i26.AppRepository>(
      () => _i27.AppRepositoryImplement(gh<_i25.AppRemoteDataSource>()));
  gh.factory<_i28.AuthRemoteDataSource>(
      () => _i28.AuthRemoteDataSource(gh<_i4.Dio>()));
  gh.factory<_i29.AuthRepository>(
      () => _i30.AuthRepositoryImplement(gh<_i28.AuthRemoteDataSource>()));
  gh.factory<_i31.ConfirmUseCase>(
      () => _i31.ConfirmUseCase(gh<_i29.AuthRepository>()));
  gh.factory<_i32.DeleteAccountUseCase>(
      () => _i32.DeleteAccountUseCase(gh<_i16.ProfileRepository>()));
  gh.factory<_i33.EditPersonalInfoUseCase>(
      () => _i33.EditPersonalInfoUseCase(gh<_i16.ProfileRepository>()));
  gh.factory<_i34.GetAcceptOrdersUseCase>(
      () => _i34.GetAcceptOrdersUseCase(gh<_i8.HomeRepository>()));
  gh.factory<_i35.GetCarAdvantageUseCase>(
      () => _i35.GetCarAdvantageUseCase(gh<_i8.HomeRepository>()));
  gh.factory<_i36.GetOrdersUseCase>(
      () => _i36.GetOrdersUseCase(gh<_i11.OrderRepository>()));
  gh.factory<_i37.GetPersonalInfoUseCase>(
      () => _i37.GetPersonalInfoUseCase(gh<_i16.ProfileRepository>()));
  gh.factory<_i38.GetSubOrderDetailsUseCase>(
      () => _i38.GetSubOrderDetailsUseCase(gh<_i11.OrderRepository>()));
  gh.factory<_i39.GetSubOrdersUseCase>(
      () => _i39.GetSubOrdersUseCase(gh<_i11.OrderRepository>()));
  gh.lazySingleton<_i40.HomeBloc>(() => _i40.HomeBloc(
        gh<_i22.UploadPhotosUseCase>(),
        gh<_i35.GetCarAdvantageUseCase>(),
        gh<_i34.GetAcceptOrdersUseCase>(),
        gh<_i19.SetOrderUseCase>(),
        gh<_i24.AcceptOrderUseCase>(),
      ));
  gh.factory<_i41.LoginUseCase>(
      () => _i41.LoginUseCase(gh<_i29.AuthRepository>()));
  gh.lazySingleton<_i42.OrderBloc>(() => _i42.OrderBloc(
        gh<_i36.GetOrdersUseCase>(),
        gh<_i39.GetSubOrdersUseCase>(),
        gh<_i18.SetArrivedUseCase>(),
        gh<_i20.SetPickedUpUseCase>(),
        gh<_i38.GetSubOrderDetailsUseCase>(),
      ));
  gh.lazySingleton<_i43.ProfileBloc>(() => _i43.ProfileBloc(
        gh<_i37.GetPersonalInfoUseCase>(),
        gh<_i33.EditPersonalInfoUseCase>(),
        gh<_i23.UploadSinglePhotoUseCase>(),
        gh<_i21.UpdatePhoneNumberUseCase>(),
        gh<_i32.DeleteAccountUseCase>(),
        gh<_i31.ConfirmUseCase>(),
      ));
  gh.factory<_i44.SignUpUseCase>(
      () => _i44.SignUpUseCase(gh<_i29.AuthRepository>()));
  gh.factory<_i45.UploadImageUseCase>(
      () => _i45.UploadImageUseCase(gh<_i26.AppRepository>()));
  gh.factory<_i46.AuthBloc>(() => _i46.AuthBloc(
        gh<_i41.LoginUseCase>(),
        gh<_i44.SignUpUseCase>(),
        gh<_i31.ConfirmUseCase>(),
      ));
  gh.factory<_i47.UploadImageCubit>(
      () => _i47.UploadImageCubit(gh<_i45.UploadImageUseCase>()));
  return getIt;
}

class _$AppModule extends _i48.AppModule {}
