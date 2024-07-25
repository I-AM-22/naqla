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
    as _i18;
import '../../features/app/data/repositories/prefs_repository_imp.dart' as _i9;
import '../../features/app/domain/repository/app_repository.dart' as _i17;
import '../../features/app/domain/repository/prefs_repository.dart' as _i8;
import '../../features/app/domain/usecases/upload_image_use_case.dart' as _i23;
import '../../features/app/presentation/state/bloc/app_bloc.dart' as _i4;
import '../../features/app/presentation/state/upload_image_cubit.dart' as _i46;
import '../../features/auth/data/datasources/auth_local_data_source.dart'
    as _i5;
import '../../features/auth/data/datasources/auth_remote_data_source.dart'
    as _i11;
import '../../features/auth/data/repositories/auth_repository_implement.dart'
    as _i40;
import '../../features/auth/domain/repositories/auth_repository.dart' as _i39;
import '../../features/auth/domain/usecases/login_use_case.dart' as _i50;
import '../../features/auth/domain/usecases/signup_use_case.dart' as _i51;
import '../../features/auth/domain/usecases/verification_phone_number_use_case.dart'
    as _i52;
import '../../features/auth/presentation/state/auth_bloc.dart' as _i58;
import '../../features/cars/data/datasources/cars_remote_data_source.dart'
    as _i12;
import '../../features/cars/data/repositories/cars_repository_implement.dart'
    as _i27;
import '../../features/cars/domain/repositories/cars_repository.dart' as _i26;
import '../../features/cars/domain/usecases/add_car_use_case.dart' as _i42;
import '../../features/cars/domain/usecases/delete_car_use_case.dart' as _i43;
import '../../features/cars/domain/usecases/edit_car_use_case.dart' as _i44;
import '../../features/cars/domain/usecases/get_all_cars_use_case.dart' as _i45;
import '../../features/cars/presentation/state/cars_bloc.dart' as _i59;
import '../../features/chat/data/datasource/chat_remote_data_source.dart'
    as _i13;
import '../../features/chat/data/repositories/chat_repository_implement.dart'
    as _i34;
import '../../features/chat/domain/repositories/chat_repository.dart' as _i33;
import '../../features/chat/domain/usecases/get_chats_use_case.dart' as _i47;
import '../../features/chat/domain/usecases/get_messages_use_case.dart' as _i48;
import '../../features/chat/domain/usecases/send_message_use_case.dart' as _i49;
import '../../features/chat/presentation/state/chat_bloc.dart' as _i60;
import '../../features/home/data/datasource/home_remote_data_source.dart'
    as _i14;
import '../../features/home/data/repositories/home_repository_implement.dart'
    as _i20;
import '../../features/home/domain/repositories/home_repository.dart' as _i19;
import '../../features/home/domain/usecase/car_advantage_use_case.dart' as _i35;
import '../../features/home/domain/usecase/get_order_car_use_case.dart' as _i36;
import '../../features/home/domain/usecase/get_sub_orders_use_case.dart'
    as _i37;
import '../../features/home/domain/usecase/set_driver_use_case.dart' as _i38;
import '../../features/home/presentation/state/home_bloc.dart' as _i41;
import '../../features/orders/data/datasources/order_remote_data_source.dart'
    as _i15;
import '../../features/orders/data/repositories/order_repository_implement.dart'
    as _i25;
import '../../features/orders/domain/repositories/order_repository.dart'
    as _i24;
import '../../features/orders/domain/usecases/get_orders_done_use_case.dart'
    as _i53;
import '../../features/orders/domain/usecases/get_orders_use_case.dart' as _i54;
import '../../features/orders/domain/usecases/get_sub_order_details.dart'
    as _i55;
import '../../features/orders/domain/usecases/set_delivered_use_case.dart'
    as _i56;
import '../../features/orders/presentation/state/order_bloc.dart' as _i61;
import '../../features/profile/data/datasource/profile_remote_data_source.dart'
    as _i16;
import '../../features/profile/data/repositories/profile_repository_implement.dart'
    as _i22;
import '../../features/profile/domain/repositories/profile_repository.dart'
    as _i21;
