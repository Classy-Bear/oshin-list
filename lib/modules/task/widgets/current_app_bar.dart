part of 'widgets.dart';

class CurrentAppBarWidget extends StatelessWidget {
  final int selectedIndex;

  const CurrentAppBarWidget({
    Key? key,
    required this.selectedIndex,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return _CurrentAppBar(
      selectedIndex: selectedIndex,
      onTextChanged: (text) {
        context.read<TaskBloc>().getAll(
          where: (task) {
            if (text.isEmpty) return true;
            final hasDescription = task.description?.contains(text) ?? false;
            final hasTitle = task.title?.contains(text) ?? false;
            return hasDescription || hasTitle;
          },
        );
      },
      onSearchClosed: () {
        context.read<TaskBloc>().getAll();
      },
    );
  }
}

class _CurrentAppBar extends StatelessWidget {
  const _CurrentAppBar({
    Key? key,
    required this.selectedIndex,
    required this.onTextChanged,
    required this.onSearchClosed,
  }) : super(key: key);

  final int selectedIndex;
  final void Function(String) onTextChanged;
  final void Function() onSearchClosed;

  @override
  Widget build(BuildContext context) {
    switch (selectedIndex) {
      case 0:
        return SearchAppBar(
          onTextChanged: onTextChanged,
          title: 'Oshin Tasklist',
          searchInputPlaceHolder: 'Search your task',
          onSearchClosed: onSearchClosed,
        );
      case 1:
        return AppBar(
          title: const Text('Stadistics'),
          centerTitle: true,
        );
      default:
        return Container();
    }
  }
}
