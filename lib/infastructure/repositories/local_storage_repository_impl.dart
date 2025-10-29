import 'package:cinemapedia/domain/datasources/local_storage_datasource.dart';
import 'package:cinemapedia/domain/entities/movie.dart';
import 'package:cinemapedia/domain/repositories/local_storage_repository.dart';

class LocalStorageRepositoryImpl extends LocalStorageRepository {
  final LocalStorageDataSource dataSource;

  LocalStorageRepositoryImpl(this.dataSource);

  @override
  Future<void> toggleFavoriteMovie(Movie movie) {
    return dataSource.toggleFavoriteMovie(movie);
  }

  @override
  Future<bool> isMovieFavorite(int movieId) {
    return dataSource.isMovieFavorite(movieId);
  }

  @override
  Future<List<Movie>> loadFavoriteMovies({int limit = 10, int offset = 0}) {
    return dataSource.loadFavoriteMovies(limit: limit, offset: offset);
  }
}
