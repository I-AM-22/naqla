import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:common_state/common_state.dart';
import '../data_sources/{{feature_name.snakeCase()}}_remote_datasource.dart';
import '../../domain/repositories/{{feature_name.snakeCase()}}_repository.dart';


@Injectable(as: {{feature_name.pascalCase()}}Repository)
class {{feature_name.pascalCase()}}RepositoryImp implements {{feature_name.pascalCase()}}Repository {

final {{feature_name.pascalCase()}}RemoteDataSource dataSource;
{{feature_name.pascalCase()}}RepositoryImp({required this.dataSource});

@override
FutureResult<String> get() async {
return Right(await dataSource.get());
}
}





