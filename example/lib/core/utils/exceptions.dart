class BaseException implements Exception {
  final String errorMessage;

  const BaseException({
    this.errorMessage = "Unknown error",
  });
}

class ServerException extends BaseException {
  final String code;

  const ServerException(String msg , this.code) : super(errorMessage: msg);
}

class RequestException extends BaseException {
  const RequestException(String msg) : super(errorMessage: msg);
}
