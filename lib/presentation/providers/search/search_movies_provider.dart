import 'package:cinemapedia/domain/entities/movie.dart';
import 'package:cinemapedia/presentation/delegates/search_movie_delegate.dart';
import 'package:cinemapedia/presentation/providers/providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';

final searchQueryProvider = StateProvider<String>((ref) => '');

final searchedMoviesProvider =
    StateNotifierProvider<SearchedMoviesNotifier, List<Movie>>((ref) {
      final movieRepository = ref.read(movieRepositoryProvider);

      return SearchedMoviesNotifier(
        searchMovies: movieRepository.searchMovies,
        ref: ref,
      );
    });

typedef SearchMoviesCallback = Future<List<Movie>> Function(String query);

class SearchedMoviesNotifier extends StateNotifier<List<Movie>> {
  final SearchMovieCallback searchMovies;
  final Ref ref;

  SearchedMoviesNotifier({required this.searchMovies, required this.ref})
    : super([]);

  Future<List<Movie>> searchMovieByQuery(String query) async {
    final movies = await searchMovies(query);

    ref.read(searchQueryProvider.notifier).update((state) => query);

    state = movies;

    return movies;
  }

  void cleanStringQuery() {
    ref.read(searchQueryProvider.notifier).update((state) => '');
  }
}
