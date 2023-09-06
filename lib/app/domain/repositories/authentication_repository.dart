
import 'package:app_manteni_correc/app/domain/models/user/user.dart';

abstract class AuthenticationRepository{
   Future<User> login(String username, String password);
   Future<User> checkAuthStatus(int token, String username, String password );
}

