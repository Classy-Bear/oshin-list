part of 'data_provider.dart';

abstract class TaskDataProvider {
  /// Gets all the [Task]s.
  Future<List<Task>> getAll();

  /// Deletes a [Task] by its [id].
  Future<void> delete(int id);

  /// Creates a new [Task].
  Future<Task> create(Task task);
}
