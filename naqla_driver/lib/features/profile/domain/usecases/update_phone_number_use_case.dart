import 'package:injectable/injectable.dart';
import 'package:common_state/common_state.dart';

import '../../../../core/use_case/use_case.dart';
import '../repositories/profile_repository.dart';

@injectable
class UpdatePhoneNumberUseCase extends UseCase<String, String> {
  final ProfileRepository _repository;

  UpdatePhoneNumberUseCase(this._repository);
  @override
  FutureResult<String> call(String params) async {
    return _repository.updatePhoneNumber(params);
  }
}
