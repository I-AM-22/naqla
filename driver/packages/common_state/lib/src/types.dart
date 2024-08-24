import '../common_state.dart';

typedef FutureResult<T> = Future<Either<dynamic, T>>;
typedef States = Map<String, CommonState>;
typedef InstanceCreator<T> = T Function(States states);
