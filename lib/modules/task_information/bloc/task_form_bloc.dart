import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:formz/formz.dart';
import 'package:task_repository/task_repository.dart';

part 'task_form_state.dart';

class TaskFormBloc extends Cubit<TaskFormState> {
  TaskFormBloc() : super(const TaskFormState());

  void titleChanged(String value) {
    final title = TitleValidator.dirty(value);
    emit(
      state.copyWith(
        title: title,
        status: Formz.validate([
          title,
          state.description,
          state.color,
          state.dateTime,
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
          state.dateTime,
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
          state.dateTime,
          state.type,
        ]),
      ),
    );
  }

  void dateTimeChanged(String value) {
    final dateTime = DateTimeValidator.dirty(value);
    emit(
      state.copyWith(
        dateTime: dateTime,
        status: Formz.validate([
          state.title,
          state.description,
          state.color,
          dateTime,
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
          state.dateTime,
          type,
        ]),
      ),
    );
  }

  Future<void> submitForm(Future Function(Task) onSubmit,{Task? task }) async {
    debugPrint('${state.status}');
    if (!state.status.isValidated) return;
    emit(state.copyWith(status: FormzStatus.submissionInProgress));
    try {

      final newTask = Task.create(
        title: state.title.value,
        description: state.description.value,
        date: DateTime.parse(state.dateTime.value),
        color: state.color.value,
        type: state.type.value,
      );

      Task? currentTask = task?.copyWith(
        title: state.title.value,
        description: state.description.value,
        date: DateTime.tryParse(state.dateTime.value) ,
        type: state.type.value,
        color: state.color.value,
      );

      if(task != null){
        await onSubmit(currentTask!);
      }else{
        await onSubmit(newTask);
      }
      
      emit(state.copyWith(status: FormzStatus.submissionSuccess));
    } on Exception {
      emit(state.copyWith(status: FormzStatus.submissionFailure));
    }
  }
}
