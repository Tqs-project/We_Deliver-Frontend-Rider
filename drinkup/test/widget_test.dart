// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter_test/flutter_test.dart';

import 'package:wedeliver/main.dart';

void main() {
  testWidgets('Authentication Test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(MyApp());

    // Verify that our counter starts at 0.
    expect(find.text('Log In'), findsOneWidget);
    expect(find.text('Email'), findsOneWidget);
    expect(find.text('Password'), findsOneWidget);
    expect(find.text('Register'), findsNothing);

    // Tap the '+' icon and trigger a frame.
    // ignore: deprecated_member_use
    //await tester.press(find.ancestor(
    //   of: find.text('Create One'), matching: find.byType(RaisedButton)));
    //await tester.pump();

    // Verify that our counter has incremented.
    expect(find.text('Register'), findsOneWidget);
    expect(find.text('Email'), findsOneWidget);
    expect(find.text('Password'), findsWidgets);
    expect(find.text('Register'), findsNothing);
  });
}
