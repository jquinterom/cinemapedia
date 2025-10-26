import 'dart:async';

import 'package:animate_do/animate_do.dart';
import 'package:cinemapedia/domain/entities/movie.dart';
import 'package:flutter/material.dart';

typedef SearchMovieCallback = Future<List<Movie>> Function(String query);

class SearchMovieDelegate extends SearchDelegate<Movie?> {
  final SearchMovieCallback searchMovies;
  final Function cleanStringQuery;
  List<Movie> initialMovies;

  StreamController<List<Movie>> debouncedMovies = StreamController.broadcast();
  StreamController<bool> isLoadingStream = StreamController.broadcast();

  Timer? _debounceTimer;

  SearchMovieDelegate({
    required this.searchMovies,
    this.initialMovies = const [],
    this.cleanStringQuery = Function.apply,
  });

  void _onQueryChanged(String query) {
    isLoadingStream.add(true);

    if (_debounceTimer?.isActive ?? false) _debounceTimer?.cancel();

    final time = query.isEmpty ? 0 : 500;

    _debounceTimer = Timer(Duration(milliseconds: time), () async {
      final movies = await searchMovies(query);

      initialMovies = movies;
      debouncedMovies.add(movies);

      isLoadingStream.add(false);
    });
  }

  void _cleanStreams() {
    _debounceTimer?.cancel();
    debouncedMovies.add([]);
  }

  void _cleanStringQuery() {
    _cleanStreams();
    query = '';
    cleanStringQuery();
  }

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      StreamBuilder(
        initialData: false,
        stream: isLoadingStream.stream,
        builder: (context, snapshot) {
          if (snapshot.data ?? false) {
            return SpinPerfect(
              duration: const Duration(seconds: 10),
              infinite: true,
              child: IconButton(
                icon: const Icon(Icons.refresh_rounded),
                onPressed: _cleanStringQuery,
              ),
            );
          }

          return FadeIn(
            animate: query.isNotEmpty,
            duration: const Duration(milliseconds: 100),
            child: IconButton(
              icon: const Icon(Icons.clear_rounded),
              onPressed: _cleanStringQuery,
            ),
          );
        },
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back_ios_rounded),
      onPressed: () {
        _cleanStreams();

        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return _onSetStreamBuilder(initialMovies);
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    _onQueryChanged(query);

    return _onSetStreamBuilder(initialMovies);
  }

  Widget _onSetStreamBuilder(List<Movie> movies) {
    return StreamBuilder(
      initialData: initialMovies,
      stream: debouncedMovies.stream,
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const Center(child: CircularProgressIndicator());
        }

        final movies = snapshot.data ?? [];

        return ListView.builder(
          itemCount: movies.length,
          itemBuilder: (context, index) => _MovieItem(
            movie: movies[index],
            onMovieTap: (context, movie) {
              _cleanStreams();

              close(context, movies[index]);
            },
          ),
        );
      },
    );
  }

  @override
  String? get searchFieldLabel => 'Search Movies';
}

class _MovieItem extends StatelessWidget {
  final Movie movie;
  final Function onMovieTap;

  const _MovieItem({required this.movie, required this.onMovieTap});

  @override
  Widget build(BuildContext context) {
    final textStyles = Theme.of(context).textTheme;
    final size = MediaQuery.of(context).size;

    return GestureDetector(
      onTap: () => onMovieTap(context, movie),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        child: Row(
          children: [
            SizedBox(
              width: size.width * 0.2,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.network(
                  movie.posterPath,
                  loadingBuilder: (context, child, loadingProgress) =>
                      FadeIn(child: child),
                ),
              ),
            ),

            SizedBox(width: 8),

            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(movie.title, style: textStyles.titleMedium),
                  const SizedBox(height: 4),
                  Text(movie.overview, style: textStyles.bodySmall),

                  Row(
                    children: [
                      Icon(
                        Icons.star_half_rounded,
                        color: Colors.yellow.shade800,
                      ),

                      SizedBox(width: 4),

                      Text(
                        movie.voteAverage.toStringAsFixed(1),
                        style: textStyles.bodyMedium!.copyWith(
                          color: Colors.yellow.shade900,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
