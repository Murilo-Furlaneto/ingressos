import 'package:flutter/material.dart';
import 'package:ingressos/features/injection_container/service_locator.dart';
import 'package:ingressos/features/movie/data/model/genre_data.dart';
import 'package:ingressos/features/movie/domain/entities/movie_entity.dart';
import 'package:ingressos/features/movie/presenter/provider/movie_notifier.dart';
import 'package:ingressos/features/movie/presenter/ui/widgets/movie_card_widget.dart';
import 'package:ingressos/features/movie/presenter/ui/widgets/pages/movie_detail_page.dart';

class MoviesPage extends StatefulWidget {
  const MoviesPage({super.key});

  @override
  State<MoviesPage> createState() => _MoviesPageState();
}

class _MoviesPageState extends State<MoviesPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final movieNotifier = get<MovieNotifier>();


  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    movieNotifier.getNowPlaying();
    movieNotifier.getUpComing();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  Widget buildMovieGrid(List<Movie> movies) {
    return GridView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.68,
        crossAxisSpacing: 8,
        mainAxisSpacing: 8,
      ),
      itemCount: movies.length,
      itemBuilder: (context, index) {
        final movie = movies[index];
        return GestureDetector(
          onTap: ()=> Navigator.push(context, MaterialPageRoute(builder: (context) => MovieDetailPage(movie: movie, notifier: movieNotifier,))),
          child: MovieCard(
            title: movie.title,
            rating: movie.voteAverage,
            genres: getGenreNames(movie.genreIds),
            backdropPath: movie.backdropPath,
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(28, 28, 45, 1),
      appBar: AppBar(
        backgroundColor: const Color(0xFF2A2A40), 
        elevation: 0,
        title: Text("Ingressos", style: TextStyle(color: Colors.white),),
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: Colors.white, 
          labelColor: Colors.white,
          unselectedLabelColor: Colors.white70,
          tabs: const [Tab(text: 'Em Cartaz'), Tab(text: 'Em Breve')],
        ),
      ),

      body: SafeArea(
        child: TabBarView(
          controller: _tabController,
          children: [
            ValueListenableBuilder(
                valueListenable: movieNotifier.nowPlayingMovies,
                builder: (_, value, child) {
                    return buildMovieGrid(value);
                },
            ),
            ValueListenableBuilder(
                valueListenable: movieNotifier.comingSoonMovies,
                builder: (_, value, child) {
                    return buildMovieGrid(value);
                },
            ),
          ],
        ),
      ),
    );
  }
}
