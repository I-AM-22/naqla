import 'package:injectable/injectable.dart';
import 'package:naqla/core/api/api_utils.dart';
import 'package:naqla/core/type_definitions.dart';
import 'package:naqla/features/home/data/data_source/home_remote_data_source.dart';
import 'package:naqla/features/home/domain/repositories/home_repository.dart';
import 'package:naqla/features/home/domain/use_case/upload_photos_use_case.dart';

@Injectable(as: HomeRepository)
class HomeRepositoryImplement extends HomeRepository {
  final HomeRemoteDataSource dataSource;

  HomeRepositoryImplement(this.dataSource);
  @override
  FutureResult<List<String>> uploadMultiplePhoto(UploadPhotosParam param) {
    return toApiResult(() => dataSource.uploadPhotos(param));
  }
}
