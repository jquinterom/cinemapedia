import 'package:cinemapedia/config/constants/enviroment.dart';
import 'package:cinemapedia/domain/entities/movie.dart';
import 'package:cinemapedia/infastructure/models/moviedb/movie_details.dart';
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

  static Movie movieDetailsToEntity(MovieDetails movieDetails) {
    return Movie(
      adult: movieDetails.adult,
      backdropPath: movieDetails.backdropPath != ''
          ? Environment.movieImageApiUrl + movieDetails.backdropPath
          : 'https://ih1.redbubble.net/image.1861339560.3228/fposter,medium,wall_texture,product,750x1000.webp',
      genreIds: movieDetails.genres.map((genre) => genre.name).toList(),
      id: movieDetails.id,
      originalLanguage: movieDetails.originalLanguage,
      originalTitle: movieDetails.originalTitle,
      overview: movieDetails.overview,
      popularity: movieDetails.popularity,
      posterPath: movieDetails.posterPath != ''
          ? Environment.movieImageApiUrl + movieDetails.posterPath
          : 'https://ih1.redbubble.net/image.1861339560.3228/fposter,medium,wall_texture,product,750x1000.webp',
      releaseDate: movieDetails.releaseDate,
      title: movieDetails.title,
      video: movieDetails.video,
      voteAverage: movieDetails.voteAverage,
      voteCount: movieDetails.voteCount,
    );
  }
}
