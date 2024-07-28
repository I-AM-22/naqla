// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:dio/dio.dart' as _i361;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;
import 'package:logger/logger.dart' as _i974;
import 'package:shared_preferences/shared_preferences.dart' as _i460;

import '../../features/app/data/datasources/app_remote_data_source.dart'
    as _i767;
import '../../features/app/data/repositories/app_repository_implement.dart'
    as _i497;
import '../../features/app/data/repositories/prefs_repository_imp.dart'
    as _i129;
import '../../features/app/domain/repository/app_repository.dart' as _i544;
import '../../features/app/domain/repository/prefs_repository.dart' as _i68;
import '../../features/app/domain/usecases/upload_image_use_case.dart' as _i146;
import '../../features/app/presentation/state/bloc/app_bloc.dart' as _i686;
import '../../features/app/presentation/state/upload_image_cubit.dart' as _i357;
import '../../features/auth/data/data_sources/auth_remote_data_source.dart'
    as _i25;
import '../../features/auth/data/repositories/auth_repository_implement.dart'
    as _i163;
import '../../features/auth/domain/repositories/auth_repository.dart' as _i787;
import '../../features/auth/domain/use_cases/confirm_use_case.dart' as _i187;
import '../../features/auth/domain/use_cases/login_use_case.dart' as _i1038;
import '../../features/auth/domain/use_cases/sign_up_use_case.dart' as _i179;
import '../../features/auth/presentation/state/bloc/auth_bloc.dart' as _i852;
import '../../features/chat/data/datasource/chat_remote_data_source.dart'
    as _i240;
import '../../features/chat/data/repositories/chat_repository_implement.dart'
    as _i316;
import '../../features/chat/domain/repositories/chat_repository.dart' as _i420;
import '../../features/chat/domain/usecases/get_chats_use_case.dart' as _i303;
import '../../features/chat/domain/usecases/get_messages_use_case.dart'
    as _i671;
import '../../features/chat/domain/usecases/send_message_use_case.dart'
    as _i500;
import '../../features/chat/presentation/state/chat_bloc.dart' as _i649;
import '../../features/home/data/data_source/home_remote_data_source.dart'
    as _i283;
import '../../features/home/data/repositories/home_repository_implement.dart'
    as _i228;
import '../../features/home/domain/repositories/home_repository.dart' as _i0;
import '../../features/home/domain/use_case/accept_order_use_case.dart'
    as _i222;
import '../../features/home/domain/use_case/cancel_order_use_case.dart'
    as _i571;
import '../../features/home/domain/use_case/get_car_advantage_use_case.dart'
    as _i834;
import '../../features/home/domain/use_case/get_orders_use_case.dart' as _i551;
import '../../features/home/domain/use_case/set_order_use_case.dart' as _i30;
import '../../features/home/domain/use_case/upload_photos_use_case.dart'
    as _i579;
import '../../features/home/presentation/bloc/home_bloc.dart' as _i202;
import '../../features/orders/data/datasources/order_remote_data_source.dart'
    as _i1011;
import '../../features/orders/data/repositories/order_repositoru_implement.dart'
    as _i611;
import '../../features/orders/domain/repositories/order_repository.dart'
    as _i543;
import '../../features/orders/domain/usecases/get_active_orders_use_case.dart'
    as _i582;
import '../../features/orders/domain/usecases/get_done_orders_use_case.dart'
    as _i581;
import '../../features/orders/domain/usecases/get_sub_order_details_use_case.dart'
    as _i471;
import '../../features/orders/domain/usecases/get_sub_orders_use_case.dart'
    as _i165;
import '../../features/orders/domain/usecases/rating_use_case.dart' as _i767;
import '../../features/orders/domain/usecases/set_arrived_use_case.dart'
    as _i313;
import '../../features/orders/domain/usecases/set_picked_up_use_case.dart'
    as _i772;
import '../../features/orders/presentation/state/order_bloc.dart' as _i975;
import '../../features/profile/data/data_source/profile_remote_data_source.dart'
    as _i998;
import '../../features/profile/data/repositories/profile_repository_implement.dart'
    as _i904;
import '../../features/profile/domain/repositories/profile_repository.dart'
    as _i894;
import '../../features/profile/domain/use_cases/delete_account_use_case.dart'
    as _i546;
import '../../features/profile/domain/use_cases/edit_personal_info_use_case.dart'
    as _i408;
import '../../features/profile/domain/use_cases/get_personal_info_use_case.dart'
    as _i774;
import '../../features/profile/domain/use_cases/update_phone_number_use_case.dart'
    as _i591;
