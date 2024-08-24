import 'package:common_state/common_state.dart';
import 'package:injectable/injectable.dart';
import 'package:naqla_driver/features/cars/data/datasources/cars_remote_data_source.dart';
import 'package:naqla_driver/features/cars/domain/repositories/cars_repository.dart';

import '../../../../core/api/api_utils.dart';
import '../../domain/usecases/add_car_use_case.dart';
import '../../domain/usecases/edit_car_use_case.dart';
import '../model/car_model.dart';

@Injectable(as: CarsRepository)
class CarsRepositoryImplement implements CarsRepository {
  final CarsRemoteDataSource dataSource;

  CarsRepositoryImplement(this.dataSource);
  @override
  FutureResult<List<CarModel>> getAllCars() {
    return toApiResult(
      () => dataSource.getAllCars(),
    );
  }

  @override
  FutureResult<CarModel> addCar(AddCarParam params) {
    return toApiResult(
      () => dataSource.addCar(params),
    );
  }

  @override
  FutureResult<void> deleteCar(String id) {
    return toApiResult(
      () => dataSource.deleteCar(id),
    );
  }

  @override
  FutureResult<CarModel> editCar(EditCarParam params) {
    return toApiResult(
      () => dataSource.editCar(params),
    );
  }
}
