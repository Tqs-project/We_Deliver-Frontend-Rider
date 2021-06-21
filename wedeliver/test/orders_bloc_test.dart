import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:wedeliver/Blocs/LocationBloc.dart';
import 'package:wedeliver/Blocs/OrdersBloc.dart';
import 'package:wedeliver/Entities/Rider.dart';

import 'authentication_bloc_test.mocks.dart';

final String BASE_URL = 'https://webmarket-314811.oa.r.appspot.com';

class MockLocationBloc extends Mock implements LocationBloc {}

@GenerateMocks([http.Client])
void main() {
  final testRider =
      Rider('username', 'email', 'password', 'phonenumber', 'licenseplate');
  var mock = MockLocationBloc();

  final ordersBloc = OrdersBloc();
  final client = MockClient();
  when(mock.initialize('username', 'TOKEN', client))
      .thenAnswer((_) async => http.Response("Doesn't matter", 200));
  when(client.get(Uri.parse(BASE_URL + '/api/riders/order'),
          headers: anyNamed('headers')))
      .thenAnswer((_) async => http.Response(
          '{ "id": 0, "orderTimestamp": "2021-06-19T16:56:47.144+00:00","paymentType": "Card", "status": "WAITING",'
          ' "cost": 100, "customerLocation": "Aveiro", "location": "Porto", "customerId": 0,'
          '"username": "username", "rideId": null}',
          200));
  when(client.post(Uri.parse(BASE_URL + '/api/riders/order/decline'),
          headers: anyNamed('headers'),
          body: anyNamed('body'),
          encoding: anyNamed('encoding')))
      .thenAnswer((_) async => http.Response('', 200));
  when(client.post(Uri.parse(BASE_URL + '/api/riders/order/accept'),
          headers: anyNamed('headers'),
          body: anyNamed('body'),
          encoding: anyNamed('encoding')))
      .thenAnswer((_) async => http.Response('Have a nice Ride', 200));
  when(client.post(Uri.parse(BASE_URL + '/api/riders/ride/0/delivered'),
          headers: anyNamed('headers'),
          body: anyNamed('body'),
          encoding: anyNamed('encoding')))
      .thenAnswer((_) async => http.Response('', 200));
  test(
      'test GetRidersOrders ------------------------------------------------------',
      () async {
    var response =
        await ordersBloc.getRiderOrders(testRider, 'TOKEN', client, mock);
    expect(response.cost, equals(100));
    expect(response.id, equals(0));
  });

  test(
      'test declineOrder ------------------------------------------------------',
      () async {
    var response =
        await ordersBloc.declineOrder(testRider, 'TOKEN', client, mock);
    expect(response.statusCode, equals(200));
  });

  test('test delivered ------------------------------------------------------',
      () async {
    var response = await ordersBloc.delivered(0, 'TOKEN', 'username', client);
    expect(response.statusCode, equals(200));
  });
}
