import 'dart:convert';
import 'dart:io';

import 'package:task_repository/src/data_provider/task_data_provider.dart';
import 'package:task_repository/src/utils/exceptions.dart';
import 'package:task_repository/src/utils/global.dart';
import 'package:task_repository/task_repository.dart';
import 'package:http/http.dart' as http;

import 'package:meta/meta.dart';

class TaskRepository implements TaskDataProvider {
  TaskRepository({
    http.Client? httpClient,
  }) : _httpClient = httpClient ?? http.Client();

  final http.Client _httpClient;

  /// get the list of [Task] created.
  Future<Task> get() async {
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

  /// delete a [Task] by its [id] .
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

  /// create a new [Task] and return a new list.
  Future<Task> create(Task task) async {
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

  @required
  void dispose() {
    _httpClient.close();
  }
}
