part of 'widgets.dart';

class TabNavBarWidget extends StatelessWidget {
  final TabController controller;

  const TabNavBarWidget({
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
            text: 'Stadistics',
          ),
        ],
      ),
    );
  }
}
