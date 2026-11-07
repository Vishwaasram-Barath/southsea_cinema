import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:southsea_cinema/views/home_view.dart';

void main() {
  setUp(() {
    rootBundle.clear();
  });

  testWidgets('HomeView shows a loading indicator, then the films',
      (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(home: HomeView()));

    expect(find.byType(CircularProgressIndicator), findsOneWidget);
    expect(find.text('Dune Part II'), findsNothing);

    await tester.pumpAndSettle();

    expect(find.byType(CircularProgressIndicator), findsNothing);
    debugDumpApp();
    expect(find.text('Dune Part II'), findsOneWidget);
    expect(find.text('Interstellar'), findsOneWidget);
    expect(find.text('Book'), findsNWidgets(2));
  });
}
