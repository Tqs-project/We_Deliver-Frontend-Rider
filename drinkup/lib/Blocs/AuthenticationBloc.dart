import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' show Client, Response;
import 'dart:io';

import 'package:wedeliver/Entities/LoginData.dart';

class AuthenticationBloc{
  StreamController<LoginData> loginStreamController = StreamController<LoginData>.broadcast();
  Stream get getLoginStream=> loginStreamController.stream;
  final String BASE_URL = 'webmarket-314811.oa.r.appspot.com';
  Client client = Client();


  Future<LoginData> register(String username, String password, String email, String phonenumber, String vehiclePlate) async {
    var uri = Uri.https(BASE_URL, ('/api/riders'));
    final response = await client.post(uri,
        headers: {
          HttpHeaders.contentTypeHeader: 'application/json',
          'Access-Control-Allow-Origin': '*'
        },
        body: jsonEncode({
          'user': {
            'username': username,
            'email': email,
            'role': 'RIDER',
            'password': password,
            'phoneNumber': phonenumber
          },
          'vehiclePlate': vehiclePlate
        }));


    if (response.statusCode == 201) {
      return await login(email, password);
    }
    return LoginData('','Failed To Register User');
  }

  Future<LoginData> login(String email, String password) async {
    var uri = Uri.https(BASE_URL, ('/api/riders/login'));
    final response = await client.post(uri,
        headers: {
          HttpHeaders.contentTypeHeader: 'application/json',
          'Access-Control-Allow-Origin': '*'
        },
        body: jsonEncode({
          'user': {
            'email': email,
            'password': password,
          }
        }));
        var _temp = LoginData(jsonDecode(response.body)['token'], jsonDecode(response.body)['errorMessage'] );

    update(_temp);
    return _temp;
  }
  void update(LoginData newdata){
    loginStreamController.sink.add(newdata);
  }
} 
final authBloc = AuthenticationBloc();