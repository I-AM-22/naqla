import 'package:common_state/common_state.dart';

import '../../../auth/data/model/user_model.dart';
import '../use_cases/edit_personal_info_use_case.dart';
import '../use_cases/upload_single_photo_use_case.dart';

abstract class ProfileRepository {
  FutureResult<User> getPersonalInfo();
  FutureResult<User> editPersonalInfo(EditPersonalInfoParam param);
  FutureResult<String> uploadSinglePhoto(UploadSinglePhotoParam param);
  FutureResult<String> updatePhoneNumber(String param);
  FutureResult<void> deleteAccount();
}
