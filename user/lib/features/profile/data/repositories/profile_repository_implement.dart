import 'package:injectable/injectable.dart';
import 'package:naqla/core/api/api_utils.dart';
import 'package:common_state/common_state.dart';
import 'package:naqla/features/profile/data/data_source/profile_remote_data_source.dart';
import 'package:naqla/features/profile/domain/repositories/profile_repository.dart';
import 'package:naqla/features/profile/domain/use_cases/edit_personal_info_use_case.dart';
import 'package:naqla/features/profile/domain/use_cases/upload_single_photo_use_case.dart';

import '../../../auth/data/model/user_model.dart';

@Injectable(as: ProfileRepository)
class ProfileRepositoryImplement implements ProfileRepository {
  final ProfileRemoteDataSource _dataSource;

  ProfileRepositoryImplement(this._dataSource);
  @override
  FutureResult<User> getPersonalInfo() {
    return toApiResult(() async => _dataSource.getPersonalInfo());
  }

  @override
  FutureResult<User> editPersonalInfo(EditPersonalInfoParam param) {
    return toApiResult(() async => _dataSource.editPersonalInfo(param));
  }

  @override
  FutureResult<String> uploadSinglePhoto(UploadSinglePhotoParam param) {
    return toApiResult(() async => _dataSource.uploadSinglePhoto(param));
  }

  @override
  FutureResult<String> updatePhoneNumber(String param) async {
    return toApiResult(() async => _dataSource.updatePhoneNumber(param));
  }

  @override
  FutureResult<void> deleteAccount() {
    return toApiResult(() async => _dataSource.deleteAccount());
  }
}
