part of 'home_page.dart';

class TaskPage extends StatelessWidget {
  const TaskPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: const [
        TaskFiltersWidget(),
        TaskListWidget(),
      ],
    );
  }
}
