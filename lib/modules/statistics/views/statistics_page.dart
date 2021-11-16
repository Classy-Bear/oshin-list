import 'package:flutter/material.dart';
import 'package:oshin_list/core/widgets/statistics_graphics/statistics_graphics.dart';
import 'package:oshin_list/modules/task/bloc/bloc.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

class StatisticsPage extends StatelessWidget {
  const StatisticsPage({Key? key}) : super(key: key);

  @override
    Widget build(BuildContext context) {
    return TasksGraphics(
      tasks: context.watch<TaskBloc>().state.tasks,
    );
  }
}

