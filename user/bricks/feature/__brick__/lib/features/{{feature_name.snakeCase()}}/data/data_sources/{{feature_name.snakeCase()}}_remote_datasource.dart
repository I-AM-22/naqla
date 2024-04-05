import 'package:injectable/injectable.dart';
import 'package:dio/dio.dart';
import 'package:naqla/core/api/api_utils.dart';

@injectable
class {{feature_name.pascalCase()}}RemoteDataSource {

{{feature_name.pascalCase()}}RemoteDataSource({required this.dio});
final Dio dio;


Future<String> get() async {
return throwAppException(() async {
final result = await dio.get("");
return result.data;
});
}

}
