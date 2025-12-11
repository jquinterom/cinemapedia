import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class CustomBottomNavigation extends StatelessWidget {
  final int currentIndex;

  const CustomBottomNavigation({super.key, required this.currentIndex});

  void onTabTapped(BuildContext context, int index) {
    context.go('/home/$index');
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      onTap: (index) => onTabTapped(context, index),
      type: BottomNavigationBarType.fixed,
      elevation: 0.0,
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.home_max_outlined),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.thumbs_up_down_outlined),
          label: 'Popular',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.favorite_outline),
          label: 'Favorites',
        ),
      ],
    );
  }
}
