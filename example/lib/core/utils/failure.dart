class Failure {
  final String errorMessage;

  const Failure(this.errorMessage);
}

class ServerError extends Failure {
  final String code;

  ServerError(super.errorMessage, this.code);
}

class RequestError extends Failure {

  RequestError(super.errorMessage);
}

// class SomeFailureState implements Failure {}
