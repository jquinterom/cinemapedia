import 'package:cinemapedia/presentation/screens/movies/home_screen.dart';
import 'package:cinemapedia/presentation/screens/screens.dart';
import 'package:go_router/go_router.dart';

final appRouter = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      name: HomeScreen.routeName,
      builder: (context, state) => const HomeScreen(),
      routes: [
        GoRoute(
          path: 'movie/:id',
          name: MovieScreen.routeName,
          builder: (context, state) =>
              MovieScreen(movieId: state.pathParameters['id'] ?? 'no-id'),
        ),
      ],
    ),
  ],
);
