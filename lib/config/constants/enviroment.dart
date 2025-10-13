import 'package:flutter_dotenv/flutter_dotenv.dart';

class Environment {
  static final String movieFieldKey = dotenv.env['THE_MOVIE_DB_API_KEY'] ?? '';
  static final String movieApiUrl = dotenv.env['THE_MOVIE_DB_API_URL'] ?? '';
  static final String movieImageApiUrl =
      dotenv.env['THE_MOVIE_DB_IMAGE_API_URL'] ?? '';
}
