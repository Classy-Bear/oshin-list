part of 'bloc.dart';

/// [TaskState] define the [TaskBloc] state.
/// Represents how a list of tasks should be handled.
class TaskState extends Equatable {
  final TaskList tasks;
  final FetchStatus status;

  const TaskState({
    this.status = FetchStatus.initial,
    this.tasks = TaskList.empty,
  });

  @override
  List<Object?> get props => [tasks, status];

  TaskState copyWith({
    TaskList? tasks,
    FetchStatus? status,
  }) =>
      TaskState(
        status: status ?? this.status,
        tasks: tasks ?? this.tasks,
      );
}
