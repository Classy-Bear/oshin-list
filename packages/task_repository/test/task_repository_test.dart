import 'package:http/http.dart' as http;
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:http/http.dart';
import 'package:task_repository/task_repository.dart';
import 'package:test/test.dart';

import 'task_repository_test.mocks.dart';

@GenerateMocks([http.Client])
void main() {
  final client = MockClient();
  const url = "https://618c209fded7fb0017bb942a.mockapi.io/task";
  TaskRepository taskRepository = TaskRepository(httpClient: client);

  group('fetch Task', () {
    test('returnd a list of task if the call completes successfully', () async {
      when(client.get(Uri.parse(url))).thenAnswer((_) async => http.Response(
          '{"id": 1, "title": "lavar", "description": "mock", "type": 1, "color": 1, "date": ""}',
          200));
      expect(await taskRepository.get(), isA<Task>());
    });

    test('returnd a exception if the http call completes with a error ', () {
      when(client.get(Uri.parse(url)))
          .thenAnswer((_) async => http.Response('No found', 404));

      expect(taskRepository.get(), throwsException);
    });
  });
}
