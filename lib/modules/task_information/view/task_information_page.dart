import 'package:flutter/material.dart';
import 'package:oshin_list/core/widgets/form_task/form.dart';
import 'package:task_repository/task_repository.dart';

class TaskInformationPage extends StatelessWidget {
  static const route = '/taskInformationPage';

  const TaskInformationPage({Key? key, required this.task}) : super(key: key);

  final Task? task;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Oshin TaskForm"), centerTitle: true),
      body: FormTaskWidget(task: task),
    );
  }
}
