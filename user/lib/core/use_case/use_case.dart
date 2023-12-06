abstract class UseCase<T, Params> {
  Future<T> call(Params params);
}

abstract class UseCaseNoParam<T> {
  Future<T> call();
}

class NoParams {}
