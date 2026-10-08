import 'package:flutter_test/flutter_test.dart';
import 'package:southsea_cinema/constants.dart';
import 'package:southsea_cinema/main.dart';

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
}
