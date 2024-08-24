import 'dart:io';

import 'package:common_state/common_state.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/api/api_utils.dart';
import '../../domain/repository/app_repository.dart';
import '../datasources/app_remote_data_source.dart';

@Injectable(as: AppRepository)
class AppRepositoryImplement implements AppRepository {
  final AppRemoteDataSource dataSource;

  AppRepositoryImplement(this.dataSource);
  @override
  FutureResult<String> uploadImageUseCase(File file) {
    return toApiResult(
      () async => await dataSource.uploadImage(file),
    );
  }
}
