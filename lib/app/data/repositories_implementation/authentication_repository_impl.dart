


import 'package:app_manteni_correc/app/data/services/authentication_api.dart';

import 'package:app_manteni_correc/app/domain/models/user/user.dart';
import 'package:app_manteni_correc/app/domain/repositories/authentication_repository.dart';

class AuthRepositoryImpl implements AuthenticationRepository {

  final AuthenticationAPI _authenticationAPI;

  AuthRepositoryImpl(
    this._authenticationAPI
  ) ;

  @override
  Future<User> checkAuthStatus(int token, String username, String password) {
    return _authenticationAPI.checkAuthStatus(token,username,password);
  }

  @override
  Future<User> login(String email, String password) {
    return _authenticationAPI.login(email, password);
  }

}