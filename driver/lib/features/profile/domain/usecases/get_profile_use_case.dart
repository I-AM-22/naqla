import 'package:common_state/common_state.dart';
import 'package:injectable/injectable.dart';
import 'package:naqla_driver/core/use_case/use_case.dart';
import 'package:naqla_driver/features/auth/data/model/driver_model.dart';
import 'package:naqla_driver/features/profile/domain/repositories/profile_repository.dart';

@injectable
class GetProfileUseCase extends UseCase<DriverModel, NoParams> {
  final ProfileRepository _repository;

  GetProfileUseCase(this._repository);
  @override
  FutureResult<DriverModel> call(NoParams params) async {
    return _repository.getMyProfile();
  }
}
