import 'package:flutter/material.dart';
import 'package:oshin_list/core/widgets/statistics_graphics/statistics_graphics.dart';
import 'package:oshin_list/modules/task/bloc/bloc.dart';
import 'package:task_repository/task_repository.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

class StatisticScreen extends StatefulWidget {
  StatisticScreen({Key? key}) : super(key: key);

  @override
  __StatisticScreenState createState() => __StatisticScreenState();
}

class __StatisticScreenState extends State<StatisticScreen> {
  @override
  Widget build(BuildContext context) {
    return TasksGraphics(
      tasks: context.read<TaskBloc>().state.tasks,
    );
  }
}
