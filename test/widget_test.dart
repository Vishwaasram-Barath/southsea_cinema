import 'package:flutter_test/flutter_test.dart';
import 'package:southsea_cinema/constants.dart';
import 'package:southsea_cinema/main.dart';
import 'package:southsea_cinema/views/movie_listing.dart';

void main() {
  testWidgets('Home page displays movies and booking buttons',
      (WidgetTester tester) async {
    await tester.pumpWidget(const SouthseaCinemaApp());
    await tester.pumpAndSettle();

    expect(find.text(appTitle), findsOneWidget);

    expect(find.text('Dune Part II'), findsOneWidget);
    expect(find.text('Interstellar'), findsOneWidget);

    expect(find.text('Book'), findsNWidgets(2));
  });

  testWidgets('', (WidgetTester tester) async {
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

    await tester.tap(find.text('ADD TO ORDER'));
    await tester.pump();

    expect(find.text('Choose at least one ticket.'), findsOneWidget);
  });
}
