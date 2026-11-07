import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:southsea_cinema/constants.dart';
import 'package:southsea_cinema/main.dart';
import 'package:southsea_cinema/views/movie_listing.dart';
import 'package:southsea_cinema/views/basket_view.dart';
import 'package:southsea_cinema/views/settings_view.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences_platform_interface/in_memory_shared_preferences_async.dart';
import 'package:shared_preferences_platform_interface/shared_preferences_async_platform_interface.dart';

void main() {
  setUp(() {
    rootBundle.clear();
    SharedPreferencesAsyncPlatform.instance =
        InMemorySharedPreferencesAsync.empty();
  });
  testWidgets('Home page displays movies and booking buttons',
      (WidgetTester tester) async {
    await tester.pumpWidget(const SouthseaCinemaApp());
    await tester.pumpAndSettle();

    expect(find.text(appTitle), findsOneWidget);

    expect(find.text('Dune Part II'), findsOneWidget);
    expect(find.text('Interstellar'), findsOneWidget);

    expect(find.text('Book'), findsNWidgets(2));
  });

  testWidgets('Book button opens the selected movie listing',
      (WidgetTester tester) async {
    await tester.pumpWidget(const SouthseaCinemaApp());
    await tester.pumpAndSettle();

    await tester.tap(find.text('Book').first);
    await tester.pumpAndSettle();

    expect(find.byType(MovieListing), findsOneWidget);
    expect(find.text('Dune Part II (PG)'), findsOneWidget);
    expect(
        find.text(
            'Paul Atreides unites with Chani and the Fremen while seeking revenge against the conspirators who destroyed his family.'),
        findsOneWidget);
    expect(find.text('Friday 9 OCT 18:00'), findsOneWidget);

    await tester.tap(find.byType(DropdownMenu<int>));
    await tester.pumpAndSettle();

    await tester.tap(find.text('1').last);
    await tester.pumpAndSettle();

    await tester.tap(find.text('ADD TO ORDER'));
    await tester.pump();

    expect(find.text('1 ticket(s) added to your order'), findsOneWidget);
  });

  testWidgets('Drawer My Basket opens the basket page',
      (WidgetTester tester) async {
    await tester.pumpWidget(const SouthseaCinemaApp());
    await tester.pumpAndSettle();

    await tester.tap(find.byIcon(Icons.menu));
    await tester.pumpAndSettle();

    await tester.tap(find.text('My Basket'));
    await tester.pumpAndSettle();

    expect(find.byType(BasketView), findsOneWidget);
  });

  testWidgets('Drawer My Settings opens the settings page',
      (WidgetTester tester) async {
    await tester.pumpWidget(const SouthseaCinemaApp());
    await tester.pumpAndSettle();

    await tester.tap(find.byIcon(Icons.menu));
    await tester.pumpAndSettle();

    await tester.tap(find.text('My Settings'));
    await tester.pumpAndSettle();

    expect(find.byType(SettingsView), findsOneWidget);
  });
}