import '../../features/profile/domain/use_cases/upload_single_photo_use_case.dart'
    as _i641;
import '../../features/profile/presentation/state/bloc/profile_bloc.dart'
    as _i710;
import 'di_container.dart' as _i198;

// initializes the registration of main-scope dependencies inside of GetIt
Future<_i174.GetIt> $initGetIt(
  _i174.GetIt getIt, {
  String? environment,
  _i526.EnvironmentFilter? environmentFilter,
}) async {
  final gh = _i526.GetItHelper(
    getIt,
    environment,
    environmentFilter,
  );
  final appModule = _$AppModule();
  gh.factory<_i361.BaseOptions>(() => appModule.dioOption);
  await gh.singletonAsync<_i460.SharedPreferences>(
    () => appModule.sharedPreferences,
    preResolve: true,
  );
  gh.lazySingleton<_i974.Logger>(() => appModule.logger);
  gh.lazySingleton<_i686.AppCubit>(() => _i686.AppCubit());
  gh.factory<_i68.PrefsRepository>(() => _i129.PrefsRepositoryImpl(
      sharedPreferences: gh<_i460.SharedPreferences>()));
  gh.lazySingleton<_i361.Dio>(() => appModule.dio(
        gh<_i361.BaseOptions>(),
        gh<_i974.Logger>(),
      ));
  gh.factory<_i767.AppRemoteDataSource>(
      () => _i767.AppRemoteDataSource(gh<_i361.Dio>()));
  gh.factory<_i240.ChatRemoteDataSource>(
      () => _i240.ChatRemoteDataSource(gh<_i361.Dio>()));
  gh.factory<_i283.HomeRemoteDataSource>(
      () => _i283.HomeRemoteDataSource(gh<_i361.Dio>()));
  gh.factory<_i1011.OrderRemoteDataSource>(
      () => _i1011.OrderRemoteDataSource(gh<_i361.Dio>()));
  gh.factory<_i998.ProfileRemoteDataSource>(
      () => _i998.ProfileRemoteDataSource(gh<_i361.Dio>()));
  gh.factory<_i25.AuthRemoteDataSource>(
      () => _i25.AuthRemoteDataSource(gh<_i361.Dio>()));
  gh.factory<_i787.AuthRepository>(
      () => _i163.AuthRepositoryImplement(gh<_i25.AuthRemoteDataSource>()));
  gh.factory<_i0.HomeRepository>(
      () => _i228.HomeRepositoryImplement(gh<_i283.HomeRemoteDataSource>()));
  gh.factory<_i420.ChatRepository>(
      () => _i316.ChatRepositoryImplement(gh<_i240.ChatRemoteDataSource>()));
  gh.factory<_i187.ConfirmUseCase>(
      () => _i187.ConfirmUseCase(gh<_i787.AuthRepository>()));
  gh.factory<_i179.SignUpUseCase>(
      () => _i179.SignUpUseCase(gh<_i787.AuthRepository>()));
  gh.factory<_i544.AppRepository>(
      () => _i497.AppRepositoryImplement(gh<_i767.AppRemoteDataSource>()));
  gh.factory<_i1038.LoginUseCase>(
      () => _i1038.LoginUseCase(gh<_i787.AuthRepository>()));
  gh.factory<_i222.AcceptOrderUseCase>(
      () => _i222.AcceptOrderUseCase(gh<_i0.HomeRepository>()));
  gh.factory<_i571.CancelOrderUseCase>(
      () => _i571.CancelOrderUseCase(gh<_i0.HomeRepository>()));
  gh.factory<_i834.GetCarAdvantageUseCase>(
      () => _i834.GetCarAdvantageUseCase(gh<_i0.HomeRepository>()));
  gh.factory<_i551.GetAcceptOrdersUseCase>(
      () => _i551.GetAcceptOrdersUseCase(gh<_i0.HomeRepository>()));
  gh.factory<_i30.SetOrderUseCase>(
      () => _i30.SetOrderUseCase(gh<_i0.HomeRepository>()));
  gh.factory<_i579.UploadPhotosUseCase>(
      () => _i579.UploadPhotosUseCase(gh<_i0.HomeRepository>()));
  gh.factory<_i894.ProfileRepository>(() =>
      _i904.ProfileRepositoryImplement(gh<_i998.ProfileRemoteDataSource>()));
  gh.lazySingleton<_i202.HomeBloc>(() => _i202.HomeBloc(
        gh<_i579.UploadPhotosUseCase>(),
        gh<_i834.GetCarAdvantageUseCase>(),
        gh<_i551.GetAcceptOrdersUseCase>(),
        gh<_i30.SetOrderUseCase>(),
        gh<_i222.AcceptOrderUseCase>(),
        gh<_i571.CancelOrderUseCase>(),
      ));
  gh.factory<_i543.OrderRepository>(
      () => _i611.OrderRepositoryImplement(gh<_i1011.OrderRemoteDataSource>()));
  gh.factory<_i146.UploadImageUseCase>(
      () => _i146.UploadImageUseCase(gh<_i544.AppRepository>()));
  gh.factory<_i582.GetActiveOrdersUseCase>(
      () => _i582.GetActiveOrdersUseCase(gh<_i543.OrderRepository>()));
  gh.factory<_i581.GetDoneOrdersUseCase>(
      () => _i581.GetDoneOrdersUseCase(gh<_i543.OrderRepository>()));
  gh.factory<_i165.GetSubOrdersUseCase>(
      () => _i165.GetSubOrdersUseCase(gh<_i543.OrderRepository>()));
  gh.factory<_i471.GetSubOrderDetailsUseCase>(
      () => _i471.GetSubOrderDetailsUseCase(gh<_i543.OrderRepository>()));
  gh.factory<_i767.RatingUseCase>(
      () => _i767.RatingUseCase(gh<_i543.OrderRepository>()));
  gh.factory<_i313.SetArrivedUseCase>(
      () => _i313.SetArrivedUseCase(gh<_i543.OrderRepository>()));
  gh.factory<_i772.SetPickedUpUseCase>(
      () => _i772.SetPickedUpUseCase(gh<_i543.OrderRepository>()));
  gh.factory<_i303.GetChatsUseCase>(
      () => _i303.GetChatsUseCase(gh<_i420.ChatRepository>()));
  gh.factory<_i671.GetMessagesUseCase>(
      () => _i671.GetMessagesUseCase(gh<_i420.ChatRepository>()));
  gh.factory<_i500.SendMessageUseCase>(
      () => _i500.SendMessageUseCase(gh<_i420.ChatRepository>()));
  gh.lazySingleton<_i975.OrderBloc>(() => _i975.OrderBloc(
        gh<_i582.GetActiveOrdersUseCase>(),
        gh<_i165.GetSubOrdersUseCase>(),
        gh<_i313.SetArrivedUseCase>(),
        gh<_i772.SetPickedUpUseCase>(),
        gh<_i471.GetSubOrderDetailsUseCase>(),
        gh<_i581.GetDoneOrdersUseCase>(),
        gh<_i767.RatingUseCase>(),
      ));
  gh.factory<_i546.DeleteAccountUseCase>(
      () => _i546.DeleteAccountUseCase(gh<_i894.ProfileRepository>()));
  gh.factory<_i408.EditPersonalInfoUseCase>(
      () => _i408.EditPersonalInfoUseCase(gh<_i894.ProfileRepository>()));
  gh.factory<_i774.GetPersonalInfoUseCase>(
      () => _i774.GetPersonalInfoUseCase(gh<_i894.ProfileRepository>()));
  gh.factory<_i591.UpdatePhoneNumberUseCase>(
      () => _i591.UpdatePhoneNumberUseCase(gh<_i894.ProfileRepository>()));
  gh.factory<_i641.UploadSinglePhotoUseCase>(
      () => _i641.UploadSinglePhotoUseCase(gh<_i894.ProfileRepository>()));
  gh.factory<_i852.AuthBloc>(() => _i852.AuthBloc(
        gh<_i1038.LoginUseCase>(),
        gh<_i179.SignUpUseCase>(),
        gh<_i187.ConfirmUseCase>(),
      ));
  gh.factory<_i649.ChatBloc>(() => _i649.ChatBloc(
        gh<_i303.GetChatsUseCase>(),
        gh<_i671.GetMessagesUseCase>(),
        gh<_i500.SendMessageUseCase>(),
      ));
  gh.factory<_i357.UploadImageCubit>(
      () => _i357.UploadImageCubit(gh<_i146.UploadImageUseCase>()));
  gh.lazySingleton<_i710.ProfileBloc>(() => _i710.ProfileBloc(
        gh<_i774.GetPersonalInfoUseCase>(),
        gh<_i408.EditPersonalInfoUseCase>(),
        gh<_i641.UploadSinglePhotoUseCase>(),
        gh<_i591.UpdatePhoneNumberUseCase>(),
        gh<_i546.DeleteAccountUseCase>(),
        gh<_i187.ConfirmUseCase>(),
      ));
  return getIt;
}

class _$AppModule extends _i198.AppModule {}
