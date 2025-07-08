import '../failure.dart';

class UnexpectedFailure extends Failure {
  UnexpectedFailure({required String description}) : super(description: description);

  factory UnexpectedFailure.fromException(Exception e) {
    return UnexpectedFailure(description: 'Erro inesperado: ${e.toString()}');
  }
}
