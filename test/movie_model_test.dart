import 'package:flutter_test/flutter_test.dart';
import 'package:southsea_cinema/models/movie.dart';

void main() {
  group('Movie model tests', () {
    test('creates Movie with the correct properties', () {
      const movie = Movie(
        id: '1',
        title: 'Test Movie',
        ageRating: 'PG',
        synopsis: 'test.',
        screeningTime: 'Friday 18:00',
        imagePath: 'assets/images/test.jpg',
        price: 6.00,
      );

      expect(movie.id, '1');
      expect(movie.title, 'Test Movie');
      expect(movie.ageRating, 'PG');
      expect(movie.synopsis, 'test.');
      expect(movie.screeningTime, 'Friday 18:00');
      expect(movie.imagePath, 'assets/images/test.jpg');
      expect(movie.price, 6.00);
    });

    test('formattedPrice displays pounds and two decimal places', () {
      const movie = Movie(
        id: 'test-movie',
        title: 'Test Movie',
        ageRating: 'PG',
        synopsis: 'test',
        screeningTime: 'Friday 18:00',
        imagePath: 'assets/images/test.jpg',
        price: 6.00,
      );

      expect(movie.formattedPrice, '£6.00');
    });

    test('U and PG films are child friendly', () {
      const uMovie = Movie(
        id: 'u-film',
        title: 'U Film',
        ageRating: 'U',
        synopsis: 'test',
        screeningTime: 'Friday 18:00',
        imagePath: 'assets/images/test.jpg',
        price: 5.00,
      );

      const pgMovie = Movie(
        id: 'pg-film',
        title: 'PG Film',
        ageRating: 'PG',
        synopsis: 'test',
        screeningTime: 'Friday 18:00',
        imagePath: 'assets/images/test.jpg',
        price: 5.00,
      );

      expect(uMovie.isChildFriendly, isTrue);
      expect(pgMovie.isChildFriendly, isTrue);
    });

    test('18 films are adult only', () {
      const adultMovie = Movie(
        id: 'adult-film',
        title: 'Adult Film',
        ageRating: '18',
        synopsis: 'test',
        screeningTime: 'Friday 18:00',
        imagePath: 'assets/images/test.jpg',
        price: 8.00,
      );

      const pgMovie = Movie(
        id: 'pg-film',
        title: 'PG Film',
        ageRating: 'PG',
        synopsis: 'test',
        screeningTime: 'Friday 18:00',
        imagePath: 'assets/images/test.jpg',
        price: 5.00,
      );

      expect(adultMovie.isAdultOnly, isTrue);
      expect(pgMovie.isAdultOnly, isFalse);
    });
  });
}
