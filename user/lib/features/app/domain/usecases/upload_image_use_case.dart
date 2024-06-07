import 'dart:io';

import 'package:common_state/common_state.dart';
import 'package:injectable/injectable.dart';
import 'package:naqla/core/use_case/use_case.dart';
import 'package:naqla/features/app/domain/repository/app_repository.dart';

@injectable
class UploadImageUseCase extends UseCase<String, File> {
  final AppRepository _repository;

  UploadImageUseCase(this._repository);
  @override
  FutureResult<String> call(File params) async {
    return _repository.uploadImageUseCase(params);
  }
}
