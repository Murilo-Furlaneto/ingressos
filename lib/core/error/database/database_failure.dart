import 'package:ingressos/core/error/database/cache_failure.dart';
import 'package:ingressos/core/error/failure.dart';

class DatabaseFailure extends Failure {
  DatabaseFailure({required String description}) : super(description: description);

  factory DatabaseFailure.fromException(Exception e) {
    final message = e.toString().toLowerCase();

    if (message.contains('database') || message.contains('sqlite')) {
      return DatabaseFailure(description: 'Erro no banco de dados.');
    } else if (message.contains('cache')) {
      return DatabaseFailure(description: 'Erro ao acessar o cache local.');
    } else {
      return DatabaseFailure(description: 'Erro desconhecido no banco de dados.');
    }
  }
}