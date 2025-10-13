import 'package:cinemapedia/config/constants/enviroment.dart';
import 'package:cinemapedia/domain/datasources/movies_datasource.dart';
import 'package:cinemapedia/domain/entities/movie.dart';
import 'package:cinemapedia/infastructure/mappers/movie_mapper.dart';
import 'package:cinemapedia/infastructure/models/moviedb/moviedb_response.dart';
import 'package:dio/dio.dart';

class MoviesDataSourceImpl extends MoviesDataSource {
  final dio = Dio(
    BaseOptions(
      baseUrl: Environment.movieApiUrl,
      queryParameters: {
        'api_key': Environment.movieFieldKey,
        'language': 'es-CO',
      },
    ),
  );

  @override
  Future<List<Movie>> getNowPlaying({int page = 1}) async {
    final response = await dio.get('/movie/now_playing');

    final movieDBResponse = MovieDbResponse.fromJson(response.data);

    final List<Movie> movies = movieDBResponse.results
        .where((movieDb) => movieDb.posterPath != 'no-poster')
        .map((movieDb) => MovieMapper.movieDbToEntity(movieDb))
        .toList();

    return Future.value(movies);
  }
}
