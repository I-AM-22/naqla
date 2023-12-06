import 'package:user/core/api/exceptions.dart';

sealed class Result<S> {
  const Result();

  fold(Function(AppException exception, String? message) onFailure,
      Function(S value) onSuccess) {
    if (this is Success) {
      onSuccess((this as Success).value);
      return;
    }
    onFailure((this as Failure).exception, (this as Failure).message);
  }

  bool get isSuccess => this is Success;

  bool get isFailure => this is Failure;

  Failure<S>? get getFailureOrNull => isFailure ? (this as Failure<S>) : null;

  Failure<S>? get getFailure => this as Failure<S>;

  Success<S>? get getSuccessOrNull => isSuccess ? (this as Success<S>) : null;

  Success<S>? get getSuccess => this as Success<S>;

  S get getDataWhenSuccess => (this as Success<S>).value;

  S? get getDataWhenSuccessOrNull =>
      isSuccess ? (this as Success<S>).value : null;
}

final class Success<S> extends Result<S> {
  const Success(this.value);

  final S value;
}

final class Failure<S> extends Result<S> {
  const Failure(this.exception, {required this.message});

  final AppException exception;
  final String? message;
}
