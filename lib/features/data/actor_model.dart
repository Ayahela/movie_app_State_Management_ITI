import 'package:movie_app/core/utils/constants.dart';

class Actor {
  final String name;
  final String? profilePath;
  Actor({required this.name, this.profilePath});

  factory Actor.fromJson(Map<String, dynamic> json) {
    return Actor(name: json['name'] ?? '', profilePath: json['profile_path']);
  }

  String get fullImageUrl {
    if (profilePath == null) {
      return '';
    }

    return "${ApiConstants.imageBaseUrlSW}$profilePath";
  }
}
