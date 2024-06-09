import 'dart:io';

import 'package:common_state/common_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../domain/usecases/upload_image_use_case.dart';

@injectable
class UploadImageCubit extends Cubit<CommonState<String>> {
  final UploadImageUseCase uploadImageUseCase;
  UploadImageCubit(this.uploadImageUseCase) : super(const InitialState());

  uploadImage(File file) => apiCall(
        () => uploadImageUseCase(file),
      );
}
