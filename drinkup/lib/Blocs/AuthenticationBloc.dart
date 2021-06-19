import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' show Client, Response;
import 'dart:io';

import 'package:wedeliver/Entities/LoginData.dart';
import 'package:wedeliver/Entities/Rider.dart';

class AuthenticationBloc {
  StreamController<UserData> loginStreamController =
      StreamController<UserData>.broadcast();
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
          'username': rider.username,
          'password': rider.password,
        }));
    var _temp = LoginData(jsonDecode(response.body)['token'],
        jsonDecode(response.body)['errorMessage']);
    if (_temp.token.isNotEmpty) {
      var currentRider =
          await getUserByUsername(rider.username, client, _temp.token);
      update(_temp, currentRider);
    }

    return _temp;
  }

  Future<Rider> getUserByUsername(
      String username, Client client, String idToken) async {
    var uri = Uri.https(BASE_URL, ('/api/riders'));
    final response = await client.get(uri, headers: {
      'Access-Control-Allow-Origin': '*',
      'username': username,
      'idToken': idToken
    });
    if (response.statusCode == 200) {
      var rider = Rider.fromJson(json.decode(response.body));
      return rider;
    }

    return Rider.empty();
  }

  void update(LoginData newdata, Rider currentRider) {
    var _temp = UserData(newdata, currentRider);
    loginStreamController.sink.add(_temp);
  }
}

class UserData {
  UserData(this.loginData, this.riderData);
  UserData.empty();
  LoginData loginData = LoginData.empty();
  Rider riderData = Rider.empty();
}

final authBloc = AuthenticationBloc();
