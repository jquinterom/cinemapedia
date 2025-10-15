import 'package:cinemapedia/presentation/providers/providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final initialLoadingProvider = Provider<bool>((ref) {
  final slideshowMoviesIsLoading = ref.watch(moviesSlideshowProvider).isEmpty;
  final nowPlayingMoviesIsLoading = ref.watch(nowPlayingMoviesProvider).isEmpty;
  final popularMoviesIsLoading = ref.watch(popularMoviesProvider).isEmpty;
  final upcomingMoviesIsLoading = ref.watch(upcomingMoviesProvider).isEmpty;
  final topRatedMoviesIsLoading = ref.watch(topRatedMoviesProvider).isEmpty;

  return slideshowMoviesIsLoading ||
      nowPlayingMoviesIsLoading ||
      popularMoviesIsLoading ||
      upcomingMoviesIsLoading ||
      topRatedMoviesIsLoading;
});
