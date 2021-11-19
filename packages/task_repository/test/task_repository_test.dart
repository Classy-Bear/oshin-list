import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:http/testing.dart';
import 'package:task_repository/src/models/models.dart';
import 'package:task_repository/task_repository.dart';
import 'package:test/test.dart';

void main() {
  TaskRepository? repository;
  http.Client? httpClient;
  final responseBody = Task.empty.toJson();

  group('$TaskRepository', () {
    test('Create a task - Status code: 201', () async {
      httpClient = MockClient((request) async {
        final bodyRequest = Task.fromJson(request.body);
        if (request.method == "POST") {
          if (bodyRequest.id == null) {
            return http.Response(responseBody, HttpStatus.created);
          }
        }
        return http.Response("", HttpStatus.internalServerError);
      });
      repository = TaskRepository(httpClient: httpClient);
      final empty = Task.empty;
      final task = await repository?.create(
        Task.create(
          title: empty.title!,
          description: empty.description!,
          type: empty.type!,
          color: empty.color!,
          date: empty.date!,
        ),
      );
      expect(task, Task.empty);
    });

    test('Delete a task - Status code: 200', () async {
      httpClient = MockClient((request) async {
        final id = request.url.pathSegments.last;
        if (int.tryParse(id) is int) {
          return http.Response("", HttpStatus.ok);
        }
        throw http.Response("", HttpStatus.internalServerError);
      });
      repository = TaskRepository(httpClient: httpClient);
      await repository?.delete('1');
      expect(HttpStatus.ok, HttpStatus.ok);
    });

    test('Get all task - Status code: 200', () async {
      httpClient = MockClient((request) async {
        return http.Response(TaskList.one.toJson(), HttpStatus.ok);
      });
      repository = TaskRepository(httpClient: httpClient);
      final taskList = await repository?.getAll();
      expect(taskList, TaskList.one);
    });

    test('Update a task - Status code: 200', () async {
      httpClient = MockClient((request) async {
        final bodyRequest = Task.fromJson(request.body);
        if (bodyRequest.id != null) {
          return http.Response(responseBody, HttpStatus.ok);
        }
        throw http.Response("", HttpStatus.internalServerError);
      });
      repository = TaskRepository(httpClient: httpClient);
      final taskUpdated = await repository?.update(Task.empty);
      expect(taskUpdated, Task.empty);
    });
  });
}

// TODO(test): Agregar test de errores y ampliar test actuales.
