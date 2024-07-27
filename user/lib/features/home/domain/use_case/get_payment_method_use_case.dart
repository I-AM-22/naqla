import 'package:common_state/common_state.dart';
import 'package:injectable/injectable.dart';
import 'package:naqla/core/use_case/use_case.dart';
import 'package:naqla/features/home/domain/repositories/home_repository.dart';

@injectable
class GetPaymentMethodUseCase extends UseCase<List<String>, NoParams> {
  final HomeRepository _repository;

  GetPaymentMethodUseCase(this._repository);
  @override
  FutureResult<List<String>> call(NoParams params) async {
    return _repository.getPaymentMethod();
  }
}
