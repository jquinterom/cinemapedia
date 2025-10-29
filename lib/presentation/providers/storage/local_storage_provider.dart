import 'package:cinemapedia/infastructure/datasources/drift_datasource_impl.dart';
import 'package:cinemapedia/infastructure/repositories/local_storage_repository_impl.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final localStorageRepositoryProvider = Provider((ref) {
  return LocalStorageRepositoryImpl(DriftDataSourceImpl());
});
