import 'package:flutter_bloc/flutter_bloc.dart';

import '../data/movie_api.dart';
import 'movie_state.dart';

class MovieCubit extends Cubit<MovieState> {
  MovieCubit() : super(MovieInitial());

  MovieApi api = MovieApi();

  Future<void> getMovies() async {
    emit(MovieLoading());

    try {
      var movies = await api.getMovies();

      emit(MovieSuccess(movies));
    } catch (e) {
      emit(MovieError(e.toString()));
    }
  }

  Future<void> getActors(int movieId) async {
    emit(ActorsLoading());

    try {
      var actors = await api.getActors(movieId);

      emit(ActorsSuccess(actors));
    } catch (e) {
      emit(ActorsError(e.toString()));
    }
  }
}