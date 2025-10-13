import 'package:flutter_dotenv/flutter_dotenv.dart';

class Environment {
  static final String movieFieldKey = dotenv.env['THE_MOVIE_DB_API_KEY'] ?? '';
}
