import 'package:movie_list_redux/src/models/movie.dart';

class GetMovies {}

class GetMoviesSuccessful {
  GetMoviesSuccessful(this.movies);

  final List<Movie> movies;
}

class GetMovieError {
  GetMovieError(this.error);

  final dynamic error;
}
