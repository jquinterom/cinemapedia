import 'package:animate_do/animate_do.dart';
import 'package:cinemapedia/domain/entities/actor.dart';
import 'package:cinemapedia/domain/entities/movie.dart';
import 'package:cinemapedia/presentation/providers/providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MovieScreen extends ConsumerStatefulWidget {
  static const String routeName = 'movie-screen';

  final String movieId;

  const MovieScreen({super.key, required this.movieId});

  @override
  MovieScreenState createState() => MovieScreenState();
}

class MovieScreenState extends ConsumerState<MovieScreen> {
  @override
  void initState() {
    super.initState();

    ref.read(movieInfoProvider.notifier).loadMovie(widget.movieId);
    ref.read(actorsMovieProvider.notifier).loadActors(widget.movieId);
  }

  @override
  Widget build(BuildContext context) {
    final Movie? movie = ref.watch(movieInfoProvider)[widget.movieId];
    final actors = ref.watch(actorsMovieProvider)[widget.movieId];

    if (movie == null) {
      return Scaffold(
        body: const Center(child: CircularProgressIndicator(strokeWidth: 2)),
      );
    }

    return Scaffold(
      body: CustomScrollView(
        physics: const ClampingScrollPhysics(),
        slivers: [
          _CustomSliversAppBar(movie: movie),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) =>
                  _MovieDetails(movie: movie, actors: actors ?? []),
              childCount: 1,
            ),
          ),
        ],
      ),
    );
  }
}

class _CustomSliversAppBar extends StatelessWidget {
  final Movie movie;
  const _CustomSliversAppBar({required this.movie});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return SliverAppBar(
      backgroundColor: Colors.black,
      expandedHeight: size.height * 0.7,
      foregroundColor: Colors.white,
      shadowColor: Colors.red,
      flexibleSpace: _FlexibleSpaceBar(movie: movie),
      actions: [
        IconButton(
          onPressed: () {},
          icon: const Icon(Icons.favorite_rounded, color: Colors.red),
          // icon: const Icon(Icons.favorite_outline_rounded),
        ),
      ],
    );
  }
}

class _FlexibleSpaceBar extends StatelessWidget {
  const _FlexibleSpaceBar({required this.movie});

  final Movie movie;

  @override
  Widget build(BuildContext context) {
    return FlexibleSpaceBar(
      titlePadding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),

      background: Stack(
        children: [
          SizedBox.expand(
            child: Image.network(
              movie.posterPath,
              fit: BoxFit.cover,
              loadingBuilder: (context, child, loadingProgress) {
                if (loadingProgress != null) {
                  return SizedBox();
                }

                return FadeIn(child: child);
              },
            ),
          ),

          _CustomGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.transparent, Colors.black87],
          ),

          _CustomGradient(begin: Alignment.topLeft, stops: [.0, .3]),

          _CustomGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            stops: [.0, .3],
          ),
        ],
      ),
    );
  }
}

class _CustomGradient extends StatelessWidget {
  final List<double> stops;
  final List<Color> colors;
  final AlignmentGeometry begin;
  final AlignmentGeometry end;

  const _CustomGradient({
    this.stops = const [.7, 1.0],
    this.colors = const [Colors.black87, Colors.transparent],
    this.begin = Alignment.topLeft,
    this.end = Alignment.centerRight,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox.expand(
      child: DecoratedBox(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: begin,
            end: end,
            stops: stops,
            colors: colors,
          ),
        ),
      ),
    );
  }
}

class _MovieDetails extends StatelessWidget {
  final Movie movie;
  final List<Actor> actors;

  const _MovieDetails({required this.movie, required this.actors});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final textStyles = Theme.of(context).textTheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(8),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Image.network(
                  movie.posterPath,
                  fit: BoxFit.cover,
                  width: size.width * 0.3,
                ),
              ),

              const SizedBox(width: 8),

              SizedBox(
                width: (size.width - 40) * 0.7,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(movie.title, style: textStyles.titleLarge),
                    Text(movie.overview),
                  ],
                ),
              ),
            ],
          ),
        ),

        Padding(
          padding: const EdgeInsets.all(8),
          child: Wrap(
            children: [
              ...movie.genreIds.map(
                (genre) => Container(
                  margin: const EdgeInsets.only(right: 8),
                  child: Chip(
                    label: Text(genre),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(24),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),

        _ActorsByMovie(actors: actors),

        SizedBox(height: 48),
      ],
    );
  }
}

class _ActorsByMovie extends StatelessWidget {
  final List<Actor> actors;

  const _ActorsByMovie({required this.actors});

  @override
  Widget build(BuildContext context) {
    if (actors.isEmpty) return const CircularProgressIndicator(strokeWidth: 2);

    return SizedBox(
      height: 300,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: actors.length,
        // shrinkWrap: true,
        // physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) {
          final actor = actors[index];
          return Container(
            padding: const EdgeInsets.all(8),
            width: 135,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ZoomIn(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(24),
                    child: Image.network(
                      actor.profilePath,
                      width: 135,
                      height: 180,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),

                const SizedBox(height: 8),

                Text(actor.name, maxLines: 2),

                Text(
                  actor.character ?? '',
                  maxLines: 2,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
