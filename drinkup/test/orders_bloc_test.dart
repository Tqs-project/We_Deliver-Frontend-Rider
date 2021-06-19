import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart' as ft_test;
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:wedeliver/Blocs/AuthenticationBloc.dart';
import 'package:wedeliver/Entities/Rider.dart';

import 'authentication_bloc_test.mocks.dart';

final String BASE_URL = 'https://webmarket-314811.oa.r.appspot.com';

@GenerateMocks([http.Client])
void main() {
  final testRider =
      Rider('username', 'email', 'password', 'phonenumber', 'licenseplate');

  final client = MockClient();

  test('test register ------------------------------------------------------',
      () async {
    var client = ft_test.MockClient((request) async {
      return http.Response('Created', 201);
    });
    final authBlocMock = AuthenticationBloc();

    var response = await authBlocMock.register(testRider, client);
    expect(response.statusCode, equals(201));
  });

  test('test Login -------------------------------------------------------',
      () async {
    when(client.post(Uri.parse(BASE_URL + '/api/riders/login'),
            headers: anyNamed('headers'),
            body: anyNamed('body'),
            encoding: anyNamed('encoding')))
        .thenAnswer((_) async =>
            http.Response('{"token":"TOKEN", "errorMessage":"ERROR"}', 200));

    when(client.get(
      Uri.parse(BASE_URL + '/api/riders'),
      headers: anyNamed('headers'),
    )).thenAnswer((_) async => http.Response(
        '{"id": 4,"username": "Pedro","email": "pedro@gmail.com", "role": "RIDER", "phoneNumber": "9134562", "vehiclePlate": "HH-45-56",  "comments": [],' +
            ' "lat": "40.6082531", "lng": "-8.6394009", "busy": false, "rides": []}',
        200));

    final authBlocMock = AuthenticationBloc();

    var response = await authBlocMock.login(testRider, client);
    expect(response.token, equals('TOKEN'));
    expect(response.error, equals('ERROR'));
  });
}