import '../../features/profile/domain/usecases/delete_account_use_case.dart'
    as _i28;
import '../../features/profile/domain/usecases/edit_personal_info_use_case.dart'
    as _i29;
import '../../features/profile/domain/usecases/get_profile_use_case.dart'
    as _i30;
import '../../features/profile/domain/usecases/update_phone_number_use_case.dart'
    as _i31;
import '../../features/profile/domain/usecases/upload_single_photo_use_case.dart'
    as _i32;
import '../../features/profile/presentation/state/profile_bloc.dart' as _i57;
import 'di_container.dart' as _i62;

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
  gh.factory<_i12.CarsRemoteDataSource>(
      () => _i12.CarsRemoteDataSource(gh<_i3.Dio>()));
  gh.factory<_i13.ChatRemoteDataSource>(
      () => _i13.ChatRemoteDataSource(gh<_i3.Dio>()));
  gh.factory<_i14.HomeRemoteDataSource>(
      () => _i14.HomeRemoteDataSource(gh<_i3.Dio>()));
  gh.factory<_i15.OrderRemoteDataSource>(
      () => _i15.OrderRemoteDataSource(gh<_i3.Dio>()));
  gh.factory<_i16.ProfileRemoteDataSource>(
      () => _i16.ProfileRemoteDataSource(gh<_i3.Dio>()));
  gh.factory<_i17.AppRepository>(
      () => _i18.AppRepositoryImplement(gh<_i10.AppRemoteDataSource>()));
  gh.factory<_i19.HomeRepository>(
      () => _i20.HomeRepositoryImplement(gh<_i14.HomeRemoteDataSource>()));
  gh.factory<_i21.ProfileRepository>(() =>
      _i22.ProfileRepositoryImplement(gh<_i16.ProfileRemoteDataSource>()));
  gh.factory<_i23.UploadImageUseCase>(
      () => _i23.UploadImageUseCase(gh<_i17.AppRepository>()));
  gh.factory<_i24.OrderRepository>(
      () => _i25.OrderRepositoryImplement(gh<_i15.OrderRemoteDataSource>()));
  gh.factory<_i26.CarsRepository>(
      () => _i27.CarsRepositoryImplement(gh<_i12.CarsRemoteDataSource>()));
  gh.factory<_i28.DeleteAccountUseCase>(
      () => _i28.DeleteAccountUseCase(gh<_i21.ProfileRepository>()));
  gh.factory<_i29.EditPersonalInfoUseCase>(
      () => _i29.EditPersonalInfoUseCase(gh<_i21.ProfileRepository>()));
  gh.factory<_i30.GetProfileUseCase>(
      () => _i30.GetProfileUseCase(gh<_i21.ProfileRepository>()));
  gh.factory<_i31.UpdatePhoneNumberUseCase>(
      () => _i31.UpdatePhoneNumberUseCase(gh<_i21.ProfileRepository>()));
  gh.factory<_i32.UploadSinglePhotoUseCase>(
      () => _i32.UploadSinglePhotoUseCase(gh<_i21.ProfileRepository>()));
  gh.factory<_i33.ChatRepository>(
      () => _i34.ChatRepositoryImplement(gh<_i13.ChatRemoteDataSource>()));
  gh.factory<_i35.CarAdvantageUseCase>(
      () => _i35.CarAdvantageUseCase(gh<_i19.HomeRepository>()));
  gh.factory<_i36.GetOrderCarUseCase>(
      () => _i36.GetOrderCarUseCase(gh<_i19.HomeRepository>()));
  gh.factory<_i37.GetSubOrdersUseCase>(
      () => _i37.GetSubOrdersUseCase(gh<_i19.HomeRepository>()));
  gh.factory<_i38.SetDriverUseCase>(
      () => _i38.SetDriverUseCase(gh<_i19.HomeRepository>()));
  gh.factory<_i39.AuthRepository>(() => _i40.AuthRepositoryImplement(
        gh<_i11.AuthRemoteDataSource>(),
        gh<_i5.AuthLocaleDataSource>(),
      ));
  gh.lazySingleton<_i41.HomeBloc>(() => _i41.HomeBloc(
        gh<_i37.GetSubOrdersUseCase>(),
        gh<_i38.SetDriverUseCase>(),
        gh<_i36.GetOrderCarUseCase>(),
      ));
  gh.factory<_i42.AddCarUseCase>(
      () => _i42.AddCarUseCase(gh<_i26.CarsRepository>()));
  gh.factory<_i43.DeleteCarUseCase>(
      () => _i43.DeleteCarUseCase(gh<_i26.CarsRepository>()));
  gh.factory<_i44.EditCarUseCase>(
      () => _i44.EditCarUseCase(gh<_i26.CarsRepository>()));
  gh.factory<_i45.GetAllCarsUseCase>(
      () => _i45.GetAllCarsUseCase(gh<_i26.CarsRepository>()));
  gh.factory<_i46.UploadImageCubit>(
      () => _i46.UploadImageCubit(gh<_i23.UploadImageUseCase>()));
  gh.factory<_i47.GetChatsUseCase>(
      () => _i47.GetChatsUseCase(gh<_i33.ChatRepository>()));
  gh.factory<_i48.GetMessagesUseCase>(
      () => _i48.GetMessagesUseCase(gh<_i33.ChatRepository>()));
  gh.factory<_i49.SendMessageUseCase>(
      () => _i49.SendMessageUseCase(gh<_i33.ChatRepository>()));
  gh.factory<_i50.LoginUseCase>(
      () => _i50.LoginUseCase(gh<_i39.AuthRepository>()));
  gh.factory<_i51.SignUpUseCase>(
      () => _i51.SignUpUseCase(gh<_i39.AuthRepository>()));
  gh.factory<_i52.VerificationPhoneNumberUseCase>(
      () => _i52.VerificationPhoneNumberUseCase(gh<_i39.AuthRepository>()));
  gh.factory<_i53.GetOrdersDoneUseCase>(
      () => _i53.GetOrdersDoneUseCase(gh<_i24.OrderRepository>()));
  gh.factory<_i54.GetActiveOrdersUseCase>(
      () => _i54.GetActiveOrdersUseCase(gh<_i24.OrderRepository>()));
  gh.factory<_i55.GetSubOrderDetailsUseCase>(
      () => _i55.GetSubOrderDetailsUseCase(gh<_i24.OrderRepository>()));
  gh.factory<_i56.SetDeliveredUseCase>(
      () => _i56.SetDeliveredUseCase(gh<_i24.OrderRepository>()));
  gh.lazySingleton<_i57.ProfileBloc>(() => _i57.ProfileBloc(
        gh<_i30.GetProfileUseCase>(),
        gh<_i29.EditPersonalInfoUseCase>(),
        gh<_i32.UploadSinglePhotoUseCase>(),
        gh<_i31.UpdatePhoneNumberUseCase>(),
        gh<_i28.DeleteAccountUseCase>(),
        gh<_i52.VerificationPhoneNumberUseCase>(),
      ));
  gh.factory<_i58.AuthBloc>(() => _i58.AuthBloc(
        gh<_i50.LoginUseCase>(),
        gh<_i51.SignUpUseCase>(),
        gh<_i52.VerificationPhoneNumberUseCase>(),
      ));
  gh.factory<_i59.CarsBloc>(() => _i59.CarsBloc(
        gh<_i45.GetAllCarsUseCase>(),
        gh<_i43.DeleteCarUseCase>(),
        gh<_i44.EditCarUseCase>(),
        gh<_i42.AddCarUseCase>(),
        gh<_i35.CarAdvantageUseCase>(),
      ));
  gh.factory<_i60.ChatBloc>(() => _i60.ChatBloc(
        gh<_i47.GetChatsUseCase>(),
        gh<_i48.GetMessagesUseCase>(),
        gh<_i49.SendMessageUseCase>(),
      ));
  gh.factory<_i61.OrderBloc>(() => _i61.OrderBloc(
        gh<_i53.GetOrdersDoneUseCase>(),
        gh<_i54.GetActiveOrdersUseCase>(),
        gh<_i56.SetDeliveredUseCase>(),
        gh<_i55.GetSubOrderDetailsUseCase>(),
      ));
  return getIt;
}

class _$AppModule extends _i62.AppModule {}
