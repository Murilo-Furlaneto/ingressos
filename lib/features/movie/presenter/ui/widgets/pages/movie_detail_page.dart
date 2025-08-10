import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:ingressos/features/movie/domain/entities/cast_entity.dart';
import 'package:ingressos/features/movie/domain/entities/movie_detail_entity.dart';
import 'package:ingressos/features/movie/domain/entities/movie_entity.dart';
import 'package:ingressos/features/movie/domain/entities/review_entity.dart';
import 'package:ingressos/features/movie/domain/entities/video_entity.dart';
import 'package:ingressos/features/movie/presenter/provider/movie_notifier.dart';
import 'package:ingressos/features/room/domain/entities/room_entity.dart';
import 'package:ingressos/features/room/presenter/provider/room_notifier.dart';
import 'package:ingressos/features/seat/presenter/ui/pages/seat_selection_page.dart';
import 'package:ingressos/injection_container/service_locator.dart';
import 'package:url_launcher/url_launcher.dart';

class MovieDetailPage extends StatefulWidget {
  final Movie movie;
  final MovieNotifier notifier;

  const MovieDetailPage({
    super.key,
    required this.movie,
    required this.notifier,
  });

  @override
  State<MovieDetailPage> createState() => _MovieDetailPageState();
}

class _MovieDetailPageState extends State<MovieDetailPage> {
  late Future<MovieDetail> _movieDetailFuture;
  late Future<List<Video>> _videosFuture;
  late Future<List<Cast>> _castFuture;
  late Future<List<Review>> _reviewsFuture;
  late List<Room> _rooms;
  final RoomNotifier _roomNotifier = get<RoomNotifier>();

  DateTime? selectedDate;
  String? selectedSession;

  final List<String> dummySessions = ['14:00', '16:30', '19:00', '21:30'];

  @override
  void initState() {
    super.initState();
    _movieDetailFuture = _fetchMovieDetail();
    _videosFuture = _fetchVideos();
    _castFuture = _fetchCast();
    _reviewsFuture = _fetchReviews();
    _rooms = _fetchRooms();
  }

  Future<MovieDetail> _fetchMovieDetail() async {
    try {
      return await widget.notifier.getMovieDetail(widget.movie.id);
    } catch (e) {
      throw Exception("Erro ao buscar os detalhes do filme: ${e.toString()}");
    }
  }

  Future<List<Video>> _fetchVideos() async {
    return await widget.notifier.getMovieVideos(widget.movie.id);
  }

  Future<List<Cast>> _fetchCast() async {
    return await widget.notifier.getMovieCast(widget.movie.id);
  }

  Future<List<Review>> _fetchReviews() async {
    return await widget.notifier.getMovieReviews(widget.movie.id);
  }

  List<Room> _fetchRooms() {
    return _roomNotifier.availableRooms;
  }

  void _onDateSelected(DateTime date) {
    setState(() {
      selectedDate = date;
      selectedSession = null;
    });
  }

  Room? selectedRoom;

  void _onSessionSelected(String session) {
    setState(() {
      selectedSession = session;
    });
  }

  void _onRoomSelected(Room room) {
    setState(() {
      selectedRoom = room;
    });
  }

