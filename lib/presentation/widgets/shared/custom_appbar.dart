import 'package:cinemapedia/presentation/delegates/search_movie_delegate.dart';
import 'package:cinemapedia/presentation/providers/providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CustomAppbar extends ConsumerWidget {
  const CustomAppbar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colors = Theme.of(context).colorScheme;
    final titleStyle = Theme.of(context).textTheme.titleMedium;

    return SafeArea(
      bottom: false,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 8.0),
        child: SizedBox(
          width: double.infinity,
          child: Row(
            children: [
              Icon(Icons.movie_outlined, color: colors.primary),
              const SizedBox(width: 4.0),
              Text('CinemaPedia', style: titleStyle),

              const Spacer(),

              IconButton(
                onPressed: () {
                  final movieRepository = ref.read(movieRepositoryProvider);
                  showSearch(
                    context: context,
                    delegate: SearchMovieDelegate(
                      searchMovies: movieRepository.searchMovies,
                    ),
                  );
                },
                icon: Icon(Icons.search),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
