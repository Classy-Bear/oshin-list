import 'package:formz/formz.dart';

/// Validation errors for the [DateTimeValidator] [FormzInput].
enum DateValidationEror {
  /// Generic invalid error.
  invalid
}

/// Form input for an date input.
class DateTimeValidator extends FormzInput<DateTime, DateValidationEror> {
  DateTimeValidator.pure() : super.pure(DateTime.now());

  DateTimeValidator.dirty(DateTime value) : super.dirty(value);

  @override
  DateValidationEror? validator(DateTime value) {
    return value.isBefore(DateTime.now()) ? DateValidationEror.invalid : null;
  }
}