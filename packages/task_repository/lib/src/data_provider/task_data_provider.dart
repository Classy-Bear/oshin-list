import 'package:task_repository/src/models/models.dart';

abstract class TaskDataProvider {
  Future<Task> get();
  Future<void> delete(int id);
  Future<Task> create(Task task);
}
