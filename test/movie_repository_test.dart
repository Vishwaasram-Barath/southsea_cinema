import 'package:flutter_test/flutter_test.dart';
import 'package:southsea_cinema/models/movie.dart';
import 'package:southsea_cinema/repositories/movie_repository.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  group('MovieRepository tests', () {
    test('getMovies returns at least two valid movies', () {
      final repository = MovieRepository();
      final List<Movie> movies = repository.getMovies();

      expect(movies.length, greaterThanOrEqualTo(2));

      final ids = movies.map((movie) => movie.id).toSet();
      expect(ids.length, movies.length);

      for (final movie in movies) {
        expect(movie.id, isNotEmpty);
        expect(movie.title, isNotEmpty);
        expect(movie.ageRating, isNotEmpty);
        expect(movie.price, greaterThan(0));
      }
    });

    test('getMovieById returns the correct existing movie', () {
      final repository = MovieRepository();

      final Movie? movie = repository.getMovieById('1');

      expect(movie, isNotNull);
      expect(movie?.title, 'Dune Part II');
    });

    test('getMovieById returns null for a missing ID', () {
      final repository = MovieRepository();

      final Movie? movie = repository.getMovieById('???');

      expect(movie, isNull);
    });

    test('getMoviesByAgeRating returns only films with that rating', () {
      final repository = MovieRepository();

      final movies = repository.getMoviesByAgeRating('PG');

      expect(movies, isNotEmpty);

      for (final movie in movies) {
        expect(movie.ageRating, 'PG');
      }
    });

    test('getMoviesUnderPrice returns only cheaper films', () {
      final repository = MovieRepository();

      final movies = repository.getMoviesUnderPrice(8.00);

      for (final movie in movies) {
        expect(movie.price, lessThan(8.00));
      }
    });

    test('loadMoviesFromAsset reads every film from the bundled JSON',
        () async {
      final repository = MovieRepository();

      final List<Movie> movies = await repository.loadMoviesFromAsset();

      expect(movies.length, 2);
      expect(movies[0].id, '1');
      expect(movies[0].title, 'Dune Part II');
      expect(movies[0].ageRating, 'PG');
      expect(movies[0].screeningTime, 'Friday 9 OCT 18:00');
      expect(movies[0].imagePath, 'assets/images/Dune2.jpeg');
      expect(movies[0].price, 7.5);
      expect(movies[1].id, '2');
      expect(movies[1].title, 'Interstellar');
      expect(repository.getMovies(), movies);
    });

    test('loadMoviesFromAsset throws when the asset does not exist', () async {
      final repository = MovieRepository();

      expect(
        () => repository.loadMoviesFromAsset(
          assetPath: 'assets/data/missing.json',
        ),
        throwsA(anything),
      );
    });
  });
}
