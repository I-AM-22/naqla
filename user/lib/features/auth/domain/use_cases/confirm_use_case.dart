import 'package:injectable/injectable.dart';
import 'package:naqla/core/type_definitions.dart';
import 'package:naqla/core/use_case/use_case.dart';
import 'package:naqla/features/auth/data/model/auth_model.dart';
import 'package:naqla/features/auth/domain/repositories/auth_repository.dart';

@injectable
class ConfirmUseCase extends UseCase<AuthModel, ConfirmParam> {
  final AuthRepository _repository;

  ConfirmUseCase(this._repository);
  @override
  FutureResult<AuthModel> call(ConfirmParam params) async {
    return _repository.confirm(params);
  }
}

class ConfirmParam {
  final String otp;

  ConfirmParam({required this.otp});

  Map<String, dynamic> get map => {'otp': otp};
}
