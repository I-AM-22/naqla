import 'dart:io';

import 'package:injectable/injectable.dart';
import 'package:naqla/core/type_definitions.dart';
import 'package:naqla/core/use_case/use_case.dart';
import 'package:naqla/features/profile/domain/repositories/profile_repository.dart';

@injectable
class UploadSinglePhotoUseCase extends UseCase<String, UploadSinglePhotoParam> {
  final ProfileRepository _repository;

  UploadSinglePhotoUseCase(this._repository);
  @override
  FutureResult<String> call(UploadSinglePhotoParam params) async {
    return _repository.uploadSinglePhoto(params);
  }
}

class UploadSinglePhotoParam {
  final File file;

  UploadSinglePhotoParam(this.file);
}
