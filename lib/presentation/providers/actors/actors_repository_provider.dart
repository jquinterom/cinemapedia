import 'package:cinemapedia/domain/repositories/actors_repository.dart';
import 'package:cinemapedia/infastructure/datasources/actor_moviedb_datasource_impl.dart';
import 'package:cinemapedia/infastructure/repositories/actor_repository_impl.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final actorsRepositoryProvider = Provider<ActorsRepository>((ref) {
  return ActorRepositoryImpl(ActorMovieDbDataSourceImpl());
});
