part of 'models.dart';

class TaskList extends Equatable {
  final List<Task> _tasks;

  const TaskList._({
    List<Task>? tasks,
  }) : _tasks = tasks ?? const [];

  factory TaskList.fromJson(List tasks) =>
      TaskList._(tasks: tasks.map((json) => Task.fromMap(json)).toList());

  String toJson() => json.encode(_tasks.map((task) => task.toJson()).toList());

  TaskList add({required Task task}) => TaskList._(tasks: [..._tasks, task]);

  TaskList replaceWhere({
    required Task task,
    required bool Function(Task) where,
  }) {
    final index = _tasks.indexWhere(where);
    if (index == -1) {
      return this;
    } else {
      _tasks.removeAt(index);
      _tasks.insert(index, task);
      return TaskList._(tasks: _tasks);
    }
  }

  TaskList removeWhere({required bool Function(Task) where}) {
    return TaskList._(tasks: _tasks..removeWhere(where));
  }

  TaskList where({required bool Function(Task) where}) {
    final filteredTask = _tasks.where(where);
    return TaskList._(tasks: filteredTask.toList());
  }

  Task elementAt({required int index}) {
    return _tasks.elementAt(index);
  }

  void forEach({required Function(Task) currentTask}) {
    _tasks.forEach(currentTask);
  }

  static final one = TaskList._(tasks: [Task.empty]);

  static const empty = TaskList._(tasks: []);

  int get length => _tasks.length;

  @override
  List<Object?> get props => [_tasks];
}

// TODO(Style): Cuando usar 'arrow functions'?