part of 'bloc.dart';

/// [TaskState] define the [TaskBloc] state.
/// represents how a list of tasks should be handled.
@immutable
class TaskState extends Equatable {
  final List<Task> tasks;
  final String? errorMessage;
  final bool isLoading;

  const TaskState({
    this.tasks = const [],
    this.errorMessage,
    this.isLoading = false,
  });

  @override
  List<Object?> get props => [tasks, errorMessage, isLoading];

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
