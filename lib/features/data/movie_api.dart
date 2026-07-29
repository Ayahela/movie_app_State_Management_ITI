import 'package:dio/dio.dart';
import '../../core/api/api_service.dart';
import 'movie_model.dart';
import 'actor_model.dart';

class MovieApi {
  ApiService api = ApiService();
  Future<List<Movie>> getMovies() async {

    Response response =
    await api.getData(
        "https://api.themoviedb.org/3/movie/popular"
    );

    List data = response.data["results"];

    return data.map((e)=>Movie.fromJson(e)).toList();
  }



  Future<List<Actor>> getActors(int movieId) async {

    Response response =
    await api.getData(
        "https://api.themoviedb.org/3/movie/$movieId/credits"
    );


    List actors = response.data["cast"];


    return actors
        .take(10)
        .map((e)=>Actor.fromJson(e))
        .toList();
  }

}