import 'package:cinemapedia/domain/entities/movie.dart';
import 'package:cinemapedia/presentation/providers/providers.dart';
import 'package:flutter_riverpod/legacy.dart';

final movieInfoProvider =
    StateNotifierProvider<MovieMapNotifier, Map<String, Movie>>((ref) {
      final getMovie = ref.watch(movieRepositoryProvider).getMovieById;

      return MovieMapNotifier(getMovie: getMovie);
    });

typedef GetMovieCallback = Future<Movie> Function(int movieId);

class MovieMapNotifier extends StateNotifier<Map<String, Movie>> {
  MovieMapNotifier({required this.getMovie}) : super({});

  final GetMovieCallback getMovie;

  Future<void> loadMovie(String movieId) async {
    if (state[movieId] != null) return;

    final movie = await getMovie(int.parse(movieId));
    state = {...state, movieId: movie};
  }
}
