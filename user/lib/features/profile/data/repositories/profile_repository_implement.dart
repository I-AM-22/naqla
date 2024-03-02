import 'package:injectable/injectable.dart';
import 'package:naqla/core/api/api_utils.dart';
import 'package:naqla/core/type_definitions.dart';
import 'package:naqla/features/auth/data/model/auth_model.dart';
import 'package:naqla/features/profile/data/data_source/profile_remote_data_source.dart';
import 'package:naqla/features/profile/domain/repositories/profile_repository.dart';

@Injectable(as: ProfileRepository)
class ProfileRepositoryImplement implements ProfileRepository {
  final ProfileRemoteDataSource _dataSource;

  ProfileRepositoryImplement(this._dataSource);
  @override
  FutureResult<User> getPersonalInfo() {
    return toApiResult(() async => _dataSource.getPersonalInfo());
  }
}
