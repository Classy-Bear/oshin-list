part of 'bloc.dart';

/// [TaskState] define the [TaskBloc] state.
/// Represents how a list of tasks should be handled.
class TaskState extends Equatable {
  final TaskList _tasks;
  final FetchStatus status;
  final Filter filter;

  TaskList get tasks {
    if (filter.isPending) {
      return pendingTasks;
    } else if (filter.isCompleted) {
      return completedTasks;
    } else if (filter.isOverdue) {
      return overdueTasks;
    }
    return _tasks;
  }

  TaskList get tasksWithNoFilters => _tasks;

  TaskList get pendingTasks => _tasks.where(where: (task) => task.isPending);

  TaskList get completedTasks =>
      _tasks.where(where: (task) => task.completed ?? false);

  TaskList get overdueTasks => _tasks.where(where: (task) => task.isOverdue);

  const TaskState({
    this.status = FetchStatus.initial,
    TaskList? tasks,
    this.filter = Filter.pending,
  }) : _tasks = tasks ?? TaskList.empty;

  @override
  List<Object?> get props => [_tasks, status, filter];

  TaskState copyWith({
    TaskList? tasks,
    FetchStatus? status,
    Filter? filter,
  }) =>
      TaskState(
        status: status ?? this.status,
        tasks: tasks ?? _tasks,
        filter: filter ?? this.filter,
      );
}

enum Filter { pending, overdue, completed, none }

extension FiltersX on Filter {
  get isPending => this == Filter.pending;
  get isCompleted => this == Filter.completed;
  get isOverdue => this == Filter.overdue;
}
