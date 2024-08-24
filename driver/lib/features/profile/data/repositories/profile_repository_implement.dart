import 'package:common_state/common_state.dart';
import 'package:injectable/injectable.dart';
import 'package:naqla_driver/core/api/api_utils.dart';
import 'package:naqla_driver/features/auth/data/model/driver_model.dart';
import 'package:naqla_driver/features/profile/data/datasource/profile_remote_data_source.dart';
import 'package:naqla_driver/features/profile/domain/repositories/profile_repository.dart';
import 'package:naqla_driver/features/profile/domain/usecases/edit_personal_info_use_case.dart';
import 'package:naqla_driver/features/profile/domain/usecases/upload_single_photo_use_case.dart';

@Injectable(as: ProfileRepository)
class ProfileRepositoryImplement implements ProfileRepository {
  final ProfileRemoteDataSource dataSource;

  ProfileRepositoryImplement(this.dataSource);
  @override
  FutureResult<DriverModel> getMyProfile() {
    return toApiResult(
      () async => await dataSource.getProfile(),
    );
  }

  @override
  FutureResult<DriverModel> editPersonalInfo(EditPersonalInfoParam param) {
    return toApiResult(() async => dataSource.editPersonalInfo(param));
  }

  @override
  FutureResult<String> uploadSinglePhoto(UploadSinglePhotoParam param) {
    return toApiResult(() async => dataSource.uploadSinglePhoto(param));
  }

  @override
  FutureResult<String> updatePhoneNumber(String param) async {
    return toApiResult(() async => dataSource.updatePhoneNumber(param));
  }

  @override
  FutureResult<void> deleteAccount() {
    return toApiResult(() async => dataSource.deleteAccount());
  }
}
