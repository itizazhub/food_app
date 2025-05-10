abstract class Failure {
  Failure(this.message);
  final String message;
}

class SomeSpecificError extends Failure {
  SomeSpecificError(super.message);
}
