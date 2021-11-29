part of 'models.dart';

/// Validation errors for the [IsoDateValidator] [FormzInput].
enum IsoDateValidationEror {
  /// Generic invalid error.
  invalid
}

/// Form input for an date input.
class IsoDateValidator extends FormzInput<String, IsoDateValidationEror> {
  const IsoDateValidator.pure() : super.pure('');

  const IsoDateValidator.dirty([String value = '']) : super.dirty(value);

  @override
  IsoDateValidationEror? validator(String value) {
    return DateTime.tryParse(value) == null
        ? IsoDateValidationEror.invalid
        : null;
  }
}
