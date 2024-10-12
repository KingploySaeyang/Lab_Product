// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fluttersuccess/main.dart';


void main() {
  testWidgets('LoginPage has a username and password field and a login button',
      (WidgetTester tester) async {
    // Build the LoginPage widget and trigger a frame.
    await tester.pumpWidget(MyApp());

    // Verify that there are two TextFields (username and password).
    expect(find.byType(TextField), findsNWidgets(2));

    // Verify that the login button is present.
    expect(find.text('Login'), findsOneWidget);

    // Enter text into the username and password fields.
    await tester.enterText(
        find.byWidgetPredicate((widget) =>
            widget is TextField && widget.decoration?.labelText == 'Username'),
        'testuser');
    await tester.enterText(
        find.byWidgetPredicate((widget) =>
            widget is TextField && widget.decoration?.labelText == 'Password'),
        'password');

    // Verify that the text was entered correctly.
    expect(find.text('testuser'), findsOneWidget);
    expect(find.text('password'), findsOneWidget);

    // Tap the login button.
    await tester.tap(find.text('Login'));
    await tester.pump();

    // Add further verifications if needed (e.g., navigation, error messages).
  });
}
