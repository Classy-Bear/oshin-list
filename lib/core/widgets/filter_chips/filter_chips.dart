import 'package:flutter/material.dart';

class FilterChips<T> extends StatefulWidget {
  final List<T> filtersList;
  final T selectedFilter;
  final Function(List<T>) onFilterSelect;
  final bool multiselect;

  /// Creates a list of [Chip]s based on a list of filters.
  ///
  /// Selected filters are returned in the [onFilterSelect]
  ///
  ///[multiselect] indicates wehter or not the user will be able to select
  /// multiple filters
  const FilterChips({
    Key? key,
    required this.filtersList,
    required this.onFilterSelect,
    this.multiselect = false,
    required this.selectedFilter,
  }) : super(key: key);

  @override
  _FilterChipsState createState() => _FilterChipsState<T>();
}

class _FilterChipsState<T> extends State<FilterChips<T>> {
  late final List<T> _selectedFilters;

  @override
  void initState() {
    super.initState();
    _selectedFilters = [widget.selectedFilter];
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: stringToChips(),
        ),
      ),
    );
  }

  List<Widget> stringToChips() {
    return widget.filtersList.map((filter) {
      bool filterIsSelected = _selectedFilters.contains(filter);
      final filterStr = filter.toString();
      return Padding(
        padding: const EdgeInsets.all(5.0),
        child: ChoiceChip(
          label: Text(filter is Enum ? filterStr.split('.')[1] : filterStr),
          selected: filterIsSelected,
          selectedColor: Colors.blue,
          labelStyle: TextStyle(
            color: filterIsSelected ? Colors.white : Colors.black,
          ),
          onSelected: (active) => updateFilters(active, filter),
        ),
      );
    }).toList();
  }

  void updateFilters(bool isActive, T filter) {
    setState(() {
      if (isActive) {
        if (!widget.multiselect) {
          _selectedFilters.removeWhere((element) => element != filter);
        }
        _selectedFilters.add(filter);
      } else {
        _selectedFilters.remove(filter);
        if (_selectedFilters.isEmpty) {
          _selectedFilters.add(filter);
        }
      }
    });

    widget.onFilterSelect(_selectedFilters);
  }
}
