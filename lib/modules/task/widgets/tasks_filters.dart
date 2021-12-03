part of 'widgets.dart';

class TaskFiltersWidget extends StatelessWidget {
  const TaskFiltersWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bloc = context.watch<TaskBloc>();
    return FilterChips<Filter>(
      selectedFilter: bloc.state.filter,
      filtersList: const [
        Filter.pending,
        Filter.completed,
        Filter.overdue,
        Filter.none,
      ],
      onFilterSelect: (filters) => bloc.setFilter(filters.first),
    );
  }
}
