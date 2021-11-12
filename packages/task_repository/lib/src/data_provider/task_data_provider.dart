part of 'data_provider.dart';

abstract class TaskDataProvider {
  /// Gets all the [Task]s.
  Future<List<Task>> getAll();

  /// Deletes a [Task] by its [id].
  Future<void> delete(String id);

  /// Creates a new [Task].
  Future<Task> create(Task task);

  /// Get a task by its [id].
  Future<Task> getOne(String id);

  /// Update a [task]
  Future<Task> update(Task task);
}
