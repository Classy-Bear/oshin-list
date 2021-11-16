import 'package:formz/formz.dart';
import 'package:task_repository/src/utils/type_helper.dart';

/// Validation errors for the [TypeValidator] [FormzInput].
enum TypeValidationEror {
  /// Generic invalid error.
  invalid
}

/// Form input for an title input.
class TypeValidator extends FormzInput<Type, TypeValidationEror> {
  const TypeValidator.pure() : super.pure(Type.work);

  const TypeValidator.dirty([Type value = Type.work]) : super.dirty(value);

  @override
  TypeValidationEror? validator(Type value) {
    return null;
  }
}
