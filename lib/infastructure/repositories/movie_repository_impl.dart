import 'package:cinemapedia/domain/datasources/movies_datasource.dart';
import 'package:cinemapedia/domain/entities/movie.dart';
import 'package:cinemapedia/domain/repositories/movies_repository.dart';

class MovieRepositoryImpl extends MoviesRepository {
  final MoviesDataSource _dataSource;
  MovieRepositoryImpl(this._dataSource);

  @override
  Future<List<Movie>> getNowPlaying({int page = 1}) {
    return _dataSource.getNowPlaying(page: page);
  }

  @override
  Future<List<Movie>> getPopular({int page = 1}) {
    return _dataSource.getPopular(page: page);
  }

  @override
  Future<List<Movie>> getUpComing({int page = 1}) {
    return _dataSource.getUpComing(page: page);
  }

  @override
  Future<List<Movie>> getTopRated({int page = 1}) {
    return _dataSource.getTopRated(page: page);
  }

  @override
  Future<Movie> getMovieById(int id) {
    return _dataSource.getMovieById(id);
  }

  @override
  Future<List<Movie>> searchMovies(String query) {
    return _dataSource.searchMovies(query);
  }
}
