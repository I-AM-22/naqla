import 'package:injectable/injectable.dart';
import 'package:naqla/core/type_definitions.dart';
import 'package:naqla/core/use_case/use_case.dart';
import 'package:naqla/features/profile/domain/repositories/profile_repository.dart';

@injectable
class UpdatePhoneNumberUseCase extends UseCase<String, String> {
  final ProfileRepository _repository;

  UpdatePhoneNumberUseCase(this._repository);
  @override
  FutureResult<String> call(String params) async {
    return _repository.updatePhoneNumber(params);
  }
}
