import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:oshin_list/core/widgets/statistics_graphics/statistics_graphics.dart';
import 'package:oshin_list/modules/task/bloc/bloc.dart';
import 'package:oshin_list/modules/task/widgets/widgets.dart';
import 'package:oshin_list/modules/task_information/view/task_information_page.dart';

part 'statistics_page.dart';
part 'task_page.dart';

class HomePage extends StatefulWidget {
  static const route = '/';

  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  late final TabController _tabController;

  var currentTab = 0;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this, initialIndex: 0);
    _tabController.addListener(() {
      setState(() {
        currentTab = _tabController.index;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: CurrentAppBarWidget(selectedIndex: currentTab),
      ),
      body: TabBarView(
        controller: _tabController,
        children: const [TaskPage(), StatisticsPage()],
      ),
      bottomNavigationBar: TabNavBarWidget(controller: _tabController),
      floatingActionButton: Offstage(
        offstage: currentTab != 0,
        child: FloatingActionButton(
          onPressed: () async {
            await Navigator.pushNamed(context, TaskInformationPage.route);
            await context.read<TaskBloc>().getAll(
              where: (task) {
                return task.isPending;
              },
            );
          },
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}
