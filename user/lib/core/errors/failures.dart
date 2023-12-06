import 'package:dio/dio.dart';

abstract class Failure {
  final String message;
  final dynamic error;

  const Failure(this.message, [this.error]);
}

class OfflineFailure extends Failure {
  const OfflineFailure({String? message}) : super(message ?? "OfflineFailure");
}

class ServerFailure extends Failure {
  const ServerFailure({String? message}) : super(message ?? "ServerFailure");
}

class EmptyCacheFailure extends Failure {
  const EmptyCacheFailure({String? message})
      : super(message ?? "EmptyCacheFailure");
}

class NoImageFailure extends Failure {
  const NoImageFailure({String? message}) : super(message ?? "NoImageFailure");
}

class DioFailure extends Failure {
  const DioFailure({String? message, DioError? error})
      : super(message ?? "DioFailure", error);
}
