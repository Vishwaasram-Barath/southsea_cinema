import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:southsea_cinema/views/settings_view.dart';

void main() {
  testWidgets('SettingsView displays the form fields, switch and save button',
      (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(home: SettingsView()));

    expect(find.text('Customer Profile'), findsOneWidget);
    expect(find.byType(TextField), findsNWidgets(3));
    expect(find.byType(Switch), findsOneWidget);
    expect(find.text('Save Settings'), findsOneWidget);
  });

  testWidgets('Entering details, toggling the switch and saving works',
      (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(home: SettingsView()));

    final Finder nameField = find.widgetWithText(TextField, 'Full name');
    final Finder addressField = find.widgetWithText(TextField, 'Address');
    final Finder emailField = find.widgetWithText(TextField, 'Email address');

    await tester.enterText(nameField, 'Alex Smith');
    await tester.enterText(addressField, '10 Elm Road, Portsmouth');
    await tester.enterText(emailField, 'alex@example.com');

    final Finder switchFinder = find.byType(Switch);
    expect(tester.widget<Switch>(switchFinder).value, isFalse);
    await tester.tap(switchFinder);
    await tester.pump();
    expect(tester.widget<Switch>(switchFinder).value, isTrue);

    await tester.tap(find.text('Save Settings'));
    await tester.pump();

    expect(find.text('Settings saved for Alex Smith'), findsOneWidget);
  });
}
