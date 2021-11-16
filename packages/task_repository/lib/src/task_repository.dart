part of '../task_repository.dart';

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
        Uri.parse(apiUrl),
        body: json.encode({
          "title": task.title,
          "description": task.description,
          "type": task.type,
          "date": task.date?.toIso8601String(),
          "color": task.color,
        }),
      );
    } catch (e) {
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
      response = await _httpClient.delete(Uri.parse('$apiUrl/$id'));
    } catch (e) {
      throw ServerError();
    }

    final statusCode = response.statusCode;
    if (statusCode != HttpStatus.ok) throw ServerError();
  }

  @override
  Future<List<Task>> getAll({bool Function(Task)? where}) async {
    late final http.Response response;
    try {
      response = await _httpClient.get(Uri.parse(apiUrl));
    } catch (e) {
      throw ServerError();
    }

    final statusCode = response.statusCode;
    if (statusCode != HttpStatus.ok) throw ServerError();

    try {
      final tasks = <Task>[];
      final body = json.decode(response.body) as Map<String, dynamic>;
      final data = body['data'] as List;
      
      return tasks;
    } on Exception {
      throw ServerError();
    }
  }

  @override
  Future<Task> update(Task task) async {
    late final http.Response response;
    if (task.id == null) throw ServerError();
    try {
      response = await _httpClient.put(
        Uri.parse('$apiUrl/${task.id}'),
        body: json.encode({
          "title": task.title,
          "description": task.description,
          "type": task.type,
          "date": task.date?.toIso8601String(),
          "color": task.color,
        }),
      );
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

  @required
  void dispose() {
    _httpClient.close();
  }
}
