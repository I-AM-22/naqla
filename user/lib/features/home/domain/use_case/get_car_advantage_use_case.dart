import 'package:injectable/injectable.dart';
import 'package:common_state/common_state.dart';
import 'package:naqla/core/use_case/use_case.dart';
import 'package:naqla/features/home/data/model/car_advantage.dart';
import 'package:naqla/features/home/domain/repositories/home_repository.dart';

@injectable
class GetCarAdvantageUseCase extends UseCase<List<CarAdvantage>, NoParams> {
  final HomeRepository _repository;

  GetCarAdvantageUseCase(this._repository);
  @override
  FutureResult<List<CarAdvantage>> call(NoParams params) async {
    return _repository.getCarAdvantages();
  }
}
