import 'package:formz/formz.dart';

// Define input validation errors
enum ClienteNameError { empty }

// Extend FormzInput and provide the input type and error type.
class ClienteName extends FormzInput<String, ClienteNameError> {


  // Call super.pure to represent an unmodified form input.
  const ClienteName.pure() : super.pure('');

  // Call super.dirty to represent a modified form input.
  const ClienteName.dirty( String value ) : super.dirty(value);



  String? get errorMessage {
    if ( isValid || isPure ) return null;

    if ( displayError == ClienteNameError.empty ) return 'El campo es requerido';

    return null;
  }

  // Override validator to handle validating a given input value.
  @override
  ClienteNameError? validator(String value) {
    
    if ( value.isEmpty || value.trim().isEmpty ) return ClienteNameError.empty;

    return null;
  }
}