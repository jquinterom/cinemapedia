import 'package:cinemapedia/config/database/database.dart';
import 'package:flutter/material.dart';

import 'package:cinemapedia/config/router/app_router.dart';
import 'package:cinemapedia/config/theme/app_theme.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await dotenv.load(fileName: '.env');

  // await db
  //     .into(db.favoriteMovies)
  //     .insert(
  //       FavoriteMoviesCompanion.insert(
  //         movieId: 1,
  //         backdropPath: 'backdropPath.png',
  //         originalTitle: 'originalTitle.title',
  //         posterPath: 'posterPath.png',
  //         title: 'title.title',
  //       ),
  //     );

  // final deleteQuery = db.delete(db.favoriteMovies);
  // await deleteQuery.go();

  final allItems = await db.select(db.favoriteMovies).get();

  print('items in database: $allItems');

  runApp(const ProviderScope(child: MainApp()));
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: appRouter,
      theme: AppTheme().getTheme(context),
      debugShowCheckedModeBanner: false,
    );
  }
}
