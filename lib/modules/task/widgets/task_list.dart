part of 'widgets.dart';

class TaskListWidget extends StatefulWidget {
  const TaskListWidget({Key? key}) : super(key: key);

  @override
  State<TaskListWidget> createState() => _TaskListWidgetState();
}

class _TaskListWidgetState extends State<TaskListWidget> {
  @override
  void initState() {
    super.initState();
    context.read<TaskBloc>().getAll(
      where: (task) {
        return task.isPending;
      },
    );
  }

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
      return _TaskListView(
        tasks: state.tasks,
        onDone: (task) async {
          await context.read<TaskBloc>().update(task.copyWith(completed: true));
          await context.read<TaskBloc>().getAll(
                where: (task) => task.isPending == true,
              );
        },
        onDelete: (task) => context.read<TaskBloc>().delete(task.id ?? '-1'),
        onLongPress: (task) async {
          if (task.completed ?? false) return;
          await Navigator.pushNamed(
            context,
            TaskInformationPage.route,
            arguments: ScreenArguments(
              task.toMap(),
            ),
          );
          context.read<TaskBloc>().getAll(
                where: (task) => task.isPending == true,
              );
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
            // key: ObjectKey(task),
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
