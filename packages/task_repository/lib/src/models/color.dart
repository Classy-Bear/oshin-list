import 'package:formz/formz.dart';

/// Validation errors for the [ColorValidator] [FormzInput].
enum ColorValidationEror {
  /// Generic invalid error.
  invalid
}

/// Form input for a color input.
class ColorValidator extends FormzInput<int, ColorValidationEror> {
  const ColorValidator.pure() : super.pure(0);

  const ColorValidator.dirty([int value = 0xFF212121]) : super.dirty(value);

  @override
  ColorValidationEror? validator(int value) {
    return value.isNegative ? ColorValidationEror.invalid : null;
  }
}