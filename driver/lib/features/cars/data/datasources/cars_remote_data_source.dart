import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/api/api_utils.dart';
import '../../../../core/common/constants/configuration/api_routes.dart';
import '../../domain/usecases/add_car_use_case.dart';
import '../../domain/usecases/edit_car_use_case.dart';
import '../model/car_model.dart';

@injectable
class CarsRemoteDataSource {
  final Dio dio;

  CarsRemoteDataSource(this.dio);
  Future<List<CarModel>> getAllCars() {
    return throwAppException(
      () async {
        final result = await dio.get(ApiRoutes.carsMine);
        return (result.data as List)
            .map(
              (e) => CarModel.fromJson(e),
            )
            .toList();
      },
    );
  }

  Future<void> deleteCar(String id) {
    return throwAppException(
      () async {
        await dio.delete(ApiRoutes.deleteCar(id));
      },
    );
  }

  Future<CarModel> addCar(AddCarParam params) {
    return throwAppException(
      () async {
        final result = await dio.post(ApiRoutes.cars, data: params.toMap);
        return CarModel.fromJson(result.data);
      },
    );
  }

  Future<CarModel> editCar(EditCarParam params) {
    return throwAppException(
      () async {
        final result = await dio.patch(ApiRoutes.editCar(params.id!), data: params.toMap);

        return CarModel.fromJson(result.data);
      },
    );
  }
}
