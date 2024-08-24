import 'package:common_state/common_state.dart';
import 'package:naqla_driver/features/auth/data/model/driver_model.dart';

import '../usecases/edit_personal_info_use_case.dart';
import '../usecases/upload_single_photo_use_case.dart';

abstract class ProfileRepository {
  FutureResult<DriverModel> getMyProfile();

  FutureResult<DriverModel> editPersonalInfo(EditPersonalInfoParam param);

  FutureResult<String> uploadSinglePhoto(UploadSinglePhotoParam param);

  FutureResult<String> updatePhoneNumber(String param);

  FutureResult<void> deleteAccount();
}
