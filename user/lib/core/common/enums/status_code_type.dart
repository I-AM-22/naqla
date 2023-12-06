enum StatusCode {
  operationSucceeded,
  operationCreated,
  operationFailed,
  serverError,
  unAuthorized,
  noContent,
}

extension FetchCode on StatusCode {
  int get code {
    switch (this) {
      case StatusCode.operationSucceeded:
        return 200;
      case StatusCode.operationCreated:
        return 201;
      case StatusCode.noContent:
        return 204;
      case StatusCode.operationFailed:
        return 400;
      case StatusCode.serverError:
        return 500;
      case StatusCode.unAuthorized:
        return 401;
    }
  }
}
