part of 'widgets.dart';

class TaskFiltersWidget extends StatefulWidget {
  const TaskFiltersWidget({Key? key}) : super(key: key);

  @override
  _TaskFiltersWidgetState createState() => _TaskFiltersWidgetState();
}

class _TaskFiltersWidgetState extends State<TaskFiltersWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: FilterChips(
        filtersList: const [
          'Pending',
          'Done',
          'OverDue',
        ],
        onFilterSelect: (filters) {
          /// TODO: Use Filters instead of Strings
          final bloc = context.read<TaskBloc>();
          for (var filter in filters) {
            if (filter == 'Pending') {
              return bloc.setFilter(Filter.pending);
            } else if (filter == 'Done') {
              return bloc.setFilter(Filter.completed);
            } else if (filter == 'OverDue') {
              return bloc.setFilter(Filter.overdue);
            }
          }
          return bloc.setFilter(Filter.none);
        },
      ),
    );
  }
}
