import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:task_repository/task_repository.dart';
import 'package:test/test.dart';

import 'task_repository_test.mocks.dart';

@GenerateMocks([http.Client])
void main() {
  final client = MockClient();
  const url = "https://618c209fded7fb0017bb942a.mockapi.io/task";
  TaskRepository taskRepository = TaskRepository();

  group('fetch Task', () {
    test('return a list of task if the call completes successfully', () async {
      when(client.get(Uri.parse(url))).thenAnswer((_) async => http.Response(
          '[{"id": 1, "title": "title", "descriptio":"description", "type": 1, "color": 1},{"id": 2, "title": "title", "descriptio":"description", "type": 1, "color": 1}]',
          200));
      expect(await taskRepository.getAll(), isA<List<Task>>());
    });

    test('returnd a exception if the http call completes with a error ', () {
      when(client.get(Uri.parse(url)))
          .thenAnswer((_) async => http.Response('No found', 404));

      expect(taskRepository.getAll(), throwsException);
    });
  });

  // group('create a new task', () {
  //   Task task =  ;
  //   test('return the task that was created if the call completes successfully',
  //       () async {
  //     when(client.post(Uri.parse(url),
  //         body: json.encode({
  //         "title": "Limpiar la cocina",
  //         "description":"modeling",
  //         "type":  1,
  //         "date": DateTime,
  //         "color":1,
  //       }),))
  //         .thenAnswer((_) async => http.Response('', 200));
  //     expect(await taskRepository.create(task), isA<Task>());
  //   });
  // });
}
