import 'package:southsea_cinema/views/movie_listing.dart';

class Movie {
  final String id;
  final String title;
  final String ageRating;
  final String synopsis;
  final String screeningTime;
  final String imagePath;

  const Movie({
    required this.id,
    required this.title,
    required this.ageRating,
    required this.synopsis,
    required this.screeningTime,
    required this.imagePath
  });
}
