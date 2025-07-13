import 'package:ingressos/core/error/failure.dart';

class TimeoutFailure extends Failure {
  TimeoutFailure({required  super.description});

  factory TimeoutFailure.defaultMessage() =>
      TimeoutFailure(description: 'Tempo limite de conexão atingido.');
}