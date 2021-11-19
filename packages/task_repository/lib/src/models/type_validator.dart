part of 'models.dart';

/// Validation errors for the [TypeValidator] [FormzInput].
enum TypeValidationEror {
  /// Generic invalid error.
  invalid
}

/// Form input for an type input.
class TypeValidator extends FormzInput<TaskType, TypeValidationEror> {
  const TypeValidator.pure() : super.pure(TaskType.work);

  const TypeValidator.dirty([TaskType value = TaskType.work])
      : super.dirty(value);

  @override
  TypeValidationEror? validator(TaskType value) {
    return null;
  }
}
