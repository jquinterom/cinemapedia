import 'package:cinemapedia/presentation/views/views.dart';
import 'package:cinemapedia/presentation/widgets/widgets.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  static const String routeName = 'home-screen';
  final int screenIndex;

  const HomeScreen({super.key, required this.screenIndex});

  final viewRoutes = const <Widget>[
    HomeView(),
    CategoriesView(),
    FavoritesView(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(index: screenIndex, children: viewRoutes),
      bottomNavigationBar: CustomBottomNavigation(currentIndex: screenIndex),
    );
  }
}
