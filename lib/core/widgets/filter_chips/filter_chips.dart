import 'package:flutter/material.dart';

class FilterChips extends StatefulWidget {
  final List<String> filtersList;
  final Function(List<String>) onFilterSelect;

  /// Creates a list of [Chip]s based on a list of filters.
  ///
  /// Selected filters are returned in the [onFilterSelect]
  const FilterChips({
    Key? key,
    required this.filtersList,
    required this.onFilterSelect,
  }) : super(key: key);

  @override
  _FilterChipsState createState() => _FilterChipsState();
}

class _FilterChipsState extends State<FilterChips> {
  final List<String> _selectedFilters = [];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: stringToChips(),
      ),
    );
  }

  List<Widget> stringToChips() {
    return widget.filtersList.map((filter) {
      bool filterIsSelected = _selectedFilters.contains(filter);

      return Padding(
        padding: const EdgeInsets.all(5.0),
        child: ChoiceChip(
          label: Text(filter),
          selected: filterIsSelected,
          selectedColor: Colors.blue,
          labelStyle: TextStyle(
            color: filterIsSelected ? Colors.white : Colors.black,
          ),
          onSelected: (active) {
            setState(() {
              if (active) {
                _selectedFilters.add(filter);
              } else {
                _selectedFilters.remove(filter);
              }
            });

            widget.onFilterSelect(_selectedFilters);
          },
        ),
      );
    }).toList();
  }
}
