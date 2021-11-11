import 'dart:convert';
import 'dart:io';

import 'package:task_repository/src/utils/exceptions.dart';
import 'package:task_repository/src/utils/global.dart';
import 'package:task_repository/task_repository.dart';
import 'package:http/http.dart' as http;

import 'data_provider/data_provider.dart';

class TaskRepository implements TaskDataProvider {
  TaskRepository({
    http.Client? httpClient,
  }) : _httpClient = httpClient ?? http.Client();

  final http.Client _httpClient;

  @override
  Future<Task> create(Task task) async {
    late final http.Response response;
    try {
      response = await _httpClient.post(
        Uri.parse(apiTask),
        body: json.encode({
          "title": task.title,
          "description": task.description,
          "type": task.type,
          // TODO: Don't use the bang(!) operator.
          "date": task.date!.toIso8601String(),
          "color": task.color,
        }),
      );
    } catch (_) {
      throw ServerError();
    }

    final statusCode = response.statusCode;
    if (statusCode != HttpStatus.ok) throw ServerError();

    try {
      return Task.fromJson(response.body);
    } catch (_) {
      throw ServerError();
    }
  }

  @override
  Future<void> delete(int id) async {
    late final http.Response response;
    try {
      response = await _httpClient.delete(Uri.parse(deleteTask(id)));
    } catch (e) {
      throw ServerError();
    }

    final statusCode = response.statusCode;
    if (statusCode != HttpStatus.ok) throw ServerError();
  }

  @override
  Future<List<Task>> getAll() async {
    late final http.Response response;
    try {
      response = await _httpClient.get(Uri.parse(apiTask));
    } catch (e) {
      throw ServerError();
    }

    final statusCode = response.statusCode;
    if (statusCode != HttpStatus.ok) throw ServerError();

    try {
      // TODO: Get a all the task, not just one.
      // return Task.fromJson(response.body);
      throw UnimplementedError();
    } on Exception {
      throw ServerError();
    }
  }
}
