// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:wedeliver/main.dart';

void main() {
  testWidgets('Authentication Test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(MyApp());

    // Verify that our counter starts at 0.
    expect(find.text('Email'), findsOneWidget);
    expect(find.text('Password'), findsOneWidget);
    expect(find.text("Don't have an account? Create One"), findsOneWidget);
    
    expect(find.byKey(Key('Login')), findsOneWidget);
    expect(find.byKey(Key('GoToRegister')), findsOneWidget);
    
    var button =  find.byKey(Key('GoToRegister')).evaluate().first.widget as TextButton;
    button.onPressed!();
    await tester.pump();


    expect(find.text('Email'), findsOneWidget);
    expect(find.text('Password'), findsWidgets);
    expect(find.byKey(Key('RegisterButton')), findsOneWidget);
    expect(find.byKey(Key('GoToLogin')), findsOneWidget);
  });
}
