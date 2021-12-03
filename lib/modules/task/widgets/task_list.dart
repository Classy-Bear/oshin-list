part of 'widgets.dart';

class TaskListWidget extends StatelessWidget {
  const TaskListWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final state = context.watch<TaskBloc>().state;
    if (state.status == FetchStatus.loading) {
      return const Expanded(
        child: Center(
          child: CircularProgressIndicator(),
        ),
      );
    } else if (state.status == FetchStatus.success) {
      final bloc = context.read<TaskBloc>();
      return _TaskListView(
        tasks: state.tasks,
        onDone: (task) => bloc.update(task.copyWith(completed: true)),
        onDelete: (task) => bloc.delete(task.id ?? '-1'),
        onLongPress: (task) async {
          if (task.completed ?? false) return;
          final taskUpdated = await Navigator.pushNamed(
            context,
            TaskInformationPage.route,
            arguments: ScreenArguments(
              task.toMap(),
            ),
          );
          if (taskUpdated != null && task != taskUpdated) {
            bloc.getAll();
          }
        },
      );
    }
    return Container();
  }
}

class _TaskListView extends StatelessWidget {
  const _TaskListView({
    required this.tasks,
    required this.onDone,
    required this.onDelete,
    required this.onLongPress,
  });

  final TaskList tasks;
  final Function(Task) onDone;
  final Function(Task) onDelete;
  final Function(Task) onLongPress;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: tasks.length,
        itemBuilder: (context, index) {
          Task task = tasks.elementAt(index: index);
          return TaskTileWidget(
            task: task,
            onDone: onDone,
            onDelete: onDelete,
            onLongPress: onLongPress,
          );
        },
      ),
    );
  }
}
