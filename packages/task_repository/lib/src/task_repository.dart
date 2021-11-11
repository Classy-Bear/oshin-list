import 'dart:convert';
import 'dart:io';

import 'package:task_repository/src/data_provider/task_data_provider.dart';
import 'package:task_repository/src/utils/exceptions.dart';
import 'package:task_repository/src/utils/global.dart';
import 'package:task_repository/task_repository.dart';
import 'package:http/http.dart' as http;

class TaskRepository implements TaskDataProvider {
  TaskRepository({
    http.Client? httpClient,
  }) : _httpClient = httpClient ?? http.Client();

  final http.Client _httpClient;

  /// get the list of [Task] created.
  Future<Task> Get() async {
    late final http.Response response;
    try {
      response = await _httpClient.get(Uri.parse(apiTask));
    } catch (e) {
      throw ServerError();
    }

    final statusCode = response.statusCode;
    if (statusCode != HttpStatus.ok) throw ServerError();

    try {
      return Task.fromJson(response.body);
    } on Exception {
      throw ServerError();
    }
  }

  /// delete a [Task] by its [id] and return a list of the rest o the [Task].
  Future<Task> Delete(int id) async {
    late final http.Response response;

    try {
      response = await _httpClient.delete(Uri.parse(deleteTask(id)));
    } catch (e) {
      throw ServerError();
    }
    final statusCode = response.statusCode;
    if (statusCode != HttpStatus.ok) throw ServerError();
    try {
      return Task.fromJson(response.body);
    } on Exception {
      throw ServerError();
    }
  }

  /// create a new [Task] and return a new list.
  Future<Task> Create(Task task) async {
    late final http.Response response;

    try {
      response = await _httpClient.post(Uri.parse(apiTask),
          body: json.encode({
            "title": task.title,
            "description": task.description,
            "type": task.type,
            "date": task.date!.toIso8601String(),
            "color": task.color,
          }));
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
}
