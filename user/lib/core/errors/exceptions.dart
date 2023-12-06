class ServerException implements Exception {
  final String? message;

  ServerException({this.message = "ServerException"});
}

class OperationFailedException implements Exception {
  final String? message;

  OperationFailedException({this.message = "OperationFailedException"});
}

class SystemAlertException implements Exception {
  final dynamic message;

  SystemAlertException([this.message]);

  @override
  String toString() {
    Object? message = this.message;
    if (message == null) return "Exception";
    return "Exception: $message";
  }
}
