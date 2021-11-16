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
          "type": task.selectedTypeRange,
          "date": task.date?.toIso8601String(),
          "color": task.color,
          "completed": task.completed,
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
    } on Exception {
      throw ServerError();
    }
    final statusCode = response.statusCode;
    if (statusCode != HttpStatus.ok) throw ServerError();
  }

  @override
  Future<TaskList> getAll({bool Function(Task)? where}) async {
    late final http.Response response;
    try {
      response = await _httpClient.get(Uri.parse(apiUrl));
    } on Exception {
      throw ServerError();
    }
    final statusCode = response.statusCode;
    if (statusCode != HttpStatus.ok) throw ServerError();
    try {
      final body = json.decode(response.body) as List;
      final taskList = TaskList.fromJson(body);
      return where == null ? taskList : taskList.where(where: where);
    } on Exception {
      throw ServerError();
    }
  }

  @override
  Future<Task> update(Task task) async {
    late final http.Response response;
    if (task.id == null) throw ServerError();
    try {
      final body = <String, dynamic>{};
      if (task.id != null) {
        body['id'] = task.id;
      }
      if (task.title != null) {
        body['title'] = task.title;
      }
      if (task.description != null) {
        body['description'] = task.description;
      }
      if (task.type != null) {
        body['type'] = task.type;
      }
      if (task.date != null) {
        body['date'] = task.date!.toIso8601String();
      }
      if (task.color != null) {
        body['color'] = task.color;
      }
      if (task.completed != null) {
        body['completed'] = task.completed;
      }
      response = await _httpClient.put(
        Uri.parse('$apiUrl/${task.id}'),
        body: json.encode(body),
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
