import 'package:flutter/material.dart';
import 'package:oshin_list/core/widgets/serch_app_bar/search_app_bar.dart';
import 'package:oshin_list/modules/task/view/tasks_screen.dart';

class HomePage extends StatelessWidget {
  static const route = '/';

  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const HomeView();
  }
}

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> with TickerProviderStateMixin {
  late final TabController _tabController;
  int currentTab = 0;

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
        child: _currentChild(currentTab),
      ),
      body: TabBarView(
        controller: _tabController,
        children: const [TaskPage(), Text('2')],
      ),
      bottomNavigationBar: _TabNavBar(controller: _tabController),
      floatingActionButton: Offstage(
        offstage: currentTab != 0,
        child: FloatingActionButton(
          onPressed: () {},
          child: const Icon(Icons.add),
        ),
      ),
    );
  }

  // TODO: Mudar esto a una clase.
  Widget _currentChild(int index) {
    switch (index) {
      case 0:
        return SearchAppBar(
          onTextChanged: (text) {},
          title: 'Oshin Tasklist',
          searchInputPlaceHolder: 'Search your task',
        );
      case 1:
        return AppBar(
          title: const Text('Metrics'),
          centerTitle: true,
        );
      default:
        return Container();
    }
  }
}

class _TabNavBar extends StatelessWidget {
  final TabController controller;

  const _TabNavBar({
    Key? key,
    required this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 60,
      child: TabBar(
        indicatorColor: Colors.blue,
        labelColor: Colors.blue,
        unselectedLabelColor: Colors.grey,
        controller: controller,
        tabs: const [
          Tab(
            icon: Icon(Icons.list),
            text: 'Tasks',
          ),
          Tab(
            icon: Icon(Icons.show_chart),
            text: 'Metrics',
          ),
        ],
      ),
    );
  }
}
