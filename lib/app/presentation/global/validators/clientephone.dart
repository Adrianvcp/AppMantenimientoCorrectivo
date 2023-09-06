import 'package:formz/formz.dart';

// Define input validation errors
enum ClientePhoneError { empty }

// Extend FormzInput and provide the input type and error type.
class ClientePhone extends FormzInput<String, ClientePhoneError> {


  // Call super.pure to represent an unmodified form input.
  const ClientePhone.pure() : super.pure('');

  // Call super.dirty to represent a modified form input.
  const ClientePhone.dirty( String value ) : super.dirty(value);



  String? get errorMessage {
    if ( isValid || isPure ) return null;

    if ( displayError == ClientePhoneError.empty ) return 'El campo es requerido';

    return null;
  }

  // Override validator to handle validating a given input value.
  @override
  ClientePhoneError? validator(String value) {
    
    if ( value.isEmpty || value.trim().isEmpty ) return ClientePhoneError.empty;

    return null;
  }
}