import 'package:injectable/injectable.dart';
import 'package:common_state/common_state.dart';
import 'package:naqla/core/use_case/use_case.dart';
import 'package:naqla/features/profile/domain/repositories/profile_repository.dart';

@injectable
class DeleteAccountUseCase extends UseCase<void, NoParams> {
  final ProfileRepository _repository;

  DeleteAccountUseCase(this._repository);
  @override
  FutureResult<void> call(NoParams params) async {
    return _repository.deleteAccount();
  }
}
