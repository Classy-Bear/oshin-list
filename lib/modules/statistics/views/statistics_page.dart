import 'package:flutter/material.dart';
import 'package:oshin_list/core/widgets/statistics_graphics/statistics_graphics.dart';
import 'package:oshin_list/modules/task/bloc/bloc.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

class StatisticsPage extends StatefulWidget {
  StatisticsPage({Key? key}) : super(key: key);

  @override
  __StatisticsPageState createState() => __StatisticsPageState();
}

class __StatisticsPageState extends State<StatisticsPage> {
  @override
  Widget build(BuildContext context) {
    return TasksGraphics(
      tasks: context.watch<TaskBloc>().state.tasks,
    );
  }
}
