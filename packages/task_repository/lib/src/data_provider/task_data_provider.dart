part of 'data_provider.dart';

abstract class TaskDataProvider {
  /// Gets all the tasks.
  Future<TaskList> getAll({bool Function(Task)? where});

  /// Deletes a [Task] by its [id].
  Future<void> delete(String id);

  /// Returns the created [Task].
  ///
  /// The API may alter some parameters from [task] and return a new [Task] from
  /// it.
  Future<Task> create(Task task);

  /// Returns the updated [Task].
  ///
  /// The API may alter some parameters from [task] and return a new [Task] from
  /// it.
  Future<Task> update(Task task);
}
