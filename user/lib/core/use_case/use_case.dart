import 'package:common_state/common_state.dart';

abstract class UseCase<T, Params> {
  FutureResult<T> call(Params params);
}

class NoParams {}
