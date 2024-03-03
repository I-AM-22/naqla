import 'package:injectable/injectable.dart';
import 'package:naqla/core/type_definitions.dart';
import 'package:naqla/core/use_case/use_case.dart';
import 'package:naqla/features/auth/data/model/auth_model.dart';
import 'package:naqla/features/profile/domain/repositories/profile_repository.dart';

@injectable
class GetPersonalInfoUseCase extends UseCase<User, NoParams> {
  final ProfileRepository _repository;

  GetPersonalInfoUseCase(this._repository);
  @override
  FutureResult<User> call(NoParams params) async {
    return _repository.getPersonalInfo();
  }
}