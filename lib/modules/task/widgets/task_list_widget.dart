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
    context.read<TaskBloc>().getAll();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TaskBloc, TaskState>(
      builder: (context, state) {
        if (state.status == FetchStatus.loading) {
          return const Expanded(
            child: Center(
              child: CircularProgressIndicator(),
            ),
          );
        } else if (state.status == FetchStatus.success) {
          return _TaskListView(tasks: state.tasks);
        }
        return Container();
      },
    );
  }
}

class _TaskListView extends StatelessWidget {
  const _TaskListView({required this.tasks});

  final TaskList tasks;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: tasks.length,
        itemBuilder: (context, index) {
          Task task = tasks.elementAt(index: index);
          return TaskTile(
            task: task,
            onDone: (task) {},
            onDelete: (task) {},
            onLongPress: (task) {},
          );
        },
      ),
    );
  }
}
