import 'package:cinemapedia/config/constants/enviroment.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  static const String routeName = 'home-screen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Center(child: Text(Environment.movieFieldKey)));
  }
}