  void _buyTicket() {
    if (selectedDate != null &&
        selectedSession != null &&
        selectedRoom != null) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder:
              (context) => SeatSelectionPage(
                movie: widget.movie,
                selectedDate: selectedDate!,
                selectedSession: selectedSession!,
                selectedRoom: selectedRoom!,
              ),
        ),
      );
    }
  }

  void _launchURL(String trailerKey) async {
    final Uri url = Uri.parse('https://www.youtube.com/watch?v=$trailerKey');

    try {
      await launchUrl(url, mode: LaunchMode.externalApplication);
    } catch (e) {
      throw Exception('Erro ao abrir o link: ${e.toString()}');
    }
  }

  @override
  Widget build(BuildContext context) {
    final posterUrl =
        "https://image.tmdb.org/t/p/w500${widget.movie.posterPath}";

    return Scaffold(
      backgroundColor: const Color(0xFF1C1C2D),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.amber,
              foregroundColor: Colors.black,
              minimumSize: const Size.fromHeight(50),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
            ),
            onPressed:
                (selectedDate != null &&
                        selectedSession != null &&
                        selectedRoom != null)
                    ? _buyTicket
                    : null,
            child: const Text(
              'Comprar ingresso',
              style: TextStyle(fontSize: 17),
            ),
          ),
        ),
      ),
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            pinned: true,
            stretch: true,
            expandedHeight: 320,
            backgroundColor: const Color(0xFF1C1C2D),
            leading: const BackButton(color: Colors.white),
            flexibleSpace: FlexibleSpaceBar(
              background: Hero(
                tag: widget.movie.id,
                child: CachedNetworkImage(
                  imageUrl: posterUrl,
                  fit: BoxFit.cover,
                  placeholder: (_, __) => Container(color: Colors.black12),
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: FutureBuilder<MovieDetail>(
              future: _movieDetailFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Padding(
                    padding: EdgeInsets.all(16),
                    child: Center(child: CircularProgressIndicator()),
                  );
                } else if (snapshot.hasError) {
                  return Padding(
                    padding: const EdgeInsets.all(16),
                    child: Center(
                      child: Text(
                        'Erro ao carregar detalhes: ${snapshot.error}',
                        style: const TextStyle(color: Colors.white),
                      ),
                    ),
                  );
                } else {
                  final detail = snapshot.data!;
                  return Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.movie.titulo,
                          style: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          detail.genres.map((g) => g.name).join(', '),
                          style: const TextStyle(color: Colors.white70),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'Duração: ${detail.runtime} min | Nota: ${widget.movie.notaMedia.toStringAsFixed(1)}',
                          style: const TextStyle(color: Colors.white70),
                        ),
                        const SizedBox(height: 16),
                        Text(
                          'Sinopse',
                          style: Theme.of(
                            context,
                          ).textTheme.titleLarge?.copyWith(color: Colors.white),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          widget.movie.sinopse,
                          style: const TextStyle(color: Colors.white70),
                        ),
                        const SizedBox(height: 20),

                        // Trailer
                        FutureBuilder<List<Video>>(
                          future: _videosFuture,
                          builder: (context, videoSnapshot) {
                            if (videoSnapshot.connectionState ==
                                ConnectionState.waiting) {
                              return const Center(
                                child: CircularProgressIndicator(),
                              );
                            } else if (videoSnapshot.hasData &&
                                videoSnapshot.data!.isNotEmpty) {
                              final trailer = videoSnapshot.data!.firstWhere(
                                (v) =>
                                    v.type.toLowerCase() == 'trailer' &&
                                    v.site.toLowerCase() == 'youtube',
                                orElse: () => videoSnapshot.data!.first,
                              );
                              return ElevatedButton.icon(
                                onPressed: () => _launchURL(trailer.key),
                                icon: const Icon(Icons.play_arrow),
                                label: const Text('Assistir Trailer'),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.redAccent,
                                  foregroundColor: Colors.white,
                                ),
                              );
                            } else {
                              return const SizedBox.shrink();
                            }
                          },
                        ),

                        const SizedBox(height: 24),

                        // Seleção de datas (simulada)
                        Text(
                          'Selecione a data',
                          style: Theme.of(
                            context,
                          ).textTheme.titleLarge?.copyWith(color: Colors.white),
                        ),
                        const SizedBox(height: 8),
                        SizedBox(
                          height: 40,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: 7,
                            itemBuilder: (context, index) {
                              final date = DateTime.now().add(
                                Duration(days: index),
                              );
                              final isSelected =
                                  selectedDate != null &&
                                  selectedDate!.year == date.year &&
                                  selectedDate!.month == date.month &&
                                  selectedDate!.day == date.day;
                              return GestureDetector(
                                onTap: () => _onDateSelected(date),
                                child: Container(
                                  margin: const EdgeInsets.only(right: 8),
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 16,
                                    vertical: 8,
                                  ),
                                  decoration: BoxDecoration(
                                    color:
                                        isSelected
                                            ? Colors.amber
                                            : Colors.grey[800],
                                    borderRadius: BorderRadius.circular(16),
                                  ),
                                  child: Center(
                                    child: Text(
                                      '${date.day}/${date.month}',
                                      style: TextStyle(
                                        color:
                                            isSelected
                                                ? Colors.black
                                                : Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),

                        const SizedBox(height: 16),

                        // Seleção de sessões (simulada)
                        if (selectedDate != null) ...[
                          Text(
                            'Selecione a sessão',
                            style: Theme.of(context).textTheme.titleLarge
                                ?.copyWith(color: Colors.white),
                          ),
                          const SizedBox(height: 8),
                          Wrap(
                            spacing: 8,
                            children:
                                dummySessions.map((session) {
                                  final isSelected = selectedSession == session;
                                  return ChoiceChip(
                                    label: Text(session),
                                    selected: isSelected,
                                    onSelected:
                                        (_) => _onSessionSelected(session),
                                    selectedColor: Colors.amber,
                                    backgroundColor: Colors.grey[800],
                                    labelStyle: TextStyle(
                                      color:
                                          isSelected
                                              ? Colors.black
                                              : Colors.white,
                                    ),
                                  );
                                }).toList(),
                          ),
                          SizedBox(height: 16),
                          Wrap(
                            spacing: 8,
                            children:
                                _rooms.map((room) {
                                  final isSelected = selectedRoom == room;
                                  return ChoiceChip(
                                    label: Text(room.nome),
                                    selected: isSelected,
                                    onSelected: (_) => _onRoomSelected(room),
                                    selectedColor: Colors.amber,
                                    backgroundColor: Colors.grey[800],
                                    labelStyle: TextStyle(
                                      color:
                                          isSelected
                                              ? Colors.black
                                              : Colors.white,
                                    ),
                                  );
                                }).toList(),
                          ),
                        ],
                        const SizedBox(height: 24),
                        // Elenco
                        Text(
                          'Elenco',
                          style: Theme.of(
                            context,
                          ).textTheme.titleLarge?.copyWith(color: Colors.white),
                        ),
                        const SizedBox(height: 8),
                        FutureBuilder<List<Cast>>(
                          future: _castFuture,
                          builder: (context, castSnapshot) {
                            if (castSnapshot.connectionState ==
                                ConnectionState.waiting) {
                              return const Center(
                                child: CircularProgressIndicator(),
                              );
                            } else if (castSnapshot.hasData &&
                                castSnapshot.data!.isNotEmpty) {
                              return SizedBox(
                                height: 150,
                                child: ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  itemCount: castSnapshot.data!.length,
                                  itemBuilder: (context, index) {
                                    final cast = castSnapshot.data![index];
                                    final profileUrl =
                                        cast.profilePath.isNotEmpty
                                            ? 'https://image.tmdb.org/t/p/w200${cast.profilePath}'
                                            : null;
                                    return Container(
                                      width: 100,
                                      margin: const EdgeInsets.only(right: 12),
                                      child: Column(
                                        children: [
                                          ClipRRect(
                                            borderRadius: BorderRadius.circular(
                                              50,
                                            ),
                                            child:
                                                profileUrl != null
                                                    ? CachedNetworkImage(
                                                      imageUrl: profileUrl,
                                                      height: 100,
                                                      width: 100,
                                                      fit: BoxFit.cover,
                                                      placeholder:
                                                          (_, __) => Container(
                                                            color: Colors.grey,
                                                          ),
                                                    )
                                                    : Container(
                                                      height: 100,
                                                      width: 100,
                                                      color: Colors.grey,
                                                      child: const Icon(
                                                        Icons.person,
                                                        size: 50,
                                                        color: Colors.white,
                                                      ),
                                                    ),
                                          ),
                                          const SizedBox(height: 8),
                                          Text(
                                            cast.name,
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                            style: const TextStyle(
                                              color: Colors.white,
                                              fontSize: 12,
                                            ),
                                          ),
                                          Text(
                                            cast.character,
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                            style: const TextStyle(
                                              color: Colors.white70,
                                              fontSize: 10,
                                            ),
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                ),
                              );
                            } else {
                              return const Text(
                                'Nenhum elenco disponível',
                                style: TextStyle(color: Colors.white70),
                              );
                            }
                          },
                        ),

                        const SizedBox(height: 24),

                        // Avaliações
                        Text(
                          'Avaliações',
                          style: Theme.of(
                            context,
                          ).textTheme.titleLarge?.copyWith(color: Colors.white),
                        ),
                        const SizedBox(height: 8),
                        FutureBuilder<List<Review>>(
                          future: _reviewsFuture,
                          builder: (context, reviewSnapshot) {
                            if (reviewSnapshot.connectionState ==
                                ConnectionState.waiting) {
                              return const Center(
                                child: CircularProgressIndicator(),
                              );
                            } else if (reviewSnapshot.hasData &&
                                reviewSnapshot.data!.isNotEmpty) {
                              return Column(
                                children:
                                    reviewSnapshot.data!.take(3).map((review) {
                                      return Container(
                                        margin: const EdgeInsets.only(
                                          bottom: 12,
                                        ),
                                        padding: const EdgeInsets.all(12),
                                        decoration: BoxDecoration(
                                          color: Colors.grey[850],
                                          borderRadius: BorderRadius.circular(
                                            12,
                                          ),
                                        ),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              review.author,
                                              style: const TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color: Colors.amber,
                                              ),
                                            ),
                                            const SizedBox(height: 4),
                                            Text(
                                              review.content,
                                              maxLines: 6,
                                              overflow: TextOverflow.ellipsis,
                                              style: const TextStyle(
                                                color: Colors.white70,
                                              ),
                                            ),
                                          ],
                                        ),
                                      );
                                    }).toList(),
                              );
                            } else {
                              return const Text(
                                'Nenhuma avaliação disponível',
                                style: TextStyle(color: Colors.white70),
                              );
                            }
                          },
                        ),

                        const SizedBox(height: 80), // espaço para botão comprar
                      ],
                    ),
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
