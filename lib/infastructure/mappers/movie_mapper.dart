import 'package:cinemapedia/config/constants/enviroment.dart';
import 'package:cinemapedia/domain/entities/movie.dart';
import 'package:cinemapedia/infastructure/models/moviedb/movie_moviedb.dart';

class MovieMapper {
  static Movie movieDbToEntity(MovieMovieDB movieDb) {
    return Movie(
      adult: movieDb.adult,
      backdropPath: movieDb.backdropPath != ''
          ? Environment.movieImageApiUrl + movieDb.backdropPath
          : 'https://ih1.redbubble.net/image.1861339560.3228/fposter,medium,wall_texture,product,750x1000.webp',
      genreIds: movieDb.genreIds.map((genreId) => genreId.toString()).toList(),
      id: movieDb.id,
      originalLanguage: movieDb.originalLanguage,
      originalTitle: movieDb.originalTitle,
      overview: movieDb.overview,
      popularity: movieDb.popularity,
      posterPath: movieDb.posterPath != ''
          ? Environment.movieImageApiUrl + movieDb.posterPath
          : 'no-poster',
      releaseDate: movieDb.releaseDate,
      title: movieDb.title,
      video: movieDb.video,
      voteAverage: movieDb.voteAverage,
      voteCount: movieDb.voteCount,
    );
  }
}
