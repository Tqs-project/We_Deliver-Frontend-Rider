// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'dart:convert';
import 'dart:html';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:http/http.dart';
import 'package:wedeliver/Entities/LoginData.dart';

import 'package:wedeliver/main.dart';

class MockClient extends Mock implements Client {}
void main() {
  final client = MockClient();
  test('test login', () {

    when(client.post(Uri.parse('webmarket-314811.oa.r.appspot.com/api/riders')))
        .thenAnswer((_) async => Response('Created', 201));

    when(client.post(Uri.parse('webmarket-314811.oa.r.appspot.com/api/riders/login')))
        .thenAnswer((_) async=> Response('{"toker":"TOKEN", "errorMessage": "ERROR"}',200));

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
