import 'package:cinemapedia/domain/repositories/movies_repository.dart';
import 'package:cinemapedia/infastructure/datasources/movie_datasource_impl.dart';
import 'package:cinemapedia/infastructure/repositories/movie_repository_impl.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Inmutable repository
final movieRepositoryProvider = Provider<MoviesRepository>((ref) {
  return MovieRepositoryImpl(MoviesDataSourceImpl());
});
