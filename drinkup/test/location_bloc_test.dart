import 'package:flutter_test/flutter_test.dart';

import 'package:http/http.dart' as http;
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:wedeliver/Blocs/LocationBloc.dart';
import 'package:wedeliver/locations.dart';

import 'authentication_bloc_test.mocks.dart';

final String BASE_URL = 'https://webmarket-314811.oa.r.appspot.com';

@GenerateMocks([http.Client])
void main() {
  final locBloc = LocationBloc();

  final client = MockClient();
  locBloc.location = LatLng(lat: 0, lng: 0);

  when(client.post(Uri.parse(BASE_URL + ('/api/riders/location')),
          headers: anyNamed('headers'), body: anyNamed('body')))
      .thenAnswer((_) async => http.Response('POSTED', 200));
  /*
  var url =
      'https://maps.googleapis.com/maps/api/directions/json?origin=0.0,0.0&destination=CUSTOMER&waypoints=STORE&key=AIzaSyBPi7DD20WaxRNbaic5aVNwV3mbWCnioHk';

  when(client.get(Uri.parse(url), headers: anyNamed('headers'))).thenAnswer(
      (_) async => http.Response(
          '{ "routes": [ {"legs":[{"distance":{"value":0} }], "overview_polyline":{"points":"1"}} ]}',
          200));

  test(
      'test CalculateRoute ------------------------------------------------------',
      () async {
    var response = await locBloc.calculateRoute('STORE', 'CUSTOMER', client);
    expect(response.statusCode, equals(200));
    expect(
        json.decode(response.body)['routes'][0]['overview_polyline']['points'],
        equals('1'));
  });

  test(
      'test getDistance ------------------------------------------------------',
      () async {
    var response = await locBloc.getDistance('STORE', 'CUSTOMER', client);
    expect(response, equals(0));
  });*/

  test(
      'test postLocation ------------------------------------------------------',
      () async {
    var response = await locBloc.postLocation(
        'TOKEN', 'username', LatLng(lat: 0, lng: 0), client);
    expect(response.statusCode, equals(200));
    expect(response.body, equals('POSTED'));
  });
}
