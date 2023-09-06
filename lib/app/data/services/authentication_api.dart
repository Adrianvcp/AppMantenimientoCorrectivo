import 'dart:convert';

import 'package:app_manteni_correc/app/data/services/errors/user_error.dart';
import 'package:app_manteni_correc/app/domain/models/user/user.dart';
import 'package:http/http.dart';

class AuthenticationAPI {
  AuthenticationAPI(this._client);

  final Client _client;
  final _baseUrl ='https://invulnerable-bastille-39566-a52ccd510b57.herokuapp.com/api';

  Future<User> login(String username, String password) async {

    final response = await _client.post(
      Uri.parse('$_baseUrl/user/login'),headers: {"Content-Type": "application/json"},
      body: json.encode({'username': username, 'password': password})
    );

    if(response.statusCode==200){
      jsonDecode(response.body);
      final user = userFromJson(response.body);
      final userDetails = user;
      return userDetails;
    }
    else {
      throw UserApiError();
    }
  }


  Future<User> checkAuthStatus(int token,String username,String password) async {
    final response = await _client.post(
      Uri.parse('$_baseUrl/user/login'),headers: {"Content-Type": "application/json"},body: json.encode({'username': username, 'password': password})
    );

    if(response.statusCode==200){
      jsonDecode(response.body);
      final user = userFromJson(response.body);
      final userDetails = user;
      return userDetails;
    }
    else {
      throw UserApiError();
    }
  }
}