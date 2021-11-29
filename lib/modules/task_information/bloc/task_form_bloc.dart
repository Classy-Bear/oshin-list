import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';
import 'package:task_repository/task_repository.dart';

part 'task_form_state.dart';

class TaskFormBloc extends Cubit<TaskFormState> {
  final Task? _task;

  TaskFormBloc({
    Task? task,
  })  : _task = task,
        super(
          task == null
              ? const TaskFormState()
              : TaskFormState(
                  title: TitleValidator.dirty(task.title ?? ''),
                  description:
                      DescriptionValidator.dirty(task.description ?? ''),
                  color: ColorValidator.dirty(task.selectedColor),
                  type: TypeValidator.dirty(task.type ?? TaskType.work),
                  isoDate: IsoDateValidator.dirty(
                    task.date?.toIso8601String() ?? '',
                  ),
                ),
        );
  void titleChanged(String value) {
    final title = TitleValidator.dirty(value);
    emit(
      state.copyWith(
        title: title,
        status: Formz.validate([
          title,
          state.description,
          state.color,
          state.isoDate,
          state.type,
        ]),
      ),
    );
  }

  void descriptionChanged(String value) {
    final description = DescriptionValidator.dirty(value);
    emit(
      state.copyWith(
        description: description,
        status: Formz.validate([
          state.title,
          description,
          state.color,
          state.isoDate,
          state.type,
        ]),
      ),
    );
  }

  void colorChanged(int value) {
    final color = ColorValidator.dirty(value);
    emit(
      state.copyWith(
        color: color,
        status: Formz.validate([
          state.title,
          state.description,
          color,
          state.isoDate,
          state.type,
        ]),
      ),
    );
  }

  void dateTimeChanged(String value) {
    final isoDate = IsoDateValidator.dirty(value);
    emit(
      state.copyWith(
        isoDate: isoDate,
        status: Formz.validate([
          state.title,
          state.description,
          state.color,
          isoDate,
          state.type,
        ]),
      ),
    );
  }

  void typeChanged(TaskType value) {
    final type = TypeValidator.dirty(value);
    emit(
      state.copyWith(
        type: type,
        status: Formz.validate([
          state.title,
          state.description,
          state.color,
          state.isoDate,
          type,
        ]),
      ),
    );
  }

  Future<void> submitForm(Future Function(Task) onSubmit) async {
    if (!state.status.isValidated) return;
    emit(state.copyWith(status: FormzStatus.submissionInProgress));
    try {
      await onSubmit(
        _task == null
            ? Task.create(
                title: state.title.value,
                description: state.description.value,
                date: DateTime.parse(state.isoDate.value),
                color: state.color.value,
                type: state.type.value,
              )
            : _task!.copyWith(
                title: state.title.value,
                description: state.description.value,
                date: DateTime.tryParse(state.isoDate.value),
                type: state.type.value,
                color: state.color.value,
              ),
      );
      emit(state.copyWith(status: FormzStatus.submissionSuccess));
    } on Exception {
      emit(state.copyWith(status: FormzStatus.submissionFailure));
    }
  }
}
