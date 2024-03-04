class AppException<OriginalException> implements Exception {
  final String message;
  final OriginalException exception;

  AppException({required this.message, required this.exception});

  const AppException.unknown({required this.message, required this.exception});

  AppException copyWith({OriginalException? exception, String? message}) {
    return AppException(
        message: message ?? this.message,
        exception: exception ?? this.exception);
  }
}

enum AppNetworkExceptionReason {
  canceled('Request canceled!'),
  timedOut('Request timed out!'),
  responseError('Server response error!'),
  noInternet('No internet connection'),
  serverError('Server  error!');

  const AppNetworkExceptionReason(this.message);

  final String message;
}

class AppNetworkException<OriginalException extends Exception>
    extends AppException<OriginalException> {
  AppNetworkException({
    required this.reason,
    required super.exception,
    String? message,
  }) : super(message: message ?? reason.name);

  AppNetworkException._({
    required this.reason,
    required super.exception,
    required super.message,
  });

  final AppNetworkExceptionReason reason;

  @override
  AppNetworkException copyWith(
      {OriginalException? exception, String? message}) {
    return AppNetworkException._(
        reason: reason,
        exception: exception ?? this.exception,
        message: message ?? this.message);
  }
}

class AppNetworkResponseException<OriginalException extends Exception, DataType>
    extends AppNetworkException<OriginalException> {
  final DataType? data;
  final int? statusCode;

  AppNetworkResponseException(
      {required super.exception, this.statusCode, this.data, super.message})
      : super(reason: AppNetworkExceptionReason.responseError);

  bool get hasData => data != null;

  bool validateStatusCode(bool Function(int statusCode) evaluator) {
    final statusCode = this.statusCode;
    if (statusCode == null) return false;
    return evaluator(statusCode);
  }
}

extension AppExceptionExt on AppException {
  bool get noInternetConnection => isThis(AppNetworkExceptionReason.noInternet);

  bool isThis(AppNetworkExceptionReason reason) {
    if (this is AppNetworkException<dynamic>) {
      final e = this as AppNetworkException;
      return e.reason == reason;
    }
    return false;
  }
}
