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

  test(
      'test postLocation ------------------------------------------------------',
      () async {
    var response = await locBloc.postLocation(
        'TOKEN', 'username', LatLng(lat: 0, lng: 0), client);
    expect(response.statusCode, equals(200));
    expect(response.body, equals('POSTED'));
  });
}
