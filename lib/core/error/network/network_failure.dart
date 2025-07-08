
import 'dart:async';
import 'dart:io';

import 'package:ingressos/core/error/failure.dart';

class NetworkFailure extends Failure{
  NetworkFailure({required super.description});

   factory NetworkFailure.fromException(Exception e) {
    if (e is SocketException) {
      return NetworkFailure(description: 'Sem conexão com a internet.');
    } else if (e is HttpException) {
      return NetworkFailure(description: 'Erro HTTP: ${e.message}');
    } else if (e is FormatException) {
      return NetworkFailure(description: 'Formato de dado inválido na resposta.');
    } else if (e is TimeoutException) {
      return NetworkFailure(description: 'Tempo de conexão esgotado.');
    } else {
      return NetworkFailure(description: 'Erro desconhecido de rede.');
    }
  }
  
}

