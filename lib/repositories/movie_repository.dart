import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:southsea_cinema/models/movie.dart';

class MovieRepository {
  List<Movie>? _cachedMovies;

  List<Movie> getMovies() {
    final List<Movie>? cachedMovies = _cachedMovies;
    if (cachedMovies != null) {
      return cachedMovies;
    }
    return const [
      Movie(
        id: '1',
        title: 'Dune Part II',
        ageRating: 'PG',
        synopsis:
            'Paul Atreides unites with Chani and the Fremen while seeking revenge against the conspirators who destroyed his family.',
        screeningTime: 'Friday 9 OCT 18:00',
        imagePath: 'assets/images/Dune2.jpeg',
        price: 7.5,
      ),
      Movie(
        id: '2',
        title: 'Interstellar',
        ageRating: 'PG',
        synopsis:
            'When Earth becomes uninhabitable in the future, a farmer and ex-NASA pilot, Joseph Cooper, is tasked to pilot a spacecraft, along with a team of researchers, to find a new planet for humans.',
        screeningTime: 'Saturday 10 OCT 20:00',
        imagePath: 'assets/images/Interstellar.jpeg',
        price: 7.5,
      ),
    ];
  }

  Movie? getMovieById(String id) {
    for (final movie in getMovies()) {
      if (movie.id == id) {
        return movie;
      }
    }

    return null;
  }

  Future<List<Movie>> loadMoviesFromAsset({
    String assetPath = 'assets/data/movies.json',
  }) async {
    final String jsonString = await rootBundle.loadString(assetPath);
    final dynamic decodedData = jsonDecode(jsonString);
    final List<dynamic> jsonList = decodedData as List<dynamic>;
    final List<Movie> loadedMovies = [];

    for (final dynamic item in jsonList) {
      final Map<String, dynamic> itemMap = item as Map<String, dynamic>;
      final Movie movie = Movie.fromJson(itemMap);
      loadedMovies.add(movie);
    }

    _cachedMovies = loadedMovies;
    return loadedMovies;
  }

  List<Movie> getMoviesByAgeRating(String rating) {
    return getMovies().where((movie) => movie.ageRating == rating).toList();
  }

  List<Movie> getMoviesUnderPrice(double maxPrice) {
    return getMovies().where((movie) => movie.price < maxPrice).toList();
  }
}
