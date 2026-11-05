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

    test('fromJson and toJson convert every field', () {
      final Map<String, dynamic> json = <String, dynamic>{
        'id': 'json-film',
        'title': 'JSON Film',
        'ageRating': '12A',
        'synopsis': 'A film described in JSON.',
        'screeningTime': 'Sunday 16:30',
        'imagePath': 'assets/images/json.jpeg',
        'price': 8.25,
      };

      final Movie movie = Movie.fromJson(json);

      expect(movie.id, 'json-film');
      expect(movie.title, 'JSON Film');
      expect(movie.ageRating, '12A');
      expect(movie.synopsis, 'A film described in JSON.');
      expect(movie.screeningTime, 'Sunday 16:30');
      expect(movie.imagePath, 'assets/images/json.jpeg');
      expect(movie.price, 8.25);
      expect(movie.toJson(), json);
    });

    test('fromJson converts a whole-number price to a double', () {
      final Map<String, dynamic> json = <String, dynamic>{
        'id': 'whole-price',
        'title': 'Whole Price Film',
        'ageRating': 'U',
        'synopsis': 'Costs a whole number of pounds.',
        'screeningTime': 'Monday 14:00',
        'imagePath': 'assets/images/whole.jpeg',
        'price': 8,
      };

      final Movie movie = Movie.fromJson(json);

      expect(movie.price, isA<double>());
      expect(movie.price, 8.0);
    });
  });
}
