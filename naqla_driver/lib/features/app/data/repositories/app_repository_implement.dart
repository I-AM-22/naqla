import 'dart:io';

import 'package:common_state/common_state.dart';
import 'package:injectable/injectable.dart';
import 'package:naqla_driver/features/home/data/model/car_model.dart';
import 'package:naqla_driver/features/home/domain/usecase/add_car_use_case.dart';

import '../../../../core/api/api_utils.dart';
import '../../domain/repository/app_repository.dart';
import '../datasources/app_remote_data_source.dart';

@Injectable(as: AppRepository)
class AppRepositoryImplement implements AppRepository {
  final AppRemoteDataSource dataSource;

  AppRepositoryImplement(this.dataSource);
  @override
  FutureResult<String> uploadImageUseCase(File file) {
    return toApiResult(
      () async => await dataSource.uploadImage(file),
    );
  }

  @override
  FutureResult<List<CarModel>> getAllCars() {
    return toApiResult(
      () => dataSource.getAllCars(),
    );
  }

  @override
  FutureResult<void> deleteCar(String id) {
    return toApiResult(
      () => dataSource.deleteCar(id),
    );
  }

  @override
  FutureResult<CarModel> editCar(AddCarParam params) {
    return toApiResult(
      () => dataSource.editCar(params),
    );
  }
}
