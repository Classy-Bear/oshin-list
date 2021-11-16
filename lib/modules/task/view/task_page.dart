import 'package:flutter/material.dart';
import 'package:oshin_list/modules/task/widgets/tasks_filters.dart';
import 'package:oshin_list/modules/task/widgets/widgets.dart';

class TaskPage extends StatelessWidget {
  const TaskPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const TasksView();
  }
}

class TasksView extends StatelessWidget {
  const TasksView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [TaskFiltersWidget(), const TaskListWidget()],
    );
  }
}
