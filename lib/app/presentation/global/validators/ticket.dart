import 'package:formz/formz.dart';

// Define input validation errors
enum TicketError { empty }

// Extend FormzInput and provide the input type and error type.
class Ticket extends FormzInput<String, TicketError> {


  // Call super.pure to represent an unmodified form input.
  const Ticket.pure() : super.pure('');

  // Call super.dirty to represent a modified form input.
  const Ticket.dirty( String value ) : super.dirty(value);



  String? get errorMessage {
    if ( isValid || isPure ) return null;

    if ( displayError == TicketError.empty ) return 'El campo es requerido';

    return null;
  }

  // Override validator to handle validating a given input value.
  @override
  TicketError? validator(String value) {
    
    if ( value.isEmpty || value.trim().isEmpty ) return TicketError.empty;

    return null;
  }
}