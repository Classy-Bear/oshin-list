import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:oshin_list/core/widgets/form_task/form.dart';
import 'package:oshin_list/modules/task_information/bloc/task_form_bloc.dart';
import 'package:task_repository/task_repository.dart';

class TaskInformationPage extends StatefulWidget {
  static const route = '/taskInformationPage';

  const TaskInformationPage({Key? key, required this.task}) : super(key: key);

  final Task? task;

  @override
  State<TaskInformationPage> createState() => _TaskInformationPageState();
}

class _TaskInformationPageState extends State<TaskInformationPage> {
  @override
  void initState() {
    super.initState();
    final task = widget.task;
    if (task != null) {
      context.read<TaskFormBloc>().titleChanged(task.title ?? '');
      context.read<TaskFormBloc>().descriptionChanged(task.description ?? '');
      context.read<TaskFormBloc>().colorChanged(task.color!);
      context.read<TaskFormBloc>().typeChanged(task.type ?? TaskType.work);
      context
          .read<TaskFormBloc>()
          .dateTimeChanged(task.date?.toIso8601String() ?? '');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Oshin TaskForm"), centerTitle: true),
      body: FormTaskWidget(task: widget.task),
    );
  }
}
