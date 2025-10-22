import 'package:cinemapedia/config/constants/enviroment.dart';
import 'package:cinemapedia/domain/entities/actor.dart';
import 'package:cinemapedia/infastructure/models/moviedb/credits_response.dart';

class ActorMapper {
  static Actor castToEntity(Cast cast) => Actor(
    id: cast.id.toString(),
    name: cast.name,
    profilePath: cast.profilePath != null
        ? Environment.movieImageApiUrl + cast.profilePath!
        : 'https://i.pinimg.com/474x/07/c4/72/07c4720d19a9e9edad9d0e939eca304a.jpg',
    character: cast.character,
  );
}
