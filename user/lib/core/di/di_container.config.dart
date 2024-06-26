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
import 'package:logger/logger.dart' as _i5;
import 'package:shared_preferences/shared_preferences.dart' as _i4;

import '../../features/app/data/datasources/app_remote_data_source.dart' as _i9;
import '../../features/app/data/repositories/app_repository_implement.dart' as _i24;
import '../../features/app/data/repositories/prefs_repository_imp.dart' as _i8;
import '../../features/app/domain/repository/app_repository.dart' as _i23;
import '../../features/app/domain/repository/prefs_repository.dart' as _i7;
import '../../features/app/domain/usecases/upload_image_use_case.dart' as _i37;
import '../../features/app/presentation/state/bloc/app_bloc.dart' as _i6;
import '../../features/app/presentation/state/upload_image_cubit.dart' as _i52;
import '../../features/auth/data/data_sources/auth_remote_data_source.dart' as _i14;
import '../../features/auth/data/repositories/auth_repository_implement.dart' as _i16;
import '../../features/auth/domain/repositories/auth_repository.dart' as _i15;
import '../../features/auth/domain/use_cases/confirm_use_case.dart' as _i21;
import '../../features/auth/domain/use_cases/login_use_case.dart' as _i25;
import '../../features/auth/domain/use_cases/sign_up_use_case.dart' as _i22;
import '../../features/auth/presentation/state/bloc/auth_bloc.dart' as _i51;
import '../../features/chat/data/datasource/chat_remote_data_source.dart' as _i13;
import '../../features/chat/data/repositories/chat_repository_implement.dart' as _i20;
import '../../features/chat/domain/repositories/chat_repository.dart' as _i19;
import '../../features/chat/domain/usecases/get_chats_use_case.dart' as _i44;
import '../../features/chat/domain/usecases/get_messages_use_case.dart' as _i45;
import '../../features/chat/presentation/state/chat_bloc.dart' as _i53;
import '../../features/home/data/data_source/home_remote_data_source.dart' as _i10;
import '../../features/home/data/repositories/home_repository_implement.dart' as _i18;
import '../../features/home/domain/repositories/home_repository.dart' as _i17;
import '../../features/home/domain/use_case/accept_order_use_case.dart' as _i26;
import '../../features/home/domain/use_case/cancel_order_use_case.dart' as _i27;
import '../../features/home/domain/use_case/get_car_advantage_use_case.dart' as _i28;
import '../../features/home/domain/use_case/get_orders_use_case.dart' as _i29;
import '../../features/home/domain/use_case/set_order_use_case.dart' as _i30;
import '../../features/home/domain/use_case/upload_photos_use_case.dart' as _i31;
import '../../features/home/presentation/bloc/home_bloc.dart' as _i34;
import '../../features/orders/data/datasources/order_remote_data_source.dart' as _i11;
import '../../features/orders/data/repositories/order_repositoru_implement.dart' as _i36;
import '../../features/orders/domain/repositories/order_repository.dart' as _i35;
import '../../features/orders/domain/usecases/get_orders_use_case.dart' as _i38;
import '../../features/orders/domain/usecases/get_sub_order_details_use_case.dart' as _i40;
import '../../features/orders/domain/usecases/get_sub_orders_use_case.dart' as _i39;
import '../../features/orders/domain/usecases/set_arrived_use_case.dart' as _i41;
import '../../features/orders/domain/usecases/set_picked_up_use_case.dart' as _i42;
import '../../features/orders/presentation/state/order_bloc.dart' as _i43;
import '../../features/profile/data/data_source/profile_remote_data_source.dart' as _i12;
import '../../features/profile/data/repositories/profile_repository_implement.dart' as _i33;
import '../../features/profile/domain/repositories/profile_repository.dart' as _i32;
import '../../features/profile/domain/use_cases/delete_account_use_case.dart' as _i46;
import '../../features/profile/domain/use_cases/edit_personal_info_use_case.dart' as _i47;
import '../../features/profile/domain/use_cases/get_personal_info_use_case.dart' as _i48;
import '../../features/profile/domain/use_cases/update_phone_number_use_case.dart' as _i49;
import '../../features/profile/domain/use_cases/upload_single_photo_use_case.dart' as _i50;
import '../../features/profile/presentation/state/bloc/profile_bloc.dart' as _i54;
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
  await gh.singletonAsync<_i4.SharedPreferences>(
    () => appModule.sharedPreferences,
    preResolve: true,
  );
  gh.lazySingleton<_i5.Logger>(() => appModule.logger);
  gh.lazySingleton<_i6.AppCubit>(() => _i6.AppCubit());
  gh.factory<_i7.PrefsRepository>(() => _i8.PrefsRepositoryImpl(sharedPreferences: gh<_i4.SharedPreferences>()));
  gh.lazySingleton<_i3.Dio>(() => appModule.dio(
        gh<_i3.BaseOptions>(),
        gh<_i5.Logger>(),
      ));
  gh.factory<_i9.AppRemoteDataSource>(() => _i9.AppRemoteDataSource(gh<_i3.Dio>()));
  gh.factory<_i10.HomeRemoteDataSource>(() => _i10.HomeRemoteDataSource(gh<_i3.Dio>()));
  gh.factory<_i11.OrderRemoteDataSource>(() => _i11.OrderRemoteDataSource(gh<_i3.Dio>()));
  gh.factory<_i12.ProfileRemoteDataSource>(() => _i12.ProfileRemoteDataSource(gh<_i3.Dio>()));
  gh.factory<_i13.ChatRemoteDataSource>(() => _i13.ChatRemoteDataSource(gh<_i3.Dio>()));
  gh.factory<_i14.AuthRemoteDataSource>(() => _i14.AuthRemoteDataSource(gh<_i3.Dio>()));
  gh.factory<_i15.AuthRepository>(() => _i16.AuthRepositoryImplement(gh<_i14.AuthRemoteDataSource>()));
  gh.factory<_i17.HomeRepository>(() => _i18.HomeRepositoryImplement(gh<_i10.HomeRemoteDataSource>()));
  gh.factory<_i19.ChatRepository>(() => _i20.ChatRepositoryImplement(gh<_i13.ChatRemoteDataSource>()));
  gh.factory<_i21.ConfirmUseCase>(() => _i21.ConfirmUseCase(gh<_i15.AuthRepository>()));
  gh.factory<_i22.SignUpUseCase>(() => _i22.SignUpUseCase(gh<_i15.AuthRepository>()));
  gh.factory<_i23.AppRepository>(() => _i24.AppRepositoryImplement(gh<_i9.AppRemoteDataSource>()));
  gh.factory<_i25.LoginUseCase>(() => _i25.LoginUseCase(gh<_i15.AuthRepository>()));
  gh.factory<_i26.AcceptOrderUseCase>(() => _i26.AcceptOrderUseCase(gh<_i17.HomeRepository>()));
  gh.factory<_i27.CancelOrderUseCase>(() => _i27.CancelOrderUseCase(gh<_i17.HomeRepository>()));
  gh.factory<_i28.GetCarAdvantageUseCase>(() => _i28.GetCarAdvantageUseCase(gh<_i17.HomeRepository>()));
  gh.factory<_i29.GetAcceptOrdersUseCase>(() => _i29.GetAcceptOrdersUseCase(gh<_i17.HomeRepository>()));
  gh.factory<_i30.SetOrderUseCase>(() => _i30.SetOrderUseCase(gh<_i17.HomeRepository>()));
  gh.factory<_i31.UploadPhotosUseCase>(() => _i31.UploadPhotosUseCase(gh<_i17.HomeRepository>()));
  gh.factory<_i32.ProfileRepository>(() => _i33.ProfileRepositoryImplement(gh<_i12.ProfileRemoteDataSource>()));
  gh.lazySingleton<_i34.HomeBloc>(() => _i34.HomeBloc(
        gh<_i31.UploadPhotosUseCase>(),
        gh<_i28.GetCarAdvantageUseCase>(),
        gh<_i29.GetAcceptOrdersUseCase>(),
        gh<_i30.SetOrderUseCase>(),
        gh<_i26.AcceptOrderUseCase>(),
        gh<_i27.CancelOrderUseCase>(),
      ));
  gh.factory<_i35.OrderRepository>(() => _i36.OrderRepositoryImplement(gh<_i11.OrderRemoteDataSource>()));
  gh.factory<_i37.UploadImageUseCase>(() => _i37.UploadImageUseCase(gh<_i23.AppRepository>()));
  gh.factory<_i38.GetOrdersUseCase>(() => _i38.GetOrdersUseCase(gh<_i35.OrderRepository>()));
  gh.factory<_i39.GetSubOrdersUseCase>(() => _i39.GetSubOrdersUseCase(gh<_i35.OrderRepository>()));
  gh.factory<_i40.GetSubOrderDetailsUseCase>(() => _i40.GetSubOrderDetailsUseCase(gh<_i35.OrderRepository>()));
  gh.factory<_i41.SetArrivedUseCase>(() => _i41.SetArrivedUseCase(gh<_i35.OrderRepository>()));
  gh.factory<_i42.SetPickedUpUseCase>(() => _i42.SetPickedUpUseCase(gh<_i35.OrderRepository>()));
  gh.lazySingleton<_i43.OrderBloc>(() => _i43.OrderBloc(
        gh<_i38.GetOrdersUseCase>(),
        gh<_i39.GetSubOrdersUseCase>(),
        gh<_i41.SetArrivedUseCase>(),
        gh<_i42.SetPickedUpUseCase>(),
        gh<_i40.GetSubOrderDetailsUseCase>(),
      ));
  gh.factory<_i44.GetChatsUseCase>(() => _i44.GetChatsUseCase(gh<_i19.ChatRepository>()));
  gh.factory<_i45.GetMessagesUseCase>(() => _i45.GetMessagesUseCase(gh<_i19.ChatRepository>()));
  gh.factory<_i46.DeleteAccountUseCase>(() => _i46.DeleteAccountUseCase(gh<_i32.ProfileRepository>()));
  gh.factory<_i47.EditPersonalInfoUseCase>(() => _i47.EditPersonalInfoUseCase(gh<_i32.ProfileRepository>()));
  gh.factory<_i48.GetPersonalInfoUseCase>(() => _i48.GetPersonalInfoUseCase(gh<_i32.ProfileRepository>()));
  gh.factory<_i49.UpdatePhoneNumberUseCase>(() => _i49.UpdatePhoneNumberUseCase(gh<_i32.ProfileRepository>()));
  gh.factory<_i50.UploadSinglePhotoUseCase>(() => _i50.UploadSinglePhotoUseCase(gh<_i32.ProfileRepository>()));
  gh.factory<_i51.AuthBloc>(() => _i51.AuthBloc(
        gh<_i25.LoginUseCase>(),
        gh<_i22.SignUpUseCase>(),
        gh<_i21.ConfirmUseCase>(),
      ));
  gh.factory<_i52.UploadImageCubit>(() => _i52.UploadImageCubit(gh<_i37.UploadImageUseCase>()));
  gh.factory<_i53.ChatBloc>(() => _i53.ChatBloc(
        gh<_i44.GetChatsUseCase>(),
        gh<_i45.GetMessagesUseCase>(),
      ));
  gh.lazySingleton<_i54.ProfileBloc>(() => _i54.ProfileBloc(
        gh<_i48.GetPersonalInfoUseCase>(),
        gh<_i47.EditPersonalInfoUseCase>(),
        gh<_i50.UploadSinglePhotoUseCase>(),
        gh<_i49.UpdatePhoneNumberUseCase>(),
        gh<_i46.DeleteAccountUseCase>(),
        gh<_i21.ConfirmUseCase>(),
      ));
  return getIt;
}

class _$AppModule extends _i55.AppModule {}
