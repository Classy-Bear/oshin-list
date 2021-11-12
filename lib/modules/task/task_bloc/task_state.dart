import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:task_repository/task_repository.dart';

/// [TaskState] define the [TaskBloc] state.
/// represents how a list of tasks should be handled.
@immutable
class TaskState extends Equatable {
  final List<Task> tasks;
  final String? errorMessage;
  final bool isLoading;

  const TaskState({
    required this.tasks,
    this.errorMessage,
    required this.isLoading,
  });

  @override
  List<Object?> get props => [tasks, errorMessage, isLoading];
  
  
  factory TaskState.initialState() {
    return const TaskState(
      tasks: [],
      isLoading: false,
    );
  }

  TaskState copyWith({
    List<Task>? tasks,
    String? errorMessage,
    bool clearMessageError = false,
    bool? isLoading,
  }) =>
      TaskState(
        tasks: tasks ?? this.tasks,
        errorMessage:
            clearMessageError ? null : errorMessage ?? this.errorMessage,
        isLoading: isLoading ?? this.isLoading,
      );
}
