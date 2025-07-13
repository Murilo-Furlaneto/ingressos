import 'package:flutter/material.dart';
import 'package:ingressos/features/movie/presenter/ui/widgets/pages/movies_page.dart';

class Routes {
  static const String home = '/';
  static const String movieDetails = '/movie_details';
  static const String payment = '/payment';
}

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case Routes.home:
      return MaterialPageRoute(builder: (_) =>  MoviesPage());

  /*  case Routes.movieDetails:
      final movieId = settings.arguments as String;
      return MaterialPageRoute(
          builder: (_) => MovieDetailsScreen(movieId: movieId));

    case Routes.payment:
      return MaterialPageRoute(builder: (_) => const PaymentScreen()); */
      

    default:
      return MaterialPageRoute(
          builder: (_) => const Scaffold(
                body: Center(child: Text('Rota não encontrada')),
              ));
  }
}
