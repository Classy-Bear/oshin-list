import 'dart:convert';
import 'dart:io';

import 'package:task_repository/src/utils/exceptions.dart';
import 'package:task_repository/src/utils/global.dart';
import 'package:task_repository/task_repository.dart';
import 'package:http/http.dart' as http;

import 'package:meta/meta.dart';
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
          "date": task.date == null ? null : task.date!.toIso8601String(),
          "color": task.color,
        }),
      );
    } catch (e) {
      print(e);
      throw ServerError();
    }

    final statusCode = response.statusCode;
    if (statusCode != HttpStatus.created) throw ServerError();

    try {
      return Task.fromJson(response.body);
    } on Exception {
      throw ServerError();
    }
  }

  @override
  Future<void> delete(String id) async {
    late final http.Response response;
    try {
      response = await _httpClient.delete(Uri.parse(getOneTask(id)));
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
      final tasks = <Task>[];
      final body = json.decode(response.body) as Map<String, dynamic>;
      final data = body['data'] as List;
      for (var e in data) {
        tasks.add(Task.fromMap(e));
      }
      return tasks;
    } on Exception {
      throw ServerError();
    }
  }

  @override
  Future<Task> getOne(String id) async {
    late final http.Response response;

    try {
      response = await _httpClient.get(Uri.parse(getOneTask(id)));
    } catch (_) {
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

  @override
  Future<Task> update(Task task) async {
    late final http.Response response;
    try {
      response = await _httpClient.put(Uri.parse(getOneTask(task.id)),
          body: json.encode({
            "title": task.title,
            "description": task.description,
            "type": task.type,
            // TODO: Don't use the bang(!) operator.
            "date": task.date == null ? null : task.date!.toIso8601String(),
            "color": task.color,
          }));
    } catch (e) {
      print(e);
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

  @required
  void dispose() {
    _httpClient.close();
  }
}
