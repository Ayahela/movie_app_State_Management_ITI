import '../data/actor_model.dart';
import '../data/movie_model.dart';
abstract class MovieState {}

class MovieInitial extends MovieState {}
class MovieLoading extends MovieState {}
class MovieSuccess extends MovieState {
  final List<Movie> movies;

  MovieSuccess(this.movies);
}
class MovieError extends MovieState {
  final String message;

  MovieError(this.message);
}

class ActorsLoading extends MovieState {}
class ActorsSuccess extends MovieState {
  final List<Actor> actors;

  ActorsSuccess(this.actors);
}
class ActorsError extends MovieState {
  final String message;

  ActorsError(this.message);
}