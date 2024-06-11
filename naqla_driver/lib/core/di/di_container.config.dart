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
import 'package:shared_preferences/shared_preferences.dart' as _i6;

import '../../features/app/data/datasources/app_remote_data_source.dart' as _i10;
import '../../features/app/data/repositories/app_repository_implement.dart' as _i14;
import '../../features/app/data/repositories/prefs_repository_imp.dart' as _i9;
import '../../features/app/domain/repository/app_repository.dart' as _i13;
import '../../features/app/domain/repository/prefs_repository.dart' as _i8;
import '../../features/app/domain/usecases/upload_image_use_case.dart' as _i17;
import '../../features/app/presentation/state/bloc/app_bloc.dart' as _i7;
import '../../features/app/presentation/state/upload_image_cubit.dart' as _i24;
import '../../features/auth/data/datasources/auth_local_data_source.dart' as _i4;
import '../../features/auth/data/datasources/auth_remote_data_source.dart' as _i11;
import '../../features/auth/data/repositories/auth_repository_implement.dart' as _i22;
import '../../features/auth/domain/repositories/auth_repository.dart' as _i21;
import '../../features/auth/domain/usecases/login_use_case.dart' as _i25;
import '../../features/auth/domain/usecases/signup_use_case.dart' as _i26;
import '../../features/auth/domain/usecases/verification_phone_number_use_case.dart' as _i27;
import '../../features/auth/presentation/state/auth_bloc.dart' as _i28;
import '../../features/home/data/datasource/home_remote_data_source.dart' as _i12;
import '../../features/home/data/repositories/home_repository_implement.dart' as _i16;
import '../../features/home/domain/repositories/home_repository.dart' as _i15;
import '../../features/home/domain/usecase/add_car_use_case.dart' as _i18;
import '../../features/home/domain/usecase/car_advantage_use_case.dart' as _i19;
import '../../features/home/domain/usecase/get_sub_orders_use_case.dart' as _i20;
import '../../features/home/presentation/state/home_bloc.dart' as _i23;
import 'di_container.dart' as _i29;

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
  gh.singleton<_i5.Logger>(() => appModule.logger);
  await gh.singletonAsync<_i6.SharedPreferences>(
    () => appModule.sharedPreferences,
    preResolve: true,
  );
  gh.lazySingleton<_i7.AppCubit>(() => _i7.AppCubit());
  gh.factory<_i8.PrefsRepository>(() => _i9.PrefsRepositoryImpl(sharedPreferences: gh<_i6.SharedPreferences>()));
  gh.lazySingleton<_i3.Dio>(() => appModule.dio(
        gh<_i3.BaseOptions>(),
        gh<_i5.Logger>(),
      ));
  gh.factory<_i10.AppRemoteDataSource>(() => _i10.AppRemoteDataSource(gh<_i3.Dio>()));
  gh.factory<_i11.AuthRemoteDataSource>(() => _i11.AuthRemoteDataSource(gh<_i3.Dio>()));
  gh.factory<_i12.HomeRemoteDataSource>(() => _i12.HomeRemoteDataSource(gh<_i3.Dio>()));
  gh.factory<_i13.AppRepository>(() => _i14.AppRepositoryImplement(gh<_i10.AppRemoteDataSource>()));
  gh.factory<_i15.HomeRepository>(() => _i16.HomeRepositoryImplement(gh<_i12.HomeRemoteDataSource>()));
  gh.factory<_i17.UploadImageUseCase>(() => _i17.UploadImageUseCase(gh<_i13.AppRepository>()));
  gh.factory<_i18.AddCarUseCase>(() => _i18.AddCarUseCase(gh<_i15.HomeRepository>()));
  gh.factory<_i19.CarAdvantageUseCase>(() => _i19.CarAdvantageUseCase(gh<_i15.HomeRepository>()));
  gh.factory<_i20.GetSubOrdersUseCase>(() => _i20.GetSubOrdersUseCase(gh<_i15.HomeRepository>()));
  gh.factory<_i21.AuthRepository>(() => _i22.AuthRepositoryImplement(
        gh<_i11.AuthRemoteDataSource>(),
        gh<_i4.AuthLocaleDataSource>(),
      ));
  gh.factory<_i23.HomeBloc>(() => _i23.HomeBloc(
        gh<_i18.AddCarUseCase>(),
        gh<_i19.CarAdvantageUseCase>(),
        gh<_i20.GetSubOrdersUseCase>(),
      ));
  gh.factory<_i24.UploadImageCubit>(() => _i24.UploadImageCubit(gh<_i17.UploadImageUseCase>()));
  gh.factory<_i25.LoginUseCase>(() => _i25.LoginUseCase(gh<_i21.AuthRepository>()));
  gh.factory<_i26.SignUpUseCase>(() => _i26.SignUpUseCase(gh<_i21.AuthRepository>()));
  gh.factory<_i27.VerificationPhoneNumberUseCase>(() => _i27.VerificationPhoneNumberUseCase(gh<_i21.AuthRepository>()));
  gh.factory<_i28.AuthBloc>(() => _i28.AuthBloc(
        gh<_i25.LoginUseCase>(),
        gh<_i26.SignUpUseCase>(),
        gh<_i27.VerificationPhoneNumberUseCase>(),
      ));
  return getIt;
}

class _$AppModule extends _i29.AppModule {}
