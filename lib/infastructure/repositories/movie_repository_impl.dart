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
}
