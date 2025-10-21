import 'package:cinemapedia/domain/datasources/movies_datasource.dart';
import 'package:cinemapedia/domain/entities/movie.dart';
import 'package:cinemapedia/domain/repositories/movies_repository.dart';

class MovieRepositoryImpl extends MoviesRepository {
  final MoviesDataSource _datasource;
  MovieRepositoryImpl(this._datasource);

  @override
  Future<List<Movie>> getNowPlaying({int page = 1}) {
    return _datasource.getNowPlaying(page: page);
  }

  @override
  Future<List<Movie>> getPopular({int page = 1}) {
    return _datasource.getPopular(page: page);
  }

  @override
  Future<List<Movie>> getUpComing({int page = 1}) {
    return _datasource.getUpComing(page: page);
  }

  @override
  Future<List<Movie>> getTopRated({int page = 1}) {
    return _datasource.getTopRated(page: page);
  }

  @override
  Future<Movie> getMovieById(int id) {
    return _datasource.getMovieById(id);
  }
}
