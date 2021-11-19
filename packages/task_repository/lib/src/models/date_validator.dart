part of 'models.dart';

/// Validation errors for the [DateTimeValidator] [FormzInput].
enum DateTimeValidationEror {
  /// Generic invalid error.
  invalid
}

/// Form input for an date input.
class DateTimeValidator extends FormzInput<String, DateTimeValidationEror> {
  const DateTimeValidator.pure() : super.pure('');

  const DateTimeValidator.dirty([String value = '']) : super.dirty(value);

  @override
  DateTimeValidationEror? validator(String value) {
    return DateTime.tryParse(value) == null
        ? DateTimeValidationEror.invalid
        : null;
  }
}
