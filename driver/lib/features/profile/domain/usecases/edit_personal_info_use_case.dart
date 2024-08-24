import 'package:injectable/injectable.dart';
import 'package:common_state/common_state.dart';
import 'package:naqla_driver/features/auth/data/model/driver_model.dart';

import '../../../../core/use_case/use_case.dart';
import '../repositories/profile_repository.dart';

@injectable
class EditPersonalInfoUseCase extends UseCase<DriverModel, EditPersonalInfoParam> {
  final ProfileRepository _repository;

  EditPersonalInfoUseCase(this._repository);
  @override
  FutureResult<DriverModel> call(EditPersonalInfoParam params) async {
    return _repository.editPersonalInfo(params);
  }
}

class EditPersonalInfoParam {
  final String firstName;
  final String lastName;
  final String photo;

  EditPersonalInfoParam({required this.firstName, required this.lastName, required this.photo});

  Map<String, dynamic> get map {
    return photo.isEmpty
        ? {
            "firstName": firstName,
            "lastName": lastName,
          }
        : {
            "firstName": firstName,
            "lastName": lastName,
            "photo": photo,
          };
  }
}
