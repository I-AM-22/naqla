import 'package:injectable/injectable.dart';
import 'package:naqla/core/type_definitions.dart';
import 'package:naqla/core/use_case/use_case.dart';
import 'package:naqla/features/profile/domain/repositories/profile_repository.dart';

import '../../../auth/data/model/auth_model.dart';

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
  final String name;
  final String phone;
  final String photo;

  EditPersonalInfoParam(
      {required this.name, required this.phone, required this.photo});

  Map<String, dynamic> get map =>
      {"name": name, "phone": phone, "photo": photo};
}
