import 'package:task_repository/src/models/models.dart';

abstract class TaskDataProvider {
  Future<Task> Get();
  Future<Task> Delete(int id);
  Future<Task> Create(Task task);
}
