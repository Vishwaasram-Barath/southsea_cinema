import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:southsea_cinema/models/basket_item.dart';
import 'package:southsea_cinema/models/movie.dart';
import 'package:southsea_cinema/repositories/basket_repository.dart';
import 'package:southsea_cinema/views/basket_view.dart';

const Movie testMovie = Movie(
  id: 't1',
  title: 'Test Film',
  ageRating: 'PG',
  synopsis: 'A test film.',
  screeningTime: 'Friday 18:00',
  imagePath: 'assets/images/test.jpeg',
  price: 7.5,
);

void main() {
  setUp(() {
    BasketRepository.instance.clear();
  });

  testWidgets('shows the empty message when the basket has no tickets',
      (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(home: BasketView()));

    expect(find.text('Your basket is empty'), findsOneWidget);
    expect(find.text('Checkout'), findsNothing);
  });

  testWidgets('shows ticket lines and removes one when delete is pressed',
      (WidgetTester tester) async {
    BasketRepository.instance.addItem(
      const BasketItem(movie: testMovie, quantity: 2),
    );

    await tester.pumpWidget(const MaterialApp(home: BasketView()));

    expect(find.text('Your basket'), findsOneWidget);
    expect(find.text('2 x Test Film'), findsOneWidget);
    expect(find.text('£15.00'), findsWidgets);
    expect(find.text('Checkout'), findsOneWidget);

    await tester.tap(find.byIcon(Icons.delete_outline));
    await tester.pump();

    expect(find.text('Your basket is empty'), findsOneWidget);
    expect(BasketRepository.instance.getItems(), isEmpty);
  });

  testWidgets('checkout clears the basket and shows a confirmation',
      (WidgetTester tester) async {
    BasketRepository.instance.addItem(
      const BasketItem(movie: testMovie, quantity: 1),
    );

    await tester.pumpWidget(const MaterialApp(home: BasketView()));

    await tester.tap(find.text('Checkout'));
    await tester.pump();

    expect(find.text('Your basket is empty'), findsOneWidget);
    expect(find.text('Thanks, your tickets are booked'), findsOneWidget);
    expect(BasketRepository.instance.getItems(), isEmpty);
  });
}
