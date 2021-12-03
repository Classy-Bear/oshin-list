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

  var _currentTab = 0;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this, initialIndex: 0);
    _tabController.addListener(() {
      setState(() {
        _currentTab = _tabController.index;
      });
    });
    context.read<TaskBloc>().getAll();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: CurrentAppBarWidget(selectedIndex: _currentTab),
      ),
      body: TabBarView(
        controller: _tabController,
        children: const [TaskPage(), StatisticsPage()],
      ),
      bottomNavigationBar: TabNavBarWidget(controller: _tabController),
      floatingActionButton: Offstage(
        offstage: _currentTab != 0,
        child: FloatingActionButton(
          onPressed: () => Navigator.pushNamed(
            context,
            TaskInformationPage.route,
          ),
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}
