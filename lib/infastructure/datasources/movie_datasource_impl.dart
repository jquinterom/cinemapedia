import 'package:cinemapedia/config/constants/enviroment.dart';
import 'package:cinemapedia/domain/datasources/movies_datasource.dart';
import 'package:cinemapedia/domain/entities/movie.dart';
import 'package:cinemapedia/infastructure/mappers/movie_mapper.dart';
import 'package:cinemapedia/infastructure/models/moviedb/movie_details.dart';
import 'package:cinemapedia/infastructure/models/moviedb/moviedb_response.dart';
import 'package:dio/dio.dart';

class MoviesDataSourceImpl extends MoviesDataSource {
  final movieUrl = "/movie/";

  final dio = Dio(
    BaseOptions(
      baseUrl: Environment.movieApiUrl,
      queryParameters: {
        'api_key': Environment.movieFieldKey,
        'language': 'es-CO',
      },
    ),
  );

  List<Movie> _jsonToMovies(Map<String, dynamic> json) {
    final movieDBResponse = MovieDbResponse.fromJson(json);

    final List<Movie> movies = movieDBResponse.results
        .where((movieDb) => movieDb.posterPath != 'no-poster')
        .map((movieDb) => MovieMapper.movieDbToEntity(movieDb))
        .toList();

    return movies;
  }

  @override
  Future<List<Movie>> getNowPlaying({int page = 1}) async {
    final response = await dio.get(
      '${movieUrl}now_playing',
      queryParameters: {'page': page},
    );

    final movies = _jsonToMovies(response.data);

    return Future.value(movies);
  }

  @override
  Future<List<Movie>> getPopular({int page = 1}) async {
    final response = await dio.get(
      '${movieUrl}popular',
      queryParameters: {'page': page},
    );

    final movies = _jsonToMovies(response.data);

    return Future.value(movies);
  }

  @override
  Future<List<Movie>> getUpComing({int page = 1}) async {
    final response = await dio.get(
      '${movieUrl}upcoming',
      queryParameters: {'page': page},
    );

    final movies = _jsonToMovies(response.data);
    return Future.value(movies);
  }

  @override
  Future<List<Movie>> getTopRated({int page = 1}) async {
    final response = await dio.get(
      '${movieUrl}top_rated',
      queryParameters: {'page': page},
    );

    final movies = _jsonToMovies(response.data);
    return Future.value(movies);
  }

  @override
  Future<Movie> getMovieById(int id) async {
    final response = await dio.get('$movieUrl$id');

    if (response.statusCode != 200) {
      throw Exception('Error getting movie with id: $id');
    }

    final movieDetails = MovieDetails.fromJson(response.data);

    final movie = MovieMapper.movieDetailsToEntity(movieDetails);

    return Future.value(movie);
  }

  @override
  Future<List<Movie>> searchMovies(String query) async {
    final response = await dio.get(
      '/search/movie',
      queryParameters: {'query': query},
    );

    return Future.value(response.data);
  }
}
