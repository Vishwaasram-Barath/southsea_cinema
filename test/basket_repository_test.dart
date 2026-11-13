import 'package:flutter_test/flutter_test.dart';
import 'package:southsea_cinema/models/basket_item.dart';
import 'package:southsea_cinema/models/movie.dart';
import 'package:southsea_cinema/repositories/basket_repository.dart';

const Movie testMovie1 = Movie(
  id: 't1',
  title: 'Test Film One',
  ageRating: 'PG',
  synopsis: 'A test film.',
  screeningTime: 'Friday 18:00',
  imagePath: 'assets/images/test1.jpeg',
  price: 10.0,
);

const Movie testMovie2 = Movie(
  id: 't2',
  title: 'Test Film Two',
  ageRating: '12A',
  synopsis: 'Another test film.',
  screeningTime: 'Saturday 20:00',
  imagePath: 'assets/images/test2.jpeg',
  price: 6.0,
);

void main() {
  setUp(() {
    BasketRepository.instance.clear();
  });

  group('BasketRepository tests', () {
    test('starts empty with zero totals', () {
      final BasketRepository basket = BasketRepository.instance;

      expect(basket.getItems(), isEmpty);
      expect(basket.getNumberOfTickets(), 0);
      expect(basket.getTotal(), 0.0);
    });

    test('adds tickets and calculates totals', () {
      final BasketRepository basket = BasketRepository.instance;

      basket.addItem(const BasketItem(movie: testMovie1, quantity: 2));
      basket.addItem(const BasketItem(movie: testMovie2, quantity: 1));

      expect(basket.getItems().length, 2);
      expect(basket.getNumberOfTickets(), 3);
      expect(basket.getTotal(), 26.0);
    });

    test('removes a ticket line by index', () {
      final BasketRepository basket = BasketRepository.instance;

      basket.addItem(const BasketItem(movie: testMovie1, quantity: 1));
      expect(basket.getItems().length, 1);

      basket.removeItem(0);

      expect(basket.getItems(), isEmpty);
      expect(basket.getTotal(), 0.0);
    });

    test('clear empties the basket', () {
      final BasketRepository basket = BasketRepository.instance;

      basket.addItem(const BasketItem(movie: testMovie1, quantity: 3));
      basket.clear();

      expect(basket.getItems(), isEmpty);
      expect(basket.getNumberOfTickets(), 0);
    });

    test('getItems returns an unmodifiable list', () {
      final BasketRepository basket = BasketRepository.instance;

      expect(
          () => basket
              .getItems()
              .add(const BasketItem(movie: testMovie1, quantity: 1)),
          throwsUnsupportedError);
    });
  });
}
