part of 'data_provider.dart';

abstract class TaskDataProvider {
  /// Gets all the [Task]s.
  Future<List<Task>> getAll({bool Function(Task)? where});

  /// Deletes a [Task] by its [id].
  Future<void> delete(String id);

  /// Creates a copy of [task] and returns the created one from the API.
  Future<Task> create(Task task);

  /// Creates a copy of [task] and returns the updated one from the API.
  Future<Task> update(Task task);
}
