import 'package:cinemapedia/config/constants/enviroment.dart';
import 'package:cinemapedia/domain/datasources/actors_datasource.dart';
import 'package:cinemapedia/domain/entities/actor.dart';
import 'package:cinemapedia/infastructure/mappers/actor_mapper.dart';
import 'package:cinemapedia/infastructure/models/moviedb/credits_response.dart';
import 'package:dio/dio.dart';

class ActorMovieDbDataSourceImpl extends ActorsDataSource {
  String getActorMovieUrl(id) => "/movie/$id/credits";

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
  Future<List<Actor>> getActorsByMovie(String movieId) async {
    final response = await dio.get(getActorMovieUrl(movieId));
    final castResponse = CreditsResponse.fromJson(response.data);

    List<Actor> actors = castResponse.cast
        .map((castItem) => ActorMapper.castToEntity(castItem))
        .toList();

    return actors;
  }
}
