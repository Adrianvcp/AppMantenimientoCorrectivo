import 'package:formz/formz.dart';

// Define input validation errors
enum SedeError { empty }

// Extend FormzInput and provide the input type and error type.
class Sede extends FormzInput<String, SedeError> {


  // Call super.pure to represent an unmodified form input.
  const Sede.pure() : super.pure('');

  // Call super.dirty to represent a modified form input.
  const Sede.dirty( String value ) : super.dirty(value);



  String? get errorMessage {
    if ( isValid || isPure ) return null;

    if ( displayError == SedeError.empty ) return 'El campo es requerido';

    return null;
  }

  // Override validator to handle validating a given input value.
  @override
  SedeError? validator(String value) {
    
    if ( value.isEmpty || value.trim().isEmpty ) return SedeError.empty;

    return null;
  }
}