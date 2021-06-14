import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' show Client, Response;
import 'dart:io';

import 'package:wedeliver/Entities/LoginData.dart';
import 'package:wedeliver/Entities/Rider.dart';

class AuthenticationBloc {
  StreamController<LoginData> loginStreamController =
      StreamController<LoginData>.broadcast();
  Stream get getLoginStream => loginStreamController.stream;
  final String BASE_URL = 'webmarket-314811.oa.r.appspot.com';

  Future<Response> register(Rider rider, Client client) async {
    var uri = Uri.https(BASE_URL, ('/api/riders'));
    final response = await client.post(uri,
        headers: {
          HttpHeaders.contentTypeHeader: 'application/json',
          'Access-Control-Allow-Origin': '*'
        },
        body: jsonEncode({
          'user': {
            'username': rider.username,
            'email': rider.email,
            'role': 'RIDER',
            'password': rider.password,
            'phoneNumber': rider.phonenumber
          },
          'vehiclePlate': rider.vehiclePlate
        }));

    if (response.statusCode == 201) {
      return response;
    }
    return response;
  }

  Future<LoginData> login(Rider rider, Client client) async {
    var uri = Uri.https(BASE_URL, ('/api/riders/login'));
    final response = await client.post(uri,
        headers: {
          HttpHeaders.contentTypeHeader: 'application/json',
          'Access-Control-Allow-Origin': '*'
        },
        body: jsonEncode({
          'user': {
            'email': rider.email,
            'password': rider.password,
          }
        }));
    var _temp = LoginData(jsonDecode(response.body)['token'],
        jsonDecode(response.body)['errorMessage']);

    update(_temp);
    return _temp;
  }

  void update(LoginData newdata) {
    loginStreamController.sink.add(newdata);
  }
}

final authBloc = AuthenticationBloc();
