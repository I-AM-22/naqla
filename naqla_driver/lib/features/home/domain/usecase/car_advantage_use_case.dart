import 'package:common_state/common_state.dart';
import 'package:injectable/injectable.dart';
import 'package:naqla_driver/core/use_case/use_case.dart';
import 'package:naqla_driver/features/cars/data/model/car_advantage.dart';
import 'package:naqla_driver/features/home/domain/repositories/home_repository.dart';

@injectable
class CarAdvantageUseCase extends UseCase<List<CarAdvantage>, NoParams> {
  final HomeRepository _repository;

  CarAdvantageUseCase(this._repository);
  @override
  FutureResult<List<CarAdvantage>> call(NoParams params) async {
    return _repository.getCarAdvantage();
  }
}
