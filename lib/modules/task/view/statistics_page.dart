part of 'home_page.dart';

class StatisticsPage extends StatefulWidget {
  const StatisticsPage({Key? key}) : super(key: key);

  @override
  State<StatisticsPage> createState() => _StatisticsPageState();
}

class _StatisticsPageState extends State<StatisticsPage> {
  ChartType? selectedChart;

  @override
  void initState() {
    super.initState();
    context.read<TaskBloc>().getAll();
  }

  @override
  Widget build(BuildContext context) {
    final bloc = context.watch<TaskBloc>();
    return TasksGraphics(
      tasks: bloc.state.tasks,
      onChangedChart: (newChart) {
        setState(() {
          selectedChart = newChart;
        });
      },
      selectedChart: selectedChart,
      completedCount: bloc.state.tasks
          .where(where: (task) => task.completed ?? false)
          .length,
      overdueCount:
          bloc.state.tasks.where(where: (task) => task.isOverdue).length,
      pendingCount:
          bloc.state.tasks.where(where: (task) => task.isPending).length,
    );
  }
}
