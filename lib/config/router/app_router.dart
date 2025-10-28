import 'package:cinemapedia/presentation/screens/screens.dart';
import 'package:go_router/go_router.dart';

const String initialRoute = '/home/0';

final appRouter = GoRouter(
  initialLocation: initialRoute,
  routes: [
    GoRoute(
      path: '/home/:screen',
      name: HomeScreen.routeName,
      builder: (context, state) {
        final int screenIndex = int.parse(
          state.pathParameters['screen'] ?? '0',
        );

        if (screenIndex > 2 || screenIndex < 0) {
          return const HomeScreen(screenIndex: 0);
        }

        return HomeScreen(screenIndex: screenIndex);
      },
      routes: [
        GoRoute(
          path: '/movie/:id',
          name: MovieScreen.routeName,
          builder: (context, state) =>
              MovieScreen(movieId: state.pathParameters['id'] ?? 'no-id'),
        ),
      ],
    ),

    GoRoute(path: '/', redirect: (_, __) => initialRoute),
  ],
);
