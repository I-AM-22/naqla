import 'dart:io';

import 'package:common_state/common_state.dart';

abstract class AppRepository {
  FutureResult<String> uploadImageUseCase(File file);
}
