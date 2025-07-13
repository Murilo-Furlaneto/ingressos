import '../failure.dart';

class ValidationFailure extends Failure {
  ValidationFailure({required super.description});

  factory ValidationFailure.emptyField(String fieldName) =>
      ValidationFailure(description: 'O campo "$fieldName" não pode estar vazio.');

  factory ValidationFailure.invalidFormat(String fieldName) =>
      ValidationFailure(description: 'Formato inválido no campo "$fieldName".');
}
