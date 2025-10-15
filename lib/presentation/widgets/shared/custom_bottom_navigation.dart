import 'package:flutter/material.dart';

class CustomBottomNavigation extends StatelessWidget {
  const CustomBottomNavigation({super.key});

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      elevation: 0.0,
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.home_max), label: 'Home'),
        BottomNavigationBarItem(
          icon: Icon(Icons.movie_outlined),
          label: 'Categories',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person_outline),
          label: 'Favorites',
        ),
      ],
    );
  }
}
