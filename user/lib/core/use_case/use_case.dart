import 'package:naqla/core/type_definitions.dart';

abstract class UseCase<T, Params> {
  FutureResult<T> call(Params params);
}

class NoParams {}
