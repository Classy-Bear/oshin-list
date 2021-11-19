part of 'models.dart';

/// Validation errors for the [TitleValidator] [FormzInput].
enum TitleValidationEror {
  /// Generic invalid error.
  invalid
}

/// Form input for an title input.
class TitleValidator extends FormzInput<String, TitleValidationEror> {
  const TitleValidator.pure() : super.pure('');

  const TitleValidator.dirty([String value = '']) : super.dirty(value);

  @override
  TitleValidationEror? validator(String value) {
    return value.isEmpty ? TitleValidationEror.invalid : null;
  }
}