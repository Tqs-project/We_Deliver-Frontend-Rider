// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart' as ft_test;
import 'package:mockito/annotations.dart';
import 'package:wedeliver/Blocs/AuthenticationBloc.dart';
import 'package:wedeliver/Entities/Rider.dart';

final String BASE_URL = 'webmarket-314811.oa.r.appspot.com';
@GenerateMocks([http.Client])
void main() {
  final testRider =
      Rider('username', 'password', 'email', 'phonenumber', 'licenseplate');

  test('test login', () async {
    var client = ft_test.MockClient((request) async {
      return http.Response('Created', 201);
    });
    final authBlocMock = AuthenticationBloc();

    var response = await authBlocMock.register(testRider, client);
    expect(response.statusCode, equals(201));
  });

  test('test register', () async {
    var client = ft_test.MockClient((request) async {
      return http.Response('{"token":"TOKEN", "errorMessage":"ERROR"}', 200);
    });
    final authBlocMock = AuthenticationBloc();

    var response = await authBlocMock.login(testRider, client);
    expect(response.token, equals('TOKEN'));
    expect(response.error, equals('ERROR'));
  });
}
