import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:oshin_list/core/network/network.dart';
import 'package:oshin_list/core/widgets/filter_chips/filter_chips.dart';
import 'package:oshin_list/core/widgets/task_tile/task_tile.dart';
import 'package:oshin_list/modules/task/bloc/bloc.dart';
import 'package:task_repository/task_repository.dart';

class TaskPage extends StatefulWidget {
  const TaskPage({Key? key}) : super(key: key);

  @override
  State<TaskPage> createState() => _TaskPageState();
}

class _TaskPageState extends State<TaskPage> {
  @override
  void initState() {
    super.initState();
    context.read<TaskBloc>().getAll();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TaskBloc, TaskState>(
      builder: (context, state) {
        if (state.status == FetchStatus.loading) {
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        } else if (state.status == FetchStatus.success) {
          return TasksScreen(tasks: state.tasks);
        }
        return Container();
      },
    );
  }
}

class TasksScreen extends StatelessWidget {
  const TasksScreen({Key? key, required this.tasks}) : super(key: key);

  final TaskList tasks;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: FilterChipsRow(
            filtersList: const [
              'Recently added',
              'Pending today',
              'Done',
              'OverDue',
              'highest pripority'
            ],
            onFilterSelect: (f) {},
          ),
        ),
        Expanded(
          child: ListView.builder(
            shrinkWrap: true,
            itemCount: tasks.length,
            itemBuilder: (context, index) {
              Task task = tasks.elementAt(index: index);
              return TaskTile(
                task: task,
                onDone: (rt) {},
                onDelete: (rt) {},
                onLongPress: (rt) {},
              );
            },
          ),
        )
      ],
    );
  }
}
