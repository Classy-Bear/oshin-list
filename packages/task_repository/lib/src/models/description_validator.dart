part of 'models.dart';

/// Validation errors for the [DescriptionValidator] [FormzInput].
enum DescriptionValidationEror {
  /// Generic invalid error.
  invalid
}

/// Form input for a description input.
class DescriptionValidator
    extends FormzInput<String, DescriptionValidationEror> {
  const DescriptionValidator.pure() : super.pure('');

  const DescriptionValidator.dirty([String value = '']) : super.dirty(value);

  @override
  DescriptionValidationEror? validator(String value) {
    return value.isEmpty ? DescriptionValidationEror.invalid : null;
  }
}