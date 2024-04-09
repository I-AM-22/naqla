import 'package:injectable/injectable.dart';
import 'package:common_state/common_state.dart';
import 'package:naqla/core/use_case/use_case.dart';
import 'package:naqla/features/profile/domain/repositories/profile_repository.dart';

import '../../../auth/data/model/user_model.dart';

@injectable
class EditPersonalInfoUseCase extends UseCase<User, EditPersonalInfoParam> {
  final ProfileRepository _repository;

  EditPersonalInfoUseCase(this._repository);
  @override
  FutureResult<User> call(EditPersonalInfoParam params) async {
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
