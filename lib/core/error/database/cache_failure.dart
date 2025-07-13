import 'package:ingressos/core/error/failure.dart';

class CacheFailure extends Failure {
  CacheFailure({required super.description});

  factory CacheFailure.defaultMessage() =>
      CacheFailure(description: 'Erro ao acessar ou salvar dados em cache.');
}