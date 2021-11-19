import 'package:flutter/material.dart';
import 'package:oshin_list/helper/date_time.dart';

class DatePicker extends StatefulWidget {
  const DatePicker({
    Key? key,
    this.initialDate,
    required this.onChanged,
  }) : super(key: key);

  final DateTime? initialDate;
  final Function(DateTime) onChanged;

  @override
  State<DatePicker> createState() => _DatePickerState();
}

class _DatePickerState extends State<DatePicker> {
  DateTime? selectedDate;

  @override
  void initState() {
    super.initState();
    setState(() {
      if (widget.initialDate != null) {
        selectedDate = widget.initialDate;
      }
    });
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate ??  DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(5000),
    );
    if (picked != null) {
      setState(() {
        selectedDate = picked;
        widget.onChanged(picked);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      readOnly: true,
      decoration: InputDecoration(
        border: const UnderlineInputBorder(),
        hintText: selectedDate?.formatedDate ?? 'Select a date',
      ),
      onTap: () => _selectDate(context),
    );
  }
}
