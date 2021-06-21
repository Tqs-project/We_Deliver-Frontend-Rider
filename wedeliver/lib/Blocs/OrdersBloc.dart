import 'dart:async';
import 'dart:convert';
import 'package:geocoder/geocoder.dart';
import 'package:http/http.dart' show Client, Response;
import 'package:wedeliver/Blocs/LocationBloc.dart';
import 'dart:io';

import 'package:wedeliver/Entities/Order.dart';
import 'package:wedeliver/Entities/Rider.dart';

class OrdersBloc {
  StreamController<Order> orderStreamController =
      StreamController<Order>.broadcast();
  Stream get getOrderStream => orderStreamController.stream;
  final String BASE_URL = 'webmarket-314811.oa.r.appspot.com';

  Future<Order> getRiderOrders(
      Rider rider, String token, Client client, LocationBloc locBloc) async {
    var uri = Uri.https(BASE_URL, ('/api/riders/order'));
    final response = await client.get(uri, headers: {
      'Access-Control-Allow-Origin': '*',
      'idToken': token,
      'username': rider.username
    });
    if (response.statusCode == 200) {
      if (json.decode(response.body)['id'] != null) {
        var order = Order.fromJson(json.decode(response.body));
        update(order);
        locBloc.initialize(rider.username, token, client);
        return order;
      }
    }
    update(Order.empty());
    return Order.empty();
  }

  Future<Response> declineOrder(
      Rider rider, String token, Client client, LocationBloc locBloc) async {
    var uri = Uri.https(BASE_URL, ('/api/riders/order/decline'));
    final response = await client.post(uri, headers: {
      HttpHeaders.contentTypeHeader: 'application/json',
      'Access-Control-Allow-Origin': '*',
      'idToken': token,
      'username': rider.username
    });
    if (response.statusCode == 200) {
      await getRiderOrders(rider, token, client, locBloc);
    }
    return response;
  }

  Future<Response> acceptOrder(Rider rider, String token, Client client) async {
    var uri = Uri.https(BASE_URL, ('/api/riders/order/accept'));
    final response = await client.post(uri, headers: {
      HttpHeaders.contentTypeHeader: 'application/json',
      'Access-Control-Allow-Origin': '*',
      'idToken': token,
      'username': rider.username
    });
    return response;
  }

  void update(Order newdata) {
    orderStreamController.sink.add(newdata);
  }

  Future<Response> delivered(
      int id, String token, String username, Client client) async {
    var uri = Uri.https(
        BASE_URL, ('/api/riders/ride/' + id.toString() + '/delivered'));
    final response = await client.post(uri, headers: {
      HttpHeaders.contentTypeHeader: 'application/json',
      'Access-Control-Allow-Origin': '*',
      'idToken': token,
      'username': username
    });
    return response;
  }
}

final ordersBloc = OrdersBloc();
