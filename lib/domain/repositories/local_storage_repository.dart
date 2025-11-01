import 'package:cinemapedia/domain/entities/movie.dart';

abstract class LocalStorageRepository {
  Future<void> toggleFavoriteMovie(Movie movie);
  Future<bool> isMovieFavorite(int movieId);
  Future<List<Movie>> loadFavoriteMovies({int limit = 15, int offset = 0});
}
