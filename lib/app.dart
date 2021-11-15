import 'package:flutter/material.dart';
import 'package:oshin_list/core/widgets/serch_app_bar/search_app_bar.dart';
import 'package:oshin_list/modules/screens/statistics_screen.dart';
import 'package:oshin_list/modules/screens/tasks_screen.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with TickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this, initialIndex: 0);

    _tabController.addListener(() {
      setState(() {
        currentTab = _tabController.index;
      });
    });
  }

  int currentTab = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: currentTab == 0
            ? SearchAppBar(
                onTextChanged: (text) {},
                title: 'Oshin Tasklist',
                searchInputPlaceHolder: 'search you task',
              )
            : (currentTab == 1)
                ? AppBar(
                    title: const Text('Metrics'),
                    centerTitle: true,
                  )
                : (currentTab == 2)
                    ? AppBar(
                        title: const Text('?????????'),
                        centerTitle: true,
                      )
                    : Container(),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [TasksScreen(), StatisticScreen(), Text('3')],
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
}

class _TabNavBar extends StatelessWidget {
  final TabController controller;

  const _TabNavBar({
    Key? key,
    required this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      child: TabBar(
        indicatorColor: Colors.red,
        labelColor: Colors.blue,
        unselectedLabelColor: Colors.grey,
        controller: controller,
        tabs: const [
          Tab(
            icon: Icon(
              Icons.list,
              // color:Colors.blue,
            ),
            text: 'Tasks',
          ),
          Tab(
            icon: Icon(
              Icons.show_chart,
              // color:Colors.blue,
            ),
            text: 'Metrics?',
          ),
          Tab(
            icon: Icon(
              Icons.ac_unit,
              // color:Colors.blue,
            ),
            text: '??????????????',
          )
        ],
      ),
    );
  }
}
