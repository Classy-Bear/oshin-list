import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:oshin_list/core/widgets/filter_chips/filter_chips.dart';
import 'package:oshin_list/modules/task/bloc/bloc.dart';

class TaskFiltersWidget extends StatefulWidget {
  TaskFiltersWidget({Key? key}) : super(key: key);

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
          context.read<TaskBloc>().getAll(
            where: (task) {
              if (filters.isEmpty) return true;
              for (var filter in filters) {
                if (filter == 'Pending' && task.isPending) {
                  return true;
                } else if (filter == 'Done' && (task.completed ?? false)) {
                  return true;
                } else if (filter == 'OverDue' && task.isOverdue) {
                  return true;
                }
              }
              return false;
            },
          );
        },
      ),
    );
  }
}
