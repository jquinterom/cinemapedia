import 'package:cinemapedia/domain/entities/actor.dart';
import 'package:cinemapedia/presentation/providers/actors/actors_repository_provider.dart';
import 'package:flutter_riverpod/legacy.dart';

final actorsMovieProvider =
    StateNotifierProvider<ActorsByMovieNotifier, Map<String, List<Actor>>>((
      ref,
    ) {
      final getActors = ref.watch(actorsRepositoryProvider).getActorsByMovie;

      return ActorsByMovieNotifier(getActors: getActors);
    });

typedef GetActorsCallback = Future<List<Actor>> Function(String movieId);

class ActorsByMovieNotifier extends StateNotifier<Map<String, List<Actor>>> {
  ActorsByMovieNotifier({required this.getActors}) : super({});

  bool isLoading = false;
  final GetActorsCallback getActors;

  Future<void> loadActors(String movieId) async {
    if (isLoading) return;

    isLoading = true;

    // if (state.isNotEmpty) return;

    final List<Actor> actors = await getActors(movieId);

    state = {...state, movieId: actors};

    isLoading = false;
  }
}
