import 'dart:io';

import 'package:injectable/injectable.dart';
import 'package:common_state/common_state.dart';
import 'package:naqla/core/use_case/use_case.dart';
import 'package:naqla/features/home/domain/repositories/home_repository.dart';

@injectable
class UploadPhotosUseCase extends UseCase<List<String>, UploadPhotosParam> {
  final HomeRepository _repository;

  UploadPhotosUseCase(this._repository);
  @override
  FutureResult<List<String>> call(UploadPhotosParam params) async {
    return _repository.uploadMultiplePhoto(params);
  }
}

class UploadPhotosParam {
  final List<File?> photos;

  UploadPhotosParam({required this.photos});
}
