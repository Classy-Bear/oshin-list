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
    final state = context.watch<TaskBloc>().state;
    return TasksGraphics(
      tasks: state.tasks,
      onChangedChart: (newChart) {
        setState(() {
          selectedChart = newChart;
        });
      },
      selectedChart: selectedChart,
      completedCount: state.completedTasks.length,
      overdueCount: state.overdueTasks.length,
      pendingCount: state.pendingTasks.length,
    );
  }
}
