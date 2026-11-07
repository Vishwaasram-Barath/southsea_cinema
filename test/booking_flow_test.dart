import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:southsea_cinema/main.dart';
import 'package:southsea_cinema/repositories/basket_repository.dart';

Future<void> bookTickets(WidgetTester tester, String quantity) async {
  await tester.tap(find.text('Book').first);
  await tester.pumpAndSettle();

  await tester.tap(find.byType(DropdownMenu<int>));
  await tester.pumpAndSettle();
  await tester.tap(find.text(quantity).last);
  await tester.pumpAndSettle();

  await tester.tap(find.text('ADD TO ORDER'));
  await tester.pump();
}

Future<void> openBasket(WidgetTester tester) async {
  await tester.tap(find.byIcon(Icons.menu));
  await tester.pumpAndSettle();
  await tester.tap(find.text('My Basket'));
  await tester.pumpAndSettle();
}

void main() {
  setUp(() {
    rootBundle.clear();
    BasketRepository.instance.clear();
  });

  testWidgets('Tickets for a JSON film can be added and removed',
      (WidgetTester tester) async {
    await tester.pumpWidget(const SouthseaCinemaApp());
    await tester.pumpAndSettle();

    await bookTickets(tester, '2');
    await openBasket(tester);

    expect(find.text('2 x Dune Part II'), findsOneWidget);
    expect(find.text('£15.00'), findsWidgets);

    await tester.tap(find.byIcon(Icons.delete_outline));
    await tester.pump();

    expect(find.text('Your basket is empty'), findsOneWidget);
    expect(BasketRepository.instance.getItems(), isEmpty);
  });

  testWidgets('Checkout clears the basket without saving a booking',
      (WidgetTester tester) async {
    await tester.pumpWidget(const SouthseaCinemaApp());
    await tester.pumpAndSettle();

    await bookTickets(tester, '1');
    await openBasket(tester);

    expect(find.text('1 x Dune Part II'), findsOneWidget);

    await tester.tap(find.text('Checkout'));
    await tester.pump();

    expect(find.text('Thanks, your tickets are booked'), findsOneWidget);
    expect(find.text('Your basket is empty'), findsOneWidget);
    expect(BasketRepository.instance.getItems(), isEmpty);
  });
}
