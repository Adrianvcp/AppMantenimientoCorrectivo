import 'package:app_manteni_correc/app/data/repositories_implementation/authentication_repository_impl.dart';
import 'package:app_manteni_correc/app/data/repositories_implementation/key_value_storage_service_impl.dart';
import 'package:app_manteni_correc/app/data/services/authentication_api.dart';
import 'package:app_manteni_correc/app/domain/models/user/user.dart';
import 'package:app_manteni_correc/app/domain/repositories/authentication_repository.dart';
import 'package:app_manteni_correc/app/domain/repositories/key_value_storage_service.dart';
import 'package:app_manteni_correc/app/presentation/global/validators/password.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http; 

final authProvider = StateNotifierProvider<AuthNotifier,AuthState>((ref) {

  final authRepository = AuthRepositoryImpl(AuthenticationAPI(http.Client()));
  final keyValueStorageService = KeyValueStorageServiceImpl();

  return AuthNotifier(
    authRepository: authRepository,
    keyValueStorageService: keyValueStorageService
  );
});



class AuthNotifier extends StateNotifier<AuthState> {

  final AuthenticationRepository authRepository;
  final KeyValueStorageService keyValueStorageService;

  AuthNotifier({
    required this.authRepository,
    required this.keyValueStorageService,
  }): super( AuthState() ) {
    checkAuthStatus();
  }
  

  Future<void> loginUser( String email, String password ) async {

    try {
      final user = await authRepository.login(email, password);
      _setLoggedUser( user );

    }  catch (e){
      logout( 'Usuario o contraseña incorrecto' );
    }

  }

  void checkAuthStatus() async {
    final token = await keyValueStorageService.getValue<int>('token');
    final username = await keyValueStorageService.getValue<String>('usern');
    final password = await keyValueStorageService.getValue<String>('passw');

    if( token == null ) return logout();
    if( username == null ) return logout();
    if( password == null ) return logout();
    try {
      final user = await authRepository.checkAuthStatus(token,username,password);
      _setLoggedUser(user);

    } catch (e) {
      logout();
    }
  }

  void _setLoggedUser( User user ) async {
    await keyValueStorageService.setKeyValue('token', user.userDetails.idUser);
    await keyValueStorageService.setKeyValue('usern', user.userDetails.username);
    await keyValueStorageService.setKeyValue('passw', user.userDetails.password);

    state = state.copyWith(
      user: user,
      authStatus: AuthStatus.authenticated,
      errorMessage: '',
    );
  }

  Future<void> logout([ String? errorMessage ]) async {
    await keyValueStorageService.removeKey('token');
    await keyValueStorageService.removeKey('usern');
    await keyValueStorageService.removeKey('passw');

    state = state.copyWith(
      authStatus: AuthStatus.notAuthenticated,
      user: null,
      errorMessage: errorMessage
    );
  }

}



enum AuthStatus { checking, authenticated, notAuthenticated }

class AuthState {

  final AuthStatus authStatus;
  final User? user;
  final String errorMessage;

  AuthState({
    this.authStatus = AuthStatus.checking, 
    this.user, 
    this.errorMessage = ''
  });

  AuthState copyWith({
    AuthStatus? authStatus,
    User? user,
    String? errorMessage,
  }) => AuthState(
    authStatus: authStatus ?? this.authStatus,
    user: user ?? this.user,
    errorMessage: errorMessage ?? this.errorMessage
  );




}