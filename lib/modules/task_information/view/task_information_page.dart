import 'package:flutter/material.dart';
import 'package:oshin_list/core/widgets/form_task/form.dart';

class TaskInformationPage extends StatelessWidget {
  static const route = '/taskInformationPage';

  const TaskInformationPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const TaskInformationView();
  }
}

class TaskInformationView extends StatelessWidget {
  const TaskInformationView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Oshin Tasklist",
        ),
        centerTitle: true,
      ),
      body: const FormTask(),
    );
  }
}
