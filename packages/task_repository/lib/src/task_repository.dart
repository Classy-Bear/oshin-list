import 'package:http/http.dart' as http;
import 'package:task_repository/src/data_provider/task.dart';
import 'package:task_repository/task_repository.dart';
import 'dart:io';

class TaskRepository implements TaskDataProvider {
  TaskRepository({
    http.Client? httpClient,
  }) : _httpClient = httpClient ?? http.Client();

  final http.Client _httpClient;

  final url = "https://618c209fded7fb0017bb942a.mockapi.io/task";

  // Future<Task> getTask() async {
  //   late final http.Response response;
  //    try{
  //      response = await _httpClient.get(Uri.parse(url));
  //    }
  //    catch(e){
  //      print(e);
  //    }
  //    final statusCode = response.statusCode;
  //    if(statusCode != HttpStatus.ok)
  //   return ;
  // }

  @override
  Task createTask() {
    // TODO: implement createTask
    throw UnimplementedError();
  }

  @override
  Task deleteTask() {
    // TODO: implement deleteTask
    throw UnimplementedError();
  }
}
