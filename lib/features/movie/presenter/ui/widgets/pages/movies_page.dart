import 'package:flutter/material.dart';
import 'package:ingressos/features/movie/presenter/ui/widgets/movie_card_widget.dart';

class MoviesPage extends StatelessWidget {

   MoviesPage({ super.key });

   final List<Map<String, dynamic>> movies = [
    {
      'title': 'Guardiões da Galáxia Vol. 3',
      'rating': 8.2,
      'genres': 'Ação/Aventura',
    },
    {
      'title': 'Homem-Aranha: Através do Aranhaverso',
      'rating': 9.0,
      'genres': 'Animação/Ação',
    },
    // Adicione mais filmes conforme necessário
  ];

   @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF181829),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Container(
              padding: const EdgeInsets.all(24),
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color(0xFF3B1E7C), Color(0xFF4E2F8E)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text(
                    'CinemaApp',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 28,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Filmes em cartaz',
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ),
            // Barra de busca
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Buscar filmes...',
                  prefixIcon: Icon(Icons.search, color: Colors.white54),
                  filled: true,
                  fillColor: const Color(0xFF23223A),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: BorderSide.none,
                  ),
                  hintStyle: const TextStyle(color: Colors.white54),
                ),
                style: const TextStyle(color: Colors.white),
              ),
            ),
            // Lista de filmes
            Expanded(
              child: GridView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 0.68,
                ),
                itemCount: movies.length,
                itemBuilder: (context, index) {
                  final movie = movies[index];
                  return MovieCard(
                    title: movie['title'],
                    rating: movie['rating'],
                    genres: movie['genres'],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}