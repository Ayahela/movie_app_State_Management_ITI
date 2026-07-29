import '../../core/utils/constants.dart';

class Movie {
  final int id;
  final String title;
  final String poster;
  final String backdrop;
  final double rating;
  final String releaseDate;
  final String overview;

  Movie({
    required this.id,
    required this.title,
    required this.poster,
    required this.backdrop,
    required this.rating,
    required this.releaseDate,
    required this.overview,
  });

  String get fullPosterUrl => '${ApiConstants.imageBaseUrlLW}$poster';

  String get fullBackdropUrl => '${ApiConstants.imageBaseUrlLW}$backdrop';

  factory Movie.fromJson(Map<String, dynamic> json) {
    return Movie(
      id: json['id'] ?? 0,
      title: json['title'] ?? '',
      overview: json['overview'] ?? '',
      rating: (json['vote_average'] ?? 0).toDouble(),

      poster: json['poster_path'] ?? '',
      backdrop: json['backdrop_path'] ?? '',

      releaseDate: json['release_date'] ?? '',
    );
  }
}
