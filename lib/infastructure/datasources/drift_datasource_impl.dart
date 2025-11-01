import 'package:drift/drift.dart' as drift;
import 'package:cinemapedia/config/database/database.dart';
import 'package:cinemapedia/domain/datasources/local_storage_datasource.dart';
import 'package:cinemapedia/domain/entities/movie.dart';

class DriftDataSourceImpl extends LocalStorageDataSource {
  final AppDatabase database;

  DriftDataSourceImpl([AppDatabase? databaseToUse])
    : database = databaseToUse ?? db;

  @override
  Future<bool> isMovieFavorite(int movieId) async {
    final query = database.select(database.favoriteMovies)
      ..where((table) {
        return table.movieId.equals(movieId);
      });

    return await query.getSingleOrNull().then((value) => value != null);
  }

  @override
  Future<List<Movie>> loadFavoriteMovies({
    int limit = 15,
    int offset = 0,
  }) async {
    final query = database.select(database.favoriteMovies)
      ..limit(limit, offset: offset);

    final favoritesMovieRows = await query.get();

    final movies = favoritesMovieRows
        .map((movie) => Movie.fromDriftDb(movie))
        .toList();

    return movies;
  }

  @override
  Future<void> toggleFavoriteMovie(Movie movie) async {
    final isFavorite = await isMovieFavorite(movie.id);

    if (isFavorite) {
      final deleteFavoriteMovie = database.delete(database.favoriteMovies)
        ..where((table) => table.movieId.equals(movie.id));

      await deleteFavoriteMovie.go();
      return;
    }

    await database
        .into(database.favoriteMovies)
        .insert(
          FavoriteMoviesCompanion.insert(
            movieId: movie.id,
            backdropPath: movie.backdropPath,
            originalTitle: movie.originalTitle,
            posterPath: movie.posterPath,
            title: movie.title,
            voteAverage: drift.Value(movie.voteAverage),
          ),
        );
  }
}
