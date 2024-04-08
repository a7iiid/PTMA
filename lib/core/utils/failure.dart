abstract class Failure {
  final String messageError;

  Failure({required this.messageError});
}

class ServerFailure extends Failure {
  ServerFailure({required super.messageError});
}
