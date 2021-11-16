import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:task_repository/src/utils/utils.dart';
import 'package:task_repository/task_repository.dart';
import 'package:test/test.dart';

import 'task_repository_test.mocks.dart';

@GenerateMocks([TaskRepository])
void main() {
  late TaskRepository taskRepository;

  setUp(() {
    taskRepository = MockTaskRepository();
  });

  group('Repsository tests', () {
    test('getAll returns a list of Task', () async {
      when(taskRepository.getAll()).thenAnswer((_) async => [Task.empty]);
    });

    test('getAll returns a ServerError ', () {
      when(taskRepository.getAll()).thenThrow((_) async => ServerError);
    });

    test('create returns a Task', () async {
      when(taskRepository.create(Task.empty))
          .thenAnswer((_) async => Task.empty);
    });

    test('create returns a ServerError', () {
      when(taskRepository.create(Task.empty))
          .thenThrow((_) async => ServerError);
    });

    test('update return a task', () async {
      when(taskRepository.update(Task.empty))
          .thenAnswer((_) async => Task.empty);
    });

    test('update', () {
      when(taskRepository.update(Task.empty))
          .thenThrow(() async => ServerError);
    });

    test('delete returns void', () async {
      when(taskRepository.delete('1')).thenAnswer((_) async => {});
    });

    test('delete returns a ServerError', () {
      when(taskRepository.delete('1')).thenThrow((_) async => ServerError);
    });
  });

  group('Task test', () {
    // TODO: Make Task test here
    test('Task test', () async {
      when(
        Task.fromJson(
          ' {"title": "title",  "description":  "description",  "type": 1, "date": "",  "color": 1}',
        ),
      ).thenAnswer((_) => Task.empty);
    });
  });
}
