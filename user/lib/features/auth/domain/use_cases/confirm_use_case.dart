import 'package:injectable/injectable.dart';
import 'package:common_state/common_state.dart';
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
  final String phone;
  final bool phoneConfirm;

  ConfirmParam(this.phoneConfirm, {required this.otp, required this.phone});

  Map<String, dynamic> get map => {'otp': otp, 'phone': phone};
}
