import '../failure.dart';

class UnexpectedFailure extends Failure {
  UnexpectedFailure({required super.description});

  factory UnexpectedFailure.fromException(Exception e) {
    return UnexpectedFailure(description: 'Erro inesperado: ${e.toString()}');
  }
}
