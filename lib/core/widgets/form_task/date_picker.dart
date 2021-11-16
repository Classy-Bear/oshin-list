import 'package:flutter/material.dart';
import 'package:oshin_list/helper/task_helper.dart';

class DatePicker extends StatefulWidget {
  const DatePicker({Key? key, this.selectedDate}) : super(key: key);
  final DateTime? selectedDate;

  @override
  State<DatePicker> createState() => _DatePickerState();
}

class _DatePickerState extends State<DatePicker> {
  late final DateTime selectedDate;

  @override
  void initState() {
    super.initState();
    selectedDate = widget.selectedDate ?? DateTime.now();
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2019, 1), // TODO: Porque 2019?
      lastDate: DateTime(2050), // TODO: Porque 2050?
    );
    if (picked != null) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      readOnly: true,
      decoration: InputDecoration(
        border: const UnderlineInputBorder(),
        hintText: selectedDate.formatedDate,
      ),
      onTap: () => _selectDate(context),
    );
  }
}
