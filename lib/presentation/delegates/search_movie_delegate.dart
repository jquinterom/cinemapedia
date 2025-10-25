import 'package:animate_do/animate_do.dart';
import 'package:cinemapedia/domain/entities/movie.dart';
import 'package:flutter/material.dart';

typedef SearchMovieCallback = Future<List<Movie>> Function(String query);

class SearchMovieDelegate extends SearchDelegate<Movie?> {
  final SearchMovieCallback searchMovies;

  SearchMovieDelegate({required this.searchMovies});

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      FadeIn(
        animate: query.isNotEmpty,
        duration: const Duration(milliseconds: 100),
        child: IconButton(
          icon: const Icon(Icons.clear_rounded),
          onPressed: () {
            query = '';
          },
        ),
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back_ios_rounded),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return const Text("buildResults");
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return FutureBuilder(
      future: searchMovies(query),
      initialData: const [],
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const Center(child: CircularProgressIndicator());
        }

        final movies = snapshot.data ?? [];

        return ListView.builder(
          itemCount: movies.length,
          itemBuilder: (context, index) {
            final movie = movies[index];

            return ListTile(title: Text(movie.title));
          },
        );
      },
    );
  }

  @override
  String? get searchFieldLabel => 'Search Movies';
}

class _MovieItem extends StatelessWidget {
  const _MovieItem();

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
